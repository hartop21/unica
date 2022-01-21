*----------------------------------*
/*/{Protheus.doc} AV120VLD

@project Validação de Produtos compostos no ACD

@description Ponto de entrada que ocorre na validação do Produto na rotina padrão "ACDV120" - Conferência da NF - Recebimento do ACD

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


User Function AV120VLD()

	Local cAuxCodBar  	:= ParamIXb[01]
	Local lRetA			:= .F.
	Local cAuxProduto  	:= Space( TamSX3( "B1_COD" )[01] )


	// Verifica se o Item Selecionado possui Produto Complementar
	If !FPossuiComplementar( cAuxCodBar )
		Return .T.
	EndIf

	aTela				:= VTSave()
	VTClear()

	@ 00,00 VTSay "Informe o Produto  " //VTColor "CLR_RED"
	@ 01,00 VTSay "Complementar: " //VTColor "CLR_RED"
	@ 02,00 VTGet cAuxProduto Pict "@!" Valid VTLastkey() == 05 .Or. FVldComplemento( cAuxProduto, @lRetA ) F3 "CBZ"
	VTRead

	VTRestore( ,,,, aTela )

Return lRetA

*---------------------------------------------------*
Static Function FVldComplemento( cAuxProduto, lRetA )
	*---------------------------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local aAreaSB1 	:= SB1->( GetArea() )
	Local aAreaSB5	:= SB5->( GetArea() )
	Local lRetA  	:= .F.
	Local cAliasTmp := GetNextAlias()

	Private lCobBarB5 := .F.
	Private cCodBarB5 := ""

	lRetA 			:= .F.

	DbSelectArea("SB5")
	DbSetOrder(09) //B5_FILIAL + B5_PRODUTO
	If DbSeek(xFilial("SB5")+cAuxProduto)
		If AllTrim(SB5->B5_2CODBAR) <> ""
			lCobBarB5 := .T.
			cCodBarB5 := SB5->B5_2CODBAR
		EndIf
	EndIf
	If lCobBarB5
		cQuery := "		SELECT COUNT( * ) AS NACHOU "
		cQuery += " 	  FROM " + RetSQLName( "SB5" )
		cQuery += "	     WHERE D_E_L_E_T_ 	= ' ' "
		cQuery += "	       AND B5_FILIAL  	= '" + XFilial( "SB5" ) + "' "
		cQuery += "	       AND B5_COD	  	= '" + SB1->B1_XCONPON  + "' "
		cQuery += "		   AND B5_2CODBAR	= '" + cAuxProduto		+ "' "
		If Select( cAliasTmp ) > 0
			( cAliasTmp )->( DbCloseArea() )
		EndIf
		ConOut( "AC120VLD - " + cQuery )
		TcQuery cQuery Alias ( cAliasTmp ) New
		If !( cAliasTmp )->( Eof() )
			lRetA := ( ( cAliasTmp )->NACHOU > 0 )
		EndIf
		( cAliasTmp )->( DbCloseArea() )
	Else
		cQuery := "		SELECT COUNT( * ) AS NACHOU "
		cQuery += " 	  FROM " + RetSQLName( "SB1" )
		cQuery += "	     WHERE D_E_L_E_T_ 	= ' ' "
		cQuery += "	       AND B1_FILIAL  	= '" + XFilial( "SB1" ) + "' "
		cQuery += "	       AND B1_COD	  	= '" + SB1->B1_XCONPON  + "' "
		cQuery += "		   AND B1_CODBAR	= '" + cAuxProduto		+ "' "
		If Select( cAliasTmp ) > 0
			( cAliasTmp )->( DbCloseArea() )
		EndIf
		ConOut( "AC120VLD - " + cQuery )
		TcQuery cQuery Alias ( cAliasTmp ) New
		If !( cAliasTmp )->( Eof() )
			lRetA := ( ( cAliasTmp )->NACHOU > 0 )
		EndIf
		( cAliasTmp )->( DbCloseArea() )
	EndIf
	If !lRetA
		VTBeep( 02 )
		VTAlert( "Produto complementar referente ao Produto Bipado nao confere " + cAuxProduto, "Aviso", .T., 4000 )
		VTGetRefresh( "cAuxProduto" )
		VTKeyBoard( Chr( 20 ) )
		VTGetSetFocus( "cAuxProduto" )
	EndIf

	RestArea( aAreaSB1 )
	RestArea( aAreaSB5)
	RestArea( aAreaAnt )

Return lRetA

*----------------------------------------------------*
Static Function FPossuiComplementar( cParamCodBarras )
	*----------------------------------------------------*
	Local aAreaAnt 		:= GetArea()
	Local aAreaSB1 		:= SB1->( GetArea() )
	Local lPossuiCompl 	:= .F.

	ConOut( "AC120VLD - FPossuiComplementar - Vai Procurar o Produto com Código de Barras " + cParamCodBarras )

	DbSelectArea("SB5")
	DbSetOrder(09) //B5_FILIAL + B5_2CodBar
	If DbSeek(xFilial("SB5")+Padr(cParamCodBarras,TamSx3("B5_2CODBAR")[1]))
		If AllTrim(SB5->B5_2CODBAR) <> ""

			ConOut( "AC120VLD - FPossuiComplementar - Encontrou o Produto na SB5 " + SB5->B5_COD )

			DbSelectArea("SB1")
			DbSetOrder(01)
			DbSeek(XFilial( "SB1" ) + SB5->B5_COD)

			ConOut( "AC120VLD - FPossuiComplementar - Encontrou o Complemento " + SB1->B1_XCONPON )

			If AllTrim( SB1->B1_XCONPON ) != ""
				lPossuiCompl := .T.
			EndIf
		Else
			DbSelectArea( "SB1" )
			DbSetOrder( 05 ) // B1_FILIAL + B1_CODBAR
			Seek XFilial( "SB1" ) + cParamCodBarras
			If Found()

				ConOut( "AC120VLD - FPossuiComplementar - Encontrou o Produto " + SB1->B1_COD )
				ConOut( "AC120VLD - FPossuiComplementar - Encontrou o Complemento " + SB1->B1_XCONPON )

				If AllTrim( SB1->B1_XCONPON ) != ""
					lPossuiCompl := .T.
				EndIf
			EndIf
		EndIf

	Else
		DbSelectArea( "SB1" )
		DbSetOrder( 05 ) // B1_FILIAL + B1_CODBAR
		Seek XFilial( "SB1" ) + cParamCodBarras
		If Found()

			ConOut( "AC120VLD - FPossuiComplementar - Encontrou o Produto " + SB1->B1_COD )
			ConOut( "AC120VLD - FPossuiComplementar - Encontrou o Complemento " + SB1->B1_XCONPON )

			If AllTrim( SB1->B1_XCONPON ) != ""
				lPossuiCompl := .T.
			EndIf

		EndIf
	EndIf
	ConOut( "AC120VLD - FPossuiComplementar - Fim da Procura" )

	RestArea( aAreaSB1 )
	RestArea( aAreaAnt )

Return lPossuiCompl
