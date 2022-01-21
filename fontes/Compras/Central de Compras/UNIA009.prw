
/*/{Protheus.doc} UNIA009

@project Central de Compras
@description Rotina customizada de Central de Compras conforme definido junto com o Cliente
@author Rafael Rezende
@since 20/06/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"

User Function UNIA009TST()

	RPCSetEnv( "01", "0207" )

	U_UNIA009()

	RPCClearEnv()

Return

*---------------------*
User Function UNIA009()
	*---------------------*
	Private cGetTabela	 		:= PadR( AllTrim( GetNewPar( "MV_XTABPAD", "001" ) ), TamSX3( "DA1_CODTAB" )[01] )
	Private cGetDesGrupo	 	:= ""
	Private cGetDesCategoria	:= ""
	Private cGetDesLinha 		:= ""
	Private cGetDesFabricante 	:= ""
	Private cGetDesProduto 		:= ""
	Private cGetDesTabela		:= ""
	Private dGetDtInicial 		:= CToD( "01/01/2019" ) //CToD( "  /  /    " )
	Private dGetDtFinal  		:= CToD( "31/12/2019" ) //CToD( "  /  /    " )
	Private aListEmpFil			:= {}
	Private aTitListEmpFil 		:= {}
	Private aSizeListEmpFil 	:= {}
	Private bLinesEmpFil		:= { || }
	Private oOk       			:= LoadBitmap( GetResources() , "LBOK" 		  ) // Marcado
	Private oNo       			:= LoadBitmap( GetResources() , "LBNO" 		  ) // Desmarcado
	Private oVerde      		:= LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
	Private oVermelho   		:= LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho
	Private lMarcaDesmarca 		:= .F.
	Private lMarcaPDesmarca		:= .F.

	Private nPosMarcado			:= 01
	Private nPosEmpresa			:= 02
	Private nPosFilial			:= 03
	Private nPosNomeEmp			:= 04
	Private nPosNomeFil			:= 05

	//Adequação com a Rotina Padrão MATA120
	Private aBackSC7   	:= {}
	Private aAutoCab   	:= {}
	Private aAutoItens	:= {}
	Private aRatCTBPC  	:= {}
	Private aAdtPC     	:= {}
	Private aRatProj   	:= {}

	Private INCLUI 		:= .T.
	Private ALTERA 		:= .F.
	Private nAutoAdt   	:= 0 //If(nOpcAuto <> NIL,nOpcAuto,0)
	Private nTipoPed   	:= 1 //nFuncao // 1 - Ped. Compra 2 - Aut. Entrega
	Private cCadastro  	:= "Pedidos de Compra" //If(nTipoPed == 2 , STR0004 , If(cPaisLoc == "VEN" , STR0093 , STR0005 ))	//"Autorizacao de Entrega"#"Requisicoes de Compra"(Ven)#"Pedidos de Compra"
	Private l120Auto   	:= .T. // ValType(xAutoCab)=="A" .And. ValType(xAutoItens) == "A"
	Private lPedido    	:= .T.
	Private lGatilha   	:= .T.                          // Para preencher aCols em funcoes chamadas da validacao (X3_VALID)
	Private lVldHead   	:= GetNewPar( "MV_VLDHEAD",.T. )// O parametro MV_VLDHEAD e' usado para validar ou nao o aCols (uma linha ou todo), a partir das validacoes do aHeader -> VldHead()

	Private aImpIB2		:= {}
	Private aImpCCO		:= {}
	Private aImpSFC		:= {}
	Private aImpSFF		:= {}
	Private aImpSFH		:= {}
	Private aImpLivr	:= {}
	Private aTesMXF		:= {}

	Private aRotina 	:= {}
	aAdd(aRotina, { "Pesquisar"	, "PesqBrw"   , 0, 1, 0, .F. } )
	aAdd(aRotina, { "Visualizar", "A120Pedido", 0, 2, 0, Nil } )
	aAdd(aRotina, { "Incluir"	, "A120Pedido", 0, 3, 0, Nil } )
	aAdd(aRotina, { "Alterar"	, "A120Pedido", 0, 4, 6, Nil } )

	SetPrvt( "oDlgCentral","oGrpEmpFil","oBtnConfirm","oBtnSair","oListEmpFil","oGrpFiltro","oSayDtInicial" )
	SetPrvt( "oSayDtFinal","oGetDtFinal","oSayGrupo","oGetGrupo","oGetDesGrupo","oSayDesGrupo","oSayCategoria" )
	SetPrvt( "oSayDesCategoria","oGetDesCategoria","oSayLinha","oSayDesLinha","oGetDesLinha","oGetLinha","oSayFabricante" )
	SetPrvt( "oSayDesFabricante","oGetDesFabricante","oSayProduto","oGetProduto","oSayDesProduto","oGetDesProduto" )

	// Variáveis utilizadas nas Consultas padrões "CENSZ1", "CENSZ2", "CENSB1"
	Public cGetCDepartamento	:= Space( TamSX3( "BM_GRUPO"   )[01] )
	Public cGetCCategoria	 	:= Space( TamSX3( "Z1_CATEGOR" )[01] )
	Public cGetCLinha  			:= Space( TamSX3( "Z2_LINHA"   )[01] )
	Public cGetCFabricante	 	:= Space( TamSX3( "Z3_CODIGO"  )[01] )
	Public cGetCProduto 		:= Space( TamSX3( "B1_COD"     )[01] )

	MsgRun( "Carregando Cadastro de Empresas, aguarde...", "Carregando Cadastro de Empresas, aguarde...", { || FCarregaEmpFil() } )


	oDlgCentra 					:= MSDialog():New( 122,241,679,1131,"Central de Compras",,,.F.,,,,,,.T.,,,.F. )

	oGrpEmpFil 					:= TGroup():New( 004,010,086,382," Empresa / Filial ",oDlgCentral,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	//oListEmpFil				:= TListBox():New( 014,017,,,355,065,,oGrpEmpFil,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	aTitListEmpFil 	:= {}
	aSizeListEmpFil := {}

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
	bLinesEmpFil				:= { || { 	If( aListEmpFil[oListEmpFil:nAt][nPosMarcado], oOk, oNo )	,; // Marcado
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosEmpresa] ) 			,; // Empresa
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosFilial]  ) 			,; // Filial
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosNomeEmp] ) 			,; // Nome Empresa
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosNomeFil] ) 			}} // Nome Filial
	oListEmpFil:bLine 	   		:= bLinesEmpFil
	oListEmpFil:bLDblClick 		:= { || FSeleciona( oListEmpFil, @aListEmpFil, nPosFilial, nPosMarcado ) }
	oListEmpFil:bHeaderClick 	:= { || FSelectAll( oListEmpFil, @aListEmpFil, nPosFilial, nPosMarcado, @lMarcaDesmarca ) }
	oListEmpFil:Refresh()

	oGrpFiltro 					:= TGroup():New( 092,010,265,382," Filtros ",oDlgCentral,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayDtInicial 				:= TSay():New( 104,018,{||"Data Inicial:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetDtInicial 				:= TGet():New( 112,018,,oGrpFiltro,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetDtInicial",,)
	oGetDtInicial:bSetGet	 	:= {|u| If(PCount()>0,dGetDtInicial:=u,dGetDtInicial)}

	oSayDtFinal 				:= TSay():New( 104,082,{||"Data Final:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oGetDtFinal 				:= TGet():New( 112,082,,oGrpFiltro,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetDtFinal",,)
	oGetDtFinal:bSetGet	 		:= {|u| If(PCount()>0,dGetDtFinal:=u,dGetDtFinal)}

	oSayGrupo  					:= TSay():New( 128,017,{||"Departamento:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
	oGetGrupo  					:= TGet():New( 136,017,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SBM","cGetCDepartamento",,)
	oGetGrupo:bSetGet	 		:= {|u| If(PCount()>0,cGetCDepartamento:=u,cGetCDepartamento)}
	oGetGrupo:bValid  			:= { || FVldCampo( "SBM" ) }

	oSayDesGrupo 				:= TSay():New( 128,080,{||"Descrição do Departamento:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,095,008)
	oGetDesGrupo 				:= TGet():New( 136,080,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesGrupo",,)
	oGetDesGrupo:bSetGet 		:= {|u| If(PCount()>0,cGetDesGrupo:=u,cGetDesGrupo)}
	oGetDesGrupo:bWhen 			:= { || .F. }

	oSayCategoria 				:= TSay():New( 150,018,{||"Categoria:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGetCategoria 				:= TGet():New( 158,018,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"CENSZ1","cGetCCategoria",,)
	oGetCategoria:bSetGet	 	:= {|u| If(PCount()>0,cGetCCategoria:=u,cGetCCategoria)}
	oGetCategoria:bValid  		:= { || FVldCampo( "SZ1" ) }

	oSayDesCategoria 			:= TSay():New( 150,081,{||"Descrição da Categoria:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,095,008)
	oGetDesCategoria 			:= TGet():New( 158,081,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesCategoria",,)
	oGetDesCategoria:bSetGet	:= {|u| If(PCount()>0,cGetDesCategoria:=u,cGetDesCategoria)}
	oGetDesCategoria:bWhen	 	:= { || .F. }

	oSayLinha  					:= TSay():New( 173,018,{||"Linha:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGetLinha  					:= TGet():New( 181,018,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"CENSZ2","cGetCLinha",,)
	oGetLinha:bSetGet	 		:= {|u| If(PCount()>0,cGetCLinha:=u,cGetCLinha)}
	oGetLinha:bValid  			:= { || FVldCampo( "SZ2" ) }

	oSayDesLinha 				:= TSay():New( 173,081,{||"Descrição da Linha:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,095,008)
	oGetDesLinha 				:= TGet():New( 181,081,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesLinha",,)
	oGetDesLinha:bSetGet	 	:= {|u| If(PCount()>0,cGetDesLinha:=u,cGetDesLinha)}
	oGetDesLinha:bWhen	 		:= { || .F. }

	oSayFabricv 				:= TSay():New( 196,018,{||"Fabricante:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGetFabricante 				:= TGet():New( 204,018,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SZ3","cGetCFabricante",,)
	oGetFabricante:bSetGet	 	:= {|u| If(PCount()>0,cGetCFabricante:=u,cGetCFabricante)}
	oGetFabricante:bValid  		:= { || FVldCampo( "SZ3" ) }

	oSayDesFabricante 			:= TSay():New( 196,081,{||"Descrição do Fabricante:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,095,008)
	oGetDesFabricante 			:= TGet():New( 204,081,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesFabricante",,)
	oGetDesFabricante:bSetGet 	:= {|u| If(PCount()>0,cGetDesFabricante:=u,cGetDesFabricante)}
	oGetDesFabricante:bWhen 	:= { || .F. }

	oSayProduto 				:= TSay():New( 219,018,{||"Produto:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGetProduto 				:= TGet():New( 227,018,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"CENSB1","cGetCProduto",,)
	oGetProduto:bSetGet 		:= {|u| If(PCount()>0,cGetCProduto:=u,cGetCProduto)}
	oGetProduto:bValid  		:= { || FVldCampo( "SB1" ) }

	oSayDesProduto 				:= TSay():New( 219,081,{||"Descrição do Produto:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,095,008)
	oGetDesProduto 				:= TGet():New( 227,081,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesProduto",,)
	oGetDesProduto:bSetGet 		:= {|u| If(PCount()>0,cGetDesProduto:=u,cGetDesProduto)}
	oGetDesProduto:bWhen 		:= { || .F. }

	oSayTabela 					:= TSay():New( 240,018,{||"Tabela de Preços:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
	oGetTabela 					:= TGet():New( 248,018,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"DA0","cGetTabela",,)
	oGetTabela:bSetGet 			:= {|u| If(PCount()>0,cGetTabela:=u,cGetTabela)}
	oGetTabela:bValid  			:= { || FVldCampo( "DA0" ) }

	oSayDesTabela 				:= TSay():New( 240,081,{||"Descrição da Tabela de Preços"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,094,008)
	oGetDesTabela 				:= TGet():New( 248,081,,oGrpFiltro,291,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesTabela",,)
	oGetDesTabela:bSetGet 		:= {|u| If(PCount()>0,cGetDesTabela:=u,cGetDesTabela)}
	oGetDesTabela:bWhen 		:= { || .F. }

	oBtnConfirm 				:= TButton():New( 008,388,"Confirmar",oDlgCentral,,045,012,,,,.T.,,"",,,,.F. )
	oBtnConfirm:bAction 		:= { || FPrincipal() }

	oBtnSair   					:= TButton():New( 024,388,"Sair",oDlgCentral,,045,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction	 		:= { || oDlgCentral:End() }

	If AllTrim( cGetTabela ) != ""
		FVldCampo( "DA0" )
		oGetDtInicial:SetFocus()
	EndIf

	oDlgCentral:Activate( ,,, .T. )

Return

*--------------------------------------*
Static Function FVldCampo( cParamOpcao )
	*--------------------------------------*
	Local lRetA := .T.

	Do Case
		Case cParamOpcao == "SBM" // Grupo

			If AllTrim( cGetCDepartamento ) != ""

				DbSelectArea( "SBM" )
				DbSetOrder( 01 ) // BM_FILIAL + BM_COD
				Seek XFilial( "SBM" ) + cGetCDepartamento
				If Found()
					cGetDesGrupo := SBM->BM_DESC
				Else
					Aviso( "Atenção", "O Departamento informado não pode ser encontrado.", { "Voltar" } )
					lRetA 		 := .F.
					cGetDesGrupo := ""
				EndIf
			Else
				cGetDesGrupo := ""
			EndIf

		Case cParamOpcao == "SZ1" // Categoria

			If AllTrim( cGetCCategoria ) != ""

				DbSelectArea( "SZ1" )
				DbSetOrder( 01 ) // Z1_FILIAL + Z1_CATEGOR
				Seek XFilial( "SZ1" ) + cGetCCategoria
				If Found()
					cGetDesCategoria 	:= SZ1->Z1_DESC
				Else
					Aviso( "Atenção", "A Categoria informada não pode ser encontrada.", { "Voltar" } )
					lRetA 		 		:= .F.
					cGetDesCategoria 	:= ""
				EndIf

			Else
				cGetDesCategoria := ""
			EndIf

		Case cParamOpcao == "SZ2" // Linha

			If AllTrim( cGetCLinha ) != ""

				DbSelectArea( "SZ2" )
				DbSetOrder( 01 ) // Z2_FILIAL + Z2_LINHA
				Seek XFilial( "SZ2" ) + cGetCLinha
				If Found()
					cGetDesLinha 	:= SZ2->Z2_DESC
				Else
					Aviso( "Atenção", "A Linha informada não pode ser encontrada.", { "Voltar" } )
					lRetA 		 		:= .F.
					cGetDesLinha 		:= ""
				EndIf

			Else
				cGetDesLinha := ""
			EndIf

		Case cParamOpcao == "SZ3" // Fabricante

			If AllTrim( cGetCFabricante ) != ""

				DbSelectArea( "SZ3" )
				DbSetOrder( 01 ) // Z3_FILIAL + Z3_CODIGO
				Seek XFilial( "SZ3" ) + cGetCFabricante
				If Found()
					cGetDesFabricante 	:= SZ3->Z3_DESCRIC
				Else
					Aviso( "Atenção", "O Fabricante informado não pode ser encontrado.", { "Voltar" } )
					lRetA 		 		:= .F.
					cGetDesFabricante	:= ""
				EndIf

			Else
				cGetDesFabricante := ""
			EndIf

		Case cParamOpcao == "SB1" // Produto

			If AllTrim( cGetCProduto ) != ""

				DbSelectArea( "SB1" )
				DbSetOrder( 01 ) // B1_FILIAL + B1_COD
				Seek XFilial( "SB1" ) + cGetCProduto
				If Found()
					cGetDesProduto 	:= SB1->B1_DESC
				Else
					Aviso( "Atenção", "O Produto informado não pode ser encontrado.", { "Voltar" } )
					lRetA 		 	:= .F.
					cGetDesProduto	:= ""
				EndIf

			Else
				cGetDesProduto := ""
			EndIf

		Case cParamOpcao == "DA0" // Tabela de Preços

			If AllTrim( cGetTabela ) != ""

				DbSelectArea( "DA0" )
				DbSetOrder( 01 ) // DA0_FILIAL + DA0_CODTAB
				Seek XFilial( "DA0" ) + cGetTabela
				If Found()
					cGetDesTabela 	:= DA0->DA0_DESCRI
				Else
					Aviso( "Atenção", "A Tabela de Preços informada não pode ser encontrada.", { "Voltar" } )
					lRetA 		 	:= .F.
					cGetDesTabela	:= ""
				EndIf

			Else
				cGetDesTabela 		:= ""
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

*----------------------------------------------------------------------------------------------------------------------------------*
Static Function FSeleciona( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, nParamPosLegenda, lParamTemLegenda )
	*----------------------------------------------------------------------------------------------------------------------------------*
	Local nLinhaGrid 			:= oParamListObject:nAt
	Default nParamPosLegenda 	:= 0
	Default lParamTemLegenda    := .F.

	// Linha precisa ser maior que zero
	If nLinhaGrid == 0
		Return
	EndIf

	If Len( aParamListObject ) == 00
		Return
	EndIf

	If ( oParamListObject:nColPos == nParamPosLegenda .And. lParamTemLegenda )

		FLegenda()

	Else

		If Len( aParamListObject ) == 01 .And. nLinhaGrid == 01
			If AllTrim( aParamListObject[nLinhaGrid][nParamPosCpo] ) == ""
				Return
			EndIf
		EndIf
		aParamListObject[nLinhaGrid][nParamPosMarcado] := !aParamListObject[nLinhaGrid][nParamPosMarcado]
		oParamListObject:Refresh()

	EndIf

Return

*-------------------------------------------------------------------------------------------------------------------*
Static Function FSelectAll( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, lParamMarcaDesmarca )
	*-------------------------------------------------------------------------------------------------------------------*
	Local nY := 0

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

	oParamListObject:Refresh()

Return

*--------------------------*
Static Function FPrincipal()
	*--------------------------*
	Private cGetPDescProduto	:= ""
	Private cGetPProduto	 	:= ""
	Private cGetPTipo   		:= ""
	Private nGetPFator  		:= 0
	Private nGetPMaior 	 		:= 0
	Private nGetPMenor  		:= 0
	Private nGetPPrcVenda		:= 0
	Private nGetPUltima 		:= 0
	Private nGetPEmbalagem 		:= 0
	Private dGetPDtMaior 		:= CToD( "" )
	Private dGetPDtMenor 		:= CToD( "" )
	Private dGetPDtUltima	 	:= CToD( "" )

	Private nPosPMarcado		:= 01
	Private nPosPLegenda		:= 02
	Private nPosPProduto		:= 03
	Private nPosPDescricao		:= 04
	Private nPosPGrupo	 		:= 05
	Private nPosPCategoria		:= 06
	Private nPosPLinha			:= 07
	Private nPosPPreco			:= 08
	Private nPosPEstoque		:= 09
	Private nPosPEstTotal		:= 10
	Private nPosPPedidos		:= 11
	Private nPosPGiro			:= 12
	Private nPosPTipo			:= 13
	Private nPosPUM				:= 14
	Private nPosPArmazem		:= 15
	Private nPosPFator			:= 16
	Private nPosPUltima			:= 17
	Private nPosPMaior			:= 18
	Private nPosPMenor			:= 19
	Private nPosPEmbalagem		:= 20
	Private nPosPDtUltima		:= 21
	Private nPosPDtMaior		:= 22
	Private nPosPDtMenor		:= 23
	//Private nPosPDescGrupo	:= 24
	//Private nPosPDescCateg	:= 25
	//Private nPosPDescLinha	:= 26

	Private nPosESMes			:= 01
	Private nPosESAno			:= 02
	Private nPosESEntradas		:= 03
	Private nPosESSaidas		:= 04
	Private nPosESNumMes		:= 05

	Private aListProdutos 		:= {}
	Private aTitListProdutos 	:= {}
	Private aSizeListProdutos	:= {}
	Private bLinesProdutos		:= { || }

	Private aListEntSai 		:= {}
	Private aTitListEntSai 		:= {}
	Private aSizeListEntSai		:= {}
	Private bLinesEntSai        := { || }

	If Empty( dGetDtInicial )
		Aviso( "Atenção", "O parâmetro [Data Inicial] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	If Empty( dGetDtFinal )
		Aviso( "Atenção", "O parâmetro [Data Final] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	If AllTrim( cGetTabela ) == ""
		Aviso( "Atenção", "O parâmetro [Tabela de Preços] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	If  AllTrim( cGetCDepartamento ) == "" .And. ;
			AllTrim( cGetCCategoria    ) == "" .And. ;
			AllTrim( cGetCLinha		   ) == "" .And. ;
			AllTrim( cGetCFabricante   ) == "" .And. ;
			AllTrim( cGetCProduto	   ) == ""

		If Aviso( "Atenção", "Você NÃO SELECIONOU FILTROS. Sua pesquisa irá retornar TODA A BASE DE PRODUTOS DE TODAS AS FILIAIS. Deseja prosseguir?", { "Sim", "Não" } ) == 02
			Return
		EndIf
	EndIf

	Processa( { || FCarregaProdutos() }, "Carregando informações, aguarde..." )

	SetPrvt( "oDlgPrincipal","oGrpProdutos","oBtnMenu","oListProdutos","oGrpInfo","oSayProduto","oSayPrcVenda" )
	SetPrvt( "oSayMenor","oSayMaior","oGetProduto","oGetDescProd","oGetPrcVenda","oGetUltima","oGetDtUltima" )
	SetPrvt( "oGetDtMenor","oGetMaior","oGetDtMaior","oGrpEntSai","oListEntSai","oGetTipo","oSayTipo","oSayFator" )
	SetPrvt( "oSayEmbalagem","oGetEmbalagem","oSayF7" )

	nMesIni := Month( dGetDtInicial )
	nMesFim := Month( dGetDtFinal   )
	nAnoIni := Year( dGetDtInicial  )
	nAnoFim := Year( dGetDtFinal    )

	If nAnoIni == nAnoFim
		nMesFim := Month( dGetDtFinal   )
	Else
		nMesFim := 12
	EndIf

	aListEntSai := {}

	cAuxMes := ""
	For nA := nAnoIni To nAnoFim

		If nA == nAnoFim
			nMesFim := Month( dGetDtFinal   )
		Else
			nMesFim := 12
		EndIf

		For nM := nMesIni To nMesFim

			Do Case
				Case nM == 01
					cAuxMes := "Janeiro"
				Case nM == 02
					cAuxMes := "Fevereiro"
				Case nM == 03
					cAuxMes := "Março"
				Case nM == 04
					cAuxMes := "Abril"
				Case nM == 05
					cAuxMes := "Maio"
				Case nM == 06
					cAuxMes := "Junho"
				Case nM == 07
					cAuxMes := "Julho"
				Case nM == 08
					cAuxMes := "Agosto"
				Case nM == 09
					cAuxMes := "Setembro"
				Case nM == 10
					cAuxMes := "Outubro"
				Case nM == 11
					cAuxMes := "Novembro"
				Case nM == 12
					cAuxMes := "Dezembro"
			EndCase

			aAdd( aListEntSai, { cAuxMes, nA, 0, 0, nM } )

		Next nM

		nMesIni := 01

	Next nA

	If Len( aListEntSai ) == 0
		aAdd( aListEntSai, { "", 0, 0, 0, 0 } )
	EndIf

	oDlgPrincipal 			:= MSDialog():New( 124,235,707,1360,"Central de Compras",,,.F.,,,,,,.T.,,,.F. )

	oGrpProduto 			:= TGroup():New( 000,007,189,548," Produtos ",oDlgPrincipal,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSayF7     				:= TSay()	:New( 007,414,{||"<F7>=Pesquisar na Grid"},oGrpProdutos,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,061,008)

	oMnuCentral				:= TMenu():New( 0, 0, 0, 0, .T., , oGrpProdutos )
	oMnuItem01 				:= TMenuItem():New( oMnuCentral, "Exportar Excel"				, , , 	 , {|| Processa( { || FExportaExcel() 	 }, "Exportando para Excel, aguarde..." ) }, , , , , , , , , .T.)
	oMnuItem02 				:= TMenuItem():New( oMnuCentral, "Gerar Pedido de Compras"		, , , 	 , {|| Processa( { || FGeraPedido() 	 }, "Gerando Pedido de Compras, aguarde..." ) }, , , , , , , , , .T.)
	oMnuItem03 				:= TMenuItem():New( oMnuCentral, "Consultar Pedido em Aberto"	, , , 	 , {|| Processa( { || FConsultaPedidos() }, "Consultando Pedidos em aberto, aguarde..." ) }, , , , , , , , , .T.)
	oMnuItem04 				:= TMenuItem():New( oMnuCentral, "Sair"							, , , 	 , {|| oDlgPrincipal:End() }, , , , , , , , , .T.)
	oMnuCentral:Add( oMnuItem01 )
	oMnuCentral:Add( oMnuItem02 )
	oMnuCentral:Add( oMnuItem03 )
	oMnuCentral:Add( oMnuItem04 )
	oBtnMenu   				:= TButton():New( 004,491,"Opções",oGrpProdutos,,053,010,,,,.T.,,"",,,,.F. )
	oBtnMenu:SetPopupMenu( oMnuCentral )

	aTitListProdutos 		:= {}
	aSizeListProdutos 		:= {}

	aAdd( aTitListProdutos , "" 			)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "B"	 	 ) )
	aAdd( aTitListProdutos , "" 			)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "B" 		 ) )
	aAdd( aTitListProdutos , "PRODUTO" 		)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBB" 		 ) )
	aAdd( aTitListProdutos , "DESCRIÇÃO" 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBBBBBBBBBBB" ) )
	aAdd( aTitListProdutos , "GRUPO" 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBB"		 ) )
	aAdd( aTitListProdutos , "CATEG." 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBB"		 ) )
	aAdd( aTitListProdutos , "LINHA" 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBB"		 ) )
	aAdd( aTitListProdutos , "PRC.VEN." 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBBBB"	 ) )
	aAdd( aTitListProdutos , "EST.FIL." 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBB"		 ) )
	aAdd( aTitListProdutos , "EST.TOT." 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBB"		 ) )
	aAdd( aTitListProdutos , "PED. AB" 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBB"		 ) )
	aAdd( aTitListProdutos , "GIRO" 	)
	aAdd( aSizeListProdutos, GetTextWidth( 0, "BBBBBB"		 ) )

	//oListProduto 			:= TListBox():New( 017,013,,,530,167,,oGrpProdutos,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListProduto 				:= TwBrowse():New( 017, 013, 530, 167,, aTitListProdutos, aSizeListProdutos, oGrpProdutos,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListProduto:SetArray( aListProduto )
	bLinesProdutos				:= { || { 	If( aListProduto[oListProduto:nAt][nPosPMarcado], oOk, oNo ),; // Marcado
		If( aListProduto[oListProduto:nAt][nPosPLegenda], oVerde, oVermelho ),; // Legenda
		AllTrim( aListProduto[oListProduto:nAt][nPosPProduto] ) 			,; // Produto
		AllTrim( aListProduto[oListProduto:nAt][nPosPDescricao]  ) 		,; // Descrição
		AllTrim( aListProduto[oListProduto:nAt][nPosPGrupo] ) 			,; // Grupo
		AllTrim( aListProduto[oListProduto:nAt][nPosPCategoria] ) 		,; // Categoria
		AllTrim( aListProduto[oListProduto:nAt][nPosPLinha] ) 			,; // Linha
		AllTrim( TransForm( aListProduto[oListProduto:nAt][nPosPPreco]	, "@E 999,999,999.99" ) ) ,; // Preço
		AllTrim( TransForm( aListProduto[oListProduto:nAt][nPosPEstoque] , "@E 999,999,999.99" ) ) ,; // Estoque
		AllTrim( TransForm( aListProduto[oListProduto:nAt][nPosPEstTotal], "@E 999,999,999.99" ) ) ,; // Estoque Total
		AllTrim( TransForm( aListProduto[oListProduto:nAt][nPosPPedidos] , "@E 999,999,999.99" ) ) ,; // Pedidos em Aberto
		AllTrim( TransForm( aListProduto[oListProduto:nAt][nPosPGiro]    , "@E 999,999,999.99" ) ) }} // Giro

	oListProduto:bLine 	   		:= bLinesProdutos

	oListProduto:bChange	 	:= { || FPChange() }
	oListProduto:bLDblClick 	:= { || FSeleciona( oListProduto, @aListProduto, nPosPProduto, nPosPMarcado, nPosPLegenda, .T. ) }
	oListProduto:bHeaderClick 	:= { || FSelectAll( oListProduto, @aListProduto, nPosPProduto, nPosPMarcado, @lMarcaPDesmarca ) }

	oListProduto:Refresh()

	oGrpInfo   				:= TGroup():New( 193,007,278,275," Informações do Produto ",oDlgPrincipal,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayPProduto 			:= TSay():New( 206,013,{||"Produto:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
	oGetPProduto 			:= TGet():New( 205,054,,oGrpInfo,060,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cGetPProduto",,)
	oGetPProduto:bSetGet 	:= {|u| If(PCount()>0,cGetPProduto:=u,cGetPProduto)}
	oGetPProduto:bWhen 		:= { || .F. }

	oGetPDescProd 			:= TGet():New( 205,120,,oGrpInfo,149,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cGetPDescProd",,)
	oGetPDescProd:bSetGet 	:= {|u| If(PCount()>0,cGetPDescProd:=u,cGetPDescProd)}
	oGetPDescProd:bWhen 	:= { || .F. }

	oSayPPrcVenda 			:= TSay():New( 221,013,{||"Prc. Venda:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
	oGetPPrcVenda 			:= TGet():New( 219,054,,oGrpInfo,069,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetPPrcVenda",,)
	oGetPPrcVenda:bSetGet	:= {|u| If(PCount()>0,nGetPPrcVenda:=u,nGetPPrcVenda)}
	oGetPPrcVenda:bWhen 	:= { || .F. }

	oSayPUltima 			:= TSay():New( 236,013,{||"Ult. Compra:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
	oGetPUltima 			:= TGet():New( 234,054,,oGrpInfo,069,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","nGetPUltima",,)
	oGetPUltima:bSetGet 	:= {|u| If(PCount()>0,nGetPUltima:=u,nGetPUltima)}
	oGetPUltima:bWhen 		:= { || .F. }

	oGetPDtUltima 			:= TGet():New( 234,128,,oGrpInfo,046,008,'@D',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","dGetPDtUltima",,)
	oGetPDtUltima:bSetGet 	:= {|u| If(PCount()>0,dGetPDtUltima:=u,dGetPDtUltima)}
	oGetPDtUltima:bWhen 	:= { || .F. }

	oSayPTipo   			:= TSay():New( 235,213,{||"Tipo:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetPTipo   			:= TGet():New( 234,245,,oGrpInfo,024,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPTipo",,)
	oGetPTipo:bSetGet 		:= {|u| If(PCount()>0,cGetPTipo:=u,cGetPTipo)}
	oGetPTipo:bWhen 		:= { || .F. }

	oSayPMenor  			:= TSay():New( 250,013,{||"Menor Compra:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
	oGetPMenor  			:= TGet():New( 248,054,,oGrpInfo,069,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","nGetPMenor",,)
	oGetPMenor:bSetGet 		:= {|u| If(PCount()>0,nGetPMenor:=u,nGetPMenor)}
	oGetPMenor:bWhen 		:= { || .F. }

	oGetPDtMenor			:= TGet():New( 248,128,,oGrpInfo,046,008,'@D',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","dGetPDtMenor",,)
	oGetPDtMenor:bSetGet 	:= {|u| If(PCount()>0,dGetPDtMenor:=u,dGetPDtMenor)}
	oGetPDtMenor:bWhen 		:= { || .F. }

	oSayPFator  			:= TSay():New( 250,213,{||"Fator:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetPFator  			:= TGet():New( 249,245,,oGrpInfo,024,008,'@E999,99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetPFator",,)
	oGetPFator:bSetGet 		:= {|u| If(PCount()>0,nGetPFator:=u,nGetPFator)}
	oGetPFator:bWhen 		:= { || .F. }

	oSayPMaior  			:= TSay():New( 264,013,{||"Maior Compra:"},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
	oGetPMaior  			:= TGet():New( 262,054,,oGrpInfo,069,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","nGetPMaior",,)
	oGetPMaior:bSetGet 		:= {|u| If(PCount()>0,nGetPMaior:=u,nGetPMaior)}
	oGetPMaior:bWhen 		:= { || .F. }

	oGetPDtMaior 			:= TGet():New( 262,128,,oGrpInfo,046,008,'@D',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","dGetPDtMaior",,)
	oGetPDtMaior:bSetGet 	:= {|u| If(PCount()>0,dGetPDtMaior:=u,dGetPDtMaior)}
	oGetPDtMaior:bWhen 		:= { || .F. }

	oSayPEmbalagem 			:= TSay():New( 263,213,{||"Qtd. Emb."},oGrpInfo,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetPEmbalagem 			:= TGet():New( 262,245,,oGrpInfo,024,008,'@E999,99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetPEmbalagem",,)
	oGetPEmbalagem:bSetGet 	:= {|u| If(PCount()>0,nGetPEmbalagem:=u,nGetPEmbalagem)}
	oGetPEmbalagem:bWhen 	:= { || .F. }

	oGrpEntSai 				:= TGroup():New( 193,281,278,548," Quantidades E / S ",oDlgPrincipal,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListEntSai 			:= {}
	aSizeListEntSai 		:= {}

	aAdd( aTitListEntSai , "MÊS" 			)
	aAdd( aSizeListEntSai, GetTextWidth( 0, "BBBBB"      ) )
	aAdd( aTitListEntSai , "ANO" 		)
	aAdd( aSizeListEntSai, GetTextWidth( 0, "BBBB" 	     ) )
	aAdd( aTitListEntSai , "ENTRADAS" 	)
	aAdd( aSizeListEntSai, GetTextWidth( 0, "BBBBBBBBBB" ) )
	aAdd( aTitListEntSai , "SAÍDAS" 	)
	aAdd( aSizeListEntSai, GetTextWidth( 0, "BBBBBBBBBB" ) )

	//oListEntSai 				:= TListBox():New( 205,288,,,254,067,,oGrpEntSai,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListEntSai 				:= TwBrowse():New( 205, 288, 254, 067,, aTitListEntSai, aSizeListEntSai, oGrpEntSai,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListEntSai:SetArray( aListEntSai )
	bLinesEntSai				:= { || { 	AllTrim( aListEntSai[oListEntSai:nAt][nPosESMes] ) 			,; // Mes
		AllTrim( Str( aListEntSai[oListEntSai:nAt][nPosESAno] ) )		,; // Ano
		AllTrim( TransForm( aListEntSai[oListEntSai:nAt][nPosESEntradas], "@E 999,999,999.99" ) ) 	,; // Entradas
		AllTrim( TransForm( aListEntSai[oListEntSai:nAt][nPosESSaidas]  , "@E 999,999,999.99" ) ) 	}} // Saídas
	oListEntSai:bLine 	   		:= bLinesEntSai
	oListEntSai:Refresh()

	FAtivaKeyPesq( oListProdutos, VK_F7 )
	oDlgPrincipal:Activate( ,,, .T. )
	FInativaKeyPesq( VK_F7 )

Return

*--------------------------------*
Static Function FCarregaProdutos()
	*--------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local cAliasQry := GetNextAlias()
	Local cQuery 	:= ""

	cQuery := " SELECT 	DISTINCT  	  "
	cQuery += "			B1_COD    	, "	// Codigo
	cQuery += "			B1_DESC   	, "	// Descricao
	cQuery += "			B1_TIPO   	, "	// Tipo
	cQuery += "			B1_UM     	, "	// Unidade
	cQuery += "			B1_LOCPAD 	, "	// Armazem Pad.
	cQuery += "			B1_GRUPO  	, "	// Grupo
	cQuery += "			BM_DESC     , " // Descrição Grupo
	cQuery += "			B1_CATEGOR 	, " // Categoria
	cQuery += "			Z1_DESC		, " // Descrição Categoria
	cQuery += "			B1_LINHA 	, " // Linha
	cQuery += "			Z2_DESC		, " // Descrição Linha
	cQuery += "			B1_PESO   	, "	// Peso Liquido
	cQuery += "			B1_CODBAR 	, "	// Cod Barras
	cQuery += "			B1_TS	 	, "	// Cod Barras
	cQuery += "			B1_MSBLQL 	, "	// Blq. de Tela
	cQuery += "			B1_QE       , " // Embalagem
	cQuery += "			B1_CUSTD	, " // Custo Standard
	cQuery += "			B1_PRV1		, " // Preço de Venda Standard
	cQuery += "			B1_CONV 	  " // Fator
	cQuery += "    FROM " + RetSQLName( "SB1" ) + " SB1, "
	cQuery += "			" + RetSQLName( "SBM" ) + " SBM, "
	cQuery += "	 		" + RetSQLName( "SZ1" ) + " SZ1, "
	cQuery += "	  		" + RetSQLName( "SZ2" ) + " SZ2  "
	cQuery += "	  WHERE SB1.D_E_L_E_T_   = ' '  "
	cQuery += "	    AND SBM.D_E_L_E_T_   = ' '  "
	cQuery += "	    AND SZ1.D_E_L_E_T_   = ' '  "
	cQuery += "	    AND SZ2.D_E_L_E_T_   = ' '  "
	cQuery += "	    AND SB1.B1_FILIAL    = '" + XFilial( "SB1" ) + "' "
	cQuery += "	    AND SBM.BM_FILIAL    = '" + XFilial( "SBM" ) + "' "
	cQuery += "	    AND SZ1.Z1_FILIAL    = '" + XFilial( "SZ1" ) + "' "
	cQuery += "	    AND SZ2.Z2_FILIAL    = '" + XFilial( "SZ2" ) + "' "
	cQuery += "	    AND B1_GRUPO 		 = BM_GRUPO    "
	cQuery += "	    AND B1_CATEGOR       = Z1_CATEGOR  "
	cQuery += "	    AND B1_LINHA	     = Z2_LINHA	   "
	If AllTrim( cGetCProduto ) != ""
		cQuery += "     AND B1_COD 	 	 = '" + cGetCProduto 	+ "' "
	EndIf
	If AllTrim( cGetCDepartamento ) != ""
		cQuery += "     AND B1_GRUPO  	 = '" + cGetCDepartamento 		+ "' "
	EndIf
	If AllTrim( cGetCCategoria ) != ""
		cQuery += "     AND B1_CATEGOR 	 = '" + cGetCCategoria 	+ "' "
	EndIf
	If AllTrim( cGetCLinha ) != ""
		cQuery += "     AND B1_LINHA 	 = '" + cGetCLinha 		+ "' "
	EndIf

	aListProdutos := {}
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
		aAuxLinha := {}
		aAdd( aAuxLinha, .F.   						) // 01-Marcado
		aAdd( aAuxLinha, 0   						) // 02-Legendado
		aAdd( aAuxLinha, ( cAliasQry )->B1_COD    	) // 03-Produto
		aAdd( aAuxLinha, ( cAliasQry )->B1_DESC   	) // 04-Descricao
		aAdd( aAuxLinha, ( cAliasQry )->B1_GRUPO  	) // 05-Grupo
		aAdd( aAuxLinha, ( cAliasQry )->B1_CATEGOR	) // 06-Categoria
		aAdd( aAuxLinha, ( cAliasQry )->B1_LINHA	) // 07-Linha
		aAdd( aAuxLinha, 0							) // 08-Preço --> B1_UPRC or   B1_CUSTD
		aAdd( aAuxLinha, 0	  						) // 09-Estoque
		aAdd( aAuxLinha, 0	  						) // 10-Estoq. Total
		aAdd( aAuxLinha, 0	  						) // 11-Pedidos Aberto
		aAdd( aAuxLinha, 0	  						) // 12-Giro
		aAdd( aAuxLinha, ( cAliasQry )->B1_TIPO	  	) // 13-Tipo
		aAdd( aAuxLinha, ( cAliasQry )->B1_UM	  	) // 14-UM
		aAdd( aAuxLinha, ( cAliasQry )->B1_LOCPAD 	) // 15-Armazem
		aAdd( aAuxLinha, ( cAliasQry )->B1_CONV		) // 16-Fator   --> B1_CONV
		aAdd( aAuxLinha, 0 							) // 17-Ultima	--> B1_UCOM
		aAdd( aAuxLinha, 0 							) // 18-Maior
		aAdd( aAuxLinha, 0 							) // 19-Menor
		aAdd( aAuxLinha, ( cAliasQry )->B1_QE		) // 20-Embalagem --> B1_CODEMB
		aAdd( aAuxLinha, CToD( "" ) 				) // 21-Dt. Ultima
		aAdd( aAuxLinha, CToD( "" ) 				) // 22-Dt. Maior
		aAdd( aAuxLinha, CToD( "" ) 				) // 23-Dt. Menor
		//aAdd( aAuxLinha, ( cAliasQry )->BM_DESC   ) // 24-Descrição Grupo
		//aAdd( aAuxLinha, ( cAliasQry )->Z1_DESC   ) // 25-Descrição Categoria
		//aAdd( aAuxLinha, ( cAliasQry )->Z2_DESC   ) // 26-Descrição Linha

		//Preço de Venda do produto de Acordo com a Tabela Informnada
		nPreco := U_UNIRetPreco( ( cAliasQry )->B1_COD, cGetTabela )
		If nPreco == 0
			nPreco := ( cAliasQry )->B1_PRV1
		EndIf
		aAuxLinha[nPosPPreco] := nPreco

		// Calcula o Saldo em Estoque da Filial para o Produto
		nSaldo := U_UNIRetSldProd( cFilAnt, ( cAliasQry )->B1_TIPO, ( cAliasQry )->B1_COD )

		// Calcula o Saldo em Estoque de todas as Filiais para o Produto
		nSldTotal := 0
		For nS := 01 To Len( aListEmpFil )
			If aListEmpFil[nS][01]
				nSldTotal += U_UNIRetSldProd( aListEmpFil[nS][03], ( cAliasQry )->B1_TIPO, ( cAliasQry )->B1_COD )
			EndIf
		Next nS
		aAuxLinha[nPosPEstoque]		:= nSaldo
		aAuxLinha[nPosPEstTotal]	:= nSldTotal

		//Pega os Pedidos em aberto para o Produto
		aAuxLinha[nPosPPedidos]		:= FRetPCsAbertos( ( cAliasQry )->B1_COD )

		// Pega as informações da Última Compra
		aAux := FRetInfoCompras( "ULTIMA", ( cAliasQry )->B1_COD )
		If Len( aAux ) > 0
			aAuxLinha[nPosPUltima]		:= aAux[01]
			aAuxLinha[nPosPDtUltima]	:= aAux[02]
		Else
			aAuxLinha[nPosPUltima]		:= 0
			aAuxLinha[nPosPDtUltima]	:= CToD( "" )
		EndIf

		// Pega as informações da Maior Compra
		aAux := FRetInfoCompras( "MAIOR", ( cAliasQry )->B1_COD )
		If Len( aAux ) > 0
			aAuxLinha[nPosPMaior]		:= aAux[01]
			aAuxLinha[nPosPDtMaior]		:= aAux[02]
		Else
			aAuxLinha[nPosPMaior]		:= 0
			aAuxLinha[nPosPDtMaior]		:= CToD( "" )
		EndIf

		// Pega as informações da Menor Compra
		aAux := FRetInfoCompras( "MENOR", ( cAliasQry )->B1_COD )
		If Len( aAux ) > 0
			aAuxLinha[nPosPMenor]		:= aAux[01]
			aAuxLinha[nPosPDtMenor]		:= aAux[02]
		Else
			aAuxLinha[nPosPMenor]		:= 0
			aAuxLinha[nPosPDtMenor]		:= CToD( "" )
		EndIf

		//Processa o Giro para o Produro
		aAuxLinha[nPosPGiro]			:= FRetGiro( ( cAliasQry )->B1_COD, ( cAliasQry )->B1_LOCPAD )

		aAdd( aListProdutos, aAuxLinha )

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If Len( aListProdutos ) == 0

		aAuxLinha := {}
		aAdd( aAuxLinha, .F.   		) // 01-Marcado
		aAdd( aAuxLinha, .F.	   	) // 02-Legendado
		aAdd( aAuxLinha, ""	    	) // 03-Produto
		aAdd( aAuxLinha, ""   		) // 04-Descricao
		aAdd( aAuxLinha, "" 	 	) // 05-Grupo
		aAdd( aAuxLinha, ""			) // 06-Categoria
		aAdd( aAuxLinha, ""			) // 07-Linha
		aAdd( aAuxLinha, 0		  	) // 08-Preço
		aAdd( aAuxLinha, 0	  		) // 09-Estoque
		aAdd( aAuxLinha, 0		  	) // 10-Estoq. Total
		aAdd( aAuxLinha, 0		  	) // 11-Pedidos Aberto
		aAdd( aAuxLinha, 0	  		) // 12-Giro
		aAdd( aAuxLinha, ""		  	) // 13-Tipo
		aAdd( aAuxLinha, ""		  	) // 14-UM
		aAdd( aAuxLinha, "" 		) // 15-Armazem
		aAdd( aAuxLinha, 0 			) // 16-Fator
		aAdd( aAuxLinha, 0 			) // 17-Ultima
		aAdd( aAuxLinha, 0 			) // 18-Maior
		aAdd( aAuxLinha, 0 			) // 19-Menor
		aAdd( aAuxLinha, 0 			) // 20-Embalagem
		aAdd( aAuxLinha, CToD( "" ) ) // 21-Dt. Ultima
		aAdd( aAuxLinha, CToD( "" ) ) // 22-Dt. Maior
		aAdd( aAuxLinha, CToD( "" ) ) // 23-Dt. Menor
		//aAdd( aAuxLinha, "" 	 	) // 24-Descrição Grupo
		//aAdd( aAuxLinha, ""   	) // 25-Descrição Categoria
		//aAdd( aAuxLinha, ""   	) // 26-Descrição Linha
		aAdd( aListProdutos, aAuxLinha )

	EndIf
	RestArea( aAreaAnt )

Return

*---------------------------------------------*
Static function FRetPCsAbertos( cParamProduto )
	*---------------------------------------------*
	Local aAreaPC	:= GetArea()
	Local cAliasPC 	:= GetNextAlias()
	Local cQuery 	:= ""

	cQuery := "		SELECT SUM( C7_QUANT - C7_QUJE ) AS C7_QUANT "
	cQuery += "		  FROM " + RetSQLName( "SC7" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND C7_PRODUTO = '" + cParamProduto + "' "
	cQuery += "		   AND ( C7_QUANT - C7_QUJE ) > 0
	If Select( cAliasPC ) > 0
		( cAliasPC )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasPC ) New
	If !( cAliasPC )->( Eof() )
		nRetPCs := ( cAliasPC )->C7_QUANT
	EndIf
	( cAliasPC )->( DbCloseArea() )

	RestArea( aAreaPC )

Return nRetPCs


Static Function FPChange()

	Local nLinhaGrid := oListProdutos:nAt

	If nLinhaGrid > 0

		cGetPProduto	 	:= aListProdutos[nLinhaGrid][nPosPProduto]
		cGetPDescProduto	:= aListProdutos[nLinhaGrid][nPosPDescricao]
		cGetPTipo   		:= aListProdutos[nLinhaGrid][nPosPTipo]
		nGetPFator  		:= aListProdutos[nLinhaGrid][nPosPFator]
		nGetPMaior 	 		:= aListProdutos[nLinhaGrid][nPosPMaior]
		nGetPMenor  		:= aListProdutos[nLinhaGrid][nPosPMenor]
		nGetPPrcVenda		:= aListProdutos[nLinhaGrid][nPosPPreco]
		nGetPUltima 		:= aListProdutos[nLinhaGrid][nPosPUltima]
		nGetPEmbalagem 		:= aListProdutos[nLinhaGrid][nPosPEmbalagem]
		dGetPDtMaior 		:= aListProdutos[nLinhaGrid][nPosPDtMaior]
		dGetPDtMenor 		:= aListProdutos[nLinhaGrid][nPosPDtMenor]
		dGetPDtUltima	 	:= aListProdutos[nLinhaGrid][nPosPDtUltima]

		oGetPProduto:Refresh()
		oGetPDescProduto:Refresh()
		oGetPTipo:Refresh()
		oGetPFator:Refresh()
		oGetPMaior:Refresh()
		oGetPMenor:Refresh()
		oGetPPrcVenda:Refresh()
		oGetPUltima:Refresh()
		oGetPEmbalagem:Refresh()
		oGetPDtMaior:Refresh()
		oGetPDtMenor:Refresh()
		oGetPDtUltima:Refresh()

		MsgRun( "Carregando as Entradas e Saídas, aguarde...", "Carregando as Entradas e Saídas, aguarde...", { || FLoadEntSai( aListProdutos[nLinhaGrid][nPosPProduto], dGetDtInicial, dGetDtFinal ) } )

	EndIf

Return



Static Function FLoadEntSai( cParamProduto, dParamDtIni, dParamDtFim )

	Local aHistEntSai := FRetHistorico( cParamProduto, dParamDtIni, dParamDtFim )

	For nE := 01 To len( aListEntSai )
		aListEntSai[nE][nPosESEntradas] := 0
		aListEntSai[nE][nPosESSaidas]   := 0
	Next nE

	For nE := 01 To Len( aHistEntSai )

		nPos := aScan( aListEntSai, { |x| x[nPosESNumMes] == Val( aHistEntSai[nE][02] ) .And. x[nPosESAno] == Val( aHistEntSai[nE][01] ) } )
		If nPos > 0
			aListEntSai[nPos][nPosESEntradas] := aHistEntSai[nE][03]
			aListEntSai[nPos][nPosESSaidas]   := aHistEntSai[nE][04]
		EndIf

	Next nE

	oListEntSai:SetArray( aListEntSai )
	oListEntSai:bLine := bLinesEntSai
	oListEntSai:Refresh()

Return

*--------------------------------*
Static Function FConsultaPedidos()
	*--------------------------------*
	Private cGetPCProduto 		:= aListProdutos[oListProdutos:nAt][nPosPProduto]
	Private cGetPCDescricao 	:= aListProdutos[oListProdutos:nAt][nPosPDescricao]

	Private nPosPVFilial		:= 01
	Private nPosPVPedido		:= 02
	Private nPosPVData			:= 03
	Private nPosPVFornecedor	:= 04
	Private nPosPVLoja			:= 05
	Private nPosPVNome			:= 06
	Private nPosPVQuant			:= 07
	Private nPosPVValor			:= 08
	Private nPosPVRecNo			:= 09

	Private aListPedidos		:= {}

	SetPrvt( "oDlgPVAberto","oGrpProduto","oSayProduto","oGetPVProduto","oGetPVDescricao","oGrpPedidos","oBtnFechar" )
	SetPrvt( "oListPedidos" )

	/*
cAuxProdutos := ""
For nY := 01 To Len( aListProdutos )
	If aListProdutos[nY][nPosPMarcado]
		cAuxProdutos += AllTrim( aListProdutos[nY][nPosPProduto] ) + ","
	EndIf
Next nY
cAuxProdutos := Replace( AllTrim( cAuxProdutos ) + ";", ";;", "" )
	*/

	If cGetPCProduto == Nil .Or. AllTrim( cGetPCProduto ) == ""
		Aviso( "Atenção", "Precisa selecionar um Produto primeiro.", { "Voltar" } )
		Return
	EndIf

	MsgRun( "Carregando Pedidos em aberto, aguarde...", "Carregando Pedidos em aberto, aguarde...", { || FLoadPedidos( cGetPCProduto ) } )

	oDlgPVAberto 			:= MSDialog():New( 138,254,573,1210,"Pedidos em Aberto",,,.F.,,,,,,.T.,,,.F. )

	oGrpProduto 			:= TGroup():New( 001,006,030,409," Produto Selecionado ",oDlgPVAberto,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayProduto 			:= TSay():New( 016,016,{||"Produto:"},oGrpProduto,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
	oGetPVProduto 			:= TGet():New( 014,043,,oGrpProduto,068,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cGetPCProduto",,)
	oGetPVProduto:bSetGet 	:= {|u| If(PCount()>0,cGetPCProduto:=u,cGetPCProduto)}
	oGetPVProduto:bWhen 	:= { || .F. }

	oGetPVDescricao 		:= TGet():New( 014,119,,oGrpProduto,284,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cGetPCDescricao",,)
	oGetPVDescricao:bSetGet := {|u| If(PCount()>0,cGetPCDescricao:=u,cGetPCDescricao)}
	oGetPVDescricao:bWhen 	:= { || .F. }

	oGrpPedido 				:= TGroup():New( 036,006,205,466," Pedidos em Aberto ",oDlgPVAberto,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListPedidos 		:= {}
	aSizeListPedidos 		:= {}

	aAdd( aTitListPedidos , "FILIAL" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB"      	) )

	aAdd( aTitListPedidos , "PEDIDO" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBB"      ) )

	aAdd( aTitListPedidos , "DATA" 				)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBB"      	) )

	aAdd( aTitListPedidos , "FORNECEDOR" 		)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBB"      	) )

	aAdd( aTitListPedidos , "LOJA" 				)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB"      	) )

	aAdd( aTitListPedidos , "NOME" 		)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBBB" ) )

	aAdd( aTitListPedidos , "VLR. TOTAL" 				)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBB"   	) )

	//oListPedidos 				:= TListBox():New( 048,012,,,448,151,,oGrpPedidos,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListPedidos 				:= TwBrowse():New( 048, 012, 448, 151,, aTitListPedidos, aSizeListPedidos, oGrpPedidos,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListPedidos:SetArray( aListPedidos )
	bLinesPedidos				:= { || {  AllTrim( aListPedidos[oListPedidos:nAt][nPosPVFilial] )			 			 ,; // Filial
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPVPedido] ) 						 ,; // Pedido
		DToC( aListPedidos[oListPedidos:nAt][nPosPVData] ) 						 ,; // Data
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPVFornecedor] ) 					 ,; // Fornecedor
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPVLoja]   ) 						 ,; // Loja
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPVNome]   ) 						 ,; // Nome
		AllTrim( TransForm( aListPedidos[oListPedidos:nAt][nPosPVQuant], "@E 999,999,999.99" ) ) ,; // Quantidade
		AllTrim( TransForm( aListPedidos[oListPedidos:nAt][nPosPVValor], "@E 999,999,999.99" ) ) }} // Valor
	oListPedidos:bLine 	   		:= bLinesPedidos
	oListPedidos:Refresh()

	oBtnFechar 				:= TButton():New( 006,417,"Fechar",oDlgPVAberto,,049,012,,,,.T.,,"",,,,.F. )
	oBtnFechar:bAction 		:= { || oDlgPVAberto:End() }

	oBtnVisualizar 			:= TButton():New( 020,417,"Visualizar",oDlgPVAberto,,049,012,,,,.T.,,"",,,,.F. )
	oBtnVisualizar:bAction 	:= { || FViewPV() }

	oDlgPVAberto:Activate( ,,, .T. )

