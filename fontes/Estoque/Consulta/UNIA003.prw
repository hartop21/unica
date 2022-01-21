
/*/{Protheus.doc} UNIA003

@project Consulta Unificada de Saldo em Estoque
@description Implementação de Tela customizada que permita a realização de filtros para a pesquisa de estoque Unificada
@author Rafael Rezende
@since 22/03/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"

User Function UNIA003TST()

	Prepare Environment Empresa "01" Filial "0101"

	U_UNIA003()

	Reset Environment

Return

*---------------------*
User Function UNIA003()
	*---------------------*
	Private nTamEmpFil			:= 04
	Private nTamProduto			:= TamSX3( "B1_COD"     )[01]
	Private nTamDescricao		:= TamSX3( "B1_DESC"    )[01]
	Private nTamCategoria		:= TamSX3( "B1_CATEGOR" )[01]
	Private nTamLinha			:= TamSX3( "B1_LINHA"   )[01]
	Private nTamGrupo			:= TamSX3( "B1_GRUPO"   )[01]
	Private nTamArmazem			:= TamSX3( "B1_LOCPAD"  )[01]
	Private cGetEmpFil 			:= Space( nTamEmpFil 	   )
	Private cGetDescric 		:= Space( nTamDescricao    )

	Private nPosELegenda		:= 01
	Private nPosEProduto		:= 02
	Private nPosEDescricao		:= 03
	Private nPosEArmazem		:= 04
	Private nPosALegenda		:= 01
	Private nPosAProduto		:= 02
	Private nPosADescricao		:= 03
	Private nPosAArmazem		:= 04

	Private aAuxEBLines			:= {}
	Private aAuxABLines			:= {}
	Private aListEstoque 		:= {}
	Private aListAlternativos 	:= {}
	Private bLinesEstoque 		:= { || }
	Private bLineAlternativos 	:= { || }

	Private oVerde      		:= LoadBitmap( GetResources(), "BR_VERDE"  	 ) // Vendas
	Private oVermelho   		:= LoadBitmap( GetResources(), "BR_VERMELHO" ) // Integrado

	Public cGetGrupo			:= Space( nTamGrupo 	)
	Public cGetProduto 			:= Space( nTamProduto 	)
	Public cGetCategoria 		:= Space( nTamCategoria )
	Public cGetLinha  			:= Space( nTamLinha 	)

	Private cGetEmpList 		:= ""
	Private cGetProdList		:= ""

	//Precisa ser Pública pois está sendo utilizada pelas consultas padrões
	Public cGetDepList	 		:= ""
	Public cGetCatList 			:= ""
	Public cGetLinList 			:= ""

	SetPrvt("oDlgConsulta","oGrpFiltro","oSayEmpFil","oSayProduto","oSayDescric","oSayDepartamento","oSayCateg")
	SetPrvt("oGetEmpFil","oGetEmpList","oBtnLimpEmp","oGetProduto","oGetProdList","oBtnLimpProd","oGetDescric")
	SetPrvt("oGetDepList","oBtnLimpDep","oGetCategoria","oGetCatList","oBtnLimpCat","oGetLinha","oGetLinList")
	SetPrvt("oBtnConsultar","oBtnSair")

	oDlgConsulta 				:= MsDialog():New( 127,254,391,1288,"Consulta de Estoque",,,.F.,,,,,,.T.,,,.F. )

	oGrpFiltro 	 				:= TGroup():New( 004,008,117,456," Filtros ",oDlgConsulta,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSayEmpFil	 				:= TSay():New( 020,016,{||"Empresa / Filial:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetEmpFil		 			:= TGet():New( 018,060,,oGrpFiltro,031,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SM0","cGetEmpFil",,)
	oGetEmpFil:bSetGet		 	:= {|u| If(PCount()>0,cGetEmpFil:=u,cGetEmpFil)}
	oGetEmpFil:bValid 			:= { || FVldEmpFil() }

	oGetEmpLis 					:= TGet():New( 018,125,,oGrpFiltro,277,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetEmpList",,)
	oGetEmpList:bSetGet 		:= {|u| If(PCount()>0,cGetEmpList:=u,cGetEmpList)}
	oGetEmpList:bWhen		 	:= { || .F. }

	oSayProduto   				:= TSay():New( 036,016,{||"Produto:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetProduto 				:= TGet():New( 034,060,,oGrpFiltro,053,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"FILSB1","cGetProduto",,)
	oGetProduto:bSetGet 		:= {|u| If(PCount()>0,cGetProduto:=u,cGetProduto)}
	oGetProduto:bValid 			:= { || FVldProduto() }

	oGetProdList 				:= TGet():New( 034,125,,oGrpFiltro,277,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetProdList",,)
	oGetProdList:bSetGet		:= {|u| If(PCount()>0,cGetProdList:=u,cGetProdList)}
	oGetProdList:bWhen 			:= { || .F. }

	oSayDescric  				:= TSay():New( 052,016,{||"Descrição"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetDescric					:= TGet():New( 050,060,,oGrpFiltro,342,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDescric",,)
	oGetDescric:bSetGet 		:= {|u| If(PCount()>0,cGetDescric:=u,cGetDescric)}
	oGetDescric:bValid 			:= { || FVldDescricao() }

	oSayDepartamento 			:= TSay():New( 068,016,{||"Departamento:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetDepartamento 			:= TGet():New( 066,060,,oGrpFiltro,044,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SBM","cGetGrupo",,)
	oGetDepartamento:bSetGet 	:= {|u| If(PCount()>0,cGetGrupo:=u,cGetGrupo)}
	oGetDepartamento:bValid 	:= { || FVldDepartamento() }

	oGetDepList 				:= TGet():New( 066,125,,oGrpFiltro,277,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDepList",,)
	oGetDepList:bSetGet 		:= {|u| If(PCount()>0,cGetDepList:=u,cGetDepList)}
	oGetDepList:bWhen 			:= { || .F. }

	oSayCategoria  				:= TSay():New( 084,016,{||"Categoria:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetCategoria 				:= TGet():New( 082,060,,oGrpFiltro,044,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"FILSZ1","cGetCategoria",,)
	oGetCategoria:bSetGet 		:= {|u| If(PCount()>0,cGetCategoria:=u,cGetCategoria)}
	oGetCategoria:bValid 		:= { || FVldCategoria() }

	oGetCatList 				:= TGet():New( 082,125,,oGrpFiltro,277,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCatList",,)
	oGetCatList:bSetGet 		:= {|u| If(PCount()>0,cGetCatList:=u,cGetCatList)}
	oGetCatList:bWhen 			:= { || .F. }

	oSayLinha  					:= TSay():New( 100,016,{||"Linha:"},oGrpFiltro,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
	oGetLinha  					:= TGet():New( 098,060,,oGrpFiltro,044,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"FILSZ2","cGetLinha",,)
	oGetLinha:bSetGet 			:= {|u| If(PCount()>0,cGetLinha:=u,cGetLinha)}
	oGetLinha:bValid 			:= { || FVldLinha() }

	oGetLinList					:= TGet():New( 098,125,,oGrpFiltro,277,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetLinList",,)
	oGetLinList:bSetGet 		:= {|u| If(PCount()>0,cGetLinList:=u,cGetLinList)}
	oGetLinList:bWhen 			:= { || .F. }

	oBtnLimpEmp 				:= TButton():New( 016,408,"Limpar",oGrpFiltro,,037,012,,,,.T.,,"",,,,.F. )
	oBtnLimpEmp:bAction 		:= { || FLimpaEmp() }

	oBtnLimpProd 				:= TButton():New( 032,408,"Limpar",oGrpFiltro,,037,012,,,,.T.,,"",,,,.F. )
	oBtnLimpProd:bAction 		:= { || FLimpaProd() }

	oBtnLimpDep 				:= TButton():New( 064,408,"Limpar",oGrpFiltro,,037,012,,,,.T.,,"",,,,.F. )
	oBtnLimpDep:bAction 		:= { || FLimpDep() }

	oBtnLimpCat 				:= TButton():New( 080,408,"Limpar",oGrpFiltro,,037,012,,,,.T.,,"",,,,.F. )
	oBtnLimpCat:bAction 		:= { || FLimpaCat() }

	oBtnLimpLin 				:= TButton():New( 096,408,"Limpar",oGrpFiltro,,037,012,,,,.T.,,"",,,,.F. )
	oBtnLimpLin:bAction 		:= { || FLimpaLin() }

	oBtnConsul 					:= TButton():New( 008,464,"Consultar",oDlgConsulta,,037,012,,,,.T.,,"",,,,.F. )
	oBtnConsultar:bAction 		:= { || FConsulta() }

	oBtnSair   					:= TButton():New( 024,464,"Sair",oDlgConsulta,,037,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction 			:= { || oDlgConsulta:End() }

	oDlgConsulta:Activate(,,,.T.)

Return

*-------------------------*
Static Function FConsulta()
	*-------------------------*
	Private aEmpresas 	:= {}
	aListEstoque		:= {}

	//Private cGetEmpList 		:= ""
	//Private cGetProdList		:= ""

	//Precisa ser Pública pois está sendo utilizada pelas consultas padrões
	//Public cGetDepList	 		:= ""
	//Public cGetCatList 			:= ""
	//Public cGetLinList 			:= ""

	aEmpresas			:= {}
	aListEstoque		:= {}
	aListAlternativos	:= {}
	lParamWebService 	:= .F.
	Processa( { || U_UNIRetConsulta( lParamWebService, cGetEmpList, cGetProdList, cGetDepList, cGetCatList, cGetLinList, "", @aEmpresas, @aListEstoque, .F. ) }, "Carregando informações, aguarde..." )
	FMostraTela( aEmpresas )

Return


Static Function FMostraTela( aParamEmpresas )

	Local cPictSld := X3Picture( "B2_QATU" )

	SetPrvt("oDlgEstoque","oGrpProdutos","oGrpAlternativos","oListEstoque","oListAlternativos")

	oDlgEstoque 	:= MSDialog():New( 215,196,788,1320,"Consulta de Produtos em Estoque Unificada",,,.F.,,,,,,.T.,,,.F. )
	oGrpProdutos 	:= TGroup():New( 000,008,183,548," Produtos em Estoque ",oDlgEstoque,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	//Tratativa da Grid Dinâmica
	aTitListEstoque := {}
	aAdd( aTitListEstoque, "LG" 		)
	aAdd( aTitListEstoque, "PRODUTO" 	)
	aAdd( aTitListEstoque, "DESCRICAO" 	)
	aAdd( aTitListEstoque, "ARMZ" 		)
	For nCols := 01 To Len( aParamEmpresas )
		aAdd( aTitListEstoque, "[" + AllTrim( aParamEmpresas[nCols][01] ) + "-" + Left( aParamEmpresas[nCols][02], 10 ) + "]" )
	Next nCols

	aSizeListEstoque := {}
	aAdd( aSizeListEstoque, GetTextWidth( 0, "BBBBB" 			) )
	aAdd( aSizeListEstoque, GetTextWidth( 0, "BBBBBB" 			) )
	aAdd( aSizeListEstoque, GetTextWidth( 0, "BBBBBBBBBBBBBB" 	) )
	aAdd( aSizeListEstoque, GetTextWidth( 0, "BBBB"				) )
	For nCols := 01 To Len( aParamEmpresas )
		aAdd( aSizeListEstoque, GetTextWidth( 0, "BBBBBBBB"     ) )
	Next nCols

	oListEstoque := TWBrowse():New( 011		, 015	 , 526		, 165		,		  , aTitListEstoque	, aSizeListEstoque, oGrpProdutos,		   ,		   ,		   ,		   ,			  ,			  ,			,			,			 ,			  ,		   , .F.		,		   , .T.	  ,			, .F.		 ,			,			 ,			   )
	oListEstoque:SetArray( aListEstoque )

	cbLinesEstoque   := "{ || { If( aListEstoque[oListEstoque:nAt][nPosELegenda] > 0, oVerde, oVermelho ) , " 	// Legenda
	cbLinesEstoque   += "  AllTrim( aListEstoque[oListEstoque:nAt][nPosEProduto]   ) , " 	// Produto
	cbLinesEstoque   += "  AllTrim( aListEstoque[oListEstoque:nAt][nPosEDescricao] ) , " 	// Descricao
	cbLinesEstoque   += "  AllTrim( aListEstoque[oListEstoque:nAt][nPosEArmazem]   ) "    	// Armazem
	For nCols := 01 To Len( aParamEmpresas )
		cbLinesEstoque   += ", " +  "AllTrim( TransForm( aListEstoque[oListEstoque:nAt]["  + StrZero( nPosEArmazem + nCols, 02 ) + "], '" + AllTrim( cPictSld ) + "'  ) ) " // Saldos
	Next nCols
	cbLinesEstoque   += "} } "
	oListEstoque:bLine	:= &cbLinesEstoque // { || &cbLinesEstoque }

	oListEstoque:bChange 	:= { || FCarregaAlternativos( .T. ) }
	oListEstoque:Refresh()

	oGrpAlternativo := TGroup():New( 188,008,269,548," Produtos Alternativos ",oDlgEstoque,CLR_HRED,CLR_WHITE,.T.,.F. )

	//Tratativa da Grid Dinâmica
	aTitListAlternativos  	:= aClone( aTitListEstoque  )
	aSizeListAlternativos 	:= aClone( aSizeListEstoque )

	oListAlternativos := TWBrowse():New( 198		, 015	 , 525		, 065		,		  , aTitListAlternativos, aSizeListAlternativos	, oGrpAlternativos	,		   ,		   ,		   ,		   ,			  ,			  ,			,			,			 ,			  ,		   , .F.		,		   , .T.	  ,			, .F.		 ,			,			 ,			   )
	oListAlternativos:SetArray( aListAlternativos )

	cbLinesAlternativo   := "{ || { If( aListAlternativos[oListAlternativos:nAt][nPosALegenda] > 0, oVerde, oVermelho ), "  	// Legenda
	cbLinesAlternativo   += "  AllTrim( aListAlternativos[oListAlternativos:nAt][nPosAProduto]   ) , " 	// Produto
	cbLinesAlternativo   += "  AllTrim( aListAlternativos[oListAlternativos:nAt][nPosADescricao] ) , "  	// Descricao
	cbLinesAlternativo   += "  AllTrim( aListAlternativos[oListAlternativos:nAt][nPosAArmazem]	 )  "    	// Armazem
	For nCols := 01 To Len( aParamEmpresas )
		cbLinesAlternativo   += ", " + "AllTrim( TransForm( aListAlternativos[oListAlternativos:nAt]["  + StrZero( nPosAArmazem + nCols, 02 ) + "], '" + AllTrim( cPictSld ) + "'  ) ) " // Saldos
	Next nCols
	cbLinesAlternativo   += "} } "
	oListAlternativos:bLine	:= &cbLinesAlternativo//{ || &cbLinesAlternativo }
	oListAlternativos:Refresh()

	oDlgEstoque:Activate(,,,.T.)

Return

*----------------------------------------*
Static Function FRetBLines( aParamBLines )
	*----------------------------------------*

Return aClone( aParamBLines )

*---------------------------------------------------*
Static Function FCarregaAlternativos( lParamRefresh )
	*---------------------------------------------------*
	Local nPosLinha 		:= oListEstoque:nAt
	Local cAliasQry 		:= GetNextAlias()
	Local cQuery  		  	:= ""
	Default lParamRefresh 	:= .F.

	aListAlternativos 		:= {}
	If nPosLinha >= 01

		If AllTrim( aListEstoque[nPosLinha][nPosEProduto] ) != ""

			cQuery := " SELECT 	DISTINCT 		   		    "
			cQuery += "	 		B1_COD 		AS [PRODUTO]  ,	"
			cQuery += "			B1_TIPO 	AS [TIPO]	  ,	"
			cQuery += "			B1_DESC 	AS [DESCRIC]  ,	"
			cQuery += "			B1_LOCPAD 	AS [ARMAZEM]   	"
			cQuery += "	   FROM " + RetSQLName( "SGI" ) + " SGI, "
			cQuery += "	        " + RetSQLName( "SB1" ) + " SB1  "
			cQuery += "	  WHERE SGI.D_E_L_E_T_ = ' ' 	"
			cQuery += "	    AND SB1.D_E_L_E_T_ = ' ' 	"
			cQuery += "		AND SGI.GI_PRODALT = B1_COD "
			cQuery += "		AND SGI.GI_PRODORI = '" + aListEstoque[nPosLinha][nPosEProduto] + "' "
			If Select( cAliasQry ) > 0
				( cAliasQry )->( DbCloseArea() )
			EndIf
			TcQuery cQuery Alias ( cAliasQry ) New
			Do While !( cAliasQry )->( Eof() )

				// Carrega os Produtos Alternativos
				aAux := aClone( aListEstoque[nPosLinha] )
				aAux[nPosALegenda] := 0  // Legenda
				aAux[nPosAProduto] := ( cAliasQry )->PRODUTO 	// Produto
				aAux[nPosADescric] := ( cAliasQry )->DESCRIC 	// Descrição
				aAux[nPosAArmazem] := ( cAliasQry )->ARMAZEM 	// Armazem

				For nY := 01 To Len( aEmpresas )
					aAux[nPosAArmazem + nY]  := 0
					aAux[nPosALegenda]	     := 0
				Next nY

				For nY := 01 To Len( aEmpresas )
					nSaldo := U_UNIRetSldProd( aEmpresas[nY][01], ( cAliasQry )->TIPO, ( cAliasQry )->PRODUTO )
					aAux[nPosAArmazem + nY]  += nSaldo
					aAux[nPosALegenda]	     += nSaldo
				Next nY
				aAdd( aListAlternativos, aAux )

				DbSelectArea( cAliasQry )
				( cAliasQry )->( DbSkip() )
			EndDo
			( cAliasQry )->( DbCloseArea() )

		EndIf

		If Len( aListAlternativos ) == 0

			aAux := aClone( aListEstoque[nPosLinha] )
			aAux[nPosALegenda] := 0  // Legenda
			aAux[nPosAProduto] := "" // Produto
			aAux[nPosADescric] := "" // Descrição
			aAux[nPosAArmazem] := "" // Armazem
			For nY := 01 To Len( aEmpresas )
				aAux[nPosAArmazem + nY]  := 0
				aAux[nPosALegenda]	     := 0
			Next nY
			aAdd( aListAlternativos, aAux )

		EndIf

		If lParamRefresh

			if Type("oListAlternativos") <> "U"
				oListAlternativos:SetArray( aListAlternativos )
				oListAlternativos:bLine := &cbLinesAlternativo
				oListAlternativos:Refresh()
			endif

		EndIf

	EndIf

Return

/*
*-------------------------------------------------------------*
Static Function FCarregaConsulta( aParamEmpresas, cParamAlias )
*-------------------------------------------------------------*
Local aAreaAnt 			:= GetArea()
Local aAreaSM0  		:= SM0->( GetArea() )
Local cQuery 			:= ""
Local cAliasSld 	 	:= ""
Default aParamEmpresas 	:= {}

aParamEmpresas := {}
DbSelectArea( "SM0" )
SM0->( DbGoTop() )
Do While !SM0->( Eof() )

	If AllTrim( SM0->M0_CODIGO ) != "99"

		If AllTrim( cGetEmpList ) == ""
			aAdd( aParamEmpresas, { SM0->M0_CODFIL, SM0->M0_FILIAL } )
		Else
			If ( AllTrim( SM0->M0_CODFIL ) $ AllTrim( cGetEmpList ) )
				aAdd( aParamEmpresas, { SM0->M0_CODFIL, SM0->M0_FILIAL } )
			EndIf
		EndIf

	EndIf

	SM0->( DbSkip() )
EndDo

aJaProcessou := {}
cQuery 		 := ""

//For nEmpresa := 01 To Len( aParamEmpresas )

//	If aScan( aJaProcessou, { |x| AllTrim( x ) == AllTrim( aParamEmpresas[nEmpresa][01] ) } ) > 0
//	 	Loop
//	EndIf

//	If Len( aJaProcessou ) > 0
//		cQuery += "  UNION 	"
//	EndIf

	cQuery := " SELECT 	DISTINCT 					  "
	cQuery += "			B1_COD    		AS [PRODUTO], "	// Codigo
	cQuery += "			B1_DESC   		AS [DESCRIC], "	// Descricao
	cQuery += "			B1_LOCPAD 		AS [ARMAZEM], "	// Armazem Pad.
	cQuery += "			B1_TIPO			AS [TIPO]  	  "	// Tipo
	cQuery += "    FROM " + RetSQLName( "SB1" )
	cQuery += "   WHERE D_E_L_E_T_  = ' '  "
	If AllTrim( cGetProdList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_COD ) )      IN " + FormatIN( cGetProdList, "," )
	EndIf
	If AllTrim( cGetDepList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_GRUPO ) )    IN " + FormatIN( cGetDepList, "," )
	EndIf
	If AllTrim( cGetCatList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_CATEGOR ) )  IN " + FormatIN( cGetCatList, "," )
	EndIf
	If AllTrim( cGetLinList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_LINHA ) )    IN " + FormatIN( cGetLinList, "," )
	EndIf
	//cQuery += "     AND B1_XFLUIG	= 'S'  "
//	aAdd( aJaProcessou, aParamEmpresas[nEmpresa][01] )

//Next nEmpresa

//cParamAlias := CriaTrab( Nil, .F. )
//If FCriaTemp( cParamAlias, aParamEmpresas )

	aListEstoque := {}
	cAliasSld 	 := GetNextAlias()
	If Select( cAliasQry ) > 0
		( cAliasSld )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSld ) New
	aListEstoque := {}
	Do While !( cAliasSld )->( Eof() )

		nPosLinha := aScan( aListEstoque, { |x| AllTrim( x[nPosEProduto] ) == AllTrim( ( cAliasSld )->PRODUTO ) } )
		If nPosLinha == 0

			aAuxLinha := {}
			aAdd( aAuxLinha, 0 						)
			aAdd( aAuxLinha, ( cAliasSld )->PRODUTO  )
			aAdd( aAuxLinha, ( cAliasSld )->DESCRIC )
			aAdd( aAuxLinha, ( cAliasSld )->ARMAZEM )
			For nE := 01 To Len( aParamEmpresas )
				aAdd( aAuxLinha, 0 )
			Next nE
			aAdd( aListEstoque, aClone( aAuxLinha ) )
			nPosLinha := Len( aListEstoque )

		EndIf

		// Atualiza o Saldo do Produto para cada Empresa
		For nE := 01 To Len( aParamEmpresas )

			nSaldo := U_UNIRetSldProd( aParamEmpresas[nE][01], ( cAliasSld )->TIPO, ( cAliasSld )->PRODUTO )
			aListEstoque[nPosLinha][nPosEArmazem + nE] += nSaldo
			aListEstoque[nPosLinha][nPosELegenda]	   += nSaldo

		Next nE

		DbSelectArea( cAliasSld )
		( cAliasSld )->( DbSkip() )
	EndDo
	( cAliasSld )->( DbCloseArea() )

//EndIf

If Len( aListEstoque ) == 0

	aAux := {}
	aAdd( aAux, 0  ) // Legenda
	aAdd( aAux, "" ) // Produto
	aAdd( aAux, "" ) // Descrição
	aAdd( aAux, "" ) // Armazem
	For nE := 01 To Len( aParamEmpresas )
		aAdd( aAux, 0 ) // Saldo
	Next nE
	aAdd( aListEstoque, aClone( aAux ) )

EndIf

If Len( aListAlternativos ) == 0

	aAux := {}
	aAdd( aAux, 0  ) // Legenda
	aAdd( aAux, "" ) // Produto
	aAdd( aAux, "" ) // Descrição
	aAdd( aAux, "" ) // Armazem
	For nE := 01 To Len( aParamEmpresas )
		aAdd( aAux, 0 ) // Saldo
	Next nE
	aAdd( aListAlternativos, aClone( aAux ) )

EndIf

Return
*/

