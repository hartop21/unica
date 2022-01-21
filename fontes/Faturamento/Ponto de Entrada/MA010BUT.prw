
/*/{Protheus.doc} MA010BUT

@project Atualiza��o da tabela de Pre�os
@description Ponto de Entrada para incluir uma nova op��o no A��es Relacionadas da rotina de Cadastro de Produtos MATA010
@author Rafael Rezende
@since 09/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"



User Function MA010BUT()

    Local aRetBotoes := {}

    aAdd( aRetBotoes, { "ANALITICO", { || U_UNIA012() }, "Atualiza��o Tab. Pre�os" } )

Return aRetBotoes