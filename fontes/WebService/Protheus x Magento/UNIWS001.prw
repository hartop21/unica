
/*/{Protheus.doc} UNIWS001

@project Integração Protheus x Magento
@description Rotina híbrida ( Menu / Schedule ) utilizada para realizar a Importação dos pedidos do E-Commerce Magento

/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"

User Function UNIWS01S()
	U_UNIWS001( "01", "0101", "UARC01", Nil, "" )
Return

*-----------------------------------------------------------------------------------------------*
User Function UNIWS001( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
	*-----------------------------------------------------------------------------------------------*
	Local oFontProc     	:= Nil
	Local oDlgProc      	:= Nil
	Local oGrpTexto     	:= Nil
	Local oSayTexto     	:= Nil
	Local oBtnConfi     	:= Nil
	Local oBtnParam     	:= Nil
	Local oBtnSair      	:= Nil
	Local lHtml      	    := .T.
	Local lConfirmou   	 	:= .F.
	Local cPerg         	:= "UNIWS001"
	Local cTitulo   	    := "Integração Protheus x Magento - Importação de Pedidos de Vendas"
	Local cTexto  	      	:= "Esta rotina tem como objetivo realizar a importação dos Pedidos de Vendas do <font color='red'> Magento </font> para o Protheus."
	Local lMostraTela 		:= .F. //IsBlind()
	Private cCodTransp		:= ""
	Private lSchedule	 	:= .T. //IsBlind()
	Private	cPedMkt			:= ""
	Private aCabecOrc		:= {}
	Private cAuxForma		:= ""
	Private cDescri			:= ""
	Private aPgtoOrc		:= {}
	Private cParamInst		:= ""
	Public lTransaciona 	:= .F.
	Public cLoteProcess 	:= ""

	//Default aParams 		:= {} //ParamIXb
	Default cParamEmpJob	:= ""
	Default cParamFilJob	:= ""
	Default oParamWS    	:= Nil
	Default cParamNumLoteLog:= ""
	Default cParamInstancia := ""

	cParamInst := cParamInstancia


	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lMostraTela 	:= AllTrim( cParamEmpJob ) == ""
	lSchedule 		:= AllTrim( cParamEmpJob ) != ""

	If !lMostraTela

		ConOut( " ################################################################################### " )
		ConOut( " ## INICIO INTEGRAÇÃO UNIWS001 - IMPORTACAO PEDIDO DE VENDAS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ################################################################################### " )

		RPCSetType( 03 )
		//RPCSetEnv( cParamEmpJob, cParamFilJob, "CX_005", "123456", "LOJ",, { "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3"},  .T. )
		RPCSetEnv( cParamEmpJob, cParamFilJob,,, "LOJ",, { "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3"},  .T. )

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

		//Gerando Perguntas do Parâmetro
		MV_PAR01 := cParamInstancia
		FIntegra( lSchedule, oParamWS, cParamNumLoteLog )

		//Reset Environment
		RPCClearEnv()

		ConOut( " ################################################################################ " )
		ConOut( " ## FIM INTEGRAÇÃO UNIWS001 - IMPORTACAO PEDIDO DE VENDAS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ################################################################################ " )

	Else

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
			Processa( { || FIntegra( lSchedule ) }, "Conectando com a API do Magento, aguarde..." )
		EndIf

	EndIf

Return


Static function FVldParametros()

	Local lRet := .T.

	If AllTrim( MV_PAR01 ) == ""
		Aviso( "Atenção", "O Parâmetro [ WSDL Magento ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

Return .T.

*----------------------------------------------------------*
Static Function FIntegra( lSchedule, oWS, cParamNumLoteLog )
	*----------------------------------------------------------*
	//Local oWS 		 		:= Nil
	//Private cVaiParaFila	:= "Aprovação do crédito.Aguardando confirmação de pagamento.Pagamento Pendente"
	//Private cLiberaPedido	:= "Pedido Faturado e enviado para transporte."
	//Private cExcluiPedido	:= "Reprovado ou Expirado.Estornado"
	//Private cTransportePed	:= "Produto(s) em transporte.Produtos(s) entregues(s).
	Local lEncerra			:= .T.
	Local _cLojaVendedor    := "" // ---- LEANDRO RIBEIRO ---- 13/12/2019 ---- //
	Local _cIDVendedor      := "" // ---- LEANDRO RIBEIRO ---- 13/12/2019 ---- //
	Local _lPag				:= .F.
	Local cAuxShipMethod	:= ""
	Local cRetDupli			:= ""
	Local cA1Cod			:= ""
	Local lContinua			:= .F.
	Local cA1Loja			:= ""
	Private cAuxIdPedido	:= ""
	Private cL4Adminins		:= ""
	Private CMETHODPAGTO	:= ""
	Private cBandeira		:= ""
	Private cTipoCard		:= ""
	Private aAuxCondPag		:= {}
	Private cAuxCGC			:= ""
	Private aGetCli			:= {}
	Private nValTotal		:= 0
	Private cRecnoUNI		:= ""
	Private cStatus 		:= ""
	Private cAutRes			:= ""
	Private cWSDL			:= ""
	Private cAuxSituacao	:= ""
	Private cVaiParaFila	:= "produtos_em_transporte|new|processing|pending_payment|novo|pending|complete" // "new.processing.pending_payment.novo.pending"
	Private cLiberaPedido	:= "pagamento_confirmado"
	Private cExcluiPedido	:= "canceled|closed"
	Private cTransportePed	:= "produtos_em_transporte"
	Private cIgnorarPedido  := "produtos_em_transporte|complete|produtos_entregues|holded|customer_delivered|canceled"
	Private aLogsMagento 	:= {}
	Private cAuxNumOrcamento 		:= ""
	Private cXid  := ""
	Private cLoteProcess	:= "" //GetSXENum( "SZ5", "Z5_CODIGO" )
	Private cErrorLog		:= ""
	Private cXML			:= ""
	Private cNSU			:= ""
	Private nRecnoUni 		:= 0
	Private nVlrJuros       := ""
	//Private cTabEcommerce	:= _c_WsTabelaMagento // PadR( GetNewPar( "MV_XTABECO", "001" ), TamSX3( "DA0_CODTAB" )[01] )

	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""


	If Type( "_c_WsLnkMagento" ) != "C"

		DbSelectArea( "SZ8" )
		DbSetOrder( 01 )
		Conout("******************************************************************************************")
		Conout("Dando DBSEEK NO " + XFilial( "SZ8" )  + MV_PAR01)
		Conout("******************************************************************************************")

		Seek XFilial( "SZ8" ) + MV_PAR01
		If Found()
			Conout("ACHOU")
			// Se estiver bloqueado
			If AllTrim( SZ8->Z8_MSBLQL ) == "1"

				cMsgErro 	:= "A Instancia Magento [ " + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + " ] esta bloqueada para uso, a rotina nao sera executada."
				cMsgComp 	:= cMsgErro
				If lSchedule
					ConOut( "	UNIWS001 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS001"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
					Return
				Else
					Aviso( "Atenção", cMsgComp, { "Voltar" } )
					Return
				EndIf

			EndIf

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


			cAutRes := AllTrim( SZ8->Z8_AUTRESE )
			cWSDL   := AllTrim( SZ8->Z8_WSDL    )
			Conout("cWSDL = " + cWSDL)
			Conout("cAutRes = " + cAutRes)
			If AllTrim( _c_WsEmpFilEstoque ) == ""
				_c_WsEmpFilEstoque := AllTrim( GetNewPar( "MV_XEMPEST", "0101,0207" ) )
			EndIf

		Else

			cMsgErro 	:= "Não encontrou uma Instancia válida para a Integração com o Magento [ " + MV_PAR01 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS001 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS001"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "Atenção", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	If oWS == Nil

		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cUserName	:= _c_WsUserMagento // AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
		//oWs:capiKey	:= AllTrim( GetNewPar( "MV_XPSWMAG", "suporte#2019" ) ) //Produção
		oWs:cApiKey		:= _c_WsPassMagento // AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação
		Conout("Login API  " + _c_WsLnkMagento + " " + TIME())
		If !oWs:Login()

			cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS001 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS001"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "Atenção", "Erro ao tentar realizar login na API de Integração com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf
		oWs:cSessionId := oWs:cloginReturn
		lEncerra	:= .T.
		Conout("LOGOU NA API  " + _c_WsLnkMagento + " " + TIME())
		ConOut( "	UNIWS001 - FIntegra - Criou nova Sessao de API com o Magento" )


	Else

		lEncerra	:= .F.
		ConOut( "	UNIWS001 - FIntegra - Manteve a Sessao de API" )

	EndIf


	//WSSEND cSessionId
	oWs:cSessionId := oWs:cLoginReturn

	//WSSEND WSsalesOrderListfilters
	oWs:oWSsalesOrderListfilters := MagentoService_FILTERS():New()

	///////////////////////////////////////////
	///// IMPLEMENTAÇÃO DO FILTRO SIMPLES /////
	///////////////////////////////////////////
	//WSDATA   oWSfilter AS MagentoService_associativeArray OPTIONAL
	oWs:oWSsalesOrderListfilters:oWsFilter 	:= MagentoService_ASSOCIATIVEARRAY():New()
	oWs:oWSsalesOrderListfilters:oWsFilter:oWSAssociativeEntity := {}

	////////////////////////////////////////////
	///// IMPLEMENTAÇÃO DO FILTRO COMPLEXO /////
	////////////////////////////////////////////
	//WSDATA   oWScomplex_filter         AS MagentoService_complexFilterArray OPTIONAL
	oWs:oWSsalesOrderListfilters:oWScomplex_filter 					:= MagentoService_COMPLEXFILTERARRAY():New()
	oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter := {}

	aAdd( oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter, WsClassNew( "MagentoService_complexFilter" ) )
	aTail( oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter ):cKey 			:= "created_at"
	aTail( oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter ):oWSvalue 		:= WsClassNew( "MagentoService_associativeEntity" )
	aTail( oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter ):oWSvalue:ckey 	:= "gt"
	//aTail( oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter ):oWSvalue:cvalue:= FRetDtFormatada( MV_PAR01, "00:00:00" )
	aTail( oWs:oWSsalesOrderListfilters:oWScomplex_filter:oWScomplexFilter ):oWSvalue:cvalue:= FRetDtFormatada( ( Date() - GetNewPar( "MV_XDIASPV", 12 ) ), "00:00:00" )

	//WSRECEIVE oWSsalesOrderListresult
	oWS:oWSsalesOrderListresult := MagentoService_SALESORDERLISTENTITYARRAY():New()

	// Executa o WebService
	Conout("INICIO SALES ORDER LIST API  " + _c_WsLnkMagento + " " + TIME())
	If !oWS:salesOrderList()

		cMsgErro  := "Erro ao tentar executar o WS [ salesOrderList ]."
		cMsgCompl := "Erro ao tentar executar o WS [ salesOrderList ] " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
		If lSchedule
			ConOut( "	UNIWS001 - FIntegra - " + cMsgErro )
			U_UNIGrvLog( cLoteProcess, "", "", "UNIWS001", "FIntegra", cMsgErro, cMsgCompl, "", 0 )
			Return
		Else
			Aviso( "Atenção", "Erro ao tentar executar o WS [ salesOrderList ]. " + CRLF + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " ), { "Sair" } )
			Return
		EndIf

	EndIf
	Conout("FIM SALES ORDER LIST API  " + _c_WsLnkMagento + " " + TIME())

	If !lSchedule
		ProcRegua( Len( oWS:oWSsalesOrderListResult:oWsSalesOrderListEntity ) )
	EndIf

	/*
Atributo cState
New (novo).........................: Este estado é aplicado para todos os pedidos que entram na loja e ainda não foram revisados, ou seja, pedidos que acabaram de entrar.
Pending Payment (pending_payment)..: Quando utilizamos um gateway como forma de pagamento, o pedido passa de new para pending_payment.
Processing (processando)...........: Este estado é aplicado para qualquer pedido que venha a ter uma fatura ou um envio gerado. Todo pedido que seja faturado, é criado uma nota de entrega.
Complete (completo)................: Quando um pedido é faturado e também é entregue ele passa a ficar com o estado complete, que significa que o pedido está completo e não há mais o que fazer com ele.
Closed (Fechado)...................: O pedido entra com o estado closed quando uma nota de crédito é criada no valor integral do pedido. Basicamente quando o pedido for estornado.
Canceled (cancelado)...............: Como o próprio nome diz os pedidos cancelados passam a ter o estado canceled.
On Hold (holded)...................: Pedidos que devem ser segurados (congelados) por um tempo ficam com este estado. Um exemplo prático é quando o mesmo é pago com boleto bancário.
Payment Review (payment_review)....: O pagamento do pedido está sendo revisado.
	*/

	nRecNoSL1 		:= 0
	aAuxIdsPedidos 	:= {}
	ConOut( "Len( oWS:oWSsalesOrderListResult:oWsSalesOrderListEntity ) --> " + cValToChar( Len( oWS:oWSsalesOrderListresult:oWsSalesOrderListEntity ) ) )
	For nP := 01 To Len( oWS:oWSsalesOrderListResult:oWsSalesOrderListEntity )
		aAdd( aAuxIdsPedidos, { oWS:oWSsalesOrderListResult:oWsSalesOrderListEntity[nP]:cIncrement_Id, oWS:oWSsalesOrderListresult:oWsSalesOrderListEntity[nP]:cStatus, oWS:oWSsalesOrderListresult:oWsSalesOrderListEntity[nP]:cshipping_method,oWS:oWSsalesOrderListResult:oWsSalesOrderListEntity[nP]:CCUSTOMER_TAXVAT }	)
	Next nP


	For nP := 01 To Len( aAuxIdsPedidos )

		fClearVar()
		cAuxIdPedido 	:= aAuxIdsPedidos[nP][01]
		cAuxShipMethod	:= aAuxIdsPedidos[nP][03]
		cXid 			:= FWUUIDV4()
		//cAuxCGC			:= aAuxIdsPedidos[nP][04]
		If cAuxIdPedido == Nil
			Conout("ERRO: Id magento não existe!")
			Conout("Fim da integração do pedido ")
			Conout("################################################################################################################################################")
			Loop
		EndIf

		Conout("################################################################################################################################################")
		Conout("Inicio da integração do Pedido Magento "+cAuxIdPedido)
		Conout("Processo de gravação na tabela intermediária UNI010 ")
		Conout("Data: " + DTOC(Date()))
		Conout(" Hora: " + Time())

		//If allTrim(cauxidpedido) == "145952307"
		//	Conout("OK")
		//EndIf

		If AllTrim( cAuxIdPedido ) == ""
			Loop
			Conout("ERRO: Id Magento não existe!")
			Conout("Fim da integração do pedido " + cAuxIdPedido)
			Conout("################################################################################################################################################")
		EndIf

		cStatus := AllTrim( aAuxIdsPedidos[nP][02] )
		If AllTrim( cStatus ) $ AllTrim( cIgnorarPedido )
			ConOut( "	UNIWS001 - Pedido de Vendas [ " + AllTrim( cAuxIdPedido ) + " ], não precisa ser processado... Status [ " + cStatus + " ]." )
			Conout("Fim da integração do pedido " + cAuxIdPedido)
			//fGrvResult(.T.,cDescri)
			Conout("################################################################################################################################################")
			Loop
		EndIf
		nRecnoUni := fSeekId()

		If nRecnoUni != 0
			cMsgErro  := "Erro ao gravar o pedido na tabela intermediária
			cMsgCompl := "Erro ao tentar gravar o Pedido [ " + cAuxIdPedido + " ] na tabela intermediária, o pedido já está gravado. Caso esteja com erro será reprocessado."
			ConOut( "	UNIWS01A - ERRO - " + cMsgCompl )
			Conout("Fim da integração do pedido " + cAuxIdPedido)
			Conout("################################################################################################################################################")
			Loop
		Else

			If !lSchedule
				IncProc( "Importando Pedido de Vendas [ " + AllTrim( cAuxIdPedido ) + " ], aguarde..." )
			EndIf
			ConOut( "	UNIWS001 - Importando Pedido de Vendas [ " + AllTrim( cAuxIdPedido ) + " ], aguarde..." )
			Conout("Gerando as informações do pedido...")
			If FRetPVInfo( cAuxIdPedido, @oWS, lSchedule )
				Conout("Informações do pedido geradas com sucesso!")
				Conout("O Status do pedido é: " + cStatus)


				dAuxDtCreate  	:= SToD( Replace( Left( oWS:oWSSalesOrderInfoResult:ccReated_At, 10 ), "-", "" ) )
				cAuxIdCliente 	:= oWS:oWSSalesOrderInfoResult:cCustomer_Id//oWSBilling_Address:cParent_Id
				cAuxCGC			:= Replace( Replace( Replace( Replace( AllTrim( oWS:oWSSalesOrderInfoResult:cCustomer_TaxVat ), ".", "" ), "-", "" ), "/", "" ), "\", "" )
				nAuxRecNoSA1    := U_UNICliExiste( cAuxCGC )
				cAuxError		:= ""
				cMethodPagto	:= oWs:oWSsalesOrderinfoResult:oWSPayment:cMethod
				cBandeira		:= AllTrim(OWs:oWSsalesOrderinfoResult:oWSPayment:CCC_TYPE)
				Conout("Gerando as informações e integrando cliente...")

				If FIntCliente( cAuxIdCliente, cAuxIdPedido, oWS, @nAuxRecNoSA1, @cAuxError )
					aGetCli := GetCli(cAuxCGC)
					Conout("Cliente integrado com sucesso!")
					Conout("Código: " + aGetCli[1][1])
					Conout("Nome: "   + aGetCli[4][1])
					Conout("Tipo: "   + aGetCli[3][1])
					Conout("Loja: "   + aGetCli[2][1])
					Conout("CGC: "    + cAuxCGC)
				else
					//Gravar erro/LOG e passar para o proximo pedido
					Conout("Erro no processo de integração do cliente. O pedido não será integrado, verificar o LOG para mais informações.")
					Conout("Fim da integração do pedido " + cAuxIdPedido)
					Conout("################################################################################################################################################")
					U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","",cAuxIdCliente,cStatus,"ERRO",cErrorLog,"UNIWS001",cXid,cWSDL,"")
					Loop
				EndIf
				Conout("Buscando a condição de pagamento...")
				// Busca a Condição de Pagamento por Método de Pagamento ( Marketplace )
				aAuxCondPag  		:= {}
				aAuxCondPag  		:= FRetCondPgto( cMethodPagto )
				If Len( aAuxCondPag ) > 0
					cAuxCondPag  		:= aAuxCondPag[01]
					cAuxForma			:= aAuxCondPag[02]
				Else
					cAuxCondPag  		:= ""
					cAuxForma			:= ""
				EndIf
				Conout("A Condição de pagamento é: " + cAuxCondPag)

				//FIM
				//Lucas Miranda de Aguiar - 14/05/2020
				//Busca o código da transportadora utilizando o ID magento
				Conout("Buscando o código da transportadora...")
				cCodTransp			:= RetCodTransp(cAuxShipMethod)
				Conout("O código da transportadora é: " + cCodTransp)
				//Fim
				If AllTrim( cAuxCondPag ) == ""
					cMsgErro  	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus."
					cMsgCompl	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus. Id de Condição de Pagamento Magento não encontrado no Protheus [ " + oWS:oWSSalesOrderInfoResult:oWSPayment:cMethod + " ]."
					ConOut( "	UNIWS001 - fIntegra - " + cMsgCompl )
					cErrorLog := cMsgCompl
					U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","",aGetCli[1][1],cStatus,"ERRO",cErrorLog,"UNIWS001",cXid,cWSDL,"")
					If !lSchedule
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
					EndIf
					Loop
				EndIf

				//Lucas Miranda de Aguiar - 14/05/2020 - 14/05/2020
				//Retorna erro caso não exista o De-para de código da transportadora ou se existir mais de uma transportadora por ID MAGENTO
				If AllTrim(cCodTransp) == "ERRO"
					cMsgErro  	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus."
					cMsgCompl	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus. O Código da transportadora MAGENTO [ " + cAuxShipMethod + " ] existe para mais de uma transportadora no Protheus.
					cRetDupli   := fTrataDupli(cAuxShipMethod)
					ConOut("	UNIWS001 - fIntegra - O de para da transportadora MAGENTO existe para mais de uma transportadora no Protheus: " + cRetDupli)
					ConOut( "	UNIWS001 - fIntegra - " + cMsgCompl )
					cErrorLog := cMsgCompl
					U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","",aGetCli[1][1],cStatus,"ERRO",cErrorLog,"UNIWS001",cXid,cWSDL,"")
					If !lSchedule
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
					EndIf
					Loop
				ElseIf AllTrim(cCodTransp) == ""
					cMsgErro  	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus."
					cMsgCompl	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus. Código da transportadora não encontrado no Protheus [ " + cAuxShipMethod + " ]."
					ConOut( "	UNIWS001 - fIntegra - " + cMsgCompl )
					cErrorLog := cMsgCompl
					U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","",aGetCli[1][1],cStatus,"ERRO",cErrorLog,"UNIWS001",cXid,cWSDL,"")
					If !lSchedule
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
					EndIf
					Loop
				EndIf
				//Busca o Código do pedido Marketplace
				Conout(" UNIWS0001 - Inicio da função U_GetPedMKT para buscar o código do marketplace caso exista")
				cPedMkt:= U_GetPedMKT(cAuxIdPedido)
				Conout(" UNIWS0001 - Fim da função U_GetPedMKT, o código marketplace é: " + cPedMkt)

				//Realiza a busca do Código da administradora do cartão para pedidos do site
				Conout("Buscando o código da administradora do pedido magento...")
				If Left( Lower( AllTrim( cMethodPagto ) ), 09 )== "mundipagg"
					cParcelas		:= oWs:oWSsalesOrderinfoResult:oWSPayment:cinstallments
					If Left( Lower( AllTrim( cMethodPagto ) ), 12 )== "mundipagg_cc"
						cTipoCard := "CC"
						cNSU := OWs:oWSsalesOrderinfoResult:oWSPayment:ccc_trans_id
						If cNSU == NIL
							cNSU := ""
						EndIf
					Else
						cTipoCard := "CD"
					EndIf
				Else
					cParcelas		:= ""
				EndIf

				If Lower(AllTrim(cMethodPagto)) == "itaushopline_standard"
					cTipoCard := "BO"
					cBandeira := "BOLETO"
				EndIf
				cMethodPagto	:= AllTrim( cMethodPagto ) + AllTrim( cParcelas )
				cL4Adminins	:= RetAdm(cBandeira,cTipoCard)
				If !Empty(AllTrim(cL4Adminins))
					Conout("O Código da administradora(AE_COD) do pedido magento " +cAuxIdPedido+ " é " + cL4Adminins )
				EndIf
				//FIM

				//Verifica o valor dos itens
				// valor Total do Pedido
				nVlrTotal 			:= Val( oWS:oWSSalesOrderInfoResult:cGrand_Total     )
				// Desconto Total do Pedido
				nVlrDesconto		:= Abs( Val( oWS:oWSSalesOrderInfoResult:cDiscount_Amount ) )
				// Frete
				nVlrFrete 			:= Val( oWS:oWSSalesOrderInfoResult:cShipping_Amount )

				nVlrProdutos 		:= ( nVlrTotal + nVlrDesconto - nVlrFrete )

				nValTotal :=  Val(oWS:oWSSalesOrderInfoResult:csubtotal) + Val( oWS:oWSSalesOrderInfoResult:cDiscount_Amount ) + Val( oWS:oWSSalesOrderInfoResult:cShipping_Amount )

				If !ValType(oWS:OwsSalesOrderInfoResult:cBseller_Skyhub_Interest) == "U"
					nVlrJuros := Val(oWS:OwsSalesOrderInfoResult:cBseller_Skyhub_Interest)
				EndIf
				/*/If nValTotal < nVlrTotal
					cMsgErro  	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus."
					cMsgCompl	:= "Erro ao tentar integrar o Orçamento de Vendas no [ " + cAuxIdPedido + " ] no Protheus. O pedido está com o valor do juros somado no total, favor incluir o pedido manualmente."
					ConOut( "	UNIWS001 - fIntegra - " + cMsgCompl )
					cErrorLog := cMsgCompl
					U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","",aGetCli[1][1],cStatus,"ERRO",cErrorLog,"UNIWS001",cXid,cWSDL,"")
					If !lSchedule
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
					EndIf
					Loop
				EndIf/*/

				nAuxMoeda			:= 1
				nAuxTxMoeda			:= 0
				nPercDesc 			:= 0
				nAuxPercDesc 		:= 0
				If nVlrDesconto > 0
					nAuxPercDesc := Round( ( ( nVlrDesconto / nVlrTotal ) * 100 ), 02 )
				EndIf

				// fim aqui
				//aPgtoOrc 	:= {}
				aAuxCond 	:= Condicao( nVlrTotal, cAuxCondPag, 0, Date() )

				nParcelas   := Iif( Len( aAuxCond ) > 0, Len( aAuxCond ), 01 )

				// Novas tratativas - 27-09-2019
				nLQVLRTOT	:= nVlrTotal - nVlrDesconto + nVlrFrete
				//Fim
				// Busca o Vendedor por Método de Pagamento ( Marketplace )
				// ---- INICIO ---- LEANDRO RIBEIRO ---- 13/12/2019 ---- //
				_cLojaVendedor := REPLACE(REPLACE(oWS:oWSSalesOrderInfoResult:CSTORE_NAME,CHAR(13) + Char(10) ,' '), CHAR(10), ' ')
				If(UPPER(_cLojaVendedor) == UPPER(AllTrim("Pagg Express Pagg Express Pagg Express")))
					_cIDVendedor := AllTrim(oWS:oWSSalesOrderInfoResult:CAFFILIATE_ID)
					If(Empty(_cIDVendedor))
						_cIDVendedor := "XXXXXXXXXX"
					EndIf
					aAuxVendedor := FRetVendedor( _cIDVendedor )
					_lPag := .T.
				Else
					aAuxVendedor := FRetVendedor( cMethodPagto )
				EndIf
				// ---- FIM ------ LEANDRO RIBEIRO ---- 13/12/2019 ---- //
				//aAuxVendedor := FRetVendedor( cMethodPagto )
				If Len( aAuxVendedor ) > 0
					cAuxVendedor  		:= aAuxVendedor[01]
					nAuxComissao		:= aAuxVendedor[02]
				Else
					//Pega o vendedor definifo no Cadastro de Instâncias Magento
					cAuxVendedor 		:= _c_WsVendedorMagen //AllTrim( GetNewPar( "MV_XVENMAG", "000086" ) ) // Vendedor para as vendas Magento
					nAuxComissao		:= 0
				EndIf

				// Guilherme Moraes em 07/04/2020 g.grmoraes@gmail.com
				// Incluir a informação de vendedor parceiro VENDEDOR2
				// I N Í C I O  D A  A L T E R A Ç Ã O
				_cCodVend2 	 	:= ""
				_aPARTNER_ID 	:= {}

				_cPARTNER_ID := Alltrim(oWS:oWSSalesOrderInfoResult:CPARTNER_ID)
				If !Empty(_cPARTNER_ID)
					_aPARTNER_ID := FRetVendedor( _cPARTNER_ID )
				EndIf

				If Len( _aPARTNER_ID ) > 0
					_cCodVend2:= _aPARTNER_ID[01]
				EndIf

				// F I N A L  D A  A L T E R A Ç Ã O

				//Com todos os dados vamos dar inicio a gravação na tabela UNI010 - Tabela intermediária da integração Magento x Protheus
				UNIWS01A()
				//Após gravar o pedido grava os itens em outra tabela
				GRVAITEM()
				//Gera o LOG
				U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","",aGetCli[1][1],cStatus,"PENDENTE","GRAVADO NA TABELA INTERMEDIARIA UNI010","UNIWS001",cXid,cWSDL,"")
			Else
				//Gravar erro/LOG e passar para o proximo pedido
				Conout("Erro ao gerar as informações do pedido, consultar log para mais informações.")
				Conout("Fim da integração do pedido " + cAuxIdPedido)
				Conout("################################################################################################################################################")
				cErrorLog := "Fim da integração do pedido " + cAuxIdPedido
				U_UNIWSLOG(XFilial( "UNI" ),"MAGENTO",cAuxIdPedido,"","","","","ERRO",cErrorLog,"UNIWS001","",cWSDL,"")
				Loop
			EndIf
		EndIf
	Next nP

	If lEncerra
		oWS:endSession()
		ConOut( "	UNIWS001 - FIntegra - Encerrou a sessao com o Magento" )
	EndIf

Return

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


Static Function UNIWS01A()

	Local aArea := GetArea()
	Local lExiste := .T.
	Local lRet	  := .F.

	//Renato Morcerf - 06/07/2021
	Local lAchou := .T.
	Local nRecNoSL1 := 0


	Conout("//////////////////////////////////////////")
	Conout("Inicio da função UNIWS01A para o pedido magento " + cAuxIdPedido )
	Conout(Date())
	Conout(Time())
	//Primeiro valida se o ID Magento com o Status já existe na tabela.

	Conout("O pedido não existe na tabela intermediária -- Inicio da gravação")
	DbSelectArea("UNI")

	lRet := .T.

	//************Renato Morcerf - 06/07/2021 *  Motivo: Nao importar pedidos cancelados do Magento ***********************//
	lAchou := .T.
	//nRecNoSL1 := 0

	IF cStatus $ cExcluiPedido

		Conout("Pedido "+cAuxIdPedido + " Foi excluido no loja")
		Conout("Fim da integração do pedido " + cAuxIdPedido + " NAO INTEGRADO")
		Conout("##############################################################################################")

		cQuery3 := "DELETE FROM " + RetSqlName("UNI") + " "
		cQuery3 += "WHERE UNI_FILIAL = '" + xFilial("UNI") 	+ "' AND "
		cQuery3 += "UNI_IDMAG = '"  + cAuxIdPedido + "' AND "
		cQuery3 += "D_E_L_E_T_ = ' '"
		TcSqlExec(cQuery3)
		lAchou := .F.
	Endif
	/*******************************************************************************************************/


	DbSelectArea("UNI")

	IF lAchou
		RecLock( "UNI", .T. )

		UNI->UNI_NUM		:= " "
		UNI->UNI_INTEG   	:= "PENDENTE"
		UNI->UNI_IDMAG      := cAuxIdPedido
		UNI->UNI_PEDMKT     := cPedMkt
		UNI->UNI_FILIAL     := XFilial( "UNI" )
		UNI->UNI_STATUS     := cStatus
		UNI->UNI_DATA       := DtoS(Date())
		UNI->UNI_HR         := Time()
		UNI->UNI_FORMA		:= cAuxForma
		UNI->UNI_XID        := cXid
		UNI->UNI_CODCLI		:= aGetCli[1][1]
		UNI->UNI_LOJCLI     := aGetCli[2][1]
		UNI->UNI_TIPOCLI    := aGetCli[3][1]
		UNI->UNI_NOMECLI    := aGetCli[4][1]
		UNI->UNI_CGCCLI     := cAuxCGC
		UNI->UNI_CADMIN     := cL4Adminins
		UNI->UNI_VEND       := cAuxVendedor
		UNI->UNI_VEND2		:= _cCodVend2
		UNI->UNI_VALTOT     := cValToChar(nVlrProdutos - nVlrDesconto)
		UNI->UNI_VALLIQ     := cValToChar(nVlrProdutos - nVlrDesconto + nVlrFrete)
		UNI->UNI_VALBRUT    := cValToChar(nVlrProdutos - nVlrDesconto + nVlrFrete)
		UNI->UNI_VALMERC    := cValToChar(nVlrProdutos)
		UNI->UNI_DESCON    	:= cValToChar(nVlrDesconto)
		UNI->UNI_DESCFN		:= cValToChar(nPercDesc)
		UNI->UNI_VLFRET    	:= cValToChar(nVlrFrete)
		UNI->UNI_PARCEL    	:= cValToChar(nParcelas)
		UNI->UNI_TRANSP     := cCodTransp
		UNI->UNI_CONDPG   	:= cAuxCondPag
		UNI->UNI_AUTRES 	:= _c_WsAutReserva
		UNI->UNI_WSDL		:= _c_WsLnkMagento + "?wsdl"
		UNI->UNI_ERRO		:= ""
		UNI->UNI_ORIGEM		:= _c_WsCodInstancia
		UNI->UNI_FLGREP		:= " "
		UNI->UNI_METHOD		:= AllTrim(cMethodPagto)
		UNI->UNI_VALOR		:= cValToChar(nVlrTotal)
		UNI->UNI_NSU		:= cNSU
		UNI->UNI_JUROS      := cValToChar(nVlrJuros)

		MsUnlock()
		Conout("Os Dados foram gravados com sucesso!")
		Conout("Fim da integração do pedido " + cAuxIdPedido)
		Conout("################################################################################################################################################")
	Else
		Conout("Pedido "+cAuxIdPedido + " Foi excluido no loja")
		Conout("Fim da integração do pedido " + cAuxIdPedido +" NAO INTEGRADO")
		Conout("################################################################################################################################################")

	Endif
	RestArea(aArea)

Return lRet

*----------------------------------------------------------------------------------------*
Static Function FIntCliente( cParamIdCliente, cParamIdPV, oWS, nParamRecSA1, cParamError )
	*----------------------------------------------------------------------------------------*
	Local aAreaAnt 			:= GetArea()
	Local lRet  			:= .T.
	Local aExecAuto 		:= {}
	local lPessoaF			:= .F.
	Default nParamRecSA1 	:= 00
	aExecAuto 				:= {}

	ConOut( "	UNIWS001 - FCLIENTE 1" )
	If Select ( "SA1" ) == 0
		ChkFile( "SA1", .T. )
	EndIf
	DbSelectArea( "SA1" )
	If nParamRecSA1 > 0

		ConOut( "	UNIWS001 - FCLIENTE 2 - TRATA COMO ALTERAÇÃO DOS DADOS DO CLIENTE " )
		SA1->( DbGoTo( nParamRecSA1 ) )
		nAuxOpc	:= 04

		aAdd( aExecAuto, { "A1_PESSOA" , SA1->A1_PESSOA	, Nil } )
		aAdd( aExecAuto, { "A1_CGC"    , SA1->A1_CGC	, Nil } )
		aAdd( aExecAuto, { "A1_TIPO"   , SA1->A1_TIPO	, Nil } )  //F Final???
		aAdd( aExecAuto, { "A1_FILIAL" , SA1->A1_FILIAL	, Nil } )
		aAdd( aExecAuto, { "A1_COD"	   , SA1->A1_COD	, Nil } )
		aAdd( aExecAuto, { "A1_LOJA"   , SA1->A1_LOJA	, Nil } )

		If AllTrim( SA1->A1_PESSOA ) == "F"
			cContrib    := "2"
			cEntId		:= "00"
			lPessoaF	:= .T.
		Else
			cContrib    := "1"
			cEntId		:= "00"
		EndIf

	Else

		ConOut( "	UNIWS001 - FCLIENTE 3 - TRATA COMO INCLUSÃO DO NOVO CLIENTE" )
		nAuxOpc		:= 03
		//cAuxCodigo 	:= GetSXENum( "SA1", "A1_COD" )
		//cAuxLoja 	:= PadL( "0", TamSX3( "A1_LOJA" )[01], "0" )
		//cAuxCGC		:= Replace( Replace( Replace( Replace( AllTrim( oWS:oWSSalesOrderInfoResult:cCustomer_TaxVat ), ".", "" ), "-", "" ), "/", "" ), "\", "" )
		If Len( AllTrim( cAuxCGC ) ) == 11
			cAuxPessoa  := "F"
			cAuxCodigo 	:= Left( cAuxCGC, 09 ) //GetSXENum( "SA1", "A1_COD" )
			cAuxLoja 	:= "PF"
			cContrib    := "2"
			cEntId		:= "00"
			lPessoaF	:= .T.
		ElseIf Len( AllTrim( cAuxCGC ) ) == 14
			cAuxPessoa  := "J"
			cAuxCodigo 	:= Left( cAuxCGC, 08 ) //GetSXENum( "SA1", "A1_COD" )
			cAuxLoja 	:= SubStr( cAuxCGC, 09, 04 )
			cContrib    := "1"
			cEntId		:= "00"
		Else
			cAuxPessoa  := " "
			cAuxCodigo 	:= "         "
			cAuxLoja 	:= "    "
			cContrib    := "2"
			cEntId		:= "00"
			//ConfirmSX8()
		EndIf

		cAuxTipo    	:= "F" //oParamOrcamentoVenda:oCliente:cTipoCliente
		aAdd( aExecAuto, { "A1_FILIAL" , XFilial( "SA1" )						 , Nil } )
		aAdd( aExecAuto, { "A1_PESSOA" , cAuxPessoa								 , Nil } )
		aAdd( aExecAuto, { "A1_CGC"    , cAuxCGC								 , Nil } )
		aAdd( aExecAuto, { "A1_TIPO"   , cAuxTipo								 , Nil } )  //F Final???
		aAdd( aExecAuto, { "A1_COD"	   , cAuxCodigo								 , Nil } )
		aAdd( aExecAuto, { "A1_LOJA"   , cAuxLoja								 , Nil } )
		aAdd( aExecAuto, { "A1_XIDMAGE", cParamIdCliente 						 , Nil } )

	EndIf

	ConOut( "	UNIWS001 - FCLIENTE 4" )

	aAdd( aExecAuto, { "A1_NOME"  	, Replace( FTrataTexto( oWS:oWSSalesOrderInfoResult:cCustomer_FirstName ) + " " + FTrataTexto( oWS:oWSSalesOrderInfoResult:cCustomer_LastName	), "  ", " " ) , Nil } )
	aAdd( aExecAuto, { "A1_NREDUZ"	, Replace( FTrataTexto( oWS:oWSSalesOrderInfoResult:cCustomer_FirstName ) + " " + FTrataTexto( oWS:oWSSalesOrderInfoResult:cCustomer_LastName	), "  ", " " ) , Nil } )
	aAdd( aExecAuto, { "A1_CONTATO" , FTrataTexto( oWS:oWSSalesOrderInfoResult:cCustomer_FirstName )	, Nil } )
	//aAdd( aExecAuto, { "A1_INSCR"   , "ISENTO"												 								 , Nil } )
	//aAdd( aExecAuto, { "A1_DTNASC"  , FRetDtFormatada( Replace( oWS:oWSSalesOrderInfoResult:ccReated_At, "-", "" ) )				, Nil } )

	ConOut( "	UNIWS001 - FCLIENTE 5" )

	// Definição do Endereço de Faturamento / Principal


	IF !lPessoaF
		aAuxEndereco := Separa( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cStreet, Chr( 10 ), .T. )

		If Len( aAuxEndereco ) == 04

			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "'", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "#", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "%", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "*", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "&", "E")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], ">", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "<", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "!", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "@", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "$", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "(", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], ")", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "_", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "=", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "+", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "{", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "}", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "[", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "]", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "/", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "?", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], ".", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "\", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], "|", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], ":", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], ";", "")
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], '"', '')
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], '°', '')
			aAuxEndereco[03] := StrTran(aAuxEndereco[03], 'ª', '')

			aAdd( aExecAuto, { "A1_END"		, FTrataTexto( aAuxEndereco[01] ) + ", " + FTrataTexto( aAuxEndereco[02] ), Nil } )
			aAdd( aExecAuto, { "A1_COMPLEM"	, FTrataTexto( aAuxEndereco[03] ), Nil } )
			aAdd( aExecAuto, { "A1_BAIRRO"	, FTrataTexto( aAuxEndereco[04] ), Nil } )
		Else
			aAdd( aExecAuto, { "A1_END"		, FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cStreet ), Nil } )
			aAdd( aExecAuto, { "A1_COMPLEM" , "" ,Nil } )
			aAdd( aExecAuto, { "A1_BAIRRO"	, "", Nil } )
		EndIf

		cAuxUF := AllTrim( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion ) )
		If Len( AllTrim( cAuxUF ) ) > 2 // Passo da forma descritiva
			cAuxUF := AllTrim( FRetUF( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion ) ) )
			cAuxEstado := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion )
			Conout("UF: "+AllTrim(cAuxUF))
			Conout("Estado: "+AllTrim(cAuxEstado))
		Else
			cAuxEstado := AllTrim( FRetEstado( FTrataTexto( cAuxUF ) ) )
			Conout("Estado: "+AllTrim(cAuxEstado))
		EndIf
		aAdd( aExecAuto, { "A1_EST"		, cAuxUF	 , Nil } )
		aAdd( aExecAuto, { "A1_ESTADO"	, cAuxEstado , Nil } )
		aAdd( aExecAuto, { "A1_CEP"		, oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cPostCode , Nil } )

		cAuxDescMun := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cCity )
		cAuxCodMun := U_UNIRetMunicipio( cAuxDescMun, cAuxUF )
		If AllTrim( cAuxCodMun ) != ""
			aAdd( aExecAuto, { "A1_COD_MUN"	, cAuxCodMun, Nil } )
			//aAdd( aExecAuto, { "A1_CODMUN"	, oParamOrcamentoVenda:oCliente:oEnderercoCobranca:cCodigoMunicipio	 , Nil } )
		Else
			aAdd( aExecAuto, { "A1_COD_MUN"	, ""	 , Nil } )
		EndIf
		aAdd( aExecAuto, { "A1_MUN"		, cAuxDescMun	, Nil } )

	Else

		aAuxEndEntrega := Separa( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cStreet, Chr( 10 ), .T. )
		If Len( aAuxEndEntrega ) == 04
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "'", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "#", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "%", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "*", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "&", "E")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], ">", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "<", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "!", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "@", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "$", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "(", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], ")", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "_", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "=", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "+", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "{", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "}", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "[", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "]", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "/", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "?", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], ".", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "\", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], "|", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], ":", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], ";", "")
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], '"', '')
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], '°', '')
			aAuxEndEntrega[03] := StrTran(aAuxEndEntrega[03], 'ª', '')

			aAdd( aExecAuto, { "A1_END"	, FTrataTexto( aAuxEndEntrega[01] ) + ", " + FTrataTexto( aAuxEndEntrega[02] ), Nil } )
			aAdd( aExecAuto, { "A1_COMPLEM"	, FTrataTexto( aAuxEndEntrega[03] ), Nil } )
			aAdd( aExecAuto, { "A1_BAIRRO"	, FTrataTexto( aAuxEndEntrega[04] ), Nil } )
		Else
			aAdd( aExecAuto, { "A1_END"	, FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cStreet ), Nil } )
			aAdd( aExecAuto, { "A1_COMPLEM" , "" ,Nil } )
			aAdd( aExecAuto, { "A1_BAIRRO"	, "", Nil } )
		EndIf

		cAuxEntUF 	:= AllTrim( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion ) )
		If Len( AllTrim( cAuxEntUF ) ) > 2 // Passo da forma descritiva
			cAuxEntUF := AllTrim( FRetUF( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion ) ) )
			cAuxEntEstado := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion )
			Conout("UF: "+AllTrim(cAuxEntUF))
			Conout("Estado: "+AllTrim(cAuxEntEstado))
		Else
			cAuxEntEstado := AllTrim( FRetEstado( FTrataTexto( cAuxEntUF ) ) )
			Conout("Estado: "+AllTrim(cAuxEntEstado))
		EndIf
		aAdd( aExecAuto, { "A1_EST"		, cAuxEntUF	 , Nil } )
		aAdd( aExecAuto, { "A1_ESTADO"	, cAuxEntEstado , Nil } )
		aAdd( aExecAuto, { "A1_CEP"	, oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cPostCode 	 	 	 , Nil } )

		cAuxDescMun := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cCity )
		cAuxCodMun  := U_UNIRetMunicipio( cAuxDescMun, cAuxEntUF )
		If AllTrim( cAuxCodMun ) != ""
			aAdd( aExecAuto, { "A1_COD_MUN"	, cAuxCodMun, Nil } )
			//aAdd( aExecAuto, { "A1_CODMUN"	, oParamOrcamentoVenda:oCliente:oEnderercoCobranca:cCodigoMunicipio	 , Nil } )
		Else
			aAdd( aExecAuto, { "A1_COD_MUN", "" , Nil } )
		EndIf
		aAdd( aExecAuto, { "A1_MUN"	, cAuxDescMun, Nil } )

	endIf

	If AllTrim( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cCountry_Id ) == "BR"
		//aAdd( aExecAuto, { "A1_DDI"		, "55"		, Nil } )
		aAdd( aExecAuto, { "A1_PAIS"	, "105"		, Nil } ) // Brasil
		aAdd( aExecAuto, { "A1_CODPAIS"	, "01058"	, Nil } )
	Else
		//aAdd( aExecAuto, { "A1_DDI"		, ""		, Nil } )
		aAdd( aExecAuto, { "A1_PAIS"	, "994"		, Nil } ) // A Designar
		aAdd( aExecAuto, { "A1_CODPAIS"	, ""		, Nil } )
	EndIf

	aAdd( aExecAuto, { "A1_INSCR"   	, ""												 								 , Nil } )
	aAdd( aExecAuto, { "A1_EMAIL"		, oWS:oWSSalesOrderInfoResult:cCustomer_Email , Nil } )

	ConOut( "	UNIWS001 - FCLIENTE 6" )

	// Definição do Endereço de Entrega do Cliente
	aAuxEndEntrega := Separa( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cStreet, Chr( 10 ), .T. )
	If Len( aAuxEndEntrega ) == 04
		aAdd( aExecAuto, { "A1_ENDENT"	, FTrataTexto( aAuxEndEntrega[01] ) + ", " + FTrataTexto( aAuxEndEntrega[02] ), Nil } )
		aAdd( aExecAuto, { "A1_COMPENT"	, FTrataTexto( aAuxEndEntrega[03] ), Nil } )
		aAdd( aExecAuto, { "A1_BAIRROE"	, FTrataTexto( aAuxEndEntrega[04] ), Nil } )
	Else
		aAdd( aExecAuto, { "A1_ENDENT"	, FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cStreet ), Nil } )
		aAdd( aExecAuto, { "A1_COMPENT" , "" ,Nil } )
		aAdd( aExecAuto, { "A1_BAIRROE"	, "", Nil } )
	EndIf

	//cAuxEntUF 	:= AllTrim( FRetUF( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion ) ) )
	//aAdd( aExecAuto, { "A1_ESTE"	, cAuxEntUF , Nil } )
	//aAdd( aExecAuto, { "A1_ESTE"	, FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion ) , Nil } )

	//cAuxEntUF 	:= AllTrim( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion ) ) // ---- LEANDRO RIBEIRO ---- 03/01/2019 ---- //
	cAuxEntUF 	:= AllTrim( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion ) )	// ---- LEANDRO RIBEIRO ---- 03/01/2019 ---- //
	If Len( AllTrim( cAuxEntUF ) ) > 2 // Passo da forma descritiva
		//cAuxEntUF := AllTrim( FRetUF( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion ) ) )   // ---- LEANDRO RIBEIRO ---- 03/01/2019 ---- //
		//cAuxEntEstado := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion )					// ---- LEANDRO RIBEIRO ---- 03/01/2019 ---- //
		cAuxEntUF := AllTrim( FRetUF( FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion ) ) )   	// ---- LEANDRO RIBEIRO ---- 03/01/2019 ---- //
		cAuxEntEstado := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cRegion )  					// ---- LEANDRO RIBEIRO ---- 03/01/2019 ---- //
		Conout("UF: "+AllTrim(cAuxEntUF))
		Conout("Estado: "+AllTrim(cAuxEntEstado))
	Else
		cAuxEntEstado := AllTrim( FRetEstado( FTrataTexto( cAuxEntUF ) ) )
		Conout("Estado: "+AllTrim(cAuxEntEstado))
	EndIf
	aAdd( aExecAuto, { "A1_ESTE"		, cAuxEntUF	 , Nil } )
	//aAdd( aExecAuto, { "A1_ESTADO"	, cAuxEntEstado , Nil } )
	aAdd( aExecAuto, { "A1_CEPE"	, oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cPostCode 	 	 	 , Nil } )

	//cAuxDescMun := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cCity )
	//Marcelo Amaral
	cAuxDescMun := FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSShipping_Address:cCity )
	cAuxCodMun  := U_UNIRetMunicipio( cAuxDescMun, cAuxEntUF )
	If AllTrim( cAuxCodMun ) != ""
		aAdd( aExecAuto, { "A1_CODMUNE"	, cAuxCodMun, Nil } )
		//aAdd( aExecAuto, { "A1_CODMUN"	, oParamOrcamentoVenda:oCliente:oEnderercoCobranca:cCodigoMunicipio	 , Nil } )
	Else
		aAdd( aExecAuto, { "A1_CODMUNE", "" , Nil } )
	EndIf
	aAdd( aExecAuto, { "A1_MUNE"	, cAuxDescMun, Nil } )
	//aAdd( aExecAuto, { "A1_ESTADE"	, FTrataTexto( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cRegion ), Nil } )
	//aAdd( aExecAuto, { "A1_CEPE"	, oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cPostCode , Nil } )

	If AllTrim( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cCountry_Id ) == "BR"
		aAdd( aExecAuto, { "A1_PAISE"	, "105"		, Nil } ) // Brasil
	Else
		aAdd( aExecAuto, { "A1_PAISE"	, "994"		, Nil } ) // A Designar
	EndIf

	ConOut( "	UNIWS001 - FCLIENTE 7" )
	aAdd( aExecAuto, { "A1_DDD"			, FRetCliDDD( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cTelephone ), Nil } )
	aAdd( aExecAuto, { "A1_TEL"			, FRetCliTel( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cTelephone ), Nil } )
	aAdd( aExecAuto, { "A1_FAX"			, FRetCliTel( oWS:oWSSalesOrderInfoResult:oWSBilling_Address:cFax )	     , Nil } )
	aAdd( aExecAuto, { "A1_EMAIL"     	, oWS:oWSSalesOrderInfoResult:cCustomer_email			   				 , Nil } )

	aAdd( aExecAuto, { "A1_NATUREZ"    	, "10101"												   				 , Nil } )
	aAdd( aExecAuto, { "A1_TABELA"		, _c_WsTabelaMagento													 , Nil } )

	aAdd( aExecAuto, { "A1_RISCO"		, "E"																	 , Nil } )

	aAdd( aExecAuto, { "A1_CONTA"		, "11201001"																	 , Nil } )

	aAdd( aExecAuto, { "A1_CONTRIB"		, cContrib																 , Nil } )
	aAdd( aExecAuto, { "A1_ENTID"		, cEntId																 , Nil } )

	If AllTrim( cParamIdCliente ) != ""
		aAdd( aExecAuto, { "A1_XIDMAGE"		, cParamIdCliente 														 , Nil } )
	EndIf

	ConOut( "	UNIWS001 - FCLIENTE 8" )
	U_UNIDebugExecAuto( "MATA030", nAuxOpc, aExecAuto )
	lMsErroAuto := .F.
	INCLUI := nAuxOpc == 03
	ALTERA := nAuxOpc == 04
	MsExecAuto( { |x, y| MATA030( x, y ) }, aExecAuto, nAuxOpc )
	If lMsErroAuto

		cMsgErro  := "Erro ao tentar integrar as informações do Cadastro de Clientes oriundas do Pedido [ " + cParamIdPV + " ]"
		cMsgCompl := "Erro ao tentar integrar as informações do Cadastro de Clientes oriundas do Pedido [ " + cParamIdPV + " ]. " + MostraErro( "-", "-" )
		ConOut( "	- UNIWS001 - FIntCliente - " + cMsgCompl )
		cErrorLog 	:= cMsgCompl
		lRet := .F.
		If nAuxOpc == 03
			RollbackSX8()
		EndIf
		cParamError := cMsgCompl

	Else

		ConOut( "	UNIWS001 - FCLIENTE 10" )
		cMsgErro  := "Cliente integrado com sucesso. Codigo [ " + SA1->A1_COD + " / " + SA1->A1_LOJA + " ]."
		cMsgCompl := "Cliente integrado com sucesso. Codigo [ " + SA1->A1_COD + " / " + SA1->A1_LOJA + " ]."
		If nAuxOpc == 03
			ConfirmSX8()
		EndIf
		lRet := .T.
		ConOut( cMsgCompl )
		ConOut( "	- UNIWS001 - FIntCliente - MostraErro - " + MostraErro( "-", "-" ) )

	EndIf

	ConOut( "	UNIWS001 - FCLIENTE 11" )
	RestArea( aAreaAnt )

