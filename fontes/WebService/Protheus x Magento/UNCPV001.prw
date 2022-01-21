#Include "TOTVS.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RESTFUL.CH"


/*±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³LoginVtu ºAutor ³Homero Junior(teclesoft)º Data ³18/02/2020  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Obtenção da chave de acesso para integração com o Magento	  º±±
±±º          ³onde será usada em todas as demais integrações.			  º±±
±±º          ³sendo que a intenção é pegar o pedido MKTPLACE e vincular	  º±±
±±º          ³no pedido Protheus/Magento de forma retroativa.			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ UNICA ARCODICIONADO  									  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ±±*/


Static Function LoginVtu()
	Local oXml	:= ""
	Local cError := ""
	Local cWarning := ""
	Local cRet		:= ""
	Public _c_WsUserMagento := "koncilia"
	Public _c_WsPassMagento := "Acessokoncilia@2020"
	Public _C_WSLNKMAGENTO		:= "https://www.unicaarcondicionado.com.br/index.php/api/v2_soap"
	Public oWS
	oWS 		 	:= WSMagentoService():New()
	oWs:cUserName	:= _c_WsUserMagento
	oWs:cApiKey		:= _c_WsPassMagento
	If !oWs:Login()
		cMsgErro := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada."
		cMsgComp := "Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " )
	EndIf
	oWs:cSessionId := oWs:cloginReturn
	lEncerra	:= .T.
	ConOut( "	UNIWS001 - FIntegra - Criou nova Sessao de API com o Magento" )
Return cRet

Static Function PedInfo( cParamIdPedido, oParamWS, lSchedule )
	Local lRetA := .F.
	Local cNumMKT := ""
	oParamWS:cOrderIncrementId 			:= cParamIdPedido
	oParamWS:oWSsalesOrderInfoResult 	:= MagentoService_SALESORDERENTITY():New()
	lRetA := oParamWS:SalesOrderInfo()
	If !lRetA

		//	cMsgErro  := "Erro ao tentar executar o Método [ salesOrderInfo ]. "
		//	cMsgCompl := "Erro ao tentar executar o Método [ salesOrderInfo ]. " + Replace( Replace( GetWSCError(), Chr(10), " " ), Chr( 13 ), "" )
		//	If lSchedule
		//		ConOut( "	UNIWS001 - FIntegra - FRetPVInfo - " + cMsgErro )
		//	Else
		//		Aviso( "Atenção", cMsgCompl, { "Continuar" } )
		//	EndIf
		//Else
		Alert("ERRO")
	Else
		cNumMKT := oParamWS:oWSsalesOrderInfoResult:CSKYHUB_CODE
	EndIf
Return cNumMKT

User Function UNCPV001()
	Local cQry := ""
	Local cIDPEDMKT := ""
	Local cPedNF := ""
	Local cTePVMKT := ""
	Local aDados := {}
	Local nSuss := 0
	Private aParams := {"01","0101"}
	PREPARE ENVIRONMENT EMPRESA aParams[1] FILIAL aParams[2]
	SL1->(DbSelectArea("SL1"))
	cQry := "SELECT L1_XIDMAGE,R_E_C_N_O_ FROM SL1010 WHERE L1_XIDMAGE <> '' AND L1_XPEDMKT = ''  AND D_E_L_E_T_ = '' "
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"QRY",.T.,.T.)
	QRY->(DbGotop())
	While QRY->(!EOF())
		aADD(aDados,{QRY->L1_XIDMAGE,QRY->R_E_C_N_O_})
		QRY->(DbSkip())
	End
	LoginVtu()
	For _xx := 1 To Len(aDados)
		If Empty(oWs:cSessionId)
			LoginVtu()
		EndIf
		SL1->(DbGoTO(aDados[_xx,2]))
		If AllTrim(SL1->L1_XPEDMKT) == "null"  .Or. Empty(SL1->L1_XPEDMKT)
			cIDPEDMKT := PedInfo(aDados[_xx,1],oWs,.T.)
			Sleep( 5000 )
		EndIf
		If Empty(cIDPEDMKT) .And. Empty(SL1->L1_XPEDMKT)
			cPedNF += aDados[_xx,1] + CRLF
		Else
			If Empty(SL1->L1_XPEDMKT) .And. (Len(AllTrim(cIDPEDMKT)) > 0 .And. Len(AllTrim(cIDPEDMKT)) <= 20) .And. aDados[_xx,2] == SL1->(Recno())  .And. AllTrim(cIDPEDMKT) <> "null"
				SL1->(Reclock("SL1",.F.))
				SL1->L1_XPEDMKT := cIDPEDMKT
				SL1->(MsUnlock())
				nSuss ++
			Else
				cTePVMKT += SL1->L1_XPEDMKT + CRLF //Ja tem pedido MKPLACE
			EndIf
		EndIf
		cTePVMKT := ""
	Next
Return