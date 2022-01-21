#Include 'Protheus.ch'

User Function AtuC9()

Local aArea := GetArea()

RPCSetType( 03 )
RPCSetEnv( "01", "0101")

DbSelectArea("SC6")
DbGoTop()

   While !SC6->( Eof() )
    DbSelectArea("SC9")
    DbSetOrder(2)
    If SC9->(DbSeek(SC6->C6_FILIAL + SC6->C6_CLI + SC6->C6_LOJA + SC6->C6_NUM + SC6->C6_ITEM))
        RecLock("SC9",.F.)
        SC9->C9_XTES := SC6->C6_TES
        MsUnLock()
    EndIf
   SC6->(DbSkip()) 
   EndDo

RestArea(aArea)
RPCClearEnv()
Return
