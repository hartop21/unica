
/*/{Protheus.doc} UNIA018

@project Criação da Minuta
@description Rotina customizada para permitir a criação, manutenção e efetivação da Minuta
@author Rafael Rezende
@since 29/08/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"

User Function UNIA018TST()

	RPCSetEnv( "01", "0101" )

	U_UNIA018I()

	RPCClearEnv()

Return

*---------------------*
User Function UNIA018()
	*---------------------*
	Local aAreaAntes    		:= GetArea()
	Private cCadastro 			:= "Cadastro de Minutas"
	Private aRotina     		:= {}
	Private oOk       			:= LoadBitmap( GetResources() , "LBOK" 		  ) // Marcado
	Private oNo     		  	:= LoadBitmap( GetResources() , "LBNO" 		  ) // Desmarcado
	Private oVerde      		:= LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
	Private oVermelho 		  	:= LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho
	Private lMarcaDesmarca 		:= .F.
	Private lMarcaMDesmarca 	:= .F.
	Private aCores 				:= { { "ZA_EFETIV  == 'N'", 'BR_VERMELHO' },;
		{ "ZA_EFETIV  == 'S'", 'BR_VERDE'    },;
		{ "ZA_EFETIV  == 'P'", 'BR_AMARELO'  },;
		{ "ZA_EFETIV  == 'F'", 'BR_AZUL'     } }

	aAdd( aRotina, { "Pesquisar" 	 , "AxPesqui"	, 00, 01 } )
	aAdd( aRotina, { "Visualizar"	 , "AxVisual"	, 00, 02 } )
	aAdd( aRotina, { "Incluir"		 , "U_UNIA018I"	, 00, 03 } )
	aAdd( aRotina, { "Alterar"		 , "U_UNIA018A"	, 00, 04 } )
	aAdd( aRotina, { "Excluir"	 	 , "U_UNIA018X"	, 00, 05 } )
	aAdd( aRotina, { "Alt. Notas" 	 , "U_UNIA018M"	, 00, 06 } )
	//aAdd( aRotina, { "Imprimir"		 , "U_UNIA018P" , 00, 07 } )
	aAdd( aRotina, { "Efetivar"		 , "U_UNIA018E" , 00, 08 } )
	aAdd( aRotina, { "Conf. Coleta"	 , "U_UNIA018C" , 00, 09 } )
	aAdd( aRotina, { "Legenda"	 	 , "U_UNIA018L"	, 00, 10 } )

	DbSelectArea( "SZA" )
	DbSetOrder( 01 )
	mBrowse( 06, 01, 22, 75, "SZA",,,,,, aCores )

	RestArea( aAreaAntes )

Return


*-----------------------------------------------------------*
User Function UNIA018A( cParamAlias, nParamRecNo, nParamOpc )
	*-----------------------------------------------------------*

	If AllTrim( SZA->ZA_EFETIV ) != "N"

		Aviso( "Atenção", "A Minuta selecionada já foi efetivada.", { "Voltar" } )

	Else

		DbSelectArea( "SZA" )
		AxAltera( cParamAlias, nParamRecNo, nParamOpc )

	EndIf

Return


User Function UNIA018I()

	Private dGetDtInicial 		:= CToD( "  /  /    " )
	Private dGetDtFinal  		:= CToD( "  /  /    " )
	Private cGetFTransp			:= Space( TamSX3( "A4_COD" )[01] )
	Private cGetFDescTransp		:= ""
	Private cGetFPedInicial		:= Space( TamSX3( "C5_NUM"   )[01] )
	Private cGetFPedFinal		:= Replicate( "Z", TamSX3( "C5_NUM" )[01] )
	Private cGetFSerInicial		:= Space( TamSX3( "F2_SERIE" )[01] )
	Private cGetFSerFinal		:= Replicate( "Z", TamSX3( "F2_SERIE" )[01] )
	Private cGetFNFInicial		:= Space( TamSX3( "F2_DOC"   )[01] )
	Private cGetFNFFinal		:= Replicate( "Z", TamSX3( "F2_DOC" )[01] )

	Private aListEmpFil			:= {}
	Private aTitListEmpFil 		:= {}
	Private aSizeListEmpFil 	:= {}
	Private bLinesEmpFil		:= { || }

	Private nPosEMarcado		:= 01
	Private nPosEEmpresa		:= 02
	Private nPosEFilial			:= 03
	Private nPosENomeEmp		:= 04
	Private nPosENomeFil		:= 05

	SetPrvt( "oDlgFilMinuta","oGrpEmpFil","oBtnConfirm","oBtnSair","oListEmpFil","oGrpFiltro","oSayDtInicial" )
	SetPrvt( "oSayDtFinal","oGetDtFinal", "oSayTransp","oGetTransp","oSayDesTransp", "oGetDesTransp" )
	SetPrvt( "oSayNFInicial", "oGetNFInicial", "oSayNFFinal", "oGetNFFinal", "oSayPedInicial", "oGetPedInicial" )
	SetPrvt( "oSaySerInicial","oGetSerInicial", "oSaySerFinal", "oGetSerFinal","oSayPedFinal", "oGetPedFinal" )

	MsgRun( "Carregando Cadastro de Empresas, aguarde...", "Carregando Cadastro de Empresas, aguarde...", { || FCarregaEmpFil() } )

	oDlgFilMinuta				:= MSDialog():New( 122,241,596,1131,"Filtros para a Minuta",,,.F.,,,,,,.T.,,,.F. )

	oGrpEmpFil 					:= TGroup():New( 004,010,086,382," Empresa / Filial ",oDlgFilMinuta,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	aTitListEmpFil 				:= {}
	aSizeListEmpFil 			:= {}
	aAdd( aTitListEmpFil , "" 			)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "B"	 		  ) )
	aAdd( aTitListEmpFil , "EMP" 			)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBB" 			  ) )
	aAdd( aTitListEmpFil , "FILIAL" 		)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBBB" 			  ) )
	aAdd( aTitListEmpFil , "NOME EMPRESA" 	)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBBBBBBBBBBB" 	  ) )
	aAdd( aTitListEmpFil , "NOME FILIAL" 	)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBBBBBBBBBBBBBB" ) )
	oListEmpFil 				:= TwBrowse():New( 014, 017, 355, 065,, aTitListEmpFil, aSizeListEmpFil, oGrpEmpFil,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListEmpFil:SetArray( aListEmpFil )
	bLinesEmpFil				:= { || { 	If( aListEmpFil[oListEmpFil:nAt][nPosEMarcado], oOk, oNo )	,; // Marcado
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosEEmpresa] ) 			,; // Empresa
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosEFilial]  ) 			,; // Filial
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosENomeEmp] ) 			,; // Nome Empresa
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosENomeFil] ) 			}} // Nome Filial
	oListEmpFil:bLine 	   		:= bLinesEmpFil
	oListEmpFil:bLDblClick 		:= { || FSeleciona( oListEmpFil, @aListEmpFil, nPosEFilial, nPosEMarcado ) }
	oListEmpFil:bHeaderClick 	:= { || FSelectAll( oListEmpFil, @aListEmpFil, nPosEFilial, nPosEMarcado, @lMarcaDesmarca ) }
	oListEmpFil:Refresh()

	oGrpFiltro 					:= TGroup():New( 092,010,223,382," Filtros ",oDlgFilMinuta,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayDtInicial 				:= TSay():New( 104,018,{||"Dt. Entr. Inicial:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetDtInicial 				:= TGet():New( 112,018,,oGrpFiltro,052,008,'@D',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetDtInicial",,)
	oGetDtInicial:bSetGet	 	:= {|u| If(PCount()>0,dGetDtInicial:=u,dGetDtInicial)}

	oSayDtFinal 				:= TSay():New( 104,082,{||"Dt. Entr. Final:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetDtFinal 				:= TGet():New( 112,082,,oGrpFiltro,052,008,'@D',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetDtFinal",,)
	oGetDtFinal:bSetGet	 		:= {|u| If(PCount()>0,dGetDtFinal:=u,dGetDtFinal)}

	oSayPedInicial				:= TSay():New( 128,018,{||"Pedido Inicial:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetPedInicial 				:= TGet():New( 136,018,,oGrpFiltro,052,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SC5","cGetFPedInicial",,)
	oGetPedInicial:bSetGet	 	:= {|u| If(PCount()>0,cGetFPedInicial:=u,cGetFPedInicial)}

	oSayPedFinal 				:= TSay():New( 128,082,{||"Pedido Final:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetPedFinal 				:= TGet():New( 136,082,,oGrpFiltro,052,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SC5","cGetFPedFinal",,)
	oGetPedFinal:bSetGet 		:= {|u| If(PCount()>0,cGetFPedFinal:=u,cGetFPedFinal)}

	oSaySerInicial				:= TSay():New( 148,018,{||"Série Inicial:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetSerInicial 				:= TGet():New( 156,018,,oGrpFiltro,052,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"01","cGetFSerInicial",,)
	oGetSerInicial:bSetGet	 	:= {|u| If(PCount()>0,cGetFSerInicial:=u,cGetFSerInicial)}

	oSaySerFinal 				:= TSay():New( 148,082,{||"Série Final:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetSerFinal 				:= TGet():New( 156,082,,oGrpFiltro,052,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"01","cGetFSerFinal",,)
	oGetSerFinal:bSetGet 		:= {|u| If(PCount()>0,cGetFSerFinal:=u,cGetFSerFinal)}

	oSayNFInicial				:= TSay():New( 168,018,{||"Nota Inicial:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetNFInicial 				:= TGet():New( 176,018,,oGrpFiltro,052,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SF2","cGetFNFInicial",,)
	oGetNFInicial:bSetGet	 	:= {|u| If(PCount()>0,cGetFNFInicial:=u,cGetFNFInicial)}

	oSayNFFinal 				:= TSay():New( 168,082,{||"Nota Final:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetNFFinal 				:= TGet():New( 176,082,,oGrpFiltro,052,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SF2","cGetFNFFinal",,)
	oGetNFFinal:bSetGet 		:= {|u| If(PCount()>0,cGetFNFFinal:=u,cGetFNFFinal)}

	oSayFTransp  				:= TSay():New( 188,018,{||"Transportadora:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
	oGetFTransp  				:= TGet():New( 196,018,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA4","cGetFTransp",,)
	oGetFTransp:bSetGet	 		:= {|u| If(PCount()>0,cGetFTransp:=u,cGetFTransp ) }
	oGetFTransp:bValid  		:= { || FVldCampo( "SA4", 1 ) }

	oSayFDesTransp 				:= TSay():New( 188,082,{||"Descrição da Transportadora:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,095,008)
	oGetFDesTransp 				:= TGet():New( 196,082,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFDescTransp",,)
	oGetFDesTransp:bSetGet 		:= {|u| If(PCount()>0,cGetFDescTransp:=u,cGetFDescTransp)}
	oGetFDesTransp:bWhen 		:= { || .F. }

	oBtnFiltrar 				:= TButton():New( 008,388,"Confirmar",oDlgFilMinuta,,045,012,,,,.T.,,"",,,,.F. )
	oBtnFiltrar:bAction 		:= { || FPrincipal() }

	oBtnSair   					:= TButton():New( 024,388,"Sair",oDlgFilMinuta,,045,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction	 		:= { || oDlgFilMinuta:End() }

	oDlgFilMinuta:Activate( ,,, .T. )

Return

*-----------------------------------------------------*
Static Function FVldCampo( cParamOpcao, nParamMomento )
	*-----------------------------------------------------*
	Local lRetA := .T.

	If nParamMomento == 01
		cAuxCodigo  := cGetFTransportadora
		cAuxDestino := "cGetFDescTransportadora"
	Else
		cAuxCodigo := cGetTransp
		cAuxDestino := "cGetDescTransp"
	EndIf

	Do Case

		Case cParamOpcao == "SA4" // Categoria

			If AllTrim( cAuxCodigo ) != ""

				DbSelectArea( "SA4" )
				DbSetOrder( 01 ) // A4_FILIAL + A4_COD
				Seek XFilial( "SA4" ) + cAuxCodigo
				If Found()
					&cAuxDestino := SA4->A4_NOME
				Else
					Aviso( "Atenção", "A Transportadora informada não pode ser encontrada.", { "Voltar" } )
					lRetA 		 			:= .F.
					&cAuxDestino := ""
				EndIf

			Else
				&cAuxDestino := ""
			EndIf

	EndCase

Return lRetA


Static Function FCarregaEmpFil()

	Local aAreaAnt 	:= GetArea()
	Local aAreaSM0	:= SM0->( GetArea() )
	aListEmpFil 	:= {}

	DbselectArea( "SM0" )
	DbGoTop()
	Do While !SM0->( Eof() )

		aAdd( aListEmpFil, { .T., ;
			SM0->M0_CODIGO , ;
			SM0->M0_CODFIL , ;
			SM0->M0_NOME	, ;
			SM0->M0_FILIAL } )
		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo

	RestArea( aAreaSM0 )
	RestArea( aAreaAnt )

Return

*--------------------------------------------------------------------------------------------------------------------------------------------------------------*
Static Function FSeleciona( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, nParamPosLegenda, lParamTemLegenda, lParamTotaliza, nParamTipo )
	*--------------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local nLinhaGrid 			:= oParamListObject:nAt
	Default nParamPosLegenda 	:= 0
	Default lParamTemLegenda    := .F.
	Default lParamTotaliza      := .F.
	Default nParamTipo 			:= 01

	// Linha precisa ser maior que zero
	If nLinhaGrid == 0
		Return
	EndIf

	If Len( aParamListObject ) == 00
		Return
	EndIf

	If ( oParamListObject:nColPos == nParamPosLegenda .And. lParamTemLegenda )

		If nParamTipo == 01
			U_UNIA018L()
		Else
			FLegenda()
		EndIf

	Else

		If Len( aParamListObject ) == 01 .And. nLinhaGrid == 01
			If AllTrim( aParamListObject[nLinhaGrid][nParamPosCpo] ) == ""
				Return
			EndIf
		EndIf

		If nParamTipo == 01
			aParamListObject[nLinhaGrid][nParamPosMarcado] := !aParamListObject[nLinhaGrid][nParamPosMarcado]
		Else

			If aParamListObject[nLinhaGrid][nPosEnviado] != "S"
				aParamListObject[nLinhaGrid][nParamPosMarcado] := !aParamListObject[nLinhaGrid][nParamPosMarcado]
			EndIf

		EndIf

		oParamListObject:Refresh()

		If lParamTotaliza
			FTotaliza()
		EndIf

	EndIf

Return

*-------------------------*
Static Function FTotaliza()
	*-------------------------*
	Local nL := 0

	nGetQtdNotas	 	:= 0
	nGetTotPeso 		:= 0
	For nL := 01 To Len( aListNotas )

		If aListNotas[nL][nPosMarcado]
			nGetQtdNotas += 01
			nGetTotPeso  += aListNotas[nL][nPosPeso]
		EndIf

	Next nL
	oGetQtdNotas:Refresh()
	oGetTotPeso:Refresh()

Return

*-----------------------------------------------------------------------------------------------------------------------------------*
Static Function FSelectAll( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, lParamMarcaDesmarca, lParamTotaliza )
	*-----------------------------------------------------------------------------------------------------------------------------------*
	Local nY := 0
	Default lParamTotaliza := .F.

	If Len( aParamListObject ) == 00
		Return
	EndIf

	If Len( aParamListObject ) == 01
		If AllTrim( aParamListObject[01][nParamPosCpo] ) == ""
			Return
		EndIf
	EndIf

	lParamMarcaDesmarca := !lParamMarcaDesmarca
	For nY := 01 To Len( aParamListObject )
		aParamListObject[nY][nParamPosMarcado] := !lParamMarcaDesmarca
	Next nY

	If lParamTotaliza
		FTotaliza()
	EndIf

	oParamListObject:Refresh()

Return

*--------------------------*
Static Function FPrincipal()
	*--------------------------*
	Local nAcao					:= 0
	Private cGetCodigo 			:= GetSXENum( "SZA", "ZA_CODIGO" )
	Private cGetTransp	 		:= Space( TamSX3( "A4_COD"     )[01] )
	Private cGetMotorista 		:= Space( TamSX3( "ZA_MOTORIS" )[01] )
	Private cGetCNH    			:= Space( TamSX3( "ZA_REGCNH"  )[01] )
	Private cGetPlaca	    	:= Space( TamSX3( "ZA_PLACA"   )[01] )
	Private cGetDescTransp 		:= ""
	Private nGetQtdNotas	 	:= 0
	Private nGetTotPeso 		:= 0
	Private dGetDtMinuta	 	:= Date() //CToD( "" )

	Private aTitListNotas		:= {}
	Private aSizeListNotas 		:= {}
	Private aListNotas          := {}
	Private bLinesNotas			:= { || }

	Private nPosMarcado			:= 01
	Private nPosEnviado			:= 02
	Private nPosFilial			:= 03
	Private nPosPedido			:= 04
	Private nPosSerie			:= 05
	Private nPosNota			:= 06
	Private nPosTransp	 		:= 07
	Private nPosRazao			:= 08
	Private nPosCliente			:= 09
	Private nPosLoja			:= 10
	Private nPosNome			:= 11
	Private nPosUF				:= 12
	Private nPosPeso			:= 13
	Private nPosVolumes			:= 14
	Private nIdMagento			:= 15
	Private nPosInstancia		:= 16
	Private nPosRecNo			:= 17

	SetPrvt("oDlgMinuta","oGrpInfo","oSayCodigo","oSayTransp","oSayData","oSayTNome","oGetCodigo","oGetTransp")
	SetPrvt("oGetDtMinuta","oGrpNotas","oListNotas","oGrpVeiculo","oSayMotorista","oGetMotorista","oSayCNH", "oGetCNH")
	SetPrvt("oSayPlaca","oGetPlaca","oSayQtdNotas","oGetQtdNotas","oSayTotPeso","oGetTotPeso","oSayF7","oBtnConfirmar")

	If Empty( dGetDtInicial )
		Aviso( "Atenção", "O Filtro [ Dt. Entreg. Inicial ] é obrigatório.", { "Voltar" } )
		Return
	EndIf
	If Empty( dGetDtFinal )
		Aviso( "Atenção", "O Filtro [ Dt. Entreg. Final ] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	If AllTrim( cGetFPedFinal ) == ""
		Aviso( "Atenção", "O Filtro [ Pedido Final ] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	If AllTrim( cGetFSerFinal ) == ""
		Aviso( "Atenção", "O Filtro [ Série Final ] é obrigatório.", { "Voltar" } )
		Return
	EndIf
	If AllTrim( cGetFNFFinal ) == ""
		Aviso( "Atenção", "O Filtro [ Nota Final ] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	Processa( { || FCarregaNotas() }, "Carregando Notas, aguarde...",  )

	oDlgMinuta 				:= MSDialog():New( 120,254,702,1228,"Criação da Minuta",,,.F.,,,,,,.T.,,,.F. )
	oGrpInfo   				:= TGroup():New( 002,007,038,416," Informações da Minuta ",oDlgMinuta,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayCodigo 				:= TSay():New( 013,016,{||"Código:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetCodigo      		:= TGet():New( 022,016,,oGrpInfo,039,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCodigo",,)
	oGetCodigo:bSetGet 		:= {|u| If(PCount()>0,cGetCodigo:=u,cGetCodigo)}
	oGetCodigo:bWhen 		:= { || .F. }

	oSayTransp 				:= TSay():New( 013,068,{||"Transportadora: "},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,041,008)
	oGetTransp 				:= TGet():New( 022,068,,oGrpInfo,041,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA4","cGetTransp",,)
	oGetTransp:bSetGet 		:= {|u| If(PCount()>0,cGetTransp:=u,cGetTransp)}
	oGetTransp:bValid 		:= { || FVldCampo( "SA4", 2 ) }

	oSayTNome  				:= TSay():New( 013,116,{||"Nome:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,021,008)
	oGetDescTransp 			:= TGet():New( 022,116,,oGrpInfo,192,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDescTransp",,)
	oGetDescTransp:bSetGet 	:= {|u| If(PCount()>0,cGetDescTransp:=u,cGetDescTransp)}
	oGetDescTransp:bWhen 	:= { || .F. }

	oSayData   				:= TSay():New( 013,316,{||"Data:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,017,008)
	oGetDtMinu 				:= TGet():New( 022,316,,oGrpInfo,039,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetDtMinuta",,)
	oGetDtMinuta:bSetGet 	:= {|u| If(PCount()>0,dGetDtMinuta:=u,dGetDtMinuta)}
	oGetDtMinuta:bWhen 		:= { || .F. }

	oGrpNotas  				:= TGroup():New( 045,007,232,473," Notas para a Minuta ",oDlgMinuta,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListNotas 			:= {}
	aSizeListNotas 			:= {}

	aAdd( aTitListNotas , "" 			)
	aAdd( aSizeListNotas, GetTextWidth( 0, "B"	 	 ) )
	aAdd( aTitListNotas , "" 			)
	aAdd( aSizeListNotas, GetTextWidth( 0, "B" 		 ) )
	aAdd( aTitListNotas , "FILIAL" 		)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListNotas , "PEDIDO" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListNotas , "SERIE" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListNotas , "NOTA" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB"	 ) )
	aAdd( aTitListNotas , "TRANSP." 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBB"	 ) )
	aAdd( aTitListNotas , "NOME" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBBBBBBBBBBB"	 ) )
	aAdd( aTitListNotas , "CLIENTE" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB"	 ) )
	aAdd( aTitListNotas , "LOJA" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BB"	 	 ) )
	aAdd( aTitListNotas , "NOME" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBBBBBBBBBBB"	 ) )
	aAdd( aTitListNotas , "UF" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BB"	 	 ) )
	aAdd( aTitListNotas , "PESO" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB"	 ) )
	aAdd( aTitListNotas , "VOLUMES" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBBB"	 ) )
	aAdd( aTitListNotas , "PEDIDO EC" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB" 	 ) )
	aAdd( aTitListNotas , "INSTANCIA" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB" 	 ) )

	//oListNotas 			:= TListBox():New( 058,015,,,452,168,,oGrpNotas,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListNotas 				:= TwBrowse():New( 058, 015, 452, 168,, aTitListNotas, aSizeListNotas, oGrpNotas,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListNotas:SetArray( aListNotas )
	bLinesNotas				:= { || { 	If( aListNotas[oListNotas:nAt][nPosMarcado], oOk, oNo )				  	,; // Marcado
		If( AllTrim( aListNotas[oListNotas:nAt][nPosEnviado] ) == "S", oVerde, oVermelho )	  	,; // Legenda
		AllTrim( aListNotas[oListNotas:nAt][nPosFilial] ) 						  	,; // Filial
		AllTrim( aListNotas[oListNotas:nAt][nPosPedido] ) 						  	,; // Pedido
		AllTrim( aListNotas[oListNotas:nAt][nPosSerie] ) 						  	,; // Série
		AllTrim( aListNotas[oListNotas:nAt][nPosNota] ) 						  		,; // Nota
		AllTrim( aListNotas[oListNotas:nAt][nPosTransp] ) 						  	,; // Transportadora
		AllTrim( aListNotas[oListNotas:nAt][nPosRazao] ) 						  	,; // Razão Social
		AllTrim( aListNotas[oListNotas:nAt][nPosCliente] ) 						  	,; // Cliente
		AllTrim( aListNotas[oListNotas:nAt][nPosLoja] ) 						  		,; // Loja
		AllTrim( aListNotas[oListNotas:nAt][nPosNome] ) 						  		,; // Nome
		AllTrim( aListNotas[oListNotas:nAt][nPosUF] ) 						  		,; // UF
		AllTrim( TransForm( aListNotas[oListNotas:nAt][nPosPeso]	, "@E 999,999,999.99" ) ) 	,; // Peso
		AllTrim( TransForm( aListNotas[oListNotas:nAt][nPosVolumes]	, "@E 999,999,999.99" ) ) 	,; // Volumes
		AllTrim( aListNotas[oListNotas:nAt][nIdMagento] ) 						  	,; // Pedido E-Commerce
		AllTrim( aListNotas[oListNotas:nAt][nPosInstancia] ) 						}} // Instância

	oListNotas:bLine 	   	:= bLinesNotas
	oListNotas:bLDblClick 	:= { || FSeleciona( oListNotas, @aListNotas, nPosNota, nPosMarcado, nPosEnviado		 , .T., .T. ) }
	oListNotas:bHeaderClick := { || FSelectAll( oListNotas, @aListNotas, nPosNota, nPosMarcado, @lMarcaMDesmarca , .T. ) }
	oListNotas:Refresh()

	oGrpVeiculo				:= TGroup():New( 238,007,277,473," Informações do Veículo / Condutor ",oDlgMinuta,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayMotorista			:= TSay():New( 249,015,{||"Motorista:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,029,008)
	oGetMotorista			:= TGet():New( 258,015,,oGrpVeiculo,160,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMotorista",,)
	oGetMotorista:bSetGet 	:= {|u| If(PCount()>0,cGetMotorista:=u,cGetMotorista)}

	oSayCNH      			:= TSay():New( 249,183,{||"Reg. CNH:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,029,008)
	oGetCNH    				:= TGet():New( 258,183,,oGrpVeiculo,066,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCNH",,)
	oGetCNH:bSetGet 		:= {|u| If(PCount()>0,cGetCNH:=u,cGetCNH)}

	oSayPlaca  				:= TSay():New( 249,255,{||"Placa:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,029,008)
	oGetPlaca  				:= TGet():New( 258,255,,oGrpVeiculo,066,008,'@R !!!-!!!!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPlaca",,)
	oGetPlaca:bSetGet 		:= {|u| If(PCount()>0,cGetPlaca:=u,cGetPlaca)}

	oSayQtdNotas 			:= TSay():New( 249,351,{||"Qtd. Notas:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
	oGetQtdNotas     		:= TGet():New( 258,351,,oGrpVeiculo,054,008,'@E 999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetQtdNotas",,)
	oGetQtdNotas:bSetGet 	:= {|u| If(PCount()>0,nGetQtdNotas:=u,nGetQtdNotas)}
	oGetQtdNotas:bWhen 		:= { || .F. }

	oSayTotPeso 			:= TSay():New( 249,411,{||"Peso Total:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
	oGetTotPeso      		:= TGet():New( 258,411,,oGrpVeiculo,054,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetTotPeso",,)
	oGetTotPeso:bSetGet 	:= {|u| If(PCount()>0,nGetTotPeso:=u,nGetTotPeso)}
	oGetTotPeso:bWhen 		:= { || .F. }

	oSayF7     				:= TSay():New( 036,427,{||"<F7> = Pesquisar"},oDlgMinuta,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,049,008)
	oBtnOk	 				:= TButton():New( 004,424,"Confirmar",oDlgMinuta,,052,012,,,,.T.,,"",,,,.F. )
	oBtnOk:bAction 			:= { || nAcao := 01, If( FVldTdOk(), oDlgMinuta:End(), nAcao := 00 ) }

	oBtnFechar := TButton():New( 018,424,"Fechar",oDlgMinuta,,052,012,,,,.T.,,"",,,,.F. )
	oBtnFechar:bAction := { || nAcao := 00, oDlgMinuta:End() }

	FAtivaKeyPesq( oListNotas, VK_F7 )
	oDlgMinuta:Activate(,,,.T.)
	FInativaKeyPesq( VK_F7 )

	If nAcao == 01

		Processa( { || FGrvMinuta() }, "Gravando a minuta, aguarde..." )

	Else
		RollBackSX8()
	EndIf

Return

*-----------------------------*
Static Function FCarregaNotas()
	*-----------------------------*
	Local aAreaAnt 	:= GetArea()
	Local cAliasQry := GetNextAlias()
	Local cQuery 	:= ""
	Local cSQLInFil := ""
	aListNotas 		:= {}

	cSQLInFil := ""
	For nE := 01 To Len( aListEmpFil )
		If aListEmpFil[nE][nPosEMarcado]
			cSQLInFil += AllTrim( aListEmpFil[nE][nPosEFilial] ) + ","
		EndIf
	Next nE
	cSQLInFil := Replace( AllTrim( cSQLInFil ) + ",", ",,", "" )

	cQuery := " SELECT 	DISTINCT  	  "	+ CRLF
	cQuery += "			F2_FILIAL  	, "	+ CRLF
	cQuery += "			C5_NUM		, "	+ CRLF
	cQuery += "			F2_SERIE   	, "	+ CRLF
	cQuery += "			F2_DOC   	, "	+ CRLF
	cQuery += "			F2_TRANSP  	, "	+ CRLF
	cQuery += "			F2_CLIENTE  , "	+ CRLF
	cQuery += "			F2_LOJA   	, "	+ CRLF
	cQuery += "			A1_NOME    	, "	+ CRLF
	cQuery += "		  	A1_EST		, "	+ CRLF
	cQuery += "			F2_VOLUME1 	, "	+ CRLF
	cQuery += "			F2_PBRUTO 	, "	+ CRLF
	cQuery += "			C5_XIDMAGE	, "	+ CRLF
	cQuery += "			C5_XCODSZ8	, "	+ CRLF
	cQuery += "			F2_XMINUTA  , "	+ CRLF
	cQuery += "			SF2.R_E_C_N_O_ AS NUMRECSF2 			  "	+ CRLF
	cQuery += "    FROM " + RetSQLName( "SF2" ) + " SF2 (NOLOCK), " + CRLF
	cQuery += "			" + RetSQLName( "SA1" ) + " SA1 (NOLOCK), "	+ CRLF
	cQuery += "	 		" + RetSQLName( "SC5" ) + " SC5 (NOLOCK), "	+ CRLF
	cQuery += "	 		" + RetSQLName( "SC6" ) + " SC6 (NOLOCK)  "	+ CRLF
	cQuery += "	  WHERE SF2.D_E_L_E_T_   	  = ' '  " + CRLF
	cQuery += "	    AND SA1.D_E_L_E_T_   	  = ' '  " + CRLF
	cQuery += "	    AND SC5.D_E_L_E_T_   	  = ' '  " + CRLF
	cQuery += "	    AND SC6.D_E_L_E_T_   	  = ' '  " + CRLF
	cQuery += "	    AND SA1.A1_FILIAL    	  = '" + XFilial( "SA1" ) + "' " + CRLF
	cQuery += "	    AND SF2.F2_FILIAL    	  = SC5.C5_FILIAL  "	+ CRLF
	cQuery += "	    AND SF2.F2_DOC  	 	  = SC5.C5_NOTA    "	+ CRLF
	cQuery += "	    AND SF2.F2_SERIE  	 	  = SC5.C5_SERIE   "	+ CRLF
	cQuery += "	    AND SF2.F2_CLIENTE   	  = SC5.C5_CLIENTE "	+ CRLF
	cQuery += "	    AND SF2.F2_LOJA 		  = SC5.C5_LOJACLI "	+ CRLF
	cQuery += "	    AND SF2.F2_CLIENTE  	  = SA1.A1_COD     "	+ CRLF
	cQuery += "	    AND SF2.F2_LOJA   	   	  = SA1.A1_LOJA    "	+ CRLF
	cQuery += "		AND SC5.C5_FILIAL		  = SC6.C6_FILIAL  "	+ CRLF
	cQuery += "		AND SC5.C5_NUM			  = SC6.C6_NUM	   "	+ CRLF
	cQuery += "		AND SC5.C5_CLIENTE		  = SC6.C6_CLI	   "	+ CRLF
	cQuery += "		AND SC5.C5_LOJACLI		  = SC6.C6_LOJA	   "	+ CRLF
	cQuery += "		AND SF2.F2_FILIAL 		 IN " + FormatIn( cSQLInFil, "," )	+ CRLF
	cQuery += "     AND SF2.F2_SERIE    BETWEEN '" + cGetFSerInicial  	   + "' AND '" + cGetFSerFinal	     + "' "	+ CRLF
	cQuery += "     AND SF2.F2_DOC      BETWEEN '" + cGetFNFInicial  	   + "' AND '" + cGetFNFFinal	     + "' "	+ CRLF
	cQuery += "     AND SC5.C5_NUM      BETWEEN '" + cGetFPedInicial  	   + "' AND '" + cGetFPedFinal		 + "' "	+ CRLF
	cQuery += "     AND SC5.C5_EMISSAO  BETWEEN '" + DToS( dGetDtInicial ) + "' AND '" + DToS( dGetDtFinal ) + "' "	+ CRLF
	//cQuery += "     AND SC6.C6_ENTREG   BETWEEN '" + DToS( dGetDtInicial ) + "' AND '" + DToS( dGetDtFinal ) + "' "	+ CRLF
	cQuery += "		AND SF2.F2_XMINUTA  	  = '' "	+ CRLF
	If AllTrim( cGetFTransp ) != ""
		cQuery += "     AND F2_TRANSP  	   	  = '" + cGetFTransp + "' " + CRLF
	EndIf
	cQuery += "	ORDER BY F2_FILIAL  , "
	cQuery += "			 C5_NUM		, "
	cQuery += "			 F2_SERIE   , "
	cQuery += "			 F2_DOC   	  "

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasQry ) New
	nContador := 0
	Count To nContador
	ProcRegua( nContador )
	DbSelectArea( cAliasQry )
	( cAliasQry )->( DbGoTop() )
	Do While !( cAliasQry )->( Eof() )

		IncProc()

		cAuxTransp := Posicione( "SA4", 01, XFilial( "SA4" ) +  ( cAliasQry )->F2_TRANSP, "A4_NOME" )
		aAuxLinha := {}
		aAdd( aAuxLinha, .F.   						) // 01- Marcado
		aAdd( aAuxLinha, ( cAliasQry )->F2_XMINUTA  ) // 02
		aAdd( aAuxLinha, ( cAliasQry )->F2_FILIAL  	) // 03
		aAdd( aAuxLinha, ( cAliasQry )->C5_NUM		) // 04
		aAdd( aAuxLinha, ( cAliasQry )->F2_SERIE   	) // 05
		aAdd( aAuxLinha, ( cAliasQry )->F2_DOC   	) // 06
		aAdd( aAuxLinha, ( cAliasQry )->F2_TRANSP  	) // 07
		aAdd( aAuxLinha, cAuxTransp					) // 08
		aAdd( aAuxLinha, ( cAliasQry )->F2_CLIENTE  ) // 09
		aAdd( aAuxLinha, ( cAliasQry )->F2_LOJA   	) // 10
		aAdd( aAuxLinha, ( cAliasQry )->A1_NOME    	) // 11
		aAdd( aAuxLinha, ( cAliasQry )->A1_EST		) // 12
		aAdd( aAuxLinha, ( cAliasQry )->F2_PBRUTO 	) // 13
		aAdd( aAuxLinha, ( cAliasQry )->F2_VOLUME1 	) // 14
		aAdd( aAuxLinha, ( cAliasQry )->C5_XIDMAGE	) // 15
		aAdd( aAuxLinha, ( cAliasQry )->C5_XCODSZ8	) // 16
		aAdd( aAuxLinha, ( cAliasQry )->NUMRECSF2 	) // 17
		aAdd( aListNotas, aAuxLinha )

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If Len( aListNotas ) == 0

		aAuxLinha := {}
		aAdd( aAuxLinha, .F. )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""	 )
		aAdd( aAuxLinha, ""	 )
		aAdd( aAuxLinha, ""	 )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""  )
		aAdd( aAuxLinha, ""	 )
		aAdd( aAuxLinha, 0 	 )
		aAdd( aAuxLinha, 0 	 )
		aAdd( aAuxLinha, ""	 )
		aAdd( aAuxLinha, ""	 )
		aAdd( aAuxLinha, 0 	 )

		aAdd( aListNotas, aAuxLinha )

	EndIf
	RestArea( aAreaAnt )

Return

*-----------------------------------------------------*
Static Function FAtivaKeyPesq( oListBox, nTeclaFuncao )
	*-----------------------------------------------------*
	Local bSetKey 		 := { || FPesqList( oListBox ) }
	Default nTeclaFuncao := VK_F7

	SetKey( nTeclaFuncao, bSetKey )

Return

*---------------------------------------------*
Static Function FInativaKeyPesq( nTeclaFuncao )
	*---------------------------------------------*
	Default nTeclaFuncao := VK_F7

	SetKey( nTeclaFuncao, Nil )

Return


Static Function FPesqList( oListBox )
	*----------------------------------*
	Private cGetConteu := Space(254)
	Private cCmbCampo  := ""
	Private aCmbCampo  := {}

	SetPrvt("oDlgPesquisa","oGrpFiltro","oSayCampo","oSayConteudo","oCmbCampo","oGetConteudo","oBtnPesq")

	MsgRun( "Carregando filtros, aguarde...", "Carregando filtros, aguarde...", { || FCarregaFiltros( oListBox, @aCmbCampo ) } )

	oDlgPesqui := MSDialog():New( 091,232,211,848,"Pesquisa em Listas",,,.F.,,,,,,.T.,,,.T. )
	oGrpFiltro := TGroup():New( 007,007,047,295," Filtro para Pesquisa ",oDlgPesquisa,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayCampo  := TSay():New( 019,015,{||"Campo a Pesquisar: "},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,052,008)
	oSayConteu := TSay():New( 019,084,{||"Conteudo à Pesquisar:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,052,008)
	oCmbCampo  := TComboBox():New( 028,016,{|u| If(PCount()>0,cCmbCampo:=u,cCmbCampo )}, aCmbCampo,064,010,oGrpFiltro,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cCmbCampo )
	oGetConteu := TGet():New( 028,084,{|u| If(PCount()>0,cGetConteudo:=u,cGetConteudo )},oGrpFiltro,148,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetConteudo",,)
	oBtnPesq   := TButton():New( 026,236,"&Pesquisar <ALT+P>",oGrpFiltro,{ || FPesq( oListBox ) },051,012,,,,.T.,,"",,,,.F. )

	oDlgPesquisa:Activate(,,,.T.)

Return

*-------------------------------*
Static Function FPesq( oListBox )
	*-------------------------------*
	Local nColunaList := Val( Left( cCmbCampo, 02 ) )
	Local lAchou 	  := .F.

	If oListBox:nAt > 01

		nLinhaAtu := oListBox:nAt
		If nLinhaAtu > 0
			If Len( oListBox:aArray ) >= ( nLinhaAtu + 01 )
				nLinhaAtu++
			EndIf
		Else
			nLinhaAtu := 01
		EndIf

	Else

		nLinhaAtu := 01

	EndIf

	lAchou := .F.
	For nP := nLinhaAtu To Len( oListBox:aArray )

		cAuxColTxt := ""
		Do Case
			Case ValType( oListBox:aArray[nP][nColunaList] ) == "D"
				cAuxColTxt := AllTrim( DToC( oListBox:aArray[nP][nColunaList] ) )
			Case ValType( oListBox:aArray[nP][nColunaList] ) == "N"
				cAuxColTxt := AllTrim( TransForm( oListBox:aArray[nP][nColunaList], "@E 999,999,999.99" ) )
			OtherWise
				cAuxColTxt := AllTrim( oListBox:aArray[nP][nColunaList] )
		EndCase

		If AllTrim( Upper( cGetConteudo ) ) $ AllTrim( Upper( cAuxColTxt ) )

			oListBox:nAt := nP
			lAchou := .T.
			Exit

		EndIf
	Next nP

	If lAchou

		oListBox:Refresh()

	Else

		If Aviso( "Atenção", "Não encontrou a pesquisa!" + CRLF + "Pesquisar do Início?", { "Sim", "Não" } ) == 01
			nLinhaAtu 	 := 01
			oListBox:nAt := 01
			FPesq( oListBox )
		EndIf

	EndIf

Return

*----------------------------------------------------*
Static Function FCarregaFiltros( oListBox, aCmbCampo )
	*----------------------------------------------------*
	aCmbCampo := {}
	For nF := 01 To Len( oListBox:aHeaders )

		If Alltrim( oListBox:aHeaders[nF] ) != ""
			aAdd( aCmbCampo, StrZero( nF, 02 ) + " - " + Alltrim( oListBox:aHeaders[nF] ) )
		EndIf

	Next nF

Return

*----------------------------------------------------------------*
Static Function FSelCombo( _cTitulo, _cDescricao, _aItens, _cRet )
	*----------------------------------------------------------------*
	Local _cCmbCampo 	:= ""
	Local _oCmbCampo	:= Nil
	Local _oBtnOk		:= Nil
	Local _oBtnSair		:= Nil
	Local _oGrpCombo	:= Nil
	Local _oDlgCombo	:= Nil
	Local _nOpc         := 0

	Default _cRet       := ""

	Define MsDialog _oDlgCombo Title _cTitulo From 000, 000  To 100, 485 Colors 0, 16777215 Pixel

	@ 005, 006 Group _oGrpCombo To 041, 204 Prompt _cDescricao 					Of _oDlgCombo Color 16711680, 16777215 Pixel
	@ 018, 013 MsComboBox _oCmbCampo Var _cCmbCampo Items _aItens Size 181, 010 Of _oDlgCombo Colors 0		, 16777215 Pixel

	Define SButton _oBtnOk   From 007, 209 Type 01 Of _oDlgCombo Enable Action( _nOpc := 01, _oDlgCombo:End() )
	Define SButton _oBtnSair From 020, 208 Type 02 Of _oDlgCombo Enable Action( _nOpc := 00, _oDlgCombo:End() )

	Activate MsDialog _oDlgCombo Centered

	If _nOpc == 01
		_cRet := _cCmbCampo
	End If

Return _cRet

*-----------------------*
User Function UNIA018L()

	Local aLegenda  := { { "BR_VERMELHO", "Não Efetivada"  			} ,;
		{ "BR_VERDE"   , "Efetivada" 	 	 		} ,;
		{ "BR_AMARELO" , "Parcialmente Confirmada" } ,;
		{ "BR_AZUL"	, "Totalmente Confirmada"   }  }

	BrwLegenda( "Status das Minutas", "Legenda", aLegenda )

Return



Static Function FLegenda()

	Local aLegenda  := { { "BR_VERDE"   , "Nota Embarcada" } ,;
		{ "BR_VERMELHO", "Nota Pendente"  }  }

	BrwLegenda( "Status das Notas da Minuta", "Legenda", aLegenda )

Return

*--------------------------*
Static Function FGrvMinuta()
	*--------------------------*
	Local nM := 0

	// Grava o Caveçalho da Minuta
	DbSelectArea( "SZA" )
	RecLock( "SZA", .T. )

	SZA->ZA_FILIAL  := XFilial( "SZA" )
	SZA->ZA_CODIGO  := cGetCodigo
	SZA->ZA_TRANSP  := cGetTransp
	SZA->ZA_MOTORIS := cGetMotorista
	SZA->ZA_REGCNH  := cGetCNH
	SZA->ZA_PLACA   := cGetPlaca
	SZA->ZA_DTCOLET := dGetDtMinuta
	SZA->ZA_DATA	:= Date()
	SZA->ZA_EFETIV  := "N"

	SZA->( MsUnLock() )
	ConfirmSX8()

	ProcRegua( Len( aListNotas ) )
	For nM := 01 To Len( aListNotas )

		IncProc( "Gravando a Minuta, aguarde..." )
		If aListNotas[nM][nPosMarcado]

			DbSelectArea( "SZB" )
			RecLock( "SZB", .T. )

			SZB->ZB_FILIAL   := XFilial( "SZB" )
			SZB->ZB_CODIGO   := cGetCodigo
			SZB->ZB_FILNOTA  := aListNotas[nM][nPosFilial]
			SZB->ZB_NUMNOTA  := aListNotas[nM][nPosNota]
			SZB->ZB_SERNOTA  := aListNotas[nM][nPosSerie]
			SZB->ZB_CLINOTA  := aListNotas[nM][nPosCliente]
			SZB->ZB_LOJNOTA  := aListNotas[nM][nPosLoja]
			SZB->ZB_PESNOTA  := aListNotas[nM][nPosPeso]
			SZB->ZB_VOLNOTA  := aListNotas[nM][nPosVolume]
			SZB->ZB_ENVIADO	 := "N"

			SZB->( MsUnLock() )

			DbSelectArea( "SF2" )
			SF2->( DbGoTo( aListNotas[nM][nPosRecNo] ) )
			RecLock( "SF2", .F. )
			SF2->F2_TRANSP  := cGetTransp
			SF2->F2_XMINUTA := cGetCodigo
			SF2->( MsUnLock() )

		EndIf

	Next nM

	Aviso( "Atenção", "Minuta [ " + cGetCodigo + " ] Incluída com sucesso!", { "Ok" } )

Return


User Function UNIA018M()

	Private cGetMCodigo 	:= SZA->ZA_CODIGO
	Private dGetMDtMin 		:= SZA->ZA_DATA
	Private cGetMTransp 	:= SZA->ZA_TRANSP
	Private cGetMDesTransp 	:= Posicione( "SA4", 01, XFilial( "SA4" ) + SZA->ZA_TRANSP, "A4_NOME" )
	Private cGetMFilial 	:= Space( FWSizeFilial() )
	Private cGetMSerie 		:= Space( TamSX3( "F2_SERIE" )[01] )
	Private cGetMNota  		:= Space( TamSX3( "F2_DOC" )[01] )
	Private nGetMVolume 	:= 0
	Private cGetMCliente 	:= ""
	Private cGetMLoja  		:= ""
	Private cGetMNome  		:= ""
	Private nRecNoSZB		:= 0

	SetPrvt("oDlgManMin","oGrpInfo","oSayMCodigo","oSayMTransp","oSayDtMinuta","oSayMDesTransp","oGetMCodigo")
	SetPrvt("oGetMDesTransp","oGetMDtMinuta","oBtnFechar","oGrpNota","oSayMFilial","oSayMSerie","oSayMNota")
	SetPrvt("oSayVolume","oSayMLoja","oSayMNome","oGetMFilial","oGetMSerie","oGetMNota","oGetMCliente","oGetMNome")
	SetPrvt("oGetMVolume","oBtninclui","oBtnAltera")

	If AllTrim( SZA->ZA_EFETIV ) != "N"
		Aviso( "Atenção", "A Minuta selecionada já foi efetivada.", { "Voltar" } )
		Return
	EndIf


	oDlgManMin 				:= MSDialog():New( 231,333,518,965,"Manutenção na Minuta",,,.F.,,,,,,.T.,,,.F. )

	oGrpInfo   				:= TGroup():New( 002,007,062,262," Informações da Minuta ",oDlgManMin,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayMCodigo			 	:= TSay():New( 013,016,{||"Código:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetMCodigo 			:= TGet():New( 022,016,,oGrpInfo,039,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMCodigo",,)
	oGetMCodigo:bSetGet 	:= {|u| If(PCount()>0,cGetMCodigo:=u,cGetMCodigo)}
	oGetMCodigo:bWhen 		:= { || .F. }

	oSayMDtMinuta			:= TSay():New( 013,063,{||"Data:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,017,008)
	oGetMDtMinuta 			:= TGet():New( 022,063,,oGrpInfo,039,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetMDtMinuta",,)
	oGetMDtMinuta:bSetGet 	:= {|u| If(PCount()>0,dGetMDtMinuta:=u,dGetMDtMinuta)}
	oGetMDtMinuta:bWhen 	:= { || .F. }

	oSayMTransp 			:= TSay():New( 037,014,{||"Transportadora: "},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetMTransp				:= TGet():New( 046,014,,oGrpInfo,041,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA4","cGetMTransp",,)
	oGetMTransp:bSetGet 	:= {|u| If(PCount()>0,cGetMTransp:=u,cGetMTransp)}
	oGetMTransp:bWhen 		:= { || .F. }

	oSayMDesTransp	 		:= TSay():New( 037,063,{||"Nome:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,021,008)
	oGetMDesTransp 			:= TGet():New( 046,063,,oGrpInfo,192,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMDesTransp",,)
	oGetMDesTransp:bSetGet 	:= {|u| If(PCount()>0,cGetMDesTransp:=u,cGetMDesTransp)}
	oGetMDesTransp:bWhen 	:= { || .F. }

	oGrpNota   				:= TGroup():New( 068,007,128,260," Manutenção na Minuta ",oDlgManMin,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayMFilial				:= TSay():New( 080,016,{||"Filial:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oGetMFilial				:= TGet():New( 089,016,,oGrpNota,032,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SZB","cGetMFilial",,)
	oGetMFilial:bSetGet 	:= {|u| If(PCount()>0,cGetMFilial:=u,cGetMFilial)}

	oSayMSerie 				:= TSay():New( 080,058,{||"Série:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oGetMSerie 				:= TGet():New( 089,058,,oGrpNota,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMSerie",,)
	oGetMSerie:bSetGet 		:= {|u| If(PCount()>0,cGetMSerie:=u,cGetMSerie)}

	oSayMNota  				:= TSay():New( 080,094,{||"Nota:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oGetMNota  				:= TGet():New( 089,094,,oGrpNota,067,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMNota",,)
	oGetMNota:bSetGet 		:= {|u| If(PCount()>0,cGetMNota:=u,cGetMNota)}
	oGetMNota:bValid		:= { || FGatilho() }

	oSayMCliente 			:= TSay():New( 103,014,{||"Cliente:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetMCliente			:= TGet():New( 112,014,,oGrpNota,041,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cGetMCliente",,)
	oGetMCliente:bSetGet 	:= {|u| If(PCount()>0,cGetMCliente:=u,cGetMCliente)}
	oGetMCliente:bWhen		:= { || .F. }

	oSayMNome      			:= TSay():New( 103,091,{||"Nome:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,021,011)
	oGetMNome  				:= TGet():New( 112,091,,oGrpNota,163,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMNome",,)
	oGetMNome:bSetGet 		:= {|u| If(PCount()>0,cGetMNome:=u,cGetMNome)}
	oGetMNome:bWhen 		:= { || .F. }

	oSayMLoja  				:= TSay():New( 103,061,{||"Loja:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,018,008)
	oGetMLoja  				:= TGet():New( 112,061,,oGrpNota,021,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMLoja",,)
	oGetMLoja:bSetGet 		:= {|u| If(PCount()>0,cGetMLoja:=u,cGetMLoja)}
	oGetMLoja:bWhen 		:= { || .F. }

	oSayMVolume    			:= TSay():New( 080,189,{||"Volumes:"},oGrpNota,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetMVolume 			:= TGet():New( 089,189,,oGrpNota,064,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","nGetMVolume",,)
	oGetMVolume:bSetGet 	:= {|u| If(PCount()>0,nGetMVolume:=u,nGetMVolume)}
	oGetMVolume:bWhen 		:= { || .F. }

	//oBtnInclui 				:= TBtnBmp2():New( 072, 268, 018, 015, "ADDCONTAINER",,,, { || FInclui() }, oDlgManMin, "Incluir Nota na Minuta"  , { || .T. } )
	oBtnInclui 				:= TBtnBmp2():New( 150, 530, 018, 015, "ADDCONTAINER",,,, { || FInclui() }, oDlgManMin, "Incluir Nota na Minuta"  , { || .T. } )
	//oBtnInclui := TButton():New( 072,268,"oBtninclui",oDlgManMin,,013,012,,,,.T.,,"",,,,.F. )
	//oBtninclui:bAction := { || FInclui() }

	//_oBtnExclui				:= TBtnBmp2():New( 088, 268, 018, 015, "BMPDEL"		 ,,,, { || FExclui() }, oDlgManMin, "Exclui NOta da Minuta"  , { || .T.  } )
	oBtnExclui				:= TBtnBmp2():New( 170, 530, 018, 015, "BMPDEL"		 ,,,, { || FExclui() }, oDlgManMin, "Exclui NOta da Minuta"  , { || .T.  } )
	//oBtnExclui := TButton():New( 088,268,"oBtn1",oDlgManMin,,013,011,,,,.T.,,"",,,,.F. )
	//oBtnExclui:bAction := { || FExclui() }

	oBtnFechar := TButton():New( 002,268,"Fechar",oDlgManMin,,036,012,,,,.T.,,"",,,,.F. )
	oBtnFechar:bAction := { || oDlgManMin:End() }

	oDlgManMin:Activate(,,,.T.)

Return


Static Function FGatilho()

	Local aAreaAntes := GetArea()
	Local lRetVld 	 := .T.

	If AllTrim( cGetMFilial + cGetMSerie + cGetMNota ) != ""

		DbSelectArea( "SF2" )
		DbSetOrder( 01 ) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
		Seek cGetMFilial + cGetMNota + cGetMSerie
		If Found()

			lRetVld			:= .T.
			nGetMVolume 	:= SF2->F2_VOLUME1
			cGetMCliente 	:= SF2->F2_CLIENTE
			cGetMLoja  		:= SF2->F2_LOJA
			cGetMNome  		:= Posicione( "SA1", 01, XFilial( "SA1" )+ SF2->( F2_CLIENTE + F2_LOJA ), "A1_NOME" )
			nRecNoSF2		:= SF2->( RecNo() )

		Else

			Aviso( "Atenção", "A Nota informada não foi localizada.", { "Voltar" } )
			lRetVld 		:= .F.
			nGetMVolume 	:= 0
			cGetMCliente 	:= ""
			cGetMLoja  		:= ""
			cGetMNome  		:= ""
			nRecNoSF2		:= 0

		EndIf

		DbSelectArea( "SZB" )
		DbSetOrder( 01 ) // ZB_FILIAL + ZB_CODIGO + ZB_FILNOTA + ZB_SERNOTA + ZB_NUMNOTA
		Seek XFilial( "SZB" ) + cGetMCodigo + cGetMFilial + cGetMSerie + cGetMNota
		If Found()
			nRecNoSZB	:= SZB->( RecNo() )
		Else
			nRecNoSZB	:= 0
		EndIf

	EndIf

	RestArea( aAreaAntes )

Return lRetVld


*-----------------------*
Static Function FInclui()
	*-----------------------*
	Local aAreaAntes := GetArea()

	If Aviso( "Atenção", "Você confirma a inclusão na Minuta da Nota informada?", { "Sim", "Não" } ) == 01

		DbSelectArea( "SZB" )
		DbSetOrder( 01 ) // ZB_FILIAL + ZB_CODIGO + ZB_FILNOTA + ZB_SERNOTA + ZB_NUMNOTA
		Seek XFilial( "SZB" ) + cGetMCodigo + cGetMFilial + cGetMSerie + cGetMNota
		If Found()

			Aviso( "Atenção", "A Nota informada já está incluída na Minuta.", { "Voltar" } )

		Else

			DbSelectArea( "SF2" )
			DbSetOrder( 01 ) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
			Seek cGetMFilial + cGetMNota + cGetMSerie
			If Found()

				If AllTrim( SF2->F2_CHVNFE ) == ""

					DbSelectArea( "SF2" )
					RecLock( "SF2", .F. )
					SF2->F2_TRANSP  := cGetMTransp
					SF2->F2_XMINUTA := cGetMCodigo
					SF2->( MsUnLock() )

					DbSelectArea( "SZB" )
					RecLock( "SZB", .T. )

					SZB->ZB_FILIAL   := XFilial( "SZB" )
					SZB->ZB_CODIGO   := cGetMCodigo
					SZB->ZB_FILNOTA  := cGetMFilial
					SZB->ZB_SERNOTA  := cGetMSerie
					SZB->ZB_NUMNOTA  := cGetMNota
					SZB->ZB_CLINOTA  := SF2->F2_CLIENTE
					SZB->ZB_LOJNOTA  := SF2->F2_LOJA
					SZB->ZB_PESNOTA  := SF2->F2_PBRUTO
					SZB->ZB_VOLNOTA  := SF2->F2_VOLUME1
					SZB->ZB_ENVIADO	 := "N"

					SZB->( MsUnLock() )

					Aviso( "Atenção", "A Nota foi incluída com sucesso!", { "Voltar" } )
					cGetMFilial 	:= Space( FWSizeFilial() )
					cGetMSerie 		:= Space( TamSX3( "F2_SERIE" )[01] )
					cGetMNota  		:= Space( TamSX3( "F2_DOC" )[01] )
					nGetMVolume 	:= 0
					cGetMCliente 	:= ""
					cGetMLoja  		:= ""
					cGetMNome  		:= ""
					nRecNoSZB		:= 0

				Else

					Aviso( "Atenção", "A Nota informada já foi transmitida para a Receita e não poderá sofrer alterações.!", { "Voltar" } )

				EndIf

			Else

				Aviso( "Atenção", "A Nota informada não foi encontrada.", { "Voltar" } )

			EndIf

		EndIf

	Else

		Aviso( "Atenção", "A Minuta já foi efetivada. Não poderá alterada!", { "Voltar" } )

	EndIf

	RestArea( aAreaAntes )

Return

*-----------------------*
Static Function FExclui()
	*-----------------------*
	Local aAreaAntes := GetArea()

	If AllTrim( SZA->ZA_EFETIV ) == "N"

		If Aviso( "Atenção", "Você confirma a exclusão na Minuta da Nota informada?", { "Sim", "Não" } ) == 01

			DbSelectArea( "SZB" )
			DbSetOrder( 01 ) // ZB_FILIAL + ZB_CODIGO + ZB_FILNOTA + ZB_SERNOTA + ZB_NUMNOTA
			Seek XFilial( "SZB" ) + cGetMCodigo + cGetMFilial + cGetMSerie + cGetMNota
			If Found()

				DbSelectArea( "SF2" )
				DbSetOrder( 01 ) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
				Seek cGetMFilial + cGetMNota + cGetMSerie
				If Found()

					DbSelectArea( "SF2" )
					RecLock( "SF2", .F. )
					SF2->F2_TRANSP  := ""
					SF2->F2_XMINUTA := ""
					SF2->( MsUnLock() )

					DbSelectArea( "SZB" )
					RecLock( "SZB", .F. )
					SZB->( DbDelete() )
					SZB->( MsUnLock() )

					Aviso( "Atenção", "A Nota foi Excluída com sucesso!", { "Voltar" } )
					cGetMFilial 	:= Space( FWSizeFilial() )
					cGetMSerie 		:= Space( TamSX3( "F2_SERIE" )[01] )
					cGetMNota  		:= Space( TamSX3( "F2_DOC" )[01] )
					nGetMVolume 	:= 0
					cGetMCliente 	:= ""
					cGetMLoja  		:= ""
					cGetMNome  		:= ""
					nRecNoSZB		:= 0

				Else

					Aviso( "Atenção", "A Nota informada não foi encontrada.", { "Voltar" } )

				EndIf

			Else

				Aviso( "Atenção", "A Nota informada não foi encontrada na Minuta.", { "Voltar" } )

			EndIf

		EndIf

	Else

		Aviso( "Atenção", "A Minuta já foi efetivada. Não poderá ser Alterada!", { "Voltar" } )

	EndIf

	RestArea( aAreaAntes )

Return


Static function FVldTdOk()

	Local aAreaAnt  := GetArea()
	Local lRetB     := .T.
	Local nZ 		:= 00

	lRetB := .F.
	For nZ := 01 To Len( aListNotas )

		If aListNotas[nZ][nPosMarcado]
			lRetB := .T.
			Exit
		EndIf

	Next nZ

	If !lRetB
		Aviso( "Atenção", "Para a criação de uma Minuta é necessário selecionar pelo menos uma Notas.", { "Voltar" } )
	EndIf

	If lRetB .And. AllTrim( cGetTransp ) == ""
		Aviso( "Atenção", "O Campo [ Transportadora ] é obrigatório.", { "Voltar" } )
		lRetB := .F.
	EndIf

	If lRetB .And. AllTrim( cGetMotorista ) == ""
		Aviso( "Atenção", "O Campo [ Nome do Motorista ] é obrigatório.", { "Voltar" } )
		lRetB := .F.
	EndIf

	If lRetB .And. AllTrim( cGetCNH ) == ""
		Aviso( "Atenção", "O Campo [ CNH ] é obrigatório.", { "Voltar" } )
		lRetB := .F.
	EndIf

	If lRetB .And. AllTrim( cGetPlaca ) == ""
		Aviso( "Atenção", "O Campo [ Placa ] é obrigatório.", { "Voltar" } )
		lRetB := .F.
	EndIf

	RestArea( aAreaAnt )

Return lRetB


User Function UNIA018E()


	If AllTrim( SZA->ZA_EFETIV ) == "N"

		If Aviso( "Atenção", "Você confirma a EFETIVAÇÃO da Minuta [" + SZA->ZA_CODIGO + "]?", { "Sim", "Não" } )  == 01

			DbSelectArea( "SZA" )
			RecLock( "SZA", .F. )
			SZA->ZA_EFETIV := "S"
			SZA->( MsUnLock() )

		EndIf

	Else

		Aviso( "Atenção", "A Minuta já foi efetivada!", { "Voltar" } )

	EndIf
Return


User Function UNIA018C()

	Private cGetCNH    := SZA->ZA_REGCNH
	Private cGetCodigo := SZA->ZA_CODIGO
	Private cGetMotori := SZA->ZA_MOTORIS
	Private cGetPlaca  := SZA->ZA_PLACA
	Private cGetTransp := SZA->ZA_TRANSP
	Private cGetDescTr := Posicione( "SA4", 01, XFilial( "SA4" ) + SZA->ZA_TRANSP, "A4_NOME" )
	Private dGetDtMinu := SZA->ZA_DATA
	Private nGetQtdNot := 0
	Private nGetTotPes := 0
	Private nGetTotVol := 0

	Private oOk       	:= LoadBitmap( GetResources() , "LBOK" 		  ) // Marcado
	Private oNo       	:= LoadBitmap( GetResources() , "LBNO" 		  ) // Desmarcado
	Private oVerde      := LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
	Private oVermelho   := LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho

	Private aTitListNotas		:= {}
	Private aSizeListNotas 		:= {}
	Private aListNotas          := {}
	Private bLinesNotas			:= { || }

	Private nPosMarcado			:= 01
	Private nPosEnviado			:= 02
	Private nPosFilial			:= 03
	Private nPosPedido			:= 04
	Private nPosSerie			:= 05
	Private nPosNota			:= 06
	Private nPosTransp	 		:= 07
	Private nPosRazao			:= 08
	Private nPosCliente			:= 09
	Private nPosLoja			:= 10
	Private nPosNome			:= 11
	Private nPosUF				:= 12
	Private nPosPeso			:= 13
	Private nPosVolumes			:= 14
	Private nPosIdMagento		:= 15
	Private nPosInstancia		:= 16
	Private nPosRecSZB			:= 17
	Private nPosRecSC5			:= 18

	SetPrvt("oDlgConfMin","oSayF7","oGrpInfo","oSayCodigo","oSayTransp","oSayData","oSayNome","oGetCodigo")
	SetPrvt("oGetDescTransp","oGetDtMinuta","oGrpNotas","oListNotas","oGrpVeiculo","oSayMotorista","oSayCNH")
	SetPrvt("oSayQtdNotas","oSayTotPeso","oGetMotorista","oGetCNH","oGetPlaca","oGetQtdNotas","oGetTotPeso")
	SetPrvt("oBtnFechar","oSayTotVolume","oGetTotVolume")

	If AllTrim( SZA->ZA_EFETIV ) == "N"
		Aviso( "Atenção", "A Minuta selecionada ainda não foi Efetivada.", { "Voltar" } )
	EndIf

	Processa( { || FCarregaMinuta() }, "Carregando Notas, aguarde...", "Carregando Notas, aguarde..." )

	oDlgConfMi 				:= MSDialog():New( 120,254,702,1228,"Conferência da Minuta",,,.F.,,,,,,.T.,,,.F. )
	oSayF7     				:= TSay():New( 036,427,{||"<F7> = Pesquisar"},oDlgConfMin,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,049,008)

	oGrpInfo   				:= TGroup():New( 002,007,038,416," Informações da Minuta ",oDlgConfMin,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayCodigo 				:= TSay():New( 013,016,{||"Código:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetCodigo 				:= TGet():New( 022,016,,oGrpInfo,039,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCodigo",,)
	oGetCodigo:bSetGet 		:= {|u| If(PCount()>0,cGetCodigo:=u,cGetCodigo)}
	oGetCodigo:bWhen 		:= { || .F. }

	oSayTransp 				:= TSay():New( 013,068,{||"Transportadora: "},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,041,008)
	oGetTransp 				:= TGet():New( 022,068,,oGrpInfo,041,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA4","cGetTransp",,)
	oGetTransp:bSetGet 		:= {|u| If(PCount()>0,cGetTransp:=u,cGetTransp)}
	oGetTransp:bWhen 		:= { || .F. }

	oSayNome   				:= TSay():New( 013,116,{||"Nome:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,021,008)
	oGetDescTransp			:= TGet():New( 022,116,,oGrpInfo,192,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDescTransp",,)
	oGetDescTransp:bSetGet 	:= {|u| If(PCount()>0,cGetDescTransp:=u,cGetDescTransp)}
	oGetDescTransp:bWhen 	:= { || .F. }

	oSayData   				:= TSay():New( 013,316,{||"Data:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,017,008)
	oGetDtMinuta			:= TGet():New( 022,316,,oGrpInfo,039,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetDtMinuta",,)
	oGetDtMinuta:bSetGet 	:= {|u| If(PCount()>0,dGetDtMinuta:=u,dGetDtMinuta)}
	oGetDtMinuta:bWhen 		:= { || .F. }

	oGrpNotas  				:= TGroup():New( 045,007,232,473," Notas para a Conferência da Minuta ",oDlgConfMin,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListNotas 			:= {}
	aSizeListNotas 			:= {}

	aAdd( aTitListNotas , "" 			)
	aAdd( aSizeListNotas, GetTextWidth( 0, "B"	 	 ) )
	aAdd( aTitListNotas , "" 			)
	aAdd( aSizeListNotas, GetTextWidth( 0, "B" 		 ) )
	aAdd( aTitListNotas , "FILIAL" 		)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListNotas , "PEDIDO" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListNotas , "SERIE" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListNotas , "NOTA" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB"	 ) )
	aAdd( aTitListNotas , "TRANSP." 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBB"	 ) )
	aAdd( aTitListNotas , "NOME" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBBBBBBBBBBB"	 ) )
	aAdd( aTitListNotas , "CLIENTE" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB"	 ) )
	aAdd( aTitListNotas , "LOJA" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BB"	 	 ) )
	aAdd( aTitListNotas , "NOME" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBBBBBBBBBBB"	 ) )
	aAdd( aTitListNotas , "UF" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BB"	 	 ) )
	aAdd( aTitListNotas , "PESO" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB"	 ) )
	aAdd( aTitListNotas , "VOLUMES" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBBB"	 ) )
	aAdd( aTitListNotas , "PEDIDO EC" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB" 	 ) )
	aAdd( aTitListNotas , "INSTANCIA" 	)
	aAdd( aSizeListNotas, GetTextWidth( 0, "BBBBB" 	 ) )

	//oListNotas 				:= TListBox():New( 058,015,,,452,168,,oGrpNotas,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListNotas 				:= TwBrowse():New( 058, 015, 452, 168,, aTitListNotas, aSizeListNotas, oGrpNotas,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListNotas:SetArray( aListNotas )
	bLinesNotas				:= { || { 	If( aListNotas[oListNotas:nAt][nPosMarcado], oOk, oNo )				  	,; // Marcado
		If( AllTrim( aListNotas[oListNotas:nAt][nPosEnviado] ) == "S", oVerde, oVermelho )	  	,; // Legenda
		AllTrim( aListNotas[oListNotas:nAt][nPosFilial] ) 						  	,; // Filial
		AllTrim( aListNotas[oListNotas:nAt][nPosPedido] ) 						  	,; // Filial
		AllTrim( aListNotas[oListNotas:nAt][nPosSerie] ) 						  	,; // Série
		AllTrim( aListNotas[oListNotas:nAt][nPosNota] ) 						  		,; // Nota
		AllTrim( aListNotas[oListNotas:nAt][nPosTransp] ) 						  	,; // Transportadora
		AllTrim( aListNotas[oListNotas:nAt][nPosRazao] ) 						  	,; // Razão Social
		AllTrim( aListNotas[oListNotas:nAt][nPosCliente] ) 						  	,; // Cliente
		AllTrim( aListNotas[oListNotas:nAt][nPosLoja] ) 						  		,; // Loja
		AllTrim( aListNotas[oListNotas:nAt][nPosNome] ) 						  		,; // Nome
		AllTrim( aListNotas[oListNotas:nAt][nPosUF] ) 						  		,; // UF
		AllTrim( TransForm( aListNotas[oListNotas:nAt][nPosPeso]	, "@E 999,999,999.99" ) ) 	,; // Peso
		AllTrim( TransForm( aListNotas[oListNotas:nAt][nPosVolumes]	, "@E 999,999,999.99" ) ) 	,; // Volumes
		AllTrim( aListNotas[oListNotas:nAt][nPosIdMagento] ) 						  	,; // Pedido E-Commerce
		AllTrim( aListNotas[oListNotas:nAt][nPosInstancia] ) 						}} // Instância

	oListNotas:bLine 	   	:= bLinesNotas
	oListNotas:bLDblClick 	:= { || FSeleciona( oListNotas, @aListNotas, nPosNota, nPosMarcado, nPosEnviado		 , .T., .T., 02 ) }
	oListNotas:bHeaderClick := { || FSelectAll( oListNotas, @aListNotas, nPosNota, nPosMarcado, @lMarcaMDesmarca , .T. ) }
	oListNotas:Refresh()

	oGrpVeiculo				:= TGroup():New( 238,007,277,473," Informações do Veículo / Condutor ",oDlgConfMin,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oSayMotorista 			:= TSay():New( 249,015,{||"Motorista:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
	oGetMotorista 			:= TGet():New( 258,015,,oGrpVeiculo,144,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetMotorista",,)
	oGetMotorista:bSetGet 	:= {|u| If(PCount()>0,cGetMotorista:=u,cGetMotorista)}
	oGetMotorista:bWhen 	:= { || .F. }

	oSayCNH    				:= TSay():New( 249,163,{||"Reg. CNH:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
	oGetCNH    				:= TGet():New( 258,163,,oGrpVeiculo,066,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCNH",,)
	oGetCNH:bSetGet 		:= {|u| If(PCount()>0,cGetCNH:=u,cGetCNH)}
	oGetCNH:bWhen 			:= { || .F. }

	oSayPlaca  				:= TSay():New( 249,233,{||"Placa:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
	oGetPlaca  				:= TGet():New( 258,233,,oGrpVeiculo,066,008,'@R !!!-!!!!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPlaca",,)
	oGetPlaca:bSetGet 		:= {|u| If(PCount()>0,cGetPlaca:=u,cGetPlaca)}
	oGetPlaca:bWhen 		:= { || .F. }

	oSayQtdNotas			:= TSay():New( 249,307,{||"Qtd. Notas:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,011)
	oGetQtdNotas			:= TGet():New( 258,307,,oGrpVeiculo,049,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetQtdNotas",,)
	oGetQtdNotas:bSetGet 	:= {|u| If(PCount()>0,nGetQtdNotas:=u,nGetQtdNotas)}
	oGetQtdNotas:bWhen 		:= { || .F. }

	oSayTotPeso 			:= TSay():New( 249,364,{||"Peso Total:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
	oGetTotPeso 			:= TGet():New( 258,364,,oGrpVeiculo,049,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetTotPeso",,)
	oGetTotPeso:bSetGet 	:= {|u| If(PCount()>0,nGetTotPeso:=u,nGetTotPeso)}
	oGetTotPeso:bWhen 		:= { || .F. }

	oSayTotVolume 			:= TSay():New( 249,419,{||"Volume Total:"},oGrpVeiculo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
	oGetTotVolume 			:= TGet():New( 258,419,,oGrpVeiculo,049,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetTotVolume",,)
	oGetTotVolume:bSetGet 	:= {|u| If(PCount()>0,nGetTotVolume:=u,nGetTotVolume)}
	oGetTotVolume:bWhen 	:= { || .F. }

	oBtnConfirmar 			:= TButton():New( 004,424,"Confirmar",oDlgConfMin,,052,012,,,,.T.,,"",,,,.F. )
	oBtnConfirmar:bAction 	:= { || Processa( { || FConfirma() }, "Aguarde..." ) }

	oBtnFechar 				:= TButton():New( 018,424,"Fechar",oDlgConfMin,,052,012,,,,.T.,,"",,,,.F. )
	oBtnFechar:bAction := { || oDlgConfMin:End() }

	oDlgConfMin:Activate(,,,.T.)

Return


User Function UNIA018X()


	If AllTrim( SZA->ZA_EFETIV ) == "N"

		If Aviso( "Atenção", "Você Confirma a Exclusão da Minuta [" + SZA->ZA_CODIGO + "]?", { "Sim", "Não" } ) == 01

			MsgRun( "Excluindo Minuta, aguarde...", "Excluindo Minuta, aguarde...", { || FExcluiMinuta() } )
			Aviso( "Atenção", "Minuta excluída com sucesso!", { "Ok" } )

		EndIf

	Else

		Aviso( "Atenção", "A Minuta já foi efetivada. Não poderá ser excluída!", { "Voltar" } )

	EndIf

Return

*-----------------------------*
Static Function FExcluiMinuta()
	*-----------------------------*

	DbSelectArea( "SZB" )
	DbSetOrder( 01 )
	Seek XFilial( "SZB" ) + SZA->ZA_CODIGO
	Do While !SZB->( Eof() ) .And. ;
			AllTrim( SZB->ZB_FILIAL ) == AllTrim( XFilial( "SZB" ) ) .And. ;
			AllTrim( SZB->ZB_CODIGO ) == AllTrim( SZA->ZA_CODIGO )

		DbSelectArea( "SZB" )
		RecLock( "SZB", .F. )
		SZB->( DbDelete() )
		SZB->( MsUnLock() )

		DbSelectArea( "SF2" )
		DbSetOrder( 01 ) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
		Seek SZB->( ZB_FILNOTA + ZB_NUMNOTA + ZB_SERNOTA + ZB_CLINOTA + ZB_LOJNOTA )
		If Found()

			DbSelectArea( "SF2" )
			RecLock( "SF2", .F. )
			SF2->F2_TRANSP  := ""
			SF2->F2_XMINUTA := ""
			SF2->( MsUnLock() )

		EndIf

		DbSelectArea( "SZB" )
		SZB->( DbSkip() )
	EndDo

	DbSelectArea( "SZA" )
	RecLock( "SZA", .F. )
	SZA->( DbDelete() )
	SZA->( MsUnLock() )

Return


Static Function FCarregaMinuta()

	Local aAreaAnt 	:= GetArea()
	aListNotas 		:= {}

	nContador  		:= 0
	cAuxTransp 		:= Posicione( "SA4", 01, XFilial( "SA4" ) +  SZA->ZA_TRANSP, "A4_NOME" )
	DbSelectArea( "SZB" )
	DbSetOrder( 01 )
	Seek XFilial( "SZB" ) + SZA->ZA_CODIGO
	Do While !SZB->( Eof() ) .And. ;
			AllTrim( SZB->ZB_FILIAL ) == AllTrim( XFilial( "SZB" ) ) .And. ;
			AllTrim( SZB->ZB_CODIGO ) == AllTrim( SZA->ZA_CODIGO   )

		aRetPedido := {}
		aRetPedido := FRetPedido( SZB->ZB_FILNOTA, SZB->ZB_NUMNOTA, SZB->ZB_SERNOTA, SZB->ZB_CLINOTA, SZB->ZB_LOJNOTA )

		cAuxNome := Posicione( "SA1", 01, XFilial( "SA1" ) +  SZB->( ZB_CLINOTA + ZB_LOJNOTA ), "A1_NOME" )
		cAuxUF	 := Posicione( "SA1", 01, XFilial( "SA1" ) +  SZB->( ZB_CLINOTA + ZB_LOJNOTA ), "A1_EST"  )
		aAuxLinha := {}
		aAdd( aAuxLinha, .F.   				) // 01- Marcado
		aAdd( aAuxLinha, SZB->ZB_ENVIADO  	) // 02
		aAdd( aAuxLinha, SZB->ZB_FILNOTA  	) // 03
		aAdd( aAuxLinha, aRetPedido[01]		) // 04
		aAdd( aAuxLinha, SZB->ZB_SERNOTA   	) // 05
		aAdd( aAuxLinha, SZB->ZB_NUMNOTA   	) // 06
		aAdd( aAuxLinha, SZA->ZA_TRANSP  	) // 07
		aAdd( aAuxLinha, cAuxTransp			) // 08
		aAdd( aAuxLinha, SZB->ZB_CLINOTA  	) // 09
		aAdd( aAuxLinha, SZB->ZB_LOJNOTA   	) // 10
		aAdd( aAuxLinha, cAuxNome    		) // 11
		aAdd( aAuxLinha, cAuxUF				) // 12
		aAdd( aAuxLinha, SZB->ZB_PESNOTA 	) //13
		aAdd( aAuxLinha, SZB->ZB_VOLNOTA 	) // 14
		aAdd( aAuxLinha, aRetPedido[02]		) // 15
		aAdd( aAuxLinha, aRetPedido[03]		) // 16
		aAdd( aAuxLinha, SZB->( RecNo() )	) // 17
		aAdd( aAuxLinha, aRetPedido[04]		) // 18
		aAdd( aListNotas, aAuxLinha )

		DbSelectArea( "SZB" )
		SZB->( DbSkip() )
	EndDo

	If Len( aListNotas ) == 0

		aAuxLinha := {}
		aAdd( aAuxLinha, .F.    ) // 01- Marcado
		aAdd( aAuxLinha, ""  	) // 02
		aAdd( aAuxLinha, ""  	) // 03
		aAdd( aAuxLinha, ""		) // 04
		aAdd( aAuxLinha, ""   	) // 05
		aAdd( aAuxLinha, ""   	) // 06
		aAdd( aAuxLinha, ""  	) // 07
		aAdd( aAuxLinha, ""		) // 08
		aAdd( aAuxLinha, ""  	) // 09
		aAdd( aAuxLinha, ""   	) // 10
		aAdd( aAuxLinha, ""		) // 11
		aAdd( aAuxLinha, ""		) // 12
		aAdd( aAuxLinha, 0 		) // 13
		aAdd( aAuxLinha, 0 		) // 14
		aAdd( aAuxLinha, ""		) // 15
		aAdd( aAuxLinha, ""		) // 16
		aAdd( aAuxLinha, 0 		) // 17
		aAdd( aAuxLinha, 0		) // 18
		aAdd( aListNotas, aAuxLinha )

	EndIf
	RestArea( aAreaAnt )

Return


*-------------------------*
Static Function FConfirma()
	*-------------------------*
	Local aAreaAnt := GetArea()
	Local aAreaSZB := SZB->( GetArea() )
	Local nF 		:= 00
	Local lAmarelo 	:= .F.
	Local nQtdNotas := Len( aListNotas )

	If Aviso( "Atenção", "Você confirma a Coleta das Notas selecionadas da Minuta?", { "Sim", "Não" } ) == 01

		DbSelectArea( "SZB" )
		DbSetOrder( 01 )
		SZB->( DbGoTop() )
		For nF := 01 To Len( aListNotas )

			If ( aListNotas[nF][nPosMarcado] .Or. aListNotas[nF][nPosEnviado] == "S" )
				nQtdNotas--
			EndIf

			If ( aListNotas[nF][nPosMarcado] .And. aListNotas[nF][nPosEnviado] != "S" )

				If aListNotas[nF][nPosRecSZB] > 0

					DbSelectArea( "SZB" )
					SZB->( DbGoTo( aListNotas[nF][nPosRecSZB] ) )
					RecLock( "SZB", .F. )
					SZB->ZB_ENVIADO	:= "S"
					SZB->( MsUnLock() )

				EndIf

				If aListNotas[nF][nPosRecSC5] > 0

					DbSelectArea( "SC5" )
					SC5->( DbGoTo( aListNotas[nF][nPosRecSC5] ) )
					RecLock( "SC5", .F. )
					SC5->C5_XDTCOLE := Date()
					SZB->( MsUnLock() )

				EndIf

				lAmarelo := .T.
				aListNotas[nF][nPosEnviado] := "S"

			EndIf

		Next nF

		If lAmarelo

			//Fecha a Minuta
			DbSelectArea( "SZA" )
			RecLock( "SZA", .F. )

			If nQtdNotas == 0
				SZA->ZA_EFETIV := "F"
			Else
				SZA->ZA_EFETIV := "P"
			EndIf

			SZA->( MsUnLock() )

		EndIf

	EndIf

	RestArea( aAreaSZB )
	RestArea( aAreaAnt )

Return


*--------------------------------------------------------------------------------------------*
Static Function FRetPedido( cParamFilial, cParamNota, cParamSerie, cParamCliente, cParamLoja )
	*--------------------------------------------------------------------------------------------*
	Local aAreaAnt 	 := GetArea()
	Local cAliasPed  := GetNextAlias()
	Local cQuery 	 := ""
	Local aRetPedido := { "", "", "", 0 } // Pedido, Id Magento e Id Instância

	cQuery := "		  SELECT C5_NUM, C5_XIDMAGE, C5_XCODSZ8, R_E_C_N_O_ AS NUMRECSC5 "
	cQuery += "			FROM " + ReTSQLName( "SC5" )
	cQuery += "		   WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		     AND C5_FILIAL  = '" + cParamFilial  + "' "
	cQuery += "		     AND C5_NOTA    = '" + cParamNota    + "' "
	cQuery += "		     AND C5_SERIE   = '" + cParamSerie   + "' "
	cQuery += "		     AND C5_CLIENTE = '" + cParamCliente + "' "
	cQuery += "		     AND C5_LOJACLI = '" + cParamLoja  	 + "' "
	If Select( cAliasPed ) > 0
		( cAliasPed )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasPed ) New
	If !( cAliasPed )->( Eof() )
		aRetPedido[01] := ( cAliasPed )->C5_NUM
		aRetPedido[02] := ( cAliasPed )->C5_XIDMAGE
		aRetPedido[03] := ( cAliasPed )->C5_XCODSZ8
		aRetPedido[04] := ( cAliasPed )->NUMRECSC5
	EndIf
	( cAliasPed )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return aRetPedido