Return

*-----------------------*
Static Function FViewPV()
	*-----------------------*
	Local aAreaAtu := GetArea()
	Local aAreaSC7 := SC7->( GetArea() )
	Local aAreaSA2 := SA2->( GetArea() )
	Local aAreaSB1 := SB1->( GetArea() )

	/*
Local nFuncao,
Local xAutoCab
Local xAutoItens
Local nOpcAuto
Local lWhenGet
Local xRatCTBPC
Local xAdtPC
Local xRatProj
	*/

	Local aFixe			:= { { "Numero do PC", "C7_NUM" }, { "Data Emissao", "C7_EMISSAO" }, { "Fornecedor", "C7_FORNECE" } }
	Local aGrupo		:= {}
	Local aIndexSC7		:= {}
	Local aCores		:= {}
	Local aCoresUsr		:= {}
	Local cFiltro		:= ""
	Local cFilQuery		:= ""
	Local cMt120Fil		:= ""
	Local nOrderSC7		:= 0
	Local nPos			:= 0
	Local nX			:= 0
	Local bBlock
	Local uMt120Dft

	PRIVATE aBackSC7   	:= {}
	PRIVATE aAutoCab   	:= {}
	PRIVATE aAutoItens 	:= {}
	PRIVATE aRatCTBPC  	:= {}
	PRIVATE aAdtPC     	:= {}
	PRIVATE aRatProj   	:= {}

	PRIVATE nAutoAdt   	:= 0
	PRIVATE nTipoPed   	:= 1 //nFuncao // 1 - Ped. Compra 2 - Aut. Entrega
	PRIVATE cCadastro  	:= "Pedidos de Compra"
	PRIVATE l120Auto   	:= .F.
	PRIVATE lPedido    	:= .T.
	PRIVATE lGatilha   	:= .T.                            // Para preencher aCols em funcoes chamadas da validacao (X3_VALID)
	PRIVATE lVldHead   	:= GetNewPar( "MV_VLDHEAD", .T. ) // O parametro MV_VLDHEAD e' usado para validar ou nao o aCols (uma linha ou todo), a partir das validacoes do aHeader -> VldHead()

	Private aImpIB2		:= {}
	Private aImpCCO		:= {}
	Private aImpSFC		:= {}
	Private aImpSFF		:= {}
	Private aImpSFH		:= {}
	Private aImpLivr	:= {}
	Private aTesMXF		:= {}

	If oListPedidos:nAt > 0

		If Len( aListPedidos ) == 01
			If aListPedidos[oListPedidos:nAt][nPosPVRecNo] == 0
				Return
			EndIf
		EndIf

		If aListPedidos[oListPedidos:nAt][nPosPVRecNo] > 0

			// Pontera no Pedido
			DbSelectArea( "SC7" )
			DbSetOrder( 01 )
			SC7->( DbGoTo( aListPedidos[oListPedidos:nAt][nPosPVRecNo] ) )

			//Pontera no Fornecedor do Pedido
			DbSelectArea( "SA2" )
			DbSetOrder( 01 )
			Seek XFilial( "SA2" ) + SC7->( C7_FORNECE + C7_LOJA )

			//Pontera no Produto do Pedido
			DbSelectArea( "SB1" )
			DbSetOrder( 01 )
			Seek XFilial( "SB1" ) + SC7->C7_PRODUTO

			// Chama a tela padrão de Visualização de Pedido de Compras
			A120Pedido( "SC7", SC7->( RecNo() ), 02 )

		EndIf

	EndIf

	RestArea( aAreaSC7 )
	RestArea( aAreaSA2 )
	RestArea( aAreaSB1 )
	RestArea( aAreaAtu )