/*
*------------------------------------------------------*
Static Function FCriaTemp( cParamAlias, aParamEmpresas )
*------------------------------------------------------*
Local aAreaAnterior := GetArea()
Local aEstrutura    := {}
Local lRetCriou 	:= .T.
Local aTamSaldo 	:= TamSX3( "B2_QATU"  )
Default cParamAlias := CriaTrab( Nil, .F. )

aEstrutura := {}
aAdd( aEstrutura, { "C_EMPFIL" , "C", nTamEmpFil		, 00 } )
aAdd( aEstrutura, { "C_NOMEFI" , "C", nTamDescricao 	, 00 } )
aAdd( aEstrutura, { "C_PRODUTO", "C", nTamProduto 	, 00 } )
aAdd( aEstrutura, { "C_DESCRIC", "C", nTamDescricao 	, 00 } )
aAdd( aEstrutura, { "C_ARMAZEM", "C", nTamArmazem 	, 00 } )
For nZ := 01 To Len( aParamEmpresas )
	aAdd( aEstrutura, { "N_SLD" + aParamEmpresas[nZ][01], "N", aTamSaldo[01] 	, aTamSaldo[02] }  )
Next nZ

If Select ( cParamAlias ) > 0
	( cParamAlias )->( DbCloseArea() )
EndIf
If TcCanOpen( cParamAlias )
	TcDelFile( cParamAlias )
EndIf

cExistTable := "IF EXISTS ( SELECT name                         "
cExistTable += "              FROM sysobjects (NOLOCK)          "
cExistTable += "             WHERE type = 'U'                   "
cExistTable += "               AND name = '" + cParamAlias + "' ) "
cExistTable += "	DROP TABLE " + cParamAlias
If TcSQLExec( cExistTable ) != 0
    ConOut( "	[UNIA003] - Atenção", "Erro ao tentar apagar o arquivo da tabela temporária [ " + cParamAlias + " ] existente." )
EndIf

lAchou		:= .F.
cAliasAchou := "TRBACHOU"
cExistTable := "	SELECT COUNT( * ) AS NACHOU 		 "
cExistTable += "      FROM sysobjects (NOLOCK)    	     "
cExistTable += "     WHERE type = 'U'               	 "
cExistTable += "       AND name = '" + cParamAlias + "'  "
If Select( cAliasAchou ) > 0
	( cAliasAchou )->( DbCloseArea() )
EndIf
TcQuery cExistTable Alias ( cAliasAchou ) New
If !( cAliasAchou )->( Eof() )
	lAchou := ( ( cAliasAchou )->NACHOU > 0 )
EndIf
( cAliasAchou )->( DbCloseArea() )

If lAchou
	Aviso( "Atenção", "Não foi possível realizar a exclusão da tabela temporária [ " + _cAliasTmp + " ]. Por favor tente novamente, caso o problema persista, contate o Administrador do Sistema.", { "Sair" } )

	If TcSQLExec( "DROP TABLE " + cAliasAchou ) != 0
		Aviso( "Atenção", "Mensagem do erro: " + CRLF + TcSQLError(), { "Sair" } )
	EndIf
	lRetCriou := .F.
    RestArea( aAreaAnterior )

Else

	DbCreate( cParamAlias, aEstrutura, "TOPCONN" )
	DbUseArea( .T., "TOPCONN", cParamAlias, cParamAlias, .T. )
	DbSelectArea( cParamAlias )

EndIf

Return lRetCriou
*/

