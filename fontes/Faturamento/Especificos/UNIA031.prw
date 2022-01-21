#Include "TOTVS.ch"
#INCLUDE "TBICONN.CH"

user function UNIA031(_cEmpArr)

	Local _cEmpresa := _cEmpArr[1] // Usar o paramixb
	Local _cFilial  := _cEmpArr[2]
	Local cCliCartao
	Local aCliCartao
	Local nCont

	PREPARE ENVIRONMENT EMPRESA _cEmpresa FILIAL _cFilial

	cCliCartao := GetMv("MV_XCLICAR")

	aCliCartao := StrTokArr(cCliCartao,";")

	dbSelectArea("SA1")
	SA1->(dbSetOrder(1))

	conout("INICIO UNIA031 Data: "+dtoc(Date())+" Hora: "+Time())

	For nCont := 1 to Len(aCliCartao)
		if SA1->(dbSeek(xFilial("SA1")+Padr(aCliCartao[nCont],TamSX3("A1_COD")[1])))
			conout("Cliente: "+SA1->A1_COD+" A1_NROCOM: "+cvaltochar(SA1->A1_NROCOM))
			RecLock("SA1",.F.)
			SA1->A1_NROCOM := 0
			SA1->(MsUnlock())
		endif
	Next

	conout("FIM UNIA031 Data: "+dtoc(Date())+" Hora: "+Time())

return
