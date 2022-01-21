
/*/{Protheus.doc} UNIR007

@project Relatório de Conferência de Entrada
@modulo SIGACOM
@type Relatório
@description Relatório de Conferência de Entrada
@author Rafael Rezende
@since 26/08/2019
@version 1.0
@return
@see www.thebestconsulting.com.br
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*---------------------*
User Function UNIR007()
	*---------------------*
	Local oReport       := Nil
	Private cAliasQry   := GetNextAlias()
	Private cPerg		:= "UNIR007K"
	Private cNome   	:= ""
	Private cHistorico  := ""
	Private nValor 	 	:= 0.00

	Pergunte( cPerg, .T. )

	If TRepInUse()

		oReport:= ReportDef()
		oReport:PrintDialog()

	EndIf

Return

*-------------------------*
Static Function ReportDef()
	*-------------------------*
	Local oSection1  	:= Nil
	//Local oBreak		:= Nil
	oReport 			:= TReport():New( cPerg, "Relatório Conferência de Entrada", cPerg, { |oReport| FGeraRelatorio( oReport ) }, "Relatório de Movimento Bancário" )
	oReport:SetLandScape()
	oReport:SetTotalInLine(.F.)
	oSection1 := TRSection():New( oReport, "Relatório Conferência de Entrada", { "SD1" },, .F., .T. )

	TRCell():New(oSection1, "D1_FILIAL"   	, cAliasQry, "Filial"		, "@!"					 , TamSX3( "D1_FILIAL"  )[01] )
	TRCell():New(oSection1, "D1_DOC" 	  	, cAliasQry, "Nota"			, "@!"					 , TamSX3( "D1_DOC"     )[01] )
	TRCell():New(oSection1, "D1_SERIE" 	  	, cAliasQry, "Série"		, "@!"					 , TamSX3( "D1_SERIE"   )[01] )
	TRCell():New(oSection1, "D1_FORNECE"   	, cAliasQry, "Fornecedor"	, "@!"					 , TamSX3( "D1_FORNECE" )[01] )
	TRCell():New(oSection1, "D1_LOJA" 	  	, cAliasQry, "Loja"			, "@!"					 , TamSX3( "D1_LOJA"    )[01] )
	TRCell():New(oSection1, "A2_NOME" 	  	, cAliasQry, "Razão Social"	, "@!"					 , TamSX3( "A2_NOME"    )[01] )
	TRCell():New(oSection1, "D1_EMISSAO"  	, cAliasQry, "Emissão"		, "@D"					 , 08 						  )
	TRCell():New(oSection1, "D1_COD" 	  	, cAliasQry, "Produto"		, "@!"					 , TamSX3( "D1_COD"     )[01] )
	TRCell():New(oSection1, "B1_DESC" 	  	, cAliasQry, "Descrição"	, "@!"					 , TamSX3( "B1_DESC"    )[01] )
	TRCell():New(oSection1, "A5_CODPRF"   	, cAliasQry, "Prod.Forn."	, "@!"					 , TamSX3( "A5_CODPRF"  )[01] )
	TRCell():New(oSection1, "QUANTIDADE"   	, cAliasQry, "Quantidade"	, "@!"					 , 20                         )
	oReport:SetTotalInLine( .F. )

	//Aqui, farei uma quebra  por seção
	oSection1:SetPageBreak( .T. )
	oSection1:SetTotalText( " " )

Return( oReport )

*---------------------------------------*
Static Function FGeraRelatorio( oReport )
	*---------------------------------------*
	//Local aAreaSM0  := SM0->( GetArea() )
	Local oSection1	  := oReport:Section( 01 )

	// Valida os Parâmetros
	If Empty( MV_PAR02 )
		Aviso( "Atenção", "O Parâmetro [ Nota até ? ] é Obrigatório.", { "Voltar" } )
		Return
	EndIf

	If Empty( MV_PAR04 )
		Aviso( "Atenção", "O Parâmetro [ Série de ? ] é Obrigatório.", { "Voltar" } )
		Return
	EndIf
	If Empty( MV_PAR07 )
		Aviso( "Atenção", "O Parâmetro [ Fornecedor até ? ] é Obrigatório.", { "Voltar" } )
		Return
	EndIf

	If Empty( MV_PAR08 )
		Aviso( "Atenção", "O Parâmetro [ Loja até ? ] é Obrigatório.", { "Voltar" } )
		Return
	EndIf

	If Empty( MV_PAR10 )
		Aviso( "Atenção", "O Parâmetro [ Data até ? ] é Obrigatório.", { "Voltar" } )
		Return
	EndIf

	If Empty( MV_PAR12 )
		Aviso( "Atenção", "O Parâmetro [ Produto até ? ] é Obrigatório.", { "Voltar" } )
		Return
	EndIf

	DbSelectArea( "SA5" )
	DbSetOrder( 01 ) // A5_FILIAL + A5_FORNECE + A5_LOJA + A5_PRODUTO + A5_FABR + A5_FALOJA

	cQuery := "   		 SELECT D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA,	"
	cQuery += "		 			D1_COD, D1_EMISSAO, B1_DESC, A2_NOME  				"
	cQuery += " 	       FROM " + RetSQLName( "SD1" ) + " SD1 (NOLOCK), "
	cQuery += "	      			" + RetSQLName( "SA2" ) + " SA2 (NOLOCK), "
	cQuery += "	      			" + RetSQLName( "SB1" ) + " SB1 (NOLOCK)  "
	cQuery += "           WHERE D1_FILIAL	   	 = '" + XFilial( "SD1" ) + "' "
	cQuery += "             AND A2_FILIAL	   	 = '" + XFilial( "SA2" ) + "' "
	cQuery += "             AND B1_FILIAL	   	 = '" + XFilial( "SB1" ) + "' "
	cQuery += " 	 		AND SD1.D_E_L_E_T_ 	 = ' '	"
	cQuery += " 	 		AND SA2.D_E_L_E_T_ 	 = ' '	"
	cQuery += " 	 		AND SB1.D_E_L_E_T_ 	 = ' '	"
	cQuery += "             AND D1_FORNECE 		 = A2_COD  "
	cQuery += "             AND D1_LOJA    	 	 = A2_LOJA "
	cQuery += "             AND D1_COD 		 	 = B1_COD  "
	cQuery += " 	 		AND D1_DOC	   BETWEEN '" + MV_PAR01 		 + "' AND '" + MV_PAR02 		+ "' "
	cQuery += " 	 		AND D1_SERIE   BETWEEN '" + MV_PAR03 		 + "' AND '" + MV_PAR04 		+ "' "
	cQuery += " 	 		AND D1_FORNECE BETWEEN '" + MV_PAR05 		 + "' AND '" + MV_PAR07 		+ "' "
	cQuery += " 	 		AND D1_LOJA	   BETWEEN '" + MV_PAR06 		 + "' AND '" + MV_PAR08 		+ "' "
	cQuery += " 	 		AND D1_EMISSAO BETWEEN '" + DToS( MV_PAR09 ) + "' AND '" + DToS( MV_PAR10 ) + "' "
	cQuery += " 	 		AND D1_COD	   BETWEEN '" + MV_PAR11 		 + "' AND '" + MV_PAR12 		+ "' "
	cQuery += "        ORDER BY D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA "
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	MemoWrite( "C:\Temp\UNIR007.txt", cQuery )
	TcQuery cQuery Alias ( cAliasQry ) New

	nContador := 0
	Count To nContador
	( cAliasQry )->( DbGoTop() )
	oReport:SetMeter( nContador )
	oSection1:Init()
	Do While !( cAliasQry )->( Eof() )

		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf

		DbSelectArea( "SA5" )
		DbSetOrder( 01 ) // A5_FILIAL + A5_FORNECE + A5_LOJA + A5_PRODUTO + A5_FABR + A5_FALOJA
		Seek XFilial( "SA5" ) + ( cAliasQry )->( D1_FORNECE + D1_LOJA + D1_COD )
		If Found()
			cAuxCodForn := SA5->A5_CODPRF
		Else
			cAuxCodForn := "N/E"
		EndIf

		oSection1:Cell( "D1_FILIAL" ):SetValue( ( cAliasQry )->D1_FILIAL 		)
		oSection1:Cell( "D1_DOC" 	):SetValue( ( cAliasQry )->D1_DOC 			)
		oSection1:Cell( "D1_SERIE" 	):SetValue( ( cAliasQry )->D1_SERIE 		)
		oSection1:Cell( "D1_FORNECE"):SetValue( ( cAliasQry )->D1_FORNECE 		)
		oSection1:Cell( "D1_LOJA" 	):SetValue( ( cAliasQry )->D1_LOJA 			)
		oSection1:Cell( "A2_NOME"   ):SetValue( ( cAliasQry )->A2_NOME	 		)
		oSection1:Cell( "D1_EMISSAO"):SetValue( ( cAliasQry )->D1_EMISSAO 		)
		oSection1:Cell( "D1_COD" 	):SetValue( ( cAliasQry )->D1_COD 			)
		oSection1:Cell( "B1_DESC" 	):SetValue( ( cAliasQry )->B1_DESC 			)
		oSection1:Cell( "A5_CODPRF" ):SetValue( cAuxCodForn				  		)
		oSection1:Cell( "QUANTIDADE"):SetValue( Replicate( "_", 15 ) 			)

		oSection1:PrintLine()

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	oSection1:Finish()

Return
