
/*/{Protheus.doc} UNIA021

@project Replicação do produto na Tabela de Preços e Indicadores
@description Rotina com o objetivo de Replicar para uma nova Filial as informações de Tabela de Preços e Indicadores de Produtos
@author Rafael Rezende
@since 26/09/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"

*---------------------*
User Function UNIA021()
	*---------------------*
	Local oFontProc     	 := Nil
	Local oDlgProc      	 := Nil
	Local oGrpTexto 	     := Nil
	Local oSayTexto	     	 := Nil
	Local oBtnConfi     	 := Nil
	Local oBtnParam 	     := Nil
	Local oBtnSair	      	 := Nil
	Local lHtml		         := .T.
	Local lConfirmou	     := .F.
	Local cPerg         	 := "UNIA021"
	Local cTitulo   	     := "Replicação de Tabela de Preços e Indicadores"
	Local cTexto	         := "<font color='red'> Replicação de Tabela de Preços e Indicadores </font><br> Esta rotina tem como objetivo a Replicação de Tabelas de Preços e Indicadores para novas Filiais.<br>Selecione os parâmetros desejados e confirme a replicação</font>."
	Private lSchedule 		 := IsBlind()
	cTexto          	     := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )

	oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
	oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
	oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
	oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
	oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
	oBtnConfi := TButton():New( 092, 006, "&Replicar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), FReplicar(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oDlgProc:Activate( ,,,.T. )

Return


Static function FVldParametros()

	Local lRet := .T.

	DbSelectArea( "DA0" )
	DbSetOrder( 01 )

	If AllTrim( MV_PAR01 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Filial Origem ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR02 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Tabela Origem ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	Else
		If !DA0->( DbSeek( PadR( Left( MV_PAR01, 02 ), TamSX3( "DA0_FILIAL" )[01] ) + MV_PAR02 ) )
			Aviso( "Atenção", "O Parâmetro [ Tabela Origem ? ] é inválido. Tabela de Preços não existe.", { "Voltar" } )
			lRet := .F.
		EndIf
	EndIf

	If lRet .And. AllTrim( MV_PAR03 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Filial Destino ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. Empty( MV_PAR04 )
		Aviso( "Atenção", "O Parâmetro [ Tabela Destino ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	Else
		If !DA0->( DbSeek( PadR( Left( MV_PAR03, 02 ), TamSX3( "DA0_FILIAL" )[01] ) + MV_PAR04 ) )
			Aviso( "Atenção", "O Parâmetro [ Tabela Destino ? ] é inválido. Tabela de Preços não existe.", { "Voltar" } )
			lRet := .F.
		EndIf
	EndIf

Return lRet



*-------------------------*
Static Function FReplicar()
	*-------------------------*
	Local aAreaAntes 	 := GetArea()
	Local aAreaSM0		 := SM0->( GetArea() )
	Local aEmpFil		 := {}
	Private nPosEmpresa  := 01
	Private nPosFilial   := 02
	Private nPosNome	 := 03

	// Realiza a replicação do Produto em todas as tabelas de Preços
	Processa( { || FReplicaTab() }, "Replicando para as Tabelas de Preço, aguarde..." )
	Processa( { || FReplicaInd() }, "Replicando Indicadores, aguarde..." )
	Aviso( "Atenção", "Replicação concluída com sucesso!", { "Ok" } )

	RestArea( aAreaAntes )

Return

*---------------------------*
Static Function FReplicaTab()
	*---------------------------*
	Local nEmp 		 := 0
	Local cQuery 	 := ""
	Local cAliasDA1  := GetNextAlias()
	Local cAliasExist:= GetNextAlias()

	cQuery := "		SELECT DA1_FILIAL, DA1_CODTAB, DA1_CODPRO, DA1_ITEM	 , DA1_PRCVEN, "
	cQuery += "			   DA1_TPOPER, DA1_DATVIG, DA1_MOEDA,  DA1_QTDLOT, DA1_INDLOT  "
	cQuery += "			   DA1_ATIVO  "
	cQuery += "		  FROM " + RetSQLName( "DA1" ) + " ( NOLOCK ) "
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' 		"
	cQuery += "		   AND DA1_FILIAL = '" +  Left( MV_PAR01, 02 ) 	+ "' "
	cQuery += "		   AND DA1_CODTAB = '" +  MV_PAR02 				+ "' "
	cQuery += "   ORDER BY DA1_FILIAL, DA1_CODTAB, DA1_CODPRO "
	If Select( cAliasDA1 ) > 0
		( cAliasDA1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasDA1 ) New

	nContador := 0
	Count To nContador
	ProcRegua( nContador )
	( cAliasDA1 )->( DbGoTop() )
	Do While !( cAliasDA1 )->( Eof() )

		IncProc( "Replicando Preço para Emp/Fil [ " + AllTrim( MV_PAR03 ) + " ], aguarde..." )

		lEncontrou := .F.
		cQuery := "		SELECT COUNT( * ) AS NACHOU "
		cQuery += "		  FROM " + RetSQLName( "DA1" ) + " ( NOLOCK ) "
		cQuery += "		 WHERE D_E_L_E_T_ 	= ' ' "
		cQuery += "		   AND DA1_FILIAL 	= '" + lEFT( MV_PAR03, 02 )		 + "' "
		cQuery += "		   AND DA1_CODTAB 	= '" + MV_PAR04 				 + "' "
		cQuery += "		   AND DA1_CODPRO 	= '" + ( cAliasDA1 )->DA1_CODPRO + "' "
		If Select( cAliasExist ) > 0
			( cAliasExist )->( DbCloseArea() )
		EndIf
		TcQuery cQuery Alias ( cAliasExist ) New
		If !( cAliasExist )->( Eof() )
			lEncontrou := ( cAliasExist )->NACHOU > 0
		EndIf
		( cAliasExist )->( DbCloseArea() )

		If !lEncontrou

			// Grava o Item na tabela de Preços
			DbSelectArea( "DA1" )
			RecLock( "DA1", .T. )

			DA1->DA1_FILIAL := LEFT( MV_PAR03, 02 )
			DA1->DA1_CODTAB := MV_PAR04
			DA1->DA1_CODPRO	:= ( cAliasDA1 )->DA1_CODPRO
			DA1->DA1_ITEM	:= ( cAliasDA1 )->DA1_ITEM
			DA1->DA1_PRCVEN	:= ( cAliasDA1 )->DA1_PRCVEN
			DA1->DA1_TPOPER := "4"
			DA1->DA1_DATVIG := Date()
			DA1->DA1_MOEDA  := 1
			DA1->DA1_QTDLOT := 999999.99
			DA1->DA1_INDLOT := "000000000999999.99"
			DA1->DA1_ATIVO  := "1"

			DA1->( MsUnLock() )

		EndIf

		DbSelectArea( cAliasDA1 )
		( cAliasDA1 )->( DbSkip() )
	EndDo
	( cAliasDA1 )->( DbCloseArea() )

Return


Static Function FReplicaInd( aParamEmpFil )

	Local nEmp 		 := 0
	Local cQuery 	 := ""
	Local cAliasSBZ	 := GetNextAlias()
	cQuery := "		SELECT * "
	cQuery += "		  FROM " + RetSQLName( "SBZ" )
	cQuery += "		 WHERE BZ_FILIAL = '" + MV_PAR01 + "' "
	cQuery == "	  ORDER BY BZ_FILIAL, BZ_COD "
	If Select( cAliasSBZ ) > 0
		( cAliasSBZ )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSBZ ) New
	nContador := 0
	Count To nContador
	ProcRegua( nContador )
	( cAliasSBZ )->( DbGoTop() )
	Do While !( cAliasSBZ )->( Eof() )

		IncProc( "Replicando Indicadores para Emp/Fil [ " + aParamEmpFil[nEmp][nPosFilial] + " ]" )

		DbSelectArea( "SBZ" )
		DbSetOrder( 01 ) // BZ_FILIAL + BZ_COD
		Seek ( cAliasSBZ )->( BZ_FILIAL + BZ_COD )
		If !Found()

			DbSelectArea( "SBZ" )
			RecLock( "SBZ", .T. )

			SBZ->BZ_FILIAL  := MV_PAR03
			SBZ->BZ_COD 	:= ( cAliasSBZ )->BZ_COD
			SBZ->BZ_LOCPAD 	:= ( cAliasSBZ )->BZ_LOCPAD
			SBZ->BZ_CUSTD 	:= 0
			SBZ->BZ_DTINCLU	:= Date()

			SBZ->( MsUnLock() )

		EndIf

		DbSelectArea( cAliasSBZ )
		( cAliasSBZ )->( DbSkip() )
	EndDo
	( cAliasSBZ )->( DbCloseArea() )

Return
