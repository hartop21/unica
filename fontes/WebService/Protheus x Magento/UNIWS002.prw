
/*/{Protheus.doc} UNIWS002

@project Integração Protheus x Magento
@description Rotina híbrida ( Menu / Schedule ) utilizada para realizar a Inclusão de Produtos no E-Commerce Magento
@wsdl https://www.unicaarcondicionado.com.br/index.php/api/v2_soap?wsdl=1
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

User Function UNIWS02S()
	U_UNIWS002( "01", "0207", "", Nil, "" )
Return

*-----------------------------------------------------------------------------------------------*
User Function UNIWS002( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
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
	Local cPerg         := "UNIWS002"
	Local cTitulo       := "Integração Protheus x Magento - Exportação Cadastro de Produtos"
	Local cTexto        := "<font color='red'> Integração Protheus x Magento </font><br> Esta rotina tem como objetivo realizar a exportação do Cadastro de Produtos para o E-commerce Magento.<br>Os produtos marcados com o Flag <font color='green'>E-commerce = Ativo </font> serão exportados.<br> Informe os parâmetros desejados e confirme a exportação."
	Private lSchedule 	:= .F. //IsBlind()

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	//Default aParams 		 := {}
	Default cParamEmpJob	 := ""
	Default cParamFilJob	 := ""
	Default cParamInstancia  := ""
	Default oParamWS    	 := Nil
	Default cParamNumLoteLog := ""

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " ####################################################################################### " )
		ConOut( " ## INICIO INTEGRACAO UNIWS002 - EXPORTACAO CADASTRO DE PRODUTOS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ####################################################################################### " )
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob )

		//Pergunte( cPerg, .F. )
		MV_PAR01 := Space( TamSX3( "B1_COD" )[01] )
		MV_PAR02 := Replicate( "Z", TamSX3( "B1_COD" )[01] )
		MV_PAR03 := cParamInstancia
		FIntegra( lSchedule, oParamWS, cParamNumLoteLog )

		Reset Environment

		ConOut( " #################################################################################### " )
		ConOut( " ## FIM INTEGRACAO UNIWS002 - EXPORTACAO CADASTRO DE PRODUTOS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " #################################################################################### " )

	Else

		// Monta Tela

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Exportar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
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
	//Local oWS 		 		:= Nil
	Local lEncerra			:= .T.
	Local cTabEcommerce		:= PadR( GetNewPar( "MV_XTABECO", "001" ), TamSX3( "DA0_CODTAB" )[01] )
	Private cNumLoteLog		:= "" //GetSXENum( "SZ5", "Z5_CODIGO" )
	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""

	If AllTrim( cParamNumLoteLog ) == ""
		cNumLoteLog			:= GetSXENum( "SZ5", "Z5_CODIGO" )
		ConfirmSX8()
		ConOut( "	UNIWS002 - FIntegra - Gerou Lote para o Log: " + cNumLoteLog )
	Else
		cNumLoteLog 		:= cParamNumLoteLog
		ConOut( "	UNIWS002 - FIntegra - Reaproveitou o Lote para o Log: " + cNumLoteLog )
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
					ConOut( "	UNIWS002 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS002"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
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
				ConOut( "	UNIWS002 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS002"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "Atenção", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	If oWS == Nil

		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cusername	:= _c_WsUserMagento //AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
		//oWs:capiKey	:= AllTrim( GetNewPar( "MV_XPSWMAG", "suporte#2019" ) ) //Produção
		oWs:capiKey		:= _c_WsPassMagento // AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação
		If !oWs:login()

			cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS002 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS002"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "Atenção", "Erro ao tentar realizar login na API de Integração com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf
		oWs:cSessionId := oWs:cloginReturn
		lEncerra	:= .T.
		ConOut( "	UNIWS002 - FIntegra - Criou nova Sessao de API com o Magento" )

	Else

		lEncerra	:= .F.
		ConOut( "	UNIWS002 - FIntegra - Manteve a Sessao de API" )

	EndIf

	//Verifica o Cadastro de Multilojas
	cAuxStore := "1"

	DbSelectArea( "SZD" )
	DbSetOrder( 01 ) //ZD_FILIAL + ZD_CODIGO + ZD_LOJA
	Seek XFilial( "SZD" ) + _c_WsCodInstancia
	If Found()

		Do While !SZD->( Eof() ) .And. ;
				AllTrim( SZD->ZD_CODIGO ) == AllTrim( _c_WsCodInstancia )

			If AllTrim( SZD->ZD_MSBLQL ) == "2"
				ConOut( "	UNIWS002 - FIntegra - Encontrou uma Store Cadastrada na Multiloja - " + SZD->ZD_STORE )

				cAuxStore := AllTrim( SZD->ZD_STORE )

				If AllTrim( cAuxStore ) == ""
					ConOut( "	UNIWS002 - FIntegra - Store da Multiloja em branco. Vai assumir a loja Default - 1" )
					cAuxStore := AllTrim( SZD->ZD_STORE )
				Else
					Exit
				EndIf

			EndIf
			DbSelectArea( "SZD" )
			SZD->( DbSkip() )
		EndDo

	Else

		ConOut( "	UNIWS002 - FIntegra - Não encontrou uma Store Cadastrada na Multiloja. Vai assumir a loja Default - 1 " )
		cAuxStore := "1"

	EndIf

	cQuery := "				  SELECT SB1.*, "
	cQuery += "						 LTRIM( RTRIM( CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B5_ECAPRES ) ) ) ) AS B5_ECAPRES, "
	cQuery += "						 LTRIM( RTRIM( CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B5_ECDESCR ) ) ) ) AS B5_ECDESCR, "
	cQuery += "						 LTRIM( RTRIM( CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B5_ECCARAC ) ) ) ) AS B5_ECCARAC, "
	cQuery += "						 LTRIM( RTRIM( CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B5_ECINDIC ) ) ) ) AS B5_ECINDIC, "
	cQuery += "						 B5_PESO	, "
	cQuery += "						 B5_ECPCHAV	, "
	cQuery += "						 B5_ECPCHAV	, "
	cQuery += "						 B5_ECTITU 	  "
	cQuery += "		  			FROM " + RetSQLName( "SB1" ) + " SB1 "
	cQuery += "		 LEFT OUTER JOIN " + RetSQLName( "SB5" ) + " SB5 "
	cQuery += "		              ON B1_COD = B5_COD 			 "
	cQuery += "				   WHERE SB1.D_E_L_E_T_ = ' ' 			 "
	cQuery += "				     AND SB5.D_E_L_E_T_ = ' ' 			 "
	cQuery += "				     AND B1_FILIAL 		= '" + XFilial( "SB1" ) + "' "
	cQuery += "				     AND B5_FILIAL 		= '" + XFilial( "SB5" ) + "' "
	cQuery += "					 AND B5_ECFLAG      = '1' " // E-commerce = Ativo
	//cQuery += "					 AND LTRIM( RTRIM( B1_XIDMAGE ) ) = '' "
	cQuery += "					 AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "					 AND CHARINDEX( '" + MV_PAR03 + "', B1_XIDMAGE, 01 ) = 0 "
	//cQuery += "				 AND B1_COD			= '5123' "

	cAliasSB1 := GetNextAlias()
	If Select( cAliasSB1 ) > 0
		( cAliasSB1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSB1 ) New
	If ( cAliasSB1 )->( Eof() )
		If !lSchedule
			Aviso( "Atenção", "Não encontrou Produtos para Exportar.", { "Sair" } )
		Else
			ConOut( "	- UNIWS007 - FIntegra - Nao encontrou Produtos para Exportar. Verifique se os Produtos estao com o Id Magento Preenchido." )
		EndIf
	EndIf
	If !lSchedule
		nConta := 0
		Count To nConta
		ProcRegua( nConta )
	EndIf
	DbSelectArea( cAliasSB1 )
	( cAliasSB1 )->( DbGoTop() )
	Do While !( cAliasSB1 )->( Eof() )

		If !lSchedule
			IncProc( "Exportando Produto [ " + AllTrim( ( cAliasSB1 )->B1_COD ) + " ], aguarde..." )
		EndIf

		// Verifica se o Produto já foi importado para o e-commerce
		//WSMETHOD catalogProductInfo WSSEND csessionId,cproductId,cstoreView,oWScatalogProductInfoattributes,cidentifierType WSRECEIVE oWScatalogProductInfoinfo WSCLIENT WSMagentoService
		//If AllTrim( ( cAliasSB1 )->B1_XIDMAGE ) == ""

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
		oWS:oWScatalogProductCreateproductData 							:= WsClassNew( "MagentoService_catalogProductCreateEntity" )
		//oWS:oWScatalogProductCreateproductData:oWScategories			:= {} // AS MagentoService_ArrayOfString OPTIONAL
		//oWS:oWScatalogProductCreateproductData:oWSwebsites			:= {} // AS MagentoService_ArrayOfString OPTIONAL

		/*
		<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:Magento" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
		   <SOAP-ENV:Body>
		      <ns1:catalogProductInfoResponse>
		         <info xsi:type="ns1:catalogProductReturnEntity">
		            <product_id xsi:type="xsd:string">393</product_id>
		            <sku xsi:type="xsd:string">4091</sku>
		            <set xsi:type="xsd:string">4</set>
		            <type xsi:type="xsd:string">simple</type>

		            <categories SOAP-ENC:arrayType="xsd:string[1]" xsi:type="ns1:ArrayOfString">
		               <item xsi:type="xsd:string">122</item>
		            </categories>

		            <websites SOAP-ENC:arrayType="xsd:string[1]" xsi:type="ns1:ArrayOfString">
		               <item xsi:type="xsd:string">1</item>
		            </websites>

		            <created_at xsi:type="xsd:string">2016-08-12T12:03:35-03:00</created_at>
		            <updated_at xsi:type="xsd:string">2019-04-01 13:54:19</updated_at>
		            <type_id xsi:type="xsd:string">simple</type_id>

		            <name xsi:type="xsd:string">REFRIGERADOR VERTICAL PORTA CEGA VCED 569 LITROS FRICON 110V</name>
		            <description xsi:type="xsd:string">
		            	<![CDATA[	<h2 class="tit"><span style="font-size: x-large; color: #2e85c4;"><b> <label id="ctl00_Conteudo_ctl66_DetalhesProduto_lblTitulo">Detalhes do produto: FREEZER/REFRIGERADOR VERTICAL PORTA CEGA VCED 569 LITROS FRICON 110V</label></b></span></h2>
									<p><span style="font-size: x-large; color: #2e85c4;"><b><img alt="" src="{{media url="wysiwyg/divisao.png"}}" height="10" width="930" /></b></span></p>
									<div id="descricao" class="descricao">
									<div id="skuDescricaoExterna">
									<div id="descricao" class="descricao"><link href="https://www.unicaarcondicionado.com.br/templatecss/stylesCBEXPF.css" rel="StyleSheet" media="screen" type="text/css" />
									<div class="CBestrutura">
									<div class="CBinternaUm">
									<div class="CBconteudoTexto">
									<p><span style="font-size: x-large; color: #2e85c4;">Freezer/Refrigerador Vertical Fricon</span></p>
									<p><span style="color: #333333; font-size: medium;">Com o freezer/refrigerador vertical <strong>Fricon VCED</strong>&nbsp;de dupla a&ccedil;&atilde;o voc&ecirc; conserva seus produtos congelados ou resfriados.</span></p>
									<p><span style="color: #333333; font-size: medium;">Com um belo designer, possui a cor branca, puxador embutido e sistema de p&eacute;s niveladores.&nbsp;</span></p>
									</div>
									<div class="CBimg">&nbsp;<img title="VCED FRICON" alt="VCED FRICON" src="{{media url="wysiwyg/mini-imagem-descricao/VCED-FRICON.png"}}" /></div>
									</div>
									</div>
									<div class="CBestrutura">
									<div class="CBinternaUm">
									<div class="CBconteudoTexto">
									<p><span style="color: #2e85c4; font-size: x-large;">Designer moderno</span></p>
									<h4><span style="font-size: medium; color: #333333; background-color: #ffffff;"><span style="color: #333333; font-size: medium; display: inline !important;">Os freezers/refrigeradores Fricon s&atilde;o extremamente modernos. Possuem chapas internas e externas em a&ccedil;o galvanizado pr&eacute;-pintado com alta resist&ecirc;ncia a corros&atilde;o e porta de chapa com fechamento magnetizado.&nbsp;</span><br /></span></h4>
									</div>
									<div class="CBconteudoTexto">
									<p><span style="font-size: x-large; color: #2e85c4;">Descri&ccedil;&atilde;o I</span></p>
									<h4><span style="font-size: medium; color: #333333;"><span style="color: #333333; font-size: medium; display: inline !important;">Refrigera&ccedil;&atilde;o est&aacute;tica.</span><br /></span></h4>
									<p><span style="font-size: medium; color: #333333;"><span style="color: #333333; font-size: medium; display: inline !important;">Moldura com corte t&eacute;rmico, proporcionando maio efici&ecirc;ncia energ&eacute;tica.</span></span></p>
									<p><span style="font-size: medium; color: #333333;"><span style="color: #333333; font-size: medium; display: inline !important;">Prateleiras ajust&aacute;veis com pintura plastificada.</span></span></p>
									<p><span style="font-size: medium; color: #333333;"><span style="color: #333333; font-size: medium; display: inline !important;">&nbsp;</span></span></p>
									</div>
									</div>
									<div class="CBestrutura">
									<div class="CBinternaUm">
									<div class="CBconteudoTexto">
									<p><span style="color: #2e85c4; font-size: x-large;">Fricon respeita o meio ambiente</span></p>
									<h4><span style="color: #333333; font-size: medium;"><span style="color: #333333; font-size: medium; display: inline !important;">Isolamento de poliuretano ecologicamente correto.</span><br /></span></h4>
									</div>
									<div class="CBconteudoTexto">
									<p><span style="color: #2e85c4; font-size: x-large;">Descri&ccedil;&atilde;o II</span></p>
									<h4><span style="font-size: medium; color: #333333;"><span style="color: #333333; font-size: medium; display: inline !important;">Grade frontal pl&aacute;stica injetada em material de alto impacto com prote&ccedil;&atilde;o U.V.</span><br /></span></h4>
									<p><span style="font-size: medium; color: #333333;">Termostato ajust&aacute;vel para dupla a&ccedil;&atilde;o.</span></p>
									<p><span style="font-size: medium; color: #333333;">Barra de tor&ccedil;&atilde;o com sistema de stop inteligente.</span></p>
									<p><span style="font-size: medium; color: #333333;">Sistema de unidade condensadora remov&iacute;vel para frente (f&aacute;cil acesso a manuten&ccedil;&atilde;o).</span></p>
									</div>
									</div>
									</div>
									</div>
									</div>
									<span style="font-size: x-large; color: #2e85c4;"><b><img alt="" src="{{media url="wysiwyg/divisao.png"}}" height="11" width="930" /></b></span></div>
									<span style="color: #333333; font-size: medium;"><span>*</span><strong>Fotos meramentente ilustrativas.</strong></span></div>
									<div class="descricao">&nbsp;</div>
									<div class="descricao"><span style="color: #333333; font-size: medium;">&nbsp;Mantenha a temperatura ideal na sua casa ou em outro ambiente, todos os dias com<strong> Springer Minimaxi!</strong></span><br /><span style="font-size: medium; color: #333333;">do tipo janela,&nbsp;o&nbsp;<strong>Ar Condicionado Minimaxi MCC128BB&nbsp;</strong>vem na cor branca.</span><br /><span style="font-size: medium; color: #333333;">&nbsp;</span></div>
									<div class="descricao"><span style="font-size: medium; color: #333333;">&nbsp;</span></div>
						]]>
					</description>
					<short_description xsi:type="xsd:string">Refrigeração estática.
							Moldura com corte térmico, proporcionando maio eficiência energética.
							Prateleiras ajustáveis com pintura plastificada.
							Grade frontal plástica injetada em material de alto impacto com proteção U.V.
							Termostato ajustável para dupla ação.
							Barra de torção com sistema de stop inteligente.
							Sistema de unidade condensadora removível para frente (fácil acesso a manutenção).
					</short_description>
					<weight xsi:type="xsd:string">91.0000</weight>
		            <status xsi:type="xsd:string">1</status>
		            <url_key xsi:type="xsd:string">refrigerador-vertical-porta-cega-vced-569-litros-fricon-110v</url_key>
		            <url_path xsi:type="xsd:string">refrigerador-vertical-porta-cega-vced-569-litros-fricon-110v.html</url_path>
		            <visibility xsi:type="xsd:string">4</visibility>
		            <category_ids SOAP-ENC:arrayType="xsd:string[1]" xsi:type="ns1:ArrayOfString">
		               <item xsi:type="xsd:string">122</item>
		            </category_ids>
		            <has_options xsi:type="xsd:string">0</has_options>
		            <price xsi:type="xsd:string">3203.7800</price>
		            <tax_class_id xsi:type="xsd:string">0</tax_class_id>
		            <tier_price SOAP-ENC:arrayType="ns1:catalogProductTierPriceEntity[0]" xsi:type="ns1:catalogProductTierPriceEntityArray"/>
		            <meta_title xsi:type="xsd:string">REFRIGERADOR VERTICAL PORTA CEGA VCED 569 LITROS FRICON 110V</meta_title>
		            <meta_keyword xsi:type="xsd:string">Refrigerador, vertical porta cega, vced,569 litros fricon, 110v</meta_keyword>
		            <meta_description xsi:type="xsd:string">Refrigerador vertical porta cega 10x sem juros ou com desconto no boleto à vista.</meta_description>
		            <custom_design xsi:type="xsd:string">inovarti/unica</custom_design>
		            <options_container xsi:type="xsd:string">container2</options_container>
		         </info>
		      </ns1:catalogProductInfoResponse>
		   </SOAP-ENV:Body>
		</SOAP-ENV:Envelope>
		*/

		cAuxcategoria 	:= ""// De-Para para pegar a Categoria
		//nPreco		:= U_UNIRetPreco( ( cAliasSB1 )->B1_COD, cTabEcommerce, cFilAnt )
		nPreco 			:= 0

		oWS:oWScatalogProductCreateproductData:cname			   			:= ( cAliasSB1 )->B1_DESC// OPTIONAL
		oWS:oWScatalogProductCreateproductData:cdescription         		:= ( cAliasSB1 )->B5_ECAPRES // Descrição com CSS// OPTIONAL
		oWS:oWScatalogProductCreateproductData:cshort_description	   		:= ( cAliasSB1 )->B5_ECDESCR// OPTIONAL
		oWS:oWScatalogProductCreateproductData:cweight       	       		:= AllTrim( ( cAliasSB1 )->B5_PESO ) // B1_PESBRU OPTIONAL
		oWS:oWScatalogProductCreateproductData:cstatus          		    := "2"// OPTIONAL // 2=Bloqueado
		oWS:oWScatalogProductCreateproductData:curl_key     	    	    := ( cAliasSB1 )->B5_ECPCHAV // OPTIONAL
		oWS:oWScatalogProductCreateproductData:curl_path	            	:= ( cAliasSB1 )->B5_ECPCHAV // OPTIONAL
		oWS:oWScatalogProductCreateproductData:cvisibility      	    	:= "4" //??? OPTIONAL --> 4=Default
		//oWS:oWScatalogProductCreateproductData:oWScategory_ids  		    := {} //{ cAuxcategoria } // AS MagentoService_ArrayOfString OPTIONAL
		//oWS:oWScatalogProductCreateproductData:oWSwebsite_ids				:= {} //  AS MagentoService_ArrayOfString OPTIONAL
		//oWS:oWScatalogProductCreateproductData:chas_options             	:= "0"// OPTIONAL
		//oWS:oWScatalogProductCreateproductData:cgift_message_available  	:= ""// OPTIONAL
		oWS:oWScatalogProductCreateproductData:cprice                   	:= cValToChar( nPreco ) // OPTIONAL
		oWS:oWScatalogProductCreateproductData:cspecial_price           	:= "" //cValToChar( nPreco ) // OPTIONAL
		//oWS:oWScatalogProductCreateproductData:cspecial_from_date       	:= ""// OPTIONAL
		//oWS:oWScatalogProductCreateproductData:cspecial_to_date         	:= "" // OPTIONAL
		//oWS:oWScatalogProductCreateproductData:ctax_class_id           	:= "0" // OPTIONAL
		//oWS:oWScatalogProductCreateproductData:oWStier_price            	:= {} // AS MagentoService_catalogProductTierPriceEntityArray OPTIONAL
		oWS:oWScatalogProductCreateproductData:cmeta_title              	:= ( cAliasSB1 )->B5_ECTITU //OPTIONAL
		oWS:oWScatalogProductCreateproductData:cmeta_keyword            	:= ( cAliasSB1 )->B5_ECPCHAV // OPTIONAL
		oWS:oWScatalogProductCreateproductData:cmeta_description        	:= ( cAliasSB1 )->B5_ECINDIC // OPTIONAL
		oWS:oWScatalogProductCreateproductData:ccustom_design           	:= ( cAliasSB1 )->B5_ECCARAC  // OPTIONAL
		//oWS:oWScatalogProductCreateproductData:ccustom_layout_update    	:= "" // OPTIONAL
		//oWS:oWScatalogProductCreateproductData:coptions_container       	:= "" // OPTIONAL
		//oWS:oWScatalogProductCreateproductData:oWSadditional_attributes 	:= WsClassNew( "MagentoService_catalogProductAdditionalAttributesEntity" ) // AS MagentoService_catalogProductAdditionalAttributesEntity OPTIONAL
		//oWS:oWScatalogProductCreateproductData:oWSadditional_attributes:oWSmulti_data 	:= {} // AS MagentoService_associativeMultiArray OPTIONAL
		//oWS:oWScatalogProductCreateproductData:oWSadditional_attributes:oWSsingle_data 	:= {} // AS MagentoService_associativeArray OPTIONAL
		/*
		oWS:oWScatalogProductCreateproductData:oWSstock_data            	:= WsClassNew( "MagentoService_catalogInventoryStockItemUpdateEntity" ) // AS MagentoService_catalogInventoryStockItemUpdateEntity OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:cqty           				:= "" //AS string OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nis_in_stock      				:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nmanage_stock             		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nuse_config_manage_stock  		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nmin_qty                  		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nuse_config_min_qty       		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nmin_sale_qty             		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nuse_config_min_sale_qty  		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nmax_sale_qty             		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nuse_config_max_sale_qty  		:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nis_qty_decimal        	   	:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nbackorders          	     	:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nuse_config_backorders 	   	:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nnotify_stock_qty    	     	:= 0  //AS int OPTIONAL
		oWS:oWScatalogProductCreateproductData:oWSstock_data:nuse_config_notify_stock_qty 	:= 0  //AS int OPTIONAL
		*/

		// WSMETHOD catalogProductCreate WSSEND csessionId,ctype,cset,csku,oWScatalogProductCreateproductData,cstoreView WSRECEIVE nresult WSCLIENT WSMagentoService
		oWS:cType   		:= "simple"
		oWS:cSet			:= "4"
		oWS:cSku	 		:= ( cAliasSb1 )->B1_COD
		oWS:cStoreView 		:= cAuxStore //"1"
		If !oWS:catalogProductCreate()

			cMsgErro  := "Erro ao tentar executar o WS [ catalogProductCreate ] " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
			cMsgCompl := "Erro ao tentar executar o WS [ catalogProductCreate ] " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "UNIWS002 - " + cMsgCompl )
			Else
				Aviso( "Atenção", cMsgCompl, { "Continuar" } )
			EndIf
			//FGrvLog( "", "", "", "UNIWS002", "FIntegra", cMsgErro, cMsgComp, "", 0 )
			U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS002", "FIntegra", cMsgCompl, "", "", 0 )

		Else

			// Cadastra na SB1 Correspondente
			DbSelectArea( "SB1" )
			SB1->( DbGoTo( ( cAliasSB1 )->R_E_C_N_O_ ) )
			RecLock( "SB1", .F. )
			//SB1->B1_XIDMAGE += Alltrim( Str( oWS:nresult ) )
			SB1->B1_XIDMAGE += cCodInstancia + "," // Alltrim( Str( oWS:nresult ) )
			//SB1->B1_XDTCREA := Date()
			SB1->( MsUnLock() )

			cMsgErro  := "Produto incluido com sucesso Produto: [ " + SB1->B1_COD + " ] - Id Magento : [ " + SB1->B1_XIDMAGE + " ]"
			cMsgCompl := "Produto incluido com sucesso Produto: [ " + SB1->B1_COD + " ] - Id Magento : [ " + SB1->B1_XIDMAGE + " ]"
			U_UNIGrvLog( cNumLoteLog, "", SB1->B1_XIDMAGE, "UNIWS002", "FIntegra", cMsgErro, cMsgCompl, "SB1", ( cAliasSB1 )->R_E_C_N_O_ )

		EndIf

		/*
	Else

		cMsgErro  := "Erro ao tentar atualizar o Cadastro de Produtos no Magento "
		cMsgCompl := "Erro ao tentar executar o WS [ catalogProductCreate ] " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
		If lSchedule
			ConOut( "UNIWS002 - " + cMsgCompl )
		Else
			Aviso( "Atenção", cMsgCompl, { "Continuar" } )
		EndIf
		U_UNIGrvLog( cNumLoteLog, "", "", "UNIWS002", "FIntegra", cMsgErro, cMsgCompl, "SB1", ( cAliasSB1 )->R_E_C_N_O_ )

	EndIf
		*/

		DbSelectArea( cAliasSB1 )
		( cAliasSB1 )->( DbSkip() )
	EndDo
	( cAliasSB1 )->( DbCloseArea() )

	If lEncerra
		oWS:endSession()
		ConOut( "	UNIWS002 - FIntegra - Encerrou a sessao com o Magemto" )
	EndIf

Return
