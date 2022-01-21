
/*/{Protheus.doc} UNIRetPreco

@project Biblioteca do Projeto Única
@description Bibilioteca de funções de reaproveitamento do projeto Unica
@author Rafael Rezende
@since 08/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"


User Function UNIRetPreco( cParamProduto, cParamTabela, cParamFilial )

	Local aAreaAnt 			:= GetArea()
	Local aAreaDA1 			:= DA1->( GetArea() )
	Local nRet 				:= 0
	Default cParamTabela 	:= PadR( AllTrim( GetNewPar( "MV_XTABPAD", "001" ) ), TamSX3( "DA1_CODTAB" )[01] )
	Default cParamFilial    := XFilial( "DA1" )

	//ConOut( "	- UNIXFUN - UNIRetPreco - cParamFilial - " + cParamFilial )
	//ConOut( "	- UNIXFUN - UNIRetPreco - cParamTabela - " + cParamTabela )
	DbSelectArea( "DA1" )
	DbSetOrder( 01 ) // DA1_FILIAL + DA1_CODTAB + DA1_CODPRO + DA1_INDLOT + DA1_ITEM
	Seek cParamFilial + cParamTabela + cParamProduto
	If Found()
		nRet := DA1->DA1_PRCVEN
	Else
		nRet := 0
	EndIf

	RestArea( aAreaDA1 )
	RestArea( aAreaAnt )

Return nRet


User Function PrcDesc( cCodigoFilial, cProduto, cTabelaPreco, cCondPg, nQuant, cCliente, cLoja )

	Local aAreaAnt 			:= GetArea()
	Local aAreaDA1 			:= DA1->( GetArea() )
	Local aAreaSB1 			:= SB1->( GetArea() )
	Local nRet 				:= 0
	Local cFilBkp := cFilAnt
	cFilAnt := cCodigoFilial

	cFilAnt := cCodigoFilial

	cProduto := PadR(cProduto, TamSX3("B1_COD")[1])
	DbSelectArea("SB1")
	dbSetOrder(1)
	If dbSeek(XFilial("SB1")+cProduto)
		nRet := MaTabPrVen(cTabelaPreco, cProduto, nQuant, cCliente, cLoja)
		nDesconto := MaRgrDesc(cProduto, cCliente, cLoja, cTabelaPreco, nQuant, cCondPg, "", 2, NIL, {},/*cCodRegDe*/, nRet)

		nRet := Round((1 - nDesconto/100) * nRet, 2)
	EndIf


	cFilAnt := cFilBkp
	RestArea( aAreaSB1 )
	RestArea( aAreaDA1 )
	RestArea( aAreaAnt )

Return nRet



User Function UNIRetSldProd( cParamEmpFil, cParamTipo, cParamProduto )

	Local aAreaAtu 	:= GetArea()
	Local nRet 		:= 0
	Local cQuery 	:= ""
	Local cAliasSld := "SLDTMP"

	nRet 			:= 0
	If AllTrim( cParamTipo ) == "PA"

		cQuery := "	SELECT ISNULL( SUM( B2_QATU - B2_QEMP - B2_RESERVA ), 0 ) SALDO " + CRLF
		cQuery += "	  FROM " + RetSQLName( "SB2" ) + " SB2 "
		cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
		cQuery += "	   AND B2_FILIAL  = '" + cParamEmpFil  + "' "
		cQuery += "	   AND B2_COD     = '" + cParamProduto + "' "
		cQuery += "	   AND B2_LOCAL   = '01' "
		If Select( cAliasSld ) > 0
			( cAliasSld )->( DbCloseArea() )
		EndIf
		TcQuery cQuery Alias ( cAliasSld ) New
		If !( cAliasSld )->( Eof() )
			nRet := ( cAliasSld )->SALDO
		EndIf
		( cAliasSld )->( DbCloseArea() )

	Else

		aRetKit := FRetEstrutura( cParamProduto )

		nQtdProducaoPossivel := 0
		If Len( aRetKit ) > 0

			// 01 - Código do Componente
			// 02 - Quantidade para Produção
			// 03 - Saldo em Estoque do Componente
			// 04 - Quantidade Possível de Produção
			nPosCodigo 			 := 01
			nPosQtdComponente 	 := 02
			nPosSldComponente    := 03
			nPosQtdPossivel      := 04

			For nK := 01 To Len( aRetKit )

				// Tratativa para Conjuntos ( Kits )
				cQuery := "	SELECT ISNULL( SUM( B2_QATU - B2_QEMP - B2_RESERVA ), 0 ) SALDO " + CRLF
				cQuery += "	  FROM " + RetSQLName( "SB2" ) + " SB2 "
				cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
				cQuery += "	   AND B2_FILIAL  = '" + cParamEmpFil 			 + "' "
				cQuery += "	   AND B2_COD     = '" + aRetKit[nK][nPosCodigo] + "' "
				cQuery += "	   AND B2_LOCAL   = '01' "
				If Select( cAliasSld ) > 0
					( cAliasSld )->( DbCloseArea() )
				EndIf
				TcQuery cQuery Alias ( cAliasSld ) New
				If !( cAliasSld )->( Eof() )

					aRetKit[nK][nPosSldComponente] := ( cAliasSld )->SALDO
					If aRetKit[nK][nPosSldComponente] >= aRetKit[nK][nPosQtdComponente] // Quantidade necessária para a Produção
						If aRetKit[nK][nPosSldComponente] == aRetKit[nK][nPosQtdComponente]
							aRetKit[nK][nPosQtdPossivel] := 1
						Else
							aRetKit[nK][nPosQtdPossivel] := Int( ( cAliasSld )->SALDO / aRetKit[nK][nPosQtdComponente] )
						EndIf
					Else
						aRetKit[nK][nPosQtdPossivel] := 0
					EndIf

				EndIf
				( cAliasSld )->( DbCloseArea() )

			Next nK

			If Len( aRetKit ) > 0

				nRet 	:= aRetKit[01][nPosQtdPossivel]
				For nK  := 01 To Len( aRetKit )

					If aRetKit[nK][nPosQtdPossivel] == 0
						nRet := 0
						Exit
					Else

						If aRetKit[nK][nPosQtdPossivel] != 0
							If nRet > aRetKit[nK][nPosQtdPossivel]
								nRet := aRetKit[nK][nPosQtdPossivel]
							EndIf
						EndIf

					EndIf

				Next nK

			EndIf

		Else

			nRet   := 0
			cQuery := "	SELECT ISNULL( SUM( B2_QATU - B2_QEMP - B2_RESERVA ), 0 ) SALDO " + CRLF
			cQuery += "	  FROM " + RetSQLName( "SB2" ) + " SB2 "
			cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
			cQuery += "	   AND B2_FILIAL  = '" + cParamEmpFil  + "' "
			cQuery += "	   AND B2_COD     = '" + cParamProduto + "' "
			cQuery += "	   AND B2_LOCAL   = '01' "
			If Select( cAliasSld ) > 0
				( cAliasSld )->( DbCloseArea() )
			EndIf
			TcQuery cQuery Alias ( cAliasSld ) New
			If !( cAliasSld )->( Eof() )
				nRet := ( cAliasSld )->SALDO
			EndIf
			( cAliasSld )->( DbCloseArea() )

		EndIf

	EndIf

	Conout("UNIRetSldProd - Produto: "+AllTrim(cParamProduto)+" - Saldo: "+cValtoChar(nRet))

	RestArea( aAreaAtu )

