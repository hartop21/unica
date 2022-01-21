/*
=============================================================================================================
AUTOR     :  Renato Morcerf
-------------------------------------------------------------------------------------------------------------
DATA      :  01/04/2021
-------------------------------------------------------------------------------------------------------------
Obs.      :  Gravar motivo de devoluÃ§Ã£o na rotina de troca
-------------------------------------------------------------------------------------------------------------
PARTIDA   :  Ponto de entrada do LOJA720
=============================================================================================================
*/

#Include "TOTVS.ch"
#Include "Topconn.ch"
#Include "rwmake.ch"
#Include "TbiConn.ch"
#Include "Totvs.ch"
#Include "Folder.ch"


User Function GERASZG(xF1FILIAL,nOrigx,nSerx,nFornx,nLojx,XdTX)

  Private a_Area	    := GetArea()
  Private a_AreaSF2	  := SF2->(GetArea())
  Private a_AreaSD2	  := SD2->(GetArea())
  Private a_AreaSF1	  := SF1->(GetArea())
  Private a_AreaSD1	  := SD1->(GetArea())
  Private a_AreaSLX	  := SLX->(GetArea())
  Private cCod        := Space(TamSx3("ZF_COD")[1])
  Private oDlg
  Private mObs
  Private cArmax      := ""
  Private CCHVNFE     := ""
  Private cSerie      := ""
  Private cNumDoc     := ""
  Private cFormul     := "S"
  Private lFormul     := .T.
  Private nNFOrig     := 1
  Private nVlrFre     := 0

  @ 000,000 TO 280,430 Dialog oDlg Title "Motivo Devolução"
  @ 005,001 Say "Codigo  :"
  @ 020,001 Get cCod F3 "SZF"  Size 40,20 Valid(Processa({|| Memo2()}))
  @ 005,050 Get mObs Memo Valid Empty(mObs) Size 150,100

  @ 110,001 Say "Valor Frete : "
  @ 110,050 Get  nVlrFre Size 060,009 Picture "@E 999,999.99"
  @ 120,001 SAY "Doc/Serie   : " + ALLTRIM(nOrigx) +" / "+nSerx
  @ 120,150 BmpButton type 1 Action Processa({|| MemoX(xF1FILIAL,nOrigx,nSerx,nFornx,nLojx,XdTX), Close(odlg)})
  @ 120,185 BmpButton type 2 Action Close(odlg)

  Activate Dialog odlg Centered

  RestArea(a_AreaSF2)
  RestArea(a_AreaSD2)
  RestArea(a_AreaSF1)
  RestArea(a_AreaSD2)
  RestArea(a_AreaSLX)
  RestArea(a_Area)

Return

****************************************************************
Static Function MemoX(xF1FILIAL,nOrigx,nSerx,nFornx,nLojx,XdTX)
  ****************************************************************
  cXmemo := mObs

  DbSelectArea("SZG")
  SZG->(DbSetOrder(1))
  IF !Empty(nOrigx)
    SZG->(RecLock("SZG",.T.))
    SZG->ZG_FILIAL  := xF1FILIAL
    SZG->ZG_NOTA    := nOrigx
    SZG->ZG_SERIE   := nSerx
    SZG->ZG_DTDEV   := dDataBase
    SZG->ZG_DTE     := XdTX
    SZG->ZG_CLIFOR  := nFornx
    SZG->ZG_LOJA    := nLojx
    IF !Empty(cArmax)
      SZG->ZG_LOCAL := cArmax
    Endif
    IF !Empty(cCod)
      SZG->ZG_CODM  := cCod
    Endif
    SZG->ZG_VLRFRT  := nVlrFre
    SZG->(MsUnlock())
  Endif

  RestArea(a_AreaSF2)
  RestArea(a_AreaSD2)
  RestArea(a_AreaSF1)
  RestArea(a_AreaSD2)
  RestArea(a_AreaSLX)
  RestArea(a_Area)
Return

**************************
Static Function Memo2
  **************************
  DbSelectArea("SZF")
  SZF->(DbSetOrder(1))

  If(DbSeek(xFilial("SZF")+cCod))
    mObs   := SZF->ZF_DESC
    cArmax := SZF->ZF_LOCAL
  Endif

  RestArea(a_AreaSF2)
  RestArea(a_AreaSD2)
  RestArea(a_AreaSF1)
  RestArea(a_AreaSD2)
  RestArea(a_AreaSLX)
  RestArea(a_Area)
Return
