*----------------------------------*
/*/{Protheus.doc} UNIR001

@project Impressão de Boletos de Cobrança ( Itaú ) para Cliente Única

@description Relatório de Impressão de Boleto Bancário para o Itaú
@files  \system\lgritau.jpg - Logo para Boleto do Itau
@author Rafael Rezende
@since 26/03/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#INCLUDE "RwMake.ch"
#Include "TOTVS.ch"
#INCLUDE "RptDef.ch"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "Shell.ch"
#INCLUDE "TbiConn.CH"
#INCLUDE "COLORS.CH"

#DEFINE IMP_SPOOL 2

*-------------------------------------------------------------------------------------*
User Function UNIR001( cParamPrefixo, cParamDeNumero, cParamAteNumero, lParamSchedule )
	*-------------------------------------------------------------------------------------*
	Local oFontProc     	:= Nil
	Local oDlgProc      	:= Nil
	Local oGrpTexto 	    := Nil
	Local oSayTexto	    	:= Nil
	Local oBtnConfi     	:= Nil
	Local oBtnParam 	    := Nil
	Local oBtnSair	      	:= Nil
	Local lHtml         	:= .T.
	Local lConfirmou	    := .F.
	Local cPerg         	:= "UNIR001Z"
	Local cTitulo   	    := "Impressão de Boleto Bancário no Layout <font color='red'>ITAÚ.</font><br>Informe os parâmetros desejados e confirme a rotina."

	//Default cParamFilial	:= ""
	Default cParamPrefixo	:= ""
	Default cParamDeNumero    := ""
	Default cParamAteNumero    := ""
	//Default cParamTipo      := ""
	//Default cParamParcela   := ""
	//Default cParamCliente   := ""
	//Default cParamLoja	    := ""
	Default lParamSchedule  := .F.

	cTitulo             	:= "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTitulo, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )
	If AllTrim( cParamDeNumero ) == ""

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 800, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 759, "Impressão de Boletos de Cobrança ITAÚ",,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 302, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTitulo }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || If( FVldParametros(), FImprime( cParamDeNumero, lParamSchedule ), ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 070, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		//oBtnSair  := TButton():New( 092, 135, "&Env.Mail"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnSair  := TButton():New( 092, 170, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )

		oDlgProc:Activate( ,,,.T. )

	Else

		MV_PAR01	:= cParamPrefixo
		MV_PAR02	:= cParamPrefixo
		MV_PAR03	:= cParamDeNumero
		MV_PAR04	:= cParamAteNumero
		MV_PAR05	:= Space( TamSX3( "E1_PARCELA" 	)[01] )
		MV_PAR06	:= Replicate( "Z", TamSX3( "E1_PARCELA" )[01] )
		MV_PAR07	:= Space( TamSX3( "E1_PORTADOR" 	)[01] )
		MV_PAR08	:= Replicate( "Z", TamSX3( "E1_PORTADOR" )[01] )
		MV_PAR09	:= Space( TamSX3( "E1_CLIENTE" 	)[01] )
		MV_PAR10	:= Replicate( "Z", TamSX3( "E1_CLIENTE" )[01] )
		MV_PAR11	:= Space( TamSX3( "E1_LOJA" 	)[01] )
		MV_PAR12	:= Replicate( "Z", TamSX3( "E1_LOJA" )[01] )
		MV_PAR13	:= CToD( "01/01/2000" )
		MV_PAR14	:= CToD( "31/12/2040" )
		MV_PAR15	:= CToD( "01/01/2000" )
		MV_PAR16	:= CToD( "31/12/2040" )
		MV_PAR17	:= Space( TamSX3( "E1_NUMBOR" 	)[01] )
		MV_PAR18	:= Replicate( "Z", TamSX3( "E1_NUMBOR" )[01] )
		MV_PAR19	:= 2
		MV_PAR20	:= 2
		//FImprime( cParamFilial, cParamPrefixo, cParamNumero, cParamTipo, cParamParcela, cParamCliente, cParamLoja, lParamSchedule )
		FImprime( cParamDeNumero, lParamSchedule )

	EndIf

Return


Static function FVldParametros()

	Local lRet := .T.

	If AllTrim( MV_PAR02 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Prefixo ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR04 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Número ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR06 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Parcela? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR08 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Portador? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR10 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Cliente? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR12 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Loja? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. Empty( MV_PAR14 )
		Aviso( "Atenção", "O Parâmetro [ Até a Emissão? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. Empty( MV_PAR16 )
		Aviso( "Atenção", "O Parâmetro [ Até Vencimento? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR18 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até Borderô? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet

*-----------------------------------------------------------------------------------------------------------------------------------------*
//Static Function FImprime( cParamFilial, cParamPrefixo, cParamNumero, cParamTipo, cParamParcela, cParamCliente, cParamLoja, lParamSchedule )
Static Function FImprime( cParamNumero, lParamSchedule )
	*-----------------------------------------------------------------------------------------------------------------------------------------*
	Local	aPergs 	   	:= {}
	Private lExec      	:= .F.
	Private cIndexName 	:= ""
	Private cIndexKey  	:= ""
	Private cFilter    	:= ""
	Private cNumNF		:= If( cParamNumero == Nil, CriaVar( "E1_NUM" ), cParamNumero )
	Private oPrint  	:= Nil
	Private oFont1 		:= Nil
	Private oFont2  	:= Nil
	Private oFont3  	:= Nil
	Private oFont4  	:= Nil
	Private oFont5  	:= Nil
	Private oFont6  	:= Nil
	Private oFont7  	:= Nil
	Private Strfil    	:= ""
	Private l_imp   	:= .F.

	Define FONT oFont1 NAME "Arial" SIZE 0,10 OF oPrint
	Define FONT oFont2 NAME "Arial" SIZE 0,12 OF oPrint BOLD
	Define FONT oFont3 NAME "Arial" SIZE 0,16 OF oPrint BOLD
	Define FONT oFont4 NAME "Arial" SIZE 0,11 OF oPrint BOLD
	Define FONT oFont5 NAME "Arial" SIZE 0,19 OF oPrint BOLD
	Define FONT oFont7 NAME "Arial" SIZE 0,25 OF oPrint
	Define FONT oFont6 NAME "Arial" SIZE 0,22 OF oPrint BOLD
	Define FONT oFont8 NAME "Arial" SIZE 0,16 OF oPrint BOLD


	Private oOk       		:= LoadBitmap( GetResources() , "LBOK" 	   ) // Marcado
	Private oNo       		:= LoadBitmap( GetResources() , "LBNO" 	   ) // Desmarcado
	Private oVerde      	:= LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
	Private oVermelho   	:= LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho
	Private aListTitulos	:= {}
	Private aTitListTitulos := {}
	Private aSizeListTitulos:= {}
	Private bLinesTitulos	:= { || }
	Private lMarcaDesmarca  := .T.

	Private nPosMarcado		:= 01
	Private nPosFilial		:= 02
	Private nPosPrefixo		:= 03
	Private nPosTipo		:= 04
	Private nPosNumero		:= 05
	Private nPosParcela		:= 06
	Private nPosValor		:= 07
	Private nPosSaldo		:= 08
	Private nPosVencto		:= 09
	Private nPosVencReal	:= 10
	Private nPosNumBco		:= 11
	Private nPosNumBor		:= 12
	Private nPosCliente		:= 13
	Private nPosLoja		:= 14
	Private nPosNome		:= 15
	Private nPosRecNo		:= 16

	Tamanho  := "M"
	Titulo   := "Impressão de Boleto com Codigo de Barras"
	cDesc1   := "Este programa destina-se a impressão do Boleto com Codigo de Barras."
	cDesc2   := "para o Banco Itaú. Layout Única"
	cDesc3   := ""
	cString  := "SE1"
	WnRel    := "UNIR001"
	lEnd     := .F.
	//cPerg    :="UNIR001"
	aReturn  := { "Zebrado", 01, "Administracao", 02, 02, 01, "", 01 }
	nLastKey := 0

	//If !lParamSchedule
	//	If !Pergunte( cPerg  , .T. )
	//		Return
	//	EndIf
	//EndIf

	/*
DbSelectArea( "SE1" )
cIndexName	:= Criatrab( Nil, .F. )
cIndexKey	:= "E1_PORTADO + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + DTOS( E1_EMISSAO )" // Ordem utilizada na FBD

cFilter		:= " E1_FILIAL  == '" + XFilial( "SE1" ) + "' .And. E1_SALDO > 0 .And. "
cFilter		+= " E1_PREFIXO >= '" + MV_PAR01 + "' .And. E1_PREFIXO <= '" + MV_PAR02 + "' .And. "
cFilter		+= " E1_NUM		>= '" + MV_PAR03 + "' .And. E1_NUM     <= '" + MV_PAR04 + "' .And. "
cFilter		+= " E1_PARCELA >= '" + MV_PAR05 + "' .And. E1_PARCELA <= '" + MV_PAR06 + "' .And. "
cFilter		+= " E1_PORTADO >= '" + MV_PAR07 + "' .And. E1_PORTADO <= '" + MV_PAR08 + "' .And. "
cFilter		+= " E1_CLIENTE >= '" + MV_PAR09 + "' .And. E1_CLIENTE <= '" + MV_PAR10 + "' .And. "
cFilter		+= " E1_LOJA	>= '" + MV_PAR11 + "' .And. E1_LOJA    <= '" + MV_PAR12 + "' .And. "
cFilter		+= " DToS( E1_EMISSAO ) >= '" + DToS( MV_PAR13 ) + "' .And. DToS( E1_EMISSAO ) <= '" + DToS( MV_PAR14 ) + "' .And. "
If Empty( cNumNF )
	cFilter	+= "DTOS( E1_VENCREA ) >= '" + DToS( MV_PAR15 ) + "' .And. DToS( E1_VENCREA ) <= '" + DToS( MV_PAR16 ) + "' .And. "
EndIf
cFilter		+= " E1_NUMBOR >= '" + MV_PAR17 + "' .And. E1_NUMBOR <= '" + MV_PAR18 + "' .And. "
cFilter		+= " !( E1_TIPO $ MVABATIM ) " //.And. "
//cFilter		+= " E1_PORTADO == '341' "
IndRegua( "SE1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")
DbSelectArea( "SE1" )
SE1->( DbGoTop() )
If Empty( cNumNF )

	lExec := .F.
	@ 001, 001 To 400, 700 Dialog oDlg Title "Seleção de Titulos"
	@ 001, 001 To 170, 350 Browse "SE1" Mark "E1_OK"
	@ 180, 310 BmpButton Type 01 Action ( lExec := .T., Close( oDlg ) )
	@ 180, 280 BmpButton Type 02 Action ( lExec := .F., Close( oDlg ) )
	Activate Dialog oDlg Centered

Else

	lExec := .T.
	l_imp := .T.

EndIf

SE1->( DbGoTop() )
If lExec
	Processa( { |lEnd| FMontBolItau( lParamSchedule, cNumNF ) } )
EndIf

DbSelectArea( "SE1" )
RetIndex( "SE1" )
Ferase( cIndexName + OrdBagExt() )

DbSelectArea( "SE1" )
Set Filter to
//dbCommitAll()
	*/

	DbSelectArea( "SE1" )
	MsgRun( "Carregando Títulos, aguarde...", "Carregando Títulos, aguarde...", { || FCarregaTitulos( cNumNF ) } )

	If AllTrim( cNumNF ) == ""

		// Mostra a Tela de Seleção de Boletos
		lExec := .F.
		SetPrvt("oDlgBoletos","oGrpTitulos","oBtnOk","oBtnSair","oSayF7","oListTitulos")
		oDlgBoleto 		:= MSDialog():New( 138,254,695,1270,"Impressão de Boletos de Cobrança",,,.F.,,,,,,.T.,,,.F. )
		oGrpTitulos     := TGroup():New( 003,007,266,456," Títulos ",oDlgBoletos,CLR_HBLUE,CLR_WHITE,.T.,.F. )
		oBtnOk     		:= TButton():New( 004,460,"Confirmar",oDlgBoletos,,037,012,,,,.T.,,"",,,,.F. )
		oBtnOk:bAction 	:= { || lExec := .T., oDlgBoletos:End() }
		oBtnSair      	:= TButton():New( 020,460,"Sair",oDlgBoletos,,037,012,,,,.T.,,"",,,,.F. )
		oBtnSair:bAction:= { || lExec := .F., oDlgBoletos:End() }
		oSayF7     		:= TSay():New( 252,458,{||"<F7>=Pesquisar"},oDlgBoletos,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,041,008)

		aTitListTitulos  := {}
		aSizeListTitulos := {}
		aAdd( aTitListTitulos , "" 			)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BB"	   ) )
		aAdd( aTitListTitulos , "FIL" 			)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BB" 	   ) )
		aAdd( aTitListTitulos , "PRE" 		)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBB" 	   ) )
		aAdd( aTitListTitulos , "TIPO" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBB" ) )
		aAdd( aTitListTitulos , "NUMERO" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBB" ) )
		aAdd( aTitListTitulos , "PAR" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BB" ) )
		aAdd( aTitListTitulos , "VALOR" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBBBB" ) )
		aAdd( aTitListTitulos , "SALDO" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBBBB" ) )
		aAdd( aTitListTitulos , "VENCTO" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBB" ) )
		aAdd( aTitListTitulos , "VEN.REAL" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBB" ) )
		aAdd( aTitListTitulos , "NOSSO NUM" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBB" ) )
		aAdd( aTitListTitulos , "BORD." 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBB" ) )
		aAdd( aTitListTitulos , "CLIENTE" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBB" ) )
		aAdd( aTitListTitulos , "LOJA" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BB" ) )
		aAdd( aTitListTitulos , "NOME" 	)
		aAdd( aSizeListTitulos, GetTextWidth( 0, "BBBBBBBBBBBBBBBBBB" ) )

		//oListTitulos	:= TListBox():New( 012,012,,,437,249,,oGrpTitulos,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
		oListTitulos 	:= TwBrowse():New( 012, 012, 437, 249,, aTitListTitulos, aSizeListTitulos, oGrpTitulos,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
		oListTitulos:SetArray( aListTitulos )

		bLinesTitulos	:= 				{ || { 	If( aListTitulos[oListTitulos:nAt][nPosMarcado], oOk, oNo )	,; // Marcado
			AllTrim( aListTitulos[oListTitulos:nAt][nPosFilial]   ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosPrefixo]  ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosTipo]     ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosNumero]   ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosParcela]  ) 			,; // Filial
			AllTrim( TransForm( aListTitulos[oListTitulos:nAt][nPosValor], "@E 999,999,999.99" )  ) 			,; // Filial
			AllTrim( TransForm( aListTitulos[oListTitulos:nAt][nPosSaldo], "@E 999,999,999.99" )  ) 			,; // Filial
			DToC( aListTitulos[oListTitulos:nAt][nPosVencto]   ) 			,; // Filial
			DToC( aListTitulos[oListTitulos:nAt][nPosVencReal] ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosNumBco]   ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosNumBor]   ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosCliente]  ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosLoja]     ) 			,; // Filial
			AllTrim( aListTitulos[oListTitulos:nAt][nPosNome]     ) 			}} // Filial

		oListTitulos:bLine 	   		:= bLinesTitulos
		oListTitulos:bLDblClick 	:= { || FSeleciona( oListTitulos, @aListTitulos, nPosNumero, nPosMarcado, 0 ) }
		oListTitulos:bHeaderClick 	:= { || FSelectAll( oListTitulos, @aListTitulos, nPosNumero, nPosMarcado, @lMarcaDesmarca ) }
		oListTitulos:Refresh()

		oDlgBoletos:Activate( ,,, .T. )

	Else

		lExec := .T.
		l_imp := .T.

	EndIf

	If lExec
		Processa( { |lEnd| FMontBolItau( lParamSchedule, cNumNF ) }, "Aguarde..." )
	EndIf

Return Nil

/*
*---------------------------------------------------------*
Static Function FMontBolItau( lParamSchedule, cParamNumNF )
*---------------------------------------------------------*

Local lEnvMail 		:= ( MV_PAR19 == 01 )
Default cParamNumNF := ""

DbSelectArea( "SE1" )
SE1->( DbGoTop() )
//ProcRegua( RecCount() )
//SE1->( DbGoTop() )
DbSelectArea( "SE1" )
Do While !Eof()

	IncProc( "Imprimindo boleto(s), aguarde..." )
	If !l_imp

		If AllTrim( cParamNumNF ) == ""
			If !Marked( "E1_OK" ) // Verifica se esta flegado
				SE1->( Dbskip() )
				Loop
			EndIf
	    EndIf

	EndIf

	U_DBOLITAU( lParamSchedule, lEnvMail, .T. )

	DbSelectArea( "SE1" )
	SE1->( DbSkip() )
EndDo

Return
*/

*---------------------------------------------------------*
Static Function FMontBolItau( lParamSchedule, cParamNumNF )
	*---------------------------------------------------------*
	Local lEnvMail 		:= ( MV_PAR19 == 01 )
	Default cParamNumNF := ""

	DbSelectArea( "SE1" )
	SE1->( DbSetOrder( 01 ) )
	ProcRegua( Len( aListTitulos )  )
	For nT := 01 To Len( aListTitulos )

		IncProc( "Imprimindo boleto(s), aguarde..." )
		If aListTitulos[nT][nPosMarcado]

			DbSelectArea( "SE1" )
			SE1->( DbGoTo( aListTitulos[nT][nPosRecNo] ) )
			U_DBOLITAU( lParamSchedule, lEnvMail, .T. )

		EndIf

	Next nT

Return

*-------------------------------------------------------------------------------*
User Function DBOLITAU( lParamSchedule, lParamEnvMail, lParamSetup, cParamFiles )
	*-------------------------------------------------------------------------------*
	Local aBitmap 	:= { 	  02, "LGRL.bmp" } // Logo da Empresa//{ 	  MV_PAR19, "LGRL.bmp" } // Logo da Empresa
	Local aDadosEmp := { 	  SM0->M0_NOMECOM	,;		//[1]Nome da Empresa
		SM0->M0_ENDCOB	,; 		//[2]Endereço
		AllTrim( SM0->M0_BAIRCOB ) + ", " + AllTrim( SM0->M0_CIDCOB  ) + ", " + SM0->M0_ESTCOB  ,;  	//[3]Complemento
		"CEP: " + TransForm( SM0->M0_CEPCOB, "@R 99.999-999" ) ,;	//[4]CEP
		"PABX/FAX: " + SM0->M0_TEL		,; 		//[5]Telefones
		"C.N.P.J.: " + TransForm( SM0->M0_CGC	,  "@R 99.999.999/9999-99" ) ,; // CNPJ
		"I.E.: " + TransForm( SM0->M0_INSC	, "@R 999.999.999.999" ) } // I.E.
	/*
	 			SubStr( SM0->M0_INSC, 04, 03 ) + "." + ;
				SubStr( SM0->M0_INSC, 07, 03 ) + "." + ;
				SubStr( SM0->M0_INSC, 10, 03 ) }	//[7]I.E
   				+ "." + ;
   				SubStr( SM0->M0_CGC,  03, 03 ) + "." + ;
   				SubStr( SM0->M0_CGC,  06, 03 ) + "/" + ;
   				SubStr( SM0->M0_CGC,  09, 04 ) + "-" + ;
   				SubStr( SM0->M0_CGC,  13, 02 ) ,;	//[6]CGC
	*/
	Local aDadosTit
	Local aDadosBanco
	Local aDatSacado
	Local aBolText    	:= { 	"APÓS VENCIMENTO MORA DIARIA DE R$ 3,10"		,;
		"3 DIAS APÓS O VENCIMENTO SUJEITO A PROTESTO"	,;
		"VENDEDORES NÃO ESTÃO AUTORIZADOS A RECEBER"    ,;
		"VISITE NOSSO SITE: WWW.UNICARIO.COM.BR"        ,;
		"NEGATIVAÇÃO APÓS 3 DIAS VENCIMENTO"  			 }
	Local aBMP        	:= {} //aBitMap
	Local CB_RN_NN    	:= {}
	Local nRec        	:= 0
	Local _nVlrAbat 	:= 0
	Local cNomeArq 		:= ""
	//Local cServidor 	:= AllTrim( GetMv( "MV_RELSERV" ) )
	//Local cConta 		:= AllTrim( GetMv( "MV_RELACNT" ) ) //GetMv( "MV_MAILCOB" ) ) //GETMV("MV_RELACNT")
	//Local cPass 		:= AllTrim( GetMv( "MV_RELPSW"  ) ) // GetMv( "MV_PSWCOB"  ) )  //GETMV("MV_RELPSW")
	//Local cEnMail 		:= AllTrim( GetNewPar( "MV_XMAILBO", "" ) )
	//Private cSubCon 	:= AllTrim( GetNewPar( "MV_XSUBITA", "001" ) )
	Private _cNosNu   	:= " "
	Private aCabExc   	:= { "Prefixo", "Número do Título", "Descrição do Erro" }
	Private aErroExc  	:= {}

	Default lParamSetup := .T.
	Default cParamFiles := Nil

	/*
DbSelectArea( "SZ4" )
DbSetOrder( 01 )
DbGoTop()

//Pega as configurações de Banco agência e Conta

DbSelectArea( "SZ6" )
SZ6->( DbSetOrder( 01 )  )
Seek XFilial( "SZ6" ) + SZ4->( Z4_CODIGO + Z4_AGENCIA + Z4_CONTA + Z4_SUBCONT )
If !Found()
	If lParamSchedule
		ConOut( "UNIR001 - Não encontrou a configuração para o Banco na tabela SZ6" )
	Else
		Aviso( "Atenção", "Não encontrou a configuração para o Banco na tabela SZ6", { "Sair" } )
		Return
	EndIf
EndIf
	*/

	DbSelectArea( "SZ4" )
	DbSetOrder( 1 )
	Dbseek(xFilial("SZ4")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)

	//Pega as configurações de Banco agência e Conta
	DbSelectArea( "SZ6" )
	SZ6->( DbSetOrder( 01 )  )
	Seek XFilial( "SZ6" ) + SZ4->( Z4_CODIGO + Z4_AGENCIA + Z4_CONTA + Z4_SUBCONT )

	//Pega as configurações de Banco agência e Conta
	//DbSelectArea( "SZ6" )
	//SZ6->( DbSetOrder( 01 )  )
	//Seek XFilial( "SZ6" ) + "033"
	If !Found()
		If lParamSchedule
			ConOut( "UNIR002 - Não encontrou a configuração para o Banco na tabela SZ6" )
		Else
			Aviso( "Atenção", "Não encontrou a configuração para o Banco na tabela SZ6", { "Sair" } )
			Return
		EndIf
	EndIf

	DbSelectArea( "SA6" )
	DbSetOrder( 01 )
	//Seek XFilial( "SA6" ) + SE1->( E1_PORTADO + E1_AGEDEP + E1_CONTA )
	Seek XFilial( "SA6" ) + SZ6->( Z6_CODIGO + Z6_AGENCIA + Z6_CONTA )
	If Found()

		// Posiciona na Arq de Parametros CNAB
		DbSelectArea( "SEE" )
		DbSetOrder( 01 )
		//Seek XFilial( "SEE" ) + SE1->( E1_PORTADO + E1_AGEDEP + E1_CONTA ) + cSubCon
		//Seek XFilial( "SEE" ) + SZ6->( Z6_CODIGO + Z6_AGENCIA + Z6_CONTA + Z6_SUBCTA )
		Seek SZ6->( Z6_FILIALS + Z6_CODIGO + Z6_AGENCIA + Z6_CONTA + Z6_SUBCTA )
		If Found()
			/*
		If ( !Empty( SEE->EE_FORMEN1 ) .Or. ;
			 !Empty( SEE->EE_FORMEN2 ) .Or. ;
			 !Empty( SEE->EE_FOREXT1 ) .Or. ;
			 !Empty( SEE->EE_FOREXT2 ) 	)

			aBolText     := { If( AllTrim( SEE->EE_FORMEN1 ) != "", &SEE->EE_FORMEN1, "" ) ,;
		                      If( AllTrim( SEE->EE_FORMEN2 ) != "", &SEE->EE_FORMEN2, "" ) ,;
		                      If( AllTrim( SEE->EE_FOREXT1 ) != "", &SEE->EE_FOREXT1, "" ) ,;
		                      If( AllTrim( SEE->EE_FOREXT2 ) != "", &SEE->EE_FOREXT2, "" ) ,;
		                      ""															}
		Else
			*/
			If SEE->EE_XPJUROS > 0
				cAuxTexto := "APÓS VENCIMENTO COBRAR JUROS DE " + AllTrim( TransForm( SEE->EE_XPJUROS, "@E 999" ) + "% A.M" )
			Else
				cAuxTexto := "APÓS VENCIMENTO COBRAR JUROS DE 5% A.M"
			EndIf

			aBolText     := { 	cAuxTexto										,;
				"30 DIAS APOS O VENCIMENTO SUJEITO A PROTESTO"	,;
				"NEGATIVACAO 1 DIA APOS O VENCIMENTO"			,;
				"VENDEDORES NÃO ESTÃO AUTORIZADOS A RECEBER"    ,;
				"VISITE NOSSO SITE: WWW.UNICARIO.COM.BR"         }

			//		EndIf

			//Posiciona o SA1 (Cliente)
			DbSelectArea( "SA1" )
			DbSetOrder( 01 )
			Seek XFilial( "SA1" ) + SE1->( E1_CLIENTE + E1_LOJA )
			If Found()

				// Seleciona o SE1 (Contas a Receber)
				DbSelectArea( "SE1" )

				aDadosBanco := {	"341-7" 				,; // [1] Numero do Banco   // SA6->A6_COD
					"Banco Itaú S.A."		,; // [2]Nome do Banco   // SA6->A6_NOME
					Left( SA6->A6_AGENCIA, 04 ) 	,; // [3]Agencia
					Alltrim( SA6->A6_NUMCON  )		,; // [4]Conta Corrente
					AllTrim( SA6->A6_DVCTA )			,; // [5]Digito da conta corrente
					" "						 }
				//AllTrim( SA6->A6_DVCONTA )		,; // [5]Digito da conta corrente

				If Empty( SA1->A1_ENDCOB )

					aDatSacado := {	AllTrim( SA1->A1_NOME )										,;	// [1]Razao Social
						AllTrim( SA1->A1_COD  ) + "-" + SA1->A1_LOJA				,;	// [2]Codigo
						AllTrim( SA1->A1_END  ) + "-" + AllTrim( SA1->A1_BAIRRO )	,;	// [3]Endereco
						AllTrim( SA1->A1_MUN  )										,;	// [4]Cidade
						SA1->A1_EST										,;	// [5]Estado
						SA1->A1_CEP										,;	// [6]CEP
						SA1->A1_CGC										 }  // [7]CGC
				Else

					aDatSacado := {	AllTrim( SA1->A1_NOME   )									 ,;	// [1]Razao Social
						AllTrim( SA1->A1_COD    ) + "-" + SA1->A1_LOJA				 ,;	// [2]Codigo
						AllTrim( SA1->A1_ENDCOB ) + "-" + AllTrim( SA1->A1_BAIRROC ) ,;	// [3]Endereco
						AllTrim( SA1->A1_MUNC	)									 ,;	// [4]Cidade
						SA1->A1_ESTC										 ,;	// [5]Estado
						SA1->A1_CEPC										 ,;	// [6]CEP
						SA1->A1_CGC										  }	// [7]CGC
				EndIf

				_nVlrAbat 	:= SomaAbat( SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, "R", 01,, SE1->E1_CLIENTE, SE1->E1_LOJA )
				//CB_RN_NN  := Rt_cBarra03(Subs(aDadosBanco[1],1,3)+"9",aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],AllTrim(SE1->E1_NUM),(Round((SE1->E1_SALDO+SE1->E1_ACRESC-_nVlrAbat-SE1->E1_DECRESC),2)),SE1->E1_VENCTO)
				CB_RN_NN  	:= FRetCodBarras( SubStr( aDadosBanco[01], 01, 03 ) + "9", aDadosBanco[03], aDadosBanco[04], aDadosBanco[05], AllTrim( SE1->E1_NUM ),( Round( ( SE1->E1_SALDO + SE1->E1_ACRESC - _nVlrAbat - SE1->E1_DECRESC ), 02 ) ), SE1->E1_VENCTO )
				aDadosTit 	:= {   AllTrim( SE1->E1_NUM ) + AllTrim( SE1->E1_PARCELA ) 								,; // [1] Numero do Titulo
					SE1->E1_EMISSAO															,; // [2] Data da Emissao do Titulo
					Date()																	,; // [3] Data da Emissao do Boleto
					SE1->E1_VENCTO															,; // [4] Data do Vencimento
					( Round( ( SE1->E1_SALDO + SE1->E1_ACRESC - _nVlrAbat - SE1->E1_DECRESC ), 02 ) )  ,; // [5] Valor do Titulo
					CB_RN_NN[03]															,; // [6] Nosso Numero (Ver Formula para Calculo)
					SE1->E1_PREFIXO															,; // [7] Prefixo da NF
					SE1->E1_TIPO															,; // [8] Tipo do Titulo
					SE1->E1_XNOTA															 } // [9] Nota Fiscal


				cPathPDF  := AllTrim( GetNewPar( "MV_XPTHBOL", "C:\BoletoPDF" ) )
				cPathMail := AllTrim( GetNewPar( "MV_XPTHMAI", "\MailBol"     ) )
				FwMakeDir( cPathPDF	, .T. )
				FwMakeDir( cPathMail, .T. )
				cNomeArq := "boletoI-" + SA1->A1_COD + "-" + SA1->A1_LOJA + "-" + FwTimeStamp( 01 ) + ".pdf"
				//cNomeArq := "boletoItau.pdf"

				// By RGR - aqui
				//If cParamFiles == Nil
				If !lParamEnvMail //MV_PAR19 == 1
					oPrint := FwMSPrinter():New( cNomeArq,, .T., cPathPDF, .T. )
				Else
					oPrint := FwMSPrinter():New( cNomeArq,, .T., cPathMail, .T. )
				EndIf

				If lParamEnvMail //MV_PAR19 == 1
					oPrint:lServer := .T.
					oPrint:SetViewPDF( .F. )
				Else
					oPrint:lServer := .F.
					oPrint:SetViewPDF( .T. )
				EndIf
				oPrint:nDevice := IMP_PDF

				If !lParamEnvMail //MV_PAR19 == 1
					oPrint:cPrinter := "PDF"
					oPrint:cPathPDF := AllTrim( cPathPDF ) + "\"
				Else
					oPrint:cPrinter := "PDF"
					oPrint:cPathPDF := AllTrim( cPathMail ) + "\"
				EndIf
				oPrint:SetPortrait()
				oPrint:SetPaperSize( DMPAPER_A4 )

				DbSelectArea( "SZ4" )
				SZ4->( DbSetOrder( 01 )  )
				SZ4->( DbGoTop() )
				If !SZ4->( Eof() )
					lMostraBoleto := SZ4->Z4_SHOWBOL == "S"
					lMostraSetUp  := SZ4->Z4_SHOWSET == "S"
				Else
					lMostraBoleto := .T.
					lMostraSetUp  := .T.
				EndIf

				FImpBoleto( oPrint, aBMP, aDadosEmp, aDadosTit, aDadosBanco, aDatSacado, aBolText, CB_RN_NN, SE1->E1_PEDIDO, SE1->E1_NUMBCO, SE1->E1_NUM )
				If !lParamEnvMail .And. lParamSetup
					If lMostraSetUp
						oPrint:Setup()
					EndIf
				EndIf

				If lMostraBoleto
					oPrint:Preview()     // Visualiza antes de imprimir //Vitor Duarte 01/11/2013
				EndIf
				FreeObj( oPrint )
				oPrint := Nil

				If lParamEnvMail //MV_PAR19 == 1
					cRetFile := Replace( cPathMail + "\" + cNomeArq, "\\", "\" )
				Else
					cRetFile := Replace( cPathPDF + "\" + cNomeArq, "\\", "\" )
				EndIf

				If lParamEnvMail

					aAuxTitulos := {}
					aAdd( aAuxTitulos, { SE1->( RecNo() ), SA1->A1_NOME, cRetFile } )
					If lParamSchedule
						MsgRun( "Enviando E-mail para cliente, aguarde..", "Enviando E-mail para cliente, aguarde..", { || U_UNIEnvBoletos( "341", aAuxTitulos, lParamSchedule ) } )
					Else
						U_UNIEnvBoletos( "341", aAuxTitulos, lParamSchedule )
					EndIf
					Sleep( 1000  )

				EndIf

			Else

				If lParamSchedule
					ConOut( "UNIR001 - Nao encontrou o Cliente - Titulo " + SE1->E1_PREFIXO + "/" + SE1->E1_NUM )
				Else
					Aviso( "Atenção", "Não encontrou o Cliente - Titulo " + SE1->E1_PREFIXO + "/" + SE1->E1_NUM, { "Continuar" } )
				EndIf

			EndIf

		EndIf

	Else

		If lParamSchedule
			ConOut( "UNIR001 - Nao encontrou Conta Bancária - " + SE1->( E1_PORTADO + "/" + E1_AGEDEP + "/" + E1_CONTA )  )
		Else
			Aviso( "Atenção", "Nao encontrou Conta Bancária - " + SE1->( E1_PORTADO + "/" + E1_AGEDEP + "/" + E1_CONTA ), { "Continuar" } )
		EndIf

	EndIf

Return cRetFile

*------------------------------------------------------------------------------------------------------------------------------------------------------*
Static Function FImpBoleto( oPrint, aBitmap, aDadosEmp, aDadosTit, aDadosBanco, aDatSacado, aBolText, CB_RN_NN, cParamPedido, cParamNossoNum, cParamNF )
	*------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local oFont8
	Local oFont10
	Local oFont16
	Local oFont16n
	Local oFont14n
	Local oFont24
	Local i        := 0
	Local _nLin    := 200
	Local aCoords1 := { 0150, 1900, 0550, 2300 }
	Local aCoords2 := { 0450, 1050, 0550, 1900 }
	Local aCoords3 := { _nLin + 0710, 1900, _nLin + 0810, 2300 }
	Local aCoords4 := { _nLin + 0980, 1900, _nLin + 1050, 2300 }
	Local aCoords5 := { _nLin + 1330, 1900, _nLin + 1400, 2300 }
	Local aCoords6 := { _nLin + 2000, 1900, _nLin + 2100, 2300 }
	Local aCoords7 := { _nLin + 2270, 1900, _nLin + 2340, 2300 }
	Local aCoords8 := { _nLin + 2620, 1900, _nLin + 2690, 2300 }
	Local oBrush
	Local cDtVencx := DToC( aDadosTit[04] )//(SUBSTR(aDadosTit[4],7,2)+"/"+SUBSTR(aDadosTit[4],5,2)+"/"+SUBSTR(aDadosTit[4],1,4))
	Local cDtEmisx := DToC( aDadosTit[02] )//(SUBSTR(aDadosTit[2],7,2)+"/"+SUBSTR(aDadosTit[2],5,2)+"/"+SUBSTR(aDadosTit[2],1,4))
	Local cImpNNum := ( SubStr( aDadosTit[06], 01, 03 ) + "/" + SubStr( aDadosTit[06], 04 ) )
	Local cCarteix :=   SubStr( aDadosTit[06], 01, 03 )

	oFont8  := TFont():New( "Arial", 09, 09,.T.,.F.,5,.T.,5,.T.,.F. )
	oFont10 := TFont():New( "Arial", 09, 10,.T.,.T.,5,.T.,5,.T.,.F. )
	oFont11 := TFont():New( "Arial", 09, 11,.T.,.T.,5,.T.,5,.T.,.F. )
	oFont16 := TFont():New( "Arial", 09, 12,.T.,.T.,5,.T.,5,.T.,.F. )
	oFont16n:= TFont():New( "Arial", 09, 17,.T.,.F.,5,.T.,5,.T.,.F. )
	oFont14n:= TFont():New( "Arial", 09, 15,.T.,.F.,5,.T.,5,.T.,.F. )
	//oFont24 := TFont():New( "Arial", 09, 21,.T.,.T.,5,.T.,5,.T.,.F. )
	oFont24 := TFont():New( "Arial", 09, 24,.T.,.T.,5,.T.,5,.T.,.F. )
	oBrush  := TBrush():New("",4)

	oPrint:StartPage()	// Inicia uma nova Pagina

	// Imprime Recibo do Sacado
	oPrint:Line(_nLin + (-0090),0100,_nLin + (-0090),2300)
	oPrint:Line(_nLin + (-0090),0560,_nLin + (-0190),0560)
	oPrint:Line(_nLin + (-0090),0800,_nLin + (-0190),0800)
	/*
oPrint:SayBitmap(_nLin + (-0185),0450,"lgritau.jpg",085,085)
oPrint:Say (_nLin + (-0144),0100,aDadosBanco[2],oFont16)	    // [2]Nome do Banco
	*/
	//oPrint:SayBitmap(_nLin + (-0185),0100,"lgritau.jpg", 275, 085 )
	oPrint:SayBitmap(_nLin + (-0185),0100,"lgritau.jpg", 295+100, 085 )
	//oPrint:Say (_nLin + (-0120),0215, aDadosBanco[2],oFont16)	    // [2]Nome do Banco

	oPrint:Say (_nLin + (-0110),0567+30,aDadosBanco[1],oFont24)	    // [1]Numero do Banco
	oPrint:Say (_nLin + (-0144),1900,"Recibo do Sacado",oFont16)
	_nLin -= 20
	oPrint:Line(_nLin + 0010,0100,_nLin + 0010,2300)
	oPrint:Line(_nLin + 0110,0100,_nLin + 0110,2300)
	oPrint:Line(_nLin + 0180,0100,_nLin + 0180,2300)
	oPrint:Line(_nLin + 0250,0100,_nLin + 0250,2300)
	oPrint:Line(_nLin + 0110,0500,_nLin + 0250,0500)
	oPrint:Line(_nLin + 0180,0750,_nLin + 0250,0750)
	oPrint:Line(_nLin + 0110,1000,_nLin + 0250,1000)
	oPrint:Line(_nLin + 0110,1350,_nLin + 0180,1350)
	oPrint:Line(_nLin + 0110,1550,_nLin + 0250,1550)
	_nLin += 30
	oPrint:Say (_nLin + (-0080),0100,"Local de Pagamento",oFont8)
	//oPrint:Say (_nLin + (-0050),0100,"QUALQUER BANCO ATÉ A DATA DO VENCIMENTO",oFont10)
	oPrint:Say (_nLin + (-0050),0100,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO ITAÚ. APÓS O VENCIMENTO, SOMENTE NO ITAÚ",oFont10)
	oPrint:Say (_nLin + (-0080),1910,"Vencimento",oFont8)
	oPrint:Say (_nLin + (-0050),1950,cDtVencx,oFont10)
	oPrint:Say (_nLin + 0010,0100,"Cedente",oFont8)
	oPrint:Say (_nLin + 0050,0100,aDadosEmp[1]+"                   "+aDadosEmp[6],oFont10) //Nome + CNPJ
	oPrint:Say (_nLin + 0010,1910,"Agência/Código Cedente",oFont8)
	oPrint:Say (_nLin + 0050,1950,aDadosBanco[03]+"/"+aDadosBanco[04]+"-"+aDadosBanco[05],oFont10)
	oPrint:Say (_nLin + 0110,0100,"Data do Documento",oFont8)
	oPrint:Say (_nLin + 0140,0100,cDtEmisx,oFont10) // Emissao do Titulo (E1_EMISSAO)
	oPrint:Say (_nLin + 0110,0505,"Nro.Documento",oFont8)
	oPrint:Say (_nLin + 0140,0605,aDadosTit[7]+aDadosTit[1],oFont10) //Prefixo +Numero+Parcela
	oPrint:Say (_nLin + 0110,1005,"Espécie Doc.",oFont8)
	oPrint:Say (_nLin + 0140,1050,aDadosTit[8],oFont10) //Tipo do Titulo
	oPrint:Say (_nLin + 0110,1355,"Aceite",oFont8)
	oPrint:Say (_nLin + 0140,1455,"N",oFont10)
	oPrint:Say (_nLin + 0110,1555,"Data do Processamento",oFont8)
	oPrint:Say (_nLin + 0140,1655,DTOC(aDadosTit[3]),oFont10) // Data impressao
	oPrint:Say (_nLin + 0110,1910,"Nosso Número",oFont8)
	oPrint:Say (_nLin + 0140,1950,cImpNNum,oFont10)
	oPrint:Say (_nLin + 0180,0100,"Uso do Banco",oFont8)
	oPrint:Say (_nLin + 0180,0505,"Carteira",oFont8)
	oPrint:Say (_nLin + 0210,0555,cCarteix,oFont10)
	oPrint:Say (_nLin + 0180,0755,"Espécie",oFont8)
	oPrint:Say (_nLin + 0210,0805,"R$",oFont10)
	oPrint:Say (_nLin + 0180,1005,"Quantidade",oFont8)
	oPrint:Say (_nLin + 0180,1555,"Valor",oFont8)
	oPrint:Say (_nLin + 0180,1910,"Valor do Documento",oFont8)
	oPrint:Say (_nLin + 0210,1950,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	oPrint:Say (_nLin + 0250,0100,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8)
	/*
oPrint:Say (_nLin + 0350,0100,aBolText[1],oFont10)
oPrint:Say (_nLin + 0400,0100,aBolText[2],oFont10)
oPrint:Say (_nLin + 0450,0100,aBolText[3],oFont10)
oPrint:Say (_nLin + 0500,0100,aBolText[4],oFont10)
oPrint:Say (_nLin + 0550,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ),oFont10)
	*/
	oPrint:Say (_nLin + 0300,0100,aBolText[1],oFont10)
	oPrint:Say (_nLin + 0340,0100,aBolText[2],oFont10)
	oPrint:Say (_nLin + 0380,0100,aBolText[3],oFont10)
	oPrint:Say (_nLin + 0420,0100,aBolText[4],oFont10)
	oPrint:Say (_nLin + 0460,0100,aBolText[5],oFont10)
	//oPrint:Say (_nLin + 0500,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ),oFont10)

	//Alterado por Luiz Otávio Campos em 18/03/21 * Adicionar o numero da Nota Fiscal corretamente
	cParamNF  := Iif(!Empty(aDadosTit[9]),aDadosTit[9],cParamNF)
	oPrint:Say (_nLin + 0500,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ),oFont10)




	oPrint:Say (_nLin + 0250,1910,"(-)Desconto/Abatimento",oFont8)

	oPrint:Say (_nLin + 0330,1910,"(-)Outras Deduções",oFont8)
	oPrint:Say (_nLin + 0400,1910,"(+)Mora/Multa",oFont8)
	oPrint:Say (_nLin + 0470,1910,"(+)Outros Acréscimos",oFont8)
	oPrint:Say (_nLin + 0540,1910,"(=)Valor Cobrado",oFont8)
	_nLin += 15
	oPrint:Say (_nLin + 0600,0100,"Pagador",oFont8)
	oPrint:Say (_nLin + 0600,0200,aDatSacado[1]+" ("+aDatSacado[2]+")",oFont10)
	//oPrint:Say (_nLin + 0633,0200,aDatSacado[3],oFont10)
	oPrint:Say (_nLin + 0630,0200,aDatSacado[3],oFont10)
	oPrint:Say (_nLin + 0660+5,0200,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
	oPrint:Say (_nLin + 0600,1750, Iif( AllTrim( aDatSacado[07] ) != "",Iif( Len( AllTrim( aDatSacado[07] ) ) == 14, "C.N.P.J.: " + Transform( aDatSacado[07], "@R 99.999.999/9999-99" ), "C.P.F.: " + Transform( aDatSacado[07], "@R 999.999.999-99" ) ), "" ), oFont10 )
	oPrint:Say (_nLin + 0660+5,1950,SUBSTR(aDadosTit[6],1,3)+"/00"+SUBSTR(aDadosTit[6],4,8),oFont10)
	oPrint:Say (_nLin + 0700,0100,"Sacador/Avalista",oFont8)
	oPrint:Say (_nLin + 0740,1500,"Autenticação Mecânica -",oFont8)
	_nLin -= 27
	oPrint:Line(_nLin + (-0090),1900,_nLin + 0600,1900) // Coluna
	oPrint:Line(_nLin + 0320,1900,_nLin + 0320,2300)  	// linha outras deduções
	oPrint:Line(_nLin + 0390,1900,_nLin + 0390,2300)  	// linha mora
	oPrint:Line(_nLin + 0460,1900,_nLin + 0460,2300)	// linha outros ac
	oPrint:Line(_nLin + 0530,1900,_nLin + 0530,2300)	// linha valor cobrado
	oPrint:Line(_nLin + 0600,0100,_nLin + 0600,2300)	// linha sacado
	oPrint:Line(_nLin + 0740,0100,_nLin + 0740,2300)	// linha autentica

	For nI := 100 TO 2300 Step 50
		oPrint:Line( _nLin + 0810, nI, _nLin + 0810, nI + 30 )
	Next nI

	// Imprime Ficha do Caixa
	_nLin -= 100
	oPrint:Line(_nLin + 1010,0100,_nLin + 1010,2300)
	oPrint:Line(_nLin + 1010,0560,_nLin + 0910,0560)
	oPrint:Line(_nLin + 1010,0800,_nLin + 0910,0800)
	/*
oPrint:SayBitmap(_nLin + 0915,0450,"lgritau.jpg",085,085)
oPrint:Say (_nLin + 0944,0100,aDadosBanco[02],oFont16)	// [2]Nome do Banco
	*/
	//oPrint:SayBitmap(_nLin + 0915,0100,"lgritau.jpg",275, 085)
	oPrint:SayBitmap(_nLin + 0915,0100,"lgritau.jpg",295+100, 085)
	//oPrint:Say (_nLin + 0960,0215, aDadosBanco[2],oFont16)	    // [2]Nome do Banco

	//oPrint:Say (_nLin + 0975,0567,aDadosBanco[01],oFont24)	// [1]Numero do Banco
	//oPrint:Say (_nLin + 0980,0567,aDadosBanco[01],oFont24)	// [1]Numero do Banco
	oPrint:Say (_nLin + 0980,0567+30,aDadosBanco[01],oFont24)	// [1]Numero do Banco
	oPrint:Say (_nLin + 0944,1900,"Ficha de Caixa",oFont16)
	_nLin -= 20
	oPrint:Line(_nLin + 1110,0100,_nLin + 1110,2300)
	oPrint:Line(_nLin + 1210,0100,_nLin + 1210,2300)
	oPrint:Line(_nLin + 1280,0100,_nLin + 1280,2300)
	oPrint:Line(_nLin + 1350,0100,_nLin + 1350,2300)
	oPrint:Line(_nLin + 1210,0500,_nLin + 1350,0500)
	oPrint:Line(_nLin + 1280,0750,_nLin + 1350,0750)
	oPrint:Line(_nLin + 1210,1000,_nLin + 1350,1000)
	oPrint:Line(_nLin + 1210,1350,_nLin + 1280,1350)
	oPrint:Line(_nLin + 1210,1550,_nLin + 1350,1550)
	_nLin += 50
	oPrint:Say (_nLin + 1010,0100,"Local de Pagamento",oFont8)
	//oPrint:Say (_nLin + 1050,0100,"QUALQUER BANCO ATÉ A DATA DO VENCIMENTO",oFont10)
	oPrint:Say (_nLin + 1050,0100,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO ITAÚ. APÓS O VENCIMENTO, SOMENTE NO ITAÚ",oFont10)
	oPrint:Say (_nLin + 1010,1910,"Vencimento",oFont8)
	oPrint:Say (_nLin + 1050,1950,cDtVencx,oFont10)
	_nLin -= 30
	oPrint:Say (_nLin + 1110,0100,"Cedente",oFont8)
	oPrint:Say (_nLin + 1150,0100,aDadosEmp[1]+"                   "+aDadosEmp[6],oFont10) //Nome + CNPJ
	oPrint:Say (_nLin + 1110,1910,"Agência/Código Cedente",oFont8)
	oPrint:Say (_nLin + 1150,1950,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
	oPrint:Say (_nLin + 1210,0100,"Data do Documento",oFont8)
	oPrint:Say (_nLin + 1240,0100,cDtEmisx,oFont10) // Emissao do Titulo (E1_EMISSAO)
	oPrint:Say (_nLin + 1210,0505,"Nro.Documento",oFont8)
	oPrint:Say (_nLin + 1240,0605,aDadosTit[7]+aDadosTit[1],oFont10) //Prefixo +Numero+Parcela
	oPrint:Say (_nLin + 1210,1005,"Espécie Doc.",oFont8)
	oPrint:Say (_nLin + 1240,1050,aDadosTit[8],oFont10) //Tipo do Titulo
	oPrint:Say (_nLin + 1210,1355,"Aceite",oFont8)
	oPrint:Say (_nLin + 1240,1455,"N",oFont10)
	oPrint:Say (_nLin + 1210,1555,"Data do Processamento",oFont8)
	oPrint:Say (_nLin + 1240,1655,DTOC(aDadosTit[3]),oFont10) // Data impressao
	oPrint:Say (_nLin + 1210,1910,"Nosso Número",oFont8)
	oPrint:Say (_nLin + 1240,1950,cImpNNum,oFont10)
	oPrint:Say (_nLin + 1280,0100,"Uso do Banco",oFont8)
	oPrint:Say (_nLin + 1280,0505,"Carteira",oFont8)
	oPrint:Say (_nLin + 1310,0555,cCarteix,oFont10)
	oPrint:Say (_nLin + 1280,0755,"Espécie",oFont8)
	oPrint:Say (_nLin + 1310,0805,"R$",oFont10)
	oPrint:Say (_nLin + 1280,1005,"Quantidade",oFont8)
	oPrint:Say (_nLin + 1280,1555,"Valor",oFont8)
	oPrint:Say (_nLin + 1280,1910,"Valor do Documento",oFont8)
	oPrint:Say (_nLin + 1310,1950,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	oPrint:Say (_nLin + 1350,0100,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8)
	/*
oPrint:Say (_nLin + 1450,0100,aBolText[1],oFont10)
oPrint:Say (_nLin + 1500,0100,aBolText[2],oFont10)
oPrint:Say (_nLin + 1550,0100,aBolText[3],oFont10)
oPrint:Say (_nLin + 1600,0100,aBolText[4],oFont10)
oPrint:Say (_nLin + 1650,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ), oFont10 )
	*/
	oPrint:Say (_nLin + 1400,0100,aBolText[1],oFont10)
	oPrint:Say (_nLin + 1440,0100,aBolText[2],oFont10)
	oPrint:Say (_nLin + 1480,0100,aBolText[3],oFont10)
	oPrint:Say (_nLin + 1520,0100,aBolText[4],oFont10)
	oPrint:Say (_nLin + 1560,0100,aBolText[5],oFont10)
	oPrint:Say (_nLin + 1600,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ), oFont10 )

	oPrint:Say (_nLin + 1350,1910,"(-)Desconto/Abatimento",oFont8)
	oPrint:Say (_nLin + 1445,1910,"(-)Outras Deduções",oFont8)
	oPrint:Say (_nLin + 1515,1910,"(+)Mora/Multa",oFont8)
	oPrint:Say (_nLin + 1585,1910,"(+)Outros Acréscimos",oFont8)
	oPrint:Say (_nLin + 1655,1910,"(=)Valor Cobrado",oFont8)
	oPrint:Say (_nLin + 1722,0100,"Pagador",oFont8)
	oPrint:Say (_nLin + 1722,0200,aDatSacado[1] + " ("+aDatSacado[2]+")",oFont10)
	oPrint:Say (_nLin + 1745+5,0200,aDatSacado[3],oFont10)
	oPrint:Say (_nLin + 1770+5,0200,aDatSacado[6] + "    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
	oPrint:Say (_nLin + 1722,1750,Iif( AllTrim( aDatSacado[07] ) != "",Iif( Len( AllTrim( aDatSacado[07] ) ) == 14, "C.N.P.J.: " + Transform( aDatSacado[07], "@R 99.999.999/9999-99" ), "C.P.F.: " + Transform( aDatSacado[07], "@R 999.999.999-99" ) ), "" ), oFont10 )
	oPrint:Say (_nLin + 1800,1950,SUBSTR(aDadosTit[6],1,3)+"/00"+SUBSTR(aDadosTit[6],4,8),oFont10)
	oPrint:Say (_nLin + 1800,0100,"Sacador/Avalista",oFont8)
	oPrint:Say (_nLin + 1840,1500,"Autenticação Mecânica -",oFont8)
	oPrint:Line(_nLin + 1010,1900,_nLin + 1700,1900)//coluna
	oPrint:Line(_nLin + 1420,1900,_nLin + 1420,2300)//linha outras ded
	oPrint:Line(_nLin + 1490,1900,_nLin + 1490,2300) //linha mora
	oPrint:Line(_nLin + 1560,1900,_nLin + 1560,2300) //linha outros acre
	oPrint:Line(_nLin + 1630,1900,_nLin + 1630,2300) //linha valor cob
	oPrint:Line(_nLin + 1700,0100,_nLin + 1700,2300) //sacado
	oPrint:Line(_nLin + 1815,0100,_nLin + 1815,2300) //autentica

	For nI := 100 To 2300 Step 50
		oPrint:Line( _nLin + 1860, nI,_nLin + 1860, nI + 30 )
	Next nI

	_nLin -= 135
	oPrint:Line(_nLin + 2100,0100,_nLin + 2100,2300)
	oPrint:Line(_nLin + 2100,0560,_nLin + 2000,0560)
	oPrint:Line(_nLin + 2100,0800,_nLin + 2000,0800)
	/*
oPrint:SayBitmap(_nLin + 2000,0450,"lgritau.jpg",085,085)
oPrint:Say (_nLin + 2054,0100,aDadosBanco[2],oFont16)	// [2] Nome do Banco
	*/
	oPrint:SayBitmap(_nLin + 2000,0100,"lgritau.jpg", 295+100, 085 )
	//oPrint:Say (_nLin + 2060,0215, aDadosBanco[2],oFont16)	    // [2]Nome do Banco

	_nLin += 20
	//oPrint:Say (_nLin + 2034,0567,aDadosBanco[1],oFont24)	// [1] Numero do Banco
	oPrint:Say (_nLin + 2040,0567+30,aDadosBanco[1],oFont24)	// [1] Numero do Banco
	oPrint:Say (_nLin + 2040,0820,CB_RN_NN[2],oFont14n)		// [2] Linha Digitavel do Codigo de Barras
	//_nLin -= 6
	_nLin -= 50
	oPrint:Line(_nLin + 2200,0100,_nLin + 2200,2300)
	_nLin -= 37
	oPrint:Line(_nLin + 2300,0100,_nLin + 2300,2300)
	oPrint:Line(_nLin + 2370,0100,_nLin + 2370,2300)
	oPrint:Line(_nLin + 2440,0100,_nLin + 2440,2300)

	oPrint:Line(_nLin + 2300,0500,_nLin + 2440,0500)
	oPrint:Line(_nLin + 2370,0750,_nLin + 2440,0750)
	oPrint:Line(_nLin + 2300,1000,_nLin + 2440,1000)
	oPrint:Line(_nLin + 2300,1350,_nLin + 2370,1350)
	oPrint:Line(_nLin + 2300,1550,_nLin + 2440,1550)
	_nLin += 75
	oPrint:Say (_nLin + 2110,0100,"Local de Pagamento",oFont8)
	//oPrint:Say (_nLin + 2140,0100,"QUALQUER BANCO ATÉ A DATA DO VENCIMENTO",oFont10)
	oPrint:Say (_nLin + 2140,0100,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO ITAÚ. APÓS O VENCIMENTO, SOMENTE NO ITAÚ",oFont10)
	oPrint:Say (_nLin + 2110,1910,"Vencimento",oFont8)
	oPrint:Say (_nLin + 2140,1950,cDtVencx,oFont10)
	_nLin -= 20
	oPrint:Say (_nLin + 2200,0100,"Cedente",oFont8)
	oPrint:Say (_nLin + 2230,0100,aDadosEmp[1]+"                   "+aDadosEmp[6],oFont10) //Nome + CNPJ
	oPrint:Say (_nLin + 2200,1910,"Agência/Código Cedente",oFont8)
	oPrint:Say (_nLin + 2230,1950,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
	_nLin -= 30
	oPrint:Say (_nLin + 2300,0100,"Data do Documento",oFont8)
	oPrint:Say (_nLin + 2330,0100,cDtEmisx,oFont10)			// Emissao do Titulo (E1_EMISSAO)
	oPrint:Say (_nLin + 2300,0505,"Nro.Documento",oFont8)
	oPrint:Say (_nLin + 2330,0605,aDadosTit[7]+aDadosTit[1],oFont10)	//Prefixo + Numero + Parcela
	oPrint:Say (_nLin + 2300,1005,"Espécie Doc.",oFont8)
	oPrint:Say (_nLin + 2330,1050,aDadosTit[8],oFont10)					//Tipo do Titulo
	oPrint:Say (_nLin + 2300,1355,"Aceite",oFont8)
	oPrint:Say (_nLin + 2330,1455,"N",oFont10)
	oPrint:Say (_nLin + 2300,1555,"Data do Processamento",oFont8)
	oPrint:Say (_nLin + 2330,1655,DTOC(aDadosTit[3]),oFont10) // Data impressao
	oPrint:Say (_nLin + 2300,1910,"Nosso Número",oFont8)
	oPrint:Say (_nLin + 2330,1950,cImpNNum,oFont10)
	oPrint:Say (_nLin + 2370,0100,"Uso do Banco",oFont8)
	oPrint:Say (_nLin + 2370,0505,"Carteira",oFont8)
	oPrint:Say (_nLin + 2400,0555,cCarteix,oFont10)
	oPrint:Say (_nLin + 2370,0755,"Espécie",oFont8)
	oPrint:Say (_nLin + 2400,0805,"R$",oFont10)
	oPrint:Say (_nLin + 2370,1005,"Quantidade",oFont8)
	oPrint:Say (_nLin + 2370,1555,"Valor",oFont8)
	oPrint:Say (_nLin + 2370,1910,"Valor do Documento",oFont8)
	oPrint:Say (_nLin + 2400,1950,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	oPrint:Say (_nLin + 2440,0100,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8)
	/*
oPrint:Say (_nLin + 2540,0100,aBolText[01], oFont10 )
oPrint:Say (_nLin + 2590,0100,aBolText[02], oFont10 )
oPrint:Say (_nLin + 2640,0100,aBolText[03], oFont10 )
oPrint:Say (_nLin + 2690,0100,aBolText[04], oFont10 )
oPrint:Say (_nLin + 2740,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ),oFont10)
	*/
	oPrint:Say (_nLin + 2490,0100,aBolText[01], oFont10 )
	oPrint:Say (_nLin + 2530,0100,aBolText[02], oFont10 )
	oPrint:Say (_nLin + 2570,0100,aBolText[03], oFont10 )
	oPrint:Say (_nLin + 2610,0100,aBolText[04], oFont10 )
	oPrint:Say (_nLin + 2650,0100,aBolText[05], oFont10 )
	oPrint:Say (_nLin + 2690,0100,"PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ),oFont10)


	oPrint:Say (_nLin + 2440,1910,"(-)Desconto/Abatimento",oFont8)
	oPrint:Say (_nLin + 2510,1910,"(-)Outras Deduções",oFont8)
	oPrint:Say (_nLin + 2580,1910,"(+)Mora/Multa",oFont8)
	oPrint:Say (_nLin + 2650,1910,"(+)Outros Acréscimos",oFont8)
	oPrint:Say (_nLin + 2720,1910,"(=)Valor Cobrado",oFont8)
	oPrint:Say (_nLin + 2790,0100,"Pagador",oFont8)
	oPrint:Say (_nLin + 2790,0200,aDatSacado[1]+" ("+aDatSacado[2]+")",oFont10)
	oPrint:Say (_nLin + 2813+8,0200,aDatSacado[3],oFont10)
	oPrint:Say (_nLin + 2846+5,0200,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10)	// CEP+Cidade+Estado
	oPrint:Say (_nLin + 2790,1700,Iif( AllTrim( aDatSacado[07] ) != "",Iif( Len( AllTrim( aDatSacado[07] ) ) == 14, "C.N.P.J.: " + Transform( aDatSacado[07], "@R 99.999.999/9999-99" ), "C.P.F.: " + Transform( aDatSacado[07], "@R 999.999.999-99" ) ), "" ), oFont10 )
	oPrint:Say (_nLin + 2856,1950,SUBSTR(aDadosTit[6],1,3)+"/00"+SUBSTR(aDadosTit[6],4,8),oFont10)
	oPrint:Say (_nLin + 2885,0100,"Sacador/Avalista",oFont8)
	oPrint:Say (_nLin + 2910,1500,"Autenticação Mecânica -",oFont8)
	oPrint:Say (_nLin + 2910,1850,"Ficha de Compensação",oFont10)
	_nLin -= 30
	oPrint:Line(_nLin + 2171,1900,_nLin + 2790,1900) //Coluna
	oPrint:Line(_nLin + 2510,1900,_nLin + 2510,2300) //linha outra ded
	oPrint:Line(_nLin + 2580,1900,_nLin + 2580,2300) //linha mora
	oPrint:Line(_nLin + 2650,1900,_nLin + 2650,2300) //linha outro ac
	oPrint:Line(_nLin + 2720,1900,_nLin + 2720,2300) //linha valor cob
	oPrint:Line(_nLin + 2790,0100,_nLin + 2790,2300) //linha sacado
	oPrint:Line(_nLin + 2920,0100,_nLin + 2920,2300) //autentica

	//Chama Função para Gravar Código de barras e linha digitável no registro da SE1
	FGrvCodBar( CB_RN_NN )

	// Imprime Código de Barras
	//MSBAR("INT25",27.6,1.6,CB_RN_NN[1],oPrint,.F.,,.T.,0.028,1.3,,,"A",.F.)
	//oPrint:FWMSBAR("INT25",27.6,1.6,CB_RN_NN[1],oPrint,.F.,,.T.,0.028,1.3,,,"A",.F.)
	oPrint:FWMSBAR( "INT25", 66.4, 1.6, CB_RN_NN[01], oPrint, .F.,, .T., 0.028, 1.3,,, "A", .F. )
	oPrint:EndPage() // Finaliza a Pagina

Return Nil

*--------------------------------*
Static Function FRetMod10( cData )
	*--------------------------------*
	Local L, D, P := 0
	Local B       := .F.

	L := Len( cData )
	B := .T.
	D := 0

	Do While L > 0

		P := Val( SubStr( cData, L, 01 ) )
		If ( B )
			P := P * 02
			If P > 9
				P := P - 09
			EndIf
		EndIf
		D := D + P
		L := L - 1
		B := !B

	EndDo

	D := 10 - ( Mod( D, 10 ) )
	If D == 10
		D := 0
	EndIf

Return( D )

*--------------------------------*
Static Function FRetMod11( cData )
	*--------------------------------*
	Local L, D, P 	:= 0
	L 				:= Len( cData )

	D := 0
	P := 1
	Do While L > 0

		P := P + 01
		D := D + ( Val( SubStr( cData, L, 01 ) ) * P )
		If P == 9
			P := 01
		EndIf
		L := L - 01

	EndDo

	D := 11 - ( Mod( D, 11 ) )

	If (D == 00 .Or. D == 01 .Or. D == 10 .Or. D == 11 )
		D := 01
	EndIf

Return( D )

*---------------------------------------------------------------------------------------*
Static Function FRetCodBarras( cBanco, cAgencia, cConta, cDacCC, cNroDoc, nValor, dVencto )
	*---------------------------------------------------------------------------------------*
	Local blDocNuFinal := StrZero( Val( cNroDoc ), 08 )
	Local blValorFinal := StrZero( Int( nValor * 100 ), 10 )
	Local dvnn         := 0
	Local dvcb         := 0
	Local dv           := 0
	Local NN           := ""
	Local RN           := ""
	Local CB           := ""
	Local s            := ""
	Local _cFator      := StrZero( dVencto - CToD( "07/10/97" ), 04 )
	Local _cCart	   := "109"
	Local cConta       := Right( cConta, 05 )
	Local _cNossoNum   := ""
	Local cNnMod10     := ""

	// Definição do Nosso Número
	//_cNossoNum :=  Alltrim((cAliasQry)->E1_NUMBCO)
	_cNossoNum := Alltrim( SE1->E1_NUMBCO )
	If Empty( _cNossoNum )

		DbSelectArea( "SEE" )
		_cNossoNum := StrZero( ( Val( Alltrim( SEE->EE_FAXATU ) ) + 01 ), 08 )
		RecLock( "SEE", .F. )
		SEE->EE_FAXATU := _cNossoNum
		SEE->( MsUnLock() )

		/*
  DbSelectArea( "SE1" )
  RecLock( "SE1", .F. )
  	SE1->E1_NUMBCO  := _cNossoNum
  	SE1->E1_PORTADO := "341"
  SE1->( MsUnlock() )
		*/
	Else
		_cNossoNum :=  Alltrim( SE1->E1_NUMBCO )
		/*
  DbSelectArea( "SE1" )
  RecLock( "SE1", .F. )
	SE1->E1_PORTADO := "341"
  SE1->( MsUnlock() )
		*/
	EndIf

	//Calcula o DAC para o Nosso Número
	s        	:= ( Alltrim( cAgencia ) + Alltrim( cConta ) + Alltrim( _cCart ) + Alltrim( SubStr( _cNossoNum, 01, 08 ) ) )
	cNnMod10 	:= FRetDACNossoNumero( s )
	cNnMod10 	:= Alltrim( cNnMod10 )
	NN   		:= _cCart + SubStr( _cNossoNum, 01, 08 ) + "-" + cNnMod10

	DbSelectArea( "SE1" )
	RecLock( "SE1", .F. )
	SE1->E1_NUMBCO  := _cNossoNum + cNnMod10
	SE1->E1_PORTADO := "341"
	SE1->E1_AGEDEP  := cAgencia
	SE1->E1_CONTA   := cConta
	SE1->( MsUnlock() )

	// Definição do Código de Barras
	s    := cBanco + _cfator + blValorFinal + _cCart + SubStr( _cNossoNum, 01, 08 ) + cNnMod10 + cAgencia + cConta + cDacCC + "000"
	dvCB := FRetMod11( s )
	CB   := SubStr( s, 01, 04 ) + AllTrim( Str( dvCB ) ) + SubStr( s, 05 )

	// Definição da Linha Digitavel (Repreentação Numérica)
	//	CAMPO 1:
	//	AAA = Codigo do banco na Camara de Compensacao
	//	  B = Codigo da moeda, sempre 9
	//	CCC = Codigo da Carteira de Cobranca
	//	 DD = Dois primeiros digitos no nosso numero
	//	  X = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
	s    := cBanco + _cCart + SubStr(_cNossoNum,1,2)
	dv   := FRetMod10(s)
	RN   := SubStr(s, 1, 5) + '.' + SubStr(s, 6, 4) + AllTrim(Str(dv)) + '  '


	//	CAMPO 2:
	//	DDDDDD = Restante do Nosso Numero
	// E      = DAC do campo Agencia/Conta/Carteira/Nosso Numero
	// FFF    = Tres primeiros numeros que identificam a agencia
	// Y      = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
	s    := SubStr( _cNossoNum, 03, 06 ) + cNnMod10 + SubStr( cAgencia, 01, 03 )
	dv   := FRetMod10(s)
	RN   := RN + SubStr( s, 01, 05 ) + "." + SubStr( s, 06, 05 ) + AllTrim( Str( dv ) ) + "  "


	//	CAMPO 3:
	//	     F = Restante do numero que identifica a agencia
	//	GGGGGG = Numero da Conta + DAC da mesma
	//	   HHH = Zeros (Nao utilizado)
	//	     Z = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
	s    := SubStr( cAgencia, 04, 01 ) + cConta + cDacCC + "000"
	dv   := FRetMod10( s )
	RN   := RN + SubStr( s, 01, 05 ) + "." + SubStr( s, 06, 05 ) + AllTrim( Str( dv ) ) + "  "

	//	CAMPO 4:
	//	     K = DAC do Codigo de Barras
	RN   := RN + AllTrim( Str( dvcb ) ) + "  "

	//	CAMPO 5:
	//       UUUU = Fator de Vencimento
	//	VVVVVVVVVV = Valor do Titulo
	RN   := RN + _cfator + StrZero( Int( nValor * 100 ), 14-Len( _cfator ) )

Return( { CB, RN, NN } )


Static Function FRetDACNossoNumero( cDacX )

	Local nLenX    := Len( cDacX )
	Local aCalcDc  := {}
	Local aCalcDc2 := {}
	Local nCalcX   := 0
	Local cCalcX   := ''
	Local lMult1   := .T.
	Local cRetX    := ''

	For nX := 01 To nLenx
		aAdd( aCalcDc, SubStr( cDacX, nX, 01 ) )
	Next nX

	For nY := 01 To Len( aCalcDc )

		If lMult1
			aAdd( aCalcDc2, ( Val( aCalcDc[ny] ) * 01 ) )
			lMult1 := .F.
		Else
			aAdd( aCalcDc2,( Val( aCalcDc[ny]) * 02 ) )
			lMult1 := .T.
		EndIf

	Next nY

	For nY := 01 To Len( aCalcDc2 )

		If( Len( Alltrim( Str( aCalcDc2[nY] ) ) ) > 01 )
			cCalcX := SubStr( Alltrim( Str( aCalcDc2[nY] ) ), 01, 01 )
			nCalcX += Val( cCalcX )
			cCalcX := SubStr( Alltrim( Str( aCalcDc2[nY] ) ), 02, 01 )
			nCalcX += Val( cCalcX )
		Else
			nCalcX += aCalcDc2[nY]
		EndIf

	Next nY

	nCalcX := 10 - ( Mod( nCalcX, 10 ) )
	If nCalcX == 10
		nCalcX := 00
	EndIf
	cRetX := Str( nCalcX )

Return cRetX

*--------------------------------------*
Static Function FGrvCodBar( aCodBarDig )
	*--------------------------------------*
	Local aAreaAgo := GetArea()
	Local aAreaSE1 := SE1->( GetArea() )

	DbSelectArea( "SE1" )
	DbSetOrder( 01 )
	Seek XFilial( "SE1" ) + SE1->( E1_PREFIXO + E1_NUM + E1_PARCELA )
	If Found()

		If Empty( SE1->E1_CODBAR )

			RecLock( "SE1", .F. )
			SE1->E1_CODBAR  := aCodBarDig[01]
			SE1->( MsUnLock() )

		EndIf

		If Empty( SE1->E1_CODDIG )

			RecLock( "SE1", .F. )
			SE1->E1_CODDIG  := aCodBarDig[02]
			SE1->( MsUnLock() )

		EndIf

		RecLock( "SE1", .F. )
		SE1->E1_PORTADO := "341"
		SE1->E1_AGEDEP  := SZ4->Z4_AGENCIA
		SE1->E1_CONTA   := SZ4->Z4_CONTA
		SE1->( MsUnLock() )

	EndIf

Return

/*
*-------------------------*
Static Function GetDBanco()
*-------------------------*
Local cDtBancox  := Alltrim( GetMv( "MV_XITAU" ) )
Local nLenbco    := TamSX3( "A6_COD"	 )[01]
Local nLenAgc    := TamSX3( "A6_AGENCIA" )[01]
Local nLenCtb    := TamSX3( "A6_NUMCON"  )[01]
Local nPosx      := 0
Local nInfox     := 1

If !Empty( cDtBancoX )

	For nX := 01 To Len( cDtBancox ) + 01

		If SubStr( cDtBancox, nX, 01 ) == "," .Or. nX == Len( cDtBancox ) + 01

			Do Case
				Case ( nInfox  == 01 )
					aAdd( aDadosBan, { PadR( SubStr( cDtBancox, 01, nX - 01 ), nLenbco ) } )
					nInfox++
					nPosX := nX + 01

				Case ( nInfox == 02 )
					aAdd( aDadosBan, { PadR( SubStr( cDtBancox, nPosx, nX - nPosX ), nLenAgc ) } )
					nInfox++
					nPosX := nX + 01

				Case ( nInfox == 03 )
					aAdd( aDadosBan, { PadR( SubStr( cDtBancox, nPosX, nX - nPosX ), nLenCtb ) } )
					nInfoX++
					nPosX := nX + 01
			EndCase

		EndIf

	Next nX

EndIf

Return
*/

*--------------------------------------------*
Static Function FCarregaTitulos( cParamNumNF )
	*--------------------------------------------*
	Local aAreaAtu  := GetArea()
	Local cAliasSE1 := GetNextAlias()
	Local cQuery 	:= ""

	cQuery := "	SELECT *, SE1.R_E_C_N_O_ AS [NUMRECSE1] "
	cQuery += "	  FROM " + RetSQLName( "SE1" ) + " SE1 ( NOLOCK), "
	cQuery += "	       " + RetSQLName( "SA1" ) + " SA1 ( NOLOCK)  "
	cQuery += "  WHERE SE1.D_E_L_E_T_ 		 = ' ' "
	cQuery += "    AND SA1.D_E_L_E_T_ 		 = ' ' "
	cQuery += "    AND SE1.E1_FILIAL  		 = '" + XFilial( "SE1" ) + "' "
	cQuery += "    AND SA1.A1_FILIAL  		 = '" + XFilial( "SA1" ) + "' "
	cQuery += "    AND SE1.E1_CLIENTE  		 = SA1.A1_COD				  "
	cQuery += "    AND SE1.E1_LOJA  		 = SA1.A1_LOJA				  "
	cQuery += "	   AND SE1.E1_PREFIXO   	>= '" + MV_PAR01		 + "' "
	cQuery += "	   AND SE1.E1_PREFIXO   	<= '" + MV_PAR02		 + "' "
	cQuery += "	   AND SE1.E1_NUM			>= '" + MV_PAR03		 + "' "
	cQuery += "	   AND SE1.E1_NUM       	<= '" + MV_PAR04		 + "' "
	cQuery += "	   AND SE1.E1_PARCELA   	>= '" + MV_PAR05		 + "' "
	cQuery += "	   AND SE1.E1_PARCELA   	<= '" + MV_PAR06		 + "' "
	cQuery += "	   AND SE1.E1_PORTADO   	>= '" + MV_PAR07		 + "' "
	cQuery += "	   AND SE1.E1_PORTADO   	<= '" + MV_PAR08		 + "' "
	cQuery += "	   AND SE1.E1_CLIENTE   	>= '" + MV_PAR09		 + "' "
	cQuery += "	   AND SE1.E1_CLIENTE   	<= '" + MV_PAR10		 + "' "
	cQuery += "	   AND SE1.E1_LOJA	    	>= '" + MV_PAR11		 + "' "
	cQuery += "	   AND SE1.E1_LOJA      	<= '" + MV_PAR12		 + "' "
	cQuery += "	   AND SE1.E1_NUMBOR 		>= '" + MV_PAR17 		 + "' "
	cQuery += "	   AND SE1.E1_NUMBOR 		<= '" + MV_PAR18 		 + "' "
	cQuery += "	   AND SE1.E1_EMISSAO  	 	>= '" + DToS( MV_PAR13 ) + "' "
	cQuery += "	   AND SE1.E1_EMISSAO   	<= '" + DToS( MV_PAR14 ) + "' "
	cQuery += "	   AND SE1.E1_SALDO		 	> 0 "
	If Empty( cParamNumNF )
		cQuery += "	   AND SE1.E1_VENCREA 	>= '" + DToS( MV_PAR15 ) + "' "
		cQuery += "	   AND SE1.E1_VENCREA   <= '" + DToS( MV_PAR16 ) + "' "
	EndIf

	If MV_PAR20 == 2
		cQuery += "	   AND SE1.E1_NUMBCO     = '' "
	EndIf
	If AllTrim( MV_PAR21 ) != ""
		cQuery += "	   AND SE1.E1_PREFIXO  NOT IN " + FormatIn( Replace( Replace( Replace( Replace( AllTrim( MV_PAR21 ), "-", "," ), ";", "," ), ".", "," ), " ", "," ), "," )
	EndIf

	cQuery += "	   AND SE1.E1_TIPO   NOT IN " + FormatIn( MVABATIM, "," )
	//cFilter		+= " !( E1_TIPO $ MVABATIM ) " //.And. "
	cQuery += "	ORDER BY E1_PORTADO, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_EMISSAO "

	If Select( cAliasSE1 ) > 0
		( cAliasSE1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSE1 ) New

	aListTitulos := {}
	Do While !( cAliasSE1 )->( Eof() )

		aAdd( aListTitulos, { .T.						,; // 01- Marcado
			( cAliasSE1 )->E1_FILIAL 	,; // 02- Filial
			( cAliasSE1 )->E1_PREFIXO	,; // 03- Prefixo
			( cAliasSE1 )->E1_TIPO		,; // 04- Tipo
			( cAliasSE1 )->E1_NUM		,; // 05- Numero
			( cAliasSE1 )->E1_PARCELA	,; // 06- Parcela
			( cAliasSE1 )->E1_VALOR	,; // 07- Valor
			( cAliasSE1 )->E1_SALDO	,; // 08- Saldo
			SToD( ( cAliasSE1 )->E1_VENCTO  ),; // 09- Vencimento
			SToD( ( cAliasSE1 )->E1_VENCREA ),; // 10- Vencto Real
			( cAliasSE1 )->E1_NUMBCO   ,; // 11- Nosso Número
			( cAliasSE1 )->E1_NUMBOR   ,; // 12- Bordero
			( cAliasSE1 )->E1_CLIENTE  ,; // 13- Cliente
			( cAliasSE1 )->E1_LOJA 	,; // 14- Loja
			( cAliasSE1 )->A1_NOME 	,; // 15- Nome
			( cAliasSE1 )->NUMRECSE1	}) // 16- RecNo

		DbSelectArea( cAliasSE1 )
		( cAliasSE1 )->( DbSkip() )
	EndDo
	( cAliasSE1 )->( DbCloseArea() )

	If Len( aListTitulos ) == 0

		aAdd( aListTitulos, { .F.		 ,;
			"" 		 ,;
			""		 ,;
			""		 ,;
			""		 ,;
			""		 ,;
			0 		 ,;
			0 		 ,;
			CToD( ""  ),;
			CToD( ""  ),;
			""         ,;
			""         ,;
			""         ,;
			""         ,;
			""         ,;
			0			 })
	EndIf

	RestArea( aAreaAtu )

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
