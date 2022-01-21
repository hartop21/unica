*----------------------------------*
/*/{Protheus.doc} UNIA007

@project Visualização de Log de Integração com o Magento

@description Opção de consulta ao Log de Integração com o Magento

@author Rafael Rezende
@since 15/04/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA007()
	*---------------------*
	Private cCadastro   := "Visualização de Log de Integração com o Magento"
	Private aRotina     := {}

	aRotina     		:= {  { "Pesquisar"  , "AxPesqui", 00, 01 } ,;
		{ "Visualizar" , "AxVisual", 00, 02 }  }

	DbSelectArea( "SZ5" )
	DbGoTop()
	mBrowse( 06, 01, 22, 75, "SZ5")

Return