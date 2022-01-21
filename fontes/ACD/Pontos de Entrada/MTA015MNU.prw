
/*/{Protheus.doc} MTA015MNU

@project Impress�o de Etiquetas T�rmicas ( Unica )
@description Ponto de Entrada na rotina padr�o MATA015 ( Cadastro de Endere�os ), com o objetivo de permitir a impress�o das Etiquetas T�rmicas para Endere�os
@author Rafael Rezende
@since 03/06/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*-----------------------*
User Function MTA015MNU()
	*-----------------------*

	aAdd( aRotina, { "Imprim. Etiquetas", "U_UNIR006", 0, 6 } ) // Imprim. Etiquetas

Return