Return


Static function FLoadPedidos( cParamProduto )

	Local aAreaPV	:= GetArea()
	Local cAliasPV 	:= GetNextAlias()
	Local cQuery 	:= ""


	cQuery := "		 SELECT C7_FILIAL 	, "
	cQuery += "				C7_NUM		, "
	cQuery += "				C7_EMISSAO	, "
	cQuery += "				C7_FORNECE	, "
	cQuery += "				C7_LOJA		, "
	cQuery += "				A2_NOME		, "
	cQuery += "				SC7.R_E_C_N_O_ AS [NUMRECNO], "
	cQuery += "				SUM( ( C7_QUANT  - C7_QUJE ) ) 	AS C7_QUANT, "
	cQuery += "				SUM( C7_TOTAL ) 				AS C7_TOTAL  "
	cQuery += "		   FROM " + RetSQLName( "SA2" ) + " SA2, "
	cQuery += "		        " + RetSQLName( "SC7" ) + " SC7  "
	cQuery += "		  WHERE SC7.D_E_L_E_T_ = ' ' "
	cQuery += "		    AND SA2.D_E_L_E_T_ = ' ' "
	cQuery += "			AND A2_FILIAL 	   = '" + XFilial( "SA2" ) + "' "
	cQuery += "			AND A2_COD  	   = C7_FORNECE  "
	cQuery += "			AND A2_LOJA  	   = C7_LOJA	 "
	//cQuery += "		    AND LTRIM( RTRIM( C7_PRODUTO ) ) IN " + FormatIN( cParamProdutos, "," )
	cQuery += "		    AND LTRIM( RTRIM( C7_PRODUTO ) ) = '" + cParamProduto + "' "
	cQuery += "		    AND ( C7_QUANT  - C7_QUJE ) > 0
	cQuery += "	   GROUP BY C7_FILIAL	,  "
	cQuery += "				C7_NUM		,  "
	cQuery += "				C7_EMISSAO	,  "
	cQuery += "				C7_FORNECE	,  "
	cQuery += "				C7_LOJA		,  "
	cQuery += "				A2_NOME		,  "
	cQuery += "				SC7.R_E_C_N_O_ "
	cQuery += "	   ORDER BY C7_FILIAL	,  "
	cQuery += "				C7_NUM		,  "
	cQuery += "				C7_EMISSAO	   "

	If Select( cAliasPV ) > 0
		( cAliasPV )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasPV ) New

	aListPedidos := {}
	Do While !( cAliasPV )->( Eof() )

		aAdd( aListPedidos, { ( cAliasPV )->C7_FILIAL	,;
			( cAliasPV )->C7_NUM		,;
			SToD( ( cAliasPV )->C7_EMISSAO ),;
			( cAliasPV )->C7_FORNECE	,;
			( cAliasPV )->C7_LOJA		,;
			( cAliasPV )->A2_NOME		,;
			( cAliasPV )->C7_QUANT	,;
			( cAliasPV )->C7_TOTAL	,;
			( cAliasPV )->NUMRECNO	})

		DbSelectArea( cAliasPV )
		( cAliasPV )->( DbSkip() )
	EndDo
	( cAliasPV )->( DbCloseArea() )

	If Len( aListPedidos ) == 0

		aAdd( aListPedidos, { ""			,;
			""			,;
			CToD( "" )	,;
			""			,;
			""			,;
			""			,;
			0				,;
			0				,;
			0				})

	EndIf

	//oListPedidos:SetArray( aListPedidos )
	//oListPedidos:bLine := bLinesPedidos
	//oListPedidos:Refresh()

	RestArea( aAreaPV )