*-------------------------*
Static Function FLimpaEmp()
	*-------------------------*
	cGetEmpList := ""
	oGetEmpList:Refresh()

Return

*--------------------------*
Static Function FLimpaProd()
	*--------------------------*

	cGetProdList := ""
	oGetProdList:Refresh()

Return


Static Function FLimpDep()


	cGetDepList := ""
	oGetDepList:Refresh()

Return

*-------------------------*
Static Function FLimpaCat()
	*-------------------------*

	cGetCatList := ""
	oGetCatList:Refresh()

Return

*-------------------------*
Static Function FLimpaLin()
	*-------------------------*

	cGetLinList := ""
	oGetLinList:Refresh()

Return


*---------------------------*
Static Function FVldEmpFil()
	*---------------------------*
	Local aAreaAnt := GetArea()
	Local aAreaSM0 := SM0->( GetArea() )
	Local lRetVld := .T.

	If AllTrim( cGetEmpFil ) != ""

		DbSelectArea( "SM0" )
		DbSetOrder( 01 )
		Seek cEmpAnt + cGetEmpFil
		If Found()

			cGetEmpList := cGetEmpList + IIf( AllTrim( cGetEmpList ) == "", "", "," ) + AllTrim( cGetEmpFil )
			oGetEmpList:Refresh()

			cGetEmpFil := Space( 04 )
			oGetEmpFil:SetFocus()

		Else

			Aviso( "Atenção", "A [ Empresa / Filial ] informada não existe.", { "Voltar" } )
			lRetVld := .F.

		EndIf

	EndIf

	RestArea( aAreaSM0 )
	RestArea( aAreaAnt )

