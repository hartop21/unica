
/*/{Protheus.doc} MA410MNU

@project integração Protheus x Magento
@description Ponto de Entrada para incluir uma nova opção no Menu principal da rotina de Pedido de Vendas MATA410 para permitir alterar a TES / Transportadora dos Pedidos Oriundos do Magento
@author Rafael Rezende
@since 09/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*-----------------------*
User Function MA410MNU()
    *-----------------------*

    aAdd( aRotina , { "Infor. TES/Transp."	, "U_UNIA013", 0, 9 } )
    aAdd( aRotina , { "Imprimir Etiqueta"	, "U_UNIR010", 0, 9 } )

Return