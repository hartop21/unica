
/*/{Protheus.doc} ACD100M

@project Impressão de Etiquetas Térmicas ( Unica )
@description Ponto de Entrada na rotina padrão ACDA100 ( Ordem de Separação ), com o objetivo de permitir a impressão das Etiquetas Térmicas para a Ordem de Separação.
@author Rafael Rezende
@since 24/03/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*---------------------*
User Function ACD100M()
	*---------------------*

	aAdd( aRotina, { "Imprim. Etiquetas"	 , "U_UNIR004", 0, 6 } ) // Imprim. Etiquetas
	aAdd( aRotina, { "Imprim. Mapa Separação", "U_UNIR008", 0, 7 } ) // Imprim. Mapa de Separação
	aAdd( aRotina, { "Config. Mapa Separação", "U_UNIR008C", 0, 8 } ) // Imprim. Mapa de Separação

Return