Return nRet



Static Function FRetEstrutura( cParamCodKit )

	Local aAreaMEV 		:= GetArea()
	Local aRetEstrutura := {}

	//ConOut( "FRetEstrutura 1" )

	aRetEstrutura := {}
	DbSelectArea( "MEV" ) // Itens do Cadastro de Kits
	DbSetOrder( 01 )      // MEV_FILIAL + MEV_CODKIT + MEV_PRODUT
	Seek XFilial( "MEV" ) + PadR( cParamCodKit, TamSX3( "MEV_CODKIT" )[01] )
	Do While !MEV->( Eof() ) .And. ;
			AllTrim( MEV->MEV_FILIAL ) == AllTrim( XFilial( "MEV" ) ) .And. ;
			AllTrim( MEV->MEV_CODKIT ) == AllTrim( cParamCodKit   )

		//ConOut( "FRetEstrutura 2" )
		aAdd( aRetEstrutura, {  MEV->MEV_PRODUT	, ;   // Produto
			MEV->MEV_QTD    , ;   // Quantidade do Componente
			0				, ;   // Saldo em Estoque do Componente
			0				} )   // Saldo Possível para Produção de PA
		MEV->( DbSkip() )
	EndDo

	//ConOut( "FRetEstrutura 3" )
	RestArea( aAreaMEV )

Return aClone( aRetEstrutura )


