
/*/{Protheus.doc} UNIA014

@project Carga de Custo de Produtos ( Indicadores )
@description Rotina com o objetivo de realizar a carga inicial do custo dos produtos ( indicadores ) na tabela SBZ
@author Rafael Rezende
@since 15/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*---------------------*
User Function UNIA014()
	*---------------------*
	Local oFontProc     := Nil
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cTitulo       := "Carga de Custo de Produtos ( Indicadores )"
	Local cTexto        := "<font color='red'> Carga de Custo de Produtos ( Indicadores ) </font><br> Esta rotina tem como objetivo realizar a carga inicial do custo do Produto no Cadastro de Indicadores do Protheus, para todas as filiais, conforme definido em parâmetro.<br>Selecione os Parâmetros e confirme a carga."
	Private cPerg       := "UNIA014X"
	Private lSchedule 	:= IsBlind()
	Private oTempTable := Nil

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	//Gerando Perguntas do Parâmetro
	MsgRun( cTitulo, "Aguarde, gerando as perguntas de parâmetros", { || FAjustaSX1( cPerg ) } )
	Pergunte( cPerg, .F. )

	oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
	oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
	oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
	oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
	oSayTexto := TSay():New( 016, 014, { || cTexto }   , oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
	oBtnConfi := TButton():New( 092, 006, "&Importar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oDlgProc:Activate( ,,,.T. )

	If lConfirmou
		Processa( { || FImporta() }, "Preparando Importação dos Custos, aguarde..." )
	EndIf

	oTempTable:Delete()

Return


Static function FVldParametros()

	Local lRetA := .T.

	//Verifica se a Planilha foi Selecionada no Botao de Parametros
	If AllTrim( MV_PAR01 ) == ""
		Aviso( "Atenção", "Selecione a Planilha ( csv ) que será importada através do botão de Parâmetros!", { "Voltar" } )
		lRetA := .F.
	End If

	//Verifica se a Planilha existe
	If lRetA .And. !File( MV_PAR01 )
		Aviso( "Atenção", "A Planilha informada no Parâmetro não foi encontrada. " + CRLF + "Arquivo: " + AllTrim( MV_PAR01 ), { "Voltar" } )
		lRetA := .F.
	End If

Return lRetA


Static Function FImporta()

	Local aArea          := GetArea()
	Local cAlias         := GetNextAlias()
	Local aClientes  	 := {}
	Local aEstrut        := {}
	Local aConteudo      := {}
	Local aDadosImp      := {}
	Local cMsg           := ""
	Local cLinha         := ""
	Local cQuery         := ""
	Local lImporta       := .T.
	Local lEmBranco      := .F.
	Local lEncontrouErro := .F.
	Local nLinha         := 0
	Local nJ             := 0
	Local nK             := 0

	//Índice da coluna da Planilha Excel em que o Campo se encontra.
	Local nBZFILIAL		:= 01
	Local nBZCOD		:= 02
	Local nBZCUSTD 		:= 03
	//Local nBZLOCPAD		:= 03

	//Tamanho dos Campos para a Montagem da Chave de Pesquisa usando PadR
	//Destacado aqui para que o Processamento não fique se repetindo durante o
	//processamento.
	Local nTamCodigo := TamSX3( "BZ_COD"    )[01]
	Local nTamLocPad := TamSX3( "BZ_LOCPAD" )[01]

	Private cAliasDest   := "SBZ"
	Private cAliasRel    := ""
	Private cArquivo     := ""

	//Define o Layout da Planilha Excel, associando as colunas aos Nomes dos
	//respectivos campos dentro do arquivo SX3 do Protheus.
	Private aCampos		:=	{	{ "BZ_FILIAL"	, Nil, Nil } ,;
		{ "BZ_COD"		, Nil, Nil } ,;
		{ "BZ_CUSTD"	, Nil, Nil }  }

	//Define o Vetor contendo Campos que receberão valores defaults, ou seja,
	//valores que não serão alterados.
	//Private aComplementos  := { { "BZ_DTINCLU", Date() } }

	If Aviso( "Atenção", "Você confirma a execução da Rotina de Carga de Custos de Produtos?", { "Sim", "Não" } ) == 2
		Return
	End If

	//Atualiza na Matriz aCampos a Obrigatoriedade de Preenchimento dos Campos
	DbSelectArea( "SX3" )
	For nK := 01 To Len( aCampos )
		aCampos[nK][02] := AvSX3( aCampos[nK][01], 02 ) // Pega o Tipo do Campo
		aCampos[nK][03] := X3Obrigat( aCampos[nK][01] ) // Obrigatoriedade
	Next nK

	//Pega o Campo de Parâmetro que está com o Arquivo da Planilha selecionada pelo usuário
	cArquivo       := MV_PAR01

	//Pontera sobre os Indices que serao utilizados pela validacao
	DbSelectArea( "SBZ" ) 	//Cadastro de Clientes
	DbSetOrder( 01 ) 		// BZ_FILIAL + BZ_COD

	//Faz uma Varredura no Arquivo Validando as Informações
	//e ao Final Realiza a Importacao das Informações.
	lImporta   	  	:= .T.
	lEncontrouErro 	:= .F.
	lLayoutInvalido := .F.

	//Cria o Arquivo de Log
	aEstrut :=	{	{ "FILIAL"	, "C",	004, 00 } , ;
		{ "CODIGO"  , "C", 	015, 00 } , ;
		{ "LOCPAD"	, "C", 	002, 00 } , ;
		{ "CUSTO"	, "N", 	014, 02 } , ;
		{ "LINHA"	, "N", 	006, 00 } , ;
		{ "MENSAGEM", "C", 	160, 00 }   }

	cAliasRel := GetNextAlias()

	oTempTable := FWTemporaryTable():New( cAliasRel )
	oTempTable:SetFields( aEstrut )
	oTempTable:AddIndex("01", {"FILIAL","CODIGO"} )

	//Abre o Arquivo Texto
	FT_FUSE( cArquivo )

	//Vai para o Inicio do Arquivo e Define o numero de Linhas para a Barra de Processamento.
	nLinha       := 0
	FT_FGOTOP()
	ProcRegua( FT_FLASTREC() )
	Do While !FT_FEOF()

		//Faz a Leitura da Linha do Arquivo e atribui a Variavel cLinha
		cLinha := AllTrim( FT_FREADLN() )
		nLinha++
		cMsg   := ""

		IncProc( "Validando registro " + StrZero( nLinha, 05 ) + " da Planilha, aguarde." )

		//Se a Linha estiver em branco, vai para a proxima Linha do Arquivo.
		If AllTrim( cLinha ) == ""
			FT_FSKIP()
			Loop
		EndIf

		//Tira a coluna de Cabeçalhos
		If Left( AllTrim( cLinha ), 03 ) == "FIL"
			FT_FSKIP()
			Loop
		EndIf

		//Distribui os Campos da Planilha para um Vetor, Pois no Arquivo Texto
		//os Campos estao separados por ponto-e-virgula.
		aConteudo := Separa( cLinha, ";", .T. )

		/*
	--------------------------------
	LAYOUT DO ARQUIVO DE IMPORTAÇÃO:
	--------------------------------
	# 	Campo 		Descrição 						Tipo		Tam Máx Decimal	Classificação	Tabela de Opções
	=================================================================================================================================================================================
	1	BZ_FILIAL	Filial			 				Char		04				Obrigatório
	2	BZ_COD		Código 							Char		15				Obrigatório
	3	BZ_CUSTO	Custo	 						Numerico	14 		02		Opcional
		*/
		cMsg 			:= ""
		lLayoutInvalido := .F.
		lImporta 		:= .T.

		//Verifica o Preenchimento dos Campos Obrigatorios
		lEmBranco 		:= .F.
		nEhObrigatorio 	:= 03
		For nJ := 01 To Len( aCampos )

			If Len( aConteudo ) < Len( aCampos ) //28

				lImporta := .F.
				lLayoutInvalido := .T.
				cMsg 	 := "Layout inválido para a Linha ( Apenas " + StrZero( Len( aConteudo ), 02 ) + " campos no layout )."
				Exit

			EndIf

			If aCampos[nJ][nEhObrigatorio]

				Do Case
					Case aCampos[nJ][02] == "D"
						lEmBranco := AllTrim( DtoS( CtoD( aConteudo[nJ] ) ) ) == ""
					Case aCampos[nJ][02] == "N"
						lEmBranco := Val( Replace( Replace( aConteudo[nJ], ".", "" ), ",", "." ) ) == 0
					OtherWise
						lEmBranco := AllTrim( aConteudo[nJ] ) == ""
				EndCase

				If lEmBranco

					lImporta := .F.
					cMsg := "O " + AllTrim( AvSX3( aCampos[nJ][01], 05 ) ) + " é Obrigatório e não está preenchido."
					Exit

				EndIf

			EndIf

		Next nJ

		If lImporta

			DbSelectArea( "SB1" )
			DbSetOrder( 01 )
			Seek XFilial( "SB1" ) + PadR( aConteudo[nBZCOD], nTamCodigo )
			cAuxLocal := If( AllTrim( aConteudo[nBZCOD] ) == "", SB1->B1_LOCPAD, "01" )
			If !FExisteArmazem( aConteudo[nBZFILIAL], cAuxLocal )
				cMsg := "A Filial [ " + aConteudo[nBZFILIAL] + " ] não possui Armazem."
				lImporta := .F.
			EndIf

		EndIf

		If !lImporta

			//Cria Linha para o Relatório Documentando o que aconteceu
			DbSelectArea( cAliasRel )
			RecLock( cAliasRel, .T. )

			If lLayoutInvalido
				( cAliasRel )->FILIAL   := ""
				( cAliasRel )->CODIGO   := ""
				( cAliasRel )->LOCPAD   := ""
				( cAliasRel )->CUSTO    := 0.00
			Else
				( cAliasRel )->FILIAL   := aConteudo[nBZFILIAL]
				( cAliasRel )->CODIGO   := aConteudo[nBZCOD]
				( cAliasRel )->LOCPAD   := cAuxLocal
				( cAliasRel )->CUSTO    := Val( Replace( Replace( aConteudo[nBZCUSTD], ".", "" ), ",", "." ) )
			EndIf
			( cAliasRel )->LINHA     := nLinha
			( cAliasRel )->MENSAGEM  := cMsg

			( cAliasRel )->( MsUnLock() )

			lEncontrouErro := .T.

		EndIf

		FT_FSKIP()
	EndDo  //Fim do Primeiro Loop

	If !lEncontrouErro

		//Vai para o Inicio do Arquivo e Define o numero de Linhas para a Barra de Processamento.
		FT_FGOTOP()
		ProcRegua( FT_FLASTREC() )
		FT_FGOTOP()
		Do While !FT_FEOF()

			//Faz a Leitura da Linha do Arquivo e atribui a Variavel cLinha
			cLinha := AllTRim( FT_FREADLN() )
			cMsg   := ""

			//Se a Linha estiver em branco, vai para a proxima Linha do Arquivo.
			If AllTrim( cLinha ) == ""
				FT_FSKIP()
				Loop
			EndIf

			If Left( cLinha, 03 ) == "FIL"
				FT_FSKIP()
				Loop
			EndIf

			//Distribui os Campos da Planilha para um Vetor, Pois no Arquivo Texto
			//os Campos estao separados por ponto-e-virgula.
			aConteudo := Separa( cLinha, ";", .T. )

			IncProc( "Importando Custo dos Produtos..." )

			//Monta o Array para o ExecAuto
			cAuxFilial 	:= Upper( TrataTexto( AllTrim( aConteudo[nBZFILIAL] ) ) )
			cAuxProduto := PadR( Upper( TrataTexto( AllTrim( aConteudo[nBZCOD] 	) ) ), nTamCodigo )
			nAuxCusto := Val( Replace( Replace( aConteudo[nBZCUSTD], ".", "" ), ",", "." ) )

			DbSelectArea( "SB1" )
			DbSetOrder( 01 )
			Seek XFilial( "SB1" ) + cAuxProduto
			cAuxLocal := If( AllTrim( aConteudo[nBZCOD] ) == "", SB1->B1_LOCPAD, "01" )

			DbSelectArea( "SBZ" )
			DbSetOrder( 01 ) // BZ_FILIAL + BZ_COD
			Seek cAuxFilial + cAuxProduto
			If Found()
				RecLock( "SBZ", .F. )
			Else
				RecLock( "SBZ", .T. )
				SBZ->BZ_FILIAL  := cAuxFilial
				SBZ->BZ_COD 	:= cAuxProduto
			EndIf

			SBZ->BZ_LOCPAD 	:= cAuxLocal
			SBZ->BZ_CUSTD 	:= nAuxCusto
			SBZ->BZ_DTINCLU	:= Date()

			SBZ->( MsUnLock() )

			FT_FSKIP()
		EndDo

		//Replicando as Informações para as Outras Filiais
		cAuxFilOrig := "0201"
		aAuxFiliais := { "0102", "0203", "0204", "0205", "0206", "0207" }
		cAliasQry   := GetNextAlias()

		cQuery := "	  SELECT BZ_COD, BZ_LOCPAD, BZ_CUSTD, BZ_DTINCLU "
		cQuery += " 	FROM " + RetSQLName( "SBZ" )
		cQuery += "	   WHERE D_E_L_E_T_ = ' ' "
		cQuery += "      AND BZ_FILIAL  = '" + cAuxFilOrig + "' "
		cQuery += " ORDER BY BZ_FILIAL, BZ_COD, BZ_LOCPAD
		If Select( cAliasQry ) > 0
			( cAliasQry )->( DbCloseArea() )
		EndIf
		TcQuery cQuery Alias ( cAliasQry ) New
		If !( cAliasQry )->( Eof() )

			// Pontera no Índice
			DbSelectArea( "SBZ" )
			DbSetOrder( 01 ) // BZ_FILIAL + BZ_COD

			ProcRegua( Len( aAuxFiliais ) )
			For nF := 01 To Len( aAuxFiliais )

				IncProc( "Replicando custos para Filial [" + aAuxFiliais[nF] + "], aguarde..." )

				DbSelectArea( cAliasQry )
				( cAliasQry )->( DbGoTop() )
				Do While !( cAliasQry )->( Eof() )

					DbSelectArea( "SBZ" )
					Seek aAuxFiliais[nF] + ( cAliasQry )->BZ_COD
					If Found()
						RecLock( "SBZ", .F. )
					Else
						RecLock( "SBZ", .T. )
						SBZ->BZ_FILIAL  := aAuxFiliais[nF]
						SBZ->BZ_COD 	:= ( cAliasQry )->BZ_COD
					EndIf

					SBZ->BZ_LOCPAD 	:= ( cAliasQry )->BZ_LOCPAD
					SBZ->BZ_CUSTD 	:= ( cAliasQry )->BZ_CUSTD
					SBZ->BZ_DTINCLU	:= Date()

					SBZ->( MsUnLock() )
					( cAliasQry )->( DbSkip() )
				EndDo

			Next nF
			( cAliasQry )->( DbCloseArea() )

		EndIf

		Aviso( "Atenção", "Importação da Carga de Custos dos Produtos concluída.", { "Ok" } )

	Else

		If Aviso( "Atenção", "Foram encontradas inconsistências na Planilha que está tentando importar. Deseja visualizsar o relatório de Log das Inconsistências?", { "Sim", "Não" } ) == 1
			FRelLogIncons()
		EndIf

	EndIf

	//Fecha o Arquivo Texto
	FT_FUSE()

	( cAliasRel )->( DbCloseArea() )
	If File( cAliasRel + "." + Replace( GetDbExtension(), ".", "" ) )
		FErase( cAliasRel + "." + Replace( GetDbExtension(), ".", "" ) )
	EndIf

