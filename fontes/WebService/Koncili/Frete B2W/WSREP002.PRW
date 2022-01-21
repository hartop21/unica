#include 'protheus.ch'
#Include "RESTFUL.CH"
#Include "Topconn.ch"
#Include "Totvs.ch"
#Include "RwMake.ch"
#Include "ApWizard.ch"

/*
|-----------------------------------------------|
| Empresa  | Unica Ar Condicionado				|
|----------|------------------------------------|
| Autor    | Victor Cardoso                     |
|----------|------------------------------------|
| Objetivo | Integração com a Koncili (Frete)	|
|-----------------------------------------------|
*/

User Function WSREP002(lSched)

	Private cCombo1 := ""
	Private cGet1   := Space(20)
	Private dGet1   := "9999-99-99"
	Private dGet2   := "9999-99-99"
	Private oCombo1, oGet1, oGet2, oPanel, oNewPag, oStepWiz, oDlg, oPanelBkg, oSay1, oSay2, oSay3

	FWMsgRun( , { |oSay| WSREP_A( lSched ) }, "Processando", "Por favor aguarde." )

Return

//###################################

Static Function WSREP_A(lSched)

	Local cIniDate   := ""
	Local cEndDate   := ""
	Local aHeader    := {}
	Local cApiKey    := ""
	Local cEndPnt 	 := ""
	Local cJson 	 := ""
	Local cJson1     := ""
	Local oJson      := JsonObject():New()
	Local oJson1     := JsonObject():New()
	Local aParSchd   := {}
	Local AB         := 0

	Private AVAR      := {}
	Private oRest     := Nil
	Private cURL      := ""
	Private aRetParA  := {}
	Private aRetParB  := {}

	aParSchd := lSched
	lSched := (  ValType( lSched ) == "A" )

	If lSched
		RpcSetType( 3 )
		RpcClearEnv()

		If ValType( aParSchd ) == "A"
			RpcSetEnv( "01", aParSchd[3],,,,, )
		Else
			RpcSetEnv( "01", "0101",,,,, )
		Endif

		cIniDate := GetMv("UN_INIDATE")
		cEndDate := GetMv("UN_ENDDATE")
		cEndPnt  := "/externalapi/orderextract/unresolveds?initDate=" + cIniDate + "&endDate="+ cEndDate
	Else
		IF Wizard_A()
			If cCombo1 == "PERÍODO"
				cIniDate := dGet1
				cEndDate := dGet2
				cEndPnt  := "/externalapi/orderextract/unresolveds?initDate=" + cIniDate+ "&endDate="+ cEndDate
			Else
				cEndPnt  := "/externalapi/orderextract/unresolveds?initDate=" + GetMv("UN_INIDATE")+ "&endDate="+ GetMv("UN_ENDDATE") + "&conciliationId=" + AllTrim(cGet1)
			Endif
		Else
			Return(.F.)
		Endif
	Endif

	cApiKey  := GetMV("UN_KEYKONC")
	cUrl     := GetMv("UN_URLKONC")

	aAdd(aHeader,"Accept: application/json")
	aAdd(aHeader,"Content-Type: application/json")
	aAdd(aHeader,"gumgaToken: " + cApiKey)

	oRest := FWRest():New(cURL+cEndPnt)
	oRest:SetPath("")
	oRest:SetPostParams("Body")


	IF oRest:GET(aHeader)
		cJson := oRest:GetResult()
		oJson:FromJson(cJson)
		oRest := Nil

		For AB := 1 To oJson[oJson:GetNames()[2]][oJson[oJson:GetNames()[2]]:GetNames()[3]] STEP 100
			//cUrl := "https://api.koncili.com/externalapi/orderextract/unresolveds?offset=" + AllTrim(Str(AB)) + "&endDate=" + endDate + "&initDate="+ initDate
			cUrl := AllTrim(GetMv("UN_URLKONC")) + cEndPnt + "&offset=" + AllTrim(Str(AB))
			oRest := FWRest():New(cURL)
			oRest:SetPath("")
			oRest:SetPostParams("Body")
			IF oRest:GET(aHeader)
				cJson1 := oRest:GetResult()
				oJson1:FromJson(cJson1)
				WSREP_B(cJson1)
			else
				conout("Não conectou na API" +  cUrl)
			Endif
			oRest := Nil
		Next
	else
		conout("Não conectou na API" + cUrl + cEndPnt)
	Endif

Return


Static Function WSREP_B(cJsonCon)

	Local oJSCon  := JsonObject():New() //Json Geral
	Local aFields := ""
	Local A, B

	oJScon:FromJson(cJsonCon)
	aFields := oJSCon:GetNames()

	For A := 1 To Len(aFields)
		IF UPPER(aFields[A]) == "CONTENT"
			For B := 1 To Len(oJSCon[aFields[A]])
				WSREP_C(oJSCon[aFields[A]][B]:ToJson())
			Next B
		Endif
	Next A
