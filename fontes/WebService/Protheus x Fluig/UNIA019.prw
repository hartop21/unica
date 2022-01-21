
/*/{Protheus.doc} UNIA019

@project Integra��o Protheus x Fluig
@modulo SIGACFG
@type Atualiza��o
@description Rotina para permitir a manute��o das configura��es do fluig por Filial
@author Rafael Rezende
@since 07/09/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA019()
    *---------------------*
    Local aAreaAntes    := GetArea()
    Local cAuxFiltro	:= ""
    Private cCadastro 	:= "Configura��es Fluig por Filial"
    Private aRotina     := {}

    aAdd( aRotina, { "Pesquisar" 	 , "AxPesqui"	, 00, 01 } )
    aAdd( aRotina, { "Visualizar"	 , "AxVisual"	, 00, 02 } )
    aAdd( aRotina, { "Incluir"		 , "AxInclui"	, 00, 03 } )
    aAdd( aRotina, { "Alterar"		 , "AxAltera"	, 00, 04 } )
    aAdd( aRotina, { "Excluir"		 , "AxDeleta"	, 00, 05 } )

    DbSelectArea( "SZ9" )
    DbSetOrder( 01 )
    mBrowse( 06, 01, 22, 75, "SZ9" )

    RestArea( aAreaAntes )

Return