
/*/{Protheus.doc} MTA010MNU

@project Atualiza��o da tabela de Pre�os
@description Ponto de Entrada para incluir uma nova op��o no Menu principal da rotina de Cadastro de Produtos MATA010
@author Rafael Rezende
@since 09/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*-----------------------*
User Function MTA010MNU()
    *-----------------------*

    aAdd( aRotina , { "Atualiza��o Tab. Pre�os"	, "U_UNIA012", 0, 09 } )
    aAdd( aRotina , { "Imprimir Etiqueta"		, "U_UNIR009", 0, 10 } )
    aAdd( aRotina , { "Imprimir Etiqueta por lote", "U_UNIR091",  0, 11 } )

Return
