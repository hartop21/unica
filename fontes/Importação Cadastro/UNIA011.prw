
/*/{Protheus.doc} UNIA011

@project Importação do Cadastro de Produtos
@description Rotina com o objetivo de realizar a importação do cadastro de Produtos, a partir de arquivo csv com layout específico
@author Rafael Rezende
@since 23/05/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*---------------------*
User Function UNIA011()
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
	Local cTitulo       := "Importação do Cadastro de Produtos"
	Local cTexto        := "<font color='red'> Importação do Cadastro de Produtos </font><br> Esta rotina tem como objetivo realizar a importação do Cadastro de Produtos do Protheus, a partir de planilha csv fornecida pelo cliente.<br>Selecione a planilha na opção de Parâmetros e confirme a importação."
	Private cPerg       := "UNIA011"
	Private lSchedule 	:= IsBlind()
	Private oTempTable := Nil

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

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
		Processa( { || FImporta() }, "Preparando Importação de Produtos, aguarde..." )
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
	Local aProdutos  	 := {}
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
	Local nPB1GRUPO		:= 01
	Local nPB1COD		:= 02
	Local nPB1TIPO		:= 03
	Local nPB1DESC		:= 04
	Local nPB1XMARCA	:= 05
	Local nPB1LOCPAD	:= 06
	Local nPB1UM		:= 07
	Local nPB1SEGUM		:= 08
	Local nPB1CONV		:= 09
	Local nPB1TIPCONV	:= 10
	Local nPB1ALTER		:= 11
	Local nPB1PESBRU	:= 12
	Local nPB1PESO		:= 13
	Local nPB1RASTRO	:= 14
	Local nPB1PERINV	:= 15
	Local nPB1LOCALIZ	:= 16
	Local nPB1GRUPCOM	:= 17
	Local nPB1POSIPI	:= 18
	Local nPB1ORIGEM	:= 19
	Local nPB1CONTA		:= 20
	Local nPB1CC		:= 21
	Local nPB1GRTRIB	:= 22
	Local nPB1IRRF		:= 23
	Local nPB1IPI		:= 24
	Local nPB1ALIQISS	:= 25
	Local nPB1INSS		:= 26
	Local nPB1PIS		:= 27
	Local nPB1PPIS		:= 28
	Local nPB1COFINS	:= 29
	Local nPB1PCOFINS	:= 30
	Local nPB1CSLL		:= 31
	Local nPB1PCSLL		:= 32
	Local nPB1RETOPER	:= 33
	Local nPB1REFBAS	:= 34
	Local nPB1VM_I		:= 35
	Local nPB1VM_GI		:= 36
	Local nPB1VM_P		:= 37
	Local nPB1FABRIC	:= 38
	Local nPB1XPAISOR	:= 39
	Local nPB1XREGANV	:= 40
	Local nPB1CATEGOR	:= 41
	Local nPB1LINHA		:= 42
	Local nPB1PROC		:= 43
	Local nPB1LOJPROC	:= 44
	Local nPB1XFLUIG	:= 45
	Local nPB1VOLTAGE	:= 46
	Local nPB1CODBAR	:= 47
	//Local nPB1XALERTA	:= 48
	//Local nPB1XOBSERV	:= 49
	Local nPA5FORNECE	:= 48
	Local nPA5LOJA		:= 49
	Local nPA5CODPRF	:= 50
	Local nPB5XVOLUME 	:= 51
	Local nPB5LARG   	:= 52
	Local nPB5COMPR  	:= 53
	Local nPB5ALTURA 	:= 54

	//Tamanho dos Campos para a Montagem da Chave de Pesquisa usando PadR
	//Destacado aqui para que o Processamento não fique se repetindo durante o
	//processamento.
	Local nTamCodigo 	:= TamSX3( "B1_COD"    ) [01]
	Local nTamB1FABRIC  := TamSX3( "B1_FABRIC" ) [01]

	Private cAliasDest  := "SB1"
	Private cAliasRel   := ""
	Private cArquivo    := ""

	//Define o Layout da Planilha Excel, associando as colunas aos Nomes dos
	//respectivos campos dentro do arquivo SX3 do Protheus.
	Private aCampos		:=	{	{ "B1_GRUPO"	, Nil, Nil } ,;
		{ "B1_COD"		, Nil, Nil } ,;
		{ "B1_TIPO"		, Nil, Nil } ,;
		{ "B1_DESC"		, Nil, Nil } ,;
		{ "B1_XMARCA"	, Nil, Nil } ,;
		{ "B1_LOCPAD"	, Nil, Nil } ,;
		{ "B1_UM"		, Nil, Nil } ,;
		{ "B1_SEGUM"	, Nil, Nil } ,;
		{ "B1_CONV"		, Nil, Nil } ,;
		{ "B1_TIPCONV"	, Nil, Nil } ,;
		{ "B1_ALTER"	, Nil, Nil } ,;
		{ "B1_PESBRU"	, Nil, Nil } ,;
		{ "B1_PESO"		, Nil, Nil } ,;
		{ "B1_RASTRO"	, Nil, Nil } ,;
		{ "B1_PERINV"	, Nil, Nil } ,;
		{ "B1_LOCALIZ"	, Nil, Nil } ,;
		{ "B1_GRUPCOM"	, Nil, Nil } ,;
		{ "B1_POSIPI"	, Nil, Nil } ,;
		{ "B1_ORIGEM"	, Nil, Nil } ,;
		{ "B1_CONTA"	, Nil, Nil } ,;
		{ "B1_CC"		, Nil, Nil } ,;
		{ "B1_GRTRIB"	, Nil, Nil } ,;
		{ "B1_IRRF"		, Nil, Nil } ,;
		{ "B1_IPI"		, Nil, Nil } ,;
		{ "B1_ALIQISS"	, Nil, Nil } ,;
		{ "B1_INSS"		, Nil, Nil } ,;
		{ "B1_PIS"		, Nil, Nil } ,;
		{ "B1_PPIS"		, Nil, Nil } ,;
		{ "B1_COFINS"	, Nil, Nil } ,;
		{ "B1_PCOFINS"	, Nil, Nil } ,;
		{ "B1_CSLL"		, Nil, Nil } ,;
		{ "B1_PCSLL"	, Nil, Nil } ,;
		{ "B1_RETOPER"	, Nil, Nil } ,;
		{ "B1_REFBAS"	, Nil, Nil } ,;
		{ "B1_VM_I"		, Nil, Nil } ,;
		{ "B1_VM_GI"	, Nil, Nil } ,;
		{ "B1_VM_P"		, Nil, Nil } ,;
		{ "B1_FABRIC"	, Nil, Nil } ,;
		{ "B1_XPAISOR"	, Nil, Nil } ,;
		{ "B1_XREGANV"	, Nil, Nil } ,;
		{ "B1_CATEGOR"	, Nil, Nil } ,;
		{ "B1_LINHA"	, Nil, Nil } ,;
		{ "B1_PROC"		, Nil, Nil } ,;
		{ "B1_LOJPROC"	, Nil, Nil } ,;
		{ "B1_XFLUIG"	, Nil, Nil } ,;
		{ "B1_VOLTAGE"	, Nil, Nil } ,;
		{ "B1_CODBAR"	, Nil, Nil } ,;
		{ "A5_FORNECE"	, Nil, Nil } ,;
		{ "A5_LOJA"		, Nil, Nil } ,;
		{ "A5_CODPRF"	, Nil, Nil } ,;
		{ "B5_XVOLUME" 	, Nil, Nil } ,;
		{ "B5_LARG" 	, Nil, Nil } ,;
		{ "B5_COMPR" 	, Nil, Nil } ,;
		{ "B5_ALTURA" 	, Nil, Nil }  }
	//{ "B1_XALERTA"	, Nil, Nil } ,;
	//{ "B1_XOBSERV"	, Nil, Nil } ,;

	//Define o Vetor contendo Campos que receberão valores defaults, ou seja,
	//valores que não serão alterados.
	Private aComplementos  := { { "B1_MSBLQL" , "1" 	} ,;
		{ "B1_XIMPORT", Date() 	}  }

	If Aviso( "Atenção", "Você confirma a execução da Rotina de Importação do cadastro de Produtos?", { "Sim", "Não" } ) == 02
		Return
	End If

	//Atualiza na Matriz aCampos a Obrigatoriedade de Preenchimento dos Campos
	DbSelectArea( "SX3" )
	For nK := 01 To Len( aCampos )
		aCampos[nK][02] := AvSX3( aCampos[nK][01], 02 ) // Pega o Tipo do Campo
		If !( Left( aCampos[nK][01], 02 ) $ "A5_B5" )
			aCampos[nK][03] := X3Obrigat( aCampos[nK][01] ) // Obrigatoriedade
		Else
			aCampos[nK][03] := .F. // Obrigatoriedade
		EndIf
	Next nK

	//Pega o Campo de Parâmetro que está com o Arquivo da Planilha selecionada pelo usuário
	cArquivo       := MV_PAR01

	//Pontera sobre os Indices que serao utilizados pela validacao
	DbSelectArea( cAliasDest ) 	// Cadastro de Produtos
	DbSetOrder( 01 ) 			// B1_FILIAL + B1_COD

	//Faz uma Varredura no Arquivo Validando as Informações
	//e ao Final Realiza a Importacao das Informações.
	lImporta   	  	:= .T.
	lEncontrouErro 	:= .F.

	//Cria o Arquivo de Log
	aEstrut :=	{	{ "CODIGO"  , "C", 015, 00 } , ;
		{ "NOME"	, "C", 034, 00 } , ;
		{ "LINHA"	, "N", 006, 00 } , ;
		{ "MENSAGEM", "C", 160, 00 }  }

	cAliasRel := GetNextAlias()
	oTempTable := FWTemporaryTable():New( cAliasRel )
	oTempTable:AddIndex("01", {"CODIGO"} )
	oTempTable:SetFields( aEstrut )
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
		cLinha := Replace( Replace( Replace( cLinha, CRLF, "{CRLF}" ), Chr( 10 ), "{CR}" ), Chr( 13 ), "{LF}" )
		nLinha++
		cMsg   := ""

		IncProc( "Validando registro " + StrZero( nLinha, 05 ) + " da Planilha, aguarde." )

		//Se a Linha estiver em branco, vai para a proxima Linha do Arquivo.
		If AllTrim( cLinha ) == "" .Or. "Cod;Grupo;Tipo;Descrição" $ AllTrim( cLinha )
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
	# 	Campo 		Descrição 									Tipo	Tam Máx Classificação	Tabela de Opções
	===============================================================================================================================================================
	1	B1_GRUPO	Grupo										Char	4		Obrigatório		(ver tabela de opções)
	2	B1_COD		Código										Char	15		Obrigatório
	3	B1_TIPO		Tipo 										Char	2		Obrigatório		(ver tabela de opções)
	4	B1_DESC		Descrição									Char	40		Obrigatório
	5	B1_XMARCA	Marca 										Char	2		Opcional		(Informar o código - ver tabela de opções)
	6	B1_LOCPAD	Armazém Padrão 								Char	2		Obrigatório		(ver tabela de opções)
	7	B1_UM		Unidade de Medida 							Char	2		Obrigatório		(ver tabela de opções)
	8	B1_SEGUM	Seg. Um. Medida 							Char	2		Opcional		(ver tabela de opções)
	9	B1_CONV		Fator Conv.									Num		5		Opcional
	10	B1_TIPCONV	Tipo de Conv 								Char	1		Opcional		(M=Multiplicador, D=Divisor)
	11	B1_ALTER	Alternativo 								Char	15		Opcional		(Informar o código do produto)
	12	B1_PESBRU	Peso Bruto									Num		11		Opcional
	13	B1_PESO		Peso Líquido								Num		11		Opcional
	14	B1_RASTRO	Rastreabilidade 							Char	1		Opcional		(L=Lote ou N=Não utiliza)
	15	B1_PERINV	Per. Invent.								Num		3		Opcional
	16	B1_LOCALIZ	Endereçamento ou No. Série 					Char	1		Opcional		(S=Sim ou N=Não)
	17	B1_GRUPCOM	Grupo de Compras 							Char	6		Obrigatório		(Informar o código)
	18	B1_POSIPI	NCM											Char	10		Obrigatório		(Informar o código)
	19	B1_ORIGEM	Origem 										Char	1		Obrigatório		(0=Nacional, 1=Importado ou 2=Adq. Merc. Interno)
	20	B1_CONTA	Conta Contábil								Char	20		Obrigatório
	21	B1_CC		C Custo (Centro de Custo)					Char	9		Opcional
	22	B1_GRTRIB	Grupo Trib. 								Char	6		Opcional 		(Grupo de Tributação)
	23	B1_IRRF		Imposto Renda 								Char	1		Opcional		(S=Sim, N=Não)
	24	B1_IPI		Aliq. IPI									Num		5		Opcional
	25	B1_ALIQISS	Aliq. ISS									Num		5		Opcional
	26	B1_INSS		Calcula INSS			 					Char	1		Opcional		(S=Sim, N=Não)
	27	B1_PIS		Retém PIS 									Char	1		Opcional		(S=Sim, N=Não)
	28	B1_PPIS		Perc. PIS									Num		5		Opcional		(S=Sim, N=Não)
	29	B1_COFINS	Retém COFINS			 					Char	1		Opcional		(1=Sim, 2=Não)
	30	B1_PCOFINS	Perc. COFINS								Num		5		Opcional
	31	B1_CSLL		Retém CSLL 									Char	1		Opcional		(1=Sim, 2=Não)
	32	B1_PCSLL	Perc. CSLL									Num		5		Opcional
	33	B1_RETOPER	Ret. Operação 								Char	1		Opcional		(1=Sim, 2=Não)
	34	B1_REFBAS	Ref. Base 	 								Char	1		Opcional		(0=Preço Tabelado/Máximo, 1=Valor Agregado, 2+Lista Negativa, 3=Lista Positiva, 4=Lista Neutra)
	35	B1_VM_I		Descrição Inglês 							Memo	1048	Opcional
	36	B1_VM_GI	Descrição Licença/Declaração de Importação	Memo	1048	Opcional
	37	B1_VM_P		Descrição Português							Memo	1048	Opcional
	38	B1_FABRIC	Fabricante									Char	20		Opcional
	39	B1_XPAISOR	País Origem (do Fabricante)					Char	20		Opcional
	40	B1_XREGANV	Reg. ANVISA									Char	12		Opcional
	41	B1_CATEGOR	Categoria 									Char	6		Obrigatório		(ver tabela de opções)
	42	B1_LINHA	Linha 										Char	6		Obrigatório		(ver tabela de opções)
	43	B1_PROC		Fornecedor Padrão							Char	9		Opcional		(ver tabela de opções)
	44	B1_LOJPROC	Loja do Fornecedor							Char	4		Opcional
	45	B1_XFLUIG	Integra Fluig								Char	1		Obrigatório		(S=Sim, N=Não)
	46	B1_VOLTAGE	Voltagem do Produto 						Char	3		Opcional
	47	B1_CODBAR	Código de Barras							Char	15		Obrigatótio
	48	A5_FORNECE	Código do Fornecedor						Char	9		Opcional
	49	A5_LOJA		Loja do Fornecedor							Char	4		Opcional
	50	A5_CODPRF	Cod.Produto Fornecedor						Char	20		Opcional
	51	B5_XVOLUME	Volume               						Num		10,02	Opcional
	52	B5_LARG   	Largura                 					Num		10,02	Opcional
	53	B5_COMPR	Comprimento           						Num		10,02	Opcional
	54	B5_ALTURA	Altura                						Num		10,02	Opcional

	48	B1_XALERTA	Alerta do Produto							Char	1048	Opcional
	49	B1_XOBSERV	Campo Observação							Memo	1048	Opcional

		*/
		cMsg 		:= ""
		lImporta 	:= .T.

		DbSelectArea( "SZ3" )
		DbSetOrder( 02 )
		Seek XFilial( "SZ3" ) + PadR( aConteudo[nPB1FABRIC], nTamB1FABRIC )
		If Found()
			aConteudo[nPB1FABRIC] := SZ3->Z3_CODIGO
		EndIf

		//Verifica o Preenchimento dos Campos Obrigatorios
		lEmBranco 		:= .F.
		nEhObrigatorio 	:= 03
		For nJ := 01 To Len( aCampos )

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
					cMsg := "O " + AllTrim( AvSX3( aCampos[nJ][01], 05 ) ) + " é Obrigatório e não está preenchido. Linha " + StrZero( nLinha, 05 ) + "."
					Exit

				EndIf

			EndIf

		Next nJ

		If !lImporta

			//Cria Linha para o Relatório Documentando o que aconteceu
			DbSelectArea( cAliasRel )
			RecLock( cAliasRel, .T. )

			( cAliasRel )->CODIGO    := aConteudo[nPB1COD]
			( cAliasRel )->NOME      := aConteudo[nPB1DESC]
			( cAliasRel )->LINHA     := nLinha + 01
			( cAliasRel )->MENSAGEM  := cMsg
			//( cAliasRel )->LOJA      := aConteudo[nPA1LOJA]

			( cAliasRel )->( MsUnLock() )

			lEncontrouErro := .T.

		EndIf

		//Alimenta o Vetor com os Produtos da Planilha e Pula de Linha no Arquivo Texto
		aAdd( aProdutos, PadR( aConteudo[nPB1COD], TamSX3( "B1_COD" )[01] )  )
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
			cLinha := Replace( Replace( Replace( cLinha, CRLF, "{CRLF}" ), Chr( 10 ), "{CR}" ), Chr( 13 ), "{LF}" )
			nLinha++
			cMsg   := ""

			//Se a Linha estiver em branco, vai para a proxima Linha do Arquivo.
			If AllTrim( cLinha ) == ""
				FT_FSKIP()
				Loop
			EndIf

			//Distribui os Campos da Planilha para um Vetor, Pois no Arquivo Texto
			//os Campos estao separados por ponto-e-virgula.
			aConteudo := Separa( cLinha, ";", .T. )

			IncProc( "Importando Cadastro Produtos " + Alltrim( aConteudo[nPB1COD] ) )

			DbSelectArea( "SZ3" )
			DbSetOrder( 02 )
			Seek XFilial( "SZ3" ) + PadR( aConteudo[nPB1FABRIC], nTamB1FABRIC )
			If Found()
				aConteudo[nPB1FABRIC] := SZ3->Z3_CODIGO
			EndIf

			//Monta o Array para o ExecAuto
			aDadosImP := {}
			aAdd( aDadosImp, { "B1_FILIAL"		, XFilial( cAliasDest )						  										, Nil } )
			aAdd( aDadosImp, { "B1_GRUPO"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1GRUPO]	 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_COD"			, Upper( TrataTexto( AllTrim( aConteudo[nPB1COD] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_TIPO"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1TIPO] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_DESC"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1DESC] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_XMARCA"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1XMARCA]		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_LOCPAD"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1LOCPAD] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_UM"			, Upper( TrataTexto( AllTrim( aConteudo[nPB1UM] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_SEGUM"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1SEGUM] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_CONV"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1CONV] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_TIPCONV"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1TIPCONV] 	) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_ALTER"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1ALTER] 		) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_ALTER"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1ALTER] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_PESBRU"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1PESBRU] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_PESO"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1PESO] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_RASTRO"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1RASTRO] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_PERINV"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1PERINV] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_LOCALIZ"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1LOCALIZ] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_GRUPCOM"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1GRUPCOM] 	) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_POSIPI"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1POSIPI] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_POSIPI"		, "00000000" 																		, Nil } )
			aAdd( aDadosImp, { "B1_ORIGEM"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1ORIGEM] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_CONTA"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1CONTA] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_CC"			, Upper( TrataTexto( AllTrim( aConteudo[nPB1CC] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_GRTRIB"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1GRTRIB] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_IRRF"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1IRRF] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_IPI"			,   Val( TrataTexto( AllTrim( aConteudo[nPB1IPI] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_ALIQISS"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1ALIQISS] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_INSS"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1INSS] 		) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_PIS"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1PIS] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_PIS"			, "2" 																				, Nil } )
			aAdd( aDadosImp, { "B1_PPIS"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1PPIS] 		) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_COFINS"	, Upper( TrataTexto( AllTrim( aConteudo[nPB1COFINS] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_COFINS"		, "2"												 								, Nil } )
			aAdd( aDadosImp, { "B1_PCOFINS"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1PCOFINS] 	) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_CSLL"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1CSLL] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_CSLL"		, "2"																				, Nil } )
			aAdd( aDadosImp, { "B1_PCSLL"		,   Val( TrataTexto( AllTrim( aConteudo[nPB1PCSLL] 		) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_RETOPER"	, Upper( TrataTexto( AllTrim( aConteudo[nPB1RETOPER] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_RETOPER"		, "2"																				, Nil } )
			aAdd( aDadosImp, { "B1_REFBAS"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1REFBAS] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_VM_I"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1VM_I] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_VM_GI"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1VM_GI] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_VM_P"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1VM_P] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_FABRIC"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1FABRIC] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_XPAISOR"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1XPAISOR] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_XREGANV"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1XREGANV] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_CATEGOR"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1CATEGOR] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_LINHA"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1LINHA]	 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_PROC"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1PROC] 		) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_LOJPROC"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1LOJPROC] 	) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_XFLUIG"	, Upper( TrataTexto( AllTrim( aConteudo[nPB1XFLUIG] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_XFLUIG"		, "S"																				, Nil } )
			aAdd( aDadosImp, { "B1_VOLTAGE"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1VOLTAGE] 	) ) )						, Nil } )
			aAdd( aDadosImp, { "B1_CODBAR"		, Upper( TrataTexto( AllTrim( aConteudo[nPB1CODBAR] 	) ) )						, Nil } )
			//aAdd( aDadosImp, { "B1_XALERTA"		, Replace( Upper( TrataTexto( AllTrim( aConteudo[nPB1XALERTA] 	) ) ), "#", ";" )	, Nil } )
			//aAdd( aDadosImp, { "B1_XOBSERV"		, Replace( Upper( TrataTexto( AllTrim( aConteudo[nPB1XOBSERV] 	) ) ), "#", ";" )	, Nil } )

			//Realiza a Gravação dos Defaults, ou seja, dos valores fixos do Registro
			aEval( aComplementos, { |x| aAdd( aDadosImp, { x[01], x[02], Nil } ) } )

			// Realiza a Inclusão através de MsExecAuto
			lMsErroAuto := .F.
			MsExecAuto( { | x, y | MATA010( x, y ) }, aDadosImp, 03 )
			If lMsErroAuto

				MostraErro()

			Else

				DbSelectArea( "SB1" )
				RecLock( "SB1", .F. )
				SB1->B1_ALTER  := aConteudo[nPB1ALTER]
				SB1->B1_POSIPI := Replace( Replace( aConteudo[nPB1POSIPI], ".", "" ), "-", "" )
				SB1->( MsUnLock() )

				cAuxFornecedor := PadR( Upper( TrataTexto( AllTrim( aConteudo[nPA5FORNECE] 	) ) ), TamSX3( "A5_FORNECE" )[01] )
				cAuxLojaFornec := PadR( Upper( TrataTexto( AllTrim( aConteudo[nPA5LOJA] 	) ) ), TamSX3( "A5_LOJA"    )[01] )
				cAuxProdFornec := PadR( Upper( TrataTexto( AllTrim( aConteudo[nPA5CODPRF] 	) ) ), TamSX3( "A5_CODPRF"  )[01] )

				// Realiza a Gravação da Tabela de Produto x Fornecedores
				DbSelectArea( "SA5" )
				DbSetOrder( 01 ) // A5_FILIAL + A5_FORNECE + A5_LOJA + A5_PRODUTO + A5_FABR + A5_FALOJA
				Seek XFilial( "SA5" ) + cAuxFornecedor + cAuxLojaFornec + SB1->B1_COD
				If !Found()

					RecLock( "SA5", .T. )

					SA5->A5_FILIAL := XFilial( "SA5" )
					SA5->A5_FORNECE	:= cAuxFornecedor
					SA5->A5_LOJA	:= cAuxLojaFornec
					SA5->A5_NOMEFOR	:= Posicione( "SA2", 01, XFilial( "SA2" ) + cAuxFornecedor + cAuxLojaFornec, "A2_NOME" )
					SA5->A5_PRODUTO	:= SB1->B1_COD
					SA5->A5_NOMPROD	:= SB1->B1_DESC
					SA5->A5_CODPRF	:= cAuxProdFornec

					SA5->( MsUnLock() )

				Else

					RecLock( "SA5", .F. )

					SA5->A5_FORNECE	:= cAuxFornecedor
					SA5->A5_LOJA	:= cAuxLojaFornec
					SA5->A5_NOMEFOR	:= Posicione( "SA2", 01, XFilial( "SA2" ) + cAuxFornecedor + cAuxLojaFornec, "A2_NOME" )
					SA5->A5_NOMPROD	:= SB1->B1_DESC
					SA5->A5_CODPRF	:= cAuxProdFornec

					SA5->( MsUnLock() )

				EndIf

				cAuxProduto	   := PadR( Upper( TrataTexto( AllTrim( aConteudo[nPB1COD] 		) ) ), TamSX3( "B1_COD" )[01] )

				// Realiza a Gravação da Tabela de Produto x Fornecedores
				DbSelectArea( "SB5" )
				DbSetOrder( 01 ) // B5_FILIAL + B5_COD
				Seek XFilial( "SB5" ) + cAuxProduto
				If !Found()

					RecLock( "SB5", .T. )

					SB5->B5_FILIAL 	:= XFilial( "SB5" )
					SB5->B5_COD		:= cAuxProduto
					SB5->B5_XVOLUME	:= Val( TrataTexto( AllTrim( aConteudo[nPB5XVOLUME] 	) ) )
					SB5->B5_LARG	:= Val( TrataTexto( AllTrim( aConteudo[nPB5LARG] 	) ) )
					SB5->B5_COMPR	:= Val( TrataTexto( AllTrim( aConteudo[nPB5COMPR] 	) ) )
					SB5->B5_ALTURA	:= Val( TrataTexto( AllTrim( aConteudo[nPB5ALTURA] 	) ) )

					SB5->( MsUnLock() )

				Else

					RecLock( "SB5", .F. )

					SB5->B5_XVOLUME	:= Val( TrataTexto( AllTrim( aConteudo[nPB5XVOLUME] 	) ) )
					SB5->B5_LARG	:= Val( TrataTexto( AllTrim( aConteudo[nPB5LARG] 	) ) )
					SB5->B5_COMPR	:= Val( TrataTexto( AllTrim( aConteudo[nPB5COMPR] 	) ) )
					SB5->B5_ALTURA	:= Val( TrataTexto( AllTrim( aConteudo[nPB5ALTURA] 	) ) )

					SB5->( MsUnLock() )

				EndIf

			EndIf

			FT_FSKIP()
		EndDo

		Aviso( "Atencao", "Importação do Cadastro de Produtos concluída.", { "Ok" } )

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
	Local cDesc3       := "Log de Inconsistências na Importação do Cadastro de Produtos"
	Local cPict        := ""
	Local titulo       := "Log de Inconsistências na Importação do Cadastro de Produtos"
	Local nLin         := 80
	//"0        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
	//"|         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |
	//"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	Local Cabec1       	:= " Código  Nome                                        Linha    Mensagem de Erro"
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
	Local nPosNome       := 09
	Local nPosLinha      := 53
	Local nPosMensagem   := 63
	//Local nPosLoja       := 09

	//"0        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
	//"|         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |
	//"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//Local Cabec1        := " Código  Nome                                        Linha    Mensagem de Erro"

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
		@ nLin, nPosNome       PSay ( cAliasRel )->NOME
		@ nLin, nPosLinha      PSay StrZero( ( cAliasRel )->LINHA, 06 )
		@ nLin, nPosMensagem   PSay Alltrim( ( cAliasRel )->MENSAGEM )
		// @ nLin, nPosLoja       PSay ( cAliasRel )->LOJA

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
		"Ú", "ú", "Ù", "ù", "Û", "û", "Ü", "ü", "'", ;
		"Ç", "ç", "°", "ª" ,"¿åE", "¿C","¶", "||", "{CRLF}", "{CR}", "{LF}"  }

	Local aCertas  := { "A", "a", "A", "a", "A", "a", "A", "a", "A", "a", ;
		"E", "e", "E", "e", "E", "e", "E", "e", ;
		"I", "i", "I", "i", "I", "i", "I", "i", ;
		"O", "o", "O", "o", "O", "o", "O", "o", "O", "o", ;
		"U", "u", "U", "u", "U", "u", "U", "u", "''", ;
		"C", "c", ".", "." , "OE", "CA","A", ";", CRLF, Chr( 10 ), Chr( 13 )  }

	cRetorno := cTexto
	For nJ := 01 To Len( aErradas )
		cRetorno := Replace( cRetorno, aErradas[nJ], aCertas[nJ] )
	Next nJ

Return FwNoAccent( Alltrim( cRetorno ) )
