
/*/{Protheus.doc} UNIWS01B

@project Integração Protheus x Magento
@description Rotina híbrida ( Menu / Schedule ) utilizada para realizar a gravação dos pedidos Magento
@author Lucas Miranda
@since 24/06/2020
@version 1.0

/*/
#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"

User Function UNIWSJB()
	U_UNIWS01B( "01", "0207")
Return

User Function UNIWS01B(cParamEmpJob, cParamFilJob)

	//Local
	Local oFontProc     	:= Nil
	Local oDlgProc      	:= Nil
	Local oGrpTexto     	:= Nil
	Local oSayTexto     	:= Nil
	Local oBtnConfi     	:= Nil
	Local oBtnParam     	:= Nil
	Local oBtnSair      	:= Nil
	Local LHTML             := .T.
	Local lConfirmou   	 	:= .F.
	Local cPerg         	:= "UNIWS01B"
	Local cTitulo   	    := "Integração Protheus x Magento - Importação de Pedidos de Vendas"
	Local cTexto  	      	:= "Esta rotina tem como objetivo consultar os pedidos pendentes na tabela intermediária e integrar no Protheus"
	Local lMostraTela 		:= .F. //IsBlind()

	//Private
	Private cPergDe  := ""
	Private cPergAte := ""
	Private cPergFil := ""
	Private lRollBack      := .F.
	//Default
	Default cParamEmpJob	:= ""
	Default cParamFilJob	:= ""
	//Default oParamWS    	:= Nil

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lMostraTela 	:= AllTrim( cParamEmpJob ) == ""
	lSchedule 		:= AllTrim( cParamEmpJob ) != ""

	If !lMostraTela

		ConOut( " ################################################################################### " )
		ConOut( " ## INICIO INTEGRAÇÃO UNIWS01B - IMPORTACAO PEDIDO DE VENDAS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ################################################################################### " )

		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob,,, "LOJ",, { "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3","SX6","SX2","SX3"},  .T. )

		ConOut( "	- Abriu as tabelas..." )
		If Select( "SLQ" ) > 0
			ConOut( "		- ALIAS - SLQ" )
		EndIf
		If Select( "SLR" ) > 0
			ConOut( "		- ALIAS - SLR" )
		EndIf
		If Select( "SL1" ) > 0
			ConOut( "		- ALIAS - SL1" )
		EndIf
		If Select( "SL2" ) > 0
			ConOut( "		- ALIAS - SL2" )
		EndIf
		If Select( "SL4" ) > 0
			ConOut( "		- ALIAS - SL4" )
		EndIf
		If Select( "SA1" ) > 0
			ConOut( "		- ALIAS - SA1" )
		EndIf
		If Select( "SB1" ) > 0
			ConOut( "		- ALIAS - SB1" )
		EndIf
		If Select( "DA0" ) > 0
			ConOut( "		- ALIAS - DA0" )
		EndIf
		If Select( "DA1" ) > 0
			ConOut( "		- ALIAS - DA1" )
		EndIf
		If Select( "SA3" ) > 0
			ConOut( "		- ALIAS - SA3" )
		EndIf
		If Select( "SX6" ) > 0
			ConOut( "		- ALIAS - SX6" )
		EndIf
		If Select( "SX2" ) > 0
			ConOut( "		- ALIAS - SX2" )
		EndIf
		If Select( "SX3" ) > 0
			ConOut( "		- ALIAS - SX3" )
		EndIf

		//Gerando Perguntas do Parâmetro
		MV_PAR01 := ""
		MV_PAR02 := ""
		MV_PAR03 := cParamFilJob

		FIntegra( lSchedule )

		//Reset Environment


		ConOut( " ################################################################################ " )
		ConOut( " ## FIM INTEGRAÇÃO UNIWS01B - IMPORTACAO PEDIDO DE VENDAS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ################################################################################ " )

	Else



		// Monta Tela
		//Gerando Perguntas do Parâmetro
		Pergunte( cPerg, .F. )

		cTexto    := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"
		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Integrar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oDlgProc:Activate( ,,,.T. )

		If lConfirmou
			cPergDe  := MV_PAR01
			cPergAte := MV_PAR02
			cPergFil := MV_PAR03
			Processa( { || FIntegra( lSchedule ) }, "Gerando orçamento, aguarde..." )
		EndIf

	EndIf
Return

Static function FVldParametros()

	Local lRet := .T.

	If AllTrim(MV_PAR01) <> "" .And. AllTrim(MV_PAR02) == ""
		Aviso( "Atenção", "Preencha todos os parâmetros", { "Voltar" } )
		lRet := .F.
	EndIf

	If AllTrim(MV_PAR02) <> "" .And. AllTrim(MV_PAR01) == ""
		Aviso( "Atenção", "Preencha todos os parâmetros", { "Voltar" } )
		lRet := .F.
	EndIf

Return .T.

