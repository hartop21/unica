
/*/{Protheus.doc} UNIA008

@project Importação do Cadastro de Clientes
@description Rotina com o objetivo de realizar a importação do cadastro de clientes, a partir de arquivo csv com layout específico
@author Rafael Rezende
@since 18/05/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*---------------------*
User Function UNIA008()
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
	Local cTitulo       := "Importação do Cadastro de Clientes"
	Local cTexto        := "<font color='red'> Importação do Cadastro de Clientes </font><br> Esta rotina tem como objetivo realizar a importação do Cadastro de clientes do Protheus, a partir de planilha csv fornecida pelo cliente.<br>Selecione a planilha na opção de Parâmetros e confirme a importação."
	Private cPerg       := "UNIA008"
	Private lSchedule 	:= IsBlind()
	Private oTempTable

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
		Processa( { || FImporta() }, "Preparando Importação de clientes, aguarde..." )
	EndIf

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

	oTempTable:Delete()

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
	Local nPA1PESSOA	:= 01
	Local nPA1CGC		:= 02
	Local nPA1TIPO		:= 03
	Local nPA1COD 		:= 04
	Local nPA1LOJA		:= 05
	Local nPA1NOME		:= 06
	Local nPA1NREDUZ	:= 07
	Local nPA1END		:= 08
	Local nPA1COMPLEM	:= 09
	Local nPA1BAIRRO	:= 10
	Local nPA1EST		:= 11
	Local nPA1CEP		:= 12
	Local nPA1REGIAO	:= 13
	Local nPA1DSCREG	:= 14
	Local nPA1CODMUN	:= 15
	Local nPA1MUN		:= 16
	Local nPA1DDD		:= 17
	Local nPA1TEL		:= 18
	Local nPA1PAIS		:= 19
	Local nPA1CONTATO	:= 20
	Local nPA1INSCR		:= 21
	Local nPA1EMAIL		:= 22
	Local nPA1TPESSOA	:= 23
	//Local nPA1CODPAIS	:= 24
	Local nPA1SIMPES	:= 24
	Local nPA1SIMPNAC	:= 25
	Local nPA1CONTRIB	:= 26
	Local nPA1ENTID		:= 27

	//Tamanho dos Campos para a Montagem da Chave de Pesquisa usando PadR
	//Destacado aqui para que o Processamento não fique se repetindo durante o
	//processamento.
	Local nTamCodigo := TamSX3( "A1_COD" ) [01]
	Local nTamLoja   := TamSX3( "A1_LOJA" )[01]

	Private cAliasDest   := "SA1"
	Private cAliasRel    := ""
	Private cArquivo     := ""

	//Define o Layout da Planilha Excel, associando as colunas aos Nomes dos
	//respectivos campos dentro do arquivo SX3 do Protheus.
	Private aCampos		:=	{	{ "A1_PESSOA"	, Nil, Nil } ,;
		{ "A1_CGC"		, Nil, Nil } ,;
		{ "A1_TIPO"		, Nil, Nil } ,;
		{ "A1_COD"		, Nil, Nil } ,;
		{ "A1_LOJA"		, Nil, Nil } ,;
		{ "A1_NOME"		, Nil, Nil } ,;
		{ "A1_NREDUZ"	, Nil, Nil } ,;
		{ "A1_END"		, Nil, Nil } ,;
		{ "A1_COMPLEM"	, Nil, Nil } ,;
		{ "A1_BAIRRO"	, Nil, Nil } ,;
		{ "A1_EST"		, Nil, Nil } ,;
		{ "A1_CEP"		, Nil, Nil } ,;
		{ "A1_REGIAO"	, Nil, Nil } ,;
		{ "A1_DSCREG"	, Nil, Nil } ,;
		{ "A1_COD_MUN"	, Nil, Nil } ,;
		{ "A1_MUN"		, Nil, Nil } ,;
		{ "A1_DDD"		, Nil, Nil } ,;
		{ "A1_TEL"		, Nil, Nil } ,;
		{ "A1_PAIS"		, Nil, Nil } ,;
		{ "A1_CONTATO"	, Nil, Nil } ,;
		{ "A1_INSCR"	, Nil, Nil } ,;
		{ "A1_EMAIL"	, Nil, Nil } ,;
		{ "A1_TPESSOA"	, Nil, Nil } ,;
		{ "A1_SIMPLES"	, Nil, Nil } ,;
		{ "A1_SIMPNAC"	, Nil, Nil } ,;
		{ "A1_CONTRIB"	, Nil, Nil } ,;
		{ "A1_ENTID"	, Nil, Nil }  }
	//                         	{ "A1_CODPAIS"	, Nil, Nil } ,;

	//Define o Vetor contendo Campos que receberão valores defaults, ou seja,
	//valores que não serão alterados.
	Private aComplementos  := { { "A1_MSBLQL" , "1" 	} ,;
		{ "A1_XIMPORT", Date()  }  }

	If Aviso( "Atenção", "Você confirma a execução da Rotina de Importação do cadastro de Clientes?", { "Sim", "Não" } ) == 2
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
	DbSelectArea( cAliasDest ) 	//Cadastro de Clientes
	DbSetOrder( 01 ) 			// A1_FILIAL + A1_COD + A1_LOJA

	//Faz uma Varredura no Arquivo Validando as Informações
	//e ao Final Realiza a Importacao das Informações.
	lImporta   	  	:= .T.
	lEncontrouErro 	:= .F.
	lLayoutInvalido := .F.

	//Cria o Arquivo de Log
	aEstrut :=	{	{ "CODIGO"  , "C", 010, 00 } , ;
		{ "LOJA"	, "C", 004, 00 } , ;
		{ "NOME"	, "C", 060, 00 } , ;
		{ "LINHA"	, "N", 006, 00 } , ;
		{ "MENSAGEM", "C", 160, 00 }  }


	cAliasRel := GetNextAlias()
	oTempTable := FWTemporaryTable():New( cAliasRel )
	oTempTable:SetFields( aEstrut )
	oTempTable:AddIndex("01", {"CODIGO"} )
	oTempTable:Create()

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
		If Left( AllTrim( cLinha ), 02 ) == "A1"
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
	# 	Campo 		Descrição 						Tipo	Tam Máx Classificação	Tabela de Opções
	=================================================================================================================================================================================
	1	A1_PESSOA	Física/Jurídica	 				Char	1		Obrigatório		F= Física, J= Jurídica
	2	A1_CGC		CNPJ/CPF 						Char	14		Obrigatório		CNPJ= 14, CPF= 11
	3	A1_TIPO		Tipo	 						Char	1		Obrigatório 	F= Consumidor Final, L= Produtor Rural, R= Revendedor, S= Solidário, X= Exportação
	4	A1_COD		Código do Cliente				Char	9		Obrigatório
	5	A1_LOJA		Loja do Cliente					Char	4		Obrigatório
	6	A1_NOME		Nome do Cliente					Char	40		Obrigatório
	7	A1_NREDUZ	Nome Fantasia					Char	20		Obrigatório
	8	A1_END		Endereço do Cliente				Char	80		Obrigatório
	9	A1_COMPLEM	Complemento de Endereço			Char	50		Obrigatório
	10	A1_BAIRRO	Bairro do Cliente				Char	40		Obrigatório
	11	A1_EST		UF do Cliente					Char	2		Obrigatório
	12	A1_CEP		CEP								Char	8		Obrigatório
	13	A1_REGIAO	Região do Cliente				Char	3		Opcional
	14	A1_DSCREG	Descrição da Região				Char	15		Opcional
	15	A1_COD_MUN	Código do Município				Char	5		Obrigatório
	16	A1_MUN		Descrição do Município			Char	60		Obrigatório
	17	A1_DDD		DDD do Cliente					Char	3		Obrigatório
	18	A1_TEL		Telefone						Char	15		Obrigatório
	19	A1_PAIS		País do Cliente 				Char	3		Obrigatório		Brasil= 105
	20	A1_CONTATO	Contato							Char	15		Opcional
	21	A1_INSCR	Inscrição Estadual 				Char	18		Obrigatório		Caso não possua colocar ISENTO
	22	A1_EMAIL	E-mail do Cliente				Char	60		Obrigatório
	23	A1_TPESSOA	Tipo Pessoa:					Char	2		Obrigatório		CI= Comércio/Indústria, PF= Pessoa Física, OS= Prestação de Serviço, EP= Empresa Pública
	24	A1_SIMPLES	Optante pelo Simples	 		Char	1		Opcional		1= Sim, 2= Não
	25	A1_SIMPNAC	Optante pelo Simples Nacional	Char	1		Opcional		1= Sim, 2= Não
	26	A1_CONTRIB	Contribuinte 					Char	1		Opcional		1= Sim, 2= Não
	27	A1_ENTID	Tipo de Entidade 				Char	2		Opcional		00= PJ de Direito Privado

//	24	A1_CODPAIS	País Bacen						Char	5		Obrigatório		Brasil= 01058

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

			If AllTrim( aConteudo[nPA1EST] ) == ""
				aConteudo[nPA1EST] := "RJ"
			EndIf

			//Realiza a tratativa para Código do Município
			If AllTrim( aConteudo[nPA1CODMUN] ) == ""
				cAuxCodMun 				:= U_UNIRetMunicipio( Upper( TrataTexto( AllTrim( aConteudo[nPA1MUN] ) ) ), Upper( TrataTexto( AllTrim( aConteudo[nPA1EST] ) ) ) )
				aConteudo[nPA1CODMUN] 	:= cAuxCodMun
				If AllTrim( cAuxCodMun ) == ""
					aConteudo[nPA1CODMUN] 	:= "04557"
					aConteudo[nPA1MUN] 		:= "RIO DE JANEIRO"
				EndIf
			EndIf
			aConteudo[nPA1LOJA] 	 	:= "0001"

			If AllTrim( aConteudo[nPA1INSCR] ) == ""
				aConteudo[nPA1INSCR] 	:= "ISENTO"
			Else
				aConteudo[nPA1INSCR] 	:= Replace( Replace( Replace( Replace( Replace( Replace( aConteudo[nPA1INSCR], " ", "" ), "-", "" ), "/", "" ), "\", "" ), ".", "" ), '"', '' )
				If !IE( aConteudo[nPA1INSCR], aConteudo[nPA1EST], .F., .F. )
					aConteudo[nPA1INSCR] := "ISENTO"
				EndIf
			EndIf

			aConteudo[nPA1TIPO] 	 	:= "F"
			aConteudo[nPA1SIMPNAC]	 	:= "2"
			aConteudo[nPA1CONTRIB]		:= "2"
			aConteudo[nPA1ENTID]		:= "00"
			If AllTrim( aConteudo[nPA1DDD] ) == ""
				aConteudo[nPA1DDD] := "021"
			EndIf
			If AllTrim( aConteudo[nPA1EMAIL] ) == ""
				aConteudo[nPA1EMAIL] := "unica@unica.com.br"
			EndIf

			If aCampos[nJ][nEhObrigatorio]

				Do Case
					Case aCampos[nJ][02] == "D"
						lEmBranco := AllTrim( DtoS( CtoD( aConteudo[nJ] ) ) ) == ""
					Case aCampos[nJ][02] == "N"
						lEmBranco := Val( Replace( Replace( aConteudo[nJ], ".", "" ), ",", "." ) ) == 0
					OtherWise
						lEmBranco := AllTrim( aConteudo[nJ] ) == ""
				End Case

				If lEmBranco

					lImporta := .F.
					cMsg := "O " + AllTrim( AvSX3( aCampos[nJ][01], 05 ) ) + " é Obrigatório e não está preenchido."
					Exit

				EndIf

			EndIf

		Next nJ

		// Valida o CNPJ / CPF
		If lImporta
			If !CGC ( AllTrim( aConteudo[nPA1CGC] ),, .F. )
				cMsg := "O CPF / CNPJ está inconsistente [ " + AllTrim( aConteudo[nPA1CGC] ) + " ]."
				lImporta := .F.
			EndIf
		EndIf

		//Valida o IE
		/*
	If lImporta

		If !IE( aConteudo[nPA1INSCR], aConteudo[nPA1EST], .F., .F. )
			//cMsg := "A Inscrição Estadual está inconsistente [ " + AllTrim( aConteudo[nPA1INSCR] ) + " ] - UF [ " + AllTrim( aConteudo[nPA1EST] ) + " ]. Linha " + StrZero( nLinha, 05 ) + "."
			//lImporta := .F.
			aConteudo[nPA1INSCR] := "ISENTO"
		EndIf

	EndIf
		*/

		If !lImporta

			//Cria Linha para o Relatório Documentando o que aconteceu
			DbSelectArea( cAliasRel )
			RecLock( cAliasRel, .T. )

			If lLayoutInvalido
				( cAliasRel )->CODIGO    := ""
				( cAliasRel )->LOJA      := ""
				( cAliasRel )->NOME      := ""
			Else
				( cAliasRel )->CODIGO    := aConteudo[nPA1COD]
				( cAliasRel )->LOJA      := aConteudo[nPA1LOJA]
				( cAliasRel )->NOME      := aConteudo[nPA1NOME]
			EndIf
			( cAliasRel )->LINHA     := nLinha
			( cAliasRel )->MENSAGEM  := cMsg

			( cAliasRel )->( MsUnLock() )

			lEncontrouErro := .T.

		EndIf

		//Alimenta o Vetor com os Produtos da Planilha e Pula de Linha no Arquivo Texto
		If !lLayoutInvalido
			aAdd( aClientes, PadR( aConteudo[nPA1COD], TamSX3( "A1_COD" )[01] ) + AllTrim( aConteudo[nPA1LOJA] ) )
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

			If Left( cLinha, 02 ) == "A1"
				FT_FSKIP()
				Loop
			EndIf

			//Distribui os Campos da Planilha para um Vetor, Pois no Arquivo Texto
			//os Campos estao separados por ponto-e-virgula.
			aConteudo := Separa( cLinha, ";", .T. )

			IncProc( "Importando Cadastro Clientes " + Alltrim( aConteudo[01] ) )

			If AllTrim( aConteudo[nPA1EST] ) == ""
				aConteudo[nPA1EST] := "RJ"
			EndIf

			//Realiza a tratativa para Código do Município
			If AllTrim( aConteudo[nPA1CODMUN] ) == ""
				cAuxCodMun 				:= U_UNIRetMunicipio( Upper( TrataTexto( AllTrim( aConteudo[nPA1MUN] ) ) ), Upper( TrataTexto( AllTrim( aConteudo[nPA1EST] ) ) ) )
				aConteudo[nPA1CODMUN] 	:= cAuxCodMun
				If AllTrim( cAuxCodMun ) == ""
					aConteudo[nPA1CODMUN] 	:= "04557"
					aConteudo[nPA1MUN] 		:= "RIO DE JANEIRO"
				EndIf
			EndIf
			aConteudo[nPA1LOJA] 		:= "0001"

			If AllTrim( aConteudo[nPA1INSCR] ) == ""
				aConteudo[nPA1INSCR] 	:= "ISENTO"
			Else
				aConteudo[nPA1INSCR] 	:= Replace( Replace( Replace( Replace( Replace( Replace( aConteudo[nPA1INSCR], " ", "" ), "-", "" ), "/", "" ), "\", "" ), ".", "" ), '"', '' )
				If !IE( aConteudo[nPA1INSCR], aConteudo[nPA1EST], .F., .F. )
					aConteudo[nPA1INSCR] := "ISENTO"
				EndIf
			EndIf

			aConteudo[nPA1TIPO] 	 	:= "F"
			aConteudo[nPA1SIMPNAC]	 	:= "2"
			aConteudo[nPA1CONTRIB]		:= "2"
			aConteudo[nPA1ENTID]		:= "00"
			aConteudo[nPA1COD]			:= PadL( AllTrim( aConteudo[nPA1COD] ), nTamCodigo, "0" )
			If AllTrim( aConteudo[nPA1DDD] ) == ""
				aConteudo[nPA1DDD] := "021"
			EndIf
			If AllTrim( aConteudo[nPA1EMAIL] ) == ""
				aConteudo[nPA1EMAIL] := "unica@unica.com.br"
			EndIf

			//Monta o Array para o ExecAuto
			aDadosImP := {}
			aAdd( aDadosImp, { "A1_FILIAL"	, XFilial( "SA1" )	 						  					, Nil } )
			aAdd( aDadosImp, { "A1_PESSOA"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1PESSOA] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_CGC"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1CGC] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_TIPO"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1TIPO] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_COD"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1COD] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_LOJA"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1LOJA] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_NOME"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1NOME]	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_NREDUZ"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1NREDUZ] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_END"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1END] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_COMPLEM"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1COMPLEM]) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_BAIRRO"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1BAIRRO] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_EST"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1EST] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_CEP"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1CEP] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_REGIAO"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1REGIAO] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_DSCREG"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1DSCREG] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_COD_MUN"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1CODMUN] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_MUN"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1MUN] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_DDD"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1DDD] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_TEL"		, Upper( TrataTexto( AllTrim( aConteudo[nPA1TEL] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_PAIS"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1PAIS] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_CONTATO"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1CONTATO]) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_INSCR"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1INSCR] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_EMAIL"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1EMAIL] 	) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_TPESSOA"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1TPESSOA]) ) )		, Nil } )
			//		aAdd( aDadosImp, { "A1_CODPAIS"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1CODPAIS]) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_SIMPLES"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1SIMPES] ) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_SIMPNAC"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1SIMPNAC]) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_CONTRIB"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1CONTRIB]) ) )		, Nil } )
			aAdd( aDadosImp, { "A1_ENTID"	, Upper( TrataTexto( AllTrim( aConteudo[nPA1ENTID] 	) ) )		, Nil } )

			//Realiza a Gravação dos Defaults, ou seja, dos valores fixos do Registro
			aEval( aComplementos, { |x| aAdd( aDadosImp, { x[01], x[02], Nil } ) } )

			// Realiza a Inclusão através de MsExecAuto
			lMsErroAuto := .F.
			MsExecAuto( { | x, y | MATA030( x, y ) }, aDadosImp, 03 )
			If lMsErroAuto
				MostraErro()
			EndIf

			FT_FSKIP()
		EndDo

		Aviso( "Atencao", "Importação do Cadastro de Clientes concluída.", { "Ok" } )

	Else

		If Aviso( "Atenção", "Foram encontradas inconsistências na Planilha que está tentando importar. Deseja visualizsar o relatório de Log das Inconsistências?", { "Sim", "Não" } ) == 1
			RelLogIncons()
		EndIf

	EndIf

	//Fecha o Arquivo Texto
	FT_FUSE()

	( cAliasRel )->( DbCloseArea() )
	If File( cAliasRel + "." + Replace( GetDbExtension(), ".", "" ) )
		FErase( cAliasRel + "." + Replace( GetDbExtension(), ".", "" ) )
	EndIf