Return


Static Function WSREP_C(cJsIdCon)

	Local oJsIdCon := JsonObject():New() // ID
	Local aFields  := {}
	Local cOrder   := ""
	Local aBaixa   := {}
	Local cHistBx  := GetMv("UN_DESCBX")
	Local cIdKon   := ""
	Local cCGC     := ""
	Local cNFiscal := ""
	Local cAnoNF   := ""
	Local cDiaNF   := ""
	Local cMesNF   := ""
	Local cEmissao := ""

	Private lMsErroAuto := .F.

	oJsIdCon:FromJson(cJsIdCon)
	aFields := oJsIdCon:GetNames()

	If UPPER(oJsIdCon["extractType"]) == "SHIP" .AND. ValType(oJsIdCon["invoiceNumber"]) <> "U"
		cOrder := oJsIdCon["orderCode"]
		cIdKon := oJsIdCon["id"]
		cNFiscal := oJsIdCon["invoiceNumber"]
		cAnoNF := SubStr(oJsIdCon["invoiceDate"],1,4)
		cMesNF := SubStr(oJsIdCon["invoiceDate"],6,2)
		cDiaNF := SubStr(oJsIdCon["invoiceDate"],9,2)
		cEmissao := cAnoNF + cMesNF + cDiaNF
		cCGC     := oJsIdCon["customerDocumentNumber"]

/*
		cQuery := "SELECT L1_DOCPED,E1_NUM,SE1010.R_E_C_N_O_ AS E1RECNO,* FROM " + RetSqlName("SL1") + " L1"
		cQuery += " INNER JOIN " + RETSQLNAME("SE1") + " E1 ON E1_NUM = L1_DOCPED AND E1_PREFIXO = L1_SERPED AND E1_CLIENTE = L1_CLIENTE AND E1_LOJA = L1_LOJA"
		cQuery += " WHERE E1.D_E_L_E_T_ = '' AND L1.D_E_L_E_T_ = '' AND L1_XPEDMKT LIKE '%" + cOrder + "%' "

		cQuery := "SELECT * FROM SE1010 WHERE E1_NUM IN( "
		cQuery += "SELECT L1_DOCPED "
		cQuery += "FROM SL1010 WHERE  D_E_L_E_T_ = '' AND "
		cQuery += "L1_XPEDMKT LIKE '%" + cOrder + "%' ) "
*/

		cQuery := "SELECT R_E_C_N_O_ AS REC FROM " + RETSQLNAME("SE2") + " WHERE D_E_L_E_T_ = ' ' AND E2_NUM + E2_PREFIXO = " + CHR(10) + CHR(13)
		cQuery += "(SELECT F1_DUPL + F1_SERIE FROM " + RETSQLNAME("SF1") + " WHERE D_E_L_E_T_ = ' ' AND F1_CHVNFE = " + CHR(10) + CHR(13)
		cQuery += "(SELECT DS_CHAVENF FROM " + RETSQLNAME("SDS") + " WHERE D_E_L_E_T_ = ' ' AND DS_XCHAVE = " + CHR(10) + CHR(13)
		cQuery += "(SELECT F2_CHVNFE FROM " + RETSQLNAME("SF2") + " WHERE D_E_L_E_T_ = ' 'AND F2_EMISSAO = '" + cEmissao + "' AND F2_DOC = '" + cNFiscal + "' AND F2_CLIENTE+F2_LOJA = " + CHR(10) + CHR(13)
		cQuery += "(SELECT A1_COD+A1_LOJA FROM " + RETSQLNAME("SA1") + " WHERE D_E_L_E_T_ = ' ' AND A1_CGC = '" + cCGC + "'" + CHR(10) + CHR(13)
		cQuery += "))))"

		IF Select("TMP1") > 0
			TMP1->(DbCloseArea())
		Endif

		TcQuery cQuery New Alias "TMP1"

		IF !TMP1->(EOF())

			DbSelectArea("SE2")
			DbSetOrder(1)
			DbGoTo(TMP1->REC)
			AADD(aBaixa, {"E2_FILIAL" , SE2->E2_FILIAL , Nil})
			AADD(aBaixa, {"E2_PREFIXO" , SE2->E2_PREFIXO , Nil})
			AADD(aBaixa, {"E2_NUM" , SE2->E2_NUM , Nil})
			AADD(aBaixa, {"E2_PARCELA" , SE2->E2_PARCELA , Nil})
			AADD(aBaixa, {"E2_TIPO" , SE2->E2_TIPO , Nil})
			AADD(aBaixa, {"E2_FORNECE" , SE2->E2_FORNECE , Nil})
			AADD(aBaixa, {"E2_LOJA" , SE2->E2_LOJA , Nil})
			AADD(aBaixa, {"AUTMOTBX" , "B2F" , Nil})
			AADD(aBaixa, {"AUTBANCO" , "B2F" , Nil})
			AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
			AADD(aBaixa, {"AUTCONTA" , "0000000002" , Nil})
			AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil})
			AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
			AADD(aBaixa, {"AUTHIST" , cHistBx , Nil})
			AADD(aBaixa, {"AUTVLRPG" , SE2->E2_SALDO , Nil})

			DbSelectArea("SX1")
			SX1->(DbSetOrder(1)) // X1_GRUPO + X1_ORDEM
			If SX1->(MsSeek(PadR("FIN080",10) + "01"))
				RecLock("SX1",.F.)
				SX1->X1_PRESEL := 2 // Mostra Lancamento Contabil? 2=Nao
				SX1->(MsUnlock())
			EndIf
			If SX1->(MsSeek(PadR("FIN080",10) + "04"))
				RecLock("SX1",.F.)
				SX1->X1_PRESEL := 2 // Contabiliza On Line? 2=Nao
				SX1->(MsUnlock())
			EndIf
			Pergunte("FIN080",.F.) // Contabilizacao deve ser pelo LP 520 Sequenciais 061/062/063
			Mv_Par01 := 2				// Mostra Lanc Contab ?		1=Sim 2=Nao
			Mv_Par02 := 2				// Aglut Lancamentos ?	1=Sim 2=Nao
			Mv_Par03 := 2 // 1			// Contabiliza On Line ?				1=Sim 2=Nao
			Mv_Par04 := 2				// Permite Baixa Bord ?		1=Sim 2=Nao
			Mv_Par05 := 2				// Replica Rateio ?			1=Sim 2=Nao
			Mv_Par06 := 2				// Utiliza Banco Anterior ?					1=Inclusao 2=Baixa 3=Nao Replicar
			lMsErroAuto := .F.

			MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)

			If lMsErroAuto
				Conout("Erro na baixa")
				mostraerro()
				WSREP_D(cIdKon)
			Else
				Conout("Baixa realizada, verifique a SE5")
				WSREP_D(cIdKon)
			EndIf

		Endif

	Endif

