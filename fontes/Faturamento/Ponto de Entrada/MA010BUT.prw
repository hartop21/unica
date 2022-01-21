
/*/{Protheus.doc} MA010BUT

@project Atualização da tabela de Preços
@description Ponto de Entrada para incluir uma nova opção no Ações Relacionadas da rotina de Cadastro de Produtos MATA010
@author Rafael Rezende
@since 09/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"



User Function MA010BUT()

    Local aRetBotoes := {}

    aAdd( aRetBotoes, { "ANALITICO", { || U_UNIA012() }, "Atualização Tab. Preços" } )

Return aRetBotoes