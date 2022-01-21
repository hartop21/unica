
/*/{Protheus.doc} A410CONS

@project Integra��o Protheus x Magento
@description Ponto de Entrada para incluir uma nova op��o nas A��es Relacionadas da rotina de Pedido de Vendas MATA040
@author Rafael Rezende
@since 09/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"


User Function A410CONS()

    Local aRetBotoes := {}

    aAdd( aRetBotoes, { "ANALITICO", { || U_UNIA013() }, "Infor. TES/Transp." } )

Return aRetBotoes