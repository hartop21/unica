#Include "TOTVS.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  * SF2460I    º Autor ³ Luiz Otavio      º Data ³  11/03/21   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


User Function SF2460I
  Local aArea   := GetArea()
  Local cQuery  := ""
  Local cArqQry := GetNextAlias()

  cQuery :=" SELECT TOP 1 L1_SERPED, L1_DOCPED, L1_NSUTEF, L1_DOCTEF, L1_XIDFLUI FROM "+RetSqlName("SL1")
  cQuery +=" WHERE D_E_L_E_T_ = ' ' "
  cQuery +=" AND L1_FILIAL = '"+xFilial("SL1")+"'"
  cQuery +=" AND L1_NUM IN ( SELECT L1_ORCRES
  cQuery +=" 	FROM "+RetSqlName("SL1")
  cQuery +=" 	WHERE D_E_L_E_T_ = ' '"
  cQuery +=" 	   AND L1_FILIAL = '"+xFilial("SL1")+"'"
  cQuery +=" 	   AND L1_DOC = '"+SF2->F2_DOC+"'"
  cQuery +="     AND L1_SERIE = '"+SF2->F2_SERIE+"' )"

  dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqQry , .F., .T.)

  If !(cArqQry)->(eof())
    DbSelectArea("SE1")
    dbSetOrder(1)
    Dbseek(xFilial("SE1")+(cArqQry)->L1_SERPED+(cArqQry)->L1_DOCPED)

    Conout("SF2460I - GRAVANDO O NUMERO DA NF E O NSU NO TITULO")

    while !SE1->(EOF()) .And. SE1->E1_PREFIXO = (cArqQry)->L1_SERPED .and. SE1->E1_NUM = (cArqQry)->L1_DOCPED

      RecLock("SE1",.F.)
      SE1->E1_XNOTA  := SF2->F2_DOC
      IF !Empty((cArqQry)->L1_XIDFLUI)
        IF !Empty(SE1->E1_NSUTEF)
          SE1->E1_NSUTEF :=  (cArqQry)->L1_NSUTEF //Atualizado por Luiz Otavio em 20/05/2021
          SE1->E1_DOCTEF :=  (cArqQry)->L1_DOCTEF //Atualizado por Luiz Otavio em 20/05/2021
        Endif
      Endif
      MsUnLock()
      SE1->(dbSkip())
    EndDo
  EndIf

  RestArea(aArea)
Return