User Function UNIRetConsulta( lParamWebService, cParamEmpFilList, cParamProdList, cParamGrpList, cParamCatList, cParamLinList, cParamDescList, aParamEmpresas, aParamEstoque, lParamFilFluig, cListFab, cListCapac, cListVolt )

	Local aAreaAnt 				:= GetArea()
	Local aAreaSM0  			:= SM0->( GetArea() )
	Local cQuery 				:= ""

	Private nPosELegenda		:= 01
	Private nPosEProduto		:= 02
	Private nPosEDescricao		:= 03
	Private nPosEArmazem		:= 04

	Default lParamWebService	:= .F.
	Default cParamEmpFilList	:= ""
	Default cParamProdList		:= ""
	Default cParamGrpList 		:= ""
	Default cParamCatList		:= ""
	Default cParamLinList       := ""
	Default cParamDescList 		:= ""
	Default aParamEmpresas 		:= {}
	Default aParamEstoque		:= {}
	Default lParamFilFluig 		:= .T.
	Default cListFab			:= ""
	Default cListCapac			:= ""
	Default cListVolt			:= ""
	aParamEmpresas 				:= {}
	DbSelectArea( "SM0" )
	SM0->( DbGoTop() )
	Do While !SM0->( Eof() )

		If AllTrim( SM0->M0_CODIGO ) != "99"

			If AllTrim( cParamEmpFilList ) == ""
				aAdd( aParamEmpresas, { SM0->M0_CODFIL, SM0->M0_FILIAL } )
			Else
				If ( AllTrim( SM0->M0_CODFIL ) $ AllTrim( cParamEmpFilList ) )
					aAdd( aParamEmpresas, { SM0->M0_CODFIL, SM0->M0_FILIAL } )
				EndIf
			EndIf

		EndIf

		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo

	aJaProcessou := {}
	cQuery 		 := ""
	cQuery := " 	SELECT DISTINCT  "
	If lParamWebService
		cQuery += "	        TOP 300 "
	EndIf
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
	cQuery += "			B1_FABRIC 	, "	// Cod Barras
	cQuery += "			B1_CAPACID 	, "	// Cod Barras
	cQuery += "			B1_VOLTAGE 	, "	// Cod Barras
	cQuery += "			CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B1_XOBSERV ) ) AS B1_XOBSERV	, "	// Observação
	cQuery += "			CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B1_XALERTA ) ) AS B1_XALERTA	, "	// Alerta
	cQuery += "			B1_MSBLQL 	  "	// Blq. de Tela
	cQuery += " 	   FROM " + RetSQLName( "SB1" ) + " SB1, "
	cQuery += "				" + RetSQLName( "SBM" ) + " SBM, "
	cQuery += "		  		" + RetSQLName( "SZ1" ) + " SZ1, "
	cQuery += "		  		" + RetSQLName( "SZ2" ) + " SZ2  "
	cQuery += "	      WHERE SB1.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SBM.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SZ1.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SZ2.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SB1.B1_FILIAL    = '" + XFilial( "SB1" ) + "' "
	cQuery += "	        AND SBM.BM_FILIAL    = '" + XFilial( "SBM" ) + "' "
	cQuery += "	        AND SZ1.Z1_FILIAL    = '" + XFilial( "SZ1" ) + "' "
	cQuery += "	        AND SZ2.Z2_FILIAL    = '" + XFilial( "SZ2" ) + "' "
	cQuery += "		    AND B1_GRUPO 		 = BM_GRUPO    "
	cQuery += "		    AND B1_CATEGOR       = Z1_CATEGOR  "
	cQuery += "		    AND B1_LINHA	     = Z2_LINHA	   "
	If AllTrim( cParamProdList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_COD ) ) 	 	IN " + FormatIN( cParamProdList, "," )
	EndIf
	If AllTrim( cParamGrpList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_GRUPO ) ) 		IN " + FormatIN( cParamGrpList, "," )
	EndIf
	If AllTrim( cParamCatList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_CATEGOR ) )  	IN " + FormatIN( cParamCatList, "," )
	EndIf
	If AllTrim( cParamLinList ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_LINHA ) ) 		IN " + FormatIN( cParamLinList, "," )
	EndIf
	If AllTrim( cParamDescList ) != ""
		cQuery += "     AND B1_DESC LIKE '%" + Replace( AllTrim( cParamDescList ), " ", "%" ) + "%' "
	EndIf
	If AllTrim( cListFab ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_FABRIC ) ) 		IN " + FormatIN( cListFab, "," )
	EndIf
	If AllTrim( cListCapac ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_CAPACID ) ) 		IN " + FormatIN( cListCapac, "," )
	EndIf
	If AllTrim( cListVolt ) != ""
		cQuery += "     AND LTRIM( RTRIM( B1_VOLTAGE ) ) 		IN " + FormatIN( cListVolt, "," )
	EndIf
	If lParamFilFluig
		cQuery += "       AND B1_XFLUIG	 	 = 'S'  AND B1_ATIVO = 'S' AND B1_MSBLQL != '1' "
	EndIf
	If lParamFilFluig
		cQuery += "       ORDER BY B1_DESC "
	EndIf

	aParamEstoque := {}
	cAliasQry 	 := GetNextAlias()
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	ConOut( "UNIXFUN - UNIRetConsulta - " + cQuery )
	TcQuery cQuery Alias ( cAliasQry ) New
	aParamEstoque := {}
	Do While !( cAliasQry )->( Eof() )

		nPosLinha := aScan( aParamEstoque, { |x| AllTrim( x[nPosEProduto] ) == AllTrim( ( cAliasQry )->B1_COD ) } )
		If nPosLinha == 0

			If !lParamWebService

				aAuxLinha := {}
				aAdd( aAuxLinha, 0 						  )
				aAdd( aAuxLinha, ( cAliasQry )->B1_COD    )
				aAdd( aAuxLinha, ( cAliasQry )->B1_DESC   )
				aAdd( aAuxLinha, ( cAliasQry )->B1_LOCPAD )
				For nE := 01 To Len( aParamEmpresas )
					aAdd( aAuxLinha, 0 )
				Next nE
				aAdd( aParamEstoque, aClone( aAuxLinha ) )
				nPosLinha := Len( aParamEstoque )

				// Atualiza o Saldo do Produto para cada Empresa
				For nE := 01 To Len( aParamEmpresas )

					nSaldo := U_UNIRetSldProd( aParamEmpresas[nE][01], ( cAliasQry )->B1_TIPO, ( cAliasQry )->B1_COD )
					aParamEstoque[nPosLinha][nPosEArmazem + nE] += nSaldo
					aParamEstoque[nPosLinha][nPosELegenda]	    += nSaldo

				Next nE

			Else

				aAuxLinha := {}
				aAdd( aAuxLinha, ( cAliasQry )->B1_COD    	) // 01-Produto
				aAdd( aAuxLinha, ( cAliasQry )->B1_DESC   	) // 02-Descricao
				aAdd( aAuxLinha, ( cAliasQry )->B1_TIPO	  	) // 03-Tipo
				aAdd( aAuxLinha, ( cAliasQry )->B1_UM	  	) // 04-Tipo
				aAdd( aAuxLinha, ( cAliasQry )->B1_LOCPAD 	) // 05-Armazem
				aAdd( aAuxLinha, ( cAliasQry )->B1_GRUPO  	) // 06-Grupo
				aAdd( aAuxLinha, ( cAliasQry )->BM_DESC   	) // 07-Descrição Grupo
				aAdd( aAuxLinha, ( cAliasQry )->B1_CATEGOR	) // 08-Categoria
				aAdd( aAuxLinha, ( cAliasQry )->Z1_DESC   	) // 09-Descrição Categoria
				aAdd( aAuxLinha, ( cAliasQry )->B1_LINHA	) // 10-Linha
				aAdd( aAuxLinha, ( cAliasQry )->Z2_DESC   	) // 11-Descrição Linha
				aAdd( aAuxLinha, ( cAliasQry )->B1_PESO   	) // 12-Peso
				aAdd( aAuxLinha, ( cAliasQry )->B1_CODBAR 	) // 13-Código de Barras
				aAdd( aAuxLinha, ( cAliasQry )->B1_MSBLQL 	) // 14-Blq. de Tela
				aAdd( aAuxLinha, ( cAliasQry )->B1_TS	 	) // 15-TES
				aAdd( aAuxLinha, ( cAliasQry )->B1_XOBSERV 	) // 16-Alerta
				aAdd( aAuxLinha, ( cAliasQry )->B1_XALERTA 	) // 17-Alerta
				nPreco := U_UNIRetPreco( ( cAliasQry )->B1_COD )
				aAdd( aAuxLinha, nPreco 	  				) // 18-Preco de Venda

				aAuxSaldos := {}
				For nE := 01 To Len( aParamEmpresas )

					nSaldo := U_UNIRetSldProd( aParamEmpresas[nE][01], ( cAliasQry )->B1_TIPO, ( cAliasQry )->B1_COD )
					//aAdd( aAuxSaldos, { AllTrim( aParamEmpresas[nE][01] ) + "-" + Left( aParamEmpresas[nE][02], 10 ), nSaldo } )
					aAdd( aAuxSaldos, { AllTrim( aParamEmpresas[nE][01] ), AllTrim( aParamEmpresas[nE][02] ), nSaldo } )

				Next nE
				aAdd( aAuxLinha, aAuxSaldos ) 	  			  // 19-Vetor de Saldos

				aAdd( aAuxLinha, ( cAliasQry )->B1_FABRIC 	) // 20-Alerta
				aAdd( aAuxLinha, ( cAliasQry )->B1_CAPACID 	) // 20-Alerta
				aAdd( aAuxLinha, ( cAliasQry )->B1_VOLTAGE 	) // 20-Alerta
				aAdd( aParamEstoque, aClone( aAuxLinha ) )



				nPosLinha := Len( aParamEstoque )

			EndIf

		EndIf

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )


	If Len( aParamEstoque ) == 0

		If lParamWebService

			aAuxLinha := {}
			aAdd( aAuxLinha, ""   ) // 01-Produto
			aAdd( aAuxLinha, ""   ) // 02-Descricao
			aAdd( aAuxLinha, ""	  ) // 03-Tipo
			aAdd( aAuxLinha, ""	  ) // 04-Tipo
			aAdd( aAuxLinha, ""   ) // 05-Armazem
			aAdd( aAuxLinha, ""   ) // 06-Grupo
			aAdd( aAuxLinha, ""   ) // 07-Descrição Grupo
			aAdd( aAuxLinha, ""	  ) // 08-Categoria
			aAdd( aAuxLinha, ""   ) // 09-Descrição Categoria
			aAdd( aAuxLinha, ""	  ) // 10-Linha
			aAdd( aAuxLinha, ""   ) // 11-Descrição Linha
			aAdd( aAuxLinha, 00   ) // 12-Peso
			aAdd( aAuxLinha, ""   ) // 13-Código de Barras
			aAdd( aAuxLinha, ""   ) // 14-Blq. de Tela
			aAdd( aAuxLinha, ""   ) // 15-TES Saída
			aAdd( aAuxLinha, ""   ) // 16-Observação
			aAdd( aAuxLinha, ""   ) // 17-Alerta
			aAdd( aAuxLinha, 00   ) // 18-Preco de Venda

			aAuxSaldo := {}
			For nE := 01 To Len( aParamEmpresas )
				aAdd( aAuxSaldo, { aParamEmpresas[nE][01], aParamEmpresas[nE][02], 0 } ) // Saldo
			Next nE
			aAdd( aAuxLinha, aAuxSaldo ) // 19-Saldo em Estoque

			aAdd( aAuxLinha, ""   ) // 18-Preco de Venda
			aAdd( aAuxLinha, ""   ) // 18-Preco de Venda
			aAdd( aAuxLinha, ""   ) // 18-Preco de Venda

			aAdd( aParamEstoque, aClone( aAuxLinha ) )
		Else

			aAux := {}
			aAdd( aAux, 0  ) // Legenda
			aAdd( aAux, "" ) // Produto
			aAdd( aAux, "" ) // Descrição
			aAdd( aAux, "" ) // Armazem
			For nE := 01 To Len( aParamEmpresas )
				aAdd( aAux, 0 ) // Saldo
			Next nE
			aAdd( aParamEstoque, aClone( aAux ) )

		EndIf

	EndIf