Return




Static Function RelLogIncons()

	Local cDesc1       := "Este programa tem como objetivo imprimir relatório "
	Local cDesc2       := "de acordo com os parametros informados pelo usuario."
	Local cDesc3       := "Log de Inconsistências na Importação do Cadastro de Clientes"
	Local cPict        := ""
	Local titulo       := "Log de Inconsistências na Importação do Cadastro de Clientes"
	Local nLin         := 80
	//"0        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
	//"|         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |
	//"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	Local Cabec1       	:= " Código  Loja    Nome                                Linha    Mensagem de Erro"
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
	Local nPosCliente	 := 01
	Local nPosLoja       := 13
	Local nPosNome       := 21
	Local nPosLinha      := 57
	Local nPosMensagem   := 67

	//"0        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
	//"|         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |
	//"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//Local Cabec1        := " Código  Loja    Nome                                Linha    Mensagem de Erro"

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

		@ nLin, nPosCliente 	  PSay ( cAliasRel )->CODIGO
		@ nLin, nPosLoja       PSay ( cAliasRel )->LOJA
		@ nLin, nPosNome       PSay ( cAliasRel )->NOME
		@ nLin, nPosLinha      PSay StrZero( ( cAliasRel )->LINHA, 06 )
		@ nLin, nPosMensagem   PSay Alltrim( ( cAliasRel )->MENSAGEM )

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
	Local aErradas := { "Á", "á", "Ã", "ã", "À", "à", "Ä", "ä", "Â", "â", ;
		"É", "é", "Ê", "ê", "È", "è", "Ë", "ë", ;
		"Í", "í", "Ì", "ì", "Î", "î", "Ï", "ï", ;
		"Ó", "ó", "Ò", "ò", "Õ", "õ", "Ô", "ô", "Ö", "ö", ;
		"Ú", "ú", "Ù", "ù", "Û", "û", "Ü", "ü", ;
		"Ç", "ç", "°", "ª" ,"¿åE", "¿C","¶", "'"  }

	Local aCertas  := { "A", "a", "A", "a", "A", "a", "A", "a", "A", "a", ;
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
