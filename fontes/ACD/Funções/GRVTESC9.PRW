#INCLUDE 'Protheus.ch'
#Include "TopConn.ch"
#Include "TbiConn.ch"

User Function GRVTESC9()

	Local aArea := GetArea()
	Local cAliasSC6 := GetNextAlias()
	Local cTes := ""
	Local cQuery := ""
	Local cUpdate := ""

	cQuery := "		SELECT * "
	cQuery += "		  FROM " + RetSQLName( "SC6" )
	cQuery += "		 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "		   AND C6_FILIAL = '"+AllTrim(SC5->C5_FILIAL)+"'"
	//cQuery += "		   AND C6_PRODUTO = '"+AllTrim(SC9->C5_PRODUTO)+"'"
	cQuery += "		   AND C6_NUM = '"+AllTrim(SC5->C5_NUM)+"'"

	If Select( cAliasSC6 ) > 0
		( cAliasSC6 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSC6 ) New
	While !( cAliasSC6 )->( Eof() )
		cUpdate := "	UPDATE " + RetSQLName( "SC9" )
		cUpdate += " 	   SET C9_XTES 	= '"+( cAliasSC6 )->C6_TES+"'"
		cUpdate += "	 WHERE D_E_L_E_T_ 	= ' ' AND "
		cUpdate += "	 C9_FILIAL =  '"+( cAliasSC6 )->C6_FILIAL+"' "
		cUpdate += " AND C9_PEDIDO = '"+( cAliasSC6 )->C6_NUM+"'"
		cUpdate += " AND C9_PRODUTO = '"+( cAliasSC6 )->C6_PRODUTO+"'"
		If TcSQLExec( cUpdate ) != 0
			Conout("Erro ao tentar atualizar a tabela SC9" + CRLF + TcSQLError())
		EndIf
		( cAliasSC6 )->( DbSkip() )
	EndDo
	( cAliasSC6 )->( DbCloseArea() )

	//RecLock("SC9",.F.)
	//SC9->C9_XTES := cTes
	//MsUnLock()
	fAtuAll()

	RestArea(aArea)
Return


Static Function fAtuAll()

	Local aArea := GetArea()
	Local cQuery := ""
	Local cQuery2 := ""
	Local cUpdate := ""
	Local cAliasSc9 := GetNextAlias()
	Local cAliasSC6 := GetNextAlias()


	cQuery := " SELECT * FROM " + RetSQLName("SC9") + " "
	cQuery += " WHERE D_E_L_E_T_ = ' ' AND C9_XTES = ' '"

	If Select( cAliasSc9 ) > 0
		( cAliasSc9 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSc9 ) New
	While !( cAliasSc9 )->( Eof() )


		cQuery2 := "		SELECT * "
		cQuery2 += "		  FROM " + RetSQLName( "SC6" )
		cQuery2 += "		 WHERE D_E_L_E_T_ = ' ' "
		cQuery2 += "		   AND C6_FILIAL = '"+( cAliasSc9 )->C9_FILIAL+"'"
		//cQuery += "		   AND C6_PRODUTO = '"+AllTrim(SC9->C5_PRODUTO)+"'"
		cQuery2 += "		   AND C6_NUM = '"+( cAliasSc9 )->C9_PEDIDO+"'"

		If Select( cAliasSC6 ) > 0
			( cAliasSC6 )->( DbCloseArea() )
		EndIf
		TcQuery cQuery2 Alias ( cAliasSC6 ) New
		While !( cAliasSC6 )->( Eof() )
			cUpdate := "	UPDATE " + RetSQLName( "SC9" )
			cUpdate += " 	   SET C9_XTES 	= '"+( cAliasSC6 )->C6_TES+"'"
			cUpdate += "	 WHERE D_E_L_E_T_ 	= ' ' AND "
			cUpdate += "	 C9_FILIAL =  '"+( cAliasSC6 )->C6_FILIAL+"' "
			cUpdate += " AND C9_PEDIDO = '"+( cAliasSC6 )->C6_NUM+"'"
			cUpdate += " AND C9_PRODUTO = '"+( cAliasSC6 )->C6_PRODUTO+"'"
			If TcSQLExec( cUpdate ) != 0
				Conout("Erro ao tentar atualizar a tabela SC9" + CRLF + TcSQLError())
			EndIf
			( cAliasSC6 )->( DbSkip() )
		EndDo
		( cAliasSC6 )->( DbCloseArea() )




		( cAliasSc9 )->( DbSkip() )
	EndDo
	( cAliasSc9 )->( DbCloseArea() )


	RestArea(aArea)
Return