Return lRet

*----------------------------------------------*
Static Function FRetCondPgto( cParamMetodoPgto )
	*----------------------------------------------*
	Local aAreaAtu 		:= GetArea()
	Local cAliasCond 	:= GetNextAlias()
	//Local cRetCondPgto 	:= ""
	Local cQuery 		:= ""
	Local aRetCond 		:= {}
	cQuery := "		SELECT E4_CODIGO , E4_FORMA  "
	cQuery += "		  FROM " + RetSQLName( "SE4" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	//cQuery += "		 AND UPPER(E4_XIDMAGE) LIKE '%"+AllTrim( Upper( cParamMetodoPgto ) )+"%'"
	cQuery += "		   AND CHARINDEX( '" + AllTrim( Upper( cParamMetodoPgto ) ) + "', UPPER( LTRIM( RTRIM( E4_XIDMAGE ) ) ), 01 ) > 0 "
	If Select( cAliasCond ) > 0
		( cAliasCond )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasCond ) New
	aRetCond := {}
	If !( cAliasCond )->( Eof() )
		aAdd( aRetCond,  ( cAliasCond )->E4_CODIGO )
		aAdd( aRetCond,  ( cAliasCond )->E4_FORMA )
	EndIf
	( cAliasCond )->( DbCloseArea() )

	RestArea( aAreaAtu )