Static Function FIntegra( lSchedule)

	Local aArea     := GetArea()
	Local cQuery    := ""
	Local cAliasUNI := GetNextAlias()
	Local lGravouL1 := .T.
	Private cFilOrc     := ""//Filial do orçamento
	Private cNumOrc     := ""//Número do orçamento
	Private cIdMageOrc  := ""//Pedido Magento
	Private cPedMKtOrc  := ""//Pedido MarketPlace
	Private cStatusOrc  := ""//Status Magento
	Private cDtTblUNI   := ""//Data de gravação na tabela intermediária (Usada para LOG)
	Private cHrTblUNI   := ""//Hora de gravação na tabela intermediária (Usada para LOG)
	Private cXidTblUNI  := ""//ID único gravado na tabela intermediária (Usada para LOG)
	Private cCliOrc     := ""//Nome do cliente
	Private cCGCCliOrc  := ""//CPF ou CNPJ do cliente
	Private cLojCliOrc  := ""//Loja da compra
	Private cTipoCliOrc := ""//Tipo de cliente
	Private cCAdmOrc    := ""//Código da administradora
	Private cVendOrc    := ""//Código do vendedor
	Private nVlFretOrc  := ""//Valor do frete
	Private cParcelaOrc := ""//Número de parcelas
	Private cTranspOrc  := ""//Código da transportadora
	Private cCondPgOrc  := ""//Código da condição de pagamento
	Private cAutResOrc  := ""//Não sei
	Private cRecnoUNI   := ""//R_E_C_N_O_
	Private cWSDLOrc    := ""//WSDL em que o pedido foi baixado no Magento (Usada para LOG)
	Private cCodCliOrc  := ""//Código do cliente
	Private cFormaPgOrc := ""//Forma de pagamento
	Private cVend2Orc   := ""//Código do segundo vendedor caso tenha
	Private cAuxCFOP    := ""//Não sei
	Private cA1ESTE     := ""//Estado entrega
	Private nDescFinOrc := 0//Desconto financeiro
	Private nDesconOrc  := 0//Desconto
	Private nValTotOrc  := 0//Valor Total
	Private nValLiqOrc  := 0//Valor Líquido
	Private nValBrutOrc := 0//Valor Bruto
	Private nValMercOrc := 0//Valor de mercado
	Private nAuxTotTabela := 0//Total
	Private nJurosOrc	:= 0 //Juros orçamento
	Private aItensOrc   := {}//Itens do orçamento
	Private aAuxTES     := {}//TES
	Private aPgtoOrc    := {}//Clone
	Private aAuxCond    := {}//Array cond pgto

	Private cUsrCaixa       := ""
	Private cPassCaixa      := ""
	Private cWsSerieMg      := ""
	Private cUsrLogin  		:= ""
	Private cUsrPass  		:= ""
	Private cSerMagento		:= ""
	Private cNumOrig		:= ""
	Private cAuxEstacao 	:= ""
	Private cAuxPDV	     	:= ""
	Private cAuxOperador	:= ""
	Private cAuxSituacao	:= ""
	Private nAuxParcela     := 0
	Private lEhSch 			:= .T.
	Private  aAutoCab		:= {}
	Private  lPOSLJAUTO     := .T.
	Private  lMsErroAuto 	:= .F.
	Private  lMsHelpAuto 	:= .F.
	Private  Inclui  		:= .T.
	Private  Altera  		:= .F.
	Private  lAuxAuto 		:= .T.
	Private nRecNoSL1       := 0
	Private  lAutoExec		:= .T.
	Private cDescri         := ""
	Private cAuxMsgErro     := ""
	Private cCodInstanc     := ""
	Private cVaiParaFila	:= "produtos_em_transporte|new|processing|pending_payment|novo|pending|complete" // "new.processing.pending_payment.novo.pending"
	Private cLiberaPedido	:= "pagamento_confirmado"
	Private cExcluiPedido	:= "canceled|closed"
	Private cTransportePed	:= "produtos_em_transporte"
	Private cIgnorarPedido  := "produtos_em_transporte|complete|produtos_entregues|canceled"
	Private lExclui         := .F.
	Private lLibera         := .F.
	Private cAuxTES         := ""
	Private cFilEst         := ""
	Private lRetExcl        := .F.
	Private lRetLib         := .F.
	Private cMethodOrc      := ""
	Private cOrigemOrc      :=  ""
	Private nValorTotal     := 0
	Private cNsuOrc         := ""
	Private cFLGREP         := ""
	Private cDataBanco      := ""

	cDataBanco := DtoS(DaySub( Date() , 10 ))


	If lSchedule
		cQuery := "		SELECT *  "
		cQuery += "		  FROM " + RetSQLName( "UNI" )
		cQuery += "		  WHERE D_E_L_E_T_ = ' ' "
		//cQuery += "   AND    UNI_FLGREP IN (' ','1','2','3')                           "
		cQuery += "		AND  UNI_INTEG IN ('PENDENTE')"
		cQuery += " AND UNI_DATA >= '"+cDataBanco+"'"
	Else
		cQuery := "		SELECT *  "
		cQuery += "		  FROM " + RetSQLName( "UNI" )
		cQuery += "		  WHERE D_E_L_E_T_ = ' ' "
		cQuery += " AND UNI_DATA >= '"+cDataBanco+"'"
		//cQuery += " AND UNI_STATUS = 'pagamento_confirmado'"
		//cQuery += "		AND  UNI_INTEG NOT IN ('IGNORAR')"
		If AllTrim(cPergDe) == ""
			cQuery += "		AND  UNI_FILIAL = '" +AllTrim(cPergFil) +"'"
		Else
			cQuery += "		 AND UNI_FILIAL = '" +AllTrim(cPergFil)+ "' "
			cQuery += "		AND  UNI_IDMAG BETWEEN '" +AllTrim(cPergDe)+ "' AND '"+AllTrim(cPergAte)+"'"
		EndIf
	EndIf

	If Select( cAliasUNI ) > 0
		( cAliasUNI )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasUNI ) New

	If !( cAliasUNI )->( Eof() )
		While !( cAliasUNI )->( Eof() )

			cFilOrc     :=  AllTrim(( cAliasUNI )->UNI_FILIAL)
			cNumOrc     :=  AllTrim(( cAliasUNI )->UNI_NUM)
			cIdMageOrc  :=  AllTrim(( cAliasUNI )->UNI_IDMAG            )
			cPedMKtOrc  :=  AllTrim(( cAliasUNI )->UNI_PEDMKT           )
			cStatusOrc  :=  AllTrim(( cAliasUNI )->UNI_STATUS           )
			cDtTblUNI   :=  AllTrim(( cAliasUNI )->UNI_DATA             )
			cHrTblUNI   :=  AllTrim(( cAliasUNI )->UNI_HR               )
			cXidTblUNI  :=  AllTrim(( cAliasUNI )->UNI_XID              )
			cFLGREP     :=  AllTrim(( cAliasUNI )->UNI_FLGREP           )
			cCliOrc     :=  AllTrim(( cAliasUNI )->UNI_NOMECLI          )
			cCGCCliOrc  :=  AllTrim(( cAliasUNI )->UNI_CGCCLI           )
			cLojCliOrc  :=  AllTrim(( cAliasUNI )->UNI_LOJCLI           )
			cTipoCliOrc :=  AllTrim(( cAliasUNI )->UNI_TIPOCL           )
			cCAdmOrc    :=  ( cAliasUNI )->UNI_CADMIN
			cVendOrc    :=  AllTrim(( cAliasUNI )->UNI_VEND             )
			cParcelaOrc :=  AllTrim(( cAliasUNI )->UNI_PARCEL           )
			cTranspOrc  :=  AllTrim(( cAliasUNI )->UNI_TRANSP           )
			cCondPgOrc  :=  AllTrim(( cAliasUNI )->UNI_CONDPG           )
			cAutResOrc  :=  AllTrim(( cAliasUNI )->UNI_AUTRES           )
			cWSDLOrc    :=  AllTrim(( cAliasUNI )->UNI_WSDL             )
			cCodCliOrc  :=  AllTrim(( cAliasUNI )->UNI_CODCLI           )
			cNsuOrc     :=  AllTrim(( cAliasUNI )->UNI_NSU              )
			cFormaPgOrc :=  ( cAliasUNI )->UNI_FORMA
			cVend2Orc   :=  AllTrim(( cAliasUNI )->UNI_VEND2            )
			cMethodOrc  :=  AllTrim(( cAliasUNI )->UNI_METHOD            )
			cRecnoUNI   :=  AllTrim(cValToChar(( cAliasUNI )->(RECNO())))
			nVlFretOrc  :=  Val(AllTrim(( cAliasUNI )->UNI_VLFRET) )
			nDescFinOrc :=  Val(AllTrim(( cAliasUNI )->UNI_DESCFN))
			nDesconOrc  :=  Val(AllTrim(( cAliasUNI )->UNI_DESCON))
			nValTotOrc  :=  Val(AllTrim(( cAliasUNI )->UNI_VALTOT))
			nValLiqOrc  :=  Val(AllTrim(( cAliasUNI )->UNI_VALLIQ))
			nValBrutOrc :=  Val(AllTrim(( cAliasUNI )->UNI_VALBRUT))
			nValMercOrc :=  Val(AllTrim(( cAliasUNI )->UNI_VALMERC))
			cOrigemOrc  := AllTrim(( cAliasUNI )->UNI_ORIGEM            )
			nValorTotal := Val(( cAliasUNI )->UNI_VALOR)
			If AllTrim(( cAliasUNI )->UNI_JUROS) != ""
				nJurosOrc   := Val(AllTrim(( cAliasUNI )->UNI_JUROS))
			Else
				nJurosOrc := 0
			EndIf

			//nValorTotal := nValorTotal + nJurosOrc
			//Verifica primeiro se é para ignorar
			If AllTrim( cStatusOrc ) $ AllTrim( cIgnorarPedido )
				ConOut( "	UNIWS01B - Pedido de Vendas [ " + AllTrim( cIdMageOrc ) + " ], não precisa ser processado... Status [ " + cStatusOrc + " ]." )
				//Alterar Pedido na tabela Intermediaria
				cDescri := " Pedido de Vendas [ " + AllTrim( cIdMageOrc ) + " ], não precisa ser processado... Status [ " + cStatusOrc + " ]."
				U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
				fGrvResult(.T.,cDescri,"IGNORAR")
				(CALIASUNI)->(DbSkip())
				Loop
			EndIf


			//Verifica se o pedido já existe no P12
			nRecNoSL1 := 0
			nRecNoSL1 := FJaImportou( AllTrim(cIdMageOrc), cCodCliOrc)


			cA1ESTE     := fGetA1()
			aAuxTES := U_UNIVerTES( cFilOrc , cA1ESTE, "F", "3" )

			If Len( aAuxTES ) > 0
				cAuxTES := aAuxTES[01]
			EndIf
			If AllTrim( cAuxTES ) == ""
				cAuxTES := "700"
			EndIf
			cAuxCFOP := Posicione( "SF4", 01, XFilial( "SF4" ) + cAuxTES, "F4_CF" )
			fGetSZ8()


			Do Case
				Case ( ( ( AllTrim( cStatusOrc ) $ cLiberaPedido  ) .Or. ;
						( AllTrim( cStatusOrc ) $ cTransportePed ) .Or. ;
						( AllTrim( cStatusOrc ) $ cVaiParaFila   ) ) .And. ( nRecNoSL1 == 0 ) )

					If !FVerItens( cIdMageOrc, cCodCliOrc, cLojCliOrc, cNumOrc, @aItensOrc, cVendOrc, @nAuxTotTabela, cAuxTES, cAuxCFOP )
						If "Erro ao tentar executar o Método" $ cDescri
							fGrvResult(.F.,cDescri,"")
						Else
							fGrvResult(.F.,cDescri,"IGNORAR")
						EndIf
						U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
						(cAliasUNI)->(DbSkip())
						Loop
					else
						nVlrProdutos := ( nValTotOrc + nDesconOrc - nVlFretOrc )
						nAuxMoeda			:= 1
						nAuxTxMoeda			:= 0
						If nDesconOrc > 0
							nAuxPercDesc := Round( ( ( nDesconOrc / nValTotOrc ) * 100 ), 02 )
						EndIf
						cNumOrc :=  GetSXENum( "SL1", "L1_NUM" )
						ConOut( "	TOTAL 	 - "  + AllTrim( Str( nValTotOrc    ) ) )
						ConOut( "	TOTAL TABELA PREÇOS	 - "  + AllTrim( Str( nAuxTotTabela  ) ) )
						ConOut( "	TOTAL PRODUTOS - " + AllTrim( Str( nVlrProdutos ) ) )
						ConOut( "	DESCONTO - "  + AllTrim( Str( nDesconOrc ) ) )
						ConOut( "	FRETE 	 - "  + AllTrim( Str( nVlFretOrc    ) ) )
						//Tabela - SLQ – Cabeçalho do Orçamento
						aCabecOrc  		:= { 	{ "LQ_VEND" 	, cVendOrc		    , Nil } ,;
							{ "LQ_VEND2"	, cVend2Orc				, Nil } ,;//INCLUÝDO VENDEDOR PARCEIRO Guilherme Moraes em 07/04/2020
							{ "LQ_FILIAL"   , XFilial("SLQ")		  	, Nil } ,;
							{ "LQ_COMIS"	, 0 					, Nil } ,;
							{ "LQ_CLIENTE"  , PADR(Alltrim(cCodCliOrc),TAMSX3("A1_COD")[1])		    , Nil } ,;
							{ "LQ_LOJA"   	, PADR(Alltrim(cLojCliOrc),TAMSX3("LQ_LOJA")[1]) 			, Nil } ,;
							{ "LQ_NUM"		, cNumOrc	  		, Nil } ,;
							{ "LQ_TIPOCLI"  , cTipoCliOrc		    , Nil } ,;
							{ "LQ_VLRTOT"   , nValTotOrc  	        , Nil } ,; //( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,; //					, Nil
							{ "LQ_DESCNF"   , 0         , Nil } ,;
							{ "LQ_DESCONT"  , nDesconOrc            , Nil } ,;
							{ "LQ_VLRLIQ"  	, nValMercOrc + nVlFretOrc  + nJurosOrc - nDesconOrc       , Nil } ,; // ( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,;
							{ "LQ_VALBRUT"  , nValMercOrc + nVlFretOrc  + nJurosOrc - nDesconOrc        , Nil } ,; //( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,; //					, Nil
							{ "LQ_VALMERC"  , nValMercOrc		    , Nil } ,; //( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,; //					, Nil
							{ "LQ_DTLIM"   	, Date()			    , Nil } ,; // dAuxDtCreate
							{ "LQ_FRETE"    , nVlFretOrc		    , Nil } ,;
							{ "LQ_TPFRET"	, "C"					, Nil } ,;
							{ "LQ_EMISSAO"  , Date()    			, Nil } ,; //dDataBase
							{ "LQ_NROPCLI" 	, " "          			, Nil } ,;
							{ "LQ_NUMMOV" 	, "1 "					, Nil } ,;
							{ "LQ_TIPO" 	, "V"					, Nil } ,;
							{ "LQ_IMPRIME" 	, "1S"					, Nil } ,;
							{ "LQ_OPERACA" 	, "C"					, Nil } ,;
							{ "LQ_STATUS" 	, "F"					, Nil } ,;
							{ "LQ_TPORC" 	, "E"					, Nil } ,;
							{ "LQ_STBATCH" 	, "1"					, Nil } ,;
							{ "LQ_SITUA" 	, "  "					, Nil } ,;
							{ "LQ_PARCELA"	, Val(cParcelaOrc)		, Nil } ,;
							{ "LQ_INDPRES"	, "1"					, Nil } ,;
							{ "LQ_TRANSP"	, cTranspOrc			, Nil } ,;
							{ "AUTRESERVA" 	, cAutResOrc		    , Nil }  }
						//Cabeçalho do ormaçamento montado

						//Montando SL4
						DbSelectArea( "SA1" )
						aPgtoOrc 	:= {}
						aAuxCond 	:= Condicao( nValorTotal, AllTrim(cCondPgOrc), 0, Date() )
						For nX := 01 To Len( aAuxCond )

							ConOut( "	- UNIWS01B - CONDICAO - " + StrZero( nX, 02 ) + " - Data " + DToC( aAuxCond[nX][01] ) + " - Valor : " + TransForm( aAuxCond[nX][02], "@E 999,999,999.99" ) )
							aAuxPgtoOrc := { 	{ 	 "L4_NUM"		, cNumOrc	        , Nil  }, ;
								{ 	 "L4_FILIAL"	, XFilial( "SL4" )          , Nil  }, ;
								{	 "L4_DATA"		, aAuxCond[nX][01]	, Nil  }, ;
								{    "L4_VALOR"		, aAuxCond[nX][02]	, Nil  }, ;
								{    "L4_FORMA"		, PADR(cFormaPgOrc,TAMSX3("E4_FORMA")[1])	    , Nil  }, ;
								{	 "L4_ADMINIS" 	, AllTrim(cCAdmOrc)      	, Nil  }, ;
								{	 "L4_FORMAID" 	, " "	 			, Nil  }, ;
								{    "L4_MOEDA"		, 0					, Nil  }, ;
								{    "L4_SITUA"		, "  "				, Nil  }, ;
								{    "L4_TERCEIR"	, "F"				, Nil  }, ;
								{    "L4_NSUTEF"	, cNsuOrc				, Nil  }, ;
								{    "L4_XIDMAGE" 	, cMethodOrc     	, Nil  }  }

							aAdd( aPgtoOrc, aClone( aAuxPgtoOrc ) )

						Next nX


						cUsrLogin  		:= cUsrCaixa
						cUsrPass  		:= cPassCaixa
						cSerMagento		:= cWsSerieMg
						cNumOrig		:= FGetNextNum( cSerMagento )

						cAuxEstacao 	:= "001"
						cAuxPDV	     	:= "0001"
						cAuxOperador	:= AllTrim( SZ8->Z8_OPERADO )

						cAuxSituacao	:= "  "
						nAuxParcela     := Iif( Len( aPgtoOrc ) > 0, Len( aPgtoOrc ), 1 )


						DbSelectArea( "SLQ" )
						DbSelectArea( "SLR" )
						DbSelectArea( "SLR" )
						DbSelectArea( "SL1" )
						DbSelectArea( "SL2" )
						DbSelectArea( "SL4" )
						DbSelectArea( "DA0" )
						DbSelectArea( "DA1" )
						DbSelectArea( "SX2" )
						DbSelectArea( "SX3" )
						DbSelectArea( "SIX" )
						DbSelectArea( "SX7" )
						DbSelectArea( "SXB" )
						DbSelectArea( "SX6" )

						aAutoCab		:= {}
						lPOSLJAUTO      := .T.
						lMsErroAuto 	:= .F.
						lMsHelpAuto 	:= .F.
						SetFunName( "LOJA701" )

						Inclui  		:= .T.
						Altera  		:= .F.
						lAuxAuto 		:= .T.
						lAutoExec		:= .T.

						If lSchedule
							cAuxMsgErro := StartJob( "U_FGERA3ORC", GetEnvServer(), .T., cEmpAnt, cFilOrc, .F., cUsrLogin, cUsrPass, aCabecOrc, aItensOrc, aPgtoOrc, 03, cCodCliOrc, PADR(Alltrim(cLojCliOrc),TAMSX3("A1_LOJA")[1]), .F., lSchedule )
						Else
							cAuxMsgErro := U_FGERA3ORC( cEmpAnt, cFilOrc, lSchedule, cUsrLogin, cUsrPass, aCabecOrc, aItensOrc, aPgtoOrc, 03, cCodCliOrc, PADR(Alltrim(cLojCliOrc),TAMSX3("A1_LOJA")[1]) , .F., lSchedule )
						EndIf

						If AllTrim( cAuxMsgErro ) != ""

							cMsgErro  := "Erro ao tentar Incluir o Orçamento de Vendas no Protheus. "
							cMsgCompl := "Erro ao tentar Incluir o Orçamento de Vendas no Protheus. " + cAuxMsgErro
							cDescri := cMsgCompl
							U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
							fGrvResult(.F.,cDescri,"")
							ConOut( "ETAPA 14.1" )
							//RollBackSXE()
							lSucesso := .F.
							If !lSchedule
								Aviso( "Atenção", cMsgErro, { "Continuar" } )
								If AllTrim( cAuxMsgErro ) != ""
									Aviso( "Atenção", "Erro: " + cAuxMsgErro, { "Continuar" } )
								EndIf
							Else
								ConOut( "	UNIWS01B - FIntegra - " + cMsgCompl )
							EndIf
							(CALIASUNI)->(DbSkip())
							Loop
						Else
							// Grava o Id do pedido no Fluig e Situação = "RX"
							DbSelectArea( "SL1" )
							DbSetOrder( 01 ) // L1_FILIAL + L1_NUM
							DbGoTop()
							If DbSeek(cFilOrc + cNumOrc)
								// Pontera no Cadastro do Cliente
								DbSelectArea( "SA1" )
								DbSetOrder( 01 ) // A1_FILIAL + A1_COD + A1_LOJA
								Seek XFilial( "SA1" ) + AllTrim(cCodCliOrc) + AllTrim(cLojCliOrc)

								DbSelectArea( "SL1" )
								RecLock( "SL1", .F. )

								SL1->L1_XIDMAGE := cIdMageOrc
								SL1->L1_ESTACAO := cAuxEstacao
								SL1->L1_PDV     := "" // cAuxPDV Marcelo Amaral 29/11/2019
								SL1->L1_OPERADO := cAuxOperador
								SL1->L1_NUMORIG := cNumOrig 	// pegar da sx5 tabela 01-mag
								SL1->L1_PARCELA := nAuxParcela  // Condição de Pagamento
								SL1->L1_DOCPED	:= cNumOrig 	// pegar da sx5 tabela 01-mag
								SL1->L1_SERPED	:= cSerMagento
								SL1->L1_SITUA	:= cAuxSituacao // "RX"
								SL1->L1_TIPO 	:= "P" // "V"  	// Venda , Dev, Troca Marcelo Amaral 29/11/2019
								SL1->L1_IMPRIME := "1S" 	//
								SL1->L1_OPERACA := "C"  	//
								SL1->L1_STATUS  := "" // "F"  	// Finalizado | Cancelado... Marcelo Amaral 29/11/2019
								SL1->L1_TPORC 	:= "E"  	//
								SL1->L1_STBATCH := "1"  	//
								SL1->L1_TREFETI	:= .F.  	//
								//SL1->L1_TRANSP 	:= _c_WsTranspMagento //AllTrim( GetNewPar( "MV_XTRAMAG", "000002" ) )
								//Lucas Miranda de Aguiar - 15/05/2020
								SL1->L1_TRANSP  := cTranspOrc
								//Fim
								SL1->L1_CONDPG  := cCondPgOrc

								SL1->L1_VEND2	:= cVend2Orc //Guilherme Moraes 10/04/2020

								//Marcelo Amaral 29/11/2019
								SL1->L1_DOC  	:= ""
								SL1->L1_SERIE 	:= ""
								SL1->L1_FILRES 	:= ""
								SL1->L1_ORCRES 	:= ""
								SL1->L1_PEDRES 	:= ""
								SL1->L1_SDOC  	:= ""

								// By RGR
								SL1->L1_VLRTOT	:= nValTotOrc
								SL1->L1_VALBRUT := nValBrutOrc
								SL1->L1_VALMERC := nValMercOrc
								SL1->L1_VLRLIQ	:= nValLiqOrc
								SL1->L1_DESCONT	:= nDesconOrc
								SL1->L1_DESCNF  := nDescFinOrc
								SL1->L1_FRETE  	:= nVlFretOrc
								SL1->L1_TPFRET  := "C"

								SL1->L1_ENDCOB  := SA1->A1_END
								SL1->L1_BAIRROC := SA1->A1_BAIRRO
								SL1->L1_CEPC 	:= SA1->A1_CEP
								SL1->L1_MUNC    := SA1->A1_COD_MUN
								SL1->L1_ESTC 	:= SA1->A1_EST

								SL1->L1_ENDENT  := SA1->A1_ENDENT
								SL1->L1_BAIRROE := SA1->A1_BAIRROE
								SL1->L1_CEPE 	:= SA1->A1_CEPE
								SL1->L1_MUNE    := SA1->A1_CODMUNE
								SL1->L1_ESTE	:= SA1->A1_ESTE

								SL1->L1_XCODSZ8 := cCodInstanc
								SL1->L1_INDPRES := "1"

								//Lucas Miranda de Aguiar 11/06/2020
								SL1->L1_XPEDMKT	:= cPedMKtOrc

								SL1->( MsUnLock() )

								If Len( aItensOrc ) > 0
									nPosProd  := aScan( aItensOrc[01], { |x| AllTrim( x[01] ) == "L2_PRODUTO" } )
									nPosVUnit := aScan( aItensOrc[01], { |x| AllTrim( x[01] ) == "L2_VRUNIT"  } )
									nPosVItem := aScan( aItensOrc[01], { |x| AllTrim( x[01] ) == "L2_VLRITEM" } )
								Else
									nPosProd  := 0
									nPosVUnit := 0
									nPosVItem := 0
								EndIf

								If nPosProd  > 0

									cAuxCFOP := Posicione( "SF4", 01, XFilial( "SF4" ) + cAuxTES, "F4_CF" )
									DbSelectArea( "SL2" )
									DbSetOrder( 02 )  // L2_FILIAL+L2_NUM+L2_ITEM+L2_PRODUTO
									For nR := 01 To Len( aItensOrc )

										DbSelectArea( "SL2" )
										Seek SL1->( L1_FILIAL + L1_NUM ) + StrZero( nR, 02 ) + aItensOrc[nR][nPosProd][02]
										If Found()

											RecLock( "SL2", .F. )

											SL2->L2_VRUNIT 	:= aItensOrc[nR][nPosVUnit][02]
											SL2->L2_VLRITEM := ( aItensOrc[nR][nPosVUnit][02] * SL2->L2_QUANT )
											SL2->L2_PRCTAB  := aItensOrc[nR][nPosVUnit][02]

											SL2->L2_DESCRI  := SB1->B1_DESC
											SL2->L2_EMISSAO := Date()

											SL2->L2_SITUA	:= cAuxSituacao
											SL2->L2_NUMORIG := cNumOrig
											SL2->L2_PDV     := cAuxPDV
											SL2->L2_ORIGEM  := SB1->B1_ORIGEM
											SL2->L2_MODBC   := "3"
											SL2->L2_VLTROCA := " "
											SL2->L2_ENTREGA := "3"
											SL2->L2_TES 	:= cAuxTES
											SL2->L2_CF      := cAuxCFOP

											SL2->( MsUnLock() )

										EndIf

									Next nR

								EndIf

								DbSelectArea( "SL4" )
								DbSetOrder( 01 ) // L4_FILIAL + L4_NUM
								Seek SL1->( L1_FILIAL + L1_NUM )
								Do While !SL4->( Eof() ) .And. ;
										SL4->( L4_FILIAL + L4_NUM ) == SL1->( L1_FILIAL + L1_NUM )

									RecLock( "SL4", .F. )
									SL4->L4_SITUA	:= cAuxSituacao
									SL4->L4_XIDMAGE	:= cIdMageOrc
									SL4->L4_ADMINIS := cCAdmOrc
									//If(_lPag)

									If AllTrim(cOrigemOrc)	== "PAG01"					// ---- LEANDRO RIBEIRO ---- 02/01/2020 ---- //
										SL4->L4_FORMA := ""	          	// ---- LEANDRO RIBEIRO ---- 02/01/2020 ---- //
									EndIf     							// ---- LEANDRO RIBEIRO ---- 02/01/2020 ---- //
									SL4->( MsUnLock() )
									SL4->( DbSkip() )
								EndDo

								//Ultima verificação, se o ID Magento foi gravado na SL1
								//lGravouL1 := fVerificaSl1()

								//If !lGravouL1
								//  lRollBack := .T.
								//cMsgErro  := "Pedido de Vendas [ " + cIdMageOrc + " ] não foi gravado na tabela SL1 do orçamento [ " + cNumOrc + " ]."
								//cMsgCompl := cMsgErro
								//cDescri := cMsgCompl
								//fGrvResult(.T.,cDescri)
								//U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"",cNumOrc,cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
								//EndIf

								//  If lRollBack
								fExcPed()
								// Else
								lSucesso  := .T.
								cMsgErro  := "Pedido de Vendas [ " + cIdMageOrc + " ] importado com sucesso. Orçamento gerado [ " + cNumOrc + " ]."
								cMsgCompl := cMsgErro
								cDescri := cMsgCompl
								fGrvResult(.T.,cDescri)
								U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"",cNumOrc,cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
								//EndIf
								If AllTrim(cStatusOrc) == "pagamento_confirmado"
									nRecNoSL1 := FJaImportou( AllTrim(cIdMageOrc), cCodCliOrc)
									fLibPed()
								EndIf
							Else
								cMsgErro  := "Erro ao tentar Incluir o Orçamento de Vendas no Protheus. "
								cMsgCompl := "Erro ao tentar Incluir o Orçamento de Vendas no Protheus. Erro não identificado."
								cDescri := cMsgCompl
								fGrvResult(.F.,cDescri,"")
								U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
								ConOut( "	- UNIWS01B - " + cMsgCompl )
								//RollBackSXE()
								lSucesso 	 := .F.
								(CALIASUNI)->(DbSkip())
								Loop
							EndIf
						EndIf
					EndIf
				Case ( AllTrim( cStatusOrc ) $ cExcluiPedido )
					lRetExcl := fExcPed()
					If lRetExcl
						U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"SUCESSO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
						fGrvResult(.T.,cDescri,)
					Else
						U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"ERRO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
						fGrvResult(.F.,cDescri,"IGNORAR")
					EndIf
					(CALIASUNI)->(DbSkip())
					Loop
				Case ( AllTrim( cStatusOrc ) $ cLiberaPedido )
					lRetLib := fLibPed()
					If lRetLib
						U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"SUCESSO",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
						fGrvResult(.T.,cDescri,"")
					Else
						U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"IGNORAR",cDescri,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
						fGrvResult(.F.,cDescri,"IGNORAR")
					EndIf
					(CALIASUNI)->(DbSkip())
					Loop
				Otherwise
					If nRecNoSL1 > 0

						DbSelectArea( "SL1" )
						SL1->( DbGoTo( nRecNoSL1 ) )
						cMsgErro  := "Pedido  [ " + AllTrim( cIdMageOrc ) + " ] já importado e Status [ " + cStatusOrc + " ] nao pede nenhuma ação. O mesmo no ser processado."
						cMsgCompl := cMsgErro
						ConOut( "	UNIWS001 - FIntegra - " + cMsgErro )
						cDescri := cMsgCompl
						DbSelectArea( "SL1" )
						cNumOrc := SL1->L1_NUM
						U_UNIWSLOG(AllTrim(cFilOrc),"MAGENTO",cIdMageOrc,"","",cCodCliOrc,cStatusOrc,"ERRO",cMsgCompl,"UNIWS01B",cXidTblUNI,cWSDLOrc,"")
						fGrvResult(.T.,cDescri,"")
						(CALIASUNI)->(DbSkip())
						Loop
					EndIf
			Endcase
			(CALIASUNI)->(DbSkip())
		End
	else
		Conout("Não existem pedidos para serem integrados.")
	EndIf
	RestArea(aArea)
