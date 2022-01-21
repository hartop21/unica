*----------------------------------*
/*/{Protheus.doc} MA410LEG

@project Trava no Faturamento

@description Ponto de entrada pertence à rotina de pedidos de venda, MATA410(). Usado, em conjunto com o ponto MA410COR, para alterar os textos da legenda, que representam o “status” do pedido.
@author Rafael Rezende
@since 08/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"


User Function MA410LEG()

    Local aLeg := ParamIxB

    aAdd( aLeg, { "BR_PRETO", "Pedido Bloqueado por Separação" } )

Return aLeg