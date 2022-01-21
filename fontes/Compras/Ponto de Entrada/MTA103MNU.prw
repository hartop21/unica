
/*/{Protheus.doc} MTA103MNU

@project Relat�rio Confer�ncia de Entrada
@modulo SIGACOM
@type Relat�rio
@description Ponto de Entrada para permitir a inclus�o de op�oes no Menu aRotina da rotina padrao de documento de entrada MATA103.
@author Rafael Rezende
@since 03/09/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*-----------------------*
User Function MTA103MNU()
    *-----------------------*

    aAdd( aRotina, { "Conferen. Cega", "U_UNIR007", 00, 02, 00, .F. } )

Return