Return lRetVld

*---------------------------*
Static Function FVldProduto()
	*---------------------------*
	Local aAreaAnt 	:= GetArea()
	Local lRetVld 	:= .T.

	If AllTrim( cGetProduto ) != ""

		DbSelectArea( "SB1" )
		DbSetOrder( 01 ) // B1_FILIAL + B1_COD
		Seek XFilial( "SB1" ) + PadR( AllTrim( cGetProduto ), nTamProduto )
		If Found()

			cGetProdList := cGetProdList + IIf( AllTrim( cGetProdList ) == "", "", "," ) + AllTrim( cGetProduto )
			oGetProdList:Refresh()

			cGetProduto := Space( nTamProduto )
			oGetProduto:SetFocus()

		Else

			Aviso( "Atenção", "O [ Produto ] informado não existe.", { "Voltar" } )
			lRetVld := .F.

		EndIf

	EndIf

	RestArea( aAreaAnt )

Return lRetVld


*-----------------------------*
Static Function FVldDescricao()
	*-----------------------------*
	Local aAreaAnt 	:= GetArea()
	Local lRetVld 	:= .T.

	If AllTrim( cGetDescric ) != ""

		cQuery := " B1_DESC LIKE '%" + Replace( AllTrim( cGetDescric ), " ", "%" ) + "%'"
		aRetProdutos := {}
		aRetProdutos := U_RGRSelMultiplos( "SB1", "B1_COD", "B1_DESC", .F., "", "Consulta de Produtos", .F., 02, cQuery, "", .F., .F., .F. )
		//				  RGRSelMultiplos( _cAlias, _cCpoCodigo, _cCpoDescricao, _lEhMvPar, _cVarMvPar, _cTitulo, _lFilFilial, _nOrdem, _cSQLFiltro, _cTabelaSX5, _lRetTodos, _lSelTodos, _lApenasUm )


		If ValType( aRetProdutos ) != "A"
			Aviso( "Atenção", "Não encontrou informações", { "Voltar" } )
			MsgYesNo( "Não encontrou informações" )
			Return .F.
		EndIf

		If Len( aRetProdutos ) > 0

			For nP := 01 To Len( aRetProdutos )

				If aRetProdutos[nP][01]
					cGetProdList := cGetProdList + IIf( AllTrim( cGetProdList ) == "", "", "," ) + AllTrim( aRetProdutos[nP][05] )
					oGetProdList:Refresh()
				EndIf

			Next nP

			cGetDescric := Space( nTamDescricao )
			oGetDescric:SetFocus()

		EndIf

	EndIf

	RestArea( aAreaAnt )

