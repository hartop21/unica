*----------------------------------*
/*/{Protheus.doc} CBINVVAL

@project Validação de Produtos compostos no ACD

@description Ponto de entrada que ocorre na validação do Produto na rotina padrão "ACDV035 " - Inventário

@author Rafael Rezende
@since 01/04/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "Font.ch"
#Include "Apvt100.ch"
#Include "TopConn.ch"


User Function CBINVVAL()

	Local cAuxCodBar	:= cEtiqProd
	Local cAuxProduto  	:= Space( TamSX3( "B1_COD" )[01] )
	Local lRetA		:= .T.
	Local cMacro1 := ""
	Local cMacro2 := ""

	cMacro1 := "StaticCall( AC120VLD, FPossuiComplementar, cAuxCodBar )"

	// Verifica se o Item Selecionado possui Produto Complementar
	If !&cMacro1
		Return .T.
	EndIf

	aTela:= VTSave()
	VTClear()

	cMacro2 := "StaticCall( AC120VLD, FVldComplemento, cAuxProduto, @lRetA )"

	@ 00,00 VTSAY "Informe o Produto "
	@ 01,00 VTSAY "Complementar: "
	@ 02,00 VTGet cAuxProduto Pict '@!' Valid VTLastkey() == 5 .Or. &cMacro2 F3 "CBZ"
	VTRead

	VTRestore( ,,,, aTela )

Return lRetA
