#Include "TOTVS.ch"


User Function fCBarra()

	Local lRet := .T.
	Local oModel    := FWModelActive()
	Local cDesc     := ""
	Local lCodBar	:= .F.

	DbSelectArea("SZ1")
	If DbSeek(xFilial("SB1")+M->B1_CATEGOR)
		If SZ1->Z1_XCODBAR == "S"
			lCodBar := .T.
		EndIf
	EndIf

	If ALTERA
		If AllTrim(SB5->B5_2CODBAR) == ""
			If lCodBar
				cDesc := cValToChar(Randomize(1,999999999))
				If Len(AllTrim(cDesc)) < 14
					While Len(AllTrim(cDesc)) < 14
						cDesc := cDesc + cValToChar(Randomize(1,10))
					End
				EndIf
				oModel:SetValue('SB5DETAIL','B5_2CODBAR',cDesc)
			EndIf
		EndIf
	ElseIf INCLUI
		If lCodBar
			cDesc := cValToChar(Randomize(1,999999999))
			If Len(AllTrim(cDesc)) < 14
				While Len(AllTrim(cDesc)) < 14
					cDesc := cDesc + cValToChar(Randomize(1,10))
				End
				oModel:SetValue('SB5DETAIL','B5_2CODBAR',cDesc)
			EndIf
		EndIf
	EndIf


Return lRet
