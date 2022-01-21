
User Function MTA410T()

   Local aSv_Area := GetArea()
   Local aSv_SC6  := SC6->(GetArea())
   Local cFilSC6  := xFilial("SC6")

   SC6->(DbSetOrder(1))
   SC6->(DbSeek(cFilSC6+SC5->C5_NUM))
   While !SC6->(Eof()) .And.;
         SC6->C6_FILIAL == cFilSC6 .And.;
         SC6->C6_NUM    == SC5->C5_NUM

      SC6->(RecLock("SC6",.f.))
      SC6->C6_PRUNIT  := SC6->C6_PRCVEN
      SC6->C6_DESCONT := 0
      SC6->C6_VALDESC := 0
      SC6->(MsUnLock())
      SC6->(DbSkip())
   EndDo


   RestArea(aSv_SC6)
   RestArea(aSv_Area)
Return
