*----------------------------------*
/*/{Protheus.doc} MA410COR

@project Trava no Faturamento

@description Ponto de entrada pertence à rotina de pedidos de venda, MATA410(). Usado, em conjunto com o ponto MA410LEG, para permitir alterar a legenda no mBrowser da rotina padrão
@author Rafael Rezende
@since 08/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"


User Function MA410COR()

	Local aCores 		:= ParamIxB
	Local cAuxCDs 		:= AllTrim( GetNewPar( "MV_XFILTRV", "0101, 0201" ) )
	Local cAux1Filtro 	:= "AllTrim( C5_XIDFLUI + C5_XIDMAGE ) != ''
	Local cAux2Filtro 	:= "( AllTrim( C5_XCONF ) != 'S' .And. AllTrim( C5_FILIAL ) $ '" + cAuxCDs + "' )"
	Local cAuxFiltro  	:= "( " + cAux1Filtro + " .Or. " + cAux2Filtro + " ) "

	//aAdd(aCores,{"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ) .And. C5_X_CONF = 'S'",'ENABLE','Pedido em Aberto' })		//Pedido em Aberto
	//aAdd(aCores,{"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)" ,'DISABLE','Pedido Encerrado'})		   	//Pedido Encerrado
	//aAdd(aCores,{"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)",'BR_AMARELO','TESTE'})
	//aAdd(aCores,{"C5_BLQ == '1'",'BR_AZUL','Pedido Bloquedo por regra'}) //Pedido Bloquedo por regra
	//aAdd(aCores,{"C5_BLQ == '2'",'BR_LARANJA','Pedido Bloquedo por verba'})	//Pedido Bloquedo por verba
	For nL := 01 To Len( aCores )

		Do Case
			Case AllTrim( aCores[nL][02] ) == "ENABLE"
				aCores[nL][01] += " .And. !" + cAuxFiltro
			Case AllTrim( aCores[nL][02] ) == "BR_AMARELO"
				aCores[nL][01] += " .And. !" + cAuxFiltro
			Case AllTrim( aCores[nL][02] ) == "BR_AZUL"
				aCores[nL][01] += " .And. !" + cAuxFiltro
			Case AllTrim( aCores[nL][02] ) == "BR_LARANJA"
				aCores[nL][01] += " .And. !" + cAuxFiltro
		EndCase

	Next nL

	aAdd( aCores, { cAuxFiltro, "BR_PRETO", "Pedido Bloqueado por Separação" } ) // Pedido "Novo STATUS"

Return aCores