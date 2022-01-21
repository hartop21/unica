#INCLUDE 'Protheus.ch'

User Function ACD100FI()
    Local aArea := GetArea()
    Local nOrig := PARAMIXB[1] // 1 = Pedido de Venda / 2 = Nota Fiscal / 3 = Ordem de Produção
    Local cFil  := " "
    Local cTes := ""

    If nOrig == 1 // Pedido de venda
        DbSelectArea("SF4")
        DbGoTop()

        While !SF4->( Eof() )
            If AllTrim(SF4->F4_ESTOQUE) == "S"
                cTes += "|" + PADR(Alltrim(SF4->F4_CODIGO),TAMSX3("C9_XTES")[1])
            EndIf
            SF4->(DbSkip())
        EndDo

        cFil := 'C9_XTES$"'+cTes+'"
    EndIf
    RestArea(aArea)
Return {nOrig,cFil} // {Origem,Filtro ADVPL}
