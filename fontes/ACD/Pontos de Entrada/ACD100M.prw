
/*/{Protheus.doc} ACD100M

@project Impress�o de Etiquetas T�rmicas ( Unica )
@description Ponto de Entrada na rotina padr�o ACDA100 ( Ordem de Separa��o ), com o objetivo de permitir a impress�o das Etiquetas T�rmicas para a Ordem de Separa��o.
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
	aAdd( aRotina, { "Imprim. Mapa Separa��o", "U_UNIR008", 0, 7 } ) // Imprim. Mapa de Separa��o
	aAdd( aRotina, { "Config. Mapa Separa��o", "U_UNIR008C", 0, 8 } ) // Imprim. Mapa de Separa��o

Return