Return


User Function UNICliExiste( cParamCGC )

	Local aAreaAnt 	:= GetArea()
	Local nRet 		:= 00
	Local cQuery 	:= ""
	Local cAliasQry := GetNextAlias()

	ConOut( "WSUNICA - FExistCliente 1" )

	cQuery := "		SELECT R_E_C_N_O_ AS NRECSA1 "
	cQuery += "		  FROM " + RetSQLName( "SA1" )
	cQuery += "		 WHERE D_E_L_E_T_ 				= ' ' "
	cQuery += "		   AND A1_FILIAL  				= '" + XFilial( "SA1" ) 	+ "' "
	cQuery += "		   AND LTRIM( RTRIM( A1_CGC ) ) = '" + AllTrim( cParamCGC ) + "' "
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	Conout( "WSUNICA - FExisteCliente Query" )
	Conout( cQuery )
	TcQuery cQuery Alias ( cAliasQry ) New
	If !( cAliasQry )->( Eof() )
		ConOut( "WSUNICA - FExistCliente 2" )
		nRet :=( cAliasQry )->NRECSA1
	EndIf
	( cAliasQry )->( DbCloseArea() )
	If nRet == Nil
		Conout( "WSUNICA - FExisteCliente nRet = Nil" )
	Else
		Conout( "WSUNICA - FExisteCliente nRet = " + cValToChar( nRet ) )
	EndIf

	ConOut( "WSUNICA - FExistCliente 3" )
	RestArea( aAreaAnt )
	ConOut( "WSUNICA - FExistCliente 4" )

Return nRet

Static Function FVerProduto()

Return .T.


User Function UNIEnvBoletos( cParamBanco, aParamTitulos, lParamSchedule )

	Local cFiles			:= ""
	Local cFileRet  		:= ""
	Local nI				:= 0
	Local cBody				:= ""
	Local cCliente			:= ""
	Local cNomCli			:= ""

	Local nPosRecNo			:= 01
	Local nPosNome			:= 02
	Local nPosAnexos 		:= 03

	Local cTitulo 			:= ""
	Local cBody  			:= ""



	If Len( aParamTitulos ) > 0

		aAreaAnt := GetArea()
		aAreaSE1 := SE1->( GetArea() )

		For nI := 01 To Len( aParamTitulos )

			DbSelectArea( "SE1" )
			SE1->( DbGoTo( aParamTitulos[nI][nPosRecNo] ) )

			DbSelectArea( "SZ4" )
			DbSetOrder( 1 )
			If Dbseek(xFilial("SZ4")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)
				cTitulo 	:= AllTrim( SZ4->Z4_TITBOL )
				cBody  		:= AllTrim( SZ4->Z4_BODYBOL )
			EndIf

			If AllTrim( cTitulo ) == ""
				cTitulo := "Boleto de Cobrança"
			EndIf

			If AllTrim( cBody ) == ""
				cBody 	:= UNIRetHTMLBoleto()
			EndIf


			DbSelectArea( "SA1" )
			DbSetOrder( 01 ) // A1_FILIAL + A1_COD + A1_LOJA
			If Dbseek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
				cAuxBody 	:= StrTran( cBody, "@cliente", aParamTitulos[nI][nPosNome] )
			Else
				Return
			EndIf

			If AllTrim( aParamTitulos[nI][nPosAnexos] ) == ""

				lEnvEmail 		:= .T.
				lMostraSetUp	:= .F.
				If AllTrim( cParamBanco ) == "341" // Itau
					cFileRet := U_DBOLITAU( lParamSchedule, lEnvEmail, lMostraSetUp )
				ElseIf AllTrim( cParamBanco ) == "033" // Santander
					cFileRet := U_DBOLSAN( lParamSchedule, lEnvEmail, lMostraSetUp )
				EndIf
				//cFileRet := StartJob( "U_GerBoleto", GetEnvServer(), .T., lEhSch, aTitSel[nI][nPosCEmpresa], aTitSel[nI][nPosCFilial], aTitSel[nI][nPosCRecNoE1], aTitSel[nI][nPosCBanco] )
				//cFiles 	 +=  Iif( AllTrim( cFiles ) == "", cFileRet, "," + AllTrim( cFileRet ) )
			Else
				cFileRet := aParamTitulos[nI][nPosAnexos]
			EndIf

			If AllTrim( cFileRet ) != ""

				cMailTo 	:= AllTrim( SA1->A1_EMAIL ) //rafael.rezende@rgrsolucoes.com SA1->A1_EMAIL
				cMailCC     := ""   //cMailCC 	:= AllTrim( GetNewPar( "MV_XBOLCCM", "financeiro@unicario.com.br" ) )
				aAnexo := { cFileRet }
				//U_RGRSendMail( "", cMailTo, cmailCC, "", cTitulo, cAuxBody, aAnexo, lParamSchedule, "UNIR001",,, )
				U_zEnvMail(cMailTo, cTitulo, cAuxBody, aAnexo, .F., .T.,cMailCC)

			EndIf

		Next nI

		RestArea( aAreaSE1 )
		RestArea( aAreaAnt )

	Else

		If !lParamSchedule
			Aviso( "Atenção", "Não existem dados para a emissão dos Boletos", { "Voltar" } )
		Else
			ConOut( "UNIR001 - FENVMAIL - Não existem dados para a emissão dos Boletos" )
		EndIf

	EndIf

Return