Return




*-----------------------------*
Static Function FRelLogIncons()
	*-----------------------------*
	Local cDesc1       := "Este programa tem como objetivo imprimir relatório "
	Local cDesc2       := "de acordo com os parametros informados pelo usuario."
	Local cDesc3       := "Log de Inconsistências na Importação da Carga de Custo dos Produtos"
	Local cPict        := ""
	Local titulo       := "Log de Inconsistências na Importação da Carga de Custo dos Produtos"
	Local nLin         := 80
	//"0        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
	//"|         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |
	//"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	Local Cabec1       	:= " Filial  Codigo             Local              Custo  Linha    Mensagem de Erro"
	Local Cabec2       	:= ""
	Local Imprime      	:= .T.
	Local aOrd 		 	:= {}
	Private lEnd       	:= .F.
	Private lAbortPrint	:= .F.
	Private CbTxt      	:= ""
	Private Limite     	:= 220
	Private Tamanho    	:= "G"
	Private NomeProg   	:= cPerg
	Private nTipo      	:= 15
	Private aReturn    	:= { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey   	:= 0
	Private CbTxt      	:= Space( 10 )
	Private CbCont     	:= 00
	Private ContFl     	:= 01
	Private M_Pag      	:= 01
	Private WnRel      	:= cPerg
	Private cString    	:= cAliasRel

	// Monta a interface padrao com o usuario...
	WnRel := SetPrint( cString, NomeProg, "", @titulo, cDesc1, cDesc2, cDesc3, .F., aOrd, .F., Tamanho,, .F. )

	If nLastKey == 27
		Return
	EndIf

	SetDefault( aReturn, cString )

	If nLastKey == 27
		Return
	EndIf

	nTipo := If( aReturn[4] == 01, 15, 18 )

	RptStatus( { || FGeraRel( Cabec1, Cabec2, Titulo, nLin ) }, Titulo )

Return


*------------------------------------------------------*
Static Function FGeraRel( Cabec1, Cabec2, Titulo, nLin )
	*------------------------------------------------------*
	Local nOrdem
	Local nPosFilial	 := 01
	Local nPosCodigo     := 09
	Local nPosLocal      := 28
	Local nPosCusto      := 47-17
	Local nPosLinha      := 54
	Local nPosMensagem   := 60
	//						   "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//						   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	//Local Cabec1       	:= " Filial  Codigo             Local              Custo  Linha Mensagem de Erro"

	DbSelectArea( cAliasRel )
	( cAliasRel )->( DbGoTop() )
	SetRegua( ( cAliasRel )->( RecCount() ) )
	( cAliasRel )->( DbGoTop() )

	Do While !( cAliasRel )->( Eof() )

		//Verifica o cancelamento pelo usuario...
		If lAbortPrint
			@ nLin, 00 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf

		//Impressao do cabecalho do relatorio. . .
		If nLin > 55 // Salto de Pagina. Neste caso o formulario tem 55 linhas...
			Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo )
			nLin := 08
		EndIf

		@ nLin, nPosFilial 	PSay ( cAliasRel )->FILIAL
		@ nLin, nPosCodigo 	PSay ( cAliasRel )->CODIGO
		@ nLin, nPosLocal    PSay ( cAliasRel )->LOCPAD
		@ nLin, nPosCusto    PSay TransForm( ( cAliasRel )->CUSTO, "@E 99,999,999,999.99" )
		@ nLin, nPosLinha    PSay StrZero( ( cAliasRel )->LINHA, 06 )
		@ nLin, nPosMensagem PSay Alltrim( ( cAliasRel )->MENSAGEM )

		nLin := nLin + 01

		( cAliasRel )->( DbSkip() )
	EndDo

	//Finaliza a execucao do relatorio...
	Set Device To Screen

	//Se impressao em disco, chama o gerenciador de impressao...
	If aReturn[05] == 01
		DbCommitAll()
		Set Printer To
		OurSpool( WnRel )
	EndIf

	Ms_Flush()