Return

Static Function fGetA1()

	Local aArea := GetArea()
	Local cAliasSA1 := GetNextAlias()
	Local cQuery := ""
	Local cRetCli := ""

	cQuery := "		SELECT A1_ESTE "
	cQuery += "		  FROM " + RetSQLName( "SA1" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND A1_CGC = '"+AllTrim(cCGCCliOrc)+"'"
	If Select( cAliasSA1 ) > 0
		( cAliasSA1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSA1 ) New
	If !( cAliasSA1 )->( Eof() )
		cRetCli := (cAliasSA1)->A1_ESTE
	EndIf
	( cAliasSA1 )->( DbCloseArea() )

	RestArea(aArea)

Return cRetCli



*----------------------------------------------------------------------------------------------------------------------------------------------*
Static Function FVerItens( cParamIdPV, cParamCodCliente, cParamLojCliente, cParamNum, aParamItens, cParamVendedor, nParamTotal, cParamTES, cParamCFOP )
	*----------------------------------------------------------------------------------------------------------------------------------------------*
	Local aParamItens 	:= {}
	Local lRetA 		:= .T.

	Local nPosCodigo 	:= 01
	Local nPosDescric   := 02
	Local nPosQtdItens  := 03
	Local nPosPercDist  := 04
	Local oWS := NIL
	Local lPvInfo  := .F.
	Local nValDivid := 0


	DbSelectArea( "SZ8" )
	DbSetOrder( 01 )
	Seek XFilial( "SZ8" ) + cOrigemOrc
	Public _c_WsCodInstancia := Alltrim( SZ8->Z8_CODIGO  )
	Public _c_WsLnkMagento   := AllTrim( SZ8->Z8_API     ) //cParamWSDL //"https://www.qualitebrasil.com.br/index.php/api/v2_soap/"
	Public _c_WsUserMagento  := AllTrim( SZ8->Z8_LOGIN   ) //"https://www.qualitebrasil.com.br/index.php/api/v2_soap/"
	Public _c_WsPassMagento  := AllTrim( SZ8->Z8_SENHA   ) //"https://www.qualitebrasil.com.br/index.php/api/v2_soap/"
	Public _c_WsEmpFilEstoque:= AllTrim( SZ8->Z8_FILEST  ) //
	Public _c_WsUserCaixa 	 := AllTrim( SZ8->Z8_USRCX   )
	Public _c_WsPassCaixa 	 := AllTrim( SZ8->Z8_PSSCX   )
	Public _c_WsVendedorMagen:= AllTrim( SZ8->Z8_VEND    )
	Public _c_WsTabelaMagento:= AllTrim( SZ8->Z8_TABELA  )
	Public _c_WsSerieMagento := AllTrim( SZ8->Z8_SERIE   )
	Public _c_WsTranspMagento:= AllTrim( SZ8->Z8_TRANSP  )
	Public _c_WsOperador 	 := AllTrim( SZ8->Z8_OPERADO )
	Public _c_WsAutReserva 	 := AllTrim( SZ8->Z8_AUTRESE )
	Public _c_WsEstacao	 	 := "001" // AllTrim( SZ8->Z8_ESTACAO)
	Public _c_WsPDV		 	 := "0001" // AllTrim( SZ8->Z8_PDV	)

	oWS 		 	:= WSMagentoService():New()
	oWs:cUserName	:= _c_WsUserMagento // AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
	oWs:cApiKey		:= _c_WsPassMagento // AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação
	Conout("Login API  " + _c_WsLnkMagento + " " + TIME())
	If oWs:Login()
		oWs:cSessionId := oWs:cloginReturn

		nParamDesconto	:= 0
		nParamTotal		:= 0

		aParamItens := {}
		nTamItem 	:= TamSX3( "LR_ITEM" )[01]
		lPvInfo := FRetPVInfo( cIdMageOrc, @oWS, lSchedule )
		If lPvInfo
			For nI := 01 To Len( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity )

				// Verifica se Existe o Produto cadastrado
				cAuxSKU	  := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cSKU
				ConOut( "	UNIWS001 - FIntegra - Analizando Item " + cAuxSKU )
				nRecNoSB1 := FExistProduto( cAuxSKU )
				If nRecNoSB1 > 0

					DbSelectArea( "SB1" )
					SB1->( DbGoTo( nRecNoSB1 ) )
					ConOut( "	UNIWS001 - FIntegra - Encontrou o Item " + cAuxSKU + " - " + SB1->B1_DESC )

					nAuxQtd := Val( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cQty_ordered )

					//Verifica se Possui o Saldo em Estoque
					If !FVerSaldo( SB1->B1_TIPO, SB1->B1_COD, nAuxQtd )

						If lSchedule

							cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
							cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou saldo em estoque suficiente para o Produto [ " + SB1->B1_COD + " ]."
							cDescri := cMsgCompl
						Else

							Aviso( "Atenção", "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou saldo em estoque suficiente para o Produto [ " + SB1->B1_COD + " ].", { "Sair" } )
							cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
							cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou saldo em estoque suficiente para o Produto [ " + SB1->B1_COD + " ]."
							cDescri := cMsgCompl
						EndIf
						lRetA := .F.
						Exit

					EndIf

					nAuxPrcTab      := U_UNIRetPreco( SB1->B1_COD, _c_WsTabelaMagento, PadR( Left( AllTrim( cFilAnt ), 02 ), TamSX3( "DA1_FILIAL" )[01] ) )
					ConOut( "	UNIWS001 - FIntegra - Totalizando os Preços de Tabela para tratativa do desconto - [ " + AllTrim( SB1->B1_COD ) + " ] - [ " + TransForm( nAuxPrcTab, "@E 999,999,999.99" ) + " ]." )
					If nAuxPrcTab <= 0

						If lSchedule

							cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
							cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou Preço de Tabela para o Produto [ " + SB1->B1_COD + " ] - Filial: [ " + Left( AllTrim( cFilAnt ), 02 ) + " ] - Tabela [ " + _c_WsTabelaMagento + " ]."
							cDescri := cMsgCompl

						Else

							Aviso( "Atenção", "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou Preço de Tabela para o Produto [ " + SB1->B1_COD + " ] - Filial: [ " + Left( AllTrim( cFilAnt ), 02 ) + " ] - Tabela [ " + _c_WsTabelaMagento + " ].", { "Sair" } )
							cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
							cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou Preço de Tabela para o Produto [ " + SB1->B1_COD + " ] - Filial: [ " + Left( AllTrim( cFilAnt ), 02 ) + " ] - Tabela [ " + _c_WsTabelaMagento + " ]."
							cDescri := cMsgCompl

						EndIf
						lRetA := .F.
						Exit

					EndIf

					nParamTotal		+= ( nAuxPrcTab * nAuxQtd )
					If AllTrim( SB1->B1_TIPO ) == "PA"

						// Desmonta a OP e o Kit caso o produto seja de um desses tipos
						aArea2Ant := SB1->( GetArea() )
						//nAuxQtd := ( aRetComponentes[nC][nPosQtdItens] * Val( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:qty_ordered ) )
						//If !FDesmontaOP( SB1->B1_COD, nAuxQtd, cParamIdPV )
						cMsgCompl	:= ""
						If !U_UNIDesmontaOP( SB1->B1_COD, nAuxQtd, @cMsgCompl )
							cMsgErro := "Não conseguiu realizar a desmontagem da OP para o Pedido [ " + cParamIdPV + " ] - Produto [ " + SB1->B1_COD + " ]."
							cDescri := cMsgCompl

							lRetA := .F.
							Exit
						EndIf
						RestArea( aArea2Ant )
						ConOut( "	UNIWS001 - FIntegra - Produto Desmontado. Ok" )

					Else

						ConOut( "	UNIWS001 - FIntegra - Produto do Tipo [ " + SB1->B1_TIPO + " ] não precisara de Desmontagem." )

					EndIf

					// 1- Código do Componente
					// 2- Local Padrão
					// 3- Descrição do Componente
					// 4- Quantidade para a composição do Kit
					// 5- Percentual de distribuição para o Item

					ConOut( "	UNIWS001 - FIntegra - Vai pegar os Componentes do PA / Kit / Mercadoria" )
					//aRetComponentes := FRetComponentes( SB1->B1_COD )
					cMsgCompl		:= ""
					aRetComponentes := {}
					If U_UNIRComponentes( SB1->B1_COD, @aRetComponentes, @cMsgCompl )
						nValDivid := nJurosOrc/Len(aRetComponentes)
						If Len( aRetComponentes ) >= 01

							For nC := 01 To Len( aRetComponentes )

								DbSelectArea( "SB1" )
								DbSetOrder( 01 ) // B1_FILIAL+B1_COD
								Seek XFilial( "SB1" ) + aRetComponentes[nC][01]
								If Found()


									nAuxPreco	 	:= ( Val( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cPrice ) ) * ( aRetComponentes[nC][05] / 100 )

									nAuxDesc    	:= Val( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cdiscount_amount ) * ( aRetComponentes[nC][05] / 100 ) //cDiscount_Percent ) //) / 100 ) *  nAuxPreco )
									If  oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cWeight != Nil
										nAuxPeso		:= Val( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cWeight )
									Else
										nAuxPeso		:= 0
									EndIf

									cAuxIdProd		:= oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cItem_Id
									nAuxQtd			:= ( nAuxQtd * aRetComponentes[nC][04] )
									nAuxPrcUnit		:= nAuxPreco + nValDivid
									nAuxPrcFinal	:= ( nAuxPreco * nAuxQtd ) //* ( aRetComponentes[nC][05] / 100 )


									_nTotItem := (nAuxPrcUnit*nAuxQtd)+nAuxDesc
									fGrvSB0(SB1->B1_COD,_nTotItem,Date())  // ---- LEANDRO RIBEIRO ---- 27/11/2019 ---- //

									aAuxItem := {}
									conout("UNIWS001")
									aAdd( aAuxItem, { "LR_NUM"	  	, cParamNum					, Nil } )
									conout("LR_NUM "+cParamNum)
									aAdd( aAuxItem, { "LR_ITEM"		, StrZero( nC, 02 ) 		, Nil } )
									aAdd( aAuxItem, { "LR_PRODUTO"	, SB1->B1_COD			   	, Nil } )
									conout("LR_PRODUTO "+SB1->B1_COD)
									aAdd( aAuxItem, { "LR_DESCRI"	, AllTrim(SB1->B1_DESC)		, Nil } )
									aAdd( aAuxItem, { "LR_QUANT"  	, nAuxQtd					, Nil } )
									conout("LR_QUANT "+cValToChar(nAuxQtd))
									aAdd( aAuxItem, { "LR_UM" 	  	, SB1->B1_UM			   	, Nil } )
									conout("LR_UM "+SB1->B1_UM)
									conout("LR_VRUNIT "+cValToChar(nAuxPrcUnit - nAuxDesc))
									nAuxPerDesc := Round( ( ( nAuxDesc / nAuxPrcUnit ) * 100 ), 02 )
									aAdd( aAuxItem, { "LR_DESC"	  , nAuxPerDesc				, Nil } )
									conout("LR_DESC "+cvaltochar(nAuxPerDesc))
									aAdd( aAuxItem, { "LR_VALDESC", nAuxDesc				, Nil } )
									conout("LR_VALDESC "+cvaltochar(nAuxDesc))
									conout("LR_VLRITEM "+cvaltochar(nAuxPrcFinal - nAuxDesc))
									aAdd( aAuxItem, { "LR_PRCTAB" 	, nAuxPrcUnit			, Nil } )
									aAdd( aAuxItem, { "LR_TABELA" 	, "1"				  		, Nil } )
									aAdd( aAuxItem, { "LR_FILIAL" 	, XFilial( "SLR" )			, Nil } )
									aAdd( aAuxItem, { "LR_TES"	  	, cParamTES					, Nil } )
									aAdd( aAuxItem, { "LR_VEND"	  	, cParamVendedor			, Nil } )
									aAdd( aAuxItem, { "LR_CF"	  	, cParamCFOP				, Nil } )
									aAdd( aAuxItem, { "LR_ENTREGA"	, "3"						, Nil } )
									aAdd( aAuxItem, { "LR_SITUA"	, "  "						, Nil } )
									aAdd( aParamItens, aAuxItem )

								Else

									If lSchedule

										cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
										cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou o Produto Componente [ " + aRetComponentes[nC][01] + " ]."
										cDescri := cMsgCompl

									Else

										Aviso( "Atenção", "Erro ao tentar Integrar o Orçamento de Venda [ " + cParamIdPV + " ], Componente [ " + aRetComponentes[nC][nPosCodigo] + " ].", { "Sair" } )
										cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
										cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ] - Não encontrou o Produto Componente [ " + aRetComponentes[nC][01] + " ]."
										cDescri := cMsgCompl
									EndIf
									lRetA := .F.
									Exit

								EndIf

							Next nC

						Else

							If lSchedule

								cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
								cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ], Não conseguiu definir a Estrutura para o Produto [ " + SB1->B1_COD + " ]. "
								cDescri := cMsgCompl
							Else
								Aviso( "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ], Não conseguiu definir a Estrutiuura para o Produto [ " + SB1->B1_COD + " ]. ", { "Sair" } )
								cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
								cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ], Não conseguiu definir a Estrutura para o Produto [ " + SB1->B1_COD + " ]. "
								cDescri := cMsgCompl
							EndIf
							lRetA := .F.
							Exit

						EndIf

					Else

						If lSchedule

							cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
							cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ], Não conseguiu definir a Estrutrura para o Produto [ " + SB1->B1_COD + " ]."
							cDescri := cMsgCompl

						Else

							Aviso( "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ], Não conseguiu definir a Estrutrura para o Produto", { "Sair" } )
							cMsgErro  := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ]"
							cMsgCompl := "Erro ao tentar Integrar o Orçamento de Vendas [ " + cParamIdPV + " ], Não conseguiu definir a Estrutrura para o Produto [ " + SB1->B1_COD + " ]."
							cDescri := cMsgCompl
						EndIf
						lRetA := .F.
						Exit

					EndIf

				Else

					cMsgErro  := "Erro ao tentar Integrar o Orçamento de Venda [ " + cParamIdPV + " ], Item SKU [ " + oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cSKU + " ] não encontrado no Cadastro de Produtos."
					cMsgCompl := "Erro ao tentar Integrar o Orçamento de Venda [ " + cParamIdPV + " ], Item SKU [ " + oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cSKU + " ] não encontrado no Cadastro de Produtos."
					If lSchedule
						cDescri := cMsgCompl
					Else
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
						cDescri := cMsgCompl
					EndIf

					lRetA := .F.
					Exit

				EndIf

				If !lRetA
					Exit
				EndIf

			Next nI
		Else
			lRetA := .F.
		EndIf
	Else
		cDescri := "Erro ao logar na API do Magento"
		lRetA := .F.
	EndIf
