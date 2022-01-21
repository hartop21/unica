/*/{Protheus.doc} UNIWS005

@project IntegraÁ„o Protheus x Magento

@description Rotina respons√°vel pela atualiza√ß√£o das informa√ß√µes de Envio da chave da Nota para o Pedido E-Commerce no Magento.
author Rafael Rezende
@since 07/04/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

User Function UNIWS05S()
	U_UNIWS005( "01", "0101", "UARC01", Nil, "" )
Return

User Function UNIWS005( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cPerg         := "UNIWS005"
	Local cTitulo   	:= "IntegraÁ„o Protheus x Magento - Envio da Chave da Nota para o Pedido"
	Local cTexto       	:= "<font color='red'> IntegraÁ„o Protheus x Magento </font><br> Esta rotina tem como objetivo de atualizar o Status do Pedido no Magento, enviando a chave da Nota para o pedido.<br>Informe o Pedido a ser atualizado na op√ß√£o de <b>Par‚metros</b> e confirme a rotina."
	Private lSchedule 	:= .F. //IsBlind()

	//Default aParams 		 := {}
	Default cParamEmpJob	 := ""
	Default cParamFilJob	 := ""
	Default cParamInstancia  := ""
	Default oParamWS    	 := Nil
	Default cParamNumLoteLog := ""

	cTexto 	            	:= "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " ####################################################################################### " )
		ConOut( " ## INICIO INTEGRACAO UNIWS005 - ATUALIZACAO DA CHAVE DA NOTA - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ####################################################################################### " )
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob )

		//Gerando Perguntas do Par‚metro
		MV_PAR01 := Space( TamSX3( "C5_NUM" )[01] )
		MV_PAR02 := Replicate( "Z", TamSX3( "C5_NUM" )[01] )
		MV_PAR03 := Space( TamSX3( "C5_XIDMAGE" )[01] )
		MV_PAR04 := Replicate( "Z", TamSX3( "C5_XIDMAGE" )[01] )
		MV_PAR05 := cParamInstancia
		FIntegra( lSchedule, oParamWS, cParamNumLoteLog )

		RPCClearEnv()
		ConOut( " ###################################################################################### " )
		ConOut( " ## FINAL INTEGRACAO UNIWS005 - ATUALIZACAO DA CHAVE DA NOTA - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ###################################################################################### " )

	Else

		// Monta Tela
		Pergunte( cPerg, .F. )

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Atualizar" , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 083, "&Par‚metros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
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
		Aviso( "AtenÁ„o", "O Par‚metro [ Pedido atÈ ? ] È obrigatÛrio.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR04 ) == ""
		Aviso( "AtenÁ„o", "O Par‚metro [ Id Magento atÈ ? ] È obrigatÛrio.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR05 ) == ""
		Aviso( "AtenÁ„o", "O Par‚metro [ WSDL Magento ? ] È obrigatÛrio.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet

Static Function FIntegra( lSchedule, oWS, cParamNumLoteLog )
	Local aAreaAnt 			:= GetArea()
	Local lEncerra			:= .T.
	Local cAliasQry 		:= GetNextAlias()
	Local nContador			:= 0
	Local nNumRegistros     := GetNewPar( "MV_XNUMREG", 10 )
	Local oRestClient 		:= FWRest():New("https://api.skyhub.com.br/")
	Local aHeader 			:= {}
	Local lErroSky 			:= .F.
	Local cXML				:= ""
	Local cErro				:= ""
	Local cFilOld			:= cFilAnt
	Private cNumLoteLog		:= ""
	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""


	If AllTrim( cParamNumLoteLog ) == ""
		cNumLoteLog			:= GetSXENum( "SZ5", "Z5_CODIGO" )
		ConfirmSX8()
		ConOut( "	UNIWS005 - FIntegra - Gerou Lote para o Log: " + cNumLoteLog )
	Else
		cNumLoteLog			:= cParamNumLoteLog
		ConOut( "	UNIWS005 - FIntegra - Reaproveitou o Lote para o Log: " + cNumLoteLog )
	EndIf

	If Type( "_c_WsLnkMagento" ) != "C"

		DbSelectArea( "SZ8" )
		DbSetOrder( 01 )
		Seek XFilial( "SZ8" ) + MV_PAR05
		If Found()

			// Se estiver bloqueado
			If AllTrim( SZ8->Z8_MSBLQL ) == "1"

				cMsgErro 	:= "A Instancia Magento [ " + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + " ] esta bloqueada para uso, a rotina nao sera executada."
				cMsgComp 	:= cMsgErro
				If lSchedule
					ConOut( "	UNIWS005 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS005"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
					Return
				Else
					Aviso( "AtenÁ„o", cMsgComp, { "Voltar" } )
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

			cMsgErro 	:= "n„o encontrou uma Instancia v·lida para a IntegraÁ„o com o Magento [ " + MV_PAR05 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS005 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS005"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "AtenÁ„o", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	If oWS == Nil
		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cUserName	:= _c_WsUserMagento // AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
		//oWs:capiKey	:= AllTrim( GetNewPar( "MV_XPSWMAG", "suporte#2019" ) ) //Produ√ß√£o
		oWs:cApiKey		:= _c_WsPassMagento // AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologa√ß√£o
		If !oWs:Login()

			cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS005 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS005"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "AtenÁ„o", "Erro ao tentar realizar login na API de IntegraÁ„o com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf
		oWs:cSessionId 	:= oWs:cLoginReturn
		lEncerra		:= .T.
		ConOut( "	UNIWS005 - FIntegra - Criou nova Sessao de API com o Magento" )

	Else

		oWs:cSessionId := oWs:cLoginReturn
		lEncerra	:= .F.
		ConOut( "	UNIWS005 - FIntegra - Manteve a Sessao de API" )

	EndIf

	SZ8->(DbSetOrder( 01 ))
	SZ8->(DbSeek(XFilial( "SZ8" ) + _c_WsCodInstancia))
	// Testa o Login da Skyhub se houver
	If ! Empty(SZ8->Z8_SKYUSR)
		// PREENCHE CABE«ALHO DA REQUISI«√O
		AAdd(aHeader, "x-user-email: " + AllTrim(SZ8->Z8_SKYUSR))
		AAdd(aHeader, "x-api-key: " + AllTrim(SZ8->Z8_SKYKEY))
		AAdd(aHeader, "x-accountmanager-key: " + AllTrim(SZ8->Z8_SKYAKEY))
		AAdd(aHeader, "accept: application/json;charset=UTF-8")

		oRestClient:setPath("statuses")
		If ! oRestClient:get(aHeader)
			cMsgErro := "Erro no acesso ‡ SKYHUB DO MAGENTO[" + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + "]"
			cMsgComp := cMsgErro + CRLF + oRestClient:GetLastError() + CRLF + oRestClient:CRESULT

			If lSchedule
				ConOut( "	UNIWS005 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS005"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "AtenÁ„o", cMsgComp, { "Voltar" } )
				Return
			EndIf
		EndIf

		AAdd(aHeader, "content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW")
	EndIf

	//cQuery := "   SELECT DISTINCT R_E_C_N_O_ AS NUMRECNO, C5_XIDMAGE "
	cQuery := "   SELECT TOP " + StrZero( nNumRegistros, 03 ) + " SC5.R_E_C_N_O_ AS NUMRECNO, C5_XIDMAGE, C5_VOLUME1,F2_DOC, F2_SERIE, F2_CHVNFE, UNI_METHOD, UNI_PEDMKT "
	cQuery += "	    FROM " + RetSQLName( "SC5" ) + " SC5 ( NOLOCK ), "
	cQuery += "	         " + RetSQLName( "SF2" ) + " SF2 ( NOLOCK ), "
	cQuery += "	         " + RetSQLName( "UNI" ) + " UNI ( NOLOCK )  "
	cQuery += "    WHERE SC5.D_E_L_E_T_  	  = ' ' "
	cQuery += "      AND SF2.D_E_L_E_T_  	  = ' ' "
	cQuery += "      AND C5_FILIAL 			  = F2_FILIAL  "
	cQuery += "      AND C5_NOTA			  = F2_DOC     "
	cQuery += "      AND C5_SERIE			  = F2_SERIE   "
	cQuery += "      AND C5_CLIENTE			  = F2_CLIENTE "
	cQuery += "      AND C5_LOJACLI			  = F2_LOJA    "

	cQuery += "      AND UNI.D_E_L_E_T_		  = ' '    "
	cQuery += "      AND UNI_IDMAG 			  = C5_XIDMAGE    "
	cQuery += "      AND UNI_ORIGEM 	      = C5_XCODSZ8    "
	cQuery += "      AND UNI_STATUS 	      = 'pagamento_confirmado'    "

	cQuery += "      AND C5_NOTA 			 != ''		   "
	cQuery += "		 AND C5_NUM     	BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "		 AND C5_XIDMAGE 	BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "

	//cQuery += "		 AND C5_XIDMAGE 		 = '146526921'  "
	cQuery += "		 AND C5_XIDMAGE 		 != ''  "
	cQuery += "		 AND (C5_XENVCHV          != 'S' OR C5_XXMLSKY = ' ') "

	cQuery += "		 AND F2_CHVNFE           != ''  "
	cQuery += "		 AND F2_FIMP           	  = 'S'  " // ---- LEANDRO RIBEIRO ---- 13/12/2019 ---- //
	cQuery += "		 AND C5_XCODSZ8       	  = '" + _c_WsCodInstancia + "' "
	cQuery += "	ORDER BY SC5.R_E_C_N_O_ DESC "
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	//ConOut(	"	- UNIWS005 - cQuery " + cQuery )
	TcQuery cQuery Alias ( cAliasQry ) New

	If !lSchedule
		nContador := 0
		Count To nContador
		ProcRegua( nContador )
	EndIf

	DbSelectArea( cAliasQry )
	( cAliasQry )->( DbGoTop() )

	If ( cAliasQry )->( Eof() )
		ConOut( "	- UNIWS005 - Nao encontrou Pedidos pendentes com Notas para enviar a Chave"  )
	EndIf
	Do While !( cAliasQry )->( Eof() )

		lProssegue := .T.

		If !lSchedule
			IncProc( "Enviando Chave NF Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "], aguarde..." )
		Else
			ConOut( "	UNIWS005 - FIntegra - Enviando Chave NF Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "], volume_qty: " + cValToChar(( cAliasQry )->C5_VOLUME1) )
		EndIf

		//Efetiva a Atualiza√ß√£o no Magento e Skyhub
		If lProssegue
			lErroSky 			:= .F.
			SC5->( DbGoto( ( cAliasQry )->NUMRECNO ) )

			// SÛ envia o XML depois de enviar a chave para o magento acho que est· sobrescrevendo depois
			If SC5->C5_XENVCHV == "S"
				If Len(aHeader) > 0 .AND. ( cAliasQry )->UNI_PEDMKT != 'null' .AND. AllTrim(( cAliasQry )->UNI_PEDMKT) != 'null' .AND. AllTrim(( cAliasQry )->UNI_METHOD) != "CNOVA"

					If !lSchedule
						IncProc( "Gerando XML [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "], aguarde..." )
					Else
						ConOut( "	UNIWS005 - FIntegra - Gerando XML Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "]" )
					EndIf

					U_TrEmpFil(cEmpAnt, SC5->C5_FILIAL)

					// tenta gerar o XML
					If GeraXml(( cAliasQry )->F2_SERIE,( cAliasQry )->F2_DOC, @cXML, @cErro)
						// Envia a chave para o skyhub com o XML
						oRestClient:setPath("orders/" + AllTrim(( cAliasQry )->UNI_METHOD) + "-" + AllTrim(( cAliasQry )->UNI_PEDMKT)  + "/invoice" )

						cPostParms := '------WebKitFormBoundary7MA4YWxkTrZu0gW'
						cPostParms += CRLF
						cPostParms += 'Content-Disposition: form-data; name="volume_qty"'
						cPostParms += CRLF
						cPostParms += CRLF
						cPostParms += cValToChar(( cAliasQry )->C5_VOLUME1)
						cPostParms += CRLF
						cPostParms += '------WebKitFormBoundary7MA4YWxkTrZu0gW'
						cPostParms += CRLF
						cPostParms += 'Content-Disposition: form-data; name="number"'
						cPostParms += CRLF
						cPostParms += CRLF
						cPostParms += cValToChar(( cAliasQry )->F2_DOC)
						cPostParms += CRLF
						cPostParms += '------WebKitFormBoundary7MA4YWxkTrZu0gW'
						cPostParms += CRLF
						cPostParms += 'Content-Disposition: form-data; name="line"'
						cPostParms += CRLF
						cPostParms += CRLF
						cPostParms += cValToChar(( cAliasQry )->F2_SERIE)
						cPostParms += CRLF
						cPostParms += '------WebKitFormBoundary7MA4YWxkTrZu0gW'
						cPostParms += CRLF
						cPostParms += 'Content-Disposition: form-data; name="key"'
						cPostParms += CRLF
						cPostParms += CRLF
						cPostParms += ( cAliasQry )->F2_CHVNFE
						cPostParms += CRLF
						cPostParms += '------WebKitFormBoundary7MA4YWxkTrZu0gW'
						cPostParms += CRLF
						cPostParms += 'Content-Disposition: form-data; name="file"; filename="\'+( cAliasQry )->F2_CHVNFE+'.xml"'
						cPostParms += CRLF
						cPostParms += 'Content-Type: text/xml'
						cPostParms += CRLF
						cPostParms += CRLF
						cPostParms += cXML
						cPostParms += CRLF
						cPostParms += '------WebKitFormBoundary7MA4YWxkTrZu0gW--'

						oRestClient:SetPostParams(cPostParms)

						a_header := aClone(aHeader)
						aAdd(a_header, "Content-Length:" + cValToChar(Len(cPostParms)))
						oRestClient:Post(aHeader)

						If oRestClient:GetLastError() == "204 NoContent" // Quando envia com sucesso retorna NoContent
							DbSelectArea( "SC5" )
							SC5->( DbGoto( ( cAliasQry )->NUMRECNO ) )
							RecLock( "SC5", .F. )
							SC5->C5_XXMLSKY := 'E'
							SC5->( MsUnLock() )
						Else
							lErroSky := .T.

							cMsgErro := "Erro ao tentar enviar a chave da Nota para SKYHUB [ " + AllTriM( ( cAliasQry )->C5_XIDMAGE ) + " ]."
							cMsgComp := cMsgErro + " Erro : " + Replace( Replace( oRestClient:GetLastError() + CRLF + oRestClient:CRESULT, Chr( 10 ), " " ), Chr( 13 ), " " )
							If !lSchedule
								Aviso( "AtenÁ„o", cMsgComp, { "Continuar" } )
							Else
								ConOut( "	UNIWS005 - FIntegra - " + cMsgComp )
								U_UNIGrvLog( cNumLoteLog , "", ( cAliasQry )->C5_XIDMAGE, "UNIWS005", "FIntegra", cMsgErro, cMsgComp, "SC5", ( cAliasQry )->NUMRECNO )
							EndIf
						EndIf
					Else
						lErroSky := .T.

						cMsgErro := "Erro ao tentar enviar a chave da Nota para SKYHUB [ " + AllTriM( ( cAliasQry )->C5_XIDMAGE ) + " ]."
						cMsgComp := cMsgErro + " Erro : " + Replace( Replace( cErro, Chr( 10 ), " " ), Chr( 13 ), " " )
						If !lSchedule
							Aviso( "AtenÁ„o", cMsgComp, { "Continuar" } )
						Else
							ConOut( "	UNIWS005 - FIntegra - " + cMsgComp )
							U_UNIGrvLog( cNumLoteLog , "", ( cAliasQry )->C5_XIDMAGE, "UNIWS005", "FIntegra", cMsgErro, cMsgComp, "SC5", ( cAliasQry )->NUMRECNO )
						EndIf
					EndIf
				Else
					DbSelectArea( "SC5" )
					SC5->( DbGoto( ( cAliasQry )->NUMRECNO ) )
					RecLock( "SC5", .F. )
					SC5->C5_XXMLSKY := 'N'
					SC5->( MsUnLock() )
				EndIf
			EndIf

			If ! lErroSky .AND. SC5->C5_XENVCHV != "S"
				If FAtuStatus( @oWS, ( cAliasQry )->C5_XIDMAGE, "complete", "chave de acesso: " + ( cAliasQry )->F2_CHVNFE + ", volume_qty: " + cValToChar(( cAliasQry )->C5_VOLUME1))

					DbSelectArea( "SC5" )
					SC5->( DbGoto( ( cAliasQry )->NUMRECNO ) )
					RecLock( "SC5", .F. )
					SC5->C5_XENVCHV := "S"
					SC5->C5_XDTEXPE := Date()
					SC5->( MsUnLock() )

					cMsgErro := "A Chave da Nota foi enviada com sucesso para o Pedido Magento! - Pedido: " + SC5->C5_XIDMAGE + " - Chave da Nota: " + ( cAliasQry )->F2_CHVNFE
					cMsgComp := cMsgErro
					If lSchedule
						ConOut( "	UNIWS005 - FIntegra - " + cMsgErro )
						U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS005", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
					EndIf

				Else

					cMsgErro := "Erro ao tentar enviar a chave da Nota para o Pedido Magento [ " + AllTriM( ( cAliasQry )->C5_XIDMAGE ) + " ]."
					cMsgComp := cMsgErro + " Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
					If !lSchedule
						Aviso( "AtenÁ„o", cMsgComp, { "Continuar" } )
					Else
						ConOut( "	UNIWS005 - FIntegra - " + cMsgComp )
						U_UNIGrvLog( cNumLoteLog , "", ( cAliasQry )->C5_XIDMAGE, "UNIWS005", "FIntegra", cMsgErro, cMsgComp, "SC5", ( cAliasQry )->NUMRECNO )
					EndIf

				EndIf
			EndIf

		EndIf

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If lEncerra
		oWS:endSession()
		ConOut( "	UNIWS005 FIntegra - Encerrou a sessao com o Magemto" )
	EndIf

	U_TrEmpFil(cEmpAnt, cFilOld)
	RestArea( aAreaAnt )
Return


Static Function FAtuStatus( oWS, cParamIdMagento, cParamStatus, cParamMensagem, cParamNotify, lSchedule )
	Local lRetWS			:= .T.
	Default cParamMensagem	:= ""
	Default cParamNotify	:= ""
	Default lSchedule 		:= .F.
	//
	oWS:cOrderIncrementId	:= cParamIdMagento
	oWS:cStatus				:= cParamStatus
	oWS:cComment            := cParamMensagem
	oWS:cNotify 			:= ""

	//WSMETHOD salesOrderAddComment WSSEND csessionId,corderIncrementId,cstatus,ccomment,cnotify WSRECEIVE lresult WSCLIENT WSMagentoService
	lRetWS := oWS:SalesOrderAddComment()
Return lRetWS

Static Function FRetChaveNF( cParamFilial, cParamDoc, cParamSerie, cParamCliente, cParamLoja )
	Local aAreaAnt  := GetArea()
	Local cAliasF2  := GetNextAlias()
	Local cQuery 	:= ""
	Local cRetChave	:= ""

	cQuery := " SELECT F2_CHVNFE "
	cQuery += "   FROM " + RetSQLName( "SF2" )
	cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "	   AND F2_FILIAL  = '" + cParamFilial 	+ "' "
	cQuery += "	   AND F2_DOC	  = '" + cParamDoc 	  	+ "' "
	cQuery += "	   AND F2_SERIE   = '" + cParamSerie  	+ "' "
	cQuery += "	   AND F2_CLIENTE = '" + cParamCliente	+ "' "
	cQuery += "	   AND F2_LOJA	  = '" + cParamLoja 	+ "' "
	If Select( cAliasF2 ) > 0
		( cAliasF2 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasF2 ) New
	If !( cAliasF2 )->( Eof() )
		cRetChave	:= AllTrim( ( cAliasF2 )->F2_CHVNFE )
	EndIf
	( cAliasF2 )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return cRetChave

/*/{Protheus.doc} GeraXml

   Obtem do TSS o XML da NFE

