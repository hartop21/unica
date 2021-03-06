
/*/{Protheus.doc} MTA140MNU

@project Relat�rio Confer�ncia de Entrada
@modulo SIGACOM
@type Relat�rio
@description Ponto de Entrada para permitir a inclus�o de op�oes no Menu aRotina da rotina padrao de Pr� Nota MATA140.
@author Rafael Rezende
@since 25/09/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*-----------------------*
User Function MTA140MNU()
    *-----------------------*
    Local aArea	:= GetArea()

    aAdd( aRotina, { "Imprim. Etiquetas", "U_UNIR005", 00, 06 			} ) // Imprim. Etiquetas
    aAdd( aRotina, { "Conferen. Cega"	, "U_UNIR007", 00, 02, 00, .F.  } )

    RestArea( aArea )

Return