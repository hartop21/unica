
/*/{Protheus.doc} UNIWS011

@project Integração Protheus x Magento
@description Rotina híbrida ( Menu / Schedule ) com o objetivo de executar a Integração do Protheus com o Magento no que Tange Cadastro de Produtos, atualizações de Saldo em Estoque e Tabela de Preço e Pedidos de Vendas
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

User Function UNIWS11S()
	U_UNIWS011( "01", "0207", "UARC01" )
Return

*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
User Function UNIWS011( cParamEmpJob, cParamFilJob, cParamInstancia, nParamEnvProd, nParamEnvTab, nParamEnvSld, nParamImpPV, nParamAtuChv, nParamAtuTransp, nParamAtuEntr )
	*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local oFontProc     := Nil
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cPerg         := "UNIWS011"
	Local cTitulo       := "Integração Protheus x Magento - Atual. Produtos/Preços/Estoque"
	Local cTexto        := "<font color='red'> Integração Protheus x Magento </font><br> Esta rotina tem como objetivo realizar a Exportação do Cadastro de Produtos, atualização de Preços e Saldo em estoque no E-commerce Magento."
	Private lSchedule 	:= IsBlind()
	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Default cParamEmpJob	:= ""
	Default cParamFilJob	:= ""
	Default cParamInstancia := ""
	Default nParamEnvProd	:= 1
	Default nParamEnvTab	:= 1
	Default nParamEnvSld	:= 1
	Default nParamImpPV		:= 1
	Default nParamAtuChv	:= 1
	Default nParamAtuTransp	:= 1
	Default nParamAtuEntr	:= 1

	If cParamEmpJob == Nil
		cParamEmpJob := ""
	EndIf

	lSchedule := AllTrim( cParamEmpJob ) != ""

	If lSchedule

		ConOut( " ################################################################ " )
		ConOut( " ## INICIO INTEGRACAO MAGENTO UNIWS011 - " + DToC( Date() ) + " - " + Time() + " ##" )
		ConOut( " ################################################################ " )

		//Prepare Environment Empresa "01" Filial "0101"
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpJob, cParamFilJob )

		// Verifica a Necessidade da Criação de Trigger de Banco de dados para a Empresa Ponteirada
		FCria1Triggers( cParamEmpJob )
		FCria2Triggers( cParamEmpJob )

		//Pergunte( cPerg, .F. )
		MV_PAR01 := Space( TamSX3( "B1_COD" )[01] )
		MV_PAR02 := Replicate( "Z", TamSX3( "B1_COD" )[01] )
		MV_PAR03 := cParamInstancia
		MV_PAR04 := If( ValType( nParamEnvProd 	 ) == "C", Val( nParamEnvProd  	 ), nParamEnvProd 	 )
		MV_PAR05 := If( ValType( nParamEnvTab 	 ) == "C", Val( nParamEnvTab     ), nParamEnvTab     )
		MV_PAR06 := If( ValType( nParamEnvSld	 ) == "C", Val( nParamEnvSld     ), nParamEnvSld     )
		MV_PAR07 := If( ValType( nParamImpPV 	 ) == "C", Val( nParamImpPV      ), nParamImpPV      )
		MV_PAR08 := If( ValType( nParamAtuChv 	 ) == "C", Val( nParamAtuChv     ), nParamAtuChv     )
		MV_PAR09 := If( ValType( nParamAtuTransp ) == "C", Val( nParamAtuTransp  ), nParamAtuTransp  )
		MV_PAR10 := If( ValType( nParamAtuEntr 	 ) == "C", Val( nParamAtuEntr    ), nParamAtuEntr	 )
		FIntegra( lSchedule )

		//Reset Environment
		RPCClearEnv()

		ConOut( " ################################################################ " )
		ConOut( " ## FIM DA INTEGRACAO MAGENTO UNIWS011 - " + DToC( Date() ) + " - " + Time() + " ##" )
		ConOut( " ################################################################ " )

	Else

		// Monta Tela
		Pergunte( cPerg, .F. )

		// Verifica a Necessidade da Criação de Trigger de Banco de dados para a Empresa Ponteirada
		MsgRun( "Aguarde, gerando as perguntas de parâmetros", "Aguarde, gerando as perguntas de parâmetros", { || FCria1Triggers( cEmpAnt ) } )
		MsgRun( "Aguarde, gerando as perguntas de parâmetros", "Aguarde, gerando as perguntas de parâmetros", { || FCria2Triggers( cEmpAnt ) } )

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


Static Function FIntegra( lSchedule )

	Local oWS 			:= Nil
	Local cIntInstancia := MV_PAR03
	Local nIntEnvProd 	:= MV_PAR04
	Local nIntEnvTab 	:= MV_PAR05
	Local nIntEnvSld 	:= MV_PAR06
	Local nIntImpPV 	:= MV_PAR07
	Local nIntAtuChv 	:= MV_PAR08
	Local nIntAtuTransp	:= MV_PAR09
	Local nIntAtuEntr	:= MV_PAR10

	//Definiçao das Horas para execucao das atividades de Integração com o Magento
	Local cTimeTabPreco := "" //AllTrim( GetNewPar( "MV_XTMPRC", "10,11,14,19" ) )
	Local cTimeEnvChave	:= AllTrim( GetNewPar( "MV_XTMCHV", "14,15,16,17,18,19,20,21,22,23,00,01,02,03,04,05,06" ) ) //"11,15,17" ) )
	Local cTimeEnvTransp:= AllTrim( GetNewPar( "MV_XTMTRA", "12,14,18,20,21,22,23,00,01,02,03,04,05,06" ) )
	Local cTimeEnvEntreg:= AllTrim( GetNewPar( "MV_XTMENT", "13,15,20,21,22,23,00,01,02,03,04,05,06"    ) )

	cNumLoteLog			:= GetSXENum( "SZ5", "Z5_CODIGO" )
	ConfirmSX8()

	ConOut( "+------------------------------------------------" )
	ConOut( "| INSTANCIA ..................: " + cIntInstancia  )
	ConOut( "| LOTE LOG ...................: " + cNumLoteLog    )
	ConOut( "| DATA INICIO ................: " + DToC( Date() ) )
	ConOut( "| HORA INICIO ................: " + Time()  		)
	ConOut( "| AGENDAMENTO TABELA PRECOS ..: " + cTimeTabPreco  )
	ConOut( "| AGENDAMENTO ENVIO CHAVE NF .: " + cTimeEnvChave  )
	ConOut( "| AGENDAMENTO ENVIO TRANSPORT.: " + cTimeEnvTransp )
	ConOut( "| AGENDAMENTO ENVIO ENTREGAS .: " + cTimeEnvEntreg )
	ConOut( "+------------------------------------------------" )

	If Type( "_c_WsLnkMagento" ) != "C"

		DbSelectArea( "SZ8" )
		DbSetOrder( 01 )
		Seek XFilial( "SZ8" ) + cIntInstancia
		If Found()

			// Se estiver bloqueado
			If AllTrim( SZ8->Z8_MSBLQL ) == "1"

				cMsgErro 	:= "A Instancia Magento [ " + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + " ] esta bloqueada para uso, a rotina nao sera executada."
				cMsgComp 	:= cMsgErro
				If lSchedule
					ConOut( "	UNIWS011 - FIntegra - " + cMsgErro )
					U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS011"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
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

			cMsgErro 	:= "Nao encontrou uma Instancia valida para a Integração com o Magento [ " + MV_PAR03 + " ], a rotina nao sera executada."
			cMsgComp 	:= cMsgErro
			If lSchedule
				ConOut( "	UNIWS011 - FIntegra - " + cMsgErro )
				U_UNIGrvLog( cNumLoteLog , "", 	 "", "UNIWS011"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Else
				Aviso( "Atenção", cMsgComp, { "Voltar" } )
			EndIf
			Return

		EndIf

	EndIf

	// Realiza o Login na API
	oWS 		 	:= WSMagentoService():New()
	oWs:cUserName	:= _c_WsUserMagento //AllTrim( GetNewPar( "MV_XUSRMAG", "totvs" 	    ) )
	oWs:cApiKey		:= _c_WsPassMagento //AllTrim( GetNewPar( "MV_XPSWMAG", "jh2J2UaR0293jGHk2wAvB" ) ) // Homologação
	If !oWs:Login()

		cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
		cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
		If lSchedule
			ConOut( "	UNIWS011 - FIntegra - " + cMsgErro )
			U_UNIGrvLog( cNumLoteLog , ""			, 	  		   "", "UNIWS011"  ,    "FIntegra", cMsgErro	, cMsgComp	 , ""		 , 0 )
			Return
		Else
			Aviso( "Atenção", "Erro ao tentar realizar login na API de Integração com o Magento." + CRLF + "Erro : " + GetWSCError(), { "Voltar" } )
			Return
		EndIf

	EndIf
	oWs:cSessionId := oWs:cLoginReturn

	If nIntEnvProd == 01
		ConOut( "	- UNIWS011 - UNIWS002 - Iniciando Rotina de Exportacao do Cadastro de Produtos... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
		U_UNIWS002( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
	Else
		ConOut( "	- UNIWS011 - UNIWS002 - Rotina desabilitada Exportacao do Cadastro de Produtos em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuChv == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvChave )
			ConOut( "	- UNIWS011 - UNIWS005 - Iniciando Rotina de Envio da Chave das Notas para o Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS005( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio da Chave das Notas abortada - Fora do horario definido para a execucao [ " + cTimeEnvChave + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS005 - Rotina Envio da Chave das Notas para o Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuEntr == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvEntreg )
			ConOut( "	- UNIWS011 - UNIWS010 - Iniciando Rotina de Envio do Pedido para status Produto(s) Entregue(s)... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS010( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Pedido para status Produto(s) Entregue(s) abortada - Fora do horario definido para a execucao [ " + cTimeEnvEntreg + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS010 - Rotina Envio do Pedido para status Produto(s) Entregue(s) desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf


	If nIntAtuTransp == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvTransp )
			ConOut( "	- UNIWS011 - UNIWS009 - Iniciando Rotina de Envio do Pedido para Transportadora no Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS009( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio do Pedido para Transportadora abortada - Fora do horario definido para a execucao [ " + cTimeEnvTransp + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS009 - Rotina Envio do Pedido para Transportadora no Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf


	If nIntEnvTab == 01

		//If Left( Time(), 02 ) $ AllTrim( cTimeTabPreco )
		ConOut( "	- UNIWS011 - UNIWS006 - Iniciando Rotina de Atualizacao da Tabela de Precos... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
		U_UNIWS006( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		//Else
		//	ConOut( "	- UNIWS011 - UNIWS006 - Rotina Atualizacao da Tabela de Precos abortada - Fora do horario definido para a execucao [ " + cTimeTabPreco + "] - Instancia [" + cIntInstancia + "] ." )
		//EndIf

	Else

		ConOut( "	- UNIWS011 - UNIWS006 - Rotina Atualizacao da Tabela de Precos desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )

	EndIf


	If nIntAtuChv == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvChave )
			ConOut( "	- UNIWS011 - UNIWS005 - Iniciando Rotina de Envio da Chave das Notas para o Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS005( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio da Chave das Notas abortada - Fora do horario definido para a execucao [ " + cTimeEnvChave + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS005 - Rotina Envio da Chave das Notas para o Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuTransp == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvTransp )
			ConOut( "	- UNIWS011 - UNIWS009 - Iniciando Rotina de Envio do Pedido para Transportadora no Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS009( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio do Pedido para Transportadora abortada - Fora do horario definido para a execucao [ " + cTimeEnvTransp + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS009 - Rotina Envio do Pedido para Transportadora no Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuEntr == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvEntreg )
			ConOut( "	- UNIWS011 - UNIWS010 - Iniciando Rotina de Envio do Pedido para status Produto(s) Entregue(s)... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS010( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Pedido para status Produto(s) Entregue(s) abortada - Fora do horario definido para a execucao [ " + cTimeEnvEntreg + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS010 - Rotina Envio do Pedido para status Produto(s) Entregue(s) desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntImpPV == 01
		ConOut( "	- UNIWS011 - UNIWS001 - Iniciando Rotina de Importacao dos Pedidos de vendas... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
		U_UNIWS001( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog)
	Else
		ConOut( "	- UNIWS011 - UNIWS001 - Rotina de Importacao dos Pedidos de vendas desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuChv == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvChave )
			ConOut( "	- UNIWS011 - UNIWS005 - Iniciando Rotina de Envio da Chave das Notas para o Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS005( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio da Chave das Notas abortada - Fora do horario definido para a execucao [ " + cTimeEnvChave + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS005 - Rotina Envio da Chave das Notas para o Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuTransp == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvTransp )
			ConOut( "	- UNIWS011 - UNIWS009 - Iniciando Rotina de Envio do Pedido para Transportadora no Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS009( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio do Pedido para Transportadora abortada - Fora do horario definido para a execucao [ " + cTimeEnvTransp + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS009 - Rotina Envio do Pedido para Transportadora no Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuEntr == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvEntreg )
			ConOut( "	- UNIWS011 - UNIWS010 - Iniciando Rotina de Envio do Pedido para status Produto(s) Entregue(s)... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS010( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Pedido para status Produto(s) Entregue(s) abortada - Fora do horario definido para a execucao [ " + cTimeEnvEntreg + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS010 - Rotina Envio do Pedido para status Produto(s) Entregue(s) desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntEnvSld == 01
		ConOut( "	- UNIWS011 - UNIWS007 - Iniciando Rotina de Atualizacao do Saldo em Estoque... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
		U_UNIWS007( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
	Else
		ConOut( "	- UNIWS011 - UNIWS007 - Rotina Atualizacao do Saldo em Estoque desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuChv == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvChave )
			ConOut( "	- UNIWS011 - UNIWS005 - Iniciando Rotina de Envio da Chave das Notas para o Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS005( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio da Chave das Notas abortada - Fora do horario definido para a execucao [ " + cTimeEnvChave + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS005 - Rotina Envio da Chave das Notas para o Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuTransp == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvTransp )
			ConOut( "	- UNIWS011 - UNIWS009 - Iniciando Rotina de Envio do Pedido para Transportadora no Magento... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS009( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Envio do Pedido para Transportadora abortada - Fora do horario definido para a execucao [ " + cTimeEnvTransp + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS009 - Rotina Envio do Pedido para Transportadora no Magento desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntAtuEntr == 01
		If Left( Time(), 02 ) $ AllTrim( cTimeEnvEntreg )
			ConOut( "	- UNIWS011 - UNIWS010 - Iniciando Rotina de Envio do Pedido para status Produto(s) Entregue(s)... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
			U_UNIWS010( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog )
		Else
			ConOut( "	- UNIWS011 - UNIWS006 - Rotina Pedido para status Produto(s) Entregue(s) abortada - Fora do horario definido para a execucao [ " + cTimeEnvEntreg + "] - Instancia [" + cIntInstancia + "] ." )
		EndIf
	Else
		ConOut( "	- UNIWS011 - UNIWS010 - Rotina Envio do Pedido para status Produto(s) Entregue(s) desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	If nIntImpPV == 01
		ConOut( "	- UNIWS011 - UNIWS001 - Iniciando Rotina de Importacao dos Pedidos de vendas... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
		U_UNIWS001( cEmpAnt, cFilAnt, cIntInstancia, @oWs, cNumLoteLog)
	Else
		ConOut( "	- UNIWS011 - UNIWS001 - Rotina de Importacao dos Pedidos de vendas desabilitada em parametros. Nao sera executada... [" + cIntInstancia + "] - ( " + DtoC( Date() ) + " - " + Time() + " )" )
	EndIf

	oWS:EndSession()
	ConOut( "+------------------------------------------------+" )
	ConOut( "|	UNIWS011 - Encerrou a Sessao com o Magento    |" )
	ConOut( "+------------------------------------------------+" )
	ConOut( "| INSTANCIA ..................: " + cIntInstancia  )
	ConOut( "| LOTE LOG ...................: " + cNumLoteLog    )
	ConOut( "| DATA FIM ...................: " + DToC( Date() ) )
	ConOut( "| HORA FIM ...................: " + Time()  		)
	ConOut( "+------------------------------------------------" )

Return


*---------------------------------------------*
Static Function FCria1Triggers( cParamEmpresa )
	*---------------------------------------------*
	Local aAreaold			:= GetArea()
	Local cAliasExists 		:= GetNextAlias()
	Local cExists 			:= ""
	Local cCreate 			:= ""
	Local lExisteTrigger 	:= .F.

	ConOut( "	- UNIWS007 - FCriaTriggers - Verifica a Necessidade da Criacao das Triggers para a Empresa / Filial" )

	// Temporário, caso precise recriar a Trigger
	cExists := "   SELECT COUNT( * ) AS NACHOU 	"
	cExists += "	 FROM sysobjects (NOLOCK) 	"
	cExists += "	WHERE type = 'TR' 			"
	cExists += "	  AND name = 'TR_UNICA_ATUALIZA_ESTOQUE_MAGENTO" + cParamEmpresa + "' "
	If Select( cAliasExists ) > 0
		( cAliasExists )->( DbCloseArea() )
	EndIf
	TcQuery cExists Alias ( cAliasExists ) New
	If !( cAliasExists )->( Eof() )
		lExisteTrigger  := ( ( cAliasExists )->NACHOU > 00 )
	EndIf
	( cAliasExists )->( DbCloseArea() )

	If !lExisteTrigger

		ConOut( "	- UNIWS007 - FCriaTriggers - Nao Localizou a Trigger, a mesma precisa ser criada" )
		cCreate := "CREATE TRIGGER TR_UNICA_ATUALIZA_ESTOQUE_MAGENTO" + cParamEmpresa + " ON " + RetSQLName( "SB2" ) + " AFTER UPDATE "
		cCreate += "AS "
		cCreate += "	BEGIN   "
		cCreate += "		IF EXISTS (  SELECT *                           "
		cCreate += "		     		   FROM inserted I, 				"
		cCreate += "		          	    	deleted  D                  "
		cCreate += "					  WHERE I.R_E_C_N_O_ = D.R_E_C_N_O_ "
		cCreate += "			  		    AND ( ( I.B2_QATU   	!= D.B2_QATU 	)   "
		cCreate += "			     		   OR ( I.B2_QEMP   	!= D.B2_QEMP 	)   "
		cCreate += "			     		   OR ( I.B2_RESERVA    != D.B2_RESERVA ) ) ) "

		cCreate += "		BEGIN "
		cCreate += "			 UPDATE " + RetSQLName( "SB2" )
		cCreate += "		   		SET B2_XFLGMAG = 'S' "
		cCreate += "		 	  WHERE R_E_C_N_O_ IN ( SELECT DISTINCT D.R_E_C_N_O_ FROM deleted D ) "
		cCreate += "		END "
		cCreate += "	END     "
		If TCSQLExec( cCreate ) != 0
			Aviso( "Atenção", "Erro ao tentar criar a Trigger de banco de dados para atualização do flag de exportacao do Estoque para o Magento." + CRLF + TcSQLError(), { "Sair" }, 03 )
			ConOut( "	- UNIWS007 - FCriaTriggers - Erro ao tentar criar a Trigger de banco de dados para atualizacao do flag de exportacao do Estoque para o Magento - " + TcSQLError() )
		Else
			ConOut( "	- UNIWS007 - FCriaTriggers - Trigger Criada com sucesso - [ TR_UNICA_ATUALIZA_ESTOQUE_MAGENTO" + cParamEmpresa + "]" )
		EndIf

	EndIf

	RestArea( aAreaOld )

Return

*---------------------------------------------*
Static Function FCria2Triggers( cParamEmpresa )
	*---------------------------------------------*
	Local aAreaold			:= GetArea()
	Local cAliasExists 		:= GetNextAlias()
	Local cExists 			:= ""
	Local cCreate 			:= ""
	Local lExisteTrigger 	:= .F.

	ConOut( "	- UNIWS006 - FCriaTriggers - Verifica a Necessidade da Criacao das Triggers para a Empresa / Filial" )

	// Temporário, caso precise recriar a Trigger
	//TcSQLExec( "DROP TRIGGER TR_UNICA_ATUALIZA_ESTOQUE_MAGENTO" + cParamEmpresa )

	cExists := "   SELECT COUNT( * ) AS NACHOU 	"
	cExists += "	 FROM sysobjects (NOLOCK) 	"
	cExists += "	WHERE type = 'TR' 			"
	cExists += "	  AND name = 'TR_UNICA_ATUALIZA_PRECO_MAGENTO" + cParamEmpresa + "' "
	If Select( cAliasExists ) > 0
		( cAliasExists )->( DbCloseArea() )
	EndIf
	TcQuery cExists Alias ( cAliasExists ) New
	If !( cAliasExists )->( Eof() )
		lExisteTrigger  := ( ( cAliasExists )->NACHOU > 00 )
	EndIf
	( cAliasExists )->( DbCloseArea() )

	If !lExisteTrigger

		ConOut( "	- UNIWS006 - FCriaTriggers - Nao Localizou a Trigger, a mesma precisa ser criada" )
		cCreate := "CREATE TRIGGER TR_UNICA_ATUALIZA_PRECO_MAGENTO" + cParamEmpresa + " ON " + RetSQLName( "DA1" ) + " AFTER UPDATE "
		cCreate += "AS "
		cCreate += "	BEGIN   "
		cCreate += "		IF EXISTS (  SELECT *                           "
		cCreate += "		     		   FROM inserted I, 				"
		cCreate += "		          	    	deleted  D                  "
		cCreate += "					  WHERE I.R_E_C_N_O_ = D.R_E_C_N_O_ "
		cCreate += "			  		    AND ( ( I.DA1_PRCVEN   	!= D.DA1_PRCVEN ) ) ) "
		cCreate += "		BEGIN "
		cCreate += "			 UPDATE " + RetSQLName( "DA1" )
		cCreate += "		   		SET DA1_XFLGMA = 'S' "
		cCreate += "		 	  WHERE R_E_C_N_O_ IN ( SELECT DISTINCT D.R_E_C_N_O_ FROM deleted D ) "
		cCreate += "		END "
		cCreate += "	END     "
		If TCSQLExec( cCreate ) != 0
			Aviso( "Atenção", "Erro ao tentar criar a Trigger de banco de dados para atualização do flag de exportacao da Tabela de Precos para o Magento." + CRLF + TcSQLError(), { "Sair" }, 03 )
			ConOut( "	- UNIWS006 - FCriaTriggers - Erro ao tentar criar a Trigger de banco de dados para atualizacao do flag de exportacao da Tabela de Precos para o Magento - " + TcSQLError() )
		Else
			ConOut( "	- UNIWS006 - FCriaTriggers - Trigger Criada com sucesso - [ TR_UNICA_ATUALIZA_PRECO_MAGENTO" + cParamEmpresa + "]" )
		EndIf

	EndIf

	RestArea( aAreaOld )

Return

User Function UNIWS11C()

	RPCSetType( 03 )
	RPCSetEnv( "01", "0101" )
	TcSQLExec( "TR_UNICA_ATUALIZA_ESTOQUE_MAGENTO01" )
	TcSQLExec( "TR_UNICA_ATUALIZA_PRECO_MAGENTO01" )
	FCria1Triggers( "01" )
	FCria2Triggers( "01" )
	RPCClearEnv()

Return