Return(.T.)

Static Function WSREP_D(cId)

	Local cUrl := GetMv("UN_URLKONC")
	Local oRestA := FWRest():New(cUrl + "/externalapi/orderextract/resolve/"+ AllTrim(Str(cId)))
	Local aHeadStr := {}
	
	AAdd(aHeadStr,"Accept: application/json")
	aAdd(aHeadStr,"Content-Type: application/json")
	aAdd(aHeadStr,"gumgaToken: " + GetMV("UN_KEYKONC"))

	oRestA:setPath("")

	If oRestA:Put(aHeadStr)
		Conout(oRestA:GetResult())
	Else
		conout(oRestA:GetLastError())
	Endif

Return

Static Function Wizard_A()

	Local lRet := .T.

	DEFINE DIALOG oDlg TITLE '' PIXEL STYLE nOR(  WS_VISIBLE ,  WS_POPUP )

	oDlg:nWidth := 600
	oDlg:nHeight := 520
	oPanelBkg:= tPanel():New(000,000,"",oDlg,,,,,,300,300)
	oPanelBkg:Align := CONTROL_ALIGN_ALLCLIENT
	oStepWiz:= FWWizardControl():New(oPanelBkg)//Instancia a classe FWWizard
	oStepWiz:ActiveUISteps()

	oNewPag := oStepWiz:AddStep("1")
	oNewPag:SetStepDescription("Sobre a rotina")
	oNewPag:SetConstruction({|Panel|CriaPag(Panel,1)})
	oNewPag:SetCancelAction({||lRet := .F. ,oDlg:End()})
	oNewPag:BPREVACTION := {||.F.}
	oNewPag:BUSERPREVACTION := {||.F.}

	oNewPag := oStepWiz:AddStep("2", {|Panel|CriaPag(Panel,2)})
	oNewPag:SetStepDescription("Tipo de Integração")
	oNewPag:SetCancelAction({||lRet := .F. ,oDlg:End()})
	oNewPag:BPREVACTION := {||.F.}
	oNewPag:BUSERPREVACTION := {||.F.}

	oNewPag := oStepWiz:AddStep("3", {|Panel|CriaPag(Panel,3)})
	oNewPag:SetStepDescription("Tipo de Integração")
	oNewPag:SetCancelAction({||lRet := .F. ,oDlg:End()})
	oNewPag:BPREVACTION := {||.F.}
	oNewPag:BUSERPREVACTION := {||.F.}

	oNewPag := oStepWiz:AddStep("4", {|Panel|CriaPag(Panel,4)})
	oNewPag:SetStepDescription("Tipo de Integração")
	oNewPag:SetCancelAction({||lRet := .F. ,oDlg:End()})
	oNewPag:BPREVACTION := {||.F.}
	oNewPag:BUSERPREVACTION := {||.F.}
	oNewPag:SetNextAction({||oDlg:End(),.T.})


	oStepWiz:Activate()
	ACTIVATE DIALOG oDlg CENTER
	oStepWiz:Destroy()

