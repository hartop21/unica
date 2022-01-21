
/*/{Protheus.doc} UNIA023

@project Integração Protheus x Fluig
@modulo SIGAFAT
@type Atualização
@description Descrição de Empresas para Fluig
@author Rafael Rezende
@since 13/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA023()
    *---------------------*
    Local aAreaAntes    := GetArea()
    Local cAuxFiltro	:= ""
    Private cCadastro 	:= "Descrição de Empresas para Fluig"
    Private aRotina     := {}

    aAdd( aRotina, { "Pesquisar" 	 , "AxPesqui"	, 00, 01 } )
    aAdd( aRotina, { "Visualizar"	 , "AxVisual"	, 00, 02 } )
    aAdd( aRotina, { "Incluir"		 , "AxInclui"	, 00, 03 } )
    aAdd( aRotina, { "Alterar"		 , "AxAltera"	, 00, 04 } )
    aAdd( aRotina, { "Excluir"		 , "AxDeleta"	, 00, 05 } )

    DbSelectArea( "SZC" )
    DbSetOrder( 01 )
    mBrowse( 06, 01, 22, 75, "SZC" )

    RestArea( aAreaAntes )

Return