Return

*-----------------------------*
Static Function FExportaExcel()
	*-----------------------------*
	Local oExcel 	:= FWMsExcel():New()

	Local aCabec	:= { { "LG"			, "C" } ,;
		{ "PRODUTO"	, "C" } ,;
		{ "DESCRIÇÃO"	, "C" } ,;
		{ "GRUPO"		, "C" } ,;
		{ "CATEG."		, "C" } ,;
		{ "LINHA"		, "C" } ,;
		{ "PRC.VEN."	, "M" } ,;
		{ "EST.FIL."	, "N" } ,;
		{ "EST.TOT."	, "N" } ,;
		{ "PED. AB"	, "N" } ,;
		{ "GIRO"		, "N" }  }

	oExcel:AddworkSheet( "CENTRAL COMPRAS" )
	oExcel:AddTable ( "CENTRAL COMPRAS", "CENTRAL COMPRAS" )

	For nF := 01 To Len( aCabec )

		Do Case
			Case aCabec[nF][02] == "N" // Number
				nAlinhamento := 03 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 02 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
			Case aCabec[nF][02] == "M" // Money
				nAlinhamento := 03 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 03 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
			Case aCabec[nF][02] == "D" // Date
				nAlinhamento := 03 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 04 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
			OtherWise
				nAlinhamento := 01 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 01 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
		EndCase
		lTotal := .F.
		oExcel:AddColumn( "CENTRAL COMPRAS", "CENTRAL COMPRAS", AllTrim(  aCabec[nF][01] ), nAlinhamento, nFormato, lTotal )

	Next nF

	lTotal 		 := .F.
	nAlinhamento := 01 // ( 1-Left	  , 2-Center , 3-Right )
	nFormato 	 := 01 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )

	//oExcel:AddColumn( "CENTRAL COMPRAS", "CENTRAL COMPRAS", "Franqueado"	, nAlinhamento, nFormato, lTotal )

	ProcRegua( Len( aListProdutos ) )
	For nL := 01 To Len( aListProdutos )

		IncProc()

		aAux := {}
		For nC := 01 To Len( aCabec )
			aAdd( aAux, aListProdutos[nL][nC+1] )
		Next nY
		oExcel:AddRow( 	"CENTRAL COMPRAS", "CENTRAL COMPRAS", aAux )

	Next nL
	MsgRun( "Aguarde, iniciando Microsoft Excel...", "Aguarde, iniciando Microsoft Excel...", { || oExcel:Activate() } )

	cPath 	 := "c:\temp\"
	FwMakeDir( cPath )
	cNomeXML := cPath + FunName() + "_" + FwTimeStamp( 01 ) + ".xml"
	oExcel:GetXMLFile( cNomeXML )
	If ApOleClient( "MsExcel" )
		oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open( cNomeXML )
		oExcelApp:SetVisible( .T. )
		oExcelApp:Destroy()
	Else
		ShellExecute( "Open", cNomeXML, "", "", 01 )
	EndIf

