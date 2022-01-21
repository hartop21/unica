#INCLUDE 'Protheus.ch'
#Include "TopConn.ch"
#Include "TbiConn.ch"


USER FUNCTION F040FCR()

	Local aArea := GetArea()
	Local nTaxa := 0
	Local nPercTx := 0
	Local cAdm := ""
	Local nPerc := 0
	Local cPed := SE1->E1_PEDIDO
	Local cFili := SE1->E1_FILIAL
	Local nVal := SE1->E1_VLRREAL
	Local cParcela := 0
	Local cAliasMEN := GetNextAlias()
	Local cQuery := ""
	Local nX := 0

	nTaxa := nVal
	cAdm :=  LEFT(Posicione("SL4",1,xFilial("SL4")+cPed+"        ","L4_ADMINIS"), 3)

	If AllTrim(cAdm) == ""
		cAdm := "Vazio"
	Else
		cQuery := "SELECT * FROM " + RetSqlName("MEN")
		cQuery += " WHERE D_E_L_E_T_ = ' ' "
		cQuery += " AND MEN_CODADM = '"+cAdm+"'"
		cQuery += " AND '"+cValToChar(cParcela)+"' BETWEEN MEN_PARINI AND MEN_PARFIN"
		cQuery += " AND MEN_FILIAL = '' "

		If Select( cAliasMEN ) > 0
			( cAliasMEN )->( DbCloseArea() )
		EndIf

		TcQuery cQuery Alias  ( cAliasMEN )  New

		If !( cAliasMEN )->( Eof() )
			nPercTx := (cAliasMEN)->MEN_TAXADM
		Else
			nPercTx := 0
			Conout("Não encontrou taxa adm com as infos: COD ADM " + cAdm + " Parcela " + cValToChar(cParcela))
		EndIf
	EndIf

	Conout("cPed = " + cPed)
	Conout("nTaxa = " + cValToChar(nTaxa))
	Conout("cAdm = " + cAdm)
	Conout("nPercTx = " + cValToChar(nPercTx))
	Conout("cFilial = " + cFili)

	nPerc := nPercTx/100
	nTaxa := nPerc * nTaxa
	nTaxa := nTaxa/cParcela


	Reclock("SE1",.F.)
	Conout("SE1->E1_XTXCARD = " + cValToChar(nTaxa))
	SE1->E1_XTXCARD := nTaxa
	MsUnlock()

	RestArea(aArea)
Return