User Function UNIRetHTMLBoleto()

	Local cRetHTML  := ""

	cRetHTML := ''

	cRetHTML := '<body style="font-family: arial;font-size: 12px;">'
	cRetHTML += '	<h4>Boleto de Cobrança</h4>'
	cRetHTML += '	<br>'
	cRetHTML += '	<font color="red">'
	cRetHTML += '		Atenção: Este e-mail foi gerado automaticamente. Favor não respondê-lo.'
	cRetHTML += '	</font>'
	cRetHTML += '	<br><br>'
	cRetHTML += '	Prezado(a) <b>@cliente</b>'
	cRetHTML += '	<br>'
	cRetHTML += '	Conforme acordado enviamos em anexo boleto(s) bancário(s) para pagamento'
	cRetHTML += '	<br><br>'
	cRetHTML += '	Em caso de dúvidas ficamos à disposição para esclarecimentos:'
	cRetHTML += '	<br><br>'
	cRetHTML += '	<br><br>'
	cRetHTML += '	Att,'
	cRetHTML += '	<br>'
	cRetHTML += '	<font color="red"><i>Workflow</i></font>'
	cRetHTML += '</body>'

Return cRetHTML


User Function UNIRetMunicipio( cParamMunicipio, cParamUF )

	Local aArea2Ant := GetArea()
	Local cAliasMun := GetNextAlias()
	Local cRetCodMun:= ""
	Local cQuery    := ""
	Local aRet 		:= {}

	aRet := { "", "" }

	cQuery := "	SELECT CC2_CODMUN "
	cQuery += "	  FROM " + RetSQLName( "CC2" )
	cQuery += "	 WHERE D_E_L_E_T_ 	= ' ' "
	cQuery += "    AND CC2_FILIAL  	= '" + XFilial( "CC2" ) 								 + "' "
	cQuery += "	   AND CC2_MUN 	 	= '" + AllTrim( Upper( FwNoAccent( cParamMunicipio ) ) ) + "' "
	cQuery += "	   AND CC2_EST      = '" + AllTrim( Upper( FwNoAccent( cParamUF 	   ) ) ) + "' "

	cQuery += "	   UNION 																		  "

	cQuery += "	SELECT CC2_CODMUN "
	cQuery += "	  FROM " + RetSQLName( "CC2" )
	cQuery += "	 WHERE D_E_L_E_T_ 	= ' ' "
	cQuery += "    AND CC2_FILIAL  	= '" + XFilial( "CC2" ) 								 + "' "
	cQuery += "	   AND CC2_EST      = '" + AllTrim( Upper( FwNoAccent( cParamUF 	   ) ) ) + "' "
	cQuery += "	   AND CHARINDEX( '" + AllTrim( Upper( FwNoAccent( cParamMunicipio ) ) ) + "', CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), UPPER(CC2_XMUN) ) ), 1 ) > 0  "
	If Select( cAliasMun ) > 0
		( cAliasMun )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasMun ) New
	If !( cAliasMun )->( Eof() )
		cRetCodMun := ( cAliasMun )->CC2_CODMUN
	EndIf
	( cAliasMun )->( DbCloseArea() )

	RestArea( aArea2Ant )

Return cRetCodMun


User Function UNIDebugExecAuto( cParamRotina, nParamOpc, aParamExecAuto , nParamTipo )

	Local nE 			:= 0
	Default nParamTipo 	:= 01

	ConOut( "##################################" + Replicate( "#", Len( cParamRotina ) ) + "###############" + "################"  )
	ConOut( "################ FDEBUGEXECAUTO - " + Upper( cParamRotina ) + " - OPERAÇÃO: " + StrZero( nParamOpc, 02 ) + "################" )
	ConOut( "##################################" + Replicate( "#", Len( cParamRotina ) ) + "###############" + "################"  )
	If nParamTipo == 01
		ConOut( "	- " + PadR( "CAMPO", 10 ) + " - CONTEUDO" )
	ConOut( "	- " + PadR( "==========", 10 ) + Replicate( "=", 60  ) )  
		For nE := 01 To Len( aParamExecAuto )
			ConOut( "	- " + PadR( aParamExecAuto[nE][01], 10 ) + " - " + If( ValType( aParamExecAuto[nE][02] ) == "D", DToC( aParamExecAuto[nE][02] ), If( ValType( aParamExecAuto[nE][02] ) == "N", cValToChar( aParamExecAuto[nE][02] ), If( ValType( aParamExecAuto[nE][02] ) == "U", "", aParamExecAuto[nE][02] ) ) ) )
		Next nE
	ElseIf nParamTipo == 02
		For nA := 01 To Len( aParamExecAuto )
			ConOut( "	- " + PadR( "CAMPO", 10 ) + " - CONTEUDO" )
		ConOut( "	- " + PadR( "==========", 10 ) + Replicate( "=", 60  ) )  
			For nE := 01 To Len( aParamExecAuto[nA] )
				ConOut( "	- " + PadR( aParamExecAuto[nA][nE][01], 10 ) + " - " + If( ValType( aParamExecAuto[nA][nE][02] ) == "D", DToC( aParamExecAuto[nA][nE][02] ), If( ValType( aParamExecAuto[nA][nE][02] ) == "N", cValToChar( aParamExecAuto[nA][nE][02] ), If( ValType( aParamExecAuto[nA][nE][02] ) == "U", "", aParamExecAuto[nA][nE][02] ) ) ) )
			Next nE
			ConOut( "" )
		Next nA
	Else


		For nC := 01 To Len( aParamExecAuto )
			For nA := 01 To Len( aParamExecAuto[nC] )
				ConOut( "	- " + PadR( "CAMPO", 10 ) + " - CONTEUDO" )
			ConOut( "	- " + PadR( "==========", 10 ) + Replicate( "=", 60  ) )  
				For nE := 01 To Len( aParamExecAuto[nC][nA] )
					ConOut( "	- " + PadR( aParamExecAuto[nC][nA][nE][01], 10 ) + " - " + If( ValType( aParamExecAuto[nC][nA][nE][02] ) == "D", DToC( aParamExecAuto[nC][nA][nE][02] ), If( ValType( aParamExecAuto[nC][nA][nE][02] ) == "N", cValToChar( aParamExecAuto[nC][nA][nE][02] ), If( ValType( aParamExecAuto[nC][nA][nE][02] ) == "U", "", aParamExecAuto[nC][nA][nE][02] ) ) ) )
				Next nE
				ConOut( "" )
			Next nA
		Next nC

	EndIf
	ConOut( "##################################" + Replicate( "#", Len( cParamRotina ) ) + "###############" + "################"  )
	ConOut( "##################################" + Replicate( "#", Len( cParamRotina ) ) + "###############" + "################"  )

Return