Return lRetVld

*--------------------------------*
Static Function FVldDepartamento()
	*--------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local lRetVld 	:= .T.

	If AllTrim( cGetGrupo ) != ""

		DbSelectArea( "SBM" )
		DbSetOrder( 01 )
		Seek XFilial( "SBM" ) + cGetGrupo
		If Found()

			cGetDepList := cGetDepList + IIf( AllTrim( cGetDepList ) == "", "", "," ) + AllTrim( cGetGrupo )
			oGetDepList:Refresh()

			cGetGrupo := Space( nTamGrupo )
			oGetDepartamento:SetFocus()

		Else

			Aviso( "Atenção", "O [ Departamento ] informado não existe.", { "Voltar" } )
			lRetVld := .F.

		EndIf

	EndIf

	RestArea( aAreaAnt )

Return lRetVld

*-----------------------------*
Static Function FVldCategoria()
	*-----------------------------*
	Local aAreaAnt 	:= GetArea()
	Local lRetVld 	:= .T.

	If AllTrim( cGetCategoria ) != ""

		DbSelectArea( "SZ1" )
		DbSetOrder( 01 )
		Seek XFilial( "SZ1" ) + cGetCategoria
		If Found()

			cGetCatList := cGetCatList + IIf( AllTrim( cGetCatList ) == "", "", "," ) + AllTrim( cGetCategoria )
			oGetCatList:Refresh()

			cGetCategoria := Space( nTamCategoria )
			oGetCategoria:SetFocus()

		Else

			Aviso( "Atenção", "A [ Categoria ] informada não existe.", { "Voltar" } )
			lRetVld := .F.

		EndIf

	EndIf

	RestArea( aAreaAnt )

