#Include "TOTVS.ch"

USER FUNCTION PE01NFESEFAZ()

	Local aProd     := PARAMIXB[1]
	Local cMensCli  := PARAMIXB[2]
	Local cMensFis  := PARAMIXB[3]
	Local aDest     := PARAMIXB[4]
	Local aNota     := PARAMIXB[5]
	Local aInfoItem := PARAMIXB[6]
	Local aDupl     := PARAMIXB[7]
	Local aTransp   := PARAMIXB[8]
	Local aEntrega  := PARAMIXB[9]
	Local aRetirada := PARAMIXB[10]
	Local aVeiculo  := PARAMIXB[11]
	Local aReboque  := PARAMIXB[12]
	Local aNfVincRur:= PARAMIXB[13]
	Local aEspVol   := PARAMIXB[14]
	Local aNfVinc   := PARAMIXB[15]
	Local AdetPag   := PARAMIXB[16]
	Local aRetorno  := {}

	conout("PE01NFESEFAZ")

	conout("Nota na SF2: "+SF2->F2_DOC)

	conout("Nota na SD2: "+SD2->D2_DOC)

	conout("Pedido na SD2: "+SD2->D2_PEDIDO)

	DbSelectArea("SC5")
	SC5->(DbSetOrder(1))
	If SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
		conout("Achou o Pedido "+SD2->D2_PEDIDO)
		If !Empty(SC5->C5_XOBS)
			conout("SC5->C5_XOBS "+Alltrim(SC5->C5_XOBS))
			if !empty(cMensCli)
				cMensCli += Chr(13) + Chr(10)
			endif
			cMensCli += "Observação: " + Alltrim(SC5->C5_XOBS) + CRLF
		else
			conout("SC5->C5_XOBS VAZIO")
		endif
	else
		conout("Não achou o Pedido "+SD2->D2_PEDIDO)
	endif

	aadd(aRetorno,aProd)
	aadd(aRetorno,cMensCli)
	aadd(aRetorno,cMensFis)
	aadd(aRetorno,aDest)
	aadd(aRetorno,aNota)
	aadd(aRetorno,aInfoItem)
	aadd(aRetorno,aDupl)
	aadd(aRetorno,aTransp)
	aadd(aRetorno,aEntrega)
	aadd(aRetorno,aRetirada)
	aadd(aRetorno,aVeiculo)
	aadd(aRetorno,aReboque)
	aadd(aRetorno,aNfVincRur)
	aadd(aRetorno,aEspVol)
	aadd(aRetorno,aNfVinc)
	aadd(aRetorno,AdetPag)

RETURN aRetorno
