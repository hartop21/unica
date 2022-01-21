
/*/{Protheus.doc} UNIA025

@project Integração Protheus x Magento
@modulo SIGACFG
@type Atualização
@description Rotina para permitir a manuteção das Multilojas do Magento.
@author Rafael Rezende
@since 14/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA025()
    *---------------------*
    Local aAreaAntes    := GetArea()
    Local cAuxFiltro	:= ""
    Private cCadastro 	:= "Manutenção MultiLojas Magento"
    Private aRotina     := {}

    aAdd( aRotina, { "Pesquisar" 	 , "AxPesqui"	, 00, 01 } )
    aAdd( aRotina, { "Visualizar"	 , "AxVisual"	, 00, 02 } )
    aAdd( aRotina, { "Incluir"		 , "AxInclui"	, 00, 03 } )
    aAdd( aRotina, { "Alterar"		 , "AxAltera"	, 00, 04 } )
    aAdd( aRotina, { "Excluir"		 , "AxDeleta" 	, 00, 05 } )

    DbSelectArea( "SZD" )
    DbSetOrder( 01 )
    mBrowse( 06, 01, 22, 75, "SZD" )

    RestArea( aAreaAntes )

Return