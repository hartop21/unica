#include 'protheus.ch'
#include 'parmtype.ch'

user function UNIA032()

Local cPerg := "UNIA032"

Pergunte(cPerg,.T.)

Processa({|| U_UNIA032A()},"Processando Vendas . . .")

return

user function UNIA032A()

Local cAliasSL1 := GetNextAlias()
Local nTotal

BEGINSQL ALIAS cAliasSL1
	SELECT SUM(L1_VLRTOT)
	FROM %table:SL1%
	WHERE L1_FILIAL = %xFilial:SL1%
	AND L1_DOC <> ''
	AND L1_SERIE = '1'
	AND D_E_L_E_T_ = ' '
	GROUP BY L1_XVEND2
ENDSQL

(cAliasSL1)->(dbGoBottom())
nTotal := (cAliasSL1)->(LastRec())
(cAliasSL1)->(dbGoTop())

ProcRegua(nTotal)

While !(cAliasSL1)->(EOF())
	IncProc("Processando Vendas . . .")
end

return
