
/*/{Protheus.doc} UNIWS007

@project Integração Protheus x Magento
@description Rotina híbrida ( Menu / Schedule ) utilizada para realizar a Atualização do Saldo em Estoque no E-Commerce Magento
@wsdl Produção 	  - https://www.unicaarcondicionado.com.br/index.php/api/v2_soap?wsdl=1
      Homologação - https://unicario.com.br/homologacao/index.php/api/v2_soap/?wsdl
@author Rafael Rezende
@since 03/04/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"

User Function UNIWS07S()
	U_UNIWS007( "01", "0207", "", Nil, "" )
Return

*-----------------------------------------------------------------------------------------------*
User Function UNIWS007( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
	*-----------------------------------------------------------------------------------------------*
	Local oFontProc     := Nil
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cPerg         := "UNIWS007"
	Local cTitulo       := "Integração Protheus x Magento - Atualização do Saldo em Estoque"
	Local cTexto        := "<font color='red'> Integração Protheus x Magento </font><br> Esta rotina tem como objetivo realizar a atualização do Saldo em Estoque no E-commerce Magento."
	Private lSchedule 	:= IsBlind()

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Default cParamEmpJob	:= ""
	Default cParamFilJob	:= ""
	Default cParamInstancia	:= ""
	Default oParamWS		:= Nil
	Default cParamNumLoteLog:= ""

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " ####################################################################################### " )
		ConOut( " ## INICIO INTEGRACAO UNIWS007 - ATUALIZACAO Do SALDO EM ESTOQUE - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ####################################################################################### " )

		//Prepare Environment Empresa "01" Filial "0101"
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob )

		//Pergunte( cPerg, .F. )
		MV_PAR01 := Space( TamSX3( "B1_COD" )[01] )
		MV_PAR02 := Replicate( "Z", TamSX3( "B1_COD" )[01] )
		MV_PAR03 := cParamInstancia
		FIntegra( lSchedule, oParamWS, cParamNumLoteLog )

		//Reset Environment
		RPCClearEnv()

		ConOut( " #################################################################################### " )
		ConOut( " ## FIM INTEGRACAO UNIWS007 - ATUALIZACAO DO SALDO EM ESTOQUE - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " #################################################################################### " )

	Else

		// Monta Tela
		//Gerando Perguntas do Parâmetro
		MsgRun( cTitulo, "Aguarde, gerando as perguntas de parâmetros", { || FAjustaSX1( cPerg ) } )
		Pergunte( cPerg, .F. )

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
			Processa( { || FIntegra( lSchedule, Nil, "" ) }, "Conectando com a API do E-Commerce, aguarde..." )
		EndIf

	EndIf

Return


Static function FVldParametros()

	Local lRet := .T.

	If AllTrim( MV_PAR02 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Produto até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR03 ) == ""
		Aviso( "Atenção", "O Parâmetro [ WSDL Magento ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet

*----------------------------------------------------------*
Static Function FIntegra( lSchedule, oWS, cParamNumLoteLog )
	*----------------------------------------------------------*
	//Local oWS 			:= Nil
	Local lEncerra			:= .T.
	Local cEmpFilEstoque 	:= "" //AllTrim( GetNewPar( "MV_XEMPEST", "0101,0207" ) )
	Local cNumLoteLog		:= ""//GetSXENum( "SZ5", "Z5_CODIGO" )
	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""

	If AllTrim( cParamNumLoteLog ) == ""
		cNumLoteLog		:= GetSXENum( "SZ5", "Z5_CODIGO" )
		ConfirmSX8()
		ConOut( "	UNIWS007 - FIntegra - Criou Lote para Log: " + cNumLoteLog )
	Else
		cNumLoteLog		:= cParamNumLoteLog
		ConOut( "	UNIWS007 - FIntegra - Manteve o Lote para Log: " + cNumLoteLog )
	EndIf

	If Type( "_c_WsLnkMagento" ) != "C"

		DbSelectArea( "SZ8" )
		DbSetOrder( 01 )
		Seek XFilial( "SZ8" ) + MV_PAR03
		If Found()

			// Se estiver bloqueado
			If AllTrim( SZ8->Z8_MSBLQL ) == "1"

				cMsgErro 	:= "A Instancia Magento [ " + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + " ] esta bloqueada para uso, a rotina nao sera executada."
				cMsgComp 	:= cMsgErro
				If lSchedule
					ConOut( "	UNIWS007 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS007"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
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
			If AllTrim( _c_WsEmpFilEstoque ) == ""
				_c_WsEmpFilEstoque := AllTrim( GetNewPar( "MV_XEMPEST", "0101,0207" ) )
			EndIf

		Else

			cMsgErro 	:= "Não encontrou uma Instancia válida para a Integração com o Magento [ " + MV_PAR03 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS007 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS007"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
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
		oWs:cApiKey		:= _c_WsPassMagento // AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação

		If !oWs:Login()

			cMsgErro 	:= "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp 	:= "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS007 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS007"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "Atenção", "Erro ao tentar realizar login na API de Integração com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf

		oWs:cSessionId 	:= oWs:cLoginReturn
		lEncerra	   	:= .T.
		ConOut( "	UNIWS007 - FIntegra - Criou nova sessao na API Magento" )

	Else
		lEncerra	   	:= .F.
		ConOut( "	UNIWS007 - FIntegra - Manteve a sessao na API Magento" )
	EndIf

	aListEmpresas   	:= {}
	aAreaSM0 			:= SM0->( GetArea() )
	DbSelectArea( "SM0" )
	DbGoTop()
	Do While !SM0->( Eof() )

		If AllTrim( SM0->M0_CODFIL ) $ _c_WsEmpFilEstoque
			aAdd( aListEmpresas, SM0->M0_CODFIL )
		EndIf

		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo
	RestArea( aAreaSM0 )

	aMultiLojas := {}

	//Verifica o Cadastro de Multilojas
	DbSelectArea( "SZD" )
	DbSetOrder( 01 ) //ZD_FILIAL + ZD_CODIGO + ZD_LOJA
	Seek XFilial( "SZD" ) + _c_WsCodInstancia
	Do While !SZD->( Eof() ) .And. ;
			AllTrim( SZD->ZD_CODIGO ) == AllTrim( _c_WsCodInstancia )

		If AllTrim( SZD->ZD_MSBLQL ) != "1"
			aAdd( aMultiLojas, { SZD->ZD_STORE, SZD->ZD_DESCRIC } )
		EndIf

		DbSelectArea( "SZD" )
		SZD->( DbSkip() )
	EndDo

	If Len( aMultiLojas ) == 0
		aAdd( aMultiLojas, { "1", "Store Default" } )
	EndIf

	For nS := 01 To Len( aMultiLojas )

		ConOut( "	- UNIWS007 - FIntegra - Atualizando Saldos de Multiloja " + aMultiLojas[nS][01] + " - " + aMultiLojas[nS][02] )

		//WSMETHOD catalogProductList WSSEND csessionId,oWScatalogProductListfilters,cstoreView WSRECEIVE oWScatalogProductListstoreView WSCLIENT WSMagentoService
		oWs:cstoreView := aMultiLojas[nS][01]
		If !oWs:CatalogProductList()

			cMsgErro  := "Erro ao tentar acessar a API [ catalogProductList ] no Magento. "
			cMsgCompl := "Erro ao tentar acessar a API [ catalogProductList ] no Magento. " + GetWSCError()
			If lSchedule
				ConOut( "	- UNIWS007 - " + cMsgCompl )
			Else
				Aviso( "Atenção", cMsgCompl, { "Voltar" } )
			EndIf

			U_UNIGrvLog( cNumLoteLog , "", "", "UNIWS007", "FIntegra", cMsgErro	, cMsgCompl, "", 0 )
			If lEncerra
				oWS:EndSession()
			EndIf
			ConOut( "	UNIWS007 - FIntegra - Encerrou a sessao do Magento" )
			Loop

		EndIf

		nTamB1_COD := TamSX3( "B1_COD" )[01]
		aAuxProdutos := {}
		For nZ := 01 To Len( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity  )

			cAuxProduto := PadR( AllTrim( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity[nZ]:cSku ), nTamB1_COD )
			If FVerFlag( cAuxProduto )
				aAdd( aAuxProdutos, { PadR( AllTrim( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity[nZ]:cSku ), nTamB1_COD ), oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity[nZ]:cProduct_Id } )
			Else
				cONoUT( "	UNIWS007 - FIntegra - SKU [ " + AllTrim( cAuxProduto ) + " ] sem alteracao de estoque, nao sera atualizado no Magento" )
			EndIf
		Next nZ

		DbSelectArea( "SB1" )
		DbSetOrder( 01 ) // B1_FILIAL + B1_COD

		If !lSchedule
			ProcRegua( Len( aAuxProdutos ) )
		Else
			ConOut( "		UNIWS007 - [ " + StrZero( Len( aAuxProdutos ), 05 ) + " ] - Produtos a processar." )
		EndIf

		For nW := 01 To Len( aAuxProdutos )

			/**
		WSSTRUCT MagentoService_catalogProductEntity
			WSDATA   cproduct_id               AS string OPTIONAL
			WSDATA   csku                      AS string OPTIONAL
			WSDATA   cname                     AS string OPTIONAL
			WSDATA   cset                      AS string OPTIONAL
			WSDATA   ctype                     AS string OPTIONAL
			WSDATA   oWScategory_ids           AS MagentoService_ArrayOfString OPTIONAL
			WSDATA   oWSwebsite_ids            AS MagentoService_ArrayOfString OPTIONAL
			WSMETHOD NEW
			WSMETHOD INIT
			WSMETHOD CLONE
			WSMETHOD SOAPRECV
		ENDWSSTRUCT

			*/
			If !lSchedule
				IncProc( "Atualizando saldo do estoque no Magento, aguarde..." )
			EndIf

			DbSelectArea( "SB1" )
			Seek XFilial( "SB1" ) + aAuxProdutos[nW][01] //PadR( AllTrim( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nW]:csku ), nTamB1_COD )
			If Found()

				ConOut( "	- UNIWS007 - SKU    - " + SB1->B1_COD )
				nAuxSaldo := 0
				For nY := 01 To Len( aListEmpresas )
					nAuxSaldo 	+= U_UNIRetSldProd( aListEmpresas[nY], SB1->B1_TIPO, SB1->B1_COD )
					ConOut( "	- UNIWS007 - UNIRetSldProd - Filial [ " + aListEmpresas[nY] + " ] - " + AllTrim( Str( nAuxSaldo ) ) )
				Next nY

				// Verifica se o Produto já foi importado para o e-commerce
				//WSMETHOD catalogProductUpdate WSSEND csessionId,cproduct,oWScatalogProductUpdateproductData,cstoreView,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService

				//Atualiza o Preço do Produto
				oWS:cProduct 			:= aAuxProdutos[nW][02] // oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nW]:cProduct_Id //AllTrim( ( cAliasSB1 )->B1_XIDMAGE )
				oWS:cStoreView 			:= aMultiLojas[nS][01] // "1"
				oWS:cIdentifierType     := ""

				/*
			WSSTRUCT MagentoService_catalogProductCreateEntity
				WSDATA   oWScategories             AS MagentoService_ArrayOfString OPTIONAL
				WSDATA   oWSwebsites               AS MagentoService_ArrayOfString OPTIONAL
				WSDATA   cname                     AS string OPTIONAL
				WSDATA   cdescription              AS string OPTIONAL
				WSDATA   cshort_description        AS string OPTIONAL
				WSDATA   cweight                   AS string OPTIONAL
				WSDATA   cstatus                   AS string OPTIONAL
				WSDATA   curl_key                  AS string OPTIONAL
				WSDATA   curl_path                 AS string OPTIONAL
				WSDATA   cvisibility               AS string OPTIONAL
				WSDATA   oWScategory_ids           AS MagentoService_ArrayOfString OPTIONAL
				WSDATA   oWSwebsite_ids            AS MagentoService_ArrayOfString OPTIONAL
				WSDATA   chas_options              AS string OPTIONAL
				WSDATA   cgift_message_available   AS string OPTIONAL
				WSDATA   cprice                    AS string OPTIONAL
				WSDATA   cspecial_price            AS string OPTIONAL
				WSDATA   cspecial_from_date        AS string OPTIONAL
				WSDATA   cspecial_to_date          AS string OPTIONAL
				WSDATA   ctax_class_id             AS string OPTIONAL
				WSDATA   oWStier_price             AS MagentoService_catalogProductTierPriceEntityArray OPTIONAL
				WSDATA   cmeta_title               AS string OPTIONAL
				WSDATA   cmeta_keyword             AS string OPTIONAL
				WSDATA   cmeta_description         AS string OPTIONAL
				WSDATA   ccustom_design            AS string OPTIONAL
				WSDATA   ccustom_layout_update     AS string OPTIONAL
				WSDATA   coptions_container        AS string OPTIONAL
				WSDATA   oWSadditional_attributes  AS MagentoService_catalogProductAdditionalAttributesEntity OPTIONAL
				WSDATA   oWSstock_data             AS MagentoService_catalogInventoryStockItemUpdateEntity OPTIONAL
				WSMETHOD NEW
				WSMETHOD INIT
				WSMETHOD CLONE
				WSMETHOD SOAPSEND
			ENDWSSTRUCT
				*/

				oWS:oWScatalogProductUpdateproductData 						:= WsClassNew( "MagentoService_catalogProductCreateEntity" )
				oWS:oWScatalogProductUpdateproductData:oWSstock_data		:= WsClassNew( "MagentoService_catalogInventoryStockItemUpdateEntity" )
				//oWS:oWSstock_data:nmin_sale_qty		:= 0
				//oWS:oWSstock_data:nmax_sale_qty		:= 0
				//oWS:oWSstock_data:nnotify_stock_qty := 0

				/*
			WSSTRUCT MagentoService_catalogInventoryStockItemUpdateEntity
				WSDATA   cqty                      AS string OPTIONAL
				WSDATA   nis_in_stock              AS int OPTIONAL
				WSDATA   nmanage_stock             AS int OPTIONAL
				WSDATA   nuse_config_manage_stock  AS int OPTIONAL
				WSDATA   nmin_qty                  AS int OPTIONAL
				WSDATA   nuse_config_min_qty       AS int OPTIONAL
				WSDATA   nmin_sale_qty             AS int OPTIONAL
				WSDATA   nuse_config_min_sale_qty  AS int OPTIONAL
				WSDATA   nmax_sale_qty             AS int OPTIONAL
				WSDATA   nuse_config_max_sale_qty  AS int OPTIONAL
				WSDATA   nis_qty_decimal           AS int OPTIONAL
				WSDATA   nbackorders               AS int OPTIONAL
				WSDATA   nuse_config_backorders    AS int OPTIONAL
				WSDATA   nnotify_stock_qty         AS int OPTIONAL
				WSDATA   nuse_config_notify_stock_qty AS int OPTIONAL
				WSMETHOD NEW
				WSMETHOD INIT
				WSMETHOD CLONE
				WSMETHOD SOAPSEND
			ENDWSSTRUCT
				*/
				oWs:oWScatalogProductUpdateproductData:oWSstock_data := WsClassNew( "MagentoService_catalogInventoryStockItemUpdateEntity" )
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:cQty						:= cValToChar( nAuxSaldo )
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nis_in_stock				:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nmanage_stock  			:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nuse_config_manage_stock	:= 1
				//oWS:oWScatalogProductUpdateproductData:oWSstock_data:nmin_qty					:= 0
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nuse_config_min_qty 		:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nmin_sale_qty              := 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nuse_config_min_sale_qty  	:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nmax_sale_qty             	:= 1000 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nuse_config_max_sale_qty  	:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nis_qty_decimal           	:= 0 //AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nbackorders               	:= 1 //AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nuse_config_backorders   	:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nnotify_stock_qty         	:= 1 // AS int OPTIONAL
				oWS:oWScatalogProductUpdateproductData:oWSstock_data:nuse_config_notify_stock_qty	:= 1 // AS int OPTIONAL
				If nAuxSaldo > 0
					oWS:oWScatalogProductUpdateproductData:oWSstock_data:nis_in_stock := 1
				Else
					oWS:oWScatalogProductUpdateproductData:oWSstock_data:nis_in_stock := 0
				EndIf

				If !oWS:CatalogProductUpdate()

					cMsgErro := "Erro ao tentar atualizar o estoque do Produto [ " + AllTrim( SB1->B1_COD ) + " ] com o WS [ catalogProductUpdate ] "
					cMsgCompl := "Erro ao tentar atualizar o estoque do Produto [ " + AllTrim( SB1->B1_COD ) + " ] com o WS [ catalogProductUpdate ] " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
					If lSchedule
						ConOut( "UNIWS007 - " + cMsgCompl )
					Else
						Aviso( "Atenção", cMsgCompl, { "Continuar" } )
					EndIf
					U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS007", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

				Else

					// Atualiza produto ( Sem ser Kit )
					cUpdate := "	UPDATE " + RetSQLName( "SB2" )
					cUpdate += "	   SET B2_XFLGMAG = ' ' "
					cUpdate += "	 WHERE D_E_L_E_T_ = ' ' "
					cUpdate += "	   AND B2_FILIAL  = '" + XFilial( "SB2" ) 	+ "' "
					cUpdate += "	   AND B2_COD  	  = '" + SB1->B1_COD 		+ "' "
					If TcSQLExec( cUpdate ) != 0

						cMsgErro  := "Erro ao tentar remover o flag do Magento para o Estoque do produto [ " + AllTrim( SB1->B1_COD ) + " ]"
						cMsgCompl := cMsgErro + " - Erro: " + TcSQLError()
						If lSchedule
							ConOut( "UNIWS007 - " + cMsgCompl )
						Else
							Aviso( "Atenção", cMsgCompl, { "Continuar" } )
						EndIf
						U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS007", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

					EndIf


					// Atualiza caso produto seja um Kit
					cUpdate := "	UPDATE " + RetSQLName( "SB2" )
					cUpdate += "	   SET B2_XFLGMAG = ' ' "
					cUpdate += "	 WHERE D_E_L_E_T_ = ' ' "
					cUpdate += "	   AND B2_FILIAL  = '" + XFilial( "SB2" ) 	+ "' "
					cUpdate += "	   AND B2_COD	 IN ( SELECT DISTINCT MEV_PRODUT "
					cUpdate += "	        			    FROM " + RetSQLName( "MEV" ) + " MEV ( NOLOCK ) "
					cUpdate += "	                       WHERE D_E_L_E_T_ = ' ' "
					cUpdate += "				             AND MEV_FILIAL = '" + XFilial( "MEV" )  + "'   "
					cUpdate += "	        			     AND MEV_CODKIT = '" + SB1->B1_COD 		 + "' ) "
					If TcSQLExec( cUpdate ) != 0

						cMsgErro  := "Erro ao tentar remover o flag do Magento para o Estoque do produto [ " + AllTrim( SB1->B1_COD ) + " ]"
						cMsgCompl := cMsgErro + " - Erro: " + TcSQLError()
						If lSchedule
							ConOut( "UNIWS007 - " + cMsgCompl )
						Else
							Aviso( "Atenção", cMsgCompl, { "Continuar" } )
						EndIf
						U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS007", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

					EndIf

					cMsgErro  := "Estoque atualizado com sucesso [ " + AllTrim( SB1->B1_COD ) + " ] - Estoque: " + TransForm( nAuxSaldo, "@E 999,999,999.99" )
					cMsgCompl := "Estoque atualizado com sucesso [ " + AllTrim( SB1->B1_COD ) + " ] - Estoque: " + TransForm( nAuxSaldo, "@E 999,999,999.99" )
					If lSchedule
						ConOut( "UNIWS007 - " + cMsgCompl )
					EndIf
					U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS007", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

				EndIf

			EndIf

		Next nI

	Next nS

	If lEncerra
		oWS:EndSession()
		ConOut( "	UNIWS007 - FIntegra - Encerrou a sessao no Magento" )
	EndIf

