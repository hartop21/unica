
/*/{Protheus.doc} UNIWS008

@project Integração Protheus x Magento
@description Rotina com o objetivo de atualizar o Campo de Id Magento do cadastro de Produtos
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


User Function UNIWS008( aParams )

	Local oFontProc     := Nil
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cPerg         := "UNIWS008"
	Local cTitulo       := "Integração Protheus x Magento - Atualização do Id Magento no Protheus"
	Local cTexto        := "<font color='red'> Integração Protheus x Magento </font><br> Esta rotina tem como objetivo realizar a atualização do Id do Produto no Magento para o Cadastro de Produtos do Protheus.<br><font color='green'>( de-para Id magento x Código Protheus )</font>"
	Private lSchedule 	:= IsBlind()

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Default aParams 	:= {} //ParamIXb

	If aParams == Nil
		aParams := {}
	EndIf

	If lSchedule

		ConOut( " ############################################################################################ " )
		ConOut( " ## INICIO INTEGRACAO UNIWS008 - ATUALIZACAO DO ID MAGENTO NO PROTHEUS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ############################################################################################ " )

		//Prepare Environment Empresa "01" Filial "0101"
		RPCSetEnv( "01", "0101" )

		//Gerando Perguntas do Parâmetro
		//FAjustaSX1( cPerg )
		//Pergunte( cPerg, .F. )
		FIntegra( lSchedule )

		//Reset Environment
		RPCClearEnv()

		ConOut( " ######################################################################################### " )
		ConOut( " ## FIM INTEGRACAO UNIWS008 - ATUALIZACAO DO ID MAGENTO NO PROTHEUS - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ######################################################################################### " )

	Else

		// Monta Tela
		//Gerando Perguntas do Parâmetro
		//MsgRun( cTitulo, "Aguarde, gerando as perguntas de parâmetros", { || FAjustaSX1( cPerg ) } )
		//Pergunte( cPerg, .F. )

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Integrar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		//	oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oDlgProc:Activate( ,,,.T. )

		If lConfirmou
			Processa( { || FIntegra( lSchedule ) }, "Conectando com a API do E-Commerce, aguarde..." )
		EndIf

	EndIf

Return


Static function FVldParametros()

Return .T.


Static Function FIntegra( lSchedule )

	Local oWS 		 		:= Nil

	// Realiza o Login na API
	oWS 		 	:= WSMagentoService():New()
	oWs:cusername	:= AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
	//oWs:capiKey	:= AllTrim( GetNewPar( "MV_XPSWMAG", "suporte#2019" ) ) //Produção
	oWs:capiKey		:= AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação
	If !oWs:login()

		cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execução Abortada."
		cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execução Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
		If lSchedule
			ConOut( "	UNIWS008 - FIntegra - " + cMsgErro )
			Return
		Else
			Aviso( "Atenção", "Erro ao tentar realizar login na API de Integração com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
			Return
		EndIf
	EndIf

	oWs:cSessionId := oWs:cloginReturn
	oWs:cstoreview := "1"

	// Mostra Tipo de Conexão com o Magento
	//If !lSchedule
	//	If Aviso( "Atenção", If( oWs:capiKey == "suporte#2019", "###LOGOU EM PRODUÇÃO NO MAGENTO ###", "###LOGOU EM HOMOLOGAÇÃO NO MAGENTO ###" ), { "Ok", "Sair" } )  == 02
	//		Return
	//	EndIf
	//EndIf
	//If( oWs:capiKey == "suporte#2019", "###LOGOU EM PRODUÇÃO NO MAGENTO ###", "###LOGOU EM HOMOLOGAÇÃO NO MAGENTO ###" )

	ConOut( "	- UNIWS008 - Busca todos os Produtos na API Magento"  )
	//WSMETHOD catalogProductList WSSEND csessionId,oWScatalogProductListfilters,cstoreView WSRECEIVE oWScatalogProductListstoreView WSCLIENT WSMagentoService
	If !oWs:catalogProductList()

		cMsgErro  := "Erro ao tentar acessar a API [ catalogProductList ] no Magento. "
		cMsgCompl := "Erro ao tentar acessar a API [ catalogProductList ] no Magento. " + GetWSCError()

		If lSchedule
			ConOut( "	- UNIWS008 - " + cMsgCompl )
		Else
			Aviso( "Atenção", cMsgCompl, { "Voltar" } )
		EndIf
		U_UNIGrvLog( "", "", "UNIWS008", "FIntegra", cMsgErro, cMsgCompl, "", 0 )

	EndIf

	nTamB1_COD := TamSX3( "B1_COD" )[01]
	DbSelectArea( "SB1" )
	DbSetOrder( 01 ) // B1_FILIAL + B1_COD

	If !lSchedule
		ProcRegua( Len( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity ) )
	EndIf
	For nI := 01 To Len( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity  )

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
			IncProc( "Atualizando o Id Magento no Protheus" )
		EndIf

		DbSelectArea( "SB1" )
		Seek XFilial( "SB1" ) + PadR( AllTrim( oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nI]:csku ), nTamB1_COD )
		If Found()

			ConOut( "	- UNIWS008 - FIntegra - Atualizando o Produto SKU [ " + oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nI]:csku + " ] - Id Magento [ " + oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nI]:cproduct_id + " ]" )
			RecLock( "SB1", .F. )
			SB1->B1_XIDMAGE := oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nI]:cproduct_id
			SB1->( MsUnLock() )

		Else

			ConOut( "	- UNIWS008 - FIntegra - Não encontrou o Produto SKU [ " + oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nI]:csku + " ] - Id Magento [ " + oWs:oWScatalogProductListstoreView:oWsCatalogProductEntity [nI]:cproduct_id + " ]" )

		EndIf

	Next nI

	oWS:endSession()

Return