Return lRetA

*-----------------------------------------------*
Static Function FExistProduto( cParamSKUProduto )
	*-----------------------------------------------*
	Local aAreaAnt := GetArea()
	Local nRecNoSB1:= 00
	Local cQuery   := ""
	Local cAliasSB1:= GetNextAlias()

	cQuery := "		SELECT R_E_C_N_O_  AS NUMRECSB1 "
	cQuery += "		  FROM " + RetSQLName( "SB1" )
	cQuery += " 	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += " 	   AND B1_FILIAL  = '" + XFilial( "SB1" ) + "' "
	cQuery += "		   AND B1_COD 	  = '" + cParamSKUProduto + "' "
	If Select( cAliasSB1 ) > 0
		( cAliasSB1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSB1 ) New
	If !( cAliasSB1 )->( Eof() )
		nRecNoSB1 := ( cAliasSB1 )->NUMRECSB1
		ConOut( "	UNIWS01B - FExistProduto - " + If( nRecNoSB1 > 0, "Produto encontrado. - RECNO - " + cValToChar( nRecNoSB1 ), "Produto não encontrado" ) )
	Else
		ConOut( "	UNIWS01B - FExistProduto - Produto não encontrado" )
	EndIf
	( cAliasSB1 )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return nRecNoSB1


