
/*/{Protheus.doc} UNIR003

@project Impress�o de Boletos de Cobran�a

@description Fun��o para definir atrav�s de parametriza��o qual a rotina de Impress�o de Boletos ser� utilizada.

@author Rafael Rezende
@since 16/04/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIR003()
	*---------------------*

	DbSelectArea( "SZ4" )
	SZ4->( DbSetOrder( 01 )  )
	SZ4->( DbGoTop() )
	If !SZ4->( Eof() )

		If AllTrim( SZ4->Z4_CODIGO ) == "341" // Itau
			U_UNIR001()

		ElseIf AllTrim( SZ4->Z4_CODIGO ) == "033" // Santander
			U_UNIR002()


		ElseIf AllTrim( SZ4->Z4_CODIGO ) == "237" // Badresco // Atualizado por Luiz Otavio Campos em 08/07/2021 considerar banco Bradesco
			U_UNIR011()

		Else
			Aviso( "Aten��o", "A Configura��o de Contas para Boletos n�o est� configurada para este banco [SZ4 - SZ6]. Favor contactar o Administrador.", { "Voltar" } )
		EndIf

	Else

		Aviso( "Aten��o", "N�o encontrou a Configura��o de Contas para Boletos. Favor contactar o Administrador [ SZ4 ].", { "Voltar" } )

	EndIf

Return
