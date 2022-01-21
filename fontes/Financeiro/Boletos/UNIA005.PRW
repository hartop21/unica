*----------------------------------*
/*/{Protheus.doc} UNIA005

@project Impressão de Boletos de Cobrança

@description Tela de Configuração para as definições de geração de boletos

@author Rafael Rezende
@since 15/04/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA005()
	*---------------------*
	Private cCadastro   := "Configurações para Emissão de Boletos na geração da DANFE "
	Private aRotina     := {}

	DbSelectArea( "SZ4" )
	DbGoTop()

	If RecCount() >= 01
		aRotina     		:= {  { "Pesquisar"  , "AxPesqui", 00, 01 } ,;
			{ "Visualizar" , "AxVisual", 00, 02 } ,;
			{ "Alterar"	 , "AxAltera", 00, 04 }  }

	Else
		aRotina     		:= {  { "Pesquisar"  , "AxPesqui", 00, 01 } ,;
			{ "Visualizar" , "AxVisual", 00, 02 } ,;
			{ "Incluir"	 , "AxInclui", 00, 03 } ,;
			{ "Alterar"	 , "AxAltera", 00, 04 }  }
	EndIf

	DbSelectArea( "SZ4" )
	DbGoTop()
	mBrowse( 06, 01, 22, 75, "SZ4")

Return