Return aRetCond

//Lucas Miranda de Aguiar
//Função para retornar a admininstradora do cartão em casos de pedido gerado pelo site.
Static Function RetAdm(cBandeira,cTipoCard)

	Local aArea := GetArea()
	Local cAliasADM   := GetNextAlias()
	Local cCodADM     := ""
	Local cQuery      := ""
	Local cSAEDesc	  := ""
	Local cRet		  := ""
	Default cBandeira := ""
	Default cTipoCard := ""

	If cBandeira == "VI"
		cSAEDesc := "VISA"
	ElseIf cBandeira == "MC"
		cSAEDesc := "MASTERCARD"
		//ElseIf cBandeira == "AE"
		//	cSAEDesc := "MASTERCARD"
	ElseIf cBandeira == "DC"
		cSAEDesc := "DINERS CLUB"
	ElseIf cBandeira == "ELO"
		cSAEDesc := "ELO"
	ElseIf cBandeira == "HI"
		cSAEDesc := "HIPERCARD"
	ElseIf cBandeira == "BOLETO"
		cSAEDesc := "BOLETO BANCARIO"
	EndIf



	cQuery := "		SELECT AE_COD "
	cQuery += "		  FROM " + RetSQLName( "SAE" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND AE_TIPO = '"+cTipoCard+"'"
	cQuery += "		   AND AE_DESC = '"+cSAEDesc+"'"
	cQuery := ChangeQuery(cQuery)
	If Select( cAliasADM ) > 0
		( cAliasADM )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasADM ) New
	If !( cAliasADM )->( Eof() )
		cCodADM := (cAliasADM)->AE_COD
	EndIf
	( cAliasADM )->( DbCloseArea() )
	RestArea(aArea)
	If !Empty(AllTrim(cCodADM))
		cRet := AllTrim(cCodADM)+" - " +AllTrim(cSAEDesc)
	EndIf