Return


Static Function FRetHistorico( cParamProduto, dParamDtIni, dParamDtFim )

	Local aAreaAnt 		:= GetArea()
	Local cAliasHist	:= GetNextAlias()
	Local cQuery 		:= ""

	cQuery := "		SELECT ANOMES			AS [ANOMES]	   ,				  	 "  + CRLF
	cQuery += "		  	   SUM( D1_QUANT ) 	AS [D1_QUANT]  ,   					 "  + CRLF
	cQuery += "		  	   SUM( D2_QUANT ) 	AS [D2_QUANT] 	   					 "  + CRLF
	cQuery += "		  FROM ( 										   			 "  + CRLF
	cQuery += "			SELECT LEFT( D1_DTDIGIT, 06 ) 	AS [ANOMES]	 , 			 "  + CRLF
	cQuery += "			  	   SUM( D1_QUANT ) 			AS [D1_QUANT], 			 "  + CRLF
	cQuery += "			  	   0 						AS [D2_QUANT] 			 "  + CRLF
	cQuery += "			  FROM " + RetSQLName( "SD1" ) + " SD1		 , 			 "  + CRLF
	cQuery += "			  	   " + RetSQLName( "SF4" ) + " SF4  				 "  + CRLF
	cQuery += "			 WHERE SF4.F4_CODIGO  	 = SD1.D1_TES   				 "  + CRLF
	cQuery += "			   AND SF4.F4_ESTOQUE 	 = 'S'         					 "  + CRLF
	cQuery += "			   AND SD1.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND SF4.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND SF4.F4_FILIAL 	 = '" + XFilial( "SF4" ) 	+ "' "  + CRLF
	cQuery += "			   AND D1_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
	cQuery += "			   AND D1_DTDIGIT		>= '" + DToS( dParamDtIni ) + "' "  + CRLF
	cQuery += "			   AND D1_DTDIGIT		<= '" + DToS( dParamDtFim ) + "' "  + CRLF
	cQuery += "		  GROUP BY LEFT( D1_DTDIGIT, 06 )						   	 "  + CRLF
	cQuery += "			 UNION  										  		 "  + CRLF
	cQuery += "			SELECT LEFT( D3_EMISSAO, 06 ) 	AS [ANOMES]	 ,			 "  + CRLF
	cQuery += "			  	   SUM( D3_QUANT ) 			AS [D1_QUANT], 	  		 "  + CRLF
	cQuery += "			  	   0 						AS [D2_QUANT] 			 "  + CRLF
	cQuery += "			  FROM " + RetSQLName( "SD3" ) + " SD3  				 "  + CRLF
	cQuery += "			 WHERE SD3.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND D3_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
	cQuery += "			   AND D3_EMISSAO		>= '" + DToS( dParamDtIni ) + "' "  + CRLF
	cQuery += "			   AND D3_EMISSAO		<= '" + DToS( dParamDtFim ) + "' "  + CRLF
	cQuery += "			   AND D3_TM      		 < '500' 						 "  + CRLF
	cQuery += "			   AND D3_ESTORNO 		!= 'S'   						 "  + CRLF
	cQuery += "  	  GROUP BY LEFT( D3_EMISSAO, 06 )    					 	 "  + CRLF
	cQuery += "			 UNION  										  		 "  + CRLF
	cQuery += "			SELECT LEFT( D2_EMISSAO, 06 ) 	AS [ANOMES]	 , 			 "  + CRLF
	cQuery += "			  	   0			 			AS [D1_QUANT], 			 "  + CRLF
	cQuery += "			  	   SUM( D2_QUANT )			AS [D2_QUANT] 			 "  + CRLF
	cQuery += "			  FROM " + RetSQLName( "SD2" ) + " SD2		 , 			 "  + CRLF
	cQuery += "			  	   " + RetSQLName( "SF4" ) + " SF4  				 "  + CRLF
	cQuery += "			 WHERE SF4.F4_CODIGO  	 = SD2.D2_TES   				 "  + CRLF
	cQuery += "			   AND SF4.F4_ESTOQUE 	 = 'S'         					 "  + CRLF
	cQuery += "			   AND SD2.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND SF4.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND SF4.F4_FILIAL 	 = '" + XFilial( "SF4" ) 	+ "' "  + CRLF
	cQuery += "			   AND D2_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
	cQuery += "			   AND D2_EMISSAO		>= '" + DToS( dParamDtIni ) + "' "  + CRLF
	cQuery += "			   AND D2_EMISSAO		<= '" + DToS( dParamDtFim ) + "' "  + CRLF
	cQuery += "		  GROUP BY LEFT( D2_EMISSAO, 06 )						   	 "  + CRLF
	cQuery += "			 UNION  										  		 "  + CRLF
	cQuery += "			SELECT LEFT( D3_EMISSAO, 06 ) 	AS [ANOMES]	 ,			 "  + CRLF
	cQuery += "			  	   0 						AS [D1_QUANT], 	  		 "  + CRLF
	cQuery += "			  	   SUM( D3_QUANT )			AS [D2_QUANT] 			 "  + CRLF
	cQuery += "			  FROM " + RetSQLName( "SD3" ) + " SD3  				 "  + CRLF
	cQuery += "			 WHERE SD3.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND D3_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
	cQuery += "			   AND D3_EMISSAO		>= '" + DToS( dParamDtIni ) + "' "  + CRLF
	cQuery += "			   AND D3_EMISSAO		<= '" + DToS( dParamDtFim ) + "' "  + CRLF
	cQuery += "			   AND D3_TM      		 > '500' 						 "  + CRLF
	cQuery += "			   AND D3_ESTORNO 		!= 'S'   						 "  + CRLF
	cQuery += "  	  GROUP BY LEFT( D3_EMISSAO, 06 )    					 	 "  + CRLF
	cQuery += "		       ) A 	  												 "  + CRLF
	cQuery += "	  GROUP BY ANOMES 												 "  + CRLF
	cQuery += "	  ORDER BY ANOMES												 "  + CRLF

	// Zera a variábel array de retorno
	aRetHist  := {}

	If Select( cAliasHist ) > 0
		( cAliasHist )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasHist ) New
	Do While !( cAliasHist )->( Eof() )

		aAdd( aRetHist, { 	Left( ( cAliasHist )->ANOMES, 04 ) 	, ;
			Right( ( cAliasHist )->ANOMES, 02 ) 	, ;
			( cAliasHist )->D1_QUANT 		, ;
			( cAliasHist )->D2_QUANT 		} )

		DbSelectArea( cAliasHist )
		( cAliasHist )->( DbSkip() )
	EndDo
	( cAliasHist )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return aRetHist