Return lRetVld

*-------------------------*
Static Function FVldLinha()
	*-------------------------*
	Local aAreaAnt 	:= GetArea()
	Local lRetVld 	:= .T.

	If AllTrim( cGetLinha ) != ""

		DbSelectArea( "SZ2" )
		DbSetOrder( 01 )
		Seek XFilial( "SZ2" ) + cGetLinha
		If Found()

			cGetLinList := cGetLinList + IIf( AllTrim( cGetLinList ) == "", "", "," ) + AllTrim( cGetLinha )
			oGetLinList:Refresh()

			cGetLinha := Space( nTamLinha )
			oGetLinha:SetFocus()

		Else

			Aviso( "Atenção", "A [ Linha ] informada não existe.", { "Voltar" } )
			lRetVld := .F.

		EndIf

	EndIf

	RestArea( aAreaAnt )

Return lRetVld

/*
#################################################################################################
Private cGetEmpresa 	:= Space( 50 )
Private cGetGrupo  		:= Space( 50 )
Private cGetProduto 	:= Space( 50 )
Private nGetSldTotal 	:= 0

Private aListEmpresa 	:= {}
Private aListGrupo		:= {}
Private aListProduto	:= {}
Private aListConsulta   := {}

Private nPosEMarcado	:= 01
Private nPosEFilial		:= 02
Private nPosEEmpresa	:= 03
Private nPosENomeEmp	:= 04
Private nPosENomeFil	:= 05

Private nPosGMarcado	:= 01
Private nPosGCodigo		:= 02
Private nPosGDescric	:= 03
Private nPosGRecNo  	:= 04

Private nPosPMarcado	:= 01
Private nPosPCodigo		:= 02
Private nPosPDescric	:= 03
Private nPosPArmazem	:= 04
Private nPosPGrupo		:= 05
Private nPosPRecNo  	:= 06

Private nPosCEmpresa	:= 01
Private nPosCFilial 	:= 02
Private nPosCCodigo		:= 03
Private nPosCArmazem	:= 04
Private nPosCNome	  	:= 05
Private nPosCSldAtu  	:= 06
Private nPosCSldPV  	:= 07
Private nPosCSldEmp		:= 08
Private nPosCSldRes		:= 09

Private bLinesEmpresa 	:= { || }
Private bLinesGrupo 	:= { || }
Private bLinesProduto 	:= { || }
Private bLinesConsulta 	:= { || }

Private oOk       		:= LoadBitmap( GetResources() , "LBOK" ) // Marcado
Private oNo       		:= LoadBitmap( GetResources() , "LBNO" ) // Desmarcado

Private oVerde      	:= LoadBitmap( GetResources(), "BR_VERDE"  	 ) // Vendas
Private oVermelho   	:= LoadBitmap( GetResources(), "BR_VERMELHO" ) // Integrado

SetPrvt("oDlgConsulta","oGrpFiltros","oSayEmpresa","oSayGrupo","oSayProduto","oListEmpresa","oListGrupo")
SetPrvt("oGetEmpresa","oGetGrupo","oListProduto","oGrpConsulta","oSaySldTotal","oGetSldTotal","oListConsulta")
SetPrvt("oBtnSair")

aListEmpresa 	:= { { .F., "", "", "", "" } }
aListGrupo		:= { { .F., "", "", 0 } }
aListProduto	:= { { .F., "", "", "", "", 0 } }
aListConsulta   := { { "", "", "", "", "", 0, 0, 0, 0 } }

oDlgConsulta 		:= MSDialog():New( 130,238,699,1346,"Consulta de Saldo de Estoque Unificada por Empresa",,,.F.,,,,,,.T.,,,.F. )

oGrpFiltro 			:= TGroup():New( 000,008,072,540," Filtros ",oDlgConsulta,CLR_HBLUE,CLR_WHITE,.T.,.F. )

oSayEmpres 			:= TSay():New( 010,016,{||"Empresa: "},oGrpFiltros,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
oGetEmpresa 		:= TGet():New( 008,040,,oGrpFiltros,134,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetEmpresa",,)
oGetEmpresa:bSetGet := {|u| If(PCount()>0,cGetEmpresa:=u,cGetEmpresa)}

//oListEmpresa 		:= TListBox():New( 022,012,,,163,042,,oGrpFiltros,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
@ 022, 012 ListBox oListEmpresa Fields Header "X", "CODIGO", "DESCRICAO" Size 163, 042 ColSizes GetTextWidth( 0, "BB"), GetTextWidth( 0, "BBBBB"), GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ) Of oGrpFiltros Pixel
oListEmpresa:SetArray( aListEmpresa )
bLinesEmpresa	:= { || { 	   		If( aListEmpresa[oListEmpresa:nAt][nPosEMarcado], oVerde,oVermelho ),; // Marcado
							   AllTrim( aListEmpresa[oListEmpresa:nAt][nPosEEmpresa] ) 					,; // Empresa
							   AllTrim( aListEmpresa[oListEmpresa:nAt][nPosEFilial] ) 					,; // Filial
							   AllTrim( aListEmpresa[oListEmpresa:nAt][nPosENomeEmp] ) 					,; // Nome Empresa
							   AllTrim( aListEmpresa[oListEmpresa:nAt][nPosENomeFil] ) 					}} // Nome Filial
oListEmpresa:bLine 	   		:= bLinesEmpresa
oListEmpresa:bLDblClick 	:= { || FSeleciona( "E" ) }
oListEmpresa:bHeaderClick 	:= { || FSelectAll( "E" ) }
oListEmpresa:Refresh()

oSayGrupo  			:= TSay():New( 010,183,{||"Grupo de Produtos:"},oGrpFiltros,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oGetGrupo  			:= TGet():New( 008,232,,oGrpFiltros,070,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SBM","cGetGrupo",,)
oGetGrupo:bSetGet 	:= {|u| If(PCount()>0,cGetGrupo:=u,cGetGrupo)}

//oListGrupo 			:= TListBox():New( 022,180,,,122,042,,oGrpFiltros,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
@ 022,180 ListBox oListGrupo Fields Header "X", "CODIGO", "DESCRICAO" Size 122,042 ColSizes GetTextWidth( 0, "BB"), GetTextWidth( 0, "BBBBB"), GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ) Of oGrpFiltros Pixel
oListGrupo:SetArray( aListGrupo )
bLinesGrupo	:= { || {  			    If( aListGrupo[oListGrupo:nAt][nPosGMarcado], oVerde,oVermelho ),; // Marcado
							   AllTrim( aListGrupo[oListGrupo:nAt][nPosGCodigo] ) 					,; // Código Grupo
							   AllTrim( aListGrupo[oListGrupo:nAt][nPosGDescric] ) 					}} // Descrição
oListGrupo:bLine 		:= bLinesGrupo
oListGrupo:bLDblClick 	:= { || FSeleciona( "G" ) }
oListGrupo:bHeaderClick := { || FSelectAll( "G" ) }
oListGrupo:Refresh()

oSayProduto			:= TSay():New( 010,308,{||"Produto: "},oGrpFiltros,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGetProduto 		:= TGet():New( 008,337,,oGrpFiltros,153,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cGetProduto",,)
oGetProduto:bSetGet := {|u| If(PCount()>0,cGetProduto:=u,cGetProduto)}

//oListProduto 		:= TListBox():New( 022,308,,,182,042,,oGrpFiltros,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
@ 022, 308 ListBox oListProduto Fields Header "X", "CODIGO", "DESCRICAO", "ARMAZ", "GRUPO" Size 182, 042 ColSizes GetTextWidth( 0, "BB"), GetTextWidth( 0, "BBBBB"), GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ), GetTextWidth( 0, "BB"), GetTextWidth( 0, "BBBB") Of oGrpFiltros Pixel
oListProduto:SetArray( aListProduto )
bLinesProduto	:= { || {  			If( aListProduto[oListProduto:nAt][nPosPMarcado], oVerde,oVermelho )		,; // Marcado
							   AllTrim( aListProduto[oListProduto:nAt][nPosPCodigo] ) 							,; // Código Produto
							   AllTrim( aListProduto[oListProduto:nAt][nPosPDescric] ) 							,; // Descrição
							   AllTrim( aListProduto[oListProduto:nAt][nPosPArmazem] ) 							,; // Armazem
							   AllTrim( aListProduto[oListProduto:nAt][nPosPGrupo] ) 							}} // Código do Grupo
oListProduto:bLine 			:= bLinesProduto
oListProduto:bLDblClick 	:= { || FSeleciona( "P" ) }
oListProduto:bHeaderClick 	:= { || FSelectAll( "P" ) }
oListProduto:Refresh()

oGrpConsulta 		:= TGroup():New( 080,008,256,540," Saldo em Estoque",oDlgConsulta,CLR_HBLUE,CLR_WHITE,.T.,.F. )
oSaySldTotal 		:= TSay():New( 264,008,{||"Saldo Total em Estoque:"},oDlgConsulta,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oGetSldTotal 		:= TGet():New( 262,068,,oDlgConsulta,078,008,'@E 999,999,999.99',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGetSldTotal",,)
oGetSldTotal:bSetGet:= {|u| If(PCount()>0,nGetSldTotal:=u,nGetSldTotal)}
oGetSldTotal:bWhen 	:= { || .F. }

//oListConsuta 		:= TListBox():New( 091,015,,,517,156,,oGrpConsulta,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
@ 091, 015 ListBox oListConsuta Fields Header "LG", "EM", "FL", "CODIGO", "ARMAZ", "DESCRICAO", "SLD. ATU", "SLD. P.V.", "SLD. EMP", "SLD. RES." Size 517, 156 ColSizes GetTextWidth( 0, "BB"), GetTextWidth( 0, "BB"), GetTextWidth( 0, "BBBBB"), GetTextWidth( 0, "BB"), GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ), GetTextWidth( 0, "9999" ), GetTextWidth( 0, "9999" ), GetTextWidth( 0, "9999" ), GetTextWidth( 0, "9999" ) Of oGrpConsulta Pixel
oListConsuta:SetArray( aListConsuta )
bLinesConsulta	:= { || {  			If( aListConsuta[oListConsuta:nAt][nPosCSldAtu] == 0, oVermelho, oVerde )	,; // Legenda
							   AllTrim( aListConsuta[oListConsuta:nAt][nPosCEmpresa] ) 							,; // Empresa
					  		   AllTrim( aListConsuta[oListConsuta:nAt][nPosCFilial]  )							,; // Filial
					  		   AllTrim( aListConsuta[oListConsuta:nAt][nPosCCodigo]  )							,; // Código do Produto
					  		   AllTrim( aListConsuta[oListConsuta:nAt][nPosCArmazem] )							,; // Armazém
					  		   AllTrim( aListConsuta[oListConsuta:nAt][nPosCNome] 	 )							,; // Nome
					AllTrim( TransForm( aListConsuta[oListConsuta:nAt][nPosCSldAtu], "@E 999.99" ) )			,; // Saldo Atual
					AllTrim( TransForm( aListConsuta[oListConsuta:nAt][nPosCSldPV] , "@E 999.99" ) )			,; // Saldo P.V.
					AllTrim( TransForm( aListConsuta[oListConsuta:nAt][nPosCSldEmp], "@E 999.99" ) )			,; // Saldo Empenho
					AllTrim( TransForm( aListConsuta[oListConsuta:nAt][nPosCSldRes], "@E 999.99" ) )			}} // Saldo Reservado
oListConsuta:bLine 			:= bLinesConsulta
//oListConsuta:bLDblClick 	:= { || FSeleciona() }
//oListConsuta:bHeaderClick := { || FSelectAll() }
oListConsuta:Refresh()

oBtnPesquisar 		:= TButton():New( 008,495,"Pesquisar",oGrpFiltros,,037,012,,,,.T.,,"",,,,.F. )
oBtnSair   			:= TButton():New( 024,495,"Sair",oGrpFiltros,,037,012,,,,.T.,,"",,,,.F. )

oDlgConsulta:Activate(,,,.T.)

Return
*/