Return cRet


*------------------------------------------------------*
Static Function FRetDtFormatada( dParamData, cParmTime )
	*------------------------------------------------------*
	Local cRetDt := ""

	cRetDt := Str( Year( dParamData ), 04 ) + "-" +  StrZero( Month( dParamData ), 02 ) + "-" + StrZero( Day( dParamData ), 02 ) + " " + cParmTime

Return cRetDt

*----------------------------------------*
Static Function FTrataTexto( cParamTexto )
	*----------------------------------------*

	//Return( AllTrim( Upper( FwNoAccent( Replace( cParamTexto, "'", "''" ) ) ) ) )  // ---- LEANDRO RIBEIRO ---- 28/11/2019 ---- //

	Local _cRet := AllTrim( Upper( FwNoAccent( Replace( cParamTexto, "'", "''" ) ) ) )  // ---- LEANDRO RIBEIRO ---- 28/11/2019 ---- //

Return(REPLACE(REPLACE(_cRet,CHAR(13) + Char(10) ,' '), CHAR(10), ' ')) // ---- LEANDRO RIBEIRO ---- 28/11/2019 ---- //

*------------------------------------*
Static Function FRetUF( cParamEstado )
	*------------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local cAliasUF  := GetNextAlias()
	Local cRetUF	:= ""
	Local cQuery    := ""

	cQuery := "	SELECT X5_CHAVE "
	cQuery += "	  FROM " + RetSQLName( "SX5" )
	cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "    AND X5_FILIAL  = '" + XFilial( "SX5" ) 	+ "' "
	cQuery += "    AND X5_TABELA  = '12' "
	cQuery += "	   AND X5_DESCRI  = '" + Upper( FwNoAccent( Replace( Replace( AllTrim( cParamEstado ), "  ", " " ) , "'", "''" ) ) ) + "' "
	If Select( cAliasUF ) > 0
		( cAliasUF )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasUF ) New
	If !( cAliasUF )->( Eof() )
		cRetUF := AllTrim( ( cAliasUF )->X5_CHAVE )
	EndIf
	( cAliasUF )->( DbCloseArea() )
	RestArea( aAreaAnt )