User Function UNIGetEnvInfo( cParamRotina )

	Local aRPO 				:= {}
	Default cParamRotina 	:= ""

	aRPO := GetAPOInfo( cParamRotina )
	If !Empty( aRPO )
		ConOut( Replicate( "=", 80 ) )
		ConOut( PadC( "ROTINA: " + aRPO[01], 80 ) )
		ConOut( PadC( "DATA: " + DToC( aRPO[04] ) + " " + aRPO[05], 80 ) )
		ConOut( Replicate( "=", 80 ) )
		ConOut( PadC( "SmartClient: " + GetBuild( .T. ), 80 ) )
		ConOut( PadC( "AppServer: " + GetBuild( .F. ), 80 ) )
		ConOut( PadC( "DbAccess: " + TcAPIBuild() + "/" + TcGetDB(), 80 ) )
		ConOut( Replicate( "=", 80 ) )
		ConOut( "Start at: " + Time() )
		ConOut( Replicate( "=", 80 ) )
	Else
		ConOut( Replicate( "=", 80 ) )
		ConOut( "GETENVINFO - NÃO ENCONTROU A ROTINA ROTINA: " + cParamRotina )
		ConOut( Replicate( "=", 80 ) )
	EndIf

Return


User Function UNIGrvLog( cParamNumLote, cParamNumOrc, cParamIdMagento, cParamRotina, cParamFuncao, cParamMsgResumo, cParamMsgLog, cParamAlias, nParamRecNo )

	Local aAreaLog := GetArea()
	Local cWSDLCod := ""

	If Type( "_c_WsCodInstancia" ) != "C"
		cWSDLCod := ""
	Else
		cWSDLCod := _c_WsCodInstancia
	EndIf

	DbSelectArea( "SZ5" )
	DbSetOrder( 01 )
	RecLock( "SZ5", .T. )

	SZ5->Z5_FILIAL 	:= XFilial( "SZ5" )
	SZ5->Z5_CODIGO  := cParamNumLote
	SZ5->Z5_DATA 	:= Date()
	SZ5->Z5_HORA	:= Time()
	SZ5->Z5_USRCOD  := __cUserId
	SZ5->Z5_USRNOME := UsrFullName( __cUserId )
	SZ5->Z5_NUMORC	:= cParamNumOrc
	SZ5->Z5_IDMAGEN	:= cParamIdMagento
	SZ5->Z5_ROTINA	:= cParamRotina
	SZ5->Z5_FUNCAO	:= cParamFuncao
	SZ5->Z5_MSGRESU := cParamMsgResumo
	SZ5->Z5_MSGCOMP := cParamMsgLog
	SZ5->Z5_ALIAS	:= cParamAlias
	SZ5->Z5_RECNO	:= nParamRecNo
	SZ5->Z5_CODSZ8  := cWSDLCod

	SZ5->( MsUnLock() )

	RestArea( aAreaLog )

Return


User Function UNIDesmontaOP( cParamProdutoPA, nParamQuant, cParamError )

	Local aAreaAtu 		:= GetArea()
	Local aAreaSB1 		:= SB1->( GetArea() )
	Local aAutoCab 		:= {}
	Local aAutoItens 	:= {}
	Local lRetOp		:= .T.
	Private lMsErroAuto := .F.
	Default cParamError := ""

	DbSelectArea( "SB1" )
	DbSetOrder( 01 ) // B1_FILIAL + B1_COD
	Seek XFilial( "SB1" ) + cParamProdutoPA
	If Found()

		If AllTrim( SB1->B1_TIPO ) == "PA"

			aAutoCab 			:= {  { "cProduto"  , SB1->B1_COD											, Nil } ,;
				{ "cLocOrig"  , SB1->B1_LOCPAD             					  		, Nil } ,;
				{ "nQtdOrig"  , nParamQuant                  							, Nil } ,;
				{ "nQtdOrigSe", CriaVar( "D3_QTSEGUM" )			        			, Nil } ,;
				{ "cDocumento", PadL( DToS( Date() ), TamSX3( "D3_DOC" )[01], "0" )	, Nil } ,;
				{ "cNumLote"  , CriaVar( "D3_NUMLOTE" )  			 		     		, Nil } ,;
				{ "cLoteDigi" , CriaVar( "D3_LOTECTL" )		        				, Nil } ,;
				{ "dDtValid"  , CriaVar( "D3_DTVALID" )        					 	, Nil } ,;
				{ "nPotencia" , CriaVar( "D3_POTENCI" ) 		       					, Nil } ,;
				{ "cLocaliza" , CriaVar( "D3_LOCALIZ" )      			 				, Nil } ,;
				{ "cNumSerie" , CriaVar( "D3_NUMSERI" )			    			    , Nil }  }

			cParamError		:= ""
			aAutoItens 		:= {}
			aAuxComponentes := {}
			If U_UNIRComponentes( SB1->B1_COD, @aAuxComponentes, @cParamError )

				For nCo := 01 To Len( aAuxComponentes )

					aAdd( aAutoItens, {	{ "D3_COD" 		, aAuxComponentes[nCo][01]					, Nil } ,;
						{ "D3_LOCAL" 	, aAuxComponentes[nCo][02]              	, Nil } ,;
						{ "D3_QUANT" 	, ( aAuxComponentes[nCo][04] * nParamQuant ), Nil } ,;
						{ "D3_QTSEGUM"	, 		                    		    	, Nil } ,;
						{ "D3_RATEIO" 	, aAuxComponentes[nCo][05]              	, Nil }  } )
				Next nCo

				DbSelectArea( "SD3" )
				lMsErroAuto := .F.
				MsExecAuto( { | v, x, y, z| MATA242( v, x, y, z ) }, aAutoCab, aAutoItens, 03, .T. )
				If lMsErroAuto
					cParamError		:= "Erro ao tentar desmontar o Produto PA para geração do Orçamento. Produto [ " + cParamProdutoPA + " ]. " + MostraErro( "-", "-" )
					ConOut( "	- UNIXFUN - UNIDesmontaOP - " + cParamError )
					lRetOp		:= .F.
				Else
					ConOut( "	- UNIXFUN - UNIDesmontaOP - Produto desmontado com sucesso!! Produto [ " + cParamProdutoPA + " ]." )
					lRetOp		:= .T.
				EndIf

			Else

				ConOut( "	- UNIXFUN - UNIDesmontaOP - " + cParamError )

			EndIf

		EndIf

	Else

		cParamError	:= "Não encontrou o Cadastro do Produto na SB1"
		ConOut( "	- UNIXFUN - UNIDesmontaOP - " + cParamError )
		lRetOp := .F.

	EndIf

Return lRetOp