/*/

Static Function GeraXml(cSerie,cNota, cXML, cErro)
	Local lRetorno
	Local nI
	Local oBSXml

	oWS:= WSNFeSBRA():New()
	oWS:cUSERTOKEN        := "TOTVS"
	oWS:cID_ENT           := xGetIdEnt()
	oWS:_URL              := AllTrim(GetNewPar("MV_SPEDURL","http://"))+"/NFeSBRA.apw"
	oWS:cIdInicial        := cSerie + cNota
	oWS:cIdFinal          := cSerie + cNota
	oWS:dDataDe           := sTod("")
	oWS:dDataAte          := sTod("20491231")
	oWS:cCNPJDESTInicial  := SPACE(14)
	oWS:cCNPJDESTFinal    := REPLICATE("Z",14)
	oWS:nDiasparaExclusao := 0

	For nI := 1 To 30

		lRetorno := oWS:RETORNAFX()

		If lRetorno
			oBSXml := oWS:oWsRetornaFxResult:OWSNOTAS:OWSNFES3[1]

			If  AllTrim(oBSXml:oWSNFe:cXMLPROT) != ""
				cXML := '<?xml version="1.0" encoding="UTF-8"?>'
				cXML += '<nfeProc xmlns="http://www.portalfiscal.inf.br/nfe" versao="">'
				cXML += AllTrim(oBSXml:oWSNFe:cXML)
				cXML += AllTrim(oBSXml:oWSNFe:cXMLPROT)
				cXML += '</nfeProc>'
			ElseIf nI == 30
				cErro := "N„o foi possÌvel Obter o protocolo de AutorizaÁ„o XML!!"
				Return .F.
			EndIf
		ElseIf nI == 30
			cErro :=  "N„o foi possÌvel Obter o XML!"
			Return .F.
		EndIf
		Sleep(1000)
	Next nI
Return .T.


/*/{Protheus.doc} xGetIdEnt
	FunÁ„o respons·vel por buscar o ID da entidade no TSS.