Return cRetUF

*------------------------------------*
Static Function FRetEstado( cParamUF )
	*------------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local cAliasUF  := GetNextAlias()
	Local cRetEst	:= ""
	Local cQuery    := ""

	cQuery := "	SELECT X5_DESCRI "
	cQuery += "	  FROM " + RetSQLName( "SX5" )
	cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "    AND X5_FILIAL  = '" + XFilial( "SX5" ) 	+ "' "
	cQuery += "    AND X5_TABELA  = '12' "
	cQuery += "	   AND X5_CHAVE   = '" + Upper( FwNoAccent( AllTrim( cParamUF ) ) ) + "' "
	If Select( cAliasUF ) > 0
		( cAliasUF )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasUF ) New
	If !( cAliasUF )->( Eof() )
		cRetEst := AllTrim( ( cAliasUF )->X5_DESCRI )
	EndIf
	( cAliasUF )->( DbCloseArea() )
	RestArea( aAreaAnt )

Return cRetEst

*------------------------------------------*
Static Function FRetCliDDD( cParamTelefone )
	*------------------------------------------*
	Local cRetDDD			:= ""
	Default cParamTelefone 	:= ""

	cRetDDD			:= Left( AllTrim( cParamTelefone ), 04 )
	If ( Left( cRetDDD, 01 ) == "(" .And. Right( cRetDDD, 01 ) == ")" )

		cRetDDD := Replace( Replace( cRetDDD, "(", "" ), ")", "" )

	Else

		If Len( AllTrim( cParamTelefone ) ) > 9
			If Len( AllTrim( cParamTelefone ) ) >= 11
				cRetDDD := Left( cParamTelefone, 02 )
			Else
				cRetDDD := "--"
			EndIf
		Else
			cRetDDD := "--"
		EndIf

	EndIf