Return(lRet)

//--------------------------
// Construção da página 1
//--------------------------
Static Function CriaPag(oPanel, nPag)

	Local cText := ""
	Local oFont := TFont():New('verdana',,14,.T.)
	Local aItems1 := {'Nº Conciliação','Período'}
	Local lHasButton := .T.

	If nPag == 1
		cText := "Esta rotina tem como objetivo realizar a baixa automática dos títulos de frete referente aos pedidos da Koncili." + CHR(10) + CHR(10) + CHR(10)
		cText += "Clique em 'Avançar' para definição dos parâmetros da integração."
		oSay1 := TSay():New(10,10,{||cText},oPanel,,oFont,,,,.T.,,,200,100)
	Elseif nPag == 2
		cText := "Para a opção 'Nº Conciliação': A rotina será integrada para uma conciliação específica. " + CHR(10)
		cText += "Para a opção 'Período': A rotina será integrada para uma data de início e fim específica. " + CHR(10)  + CHR(10)
		cText += "Informe o tipo de integração e em seguida clique em 'Avançar' para a tela de filtros."
		oSay1 := TSay():New(10,10,{||cText},oPanel,,oFont,,,,.T.,,,200,100)
		oCombo1 := TComboBox():New(70,15,{|u|if(PCount()>0,cCombo1:=u,cCombo1)},aItems1,100,20,oPanel,,{|| },,,,.T.,,,,,,,,,'cCombo1')
	Elseif nPag == 3

		If UPPER(cCombo1) == 'PERÍODO'
			cText := "Informe a data em que a conciliação foi finalizada. Essa informação só pode ser vista no site da Koncili." + CHR(10) + CHR(10)
			cText += "A data deve ser informada no formato AAAA-MM-DD." + CHR(10) + CHR(10) + CHR(10) + CHR(10) + CHR(10) + CHR(10) + CHR(10) + CHR(10)
			cText += "Clique em 'Avançar' para revisão dos parâmetros de integração."
			oSay2 := TSay():New(052,010,{||"De"},oPanel,,oFont,,,,.T.,,,200,100)
			oSay3 := TSay():New(052,090,{||"Até"},oPanel,,oFont,,,,.T.,,,200,100)

			oGet1 := TGet():New( 050, 025, { | u | If( PCount() == 0, dGet1, dGet1 := u ) },oPanel, ;
				060, 010, "@9 9999-99-99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"dGet1",,,,lHasButton  )
			oGet2 := TGet():New( 050, 110, { | u | If( PCount() == 0, dGet2, dGet2 := u ) },oPanel, ;
				060, 010, "@9 9999-99-99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"dGet2",,,,lHasButton  )
		Else
			cText := "Informe o número da conciliação a ser integrada." + CHR(10) + CHR(10)
			cText += "Clique em 'Avançar' para revisão dos parâmetros de integração."

			oGet1 := TGet():New( 060, 010, { | u | If( PCount() == 0, cGet1, cGet1 := u ) },oPanel, ;
				060, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet1",,,,lHasButton  )
		Endif

		oSay1:= TSay():New(10,10,{||cText},oPanel,,oFont,,,,.T.,,,200,100)
	Else
		cText := "Verifique se os parâmetros estão corretos antes de iniciar a integração" + CHR(10) + CHR(10)
		cText += "Tipo de integração: " + cCombo1 + CHR(10) + CHR(10)
		If UPPER(cCombo1) == 'PERÍODO'
			cText += "Data Início (AAAAMMDD): " + dGet1 + CHR(10) + CHR(10)
			cText += "Data Fim (AAAAMMDD): "    + dGet2 + CHR(10) + CHR(10)
		Else
			cText += "Conciliação: " + cGet1 + CHR(10) + CHR(10)
		Endif
		cText += "Clique em 'Concluir' para iniciar a integração."

		oSay1:= TSay():New(10,10,{||cText},oPanel,,oFont,,,,.T.,,,200,100)
	Endif

Return
