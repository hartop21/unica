/*/{Protheus.doc} M460MARK

@project Ponto de entrada da rotina MATA461
@description Rotina para validar se o usuário marcou TODOS os itens dos pedidos antes de faturar
@author Lucas Miranda
@since 14/10/2020
@version 1.0

/*/

#include 'protheus.ch'
#include 'parmtype.ch'
#Include "TopConn.ch"
#Include "TbiConn.ch"


User Function M460MARK()
    Local cMark := PARAMIXB[1] // MARCA UTILIZADA
    Local lInvert := PARAMIXB[2] // SELECIONOU "MARCA TODOS"
    Local aArea := GetArea("SC9")
    Local aMarcados := {}
    Local nX := 00
    Local cAliasSC9 := GetNextAlias()
    Local cQuery := ""
    Local lExecuta := .T.
    Local lValida := GetNewPar("MV_VALFAT", .T.)
    Local cChave := ""
    Local cQueryC9 := ""
    Local cAliasMark := GetNextAlias()

    If lValida

        cQueryC9 := "SELECT DISTINCT(C9_PEDIDO), C9_FILIAL  FROM " +RetSqlName("SC9")+ " WHERE C9_OK = '"+cMark+"' AND C9_BLCRED <> '10'"

        If Select( cAliasMark ) > 0
            ( cAliasMark )->( DbCloseArea() )
        EndIf
        TcQuery cQueryC9 Alias ( cAliasMark ) New

        While !( cAliasMark )->( Eof() )
            AaDD(aMarcados,{(cAliasMark)->C9_FILIAL,(cAliasMark)->C9_PEDIDO})
            (cAliasMark)->(DbSkip())
        EndDo

        ( cAliasMark )->( DbCloseArea() )

        For nX := 01 To Len(aMarcados)

            cQuery := " SELECT * FROM " + RetSqlName("SC9")
            cQuery += " WHERE D_E_L_E_T_ = ' ' AND "
            cQuery += " C9_FILIAL = '"+aMarcados[nX][01]+"' AND "
            cQuery += " C9_PEDIDO = '"+aMarcados[nX][02]+"'"

            If Select( cAliasSC9 ) > 0
                ( cAliasSC9 )->( DbCloseArea() )
            EndIf
            TcQuery cQuery Alias ( cAliasSC9 ) New

            While !( cAliasSC9 )->( Eof() )

                If AllTrim((cAliasSC9)->C9_OK) != cMark
                    MsgInfo( "O pedido "+(cAliasSC9)->C9_PEDIDO+" n�o está com todos os itens selecionados para faturar", "Faturamento de pedidos de venda." )
                    lExecuta := .F.
                    Return lExecuta
                EndIf
                (cAliasSC9)->(DbSkip())

            EndDo

            ( cAliasSC9 )->( DbCloseArea() )

        Next nX
    EndIf

    RestArea(aArea)

Return lExecuta