*---------------------------------------------------------------------*
Static Function FVerSaldo( cParamTipo, cParamProduto, nParamQuantItem )
	*---------------------------------------------------------------------*
	Local aAreaAtu 			:= GetArea()
	Local aAreaSM0 			:= SM0->( GetArea() )
	//Local cEmpFilEstoque 	:= AllTrim( GetNewPar( "MV_XEMPEST", "0101,0207" ) )
	Local aListEmpresas     := {}
	Local lRetSaldo 		:= 0
	Local nY 				:= 0

	DbSelectArea( "SM0" )
	SM0->( DbGoTop() )
	Do While !SM0->( Eof() )

		If AllTrim( SM0->M0_CODFIL ) $ cFilEst
			aAdd( aListEmpresas, SM0->M0_CODFIL )
		EndIf

		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo
	RestArea( aAreaSM0 )

	nAuxSaldo := 0
	For nY := 01 To Len( aListEmpresas )
		nAuxSaldo 	+= U_UNIRetSldProd( aListEmpresas[nY], cParamTipo, cParamProduto )
	Next nY

	If ( nAuxSaldo >= nParamQuantItem )
		lRetSaldo := .T.
	Else
		lRetSaldo := .F.
	EndIf

	RestArea( aAreaAtu )

Return lRetSaldo

