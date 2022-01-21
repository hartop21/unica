*----------------------------------*
/*/{Protheus.doc} UNIWS009

@project Integra��o Protheus x Magento

@description Rotina respons�vel pela atualiza��o das informa��es de Envio do Pedido E-Commerce para a transportadora.
author Rafael Rezende
@since 15/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.CH"
#Include "ApWebSrv.ch"


User Function UNIWS09S()

	U_UNIWS009( "01", "0207", "", Nil, "" )
Return

*-----------------------------------------------------------------------------------------------*
User Function UNIWS009( cParamEmpJob, cParamFilJob, cParamInstancia, oParamWS, cParamNumLoteLog )
	*-----------------------------------------------------------------------------------------------*
	Local oFontProc     	:= Nil
	Local oDlgProc      	:= Nil
	Local oGrpTexto     	:= Nil
	Local oSayTexto     	:= Nil
	Local oBtnConfi     	:= Nil
	Local oBtnParam     	:= Nil
	Local oBtnSair      	:= Nil
	Local lHtml         	:= .T.
	Local lConfirmou    	:= .F.
	Local cPerg         	:= "UNIWS009"
	Local cTitulo   	    := "Integra��o Protheus x Magento - Envio do Pedido para Transportadora"
	Local cTexto       		:= "<font color='red'> Integra��o Protheus x Magento </font><br> Esta rotina tem como objetivo de atualizar o Status do Pedido no Magento, enviando o mesmo para Transportadora.<br>Informe o Pedido a ser atualizado na op��o de <b>Par�metros</b> e confirme a rotina."
	Private lSchedule 		:= .F. //IsBlind()

	//Default aParams 		 := {}
	Default cParamEmpJob	 := ""
	Default cParamFilJob	 := ""
	Default cParamInstancia	 := ""
	Default oParamWS    	 := Nil
	Default cParamNumLoteLog := ""

	cTexto 	            	:= "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf
	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " #################################################################################### " )
		ConOut( " ## INICIO INTEGRACAO UNIWS009 - ENVIO PARA TRANSPORTADORA - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " #################################################################################### " )
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob )

		//Gerando Perguntas do Par�metro
		MV_PAR01 := Space( TamSX3( "C5_NUM" )[01] )
		MV_PAR02 := Replicate( "Z", TamSX3( "C5_NUM" )[01] )
		MV_PAR03 := Space( TamSX3( "C5_XIDMAGE" )[01] )
		MV_PAR04 := Replicate( "Z", TamSX3( "C5_XIDMAGE" )[01] )
		MV_PAR05 := cParamInstancia
		FIntegra( lSchedule, oParamWS, cParamNumLoteLog )

		RPCClearEnv()
		ConOut( " ################################################################################### " )
		ConOut( " ## FINAL INTEGRACAO UNIWS009 - ENVIO PARA TRANSPORTADORA - " + DToC( Date() ) + " " + Time() + " ##" )
		ConOut( " ################################################################################### " )

	Else

		// Monta Tela
		Pergunte( cPerg, .F. )

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Atualizar" , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 083, "&Par�metros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
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
		Aviso( "Aten��o", "O Par�metro [ Pedido at� ? ] � obrigat�rio.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR04 ) == ""
		Aviso( "Aten��o", "O Par�metro [ Id Magento at� ? ] � obrigat�rio.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR05 ) == ""
		Aviso( "Aten��o", "O Par�metro [ WSDL Magento ? ] � obrigat�rio.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet

*----------------------------------------------------------*
Static Function FIntegra( lSchedule, oWS, cParamNumLoteLog )
	*----------------------------------------------------------*
	Local aAreaAnt 			:= GetArea()
	Local lEncerra			:= .T.
	Local nAuxRecNo 		:= 0
	Local cAliasQry 		:= GetNextAlias()
	Local nContador			:= 0
	Local nNumRegistros     := GetNewPar( "MV_XNUMREG", 10 )
	Local cMacro := ""
	Private cNumLoteLog		:= ""
	Default oWS				:= Nil
	Default cParamNumLoteLog:= ""

	If AllTrim( cParamNumLoteLog ) == ""
		cNumLoteLog			:= GetSXENum( "SZ5", "Z5_CODIGO" )
		ConfirmSX8()
		ConOut( "	UNIWS009 - FIntegra - Gerou Lote para o Log: " + cNumLoteLog )
	Else
		cNumLoteLog			:= cParamNumLoteLog
		ConOut( "	UNIWS009 - FIntegra - Reaproveitou o Lote para o Log: " + cNumLoteLog )
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
					ConOut( "	UNIWS009 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS009"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
					Return
				Else
					Aviso( "Aten��o", cMsgComp, { "Voltar" } )
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

			cMsgErro 	:= "N�o encontrou uma Instancia v�lida para a Integra��o com o Magento [ " + MV_PAR05 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS009 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS009"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "Aten��o", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	If oWS == Nil

		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cUserName	:= _c_WsUserMagento //AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
		//oWs:capiKey	:= AllTrim( GetNewPar( "MV_XPSWMAG", "suporte#2019" ) ) //Produ��o
		oWs:cApiKey		:= _c_WsPassMagento //AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologa��o
		If !oWs:Login()

			cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
			cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
			If lSchedule
				ConOut( "	UNIWS009 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS009"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
				Return
			Else
				Aviso( "Aten��o", "Erro ao tentar realizar login na API de Integra��o com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
				Return
			EndIf

		EndIf
		oWs:cSessionId 	:= oWs:cLoginReturn
		lEncerra		:= .T.
		ConOut( "	UNIWS009 - FIntegra - Criou nova Sessao de API com o Magento" )

	Else

		oWs:cSessionId := oWs:cLoginReturn
		lEncerra	:= .F.
		ConOut( "	UNIWS009 - FIntegra - Manteve a Sessao de API" )

	EndIf

	cQuery := "   SELECT TOP " + StrZero( nNumRegistros, 03 ) + " SC5.R_E_C_N_O_ AS NUMRECNO, C5_XIDMAGE, F2_DOC, F2_SERIE, F2_CHVNFE  "
	cQuery += "	    FROM " + RetSQLName( "SC5" ) + " SC5 ( NOLOCK ), "
	cQuery += "	         " + RetSQLName( "SF2" ) + " SF2 ( NOLOCK )  "
	cQuery += "    WHERE SC5.D_E_L_E_T_  	  = ' ' "
	cQuery += "      AND SF2.D_E_L_E_T_  	  = ' ' "
	cQuery += "      AND C5_FILIAL 			  = F2_FILIAL  "
	cQuery += "      AND C5_NOTA			  = F2_DOC     "
	cQuery += "      AND C5_SERIE			  = F2_SERIE   "
	cQuery += "      AND C5_CLIENTE			  = F2_CLIENTE "
	cQuery += "      AND C5_LOJACLI			  = F2_LOJA    "
	cQuery += "      AND C5_NOTA 			 != ''		   "
	cQuery += "		 AND C5_NUM     	BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "		 AND C5_XIDMAGE 	BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	cQuery += "		 AND C5_XIDMAGE 		 != ''  "
	cQuery += "		 AND C5_XENVCHV           = 'S' "
	cQuery += "		 AND C5_XENVTRA      	 != 'S' "
	cQuery += "		 AND C5_XDTCOLE      	 != '        ' "
	cQuery += "		 AND C5_XCODSZ8       	  = '" + _c_WsCodInstancia + "' "
	cQuery += "		 AND F2_XMINUTA 		 != '' "
	cQuery += "		 AND F2_FIMP           	  = 'S'  " // ---- LEANDRO RIBEIRO ---- 13/12/2019 ---- //
	cQuery += "	ORDER BY SC5.R_E_C_N_O_ DESC "
	ConOut( "cQuery " + cQuery )
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasQry ) New

	nContador := 0
	Count To nContador
	If !lSchedule
		ProcRegua( nContador )
	EndIf

	nCntAtual := 00
	//ConOut( "	UNIWS009 - FIntegra - Pedidos a Processar [  " + AllTrim( Str( nContador ) ) + " ]" )
	DbSelectArea( cAliasQry )
	( cAliasQry )->( DbGoTop() )

	If ( cAliasQry )->( Eof() )
		ConOut( "	UNIWS009 - FIntegra - Nao encontrou pedidos pendentes para enviar para transportadora" )
	EndIf

	Do While !( cAliasQry )->( Eof() )

		nCntAtual++
		lProssegue := .T.

		If !lSchedule
			IncProc( "Enviando Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "] para Transportadora, aguarde..." )
		Else
			ConOut( "	UNIWS009 - FIntegra - Enviando Pedido [" + AllTrim( ( cAliasQry )->C5_XIDMAGE ) + "] para Transportadora. [ " + AllTrim( Str( nCntAtual ) ) + " / " + AllTrim( Str( nContador ) ) + " ]" )
		EndIf

		nAuxRecNo := ( cAliasQry )->NUMRECNO

		DbSelectArea( "SC5" )
		SC5->( DbGoTo( nAuxRecNo ) )

		//Verifica se est� faturado
		If AllTrim( SC5->C5_NOTA ) == ""

			cMsgErro := "O Pedido [ " + AllTrim( SC5->C5_XIDMAGE ) + " ] nao possui Nota para ser enviado para Transporte."
			cMsgComp := cMsgErro
			If !lSchedule
				Aviso( "Aten��o", cMsgErro, { "Voltar" } )
			Else
				ConOut( "	UNIWS009 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
			EndIf
			lProssegue := .F.

		EndIf

		//Verifica se est� faturado
		If lProssegue

			If AllTrim( SC5->C5_TRANSP ) == ""

				cMsgErro := "O Pedido [ " + AllTrim( SC5->C5_XIDMAGE ) + " ] nao possui uma Transportadora para envio."
				cMsgComp := cMsgErro
				If !lSchedule
					Aviso( "Aten��o", cMsgErro, { "Voltar" } )
				Else
					ConOut( "	UNIWS009 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
				EndIf
				lProssegue := .F.

			EndIf

		EndIf

		If lProssegue

			// Verifica se j� criou o Id de Rastreabilidade do Frete no Magento
			If AllTrim( SC5->C5_XIDFRET ) == ""

				//WSMETHOD salesOrderShipmentCreate WSSEND csessionId,corderIncrementId,oWSsalesOrderShipmentCreateitemsQty,ccomment,nemail,nincludeComment WSRECEIVE cshipmentIncrementId WSCLIENT WSMagentoService
				oWs:cOrderIncrementId					:= SC5->C5_XIDMAGE //""//FwTimeStamp( 01 ) //?????????
				oWs:oWSsalesOrderShipmentCreateitemsQty := {}
				aAdd( oWs:oWSsalesOrderShipmentCreateitemsQty, WsClassNew( "MagentoService_OrderItemIdQty" ) )
				oWs:cComment				:= ""
				oWs:nEmail					:= 0
				oWs:nIncludeComment			:= 0
				oWs:cIncludeInEmail			:= ""
				If !oWs:SalesOrderShipmentCreate()

					cMsgErro := "Erro ao tentar criar o Id de Rastreabilidade para o Frete no Magento - Pedido [" + SC5->C5_XIDMAGE + "]."
					cMsgComp := cMsgErro + " - Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
					If !lSchedule
						Aviso( "Aten��o", cMsgErro, { "Voltar" } )
					Else
						ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
						U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
					EndIf
					cIdFrete 	:= ""
					lProssegue 	:= .F.

				Else

					// Pega o Id do Traching
					cIdFrete := oWs:cShipmentIncrementId

					//Grava no Pedido o Id Interno do Frete
					DbSelectArea( "SC5" )
					RecLock( "SC5", .F. )
					SC5->C5_XIDFRET := cIdFrete
					SC5->( MsUnLock() )

					cMsgErro := "Id do Frete criado para o Pedido [" + SC5->C5_XIDMAGE + "] - Id Frete [" + cIdFrete + "]."
					cMsgComp := cMsgErro
					If lSchedule
						ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
						U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
					EndIf
					lProssegue := .T.

				EndIf

			Else

				// Pega o Id interno gerado para o Frete
				cIdFrete  	:= SC5->C5_XIDFRET

				cMsgErro := "Id do Frete ja existente para o Pedido [" + SC5->C5_XIDMAGE + "] - Id Frete [" + cIdFrete + "]."
				cMsgComp := cMsgErro
				If lSchedule
					ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
					U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
				EndIf
				lProssegue := .T.

			EndIf

		EndIf

		// Atualiza o Status no Magento
		If lProssegue

			cAuxTransportadora := ""
			DbSelectArea( "SA4" )
			DbSetOrder( 01 ) // A4_FILIAL + A4_CODIGO
			Seek XFilial( "SA4" ) + SC5->C5_TRANSP
			If Found()
				cAuxTransportadora 	:= SA4->A4_NREDUZ
			Else
				cAuxTransportadora 	:= "TRANSPORTADORA N/I"
			EndIf

			// Altera o Pedido para Enviado para Transportadora e cria rastreabilidade
			If ( cIdFrete != Nil .And. AllTrim( cIdFrete ) != "" )

				// WSMETHOD salesOrderShipmentAddTrack WSSEND csessionId,cshipmentIncrementId,ccarrier,ctitle,ctrackNumber WSRECEIVE nresult WSCLIENT WSMagentoService
				oWs:cShipmentIncrementId	:= cIdFrete
				oWs:cCarrier				:= "dhl" // "Transportadora" /cAuxTransportadora //"ups" //, usps, dhl, fedex, or dhlint)
				oWs:cTitle					:= cAuxTransportadora
				oWs:cTrackNumber            := SC5->C5_NOTA  // "1" // Numero para Rastreabilidade
				If !oWs:SalesOrderShipmentAddTrack()

					cMsgErro := "Erro ao tentar Criar o Tracking para o Frete no Magento - Pedido [" + SC5->C5_XIDMAGE + "]."
					cMsgComp := cMsgErro + " - Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
					If !lSchedule
						Aviso( "Aten��o", cMsgErro, { "Voltar" } )
					Else
						ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
						U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
					EndIf

				Else

					cMsgErro := "Tracking criado para o Frete no Magento - Pedido [" + SC5->C5_XIDMAGE + "]."
					cMsgComp := cMsgErro + " - Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
					If lSchedule
						ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
						U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
					EndIf

				EndIf

			Else

				cMsgErro := "Erro ao tentar Criar o Tracking para o Frete no Magento - Pedido [" + SC5->C5_XIDMAGE + "]."
				cMsgComp := cMsgErro + " - Erro : Nao encontrou o Id do Frete"
				If lSchedule
					ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
					U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
				EndIf

			EndIf

		EndIf

		//Atualiza o Status para "Produto(s) em transporte"
		If lProssegue

			cMacro := 'StaticCall( UNIWS005, FAtuStatus, @oWS, SC5->C5_XIDMAGE, "produtos_em_transporte", "" ) '

			If &cMacro

				DbSelectArea( "SC5" )
				RecLock( "SC5", .F. )
				SC5->C5_XENVTRA := "S"
				SC5->( MsUnLock() )

				cMsgErro := "O Pedido Magento [" + SC5->C5_XIDMAGE + "] foi enviado para Transporte com sucesso!" + CRLF + "Pedido: " + SC5->C5_XIDMAGE + CRLF + "Transportadora: " + cAuxTransportadora + CRLF + "Nota Fiscal: " + SC5->C5_NOTA
				cMsgComp := cMsgErro
				If lSchedule
					ConOut( "	UNIWS009 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
				EndIf

			Else

				cMsgErro := "Erro ao tentar enviado o Pedido Magento [" + SC5->C5_XIDMAGE + "] para Transporte."
				cMsgComp := cMsgErro + " Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
				If !lSchedule
					Aviso( "Aten��o", cMsgComp, { "Continuar" } )
				Else
					ConOut( "	UNIWS009 - FIntegra - " + cMsgComp )
					U_UNIGrvLog( cNumLoteLog , "", SC5->C5_XIDMAGE, "UNIWS009", "FIntegra", cMsgErro, cMsgComp, "SC5", SC5->( RecNo() ) )
				EndIf

			EndIf

		EndIf

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If lEncerra
		oWS:EndSession()
		ConOut( "	UNIWS009 FIntegra - Encerrou a sessao com o Magento" )
	EndIf

	RestArea( aAreaAnt )

Return

