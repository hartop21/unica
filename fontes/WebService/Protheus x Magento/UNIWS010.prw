*----------------------------------*
/*/{Protheus.doc} UNIWS010

@project Integração Protheus x Magento

@description Rotina responsável pela atualização do status do Pedido para "Produto(s) Entregue(s)
author Rafael Rezende
@since 22/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.CH"
#Include "ApWebSrv.ch"


User Function UNIWS10S()

	U_UNIWS009( "01", "0207", "", Nil, "" )
Return

*-----------------------------------------------------------------------------------------------*
User Function UNIWS010( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
	*-----------------------------------------------------------------------------------------------*
	Local oFontProc     	 := Nil
	Local oDlgProc       	 := Nil
	Local oGrpTexto 	     := Nil
	Local oSayTexto	    	 := Nil
	Local oBtnConfi     	 := Nil
	Local oBtnParam 	     := Nil
	Local oBtnSair	      	 := Nil
	Local lHtml         	 := .T.
	Local lConfirmou	     := .F.
	Local cPerg         	 := "UNIWS010"
	//Local cTitulo   	     := "Atualização do status do Pedido do Magento, para informar que os produtos foram enviados para a Transportadora.<br>Informe os parâmetros desejados e confirme a rotina."
	Local cTitulo   	     := "Integração Protheus x Magento - Produto(s) entregue(s)"
	Local cTexto       		 := "<font color='red'> Integração Protheus x Magento </font><br> Esta rotina tem como objetivo de atualizar o Status do Pedido no Magento para Produto(s) entregue(s).<br>Informe o Pedido a ser atualizado na opção de <b>Parâmetros</b> e confirme a rotina."

	//Default aParams 		 := {}
	Default cParamEmpJob	 := ""
	Default cParamFilJob	 := ""
	Default cParamInstancia	 := ""
	Default oParamWS    	 := Nil
	Default cParamNumLoteLog := ""

	cTexto 	                 := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf
	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " #################################################################################### " )
		ConOut( " ## INICIO INTEGRACAO UNIWS010 - ENVIO PRODUTO ENTREGUES - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " #################################################################################### " )
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob )

		//Gerando Perguntas do Parâmetro
		MV_PAR01 := Space( TamSX3( "C5_NUM" )[01] )
		MV_PAR02 := Replicate( "Z", TamSX3( "C5_NUM" )[01] )
		MV_PAR03 := Space( TamSX3( "C5_XIDMAGE" )[01] )
		MV_PAR04 := Replicate( "Z", TamSX3( "C5_XIDMAGE" )[01] )
		MV_PAR05 := cParamInstancia
		FIntegra( lSchedule, oParamWS, cParamNumLoteLog )

		RPCClearEnv()
		ConOut( " ################################################################################### " )
		ConOut( " ## FINAL INTEGRACAO UNIWS010 - ENVIO PRODUTO ENTREGUES - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ################################################################################### " )

	Else

		Pergunte( cPerg, .F. )

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Atualizar" , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
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
		Aviso( "Atenção", "O Parâmetro [ Pedido até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR04 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Id Magento até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR05 ) == ""
		Aviso( "Atenção", "O Parâmetro [ WSDL Magento ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet

*----------------------------------------------------------*
Static Function FIntegra( lSchedule, oWS, cParamNumLoteLog )
	*----------------------------------------------------------*
	Local aAreaAnt 			:= GetArea()
	Local nAuxRecNo 		:= 0
	Local cAliasQry 		:= GetNextAlias()
	Local nNumRegistros     := GetNewPar( "MV_XNUMREG", 10 )
	Local cMacro := ""
	Private cNumLoteLog		:= ""
	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""

	If AllTrim( cParamNumLoteLog ) == ""
		cNumLoteLog			:= GetSXENum( "SZ5", "Z5_CODIGO" )
		ConfirmSX8()
		ConOut( "	UNIWS010 - FIntegra - Gerou Lote para o Log: " + cNumLoteLog )
	Else
		cNumLoteLog			:= cParamNumLoteLog
		ConOut( "	UNIWS010 - FIntegra - Reaproveitou o Lote para o Log: " + cNumLoteLog )
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
					ConOut( "	UNIWS010 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS010"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
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
				_c_WsEmpFilEstoque   := AllTrim( GetNewPar( "MV_XEMPEST", "0101,0207" ) )
			EndIf

		Else

			cMsgErro 	:= "Não encontrou uma Instancia válida para a Integração com o Magento [ " + MV_PAR05 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS010 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS010"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "Atenção", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	If oWS == Nil

		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cUserName	:= _c_WsUserMagento //AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
		oWs:cApiKey		:= _c_WsPassMagento //AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação
		If !oWs:Login()

			cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS010 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS010"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "Atenção", "Erro ao tentar realizar login na API de Integração com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf
		oWs:cSessionId 	:= oWs:cLoginReturn
		lEncerra		:= .T.
		ConOut( "	UNIWS010 - FIntegra - Criou nova Sessao de API com o Magento" )

	Else

		oWs:cSessionId := oWs:cLoginReturn
		lEncerra	:= .F.
		ConOut( "	UNIWS010 - FIntegra - Manteve a Sessao de API" )

	EndIf

	cQuery := "   SELECT TOP " + StrZero( nNumRegistros, 03 ) + " R_E_C_N_O_ AS NUMRECNO, C5_XIDMAGE "
	cQuery += "	    FROM " + RetSQLName( "SC5" )
	cQuery += "    WHERE D_E_L_E_T_ 	  = ' ' "
	cQuery += "		 AND C5_XIDMAGE 	 != ''  "
	cQuery += "		 AND C5_NUM     BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "		 AND C5_XIDMAGE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	cQuery += "		 AND C5_XENVCHV       = 'S' "
	cQuery += "		 AND C5_XENVTRA       = 'S' "
	cQuery += "		 AND C5_XENVPRO      != 'S' "
	cQuery += "		 AND C5_XDTENTR      != '        ' "
	cQuery += "		 AND C5_XIDMAGE		 != '' "
	cQuery += "		 AND C5_XCODSZ8       = '" + _c_WsCodInstancia + "' "
	cQuery += "	ORDER BY R_E_C_N_O_ DESC "
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	conout(cQuery)
	TcQuery cQuery Alias ( cAliasQry ) New

	If !lSchedule
		nContador := 0
		Count To nContador
		ProcRegua( nContador )
	EndIf

	DbSelectArea( cAliasQry )
	( cAliasQry )->( DbGoTop() )
	Do While !( cAliasQry )->( Eof() )

		lProssegue := .T.

		If !lSchedule
			IncProc( "Enviando Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "] para Produto Entregue, aguarde..." )
		Else
			ConOut( "	UNIWS010 - FIntegra - Enviando Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "] para Produto Entregue." )
		EndIf

		nAuxRecNo := ( cAliasQry )->NUMRECNO
		DbSelectArea( "SC5" )
		SC5->( DbGoTo( nAuxRecNo ) )

		cMacro := "StaticCall( UNIWS005, FAtuStatus, @oWS, SC5->C5_XIDMAGE, 'produtos_entregues', '' )"

		//Efetiva a Atualização no Magento
		If &cMacro

			DbSelectArea( "SC5" )
			RecLock( "SC5", .F. )
			SC5->C5_XENVPRO := "S"
			SC5->( MsUnLock() )

			cMsgErro := "O Pedido Magento [" + SC5->C5_XIDMAGE + "] foi enviado para Produto(s) Entregue(s) com sucesso! - Pedido: " + SC5->C5_XIDMAGE + " - Nota Fiscal: " + SC5->C5_NOTA
			cMsgComp := cMsgErro
			If lSchedule
				ConOut( "	UNIWS010 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS010", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
			EndIf

		Else

			cMsgErro := "Erro ao tentar enviado o Pedido Magento [" + SC5->C5_XIDMAGE + "] para o Status Produto(s) Entregue(s)."
			cMsgComp := cMsgErro + " Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If !lSchedule
				Aviso( "Atenção", cMsgComp, { "Continuar" } )
			Else
				ConOut( "	UNIWS010 - FIntegra - " + cMsgComp )
				U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
			EndIf

		EndIf

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If lEncerra
		oWS:EndSession()
		ConOut( "	UNIWS010 FIntegra - Encerrou a sessao com o Magento" )
	EndIf

	RestArea( aAreaAnt )

Return

