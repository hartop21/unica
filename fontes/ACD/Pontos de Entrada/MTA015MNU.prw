
/*/{Protheus.doc} MTA015MNU

@project Impressão de Etiquetas Térmicas ( Unica )
@description Ponto de Entrada na rotina padrão MATA015 ( Cadastro de Endereços ), com o objetivo de permitir a impressão das Etiquetas Térmicas para Endereços
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