Return


Static Function TrataTexto( cTexto )

	Local nJ 	  := 0
	Local cRetorno := ""
	Local aErradas := {  "Á", "á", "Ã", "ã", "À", "à", "Ä", "ä", "Â", "â", ;
		"É", "é", "Ê", "ê", "È", "è", "Ë", "ë", ;
		"Í", "í", "Ì", "ì", "Î", "î", "Ï", "ï", ;
		"Ó", "ó", "Ò", "ò", "Õ", "õ", "Ô", "ô", "Ö", "ö", ;
		"Ú", "ú", "Ù", "ù", "Û", "û", "Ü", "ü", ;
		"Ç", "ç", "°", "ª" ,"¿åE", "¿C","¶", "'"  }

	Local aCertas  := {  "A", "a", "A", "a", "A", "a", "A", "a", "A", "a", ;
		"E", "e", "E", "e", "E", "e", "E", "e", ;
		"I", "i", "I", "i", "I", "i", "I", "i", ;
		"O", "o", "O", "o", "O", "o", "O", "o", "O", "o", ;
		"U", "u", "U", "u", "U", "u", "U", "u", ;
		"C", "c", ".", "." , "OE", "CA","A", "''" }

	cRetorno := cTexto
	For nJ := 01 To Len( aErradas )
		cRetorno := Replace( cRetorno, aErradas[nJ], aCertas[nJ] )
	Next nJ


Return FwNoAccent( Alltrim( cRetorno ) )

*---------------------------------------------------------*
Static Function FExisteArmazem( cParamFilial, cParamLocal )
	*---------------------------------------------------------*
	Local aAreaAnt  := GetArea()
	Local lRetA		:= .T.

	cParamFilial := PadL( AllTrim( cParamFilial ), 04, "0" )

	DbSelectArea( "NNR" )
	DbSetOrder( 01 ) // NNR_FILIAL + NNR_CODIGO
	Seek cParamFilial + AllTrim( cParamLocal )
	If !Found()
		Aviso( "Atenção", "O Armazem [ " + AllTrim( cParamLocal ) + " ], não existe para a Filial [ " + AllTrim( cParamFilial ) + " ].", { "Continuar" } )
		lRetA := .F.
	EndIf
	RestArea( aAreaAnt )

Return lRetA