*---------------------------*
Static Function FGeraPedido()
	*---------------------------*
	Local aAreaAnt 	:= GetArea()
	Local aAreaSB1 	:= SB1->( GetArea() )
	Local aAreaSA2 	:= SA2->( GetArea() )
	Local nIt 		:= 0
	Local lMarcou   := .F.
	Local nTamItem  := TamSX3( "C7_ITEM" )[01]
	Local aCabecSC7	:= {}
	Local aItensSC7	:= {}
	Local nSeqItem 	:= 01

	lMarcou   		:= .F.
	For nIt := 01 To Len( aListProdutos )

		If aListProdutos[nIt][nPosPMarcado]
			lMarcou   := .T.
			Exit
		EndIf

	Next nIt

	If !lMarcou
		//Aviso( "Atenção", "Será necessário selecionar pelo menos 1(um) produto para gerar o Pedido.", { "Voltar" } )
		MsgYesNo( "Será necessário selecionar pelo menos 1(um) produto para gerar o Pedido." )
		Return
	EndIf

	DbSelectArea( "SC7" )
	DbSetOrder( 01 )
	cNumPC 	 := GetSXeNum( "SC7", "C7_NUM" )
	Do While .T.

		If SC7->( DbSeek( XFilial( "SC7" ) + cNumPC ) )
			ConfirmSX8()
			cNumPC 	 := GetSXeNum( "SC7", "C7_NUM" )
			Loop
		Else
			Exit
		EndIf
	EndDo

	aCabecSC7	:= {}
	aItensSC7	:= {}
	nSeqItem 	:= 01
	ProcRegua( Len( aListProdutos ) )
	For nIt := 01 To Len( aListProdutos )

		IncProc()
		If aListProdutos[nIt][nPosPMarcado]

			// Monta o Cabeçalho do PC
			If nSeqItem == 01

				aAuxFornecedor := {}
				aAuxFornecedor := FRetFornecedor( aListProdutos[nIt][nPosPProduto] )
				If Len( aAuxFornecedor ) == 0

					cAuxFornecedor 	:= ""
					cAuxLoja 		:= ""
					//Aviso( "Atenção", "Não será possível gerar o Pedido de Compras pois não existe Produto x Fornecedor associado para o Produto abaixo:" + CRLF + "Produto: " + AllTrim( aListProdutos[nIt][nPosPProduto] ) + "-" +  AllTrim( aListProdutos[nIt][nPosPDescricao] ), { "Voltar" } )
					/*
				If Aviso( "Atenção", "Deseja utilizar o Fornecedor padrão definido?", { "Sim", "Não" } ) == 02
					RestArea( aAreaSA2 )
					RestArea( aAreaSB1 )
					RestArea( aAreaAnt )
					Return
				Else
					aAuxFornecedor := {}
					aAdd( aAuxFornecedor, PadR( GetNewPar( "MV_XFORCEN", "90189960" ), TamSX3( "A2_COD" )[01] ) )
					aAdd( aAuxFornecedor, "0001" )
				EndIf
					*/

				Else

					cAuxFornecedor 	:= PadR( AllTrim( aAuxFornecedor[01] ), TamSX3( "A2_COD" )[01] )
					cAuxLoja 		:= aAuxFornecedor[02]

				EndIf

				If AllTrim( cAuxFornecedor ) == ""

					Aviso( "Atenção", "Não será possível gerar o Pedido de Compras pois não existe Produto x Fornecedor associado para o Produto abaixo:" + CRLF + "Produto: " + AllTrim( aListProdutos[nIt][nPosPProduto] ) + "-" +  AllTrim( aListProdutos[nIt][nPosPDescricao] ), { "Voltar" } )

					If Aviso( "Atenção", "Deseja selecionar um fornecedor?", { "Sim", "Não" } ) == 01

						Do While .T.

							DbSelectArea( "SA2" )
							ConPad1( ,,, "SA2" )
							cAuxFornecedor 	:= SA2->A2_COD
							cAuxLoja 		:= SA2->A2_LOJA
							If SA2->( DbSeek( XFilial( "SA2" ) + cAuxFornecedor + cAuxLoja ) )
								Exit
							EndIf

						EndDo

					Else

						RestArea( aAreaSA2 )
						RestArea( aAreaSB1 )
						RestArea( aAreaAnt )
						Return

					EndIf

				EndIf

				DbSelectArea( "SA2" )
				SA2->( DbGoTop() )
				DbSetOrder( 01 ) // A2_FILIAL + A2_COD + A2_LOJA
				Seek XFilial( "SA2" ) + cAuxFornecedor  + cAuxLoja
				If Found()

					aCabecSC7 := {}
					aAdd( aCabecSC7, { "C7_FILIAL"	, XFilial( "SC7" )				, Nil } )
					aAdd( aCabecSC7, { "C7_NUM"		, cNumPC						, Nil } )
					aAdd( aCabecSC7, { "C7_EMISSAO"	, dDataBase						, Nil } )
					aAdd( aCabecSC7, { "C7_FORNECE"	, SA2->A2_COD  					, Nil } )
					aAdd( aCabecSC7, { "C7_LOJA"	, SA2->A2_LOJA					, Nil } )
					aAdd( aCabecSC7, { "C7_COND"    , "001" 			    	  	, Nil } )
					aAdd( aCabecSC7, { "C7_CONTATO" , SA2->A2_CONTATO		   	 	, Nil } )
					aAdd( aCabecSC7, { "C7_USER"  	, __cUserId				   	 	, Nil } )
					aAdd( aCabecSC7, { "C7_FILENT"	, cFilAnt						, Nil } )
					aAdd( aCabecSC7, { "C7_MOEDA"  	, 1								, Nil } )
					aAdd( aCabecSC7, { "C7_TXMOEDA"	, 0								, Nil } )
					aAdd( aCabecSC7, { "C7_NATUREZ"	, SA2->A2_NATUREZ				, Nil } )

				Else

					Aviso( "Atenção", "Não encontrou o Fornecedor definido para a automação.", { "Voltar" } )
					RestArea( aAreaSA2 )
					RestArea( aAreaSB1 )
					RestArea( aAreaAnt )
					Return

				EndIf

			EndIf

			DbSelectArea( "SB1" )
			DbSetOrder( 01 )
			Seek XFilial( "SB1" ) + PadR( aListProdutos[nIt][nPosPProduto], TamSX3( "B1_COD" )[01] )
			If Found()

				//Monta os Itens do PC
				aAuxItem := {}
				aAdd( aAuxItem, { "C7_ITEM"		, StrZero( nSeqItem, nTamItem )						 , Nil } )
				aAdd( aAuxItem, { "C7_PRODUTO"	, SB1->B1_COD										 , Nil } )
				aAdd( aAuxItem, { "C7_DESCRI" 	, SB1->B1_DESC 									 	 , Nil } )
				aAdd( aAuxItem, { "C7_QUANT"	, 01												 , Nil } )
				aAdd( aAuxItem, { "C7_PRECO"	, If( SB1->B1_UPRC == 0, 0.1, SB1->B1_UPRC )		 , Nil } )
				aAdd( aAuxItem, { "C7_TOTAL"  	, ( 01 * If( SB1->B1_UPRC == 0, 0.1, SB1->B1_UPRC ) ), Nil } )
				aAdd( aAuxItem, { "C7_DATPRF"	, dDataBase											 , Nil } )
				aAdd( aAuxItem, { "C7_UM"  		, SB1->B1_UM										 , Nil } )
				aAdd( aAuxItem, { "C7_LOCAL"  	, SB1->B1_LOCPAD 									 , Nil } )

				//aAdd( aAuxItem, { "C7_CODTAB"	, cGetTabela							, Nil } )
				//aAdd( aAuxItem, { "C7_OBS"    , ""						 	   		, Nil } )
				//aAdd( aAuxItem, { "C7_CFOP"   , ""									, Nil } )
				//aAdd( aAuxItem, { "C7_TES"    , ""			 						, Nil } )
				//aAdd( aAuxItem, { "C7_CONTA"  , ""			 			 			, Nil } )
				//aAdd( aAuxItem, { "C7_CC"  	, "" 	 								, Nil } )
				//aAdd( aAuxItem, { "C7_NATUREZ", ""							    	, Nil } )
				//aAdd( aAuxItem, { "C7_QTDSOL" , ""  									, Nil } )
				//aAdd( aAuxItem, { "C7_VLDESC" , ""									, Nil } )
				//nQtdSeg := ConvUm( SB1->B1_COD, nQuant, 0, 2 )

				aAdd( aItensSC7, aAuxItem )
				nSeqItem++

			Else

				Aviso( "Atenção", "Erro, não encontrou o Cadastro do Produto [ " + aListProdutos[nIt][nPosPProduto] + " ], a operação não poderá continuar.", { "Voltar" } )
				RestArea( aAreaSA2 )
				RestArea( aAreaSB1 )
				RestArea( aAreaAnt )
				Return

			EndIf

		EndIf

	Next nIt

	DbSelectArea( "SC7" )
	l120Auto   	:= .T.
	lGatilha   	:= .T.
	lMsErroAuto := .F.
	MsExecAuto( { |v, x, y, z| Mata120( v, x, y, z ) }, 01, aCabecSC7, aItensSC7, 03,,, {} ) // Inclusão
	If lMsErroAuto

		MostraErro()
		RollBackSX8()

	Else

		ConfirmSX8()
		l120Auto   	:= .F.
		A120Pedido( "SC7", SC7->( RecNo() ), 04 )

	End If

	RestArea( aAreaSB1 )
	RestArea( aAreaAnt )