/*/
STATIC aFilIdEnt := {}
Static Function xGetIdEnt()

	Local aArea		:= GetArea()
	Local cIdEnt	:= ""
	Local cURL		:= PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Local oWs
	Local nPos 		:= 0

	// Procura no cache para otimizar o tempo
	nPos := aScan(aFilIdEnt, {|x| x[1] == cEmpAnt + cFilAnt  })
	If nPos > 0
		Return aFilIdEnt[nPos][2]
	EndIf

	oWS := WsSPEDAdm():New()
	oWS:cUSERTOKEN			:= "TOTVS"
	oWS:oWSEMPRESA:cCNPJ	:= IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cCPF		:= IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cIE		:= SM0->M0_INSC
	oWS:oWSEMPRESA:cIM		:= SM0->M0_INSCM
	oWS:oWSEMPRESA:cNOME	:= SM0->M0_NOMECOM
	oWS:oWSEMPRESA:cFANTASIA:= SM0->M0_NOME
	oWS:oWSEMPRESA:cENDERECO:= FisGetEnd(SM0->M0_ENDENT)[1]
	oWS:oWSEMPRESA:cNUM		:= FisGetEnd(SM0->M0_ENDENT)[3]
	oWS:oWSEMPRESA:cCOMPL	:= FisGetEnd(SM0->M0_ENDENT)[4]
	oWS:oWSEMPRESA:cUF		:= SM0->M0_ESTENT
	oWS:oWSEMPRESA:cCEP		:= SM0->M0_CEPENT
	oWS:oWSEMPRESA:cCOD_MUN	:= SM0->M0_CODMUN
	oWS:oWSEMPRESA:cCOD_PAIS:= "1058"
	oWS:oWSEMPRESA:cBAIRRO	:= SM0->M0_BAIRENT
	oWS:oWSEMPRESA:cMUN		:= SM0->M0_CIDENT
	oWS:oWSEMPRESA:cCEP_CP	:= Nil
	oWS:oWSEMPRESA:cCP         := Nil
	oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
	oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
	oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
	oWS:oWSEMPRESA:cEMAIL      := UsrRetMail("000000")
	oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
	oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
	oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cINDSITESP  := ""
	oWS:oWSEMPRESA:cID_MATRIZ  := ""
	oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
	oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"

	If oWs:ADMEMPRESAS()
		cIdEnt  := oWs:cADMEMPRESASRESULT

		aAdd(aFilIdEnt, {cEmpAnt + cFilAnt , cIdEnt} )
	Else
		Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"OK"},3)
	EndIf

	RestArea(aArea)

Return(cIdEnt)


/*/{Protheus.doc} TrEmpFil

	Troca de empresa e/ou filial

	@author  Robson RogÈrio
	@since   02-04-2021
/*/

User Function TrEmpFil(cEmp, cFil)
	Local aDicionarios := RetSxs()
	Local nI

	// Troca para a filial
	If cFilAnt != cFil .OR. cEmpAnt != cEmp// Usando o lastName por enquanto atÈ melhor definiÁ„o
		qOut('Trocando para ' + cValToChar(cEmp) + "/" +  cValTochar(cFil) )

		If cEmpAnt != cEmp
			dbCloseAll() //Fecho todos os arquivos abertos
		EndIf

		cFilAnt := cFil
		cEmpAnt := cEmp

		cNumEmp := cEmpAnt + cFilAnt
		OpenSM0(cEmpAnt + cFilAnt)

		For nI := 1 To Len(aDicionarios)
			If( Select(aDicionarios[ni][1]) > 0)
				(aDicionarios[ni][1])->(DbCloseArea())
			EndIf
		Next nI

		aEVal(aDicionarios, {|x| DbSelectArea(x[1])})
		InitPublic()  // Incializa as Variaveis Publicas

		//OpenFile(cEmpAnt + cFilAnt) //Abro a empresa que eu desejo trabalhar
	EndIf
Return