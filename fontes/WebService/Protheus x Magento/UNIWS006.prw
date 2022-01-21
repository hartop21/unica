
/*/{Protheus.doc} UNIWS006

@project Integrao Protheus x Magento
@description Rotina hbrida ( Menu / Schedule ) utilizada para realizar a Atualizao da tabela de Preos no E-Commerce Magento
@wsdl Produo 	  - https://www.unicaarcondicionado.com.br/index.php/api/v2_soap?wsdl=1
      Homologao - https://unicario.com.br/homologacao/index.php/api/v2_soap/?wsdl
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

User Function UNIWS06S()
	U_UNIWS006( "01", "0207", Nil, "" )
Return

*-----------------------------------------------------------------------------------------------*
User Function UNIWS006( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
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
	Local cPerg         := "UNIWS006"
	Local cTitulo       := "Integrao Protheus x Magento - Atualizao da Tabela de Preos"
	Local cTexto        := "<font color='red'> Integrao Protheus x Magento </font><br> Esta rotina tem como objetivo realizar a atualizao do Cadastro de Preos no E-commerce Magento."
	Private lSchedule 	:= IsBlind()

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Default cParamEmpJob	 := ""
	Default cParamFilJob	 := ""
	Default cParamInstancia  := ""
	Default oParamWS		 := Nil
	Default cParamNumLoteLog := ""

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " ####################################################################################### " )
		ConOut( " ## INICIO INTEGRACAO UNIWS006 - ATUALIZACAO DA TABELA DE PRECOS - " + DToC( Date() ) + " " + Time() + " ##" )
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
		ConOut( " ## FIM INTEGRACAO UNIWS006 - ATUALIZACAO DA TABELA DE PRECOS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " #################################################################################### " )

	Else

		// Monta Tela
		//Gerando Perguntas do Parmetro
		MsgRun( cTitulo, "Aguarde, gerando as perguntas de parmetros", { || FAjustaSX1( cPerg ) } )
		Pergunte( cPerg, .F. )

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Integrar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 083, "&Parmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oDlgProc:Activate( ,,,.T. )

		If lConfirmou
			Processa( { || FIntegra( lSchedule ) }, "Conectando com a API do E-Commerce, aguarde..." )
		EndIf

	EndIf

Return


Static function FVldParametros()

	Local lRet := .T.

	If AllTrim( MV_PAR02 ) == ""
		Aviso( "Ateno", "O Parmetro [ Produto at ? ]  obrigatrio.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR03 ) == ""
		Aviso( "Ateno", "O Parmetro [ WSDL Magento ? ]  obrigatrio.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet

*----------------------------------------------------------*
Static Function FIntegra( lSchedule, oWS, cParamNumLoteLog )
	*----------------------------------------------------------*
	//Local oWS 			:= Nil
	Local cAliasPrc         := GetNextAlias()
	Local lEncerra 			:= .T.
	Local cTabEcommerce		:= "" //_c_WsTabelaMagento //PadR( GetNewPar( "MV_XTABECO", "001" ), TamSX3( "DA0_CODTAB" )[01] )
	Local nZ  				:= 0
	//Local cParamTabela 		:= PadR( AllTrim( GetNewPar( "MV_XTABPAD", "001" ) ), TamSX3( "DA1_CODTAB" )[01] )

	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""

	If AllTrim( cParamNumLoteLog ) == ""
		cNumLoteLog				:= GetSXENum( "SZ5", "Z5_CODIGO" )
		ConfirmSX8()
		ConOut( "	UNIWS006 - FIntegra - Criou novo Lote de Log: " + cNumLoteLog )
	Else
		cNumLoteLog				:= cParamNumLoteLog
		ConOut( "	UNIWS006 - FIntegra - Manteve o Lote de Log: " + cNumLoteLog )
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
					ConOut( "	UNIWS006 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS006"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
					Return
				Else
					Aviso( "Ateno", cMsgComp, { "Voltar" } )
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

			cMsgErro 	:= "No encontrou uma Instancia valida para a Integrao com o Magento [ " + MV_PAR03 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS006 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS006"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "Ateno", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	aMultiLojas := {}

	//Atribui a tabela de Preos do E-commerce
	cTabEcommerce := _c_WsTabelaMagento

	If oWS == Nil

		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cUserName	:= _c_WsUserMagento
		oWs:cApiKey		:= _c_WsPassMagento
		If !oWs:Login()

			cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS006 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS006"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "Ateno", "Erro ao tentar realizar login na API de Integrao com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf
		oWs:cSessionId := oWs:cLoginReturn
		lEncerra 			:= .T.
		ConOut( "	UNIWS006 - FIntegra - Criou nova sessao na API Mageto" )

	Else
		lEncerra 			:= .F.
		ConOut( "	UNIWS006 - FIntegra - Manteve a sessao na API Mageto" )
	EndIf


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

	nTamB1_COD := TamSX3( "B1_COD" )[01]
	For nS := 01 To Len( aMultiLojas )

		ConOut( "	- UNIWS006 - FIntegra - Atualizando preos na Multiloja " + aMultiLojas[nS][01] + " - " + aMultiLojas[nS][02] )

		//WSMETHOD catalogProductList WSSEND csessionId,oWScatalogProductListfilters,cstoreView WSRECEIVE oWScatalogProductListstoreView WSCLIENT WSMagentoService
		oWs:cStoreView := aMultiLojas[nS][01]
		If !oWs:CatalogProductList()

			cMsgErro  := "Erro ao tentar acessar a API [ catalogProductList ] no Magento. "
			cMsgCompl := "Erro ao tentar acessar a API [ catalogProductList ] no Magento. " + GetWSCError()
			If lSchedule
				ConOut( "	- UNIWS006 - " + cMsgCompl )
			Else
				Aviso( "Ateno", cMsgCompl, { "Voltar" } )
			EndIf
			U_UNIGrvLog( cNumLoteLog  , ""			, ""			 , "UNIWS006"  , "FIntegra"	 , cMsgErro		  , cMsgCompl	, ""		 , 0 )
			If lEncerra
				oWS:EndSession()
			EndIf
			ConOut( "	UNIWS006 - FIntegra - Encerrou a sessao do Magento" )
			Loop

		EndIf

		aAuxProdutos := {}
		For nZ := 01 To Len( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity  )
			aAdd( aAuxProdutos, { PadR( AllTrim( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity[nZ]:cSku ), nTamB1_COD ), oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity[nZ]:cProduct_Id } )
		Next nZ

		If !lSchedule
			ProcRegua( Len( aAuxProdutos ) )
		Else
			ConOut( "		UNIWS006 - [ " + StrZero( Len( aAuxProdutos ), 05 ) + " ] - Produtos a processar." )
		EndIf

		For nZ := 01 To Len( aAuxProdutos )

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
				IncProc( "Atualizando tabela de preos no Magento, aguarde..." )
			EndIf

			If aAuxProdutos[nZ][01] == Nil .Or. aAuxProdutos[nZ][02] == Nil
				ConOut( "	- UNIWS006 - Produto Sem SKU / ID Produto no Magento... No ser importado" )
				Loop
			EndIf
			If AllTrim( aAuxProdutos[nZ][01] ) == "" .Or. AllTrim( aAuxProdutos[nZ][02] ) == ""
				ConOut( "	- UNIWS006 - Produto Sem SKU / ID Produto no Magento... No ser importado" )
				Loop
			EndIf

			ConOut( "	- UNIWS006 - SKU    - " + AllTrim( aAuxProdutos[nZ][01] ) )
			ConOut( "	- UNIWS006 - TABELA - " + cTabEcommerce )
			ConOut( "	- UNIWS006 - FILIAL - " + XFilial( "DA1" ) )

			nAuxPreco := 0
			nAuxRecNo := 0
			cQuery 	  := "		SELECT DA1_PRCVEN, R_E_C_N_O_ AS NUMRECDA1 "
			cQuery 	  += "		  FROM " + RetSQLName( "DA1" ) + " (NOLOCK) "
			cQuery 	  += "		 WHERE D_E_L_E_T_ 	= ' ' "
			cQuery 	  += "		   AND DA1_FILIAL   = '" + XFilial( "DA1" ) 			   + "' "
			cQuery 	  += "		   AND DA1_CODTAB   = '" + cTabEcommerce				   + "' "
			cQuery 	  += "		   AND DA1_CODPRO	= '" + AllTrim( aAuxProdutos[nZ][01] ) + "' "
			cQuery 	  += "		   AND DA1_XFLGMA 	= 'S' "
			If Select( cAliasPrc ) > 0
				( cAliasPrc )->( DbCloseArea() )
			EndIf
			TcQuery cQuery Alias ( cAliasPrc ) New
			If !( cAliasPrc )->( Eof() )
				nAuxPreco := ( cAliasPrc )->DA1_PRCVEN
				nAuxRecNo := ( cAliasPrc )->NUMRECDA1
			Else
				ConOut( "	- UNIWS006 - Nao encontrou alteracao de preco para o Produto" )
				Loop
			EndIf
			( cAliasPrc )->( DbCloseArea() )

			ConOut( "	- UNIWS006 - Preco  - " + AllTrim( TransForm( nAuxPreco, "@E 999,999,999.99" ) ) )
			If nAuxPreco == 0

				ConOut( "	- UNIWS006 - Nao atualiza o Item, pois o Preo esta zerado."  )
				cMsgErro  := "Erro ao tentar atualizar o preco do Produto " + AllTrim( aAuxProdutos[nZ][01] ) + ". Preco esta zerado. "
				cMsgCompl := cMsgErro
				If lSchedule
					ConOut( "UNIWS006 - " + cMsgCompl )
				Else
					Aviso( "Ateno", cMsgCompl, { "Continuar" } )
				EndIf
				U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS006", "FIntegra", cMsgErro, cMsgCompl, "", 0 )
				Loop

			EndIf

			// Verifica se o Produto j foi importado para o e-commerce
			// WSMETHOD catalogProductUpdate WSSEND csessionId,cproduct,oWScatalogProductUpdateproductData,cstoreView,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService

			//Atualiza o Preo do Produto
			oWS:cProduct 			:= aAuxProdutos[nZ][02] // oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity[nZ]:cProduct_Id //AllTrim( ( cAliasSB1 )->B1_XIDMAGE )
			//oWS:cProductId 		:= AllTrim( ( cAliasSB1 )->B1_XIDMAGE )
			oWS:cStoreView 			:= aMultiLojas[nS][01] //"1" // ?????
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
			oWS:oWSCatalogProductUpdateProductData 					:= WsClassNew( "MagentoService_catalogProductCreateEntity" )
			oWS:oWSCatalogProductUpdateProductData:cPrice 			:= Str( nAuxPreco )
			//oWS:oWSCatalogProductUpdateProductData:cSpecial_Price 	:= ""
			//oWS:oWScatalogProductUpdateproductData:oWStier_price := {}
			//aAdd( oWS:oWScatalogProductUpdateproductData:oWStier_price, WsClassNew( "MagentoService_catalogProductTierPriceEntity" ) )
			//aTail( oWS:oWScatalogProductUpdateproductData:oWStier_price ):ccustomer_group_id := ""
			//aTail( oWS:oWScatalogProductUpdateproductData:oWStier_price ):cwebsite           := ""
			//aTail( oWS:oWScatalogProductUpdateproductData:oWStier_price ):nqty               := 0
			//aTail( oWS:oWScatalogProductUpdateproductData:oWStier_price ):nprice             := 0

			If !oWS:CatalogProductUpdate()

				cMsgErro  := "Erro ao tentar atualizar o preco do Produto " + AllTrim( aAuxProdutos[nZ][01] ) + " com o WS [ catalogProductUpdate ] "
				cMsgCompl := "Erro ao tentar atualizar o preco do Produto " + AllTrim( aAuxProdutos[nZ][01] ) + " com o WS [ catalogProductUpdate ] " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
				If lSchedule
					ConOut( "UNIWS006 - " + cMsgCompl )
				Else
					Aviso( "Ateno", cMsgCompl, { "Continuar" } )
				EndIf
				U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS006", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

			Else

				cMsgErro  := "Preco atualizado com sucesso [ " + AllTrim( aAuxProdutos[nZ][01] ) + " ] - Novo Preco: " + TransForm( nAuxPreco, "@E 999,999,999.99" )
				cMsgCompl := "Preco atualizado com sucesso [ " + AllTrim( aAuxProdutos[nZ][01] ) + " ] - Novo Preco: " + TransForm( nAuxPreco, "@E 999,999,999.99" )
				If lSchedule
					ConOut( "UNIWS006 - " + cMsgCompl )
				EndIf
				U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS006", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

				If nAuxRecNo > 0

					DbSelectArea( "DA1" )
					DA1->( DbGoTo( nAuxRecNo ) )
					RecLock( "DA1", .F. )
					DA1->DA1_XFLGMA := " "
					DA1->( MsUnLock() )

				EndIf

			EndIf

		Next nZ

	Next nS

	If lEncerra
		oWS:EndSession()
		ConOut( "	UNIWS006 - FIntegra - Encerrou a sessao do Magento" )
	EndIf

Return

