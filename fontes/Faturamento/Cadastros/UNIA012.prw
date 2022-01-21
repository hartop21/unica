
/*/{Protheus.doc} UNIA012

@project Atualização da tabela de Preços
@description Rotina customizada com o objetivo de realizar a atualização das Tabelas de Preço
@author Rafael Rezende
@since 03/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"

User Function UNIA012S()

	RPCSetEnv( "01", "0101" )

	DbSelectArea( "SB1" )
	DbSetOrder( 01 )
	Seek XFilial( "SB1" ) + "5123"
	U_UNIA012()

	RPCClearEnv()

Return


*---------------------*
User Function UNIA012()
	*---------------------*
	Private cGetCodCategoria 	 := SB1->B1_CATEGOR
	Private cGetCodDepartamento  := SB1->B1_GRUPO
	Private cGetCodLinha		 := SB1->B1_LINHA
	Private cGetCodProduto		 := SB1->B1_COD
	Private cGetDesCategoria	 := Posicione( "SZ1", 01, XFilial( "SZ1" ) + SB1->B1_CATEGOR, "Z1_DESC" )
	Private cGetDesDepartamento  := Posicione( "SBM", 01, XFilial( "SBM" ) + SB1->B1_GRUPO  , "BM_DESC" )
	Private cGetDesLinha 		 := Posicione( "SZ2", 01, XFilial( "SZ2" ) + SB1->B1_LINHA  , "Z2_DESC" )
	Private cGetDesProduto	 	 := SB1->B1_DESC
	Private nGetCusto  			 := FRetCusto( cFilAnt, SB1->B1_COD )
	Private nGetMKIdeal 		 := SB1->B1_MARKUP
	Private nGetMkReal 			 := 0 //nGetCusto // nGetCusto  ( nGetCusto * ( nGetMKIdeal / 100 ) ) -->

	//MARKUP  --> PREÇO / CUSTO
	//MARKUP ATUAL --> NOVO PREÇO / CUSTO

	//CALCULO DO PERCENTUAL
	//( ( NOVO PREÇO / PREÇO ATUAL ) - 1 ) * 100

	//TRATAR GRAVAÇÃO INDIVIDUAL
	//MarkUp 		- MK Ideal
	//Margem 		- MK Real
	//Nova Margem - MK Calculado

	//TRAZER MARKUP - FINAL

	Private nGetMKCalculado 	 := 0
	Private nGetPrcAtual 		 := 0
	Private nGetPercentual 		 := 0
	Private nGetPrcNovo 		 := 0
	Private nAntPercentual 		 := 0
	Private nAntPrcNovo 		 := 0
	Private cTabelaMestre		 := PadR( AllTrim( GetNewPar( "MV_XTABPAD", "001" ) ), TamSX3( "DA1_CODTAB" )[01] )

	Private oOk       			 := LoadBitmap( GetResources() , "LBOK" 	   ) // Marcado
	Private oNo       			 := LoadBitmap( GetResources() , "LBNO" 	   ) // Desmarcado
	Private oVerde      		 := LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
	Private oVermelho   		 := LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho
	Private lMarcaDesmarca 		 := .T.

	Private nPosMarcado			 := 01
	Private nPosEmpresa			 := 02
	Private nPosFilial			 := 03
	Private nPosNomeEmp			 := 04
	Private nPosNomeFil			 := 05

	Private nPosTLegenda		 := 01
	Private nPosTEmpresa		 := 02
	Private nPosTFilial		 	 := 03
	Private nPosTCodigo		 	 := 04
	Private nPosTDescricao	 	 := 05
	Private nPosTRTPossui		 := 06
	Private nPosTRTPercent		 := 07
	Private nPosTCtPossui		 := 08
	Private nPosTCtPercent		 := 09
	Private nPosTPrcAtual		 := 10
	Private nPosTPerAtual		 := 11
	Private nPosTMKFinal		 := 12
	Private nPosTPrcNovo		 := 13
	Private nPosTRecNo			 := 14

	Private aTitListEmpFil 		:= {}
	Private aSizeListEmpFil 	:= {}
	Private aListEmpFil			:= {}
	Private bLinesEmpFil        := { || }

	Private aTitListTabelas 	:= {}
	Private aSizeListTabelas 	:= {}
	Private aListBkpTabelas		:= {}
	Private aListTabelas		:= {}
	Private bLinesTabelas       := { || }

	SetPrvt( "oDlgTabPrc","oGrpEmpresas","oListEmpFil","oGrpAtualizacao","oBtnConfirmar","oBtnSair","oSayCodProduto" )
	SetPrvt( "oGetDesProduto","oSayDepartamento","oGetCodDepartamento","oGetDesDepartamento","oSayCategoria" )
	SetPrvt( "oGetDesCategoria","oSayLinha","oGetCodLinha","oGetDesLinha","oSayPrcAtual","oGetPrcAtual","oSayMKIdeal" )
	SetPrvt( "oSayMKReal","oGetMKReal","oSayCusto","oGetCusto","oSayPrcNovo","oGetPrcNovo","oSayPercentual" )
	SetPrvt( "oSayMKCalculado","oGetMKCalculado","oBtnAtualizar","oGrpTabPreco","oListTabelas" )

	// Valida acesso do usuário através da Opção de Acessos x Rotinas do Configurador
	// 32 -  "Acesso tabela de preços" - Define se o usuário possui acesso à tabela de preços.
	If !VerSenha( 32 )

		MsgStop( "Usuário sem acesso à Tabela de preços." )
		Return

	EndIf

	MsgRun( "Carregando Cadastro de Empresas, aguarde...", "Carregando Cadastro de Empresas, aguarde...", { || FCarregaEmpFil() } )
	MsgRun( "Carregando as tabelas de preços, aguarde...", "Carregando as tabelas de preços, aguarde...", { || FCarregaTabelas() } )

	oDlgTabPrc 					:= MSDialog():New( 127,217,709,1352,"Atualização das tabelas de Preço",,,.F.,,,,,,.T.,,,.F. )

	oGrpEmpresas 				:= TGroup():New( 003,008,103,197," Empresas ",oDlgTabPrc,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListEmpFil 	:= {}
	aSizeListEmpFil := {}
	aAdd( aTitListEmpFil , "" 			)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BB"	   ) )
	aAdd( aTitListEmpFil , "EMP" 			)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BB" 	   ) )
	aAdd( aTitListEmpFil , "FILIAL" 		)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBB" 	   ) )
	aAdd( aTitListEmpFil , "NOME EMPRESA" 	)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBBBBBBB" ) )
	aAdd( aTitListEmpFil , "NOME FILIAL" 	)
	aAdd( aSizeListEmpFil, GetTextWidth( 0, "BBBBBBBB" ) )

	//oListEmpresas := TListBox():New( 014,015,,,175,083,,oGrpEmpresas,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListEmpFil 				:= TwBrowse():New( 014, 015, 175, 083,, aTitListEmpFil, aSizeListEmpFil, oGrpEmpresas,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListEmpFil:SetArray( aListEmpFil )
	bLinesEmpFil				:= { || { 	If( aListEmpFil[oListEmpFil:nAt][nPosMarcado], oOk, oNo )	,; // Marcado
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosEmpresa] ) 			,; // Empresa
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosFilial]  ) 			,; // Filial
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosNomeEmp] ) 			,; // Nome Empresa
		AllTrim( aListEmpFil[oListEmpFil:nAt][nPosNomeFil] ) 			}} // Nome Filial
	oListEmpFil:bLine 	   		:= bLinesEmpFil
	oListEmpFil:bLDblClick 		:= { || FSeleciona( oListEmpFil, @aListEmpFil, nPosFilial, nPosMarcado, 0 ) }
	oListEmpFil:bHeaderClick 	:= { || FSelectAll( oListEmpFil, @aListEmpFil, nPosFilial, nPosMarcado, @lMarcaDesmarca ) }
	oListEmpFil:Refresh()

	oGrpAtualizacao 			:= TGroup():New( 003,204,103,507," Atualização do Preço ",oDlgTabPrc,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayCodProduto 				:= TSay():New( 016,212,{||"Produto:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
	oGetCodProduto 				:= TGet():New( 014,251,,oGrpAtualizacao,065,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cGetCodProduto",,)
	oGetCodProduto:bSetGet 		:= {|u| If(PCount()>0,cGetCodProduto:=u,cGetCodProduto)}
	oGetCodProduto:bWhen 		:= { || .F. }

	oGetDesProduto 				:= TGet():New( 014,321,,oGrpAtualizacao,178,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesProduto",,)
	oGetDesProduto:bSetGet 		:= {|u| If(PCount()>0,cGetDesProduto:=u,cGetDesProduto)}
	oGetDesProduto:bWhen 		:= { || .F. }

	oSayDepartamento 			:= TSay():New( 030,212,{||"Departamento:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
	oGetCodDepartamento 		:= TGet():New( 028,251,,oGrpAtualizacao,038,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SBM","cGetCodDepartamento",,)
	oGetCodDepartamento:bSetGet := {|u| If(PCount()>0,cGetCodDepartamento:=u,cGetCodDepartamento)}
	oGetCodDepartamento:bWhen 	:= { || .F. }

	oGetDesDepartamento 		:= TGet():New( 028,296,,oGrpAtualizacao,204,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesDepartamento",,)
	oGetDesDepartamento:bSetGet := {|u| If(PCount()>0,cGetDesDepartamento:=u,cGetDesDepartamento)}
	oGetDesDepartamento:bWhen 	:= { || .F. }

	oSayCategoria 				:= TSay():New( 044,212,{||"Categoria:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
	oGetCodCategoria 			:= TGet():New( 042,251,,oGrpAtualizacao,038,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SZ1","cGetCodCategoria",,)
	oGetCodCategoria:bSetGet 	:= {|u| If(PCount()>0,cGetCodCategoria:=u,cGetCodCategoria)}
	oGetCodCategoria:bWhen 		:= { || .F. }

	oGetDesCategoria 			:= TGet():New( 042,296,,oGrpAtualizacao,204,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesCategoria",,)
	oGetDesCategoria:bSetGet 	:= {|u| If(PCount()>0,cGetDesCategoria:=u,cGetDesCategoria)}
	oGetDesCategoria:bWhen 		:= { || .F. }

	oSayLinha  					:= TSay():New( 058,212,{||"Linha:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
	oGetCodLinha 				:= TGet():New( 056,251,,oGrpAtualizacao,038,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SZ2","cGetCodLinha",,)
	oGetCodLinha:bSetGet 		:= {|u| If(PCount()>0,cGetCodLinha:=u,cGetCodLinha)}
	oGetCodLinha:bWhen 			:= { || .F. }

	oGetDesLinha 				:= TGet():New( 056,296,,oGrpAtualizacao,204,008,'',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDesLinha",,)
	oGetDesLinha:bSetGet 		:= {|u| If(PCount()>0,cGetDesLinha:=u,cGetDesLinha)}
	oGetDesLinha:bWhen 			:= { || .F. }

	oSayPrcAtual 				:= TSay():New( 072,212,{||"Preço Atual:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
	oGetPrcAtual 				:= TGet():New( 070,251,,oGrpAtualizacao,052,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","nGetPrcAtual",,)
	oGetPrcAtual:bSetGet 		:= {|u| If(PCount()>0,nGetPrcAtual:=u,nGetPrcAtual)}
	oGetPrcAtual:bWhen 			:= { || .F. }

	oSayMKIdeal					:= TSay():New( 072,310,{||"MK.Ideal:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGetMKIdeal 				:= TGet():New( 070,333,,oGrpAtualizacao,023,008,'@E 999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetMKIdeal",,)
	oGetMKIdeal:bSetGet 		:= {|u| If(PCount()>0,nGetMKIdeal:=u,nGetMKIdeal)}
	oGetMKIdeal:bWhen 			:= { || .F. }

	oSayMKReal 					:= TSay():New( 072,367,{||"MK.Real:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
	oGetMKReal 					:= TGet():New( 070,392,,oGrpAtualizacao,023,008,'@E 999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetMkReal",,)
	oGetMKReal:bSetGet 			:= {|u| If(PCount()>0,nGetMkReal:=u,nGetMkReal)}
	oGetMKReal:bWhen 			:= { || .F. }

	oSayCusto  					:= TSay():New( 072,426,{||"Custo Std.:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
	oGetCusto  					:= TGet():New( 070,455,,oGrpAtualizacao,044,008,'@E 999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetCusto",,)
	oGetCusto:bSetGet 			:= {|u| If(PCount()>0,nGetCusto:=u,nGetCusto)}
	oGetCusto:bWhen 			:= { || .F. }

	oSayPrcNovo 				:= TSay():New( 087,212,{||"Novo Preço:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,039,008)
	oGetPrcNovo 				:= TGet():New( 085,251,,oGrpAtualizacao,052,008,'@E 999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","nGetPrcNovo",,)
	oGetPrcNovo:bSetGet 		:= {|u| If(PCount()>0,nGetPrcNovo:=u,nGetPrcNovo)}
	oGetPrcNovo:bValid  		:= { || FVldNovoPreco( 01 ) }

	oSayPercentual 				:= TSay():New( 087,308,{||"%Acres./Decres:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
	oGetPercentual 				:= TGet():New( 085,355,,oGrpAtualizacao,023,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetPercentual",,)
	oGetPercentual:bSetGet 		:= {|u| If(PCount()>0,nGetPercentual:=u,nGetPercentual)}
	oGetPercentual:bWhen 		:= { || .F. }
	//oGetPercentual:bValid  	:= { || FVldNovoPreco( 02 ) }

	oSayMKCalculado 				:= TSay():New( 087,396,{|| "MK.Calcul.:"},oGrpAtualizacao,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,038,008)
	oGetMKCalculado 				:= TGet():New( 085,430,,oGrpAtualizacao,023,008,'@E 999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetMKCalculado",,)
	oGetMKCalculado:bSetGet 		:= {|u| If(PCount()>0,nGetMKCalculado:=u,nGetMKCalculado)}
	oGetMKCalculado:bWhen 		:= { || .F. }

	oBtnAtualizar 				:= TButton():New( 084,465,"Atualizar",oGrpAtualizacao,,035,012,,,,.T.,,"",,,,.F. )
	oBtnAtualizar:bAction 		:= { || Processa( { || FReprocTabela() }, "Reprocessando valores, aguarde..." ) }

	oGrpTabPreco 				:= TGroup():New( 108,008,277,557," Tabelas de Preço ",oDlgTabPrc,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListTabelas  := {}

	aSizeListTabelas := {}
	aAdd( aTitListTabelas , "" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "B"	   			  ) )
	aAdd( aTitListTabelas , "GRP" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBB"	   			  ) )
	aAdd( aTitListTabelas , "EMP" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBB"	 			  ) )
	aAdd( aTitListTabelas , "CODIGO" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBB"	 			  ) )
	aAdd( aTitListTabelas , "DESCRIÇÃO" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBBBBBBBBBBBBBB"  ) )
	aAdd( aTitListTabelas , "RT?" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBB"	 		 	  ) )
	aAdd( aTitListTabelas , "% RT" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBB"	 			  ) )
	aAdd( aTitListTabelas , "CONTRIB.?" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBBB"	 		  ) )
	aAdd( aTitListTabelas , "% CONTRIB." 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBBB"	 		  ) )
	aAdd( aTitListTabelas , "PREÇO ATUAL" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBBBBB"	 		  ) )
	aAdd( aTitListTabelas , "% ATUALIZ." 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBB"	 		  ) )
	aAdd( aTitListTabelas , "MK FINAL"          )
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBBB"	 		  ) )
	aAdd( aTitListTabelas , "PREÇO NOVO" 			)
	aAdd( aSizeListTabelas, GetTextWidth( 0, "BBBBBBBB"	 		  ) )

	//oListTabelas := TListBox():New( 119,016,,,533,148,,oGrpTabPreco,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListTabelas 				:= TwBrowse():New( 119, 016, 533, 148,, aTitListTabelas, aSizeListTabelas, oGrpTabPreco,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListTabelas:SetArray( aListTabelas )
	bLinesTabelas				:= { || {	If( aListTabelas[oListTabelas:nAt][nPosTLegenda], oVerde, oVermelho )		   ,; // Legenda
		AllTrim( aListTabelas[oListTabelas:nAt][nPosTEmpresa]  ) 					   ,; // Empresa
		AllTrim( aListTabelas[oListTabelas:nAt][nPosTFilial]   )		 			   ,; // Filial
		AllTrim( aListTabelas[oListTabelas:nAt][nPosTCodigo]   ) 					   ,; // Código
		AllTrim( aListTabelas[oListTabelas:nAt][nPosTDescricao]) 					   ,; // Descrição
		If( aListTabelas[oListTabelas:nAt][nPosTRTPossui] == "S", "Sim", "Não"  ) ,; // Considera RT?
		TransForm( aListTabelas[oListTabelas:nAt][nPosTRTPercent], "@E 999.99"         ) ,; // % RT
		If( aListTabelas[oListTabelas:nAt][nPosTCtPossui] == "S", "Sim", "Não"  ) ,; // Considera RT?
		TransForm( aListTabelas[oListTabelas:nAt][nPosTCtPercent], "@E 999.99"         ) ,; // % Contribuição
		TransForm( aListTabelas[oListTabelas:nAt][nPosTPrcAtual] , "@E 999,999,999.99" ) ,; // Preço Atual
		TransForm( aListTabelas[oListTabelas:nAt][nPosTPerAtual] , "@E 999.99"         ) ,; // Percentual Atualização
		TransForm( aListTabelas[oListTabelas:nAt][nPosTMKFinal]  , "@E 999.99"         ) ,; // MarkUp Final
		TransForm( aListTabelas[oListTabelas:nAt][nPosTPrcNovo]  , "@E 999,999,999.99" ) }} // Preço Novo
	oListTabelas:bLine 	   		:= bLinesTabelas
	oListTabelas:bLDblClick 	:= { || FSeleciona( oListTabelas, @aListTabelas, nPosTCodigo, 0, nPosTLegenda ) }
	oListTabelas:Refresh()

	oBtnConfirmar 				:= TButton():New( 003,514,"Confirmar",oDlgTabPrc,,043,012,,,,.T.,,"",,,,.F. )
	oBtnConfirmar:bAction 		:= { || FEfetivar() }
	//oBtnConfirmar:Disable()

	oBtnSair   					:= TButton():New( 019,514,"Sair",oDlgTabPrc,,043,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction 			:= { || FSair() }

	oDlgTabPrc:Activate(,,,.T.)

Return


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

*----------------------------------------------------------------------------------------------------------------*
Static Function FSeleciona( oParamListObject, aParamListObject, nParamPosCpo, nParamPosMarcado, nParamPosLegenda )
	*----------------------------------------------------------------------------------------------------------------*
	Local nLinhaGrid 			:= oParamListObject:nAt
	Local lTemMarcado   		:= 0
	Local lTemLegenda           := 0
	Default nParamPosMarcado    := 0
	Default nParamPosLegenda 	:= 0
	lTemMarcado   				:= ( nParamPosMarcado > 0 )
	lTemLegenda         		:= ( nParamPosLegenda > 0 )

	// Linha precisa ser maior que zero
	If nLinhaGrid == 0
		Return
	EndIf

	If Len( aParamListObject ) == 00
		Return
	EndIf

	If ( oParamListObject:nColPos == nParamPosLegenda .And. lTemLegenda )

		FLegenda()

	Else

		If lTemMarcado

			If Len( aParamListObject ) == 01 .And. nLinhaGrid == 01
				If AllTrim( aParamListObject[nLinhaGrid][nParamPosCpo] ) == ""
					Return
				EndIf
			EndIf
			aParamListObject[nLinhaGrid][nParamPosMarcado] := !aParamListObject[nLinhaGrid][nParamPosMarcado]
			oParamListObject:Refresh()

		EndIf

	EndIf

	If lTemMarcado
		//Atualiza a Lista de tabelas de Preços com as Empresas Selecionadas
		MsgRun( "Carregando as tabelas de preços, aguarde...", "Carregando as tabelas de preços, aguarde...", { || FRefreshTabelas() } )
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

	//Atualiza a Lista de tabelas de Preços com as Empresas Selecionadas
	MsgRun( "Carregando as tabelas de preços, aguarde...", "Carregando as tabelas de preços, aguarde...", { || FRefreshTabelas() } )

Return

*---------------------------*
Static Function FAtuCalculo()
	*---------------------------*

Return .T.

*-------------------------------*
Static Function FCarregaTabelas()
	*-------------------------------*
	Local cAliasTab 	:= GetNextAlias()
	//Local nPercRT 	:= GetNewPar( "MV_XPERRT" , 3.00 )
	//Local nPercContr  := GetNewPar( "MV_XPERCON", 5.50 )
	Local aJaFoi 		:= {}

	aListBkpTabelas := {}
	aListTabelas 	:= {}
	For nE := 01 To Len( aListEmpFil )

		If aListEmpFil[nE][nPosMarcado]

			cQuery := "	 SELECT DA0_FILIAL  ,  "
			cQuery += "	  		DA0_CODTAB	,  "
			cQuery += "	  		DA0_DESCRI	,  "
			cQuery += "	  		DA1_CODPRO  ,  "
			cQuery += "	  		DA0_XRT		,  "
			cQuery += "	  		DA0_XPERRT	,  "
			cQuery += "	  		DA0_XCONTR	,  "
			cQuery += "	  		DA0_XPERCO	,  "
			cQuery += "	  		DA1_PRCVEN	,  "
			cQuery += "	  		DA1.R_E_C_N_O_ AS NUMRECDA1     "
			cQuery += "	  FROM " + RetSQLName( "DA0" ) + " DA0, "
			cQuery += "	       " + RetSQLName( "DA1" ) + " DA1  "
			cQuery += "	 WHERE DA0.D_E_L_E_T_  = ' ' "
			cQuery += "	   AND DA1.D_E_L_E_T_  = ' ' "
			cQuery += "	   AND DA0.DA0_FILIAL  = DA1.DA1_FILIAL "
			cQuery += "	   AND DA0.DA0_CODTAB  = DA1.DA1_CODTAB "
			cQuery += "	   AND DA0.DA0_FILIAL  = '" + Left( AllTrim( aListEmpFil[nE][nPosFilial] ), 02 ) + "' "
			cQuery += "	   AND DA1.DA1_CODPRO  = '" + cGetCodProduto			  + "' "
			cQuery += "	   AND DA0_ATIVO  NOT IN ( '2', 'N' ) "
			If Select( cAliasTab ) > 0
				( cAliasTab )->( DbCloseArea() )
			EndIf
			TcQuery cQuery Alias ( cAliasTab ) New
			Do While !( cAliasTab )->( Eof() )

				If aScan( aJaFoi, { |x| ( AllTrim( x[01] ) == AllTrim( ( cAliasTab )->DA0_FILIAL ) .And. ;
						AllTrim( x[02] ) == AllTrim( ( cAliasTab )->DA0_CODTAB ) ) } ) == 0

					lEhMestra := .F.
					If AllTrim( cTabelaMestre )	 	   == AllTrim( ( cAliasTab )->DA0_CODTAB ) .And. ;
							Left( AllTrim( cFilAnt ), 02 )  == AllTrim( ( cAliasTab )->DA0_FILIAL )
						nGetPrcAtual := ( cAliasTab )->DA1_PRCVEN
						nGetMkReal	 := ( ( ( nGetPrcAtual / nGetCusto ) - 1 ) * 100 )
						lEhMestra 	 := .T.
					EndIf

					nAuxPerRT 		:= Iif( AllTrim( ( cAliasTab )->DA0_XRT    ) == "S", ( cAliasTab )->DA0_XPERRT	, 0 )
					nAuxPerContrib 	:= Iif( AllTrim( ( cAliasTab )->DA0_XCONTR ) == "S", ( cAliasTab )->DA0_XPERCO	, 0 )
					aAdd( aListTabelas, { lEhMestra						, ;
						aListEmpFil[nE][nPosEmpresa]	, ;
						( cAliasTab )->DA0_FILIAL		, ;
						( cAliasTab )->DA0_CODTAB		, ;
						( cAliasTab )->DA0_DESCRI		, ;
						( cAliasTab )->DA0_XRT		, ;
						nAuxPerRT						, ;
						( cAliasTab )->DA0_XCONTR   	, ;
						nAuxPerContrib			  	, ;
						( cAliasTab )->DA1_PRCVEN	  	, ;
						0								, ;
						( ( ( ( cAliasTab )->DA1_PRCVEN / nGetCusto ) -1 ) * 100 ), ;
						( cAliasTab )->DA1_PRCVEN		, ;
						( cAliasTab )->NUMRECDA1		} )

					aAdd( aJaFoi, { ( cAliasTab )->DA0_FILIAL, ( cAliasTab )->DA0_CODTAB } )

				EndIf

				DbSelectArea( cAliasTab )
				( cAliasTab )->( DbSkip() )
			EndDo
			( cAliasTab )->( DbCloseArea() )

		EndIf

	Next nE

	If Len( aListTabelas ) == 0

		aAdd( aListTabelas, { .F.	, ;
			""	, ;
			"" 	, ;
			""	, ;
			""	, ;
			""	, ;
			0		, ;
			""   	, ;
			0  	, ;
			0	  	, ;
			0		, ;
			0		, ;
			0		, ;
			0		} )

	EndIf

	aListBkpTabelas := aClone( aListTabelas )

Return


*--------------------------*
Static Function FEfetivar()
	*--------------------------*
	Local cAuxMensagem	:= ""
	Private oProcessBar := Nil

	cAuxMensagem := "Você confirma a efetivação da simulação de Novo Preço abaixo?" + CRLF+ CRLF
	cAuxMensagem += "Obs.: Essa opção irá EFETIVAR AS ALTERAÇÕES realizadas NAS TABELAS DE PREÇO SELECIONADAS EM AMBIENTE DE PRODUÇÃO."
	If Aviso( "Atenção", cAuxMensagem, { "Sim", "Não" } ) == 01

		oBtnConfirmar:Disable()
		oGetPrcNovo:bWhen 	 := { || .F. }
		oGetPercentual:bWhen := { || .F. }
		oGetPrcNovo:Refresh()
		oGetPercentual:Refresh()
		oProcessBar := MsNewProcess():New( { |lEnd| FAtuTabelas( @lEnd ) }, "Atualizando tabelas, aguarde...", "Atualizando tabelas, aguarde...", .F. )
		oProcessBar:Activate()
		Aviso( "Atenção", "Atualização da tabela de Preços concluída com sucesso.", { "Ok" } )

	EndIf

Return

*---------------------------------*
Static Function FAtuTabelas( lEnd )
	*---------------------------------*
	Local aAreaAnt := GetArea()

	DbSelectArea( "DA1" )
	DbSetOrder( 01 )

	oProcessBar:SetRegua1( Len( aListEmpFil ) )
	For nE := 01 To Len( aListEmpFil )

		oProcessBar:IncRegua1( "Atualizando Filial [ " + AllTrim( aListEmpFil[nE][nPosFilial] ) + "-" + AllTrim( aListEmpFil[nE][nPosNomeFil] )+ " ]" )

		//Nova Solicitação para fazer por Empresa
		If aListEmpFil[nE][nPosMarcado]

			oProcessBar:SetRegua2( Len( aListBkpTabelas ) )
			For nT := 01 To Len( aListBkpTabelas )

				oProcessBar:IncRegua2( "Atualizando Tabela [ " + AllTrim( aListBkpTabelas[nT][nPosTCodigo] ) + "-" + SubStr( AllTrim( aListBkpTabelas[nT][nPosTDescricao] ), 15 ) + " ]" )
				If ( AllTrim( aListEmpFil[nE][nPosEmpresa] ) == AllTrim( aListBkpTabelas[nT][nPosTEmpresa] ) .And. ;
						Left( AllTrim( aListEmpFil[nE][nPosFilial]  ), 02 ) == Left( AllTrim( aListBkpTabelas[nT][nPosTFilial]  ), 02 ) )

					DbSelectArea( "DA1" )
					DA1->( DbGoTo( aListBkpTabelas[nT][nPosTRecNo] ) )
					RecLock( "DA1", .F. )
					DA1->DA1_PRCVEN := aListBkpTabelas[nT][nPosTPrcNovo]
					DA1->( MsUnLock() )

				EndIf

			Next nT

		EndIf

	Next nE

	RestArea( aAreaAnt )

Return

*-------------------------------*
Static Function FRefreshTabelas()
	*-------------------------------*
	Local nY 			 := 0
	Local cListaEmpresas := ""
	Local cListaFiliais  := ""

	For nY := 01 To Len( aListEmpFil )

		If aListEmpFil[nY][nPosMarcado]

			If !( AllTrim( aListEmpFil[nY][nPosEmpresa] ) $ cListaEmpresas )
				cListaEmpresas += AllTrim( aListEmpFil[nY][nPosEmpresa] ) + ","
			EndIf
			If !( Left( AllTrim( aListEmpFil[nY][nPosFilial] ), 02 ) $ cListaFiliais )
				cListaFiliais += Left( AllTrim( aListEmpFil[nY][nPosFilial] ), 02 ) + ","
			EndIf

		EndIf

	Next nY

	aListTabelas := {}
	For nY := 01 To Len( aListBkpTabelas )

		If ( AllTrim( aListBkpTabelas[nY][nPosTEmpresa] ) $ cListaEmpresas ) .And. ;
				( Left( AllTrim( aListBkpTabelas[nY][nPosTFilial]  ), 02 ) $ cListaFiliais  )
			aAdd( aListTabelas, aClone( aListBkpTabelas[nY] ) )
		EndIf

	Next nY

	If Len( aListTabelas ) == 0

		aAdd( aListTabelas, { .F.	, ;
			""	, ;
			"" 	, ;
			""	, ;
			""	, ;
			""	, ;
			0		, ;
			""   	, ;
			0  	, ;
			0	  	, ;
			0		, ;
			0		, ;
			0		, ;
			0		} )

	EndIf

	oListTabelas:SetArray( aListTabelas )
	oListTabelas:bLine := bLinesTabelas
	oListTabelas:Refresh()

Return


Static Function FVldNovoPreco( nParamTipo )

	Local lRetPrc 		:= .T.
	Local nAuxDiferenca := 0
	Local nAuxMargem 	:= 0

	If nParamTipo == 01 // Campo de Novo Preço

		If nGetPrcNovo == 0
			nGetPercent := 0
			Return .T.
		EndIf

		// Foi informado o Novo Preço, proceder com a atualização do campo de %
		nGetPercent := Round( ( ( ( nGetPrcNovo / nGetPrcAtual ) - 1 ) * 100 ), 04 )
		oGetPercent:Refresh()
		/*
ElseIf nParamTipo == 02 // Acréscimo / Descrescimo

	If nGetPercent == 0
		nGetPrcNovo := 0
		Return .T.
	EndIf

	// Foi informado o Percentual de Acréscimo / Descrescimo, proceder com a atualização do campo de Novo Preço
	//nGetAuxPrc  := Round( ( nGetPrcAtual + ( nGetPrcAtual * ( nGetPercent / 100 ) ) ), 04 )
	//If nGetPrcNovo == 0
	//	nGetPrcNovo := nGetAuxPrc
	//	oGetPrcNovo:Refresh()
	//EndIf
	nGetPrcNovo  := Round( ( nGetPrcAtual + ( nGetPrcAtual * ( nGetPercent / 100 ) ) ), 04 )
	//nGetPercent := Round( ( ( ( nGetPrcNovo / nGetPrcAtual ) - 1 ) * 100 ), 04 )
	oGetPrcNovo:Refresh()
		*/
	Else

		Return .T.

	EndIf

	// Cálculo da Margem
	//MARKUP - --> Preco de Venda / CUSTO
	nGetMKCalculado := ( ( ( nGetPrcNovo / nGetCusto ) -1 ) * 100 ) //* ( nGetMKIdeal / 100 ) )
	oGetMKCalculado:Refresh()

	// Caso a Diferença entre o Preço digitado e Preço Ideal seja menor que a Margem o sistema deverá informar ao usuário e impedir a atualização do Produto.
	If nGetMKCalculado < nGetMkIdeal

		cAuxMensagem := "O [ Novo Preço ] e/ou [ % Acresc/Decresc. ] informado não poderá ser considerado, pois a diferença entre o Preço Atual e o Novo Preços ficou abaixo do MarkUp Ideal." + CRLF
		cAuxMensagem += "Preço Atual : " 		+ AllTrim( TransForm( nGetPrcAtual	 , "@E 999,999,999.99" ) ) + CRLF
		cAuxMensagem += "Novo Preço : " 		+ AllTrim( TransForm( nGetPrcNovo 	 , "@E 999,999,999.99" ) ) + CRLF
		cAuxMensagem += "% MarkUp Ideal : " 	+ AllTrim( TransForm( nGetMkIdeal	 , "@E 999.99"    	   ) ) + CRLF
		cAuxMensagem += "% MarkUp Calculado : "	+ AllTrim( TransForm( nGetMKCalculado, "@E 999.99"    	   ) ) + CRLF
		cAuxMensagem += "% Acres./Decres.: " 	+ AllTrim( TransForm( nGetPercent 	 , "@E 999.99"    	   ) )

		Aviso( "Atenção", cAuxMensagem, { "Voltar" }, 03 )
		//lRetPrc := .T.

	EndIf

	If lRetPrc

		If ( nAntPercentual == nGetPercentual .Or. ;
				nAntPrcNovo	== nGetPrcNovo )
		Else
			//oBtnConfirmar:Disable()
			//oBtnAtualizar:Enable()
		EndIf

	EndIf