User Function UNIRComponentes( cParamProduto, aParamRetEstrutura, cParamError )

	Local aAreaAtu 				:= GetArea()
	Local aAreaSB1 				:= SB1->( GetArea() )
	Local lRetB					:= .T.
	Default aParamRetEstrutura	:= {}
	Default cParamError			:= ""

	//ConOut( "	UNIXFUN - UNIRComponentes - Início - Produto " + cParamProduto )

	DbSelectArea( "SB1" )
	DbSetOrder( 01 )
	Seek XFilial( "SB1" ) + cParamProduto
	If Found()

		aAreaProd := SB1->( GetArea() )

		If AllTrim( SB1->B1_TIPO ) == "PA"

			ConOut( "	UNIXFUN - UNIRComponentes - Produto PA - Pega da SG1" )
			DbSelectArea( "SG1" )
			DbSetOrder( 01 ) // G1_FILIAL + G1_COD + G1_COMP + G1_TRT
			Seek XFilial( "SG1" ) + cParamProduto
			If Found()

				Do While !SG1->( Eof() ) .And. ;
						AllTrim( SG1->G1_FILIAL ) == AllTrim( XFilial( "SG1" ) ) .And. ;
						AllTrim( SG1->G1_COD    ) == AllTrim( cParamProduto	)

					DbSelectArea( "SB1" )
					DbSetOrder( 01 )
					Seek XFilial( "SB1" ) + SG1->G1_COMP
					If Found()

						ConOut( "	UNIXFUN - UNIRComponentes - Incluíu o Componente " + SB1->B1_COD + " - " + SB1->B1_DESC )
						aAdd( aParamRetEstrutura, { SB1->B1_COD	 	, ;
							SB1->B1_LOCPAD 	, ;
							SB1->B1_DESC 	, ;
							SG1->G1_QUANT   , ;
							SG1->G1_XPERDIS	} )

					Else

						ConOut( "	UNIXFUN - UNIRComponentes - Erro na Estrutura do Produro - 1" )

					EndIf

					DbSelectArea( "SG1" )
					SG1->( DbSkip() )
				EndDo

			Else

				ConOut( "	UNIXFUN - UNIRComponentes - Não encontrou Estrutura - Monta Estrutura com único produto ( ele mesmo )" )
				RestArea( aAreaProd )
				aAdd( aParamRetEstrutura, { SB1->B1_COD	 	, ;
					SB1->B1_LOCPAD 	, ;
					SB1->B1_DESC 	, ;
					01			    , ;
					100				} )

			EndIf

		Else

			ConOut( "	UNIXFUN - UNIRComponentes - Vai tratar como Kit" )
			DbSelectArea( "MEV" ) // Itens do Cadastro de Kits
			DbSetOrder( 01 )      // MEV_FILIAL + MEV_CODKIT + MEV_PRODUT
			Seek XFilial( "MEV" ) + PadR( cParamProduto, TamSX3( "MEV_PRODUTO" )[01] )
			If Found()

				Do While !MEV->( Eof() ) .And. ;
						AllTrim( MEV->MEV_FILIAL ) == AllTrim( XFilial( "MEV" ) ) .And. ;
						AllTrim( MEV->MEV_CODKIT ) == AllTrim( cParamProduto )

					DbSelectArea( "SB1" )
					DbSetOrder( 01 )
					Seek XFilial( "SB1" ) + MEV->MEV_PRODUT
					If Found()

						ConOut( "	UNIXFUN - UNIRComponentes - Inclui produto componente do Kit " + SB1->B1_COD + " - " + SB1->B1_DESC )
						aAdd( aParamRetEstrutura, { SB1->B1_COD 	, ;
							SB1->B1_LOCPAD	, ;
							SB1->B1_DESC	, ;
							MEV->MEV_QTD    , ;
							MEV->MEV_XPERCD } )
					Else

						cParamError := "Erro na montagem da Estrutura do Kit para o Produto [ " + cParamProduto + " ]. Não encontrou o componete do Kit [ " + MEV->MEV_PRODUT + " ]."
						ConOut( "	UNIXFUN - UNIRComponentes - Erro na Estrutura do Kit - 1 " )
						lRetB := .F.

					EndIf

					MEV->( DbSkip() )
				EndDo

			Else

				ConOut( "	UNIXFUN - UNIRComponentes - Inclui produto com único componente ( ele mesmo )" )
				aAdd( aParamRetEstrutura, { SB1->B1_COD		, ;
					SB1->B1_LOCPAD 	, ;
					SB1->B1_DESC	, ;
					1    			, ;
					100 			} )
			EndIf

		EndIf

	Else

		ConOut( "	UNIXFUN- UNIRComponentes - Não encontrou o cadastro de Produtos " + cParamProduto )

	EndIf

	RestArea( aAreaSB1 )
	RestArea( aAreaAtu )
	ConOut( "	UNIXFUN- UNIRComponentes - Fim da Rotina " )

Return lRetB


User Function UniPrtInicializa()

	Local cNomeImpressora 		:= AllTrim( GetNewPar( "MV_XIMPZEB", "ZEBRA" ) )
	Local cPortaImpressora 		:= AllTrim( GetNewPar( "MV_XPORZEB", "LPT3"  ) )
	Local nAlturaEtiqueta		:= 64   	// mm
	Local nLarguraEtiqueta 		:= 100  	// mm
	Local cBaudRate 		 	:= "9600" 	//  "110","19200","300","38400","600","56000","1200","57600","2400","115200","4800","128000","9600","256000","14400"
	Local cParity			 	:= "0" 		//  "0"- NoParity,"1"-OddParity,"2"-EvenParity,"3"-MarkParity,"4"-SpaceParity
	Local cData 		 	 	:= "8" 		//  "4","5","6","7","8"
	Local cStop					:= "0" 		//  "0"-OneStopBit,"1"-One5StopBits,"2"-TwoStopBits

	// Inicializa o tamanho da Etiqueta na Memória da Impressora
	cPortaImpressora += ":" + cBaudRate + "," + cParity + "," + cData + "," + cStop

	MSCBPrinter( cNomeImpressora, cPortaImpressora,,, .F./*lSrv*/, /*nPorta*/, /*cServer*/, /*cEnv*/, /*nMemoria*/, /*cFila*/, .F./*lDrvWin*/, /*cPathSpool*/ )

	MsCbChkStatus( .F. )

Return .T.



User Function UniPrtFinaliza()


	// Fecha a Comunicação com a Impressora
	MsCbClosePrinter()

Return


User Function UniLogTrataMagento( cParamMagento, cParamPedido, cParamStatus, cParamMensagem, cParamSolved )

	Local aAreaOld := GetArea()
	Local cWSDLCod := ""

	If Type( "_c_WsCodInstancia" ) != "C"
		cWSDLCod := ""
	Else
		cWSDLCod := _c_WsCodInstancia
	EndIf

	DbSelectArea( "SZ7" )
	DbSetOrder( 01 ) // Z7_FILIAL + Z7_IDMAGEN
	Seek XFilial( "SZ7" ) + cParamMagento + cWSDLCod
	If Found()

		RecLock( "SZ7", .F. )

	Else

		If cParamSolved == "S"

			RestArea( aAreaOld )
			Return

		Else

			RecLock( "SZ7", .T. )
			SZ7->Z7_FILIAL   := XFilial( "SZ7" )
			SZ7->Z7_IDMAGEN  := cParamMagento
			SZ7->Z7_CODSZ8   := cWSDLCod

		EndIf

	EndIf

	If AllTrim( cParamSolved ) == "S"

		If AllTrim( cParamStatus ) == AllTrim( SZ7->Z7_STATUS )

			SZ7->Z7_RESOLVI := cParamSolved
			SZ7->Z7_DTSOLUC := Date()
			SZ7->Z7_HRSOLUC := Time()

		EndIf

	Else

		SZ7->Z7_PEDIDO  := cParamPedido
		SZ7->Z7_STATUS  := cParamStatus
		SZ7->Z7_MSGLOG	:= cParamMensagem
		SZ7->Z7_RESOLVI := cParamSolved
		SZ7->Z7_DTULTIM := Date()
		SZ7->Z7_HRULTIM := Time()

	EndIf
	SZ7->( MsunLock() )

	RestArea( aAreaOld )