*----------------------------------------*
Static Function FGetNextNum( cParamSerie )
	*----------------------------------------*
	Local aAreaAntes  := GetArea()

	DbSelectArea( "SX5" )
	DbSetOrder( 01 )
	//Seek XFilial( "SX5" ) + "01" + cParamSerie
	Seek cFilAnt + "01" + cParamSerie
	If Found()

		cAuxNum := AllTrim( SX5->X5_DESCRI )
		cRetNum := Soma1( AllTrim( SX5->X5_DESCRI ) )
		RecLock( "SX5", .F. )
		SX5->X5_DESCRI	:= cRetNum
		SX5->X5_DESCSPA	:= cRetNum
		SX5->X5_DESCENG	:= cRetNum
		SX5->( MsUnLock() )

	Else

		cRetNum := "00001"
		RecLock( "SX5", .T. )
		SX5->X5_FILIAL  := cFilAnt //XFilial( "SX5" )
		SX5->X5_TABELA  := "01"
		SX5->X5_CHAVE 	:= cParamSerie
		SX5->X5_DESCRI	:= cRetNum
		SX5->X5_DESCSPA	:= cRetNum
		SX5->X5_DESCENG	:= cRetNum
		SX5->( MsUnLock() )

	EndIf
	SX5->( MsUnLock() )

	RestArea( aAreaAntes )

	ConOut( "UNIWS01B - FGETNEXTNUM - NUMERO DE SÉRIE - " +  cRetNum )

Return cRetNum


*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
User Function FGERA3ORC( cParamEmpresa, cParamFilial, lParamSchedule, cParamLogin, cParamSenha, aParamCabecalho, aParamItens, aParamCondicoes, nParamOpc, cParamCliente, cParamLoja, lEhEcommerce, lRunAsJob )
	*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local cRetMostraErro := ""
	Local oError    	 := ErrorBlock( { |e| ConOut( "Erro durante o Execauto Loja701 " + MostraErro( "-", "-" ) ) } )
	Local lErro			 := .F.

	Private lMsErroAuto  := .F.
	Default lEhEcommerce := .F.
	Default lRunAsJob	 := .F.
	ConOut( "INICIO FGERA3ORC" )
	ConOut( "cParamEmpresa 	= " + cParamEmpresa )
	ConOut( "cParamFilial 	= " + cParamFilial	)
	ConOut( "cParamLogin 	= " + cParamLogin	)
	ConOut( "cParamSenha 	= " + cParamSenha 	)
	ConOut( "lParamSchedule = " + If( lParamSchedule, ".T.", ".F."  ) )
	ConOut( "nParamOpc 		= " + StrZero( nParamOpc, 02 			) )
	ConOut( "lEhEcommerce 	= " + Iif( lEhEcommerce,  ".T.", ".F."  ) )

	If lRunAsJob
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpresa,  cParamFilial,  cParamLogin, cParamSenha, "LOJ", "LOJA701", { "SLG", "SLF",  "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3", "SX6" },  .T. )
	EndIf
	aAutoCab	:= {}
	lPOSLJAUTO  := .T. //Execauto para eCommerce
	lMsErroAuto := .F.
	lMsHelpAuto := .F.
	SetFunName( "LOJA701" )

	Inclui  	:= .T.
	Altera  	:= .F.
	MsExecAuto( { | a, b, c, d, e, f, g, h | LOJA701( a, b, c, d, e, f, g, h ) }, .F., nParamOpc, cParamCliente, cParamLoja, {}, aParamCabecalho, aParamItens, aParamCondicoes, .F. )
	If lMsErroAuto
		cRetMostraErro := MostraErro( "-", "-" )
		ConOut( cRetMostraErro )
		ROLLBACKSXE()
	Else
		ConOut( "EXECAUTO LOJA701 - OK" )
		ConOut( "Verificando se o orçamento é do cliente correto" )
		lErro := fCompCli(cIdMageOrc)
		If lErro
			Conout("O Orçamento foi gravado com o cliente errado! Iniciando rollback")
			cDescri := "O Orçamento foi gravado com o cliente errado!"
			cRetMostraErro := "O Orçamento foi gravado com o cliente errado!"
			lRollBack := .T.
			nRecNoSL1 := FJaImportou( AllTrim(cIdMageOrc), cCodCliOrc)
		else
			Conout("Cliente OK!")
			Conout("Verificando se criou SL4")
			lErro := fSeekL4()
			If lErro
				Conout("Os Registros da SL4 não foram gerados, iniciando Rollback")
				cDescri := "Os Registros da SL4 não foram gerados, iniciando Rollback"
				cRetMostraErro := "Os Registros da SL4 não foram gerados, iniciando Rollback"
				lRollBack := .T.
				nRecNoSL1 := FJaImportou( AllTrim(cIdMageOrc), cCodCliOrc)
			else
				Conout("SL4 OK")
				ConfirmSXE()
			EndIf
		EndIf
	EndIf



	If lRunAsJob
		RPCClearEnv()
	EndIf

	ErrorBlock( oError )