Return lRetPrc



Static Function FLegenda()

	Local aLegenda  := { { "BR_VERDE"   , "Tabela Mestre"	  } ,;
		{ "BR_VERMELHO", "Tabela Secundária" }  }

	BrwLegenda( "Atualização Tab. Preços", "Legenda", aLegenda )

Return

*-----------------------------*
Static Function FReprocTabela()
	*-----------------------------*
	Local nR 				:= 00
	Local nAuxPrc   		:= 00
	Local cAuxMensagem 		:= ""
	Local nAuxRT 			:= 0
	Local nAuxContribuicoes	:= 0
	LocaL cListaEmpresas    := ""
	Local cListaFiliais 	:= ""
	If nGetPrcNovo == 0
		Aviso( "Atenção", "Será necessário informar o [ Novo Preço ] para prosseguir com a Atualização.", { "Voltar" } )
		Return
	EndIf

	If nGetPercent == 0
		Aviso( "Atenção", "Será necessário informar o [ % Acres./Decres. ] para prosseguir com a Atualização.", { "Voltar" } )
		Return
	EndIf

	cAuxMensagem := "Você confirma a Simulação de Novo Preço para as informações abaixo:" 			   	+ CRLF
	cAuxMensagem += "Preço Atual: " 	 	+ AllTrim( TransForm( nGetPrcAtual	 , "@E 999,999,999.99" 	) ) + CRLF
	cAuxMensagem += "Novo Preço : " 	 	+ AllTrim( TransForm( nGetPrcNovo 	 , "@E 999,999,999.99" 	) ) + CRLF
	cAuxMensagem += "% MarkUp Ideal: " 	 	+ AllTrim( TransForm( nGetMkIdeal 	 , "@E 999.99" 			) ) + CRLF
	cAuxMensagem += "% MarkUp Calculado : " + AllTrim( TransForm( nGetMKCalculado, "@E 999.99" 			) ) + CRLF
	cAuxMensagem += "% Acres./Decres.: " 	+ AllTrim( TransForm( nGetPercent 	 , "@E 999.99" 			) )
	If Aviso( "Atenção", cAuxMensagem, { "Sim", "Não"  }, 03 ) == 01

		cListaEmpresas := ""
		For nY := 01 To Len( aListEmpFil )

			If aListEmpFil[nY][nPosMarcado]

				If !( AllTrim( aListEmpFil[nY][nPosEmpresa] ) $ cListaEmpresas )
					cListaEmpresas += AllTrim( aListEmpFil[nY][nPosEmpresa] ) + ","
				EndIf
				If !( Left( AllTrim( aListEmpFil[nY][nPosFilial] ), 02 ) $ cListaFiliais )
					cListaFiliais += Left( AllTrim( aListEmpFil[nY][nPosFilial] ), 02 ) + ","
				EndIf

			EndIf

		Next nY

		// Reprocessa o Valor do Produto para cada uma das Tabelas
		ProcRegua( Len( aListBkpTabelas ) )
		For nR := 01 To Len( aListBkpTabelas )

			IncProc()

			If ( AllTrim( aListBkpTabelas[nR][nPosTEmpresa] ) $ cListaEmpresas ) .And. ;
					( Left( AllTrim( aListBkpTabelas[nR][nPosTFilial]  ), 02 ) $ cListaFiliais  )

				// Pega o novo Preço Informado
				//nAuxPrc := nGetPrcNovo
				nAuxPrc := aListBkpTabelas[nR][nPosTPrcAtual]

				// Verifica o % de RT
				nAuxRT 	:= 0
				If aListBkpTabelas[nR][nPosTRTPercent] > 0
					nAuxRT 	:= ( nAuxPrc * ( aListBkpTabelas[nR][nPosTRTPercent] / 100 ) )
				EndIf

				// Verifica o % de Contribuições
				nAuxContribuicoes 	:= 0
				If aListBkpTabelas[nR][nPosTCtPercent] > 0
					nAuxContribuicoes 	:= ( nAuxPrc * ( aListBkpTabelas[nR][nPosTCtPercent] / 100 ) )
				EndIf

				//Aplica % de Ajuste de Preço
				nAuxAjuste := ( nAuxPrc * ( nGetPercent / 100 ) )

				//Calcula o Novo preço
				nAuxPrc += nAuxRT
				nAuxPrc += nAuxContribuicoes
				nAuxPrc += nAuxAjuste

				//Atualiza a Matriz
				aListBkpTabelas[nR][nPosTPrcNovo]  := nAuxPrc
				aListBkpTabelas[nR][nPosTPerAtual] := nGetPercent
				//aListBkpTabelas[nR][nPosTMKFinal]  := If( nGetPercent > 0, "Acrescimo", "Decrescimo" )
				aListBkpTabelas[nR][nPosTMKFinal]  := ( ( ( nAuxPrc / nGetCusto ) -1 ) * 100 )

			EndIf

		Next nR

		//Atualiza a Lista de tabelas de Preços com as Empresas Selecionadas
		MsgRun( "Carregando as tabelas de preços, aguarde...", "Carregando as tabelas de preços, aguarde...", { || FRefreshTabelas() } )

		nAntPercent	:= nGetPercent
		nAntPrcNovo := nGetPrcNovo
		//oBtnConfirmar:Enable()
		//oBtnAtualizar:Disable()

	EndIf

Return

*---------------------*
Static Function FSair()
	*---------------------*

	If Aviso( "Atenção", "Você confirma a saída da rotina de Atualização de Tabelas de Preço?", { "Sim", "Não" } ) == 01
		oDlgTabPrc:End()
	EndIf

Return

*------------------------------------------------------*
Static Function FRetCusto( cParamFilial, cParamProduto )
	*------------------------------------------------------*
	Local aAreaAtu 	:= GetArea()
	Local aAreaSBZ 	:= SBZ->( GetArea() )
	Local nRetCusto := 0

	DbSelectArea( "SBZ" )
	DbSetOrder( 01 )
	Seek cParamFilial + cParamProduto
	If Found()
		nRetCusto := SBZ->BZ_CUSTD
	EndIf

	RestArea( aAreaSBZ )
	RestArea( aAreaAtu )

Return nRetCusto