Return cRetDDD

*------------------------------------------*
Static Function FRetCliTel( cParamTelefone )
	*------------------------------------------*
	Local cRetTel			:= ""
	Local cAuxDDD 			:= ""
	Default cParamTelefone 	:= ""

	cAuxDDD	:= Left( AllTrim( cParamTelefone ), 04 )
	If ( Left( cAuxDDD, 01 ) == "(" .And. Right( cAuxDDD, 01 ) == ")" )
		cRetTel := SubStr( AllTrim( cParamTelefone ), 05, Len( AllTrim( cParamTelefone ) ) )
	Else
		cRetTel := Right( AllTrim( cParamTelefone ), TamSX3( "A1_TEL" )[01] )
	EndIf
	cRetTel := Alltrim( Right( cRetTel, 10 ) )

Return cRetTel

Static Function GetCli(cAuxCGC)

	Local aArea := GetArea()
	Local cAliasSA1 := GetNextAlias()
	Local cQuery := ""
	Private aRetCli := {}

	Default cAuxCGC := ""

	cQuery := "		SELECT * "
	cQuery += "		  FROM " + RetSQLName( "SA1" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND A1_CGC = '"+AllTrim(cAuxCGC)+"'"
	If Select( cAliasSA1 ) > 0
		( cAliasSA1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSA1 ) New
	If !( cAliasSA1 )->( Eof() )
		aRetCli := {	{ 	(cAliasSA1)->A1_COD	  , Nil  }, ;
			{ 	 (cAliasSA1)->A1_LOJA , Nil  }, ;
			{ 	 (cAliasSA1)->A1_TIPO , Nil  }, ;
			{ 	 (cAliasSA1)->A1_NOME , Nil  }}
	EndIf
	( cAliasSA1 )->( DbCloseArea() )

	RestArea(aArea)
Return aRetCli

//Lucas Miranda de Aguiar - 14/05/2020 - 14/05/2020
//Alteração para retornar o código da transportadora utilizando o ID magento
*----------------------------------------------*
Static Function RetCodTransp(cAuxShipMethod)
	*----------------------------------------------*
	Local aArea			:= GetArea()
	Local cAliasTransp 		:= GetNextAlias()
	Local cQuery 		:= ""
	Local cRetCod 		:= ""
	Local nBusca		:= 0
	Default	cAuxShipMethod := ""
	cQuery := "		SELECT A4_COD "
	cQuery += "		  FROM " + RetSQLName( "SA4" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND UPPER(A4_XIDMAGE) LIKE '%;"+Upper(AllTrim(cAuxShipMethod))+";%'"
	cQuery := ChangeQuery(cQuery)
	If Select( cAliasTransp ) > 0
		( cAliasTransp )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasTransp ) New
	aRetCond := {}
	If !( cAliasTransp )->( Eof() )
		cRetCod := (cAliasTransp)->A4_COD
	EndIf
	( cAliasTransp )->( DbGoTop() )
	While !( cAliasTransp )->( Eof() )
		nBusca := nBusca + 1
		( cAliasTransp )->( DbSkip() )
	End
	If nBusca > 1
		cRetCod := "ERRO"
	EndIf

	( cAliasTransp )->( DbCloseArea() )

	RestArea(aArea)

Return cRetCod

*----------------------------------------------*
Static Function FRetVendedor( cParamMetodoPgto )
	*----------------------------------------------*
	Local aAreaAtu 		:= GetArea()
	Local cAliasVend 	:= GetNextAlias()
	Local cQuery 		:= ""
	Local aRetVend 		:= {}

	cQuery := "		SELECT A3_COD, A3_COMIS "
	cQuery += "		  FROM " + RetSQLName( "SA3" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND CHARINDEX( '" + AllTrim( Upper( cParamMetodoPgto ) ) + "', UPPER( LTRIM( RTRIM( A3_XIDMAGE ) ) ), 01 ) > 0 "
	If Select( cAliasVend ) > 0
		( cAliasVend )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasVend ) New
	aRetVend := {}
	If !( cAliasVend )->( Eof() )
		aAdd( aRetVend,  ( cAliasVend )->A3_COD 	)
		aAdd( aRetVend,  ( cAliasVend )->A3_COMIS 	)
	EndIf
	( cAliasVend )->( DbCloseArea() )

	RestArea( aAreaAtu )

Return aRetVend

Static Function fSeekId()

	Local aArea := GetArea()
	Local cAliasUNI   := GetNextAlias()
	Local cQuery := ""
	Local lRet := .T.
	Local nRetRecno := 0


	cQuery := "		SELECT R_E_C_N_O_ AS [NUMREC] "
	cQuery += "		  FROM " + RetSQLName( "UNI" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND UNI_IDMAG = '"+AllTrim(cAuxIdPedido)+"'"
	cQuery += "		   AND UNI_STATUS = '"+AllTrim(cStatus)+"'"

	If Select( cAliasUNI ) > 0
		( cAliasUNI )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasUNI ) New
	If !( cAliasUNI )->( Eof() )
		nRetRecNo := ( cAliasUNI )->NUMREC
	EndIf
	( cAliasUNI )->( DbCloseArea() )


	RestArea(aArea)

Return nRetRecno

Static Function fTrataDupli(cAuxShipMethod)

	Local aArea			:= GetArea()
	Local cAliasTransp 		:= GetNextAlias()
	Local cQuery 		:= ""
	Local cRetDupli 		:= ""
	Default	cAuxShipMethod := ""
	cQuery := "		SELECT A4_COD "
	cQuery += "		  FROM " + RetSQLName( "SA4" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND UPPER(A4_XIDMAGE) LIKE '%;"+Upper(AllTrim(cAuxShipMethod))+";%'"
	cQuery := ChangeQuery(cQuery)
	If Select( cAliasTransp ) > 0
		( cAliasTransp )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasTransp ) New
	( cAliasTransp )->( DbGoTop() )
	While !( cAliasTransp )->( Eof() )
		If cRetDupli == ""
			cRetDupli := (cAliasTransp)->A4_COD
		Else
			cRetDupli := cRetDupli + "|" + (cAliasTransp)->A4_COD
		EndIf
		( cAliasTransp )->( DbSkip() )
	End
	( cAliasTransp )->( DbCloseArea() )

	RestArea(aArea)

Return cRetDupli

Static Function GRVAITEM()

	Local aArea := GetArea()
	Local nI := 0

	DbSelectArea("ZZB")
	DbSelectArea("UNI")

	For nI := 01 To Len( oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity )
		RecLock("ZZB",.T.)
		ZZB->ZZB_FILIAL	:= xFilial("ZZB")
		ZZB->ZZB_SKU    := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cSKU
		ZZB->ZZB_QTD    := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cQty_ordered
		ZZB->ZZB_PRECO  := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cPrice
		ZZB->ZZB_DESC   := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cdiscount_amount
		ZZB->ZZB_WGT    := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cWeight
		ZZB->ZZB_ITNID  := oWS:oWSSalesOrderInfoResult:oWSItems:oWSSalesOrderItemEntity[nI]:cItem_Id
		ZZB->ZZB_TABELA := _c_WsTabelaMagento
		ZZB->ZZB_IDMAG  := cAuxIdPedido
		ZZB->ZZB_RECUNI := cXid
		MsUnlock()
	Next nI

	RestArea(aArea)
Return

Static Function fClearVar()

	Local aArea := GetArea()

	cAuxIdPedido        := ""
	cAuxShipMethod      := ""
	cXid                := ""
	cStatus             := ""
	nRecnoUni           := ""
	dAuxDtCreate        := ""
	cAuxIdCliente       := ""
	cAuxCGC             := ""
	nAuxRecNoSA1        := ""
	cAuxError           := ""
	cMethodPagto        := ""
	cBandeira           := ""
	cAuxCondPag         := ""
	cAuxForma           := ""
	cCodTransp          := ""
	cPedMkt             := ""
	cParcelas           := ""
	cTipoCard           := ""
	cL4Adminins         := ""
	_cCodVend2          := ""
	cNSU                := ""
	_cLojaVendedor		:= ""


	nVlrTotal           := 0
	cSkyCode			:= ""
	nVlrDesconto        := 0
	nVlrFrete           := 0
	nVlrProdutos        := 0
	nAuxMoeda           := 0
	nAuxTxMoeda         := 0
	nPercDesc           := 0
	nAuxPercDesc        := 0
	nVlrDesconto        := 0
	nParcelas           := 0
	nLQVLRTOT           := 0
	nAuxComissao        := 0

	aAuxVendedor        := {}
	_aPARTNER_ID        := {}
	aGetCli             := {}
	aAuxCondPag         := {}
	aAuxCond            := {}

	RestArea(aArea)

Return


//Renato Morcerf - 06/07/2021

//Static Function FJaImportog( cParamIdPedido, cParamIdCli )

/*
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
*/
