
/*/{Protheus.doc} MT010INC

@project Replicação do produto na Tabela de Preços e Indicadores
@description Ponto de Entrada na rotina padrão MATA010 ( Cadastro de Produtos ), com o objetivo de Replicação o produto nas Tabelas de Preços de todas as Empresa / Filiais e criar caso não exista o custo no Cadastro de Indicadores.
@author Rafael Rezende
@since 24/09/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"


User Function MT010INC()

	Local aAreaAntes 	 := GetArea()
	Local aAreaSM0		 := SM0->( GetArea() )
	Local aEmpFil		 := {}
	Private nPosEmpresa  := 01
	Private nPosFilial   := 02
	Private nPosNome	 := 03

	//Monta a Lista de Empresas / Filial
	DbSelectArea( "SM0" )
	SM0->( DbGoTop() )
	Do While !SM0->( Eof() )

		aAdd( aEmpFil, { SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_FILIAL } )

		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo

	// Realiza a replicação do Produto em todas as tabelas de Preços
	Processa( { || FReplicaTab( aEmpFil ) }, "Replicando para as Tabelas de Preço, aguarde..." )
	Processa( { || FReplicaInd( aEmpFil ) }, "Replicando Indicadores, aguarde..." )

	RestArea( aAreaAntes )

Return


Static Function FReplicaTab( aParamEmpFil )

	Local nEmp 		 := 0
	Local cQuery 	 := ""
	Local cAliasDA0  := GetNextAlias()
	Local cAliasDA1  := GetNextAlias()
	Local nTamFilial := TamSX3( "DA0_FILIAL" )[01]

	ProcRegua( Len( aParamEmpFil ) )

	cQuery := "		SELECT DA0_FILIAL, DA0_CODTAB, DA0_DESCRI 	"
	cQuery += "		  FROM " + RetSQLName( "DA0" ) + " ( NOLOCK ) "
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' 		"
	cQuery += "   ORDER BY DA0_FILIAL, DA0_CODTAB 	"
	If Select( cAliasDA0 ) > 0
		( cAliasDA0 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasDA0 ) New
	Do While !( cAliasDA0 )->( Eof() )

		For nEmp := 01 To Len( aParamEmpFil )

			IncProc( "Replicando Preço para Emp/Fil [ " + AllTrim( aParamEmpFil[nEmp][nPosFilial] ) + " ]" )

			lEncontrou := .F.
			cQuery := "		SELECT COUNT( * ) AS NACHOU "
			cQuery += "		  FROM " + RetSQLName( "DA1" ) + " ( NOLOCK ) "
			cQuery += "		 WHERE D_E_L_E_T_ 	= ' ' "
			cQuery += "		   AND DA1_FILIAL 	= '" + ( cAliasDA0 )->DA0_FILIAL + "' "
			cQuery += "		   AND DA1_CODTAB 	= '" + ( cAliasDA0 )->DA0_CODTAB + "' "
			cQuery += "		   AND DA1_CODPRO 	= '" + SB1->B1_COD 				 + "' "
			If Select( cAliasDA1 ) > 0
				( cAliasDA1 )->( DbCloseArea() )
			EndIf
			TcQuery cQuery Alias ( cAliasDA1 ) New
			If !( cAliasDA1 )->( Eof() )
				lEncontrou := ( cAliasDA1 )->NACHOU > 0
			EndIf
			( cAliasDA1 )->( DbCloseArea() )

			If !lEncontrou

				cAuxItem := ""
				cQuery := "		SELECT MAX( DA1_ITEM ) AS ITEM "
				cQuery += "		  FROM " + RetSQLName( "DA1" ) + " ( NOLOCK ) "
				cQuery += "		 WHERE D_E_L_E_T_ 	= ' ' "
				cQuery += "		   AND DA1_FILIAL 	= '" + ( cAliasDA0 )->DA0_FILIAL + "' "
				cQuery += "		   AND DA1_CODTAB 	= '" + ( cAliasDA0 )->DA0_CODTAB + "' "
				If Select( cAliasDA1 ) > 0
					( cAliasDA1 )->( DbCloseArea() )
				EndIf
				TcQuery cQuery Alias ( cAliasDA1 ) New
				If !( cAliasDA1 )->( Eof() )
					cAuxItem := ( cAliasDA1 )->ITEM
				EndIf
				cAuxItem := Soma1( cAuxItem )

				// Grava o Item na tabela de Preços
				DbSelectArea( "DA1" )
				RecLock( "DA1", .T. )

				DA1->DA1_FILIAL := ( cAliasDA0 )->DA0_FILIAL
				DA1->DA1_CODTAB := ( cAliasDA0 )->DA0_CODTAB
				DA1->DA1_CODPRO	:= SB1->B1_COD
				DA1->DA1_ITEM	:= cAuxItem
				DA1->DA1_PRCVEN	:= 0
				DA1->DA1_TPOPER := "4"
				DA1->DA1_DATVIG := Date()
				DA1->DA1_MOEDA  := 1
				DA1->DA1_QTDLOT := 999999.99
				DA1->DA1_INDLOT := "000000000999999.99"
				DA1->DA1_ATIVO  := "1"

				DA1->( MsUnLock() )

			EndIf

		Next nEmp

		DbSelectArea( cAliasDA0 )
		( cAliasDA0 )->( DbSkip() )
	EndDo
	( cAliasDA0 )->( DbCloseArea() )

Return


Static Function FReplicaInd( aParamEmpFil )

	Local nEmp 		 := 0
	Local cQuery 	 := ""
	Local nTamFilial := TamSX3( "BZ_FILIAL" )[01]

	ProcRegua( Len( aParamEmpFil ) )

	For nEmp := 01 To Len( aParamEmpFil )

		IncProc( "Replicando Indicadores para Emp/Fil [ " + aParamEmpFil[nEmp][nPosFilial] + " ]" )

		DbSelectArea( "SBZ" )
		DbSetOrder( 01 ) // BZ_FILIAL + BZ_COD
		Seek PadR( aParamEmpFil[nEmp][nPosFilial], nTamFilial ) + SB1->B1_COD
		If !Found()

			DbSelectArea( "SBZ" )
			RecLock( "SBZ", .T. )

			SBZ->BZ_FILIAL  := aParamEmpFil[nEmp][nPosFilial]
			SBZ->BZ_COD 	:= SB1->B1_COD
			SBZ->BZ_LOCPAD 	:= SB1->B1_LOCPAD
			SBZ->BZ_CUSTD 	:= 0
			SBZ->BZ_DTINCLU	:= Date()

			SBZ->( MsUnLock() )

		EndIf

	Next nEmp

Return