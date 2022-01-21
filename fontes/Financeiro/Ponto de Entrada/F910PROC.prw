#Include "TOTVS.ch"
#Include "TopConn.ch"

*-------------------------------*
User Function F910PROC( cCamArq )
	*-------------------------------*
	Local aAreaAnt  	:= GetArea()
	Local aAreaSA6  	:= SA6->( GetArea() )
	Local aAreaFIF  	:= FIF->( GetArea() )
	Local cAliasQry 	:= GetNextAlias()
	Local cAliasSA6 	:= GetNextAlias()
	Local cQuery 		:= ""
	Local cAuxBanco 	:= ""
	Local cAuxAgencia 	:= ""
	Local cAuxConta 	:= ""
	Local lAlterou 		:= .F.
	Local nContador 	:= 0
	//Executa a rotina Padrão de Importação do SITEF para manter o Padrão
	A910VldArq( cCamArq, @lEnd )

	// Segue com a Customização para acertar os dados de Banco / Agência / Conta
	cQuery := "		SELECT DISTINCT R_E_C_N_O_ AS NUMRECFIF "
	cQuery += "		  FROM " + RetSQLName( "FIF" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND FIF_STATUS = '1' "
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

		IncProc( "Validando informações dos bancos, aguarde..." )
		DbSelectArea( "FIF" )
		FIF->( DbGoTo( ( cAliasQry )->NUMRECFIF ) )

		lAlterou 		:= .F.
		cAuxBanco 		:= AllTrim( Str( Val( FIF->FIF_CODBCO ) ) )
		cAuxAgencia 	:= AllTrim( Str( Val( FIF->FIF_CODAGE ) ) )
		cAuxConta 		:= AllTrim( Str( Val( FIF->FIF_NUMCC  ) ) )

		cQuery := "	SELECT A6_FILIAL, A6_COD, A6_AGENCIA, A6_NUMCON "
		cQuery += "	  FROM " + RetSQLName( "SA6" )
		cQuery += "  WHERE D_E_L_E_T_ = ' ' "
		cQuery += "    AND CHARINDEX( '"   + cAuxBanco 	 + "', A6_COD	, 01  ) > 0 "
		cQuery += "    AND CHARINDEX( '"   + cAuxAgencia + "', A6_AGENCIA, 01 ) > 0 "
		cQuery += "    AND ( CHARINDEX( '" + cAuxConta 	 + "', A6_NUMCON , 01 ) > 0 "
		cQuery += "       OR CHARINDEX( '" + Left( cAuxConta, ( Len( cAuxConta ) - 01 ) ) + "', A6_NUMCON, 01 ) > 0 ) "
		If Select( cAliasSA6 ) > 0
			( cAliasSA6 )->( DbCloseArea() )
		EndIf
		TcQuery cQuery Alias ( cAliasSA6 ) New
		If !( cAliasSA6 )->( Eof() )

			lAlterou 		:= .T.
			cAuxBanco 		:= ( cAliasSA6 )->A6_COD
			cAuxAgencia 	:= ( cAliasSA6 )->A6_AGENCIA
			cAuxConta 		:= ( cAliasSA6 )->A6_NUMCON

		EndIf

		If lAlterou

			DbSelectArea( "FIF" )
			RecLock( "FIF", .F. )
			FIF->FIF_CODBCO := cAuxBanco
			FIF->FIF_CODAGE := cAuxAgencia
			FIF->FIF_NUMCC  := cAuxConta
			FIF->( MsUnLock() )

		EndIf

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	RestArea( aAreaSA6 )
	RestArea( aAreaFIF )
	RestArea( aAreaAnt )

Return