Return


User Function UNIVerTES( cParamFilial, cParamUF, cParamTpCliente, cParamTpEntrega )

	Local aAreaAnt := GetArea()
	Local aRetTES  := { "", "" }

	If AllTrim( cParamTpEntrega ) $ "3.4"

		ConOut( "	UNIVerTES - DANFE " )
		Do Case
			Case Left( cParamFilial, 04 ) = '0102' // 0102 - F & F REFRIGERAÇÃO MG

				ConOut( "	UNIVerTES - Empresa - 0102 Com Novas Filias" )
				If AllTrim( cParamTpCliente ) = "R"
					ConOut( "	UNIVerTES - Cliente Revendendor" )
					// ALTERAï¿½ï¿½O DO TES CONFORME ORIENTAï¿½ï¿½O DO CLIENTE
					aRetTES[01] := "731" //Orçamento
					aRetTES[02] := "732" //Faturamento
				elseif AllTrim( cParamTpCliente ) == "F"

					If AllTrim( cParamUF ) == "MG"
						ConOut( "	UNIVerTES - Cliente Final dentro do estado" )
						aRetTES[01] := "715" //Orçamento
						aRetTES[02] := "707"  //Faturamento
					Else
						ConOut( "	UNIVerTES - Cliente Final fora do estado" )
						aRetTES[01] := "785" //Orçamento
						aRetTES[02] := "784"  //Faturamento
					EndIf
				EndIf


			Case Left( cParamFilial, 04 ) == '0103' .Or. Left( cParamFilial, 04 ) == '0104' // 0103 e 0104 - F & F REFRIGERACAO SP

				ConOut( "	UNIVerTES - Empresa - 01 Com Novas Filias" )
				If AllTrim( cParamTpCliente ) == "R"
					ConOut( "	UNIVerTES - Cliente Revendendor" )
					aRetTES[01] := "731" //Orçamento
					aRetTES[02] := "732" //Faturamento
				elseif AllTrim( cParamTpCliente ) == "F"

					If AllTrim( cParamUF ) == "SP"
						ConOut( "	UNIVerTES - Cliente Final dentro do estado" )
						aRetTES[01] := "715" //Orçamento
						aRetTES[02] := "707"  //Faturamento
					Else
						ConOut( "	UNIVerTES - Cliente Final fora do estado" )
						aRetTES[01] := "785" //Orçamento
						aRetTES[02] := "784"  //Faturamento
					EndIf
				EndIf


				//Fim alteracao Luiz Otavio Campos 19/04/2021

				// 0202 - REAL ES
			Case Left( cParamFilial, 04 ) == '0202' .OR. Left( cParamFilial, 02 ) == "01"

				ConOut( "	UNIVerTES - Empresa - 01" )
				If AllTrim( cParamUF ) == "DF"
					ConOut( "	UNIVerTES - DF" )
					// ALTERAÇÃO DO TES CONFORME ORIENTAÇÃO DO CLIENTE
					aRetTES[01] := "781"
					aRetTES[02] := "782"
				ElseIf AllTrim( cParamUF ) == "ES"
					ConOut( "	UNIVerTES - Dentro do ES" )
					aRetTES[01] := "715"
					aRetTES[02] := "717"
				Else
					ConOut( "	UNIVerTES - Dentro do ES" )
					If AllTrim( cParamTpCliente ) == "F"
						ConOut( "	UNIVerTES - Cliente Final" )
						aRetTES[01] := "786"
						aRetTES[02] := "784"
					Else
						ConOut( "	UNIVerTES - Não é Cliente Final" )
						aRetTES[01] := "715"
						aRetTES[02] := "707"
					EndIf
				EndIf
				//Fim AlteraÃ§Ã£o Matheus


			Case Left( cParamFilial, 02 ) == "02"

				ConOut( "	UNIVerTES - Empresa - 02" )
				If AllTrim( cParamUF ) == "RJ"
					ConOut( "	UNIVerTES - Dentro do RJ" )
					If AllTrim( cParamTpCliente ) == "F"
						ConOut( "	UNIVerTES - Cliente Final" )
						aRetTES[01] := "714"
						aRetTES[02] := "703"
					Else
						ConOut( "	UNIVerTES - Não é Cliente Final" )
						aRetTES[01] := "715"
						aRetTES[02] := "703"
					EndIf
				Else
					ConOut( "	UNIVerTES - Outros UFs" )
					If AllTrim( cParamTpCliente ) == "F"
						ConOut( "	UNIVerTES - Cliente Final" )
						aRetTES[01] := "785"
						aRetTES[02] := "784"
					Else
						ConOut( "	UNIVerTES - Não é Cliente Final" )
						aRetTES[01] := "715"
						aRetTES[02] := "707"
					EndIf
				EndIf

			OtherWise
				ConOut( "	UNIVerTES - Nenhuma das Opcoes acima - usa MV_TESSAI" )
				aRetTES[01] := Alltrim( GetMv( "MV_TESSAI" ) )
				aRetTES[02] := Alltrim( GetMv( "MV_TESSAI" ) )
				ConOut( "	UNIVerTES - TES Orcamento - " + aRetTES[01] )
		EndCase

	Else

		// NFCE
		ConOut( "	UNIVerTES - NFCE - usa MV_TESSAI" )
		aRetTES[01] := Alltrim( GetMv( "MV_TESSAI" ) )
		aRetTES[02] := Alltrim( GetMv( "MV_TESSAI" ) )

	EndIf

	RestArea( aAreaAnt )

Return aRetTES

// Filtra condições de pagamento
User Function FiltCond(cCondPag, cTabela)
	Local lRet := .F.

	If Type("M->C5_TABELA") == 'C'
		Default cTabela := M->C5_TABELA
	EndIf

	If !Empty(cTabela)
		dbSelectArea("ACO")
		dbSetOrder(2)
		lRet := dbSeek(XFilial("ACO")+PadR(cTabela, TamSX3("C5_TABELA")[1])+cCondPag)
	Else
		lRet := .T.
	EndIf
Return lRet
