#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"


User Function UNIWSLOG(cFil,cOrigem,cIdMagento,cIdFluig,cNumOrc,cCliente,cStatusMag,cStatusP12,cRet,cRotina,cXID,cWSDL,cXML)

    Local aArea         := GetArea()
    Local lGrava        := .T.

    Default cFil        := ""
    Default cOrigem     := ""
    Default cIdMagento  := ""
    Default cIdFluig    := ""
    Default cNumOrc     := ""
    Default cCliente    := ""
    Default cStatusMag  := ""
    Default cStatusP12  := ""
    Default cRet        := ""
    Default cRotina     := ""
    Default cXID        := ""
    Default cWSDL       := ""
    Default cXML		:= ""

    If AllTrim(cRotina) == "UNIWS001"
        If  DbSeek(PadR(cFil, TamSX3("UNI_FILIAL")[1])+PadR(cXID, TamSX3("UNI_XID")[1]))
            If AllTrim(cStatusP12) != "ERRO" .And. AllTrim(UNI->UNI_XIDMAG) == AllTrim(cIdMagento) .And. AllTrim(UNI->UNI_STATUS) == AllTrim(cStatusMag)
                lGrava := .F.
            EndIf
        EndIf
    EndIf

    If lGrava
        DbSelectArea("ZZA")
        Reclock("ZZA",.T.)
        ZZA->ZZA_FILIAL      := cFil
        ZZA->ZZA_ORIGEM      := cOrigem
        ZZA->ZZA_IDMAG       := cIdMagento
        ZZA->ZZA_IDFLUI      := cIdFluig
        ZZA->ZZA_NUM         := cNumOrc
        ZZA->ZZA_CLI         := cCliente
        ZZA->ZZA_MAGST       := cStatusMag
        ZZA->ZZA_P12ST       := cStatusP12
        ZZA->ZZA_RET         := cRet
        ZZA->ZZA_ROTINA      := cRotina
        ZZA->ZZA_XIDUNI      := cXID
        ZZA->ZZA_WSDL        := cWSDL
        ZZA->ZZA_XML		 := cXML
        ZZA->ZZA_DATA        := DtoS(Date())
        ZZA->ZZA_HR          := Time()
        MsUnlock()
    EndIf
    RestArea(aArea)
Return