Return

*----------------------------------------------------------*
Static Function FRetInfoCompras( cParamTipo, cParamProduto )
	*----------------------------------------------------------*
	Local aAreaAnt 		:= GetArea()
	Local cAliasInfo	:= GetNextAlias()
	Local cQuery 		:= ""
	Local aRetInfo		:= {}

	Do Case
		Case AllTrim( cParamTipo ) == "ULTIMA"

			cQuery := "			SELECT TOP 1 											 "  + CRLF
			cQuery += "			  	   D1_DTDIGIT 			 	AS [DTPC]	 , 			 "  + CRLF
			cQuery += "			  	   D1_QUANT 	 			AS [QUANT]	 			 "  + CRLF
			cQuery += "			  FROM " + RetSQLName( "SD1" ) + " SD1		  			 "  + CRLF
			cQuery += "			 WHERE SD1.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
			cQuery += "			   AND D1_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
			cQuery += "			   AND D1_DTDIGIT		 = ( SELECT MAX( D1_DTDIGIT ) FROM " + RetSQLName( "SD1" ) + " WHERE D_E_L_E_T_ = ' '  AND D1_COD = '" + cParamProduto + "' ) "
			cQuery += "		  ORDER BY R_E_C_N_O_ DESC								   	 "  + CRLF

		Case AllTrim( cParamTipo ) == "MAIOR"

			cQuery := "			SELECT TOP 1 											 "  + CRLF
			cQuery += "			  	   D1_DTDIGIT 			 	AS [DTPC]	 , 			 "  + CRLF
			cQuery += "			  	   D1_QUANT 	 			AS [QUANT]	 			 "  + CRLF
			cQuery += "			  FROM " + RetSQLName( "SD1" ) + " SD1		  			 "  + CRLF
			cQuery += "			 WHERE SD1.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
			cQuery += "			   AND D1_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
			cQuery += "			   AND D1_QUANT		 = ( SELECT MAX( D1_QUANT ) FROM " + RetSQLName( "SD1" ) + " WHERE D_E_L_E_T_ = ' '  AND D1_COD = '" + cParamProduto + "' ) "
			cQuery += "		  ORDER BY R_E_C_N_O_ DESC								   	 "  + CRLF

		Case AllTrim( cParamTipo ) == "MENOR"

			cQuery := "			SELECT TOP 1 											 "  + CRLF
			cQuery += "			  	   D1_DTDIGIT 			 	AS [DTPC]	 , 			 "  + CRLF
			cQuery += "			  	   D1_QUANT 	 			AS [QUANT]	 			 "  + CRLF
			cQuery += "			  FROM " + RetSQLName( "SD1" ) + " SD1		  			 "  + CRLF
			cQuery += "			 WHERE SD1.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
			cQuery += "			   AND D1_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
			cQuery += "			   AND D1_QUANT		 = ( SELECT MIN( D1_QUANT ) FROM " + RetSQLName( "SD1" ) + " WHERE D_E_L_E_T_ = ' '  AND D1_COD = '" + cParamProduto + "' ) "
			cQuery += "		  ORDER BY R_E_C_N_O_ DESC								   	 "  + CRLF
	EndCase

	// Zera a variábel array de retorno
	aRetInfo		:= {}

	If Select( cAliasInfo ) > 0
		( cAliasInfo )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasInfo ) New
	If !( cAliasInfo )->( Eof() )

		aAdd( aRetInfo, 	  ( cAliasInfo )->QUANT  )
		aAdd( aRetInfo, SToD( ( cAliasInfo )->DTPC ) )

	EndIf
	( cAliasInfo )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return aRetInfo

