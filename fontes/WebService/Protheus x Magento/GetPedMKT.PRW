#Include "TOTVS.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RESTFUL.CH"

//Lucas Miranda de Aguiar - 11/06/2020
//GetPedMKT - Programa que busca no Magento o n√∫mero do pedido Marketplace


User Function GetPedMKT(cAuxIdPedido)
	//Local cQry := ""
	Local aArea		:= GetArea()
	Local cIDPEDMKT := ""
	//Local cPedNF := ""
	//Local cTePVMKT := ""
	//Local aDados := {}
	//Local nSuss := 0
	Private aParams := {"01","0101"}

	Default cAuxIdPedido := ""
	PREPARE ENVIRONMENT EMPRESA aParams[1] FILIAL aParams[2]
	If Empty(AllTrim(cAuxIdPedido))
		Conout("O pedido n„o foi gerado via Magento")
	Else
		LoginVtu()
		cIDPEDMKT := PedInfo(cAuxIdPedido,oWs,.T.)
		If Empty(AllTrim(cIDPEDMKT))
			cIDPEDMKT := " "
		EndIf
	EndIf
	RestArea(aArea)
Return cIDPEDMKT


Static Function LoginVtu()
	Local oXml	:= ""
	Local cError := ""
	Local cWarning := ""
	Local cRet		:= ""
	Public oWS
	oWS 		 	:= WSMagentoService():New()
	oWs:cUserName	:= _c_WsUserMagento
	oWs:cApiKey		:= _c_WsPassMagento
	If !oWs:Login()
		Conout(" U_GetPedMkt - Erro ao tentar realizar login na API de Integracao com o Magento. Execucao Abortada. Erro : " + Replace( Replace( GetWSCError(), Chr( 10 ), " " ), Chr( 13 ), " " ))
	EndIf
	oWs:cSessionId := oWs:cloginReturn
	lEncerra	:= .T.
	ConOut( "  U_GetPedMkt - Criou nova Sessao de API com o Magento" )
Return cRet

Static Function PedInfo( cParamIdPedido, oParamWS, lSchedule )
	Local lRetA := .F.
	Local cNumMKT := ""
	oParamWS:cOrderIncrementId 			:= cParamIdPedido
	oParamWS:oWSsalesOrderInfoResult 	:= MagentoService_SALESORDERENTITY():New()
	lRetA := oParamWS:SalesOrderInfo()
	If !lRetA

		Conout(" U_GetPedMkt - n„o conseguiu buscar as informa√ß√µes do pedido")
	Else
		cNumMKT := oParamWS:oWSsalesOrderInfoResult:CSKYHUB_CODE
		If !Empty(AllTrim(cNumMKT))
			Conout(" U_GetPedMkt - Conseguiu buscar o n√∫mero do Marketplace: " + cNumMKT)
		Else
			Conout(" U_GetPedMkt - O pedido n„o È de Marketplace")
		EndIf
	EndIf
Return cNumMKT