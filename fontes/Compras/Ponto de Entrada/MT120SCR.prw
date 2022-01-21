#Include "TOTVS.ch"


User Function MT120SCR()

	Local aAreaAnt   := GetArea()
	Local aAreaSB1   := SB1->( GetArea() )
	Local nPosCodigo := aScan( aHeader, { |x| AllTrim( x[02] ) == "C7_PRODUTO" } )
	Local nPosDescri := aScan( aHeader, { |x| AllTrim( x[02] ) == "C7_DESCPRO"  } )

	If nPosDescri > 0

		DbSelectArea( "SB1" ) // B1_FILIAL+B1_COD
		DbSetOrder( 01 )
		For nLinha := 01 To Len( aCols )

			If SB1->( DbSeek( XFilial( "SB1" ) + aCols[nLinha][nPosCodigo] ) )
				aCols[nLinha][nPosDescri] := SB1->B1_DESC
			EndIf

		Next nLinha

	EndIf

Return