Return

*----------------------------------------------------*
Static Function FVerFlag( cParamProduto, cParamAlias )
	*----------------------------------------------------*
	Local aAreaAnt 		:= GetArea()
	Local lRetFlag 		:= .F.
	Local cQuery   		:= ""
	Default cParamAlias := GetNextAlias()

	cQuery := " 	SELECT SUM( NACHOU ) AS NACHOU "
	cQuery += "		  FROM ( "

	cQuery += " 				SELECT COUNT( * ) AS NACHOU "
	cQuery += "					  FROM " + RetSQLName( "SB2" ) + " SB2 ( NOLOCK ) "
	cQuery += "				 	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "				 	   AND B2_FILIAL  = '" + XFilial( "SB2" ) + "' "
	cQuery += " 				   AND B2_COD	  = '" + cParamProduto	  + "' "
	cQuery += "				 	   AND B2_XFLGMAG = 'S' "

	cQuery += "				 	 UNION "

	cQuery += "				 	SELECT COUNT( * ) AS NACHOU "
	cQuery += "					  FROM " + RetSQLName( "SB2" ) + " SB2 ( NOLOCK ) "
	cQuery += "				 	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "				 	   AND B2_FILIAL  = '" + XFilial( "SB2" ) + "' "
	cQuery += "				 	   AND B2_XFLGMAG = 'S' "
	cQuery += "				 	   AND B2_COD	 IN ( SELECT DISTINCT MEV_PRODUT "
	cQuery += " 	        			                FROM " + RetSQLName( "MEV" ) + " MEV ( NOLOCK ) "
	cQuery += " 	                    			   WHERE D_E_L_E_T_ = ' ' "
	cQuery += " 				                         AND MEV_FILIAL = '" + XFilial( "MEV" )  + "'   "
	cQuery += " 	        			                 AND MEV_CODKIT = '" + cParamProduto	 + "' ) "

	cQuery += "		       ) AS A
	If Select( cParamAlias ) > 0
		( cParamAlias )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cParamAlias ) New
	If !( cParamAlias )->( Eof() )
		lRetFlag := ( cParamAlias )->NACHOU > 0
	EndIf
	( cParamAlias )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return lRetFlag