Return cRetMostraErro

Static Function fCompCli(cAuxIdPedido)

	Local aArea 	:= GetArea()
	Local cAliasUNI := GetNextAlias()
	Local cQuery 	:= ""
	Local lErro 	:= .T.
	Local cCGCUNI	:= ""
	Local cCGCSL1	:= ""

	Default cAuxIdPedido := ""

	cQuery := "		 SELECT UNI_CODCLI, L1_CLIENTE 												"
	cQuery += "		 FROM " + RetSQLName( "UNI" ) + " UNI" + "," + RetSqlName("SL1") + " L1		"
	cQuery += "		 WHERE UNI.D_E_L_E_T_ = ' ' 												"
	cQuery += "		 AND L1.D_E_L_E_T_ = ' ' 													"
	cQuery += "      AND UNI.UNI_FILIAL = '" +cFilOrc + "'"
	cQuery += "      AND L1.L1_FILIAL 	= '" +cFilOrc + "'"
	cQuery += "		 AND UNI.UNI_IDMAG = '"+AllTrim(cAuxIdPedido)+"'"
	cQuery += "		 AND L1.L1_NUM = '"+cNumOrc+"'"

	If Select( cAliasUNI ) > 0
		( cAliasUNI )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasUNI ) New
	If !( cAliasUNI )->( Eof() )
		cCGCUNI := ( cAliasUNI )->UNI_CODCLI
		cCGCSL1 := ( cAliasUNI )->L1_CLIENTE
	EndIf
	( cAliasUNI )->( DbCloseArea() )

	If AllTrim(cCGCUNI)  == AllTrim(cCGCSL1)
		lErro := .F.
	EndIf
	RestArea(aArea)
Return lErro

Static Function fSeekL4()

	Local aArea 	:= GetArea()
	Local cAliasSL4 := GetNextAlias()
	Local cQuery 	:= ""
	Local lErro 	:= .T.


	Default cNumero := ""

	cQuery := "		 SELECT *											                    	"
	cQuery += "		 FROM " + RetSQLName( "SL4" )                                       		"
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' 												"
	cQuery += "      AND L4_FILIAL = '" +cFilOrc+ "'"
	cQuery += "      AND L4_NUM 	= '" +cNumOrc+ "'"


	If Select( cAliasSL4 ) > 0
		( cAliasSL4 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSL4 ) New
	If !( cAliasSL4 )->( Eof() )
		lErro := .F.
	EndIf
	( cAliasSL4 )->( DbCloseArea() )

	RestArea(aArea)

Return lErro


Static Function fGrvResult(lOk,cDescri,cIgnora)

	Local aArea 	:= GetArea()
	Local cIntegP12	:= ""
	Local cAliasUN  := GetNextAlias()
	Local nRetRecNo := 0
	Local cUpdate   := ""

	Private cFLAGREP   := ""

	Default lOk := .T.
	Default cDescri := ""
	Default cIgnora := ""

	If lOk
		cIntegP12 := "SUCESSO"
	else
		If AllTrim(cIgnora) == ""
			cIntegP12 := "ERRO"
			If "nao pede nenhuma ação. O mesmo no ser processado." $ cdescri
			Else
				cNumOrc := ""
			EndIf
			ROLLBACKSXE()
		else
			cIntegP12 := "IGNORAR"
			If cStatusOrc != "pagamento_confirmado"
				cNumOrc := ""
			EndIf
			//ROLLBACKSXE()
		EndIf
	EndIf


	DbSelectArea("UNI")
	DbSetOrder(2)
	UNI->(DbSeek(xFilial("UNI") + AllTrim(cXidTblUNI)))

	If AllTrim(cFLGREP) == ""
		cFLAGREP := "1"
	ElseIf cFLGREP == "1"
		cFLAGREP := "2"
	ElseIf cFLGREP == "2"
		cFLAGREP := "3"
	ElseIf  cFLGREP == "3"
		cFLAGREP := "4"
	EndIf
	/*/  RecLock( "UNI", .F. )
	UNI->UNI_INTEG  := cIntegP12
	UNI->UNI_ERRO	:= cDescri
	UNI->UNI_NUM    := cNumOrc
	UNI->UNI_FLGREP := cFLGREP
	MsUnlock()/*/

	cUpdate := "	UPDATE " + RetSQLName( "UNI" )
	cUpdate += " 	   SET UNI_INTEG 	= '" + AllTrim(cIntegP12) + "' "
	cUpdate += ", UNI_ERRO 	= '" + AllTrim(cDescri) + "' "
	cUpdate += ", UNI_NUM 	= '" + AllTrim(cNumOrc) + "' "
	cUpdate += ", UNI_FLGREP 	= '" + AllTrim(cFLAGREP) + "' "
	cUpdate += "	 WHERE D_E_L_E_T_ 	= ' ' AND "
	cUpdate += "	 UNI_XID =  '"+AllTrim(cXidTblUNI)+"'"
	If TcSQLExec( cUpdate ) != 0
		Conout("Erro ao tentar atualizar a tabela uni010" + CRLF + TcSQLError())
	EndIf

	RestArea(aArea)
Return

Static Function fExcPed()

	Local lRetexc := .T.
	// Precisa estornar o Orçamento de Venda

	If nRecNoSL1 > 0
		DbSelectArea( "SL1" )
		SL1->( DbGoTo( nRecNoSL1 ) )
		cNumOrc := SL1->L1_NUM
		If AllTrim( SL1->L1_SITUA ) != ""

			cMsgErro  := "Não foi possível Estornar o Orçamento com Id [ " + AllTrim(cIdMageOrc) + " ], o mesmo possui alteração de Status."
			cMsgCompl := cMsgErro
			ConOut( "	UNIWS01B - " + cMsgErro )
			cDescri := cMsgErro
			lRetexc := .F.
		else
			ConOut( "UNIWS01B - Realiza a Exclusão do Orçamento de Vendas" )

			DbSelectArea( "SL2" )
			DbSetOrder( 01 ) // L2_FILIAL + L2_NUM + l2_ITEM
			Seek SL1->( L1_FILIAL + L1_NUM )
			Do While !SL2->( Eof() ) .And. ;
					SL2->( L2_FILIAL + L2_NUM ) == SL1->( L1_FILIAL + L1_NUM )

				// Faz o cancelamento da reserva
				aAuxReserva	:= {}
				aAuxRetRes	:= {}
				aAuxReserva := { {	SL2->L2_RESERVA	 , ; // Numero da Reserva
					SL2->L2_LOJARES	 , ; // Codigo da Loja
					SL2->L2_PRODUTO	 , ; // Codigo do Produto
					SL2->L2_LOCAL	 , ; // Local (Armazem)
					SL2->L2_FILRES 	 , ; // Filial da Reserva
					SL2->L2_ITEM	 } }
				AHeaderDet  := {}
				aAuxRetRes	:= Lj7CancRes( aAuxReserva, lSchedule )
				lRet		:= aAuxRetRes[01][02] // O tamanho do Array de retorno é Fixo

				// Verifica se consegui realizar o Estorno da Reserva
				If !lRet
					cMsgErro  := "Não foi possível realizar o estorno da Reserva do Pedido [ " + Alltrim(cIdMageOrc) + " ]."
					cMsgCompl := cMsgErro + " - Produto [ " + SL2->L2_PRODUTO + " ]."
					ConOut( "	UNIWS01B - " + cMsgCompl )
					cDescri := cMsgCompl
					If !lSchedule
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
					Else
						ConOut( "UNIWS01B - FIntegra - " + cMsgCompl )
					EndIf
				Else
					DbSelectArea( "SL2" )
					RecLock( "SL2", .F. )
					SL2->L2_SITUA := "EX"
					DbDelete()
					SL2->( MsUnLock() )
					SL2->( DbSkip() )
				EndIf
			EndDo
			// Grava o Situação = "RX"
			DbSelectArea( "SL4" )
			DbSetOrder( 01 ) // L4_FILIAL + L4_NUM
			Seek SL1->( L1_FILIAL + L1_NUM )
			Do While !SL4->( Eof() ) .And. ;
					SL4->( L4_FILIAL + L4_NUM ) == SL1->( L1_FILIAL + L1_NUM )
				RecLock( "SL4", .F. )
				SL4->L4_SITUA := "EX" // "RX"
				DbDelete()
				SL4->( MsUnLock() )
				SL4->( DbSkip() )
			EndDo
			DbSelectArea( "SL1" )
			RecLock( "SL1", .F. )
			SL1->L1_SITUA := "EX"
			DbDelete()
			SL1->( MsUnLock() )
			cMsgErro  := "Orçamento com Id [ " + AllTrim(cIdMageOrc) + " ], estornado com sucesso."
			cMsgCompl := cMsgErro
			cDescri := cMsgCompl
			ConOut( "UNIWS01B - " + cMsgErro )
		EndIf
	Else
		cMsgErro  := "O Pedido de Vendas Id [ " + AllTrim(cIdMageOrc) + " ] está com Status [ " + AllTrim( cStatusOrc ) + " ], porém não será necessário estorno, pois o mesmo não foi encontrado na base de dados do Protheus."
		cMsgCompl := cMsgErro
		cDescri := cMsgErro
		ConOut( "	UNIWS01B - Não será necessário estornar o Orçamento com Id [ " + Alltrim(cIdMageOrc) + " ], o mesmo não existe na base de dados do Protheus." )
		lRetexc := .T.
	EndIf

Return lRetexc