*-----------------------------------------------------*
Static Function FRetGiro( cParamProduto, cParamLocal  )
	*-----------------------------------------------------*
	Local aAreaGiro 		:= GetArea()
	Local nRetGiro 			:= 0
	Local nEstQtdInicial 	:= 0
	Local nEstQtdFinal	 	:= 0
	Local nEstQtdMedio 		:= 0
	Local aAuxSldIni		:= {}
	Local aAuxSldFim		:= {}

	//Pega o Estoque no Início do Período Solicitado
	aSldIni := CalcEst( cParamProduto, cParamLocal, dGetDtInicial )
	If Len( aSldIni ) > 0
		nEstQtdInicial 	:= aSldIni[01]
	EndIf

	//Pega o Estoque no Final do Período Solicitado
	aSldFim := CalcEst( cParamProduto, cParamLocal, dGetDtFinal )
	If Len( aSldFim ) > 0
		nEstQtdFinal 	:= aSldFim[01]
	EndIf

	//Calcula a Média do Estoque no Período Solicitado
	If ( nEstQtdInicial + nEstQtdFinal ) != 0
		nEstQtdMedio := ( ( nEstQtdInicial + nEstQtdFinal ) / 02 )
	EndIf

	nAuxvendas 	:= 01
	nAuxvendas 	:= FRetVendas( cParamProduto, dGetDtInicial, dGetDtFinal )

	nRetGiro 	:= ( nAuxvendas / nEstQtdMedio )

	RestArea( aAreaGiro )

Return nRetGiro

*---------------------------------------------*
Static Function FRetFornecedor( cParamProduto )
	*---------------------------------------------*
	Local aAreaAnt 			:= GetArea()
	Local cAliasA2 			:= GetNextAlias()
	Local aRetFornecedor 	:= {}
	Local cQuery 			:= ""

	cQuery := "	  SELECT A5_FORNECE, A5_LOJA "
	cQuery += "		FROM " + RetSQLName( "SA5" )
	cQuery += "	   WHERE D_E_L_E_T_ = ' ' "
	cQuery += "	     AND A5_FILIAL  = '" + XFilial( "SA5" ) + "' "
	cQuery += "	     AND A5_PRODUTO = '" + cParamProduto    + "' "
	If Select( cAliasA2 ) > 0
		( cAliasA2 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasA2 ) New

	aRetFornecedor := {}
	If !( cAliasA2 )->( Eof() )
		aAdd( aRetFornecedor, ( cAliasA2 )->A5_FORNECE )
		aAdd( aRetFornecedor, ( cAliasA2 )->A5_LOJA    )
	EndIf
	( cAliasA2 )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return aRetFornecedor


*------------------------------------------------------------------*
Static Function FRetVendas( cParamProduto, dParamDtIni, dParamDtFim )
	*-------------------------------------------------------------------*
	Local aAreaAnt 		:= GetArea()
	Local cAliasVendas	:= GetNextAlias()
	Local cQuery 		:= ""

	cQuery := "		SELECT SUM( D2_QUANT ) 	AS [D2_QUANT] 	   					 "  + CRLF
	cQuery += "		  FROM ( 										   			 "  + CRLF
	cQuery += "			SELECT SUM( D2_QUANT )			AS [D2_QUANT] 			 "  + CRLF
	cQuery += "			  FROM " + RetSQLName( "SD2" ) + " SD2		 , 			 "  + CRLF
	cQuery += "			  	   " + RetSQLName( "SF4" ) + " SF4  				 "  + CRLF
	cQuery += "			 WHERE SF4.F4_CODIGO  	 = SD2.D2_TES   				 "  + CRLF
	cQuery += "			   AND SF4.F4_ESTOQUE 	 = 'S'         					 "  + CRLF
	cQuery += "			   AND SD2.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND SF4.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND SF4.F4_FILIAL 	 = '" + XFilial( "SF4" ) 	+ "' "  + CRLF
	cQuery += "			   AND D2_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
	cQuery += "			   AND D2_EMISSAO		>= '" + DToS( dParamDtIni ) + "' "  + CRLF
	cQuery += "			   AND D2_EMISSAO		<= '" + DToS( dParamDtFim ) + "' "  + CRLF
	cQuery += "		  GROUP BY LEFT( D2_EMISSAO, 06 )						   	 "  + CRLF
	cQuery += "			 UNION  										  		 "  + CRLF
	cQuery += "			SELECT SUM( D3_QUANT )			AS [D2_QUANT] 			 "  + CRLF
	cQuery += "			  FROM " + RetSQLName( "SD3" ) + " SD3  				 "  + CRLF
	cQuery += "			 WHERE SD3.D_E_L_E_T_ 	 = ' ' 		 					 "  + CRLF
	cQuery += "			   AND D3_COD		 	 = '" + cParamProduto 		+ "' "  + CRLF
	cQuery += "			   AND D3_EMISSAO		>= '" + DToS( dParamDtIni ) + "' "  + CRLF
	cQuery += "			   AND D3_EMISSAO		<= '" + DToS( dParamDtFim ) + "' "  + CRLF
	cQuery += "			   AND D3_TM      		 > '500' 						 "  + CRLF
	cQuery += "			   AND D3_ESTORNO 		!= 'S'   						 "  + CRLF
	cQuery += "  	  GROUP BY LEFT( D3_EMISSAO, 06 )    					 	 "  + CRLF
	cQuery += "		       ) A 	  												 "  + CRLF

	nRetVendas := 0

	If Select( cAliasVendas ) > 0
		( cAliasVendas )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasVendas ) New
	If !( cAliasVendas )->( Eof() )
		nRetVendas := ( cAliasVendas )->D2_QUANT
	EndIf
	( cAliasVendas )->( DbCloseArea() )

	RestArea( aAreaAnt )

Return nRetVendas

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

	SetPrvt( "oDlgPesquisa","oGrpFiltro","oSayCampo","oSayConteudo","oCmbCampo","oGetConteudo","oBtnPesq" )

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


Static Function FLegenda()

	Local aLegenda  := { { "BR_VERDE"   , "Saldo disponível"	  } ,;
		{ "BR_VERMELHO", "Sem Saldo disponível"  }  }

	BrwLegenda( "Central de Compras", "Legenda", aLegenda )

Return