Static Function FJaImportou( cParamIdPedido, cParamIdCli )

	Local aAreaOrc 	:= GetArea()
	Local cAliasOrc	:= GetNextAlias()
	Local cQuery 	:= ""
	Local nRetRecNo := 0

	lRetJaImp 	:= .F.
	cQuery 		:= "		SELECT R_E_C_N_O_ AS [NUMREC] "
	cQuery 		+= "		  FROM " + RetSQLName( "SL1" )
	cQuery 		+= "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery 		+= "		   AND L1_CLIENTE  = '" + AllTrim( cParamIdCli )	+ "' "
	cQuery 		+= "		   AND L1_XIDMAGE = '" + AllTrim( cParamIdPedido    ) + "' "
	cQuery      += " ORDER BY R_E_C_N_O_"

	If Select( cAliasOrc ) > 0
		( cAliasOrc )->( DbCloseArea() )
	EndIf
	ConOut( "	- UNIWS01B - FJaImportou - " + cQuery )
	TcQuery cQuery Alias ( cAliasOrc ) New
	If !( cAliasOrc )->( Eof() )
		nRetRecNo := ( cAliasOrc )->NUMREC
	EndIf
	( cAliasOrc )->( DbCloseArea() )

	RestArea( aAreaOrc )

Return nRetRecNo


Static Function fLibPed()

	Local aArea := GetArea()
	Local lRet  := .F.
	Local cUpdate := ""
	Local cMsgErro := ""
	Local cMsgCompl := ""

	DbSelectArea( "SL1" )
	If nRecNoSL1 != 0
		SL1->( DbGoTo( nRecNoSL1 ) )
		cNumOrc := SL1->L1_NUM
	EndIf
	If AllTrim( SL1->L1_SITUA ) == "FR"
		cMsgErro  := "Nao foi possivel Liberar o Orçamento com Id [ " + AllTrim(cIdMageOrc) + " ], o mesmo possui alteracao de Status."
		cMsgCompl := cMsgErro
		cDescri := cMsgCompl
		/*/If AllTrim( SL1->L1_SITUA ) == "FR"
		cMsgErro  := "Nao foi possivel Liberar o Orçamento com Id [ " + AllTrim(cIdMageOrc) + " ], o mesmo possui alteracao de Status."
		cMsgCompl := cMsgErro
		cDescri := cMsgCompl
		ConOut( "	UNIWS01B - " + cMsgErro )
	ElseIf AllTrim(SL1->L1_SITUA) == "ER"
		RecLock("SL1",.F.)
		SL1->L1_SITUA := ""
		MsUnLock()
		EndIf/*/
		//Lucas Miranda de Aguiar - 16/06/2020
	Else
		cUpdate := "	UPDATE " + RetSQLName( "SL4" )
		cUpdate += " 	   SET L4_NSUTEF 	= '"+cNsuOrc+"'"
		cUpdate += "	 WHERE D_E_L_E_T_ 	= ' ' AND "
		cUpdate += "	 L4_NUM =  '"+cNumOrc+"' "
		cUpdate += " AND L4_FILIAL = '"+Xfilial("SL4")+"'"
		If TcSQLExec( cUpdate ) != 0
			Conout("Erro ao tentar atualizar a tabela SL4" + CRLF + TcSQLError())
			cDescri := "Erro ao tentar atualizar a tabela SL4  " + TcSQLError()
		Else
			cUpdate := ""
			cUpdate := "	UPDATE " + RetSQLName( "SL1" )
			cUpdate += " 	   SET L1_SITUA 	= 'RX' "
			cUpdate += "	 WHERE D_E_L_E_T_ 	= ' ' AND "
			cUpdate += "	 R_E_C_N_O_ =  "
			cUpdate += "'"+cValToChar(nRecNoSL1)+"'"
			If TcSQLExec( cUpdate ) != 0
				Conout("Erro ao tentar atualizar a tabela SL1" + CRLF + TcSQLError())
				cDescri := "Erro ao tentar atualizar a tabela SL1  " + TcSQLError()
			Else
				cMsgErro  := "Orçamento com Id [ " + AllTrim(cIdMageOrc) + " ] foi Liberado com sucesso."
				cMsgCompl := cMsgErro
				cDescri := cMsgCompl
				lRet := .T.
			EndIf
		EndIf
	EndIf
	//ConOut( "UNIWS01B - " + cMsgErro )
	RestArea(aArea)
Return lRet


Static Function fGetSZ8()

	Local aArea := GetArea()
	Local cAliasZ8	:= GetNextAlias()
	Local cQuery 	:= ""
	Local nRetRecNo := 0

	cQuery 		:= "		SELECT * "
	cQuery 		+= "		  FROM " + RetSQLName( "SZ8" )
	cQuery 		+= "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery 		+= "		   AND Z8_CODIGO  = '" + AllTrim( cOrigemOrc )	+ "' "

	If Select( cAliasZ8 ) > 0
		( cAliasZ8 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasZ8 ) New
	If !( cAliasZ8 )->( Eof() )
		cUsrCaixa       := AllTrim( ( cAliasZ8 )->Z8_USRCX   )
		cPassCaixa      := AllTrim( ( cAliasZ8 )->Z8_PSSCX   )
		cWsSerieMg      := AllTrim( ( cAliasZ8 )->Z8_SERIE   )
		cCodInstanc     := Alltrim( ( cAliasZ8 )->Z8_CODIGO  )
		cFilEst         := AllTrim( ( cAliasZ8 )->Z8_FILEST  )
	EndIf
	( cAliasZ8 )->( DbCloseArea() )

	Restarea(aArea)
Return

Static Function fGrvSB0(_cCodPrd,_nValorPrd,_dData)

	Local _cProd  := PADR(Alltrim(_cCodPrd),TAMSX3("B0_COD")[1])
	Local _nValor := _nValorPrd

	DbSelectArea("SB0")
	SB0->(DbSetOrder(1))

	If SB0->(DbSeek(xFilial("SB0")+_cProd))
		RecLock('SB0',.F.) // LOCALIZOU O REGISTRO - ALTERA
		SB0->B0_FILIAL  := xFilial("SB0")
		SB0->B0_COD     := _cProd
		SB0->B0_PRV1    := _nValor
		SB0->B0_PRV2    := 0
		SB0->B0_PRV3    := 0
		SB0->B0_PRV4    := 0
		SB0->B0_PRV5    := 0
		SB0->B0_PRV6    := 0
		SB0->B0_PRV7    := 0
		SB0->B0_PRV8    := 0
		SB0->B0_PRV9    := 0
		SB0->B0_ECFLAG  := "2"
		SB0->B0_ECPRV   := 0
		SB0->B0_ECPROFU := 0
		SB0->B0_ECCOMP  := 0
		SB0->B0_ECLARGU := 0
		SB0->B0_DESCONT := 0
		SB0->B0_DTHRALT	:= DTOS(_dData)+Time()
		SB0->(MsUnlock())
	Else
		RecLock('SB0',.T.) // NÃO LOCALIZOU O REGISTRO - INCLUI
		SB0->B0_FILIAL  := xFilial("SB0")
		SB0->B0_COD     := _cProd
		SB0->B0_PRV1    := _nValor
		SB0->B0_PRV2    := 0
		SB0->B0_PRV3    := 0
		SB0->B0_PRV4    := 0
		SB0->B0_PRV5    := 0
		SB0->B0_PRV6    := 0
		SB0->B0_PRV7    := 0
		SB0->B0_PRV8    := 0
		SB0->B0_PRV9    := 0
		SB0->B0_ECFLAG  := "2"
		SB0->B0_ECPRV   := 0
		SB0->B0_ECPROFU := 0
		SB0->B0_ECCOMP  := 0
		SB0->B0_ECLARGU := 0
		SB0->B0_DESCONT := 0
		SB0->B0_DTHRALT	:= DTOS(_dData)+Time()
		SB0->(MsUnlock())
	EndIf

Return()

*---------------------------------------------------------------*
Static Function FRetPVInfo( cParamIdPedido, oParamWS, lSchedule )
	*---------------------------------------------------------------*

	Local lRetA := .F.
	Conout("Inicio FRetPVInfo " + Time())


	oParamWS:cOrderIncrementId 			:= cParamIdPedido
	oParamWS:oWSsalesOrderInfoResult 	:= MagentoService_SALESORDERENTITY():New()
	lRetA := oParamWS:SalesOrderInfo()
	If !lRetA

		cMsgErro  := "Erro ao tentar executar o Método [ salesOrderInfo ]. "
		cMsgCompl := "Erro ao tentar executar o Método [ salesOrderInfo ]. " + Replace( Replace( GetWSCError(), Chr(10), " " ), Chr( 13 ), "" )
		cDescri := cMsgCompl
		If lSchedule
			ConOut( "	UNIWS001 - FIntegra - FRetPVInfo - " + cMsgErro )
		Else
			Aviso( "Atenção", cMsgCompl, { "Continuar" } )
		EndIf
	EndIf
	//cAuxCGC := oParamWS:oWSsalesOrderInfoResult:ccustomer_taxvat
	Conout("Fim FRetPVInfo " + Time())
	//cXML := GetSoapResponse()
Return lRetA





Static Function fVerificaSl1()

	Local aArea := GetArea()
	Local cQuery := ""
	Local cAliasL1 := GetNextAlias()
	Local lGravou := .F.

	cQuery := "		SELECT R_E_C_N_O_ AS [NUMREC], L1_XIDMAGE  "
	cQuery += "		  FROM " + RetSQLName( "SL1" )
	cQuery += "		  WHERE D_E_L_E_T_ = ' ' "
	cQuery += "       AND L1_FILIAL = '"+cFilOrc+"'"
	cQuery += "		AND  L1_NUM = '"+cNumOrc+"'"

	If Select( cAliasL1 ) > 0
		( cAliasL1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasL1 ) New

	If !( cAliasL1 )->( Eof() )
		If AllTrim((cAliasL1)->L1_XIDMAGE) == AllTrim(cIdMageOrc)
			lGravou := .T.
		EndIf
		nRecNoSL1 := ( cAliasL1 )->NUMREC
	EndIf
	( cAliasL1 )->( DbCloseArea() )

Return lGravou
