*----------------------------------*
/*/{Protheus.doc} UNIR002

@project Impressão de Boletos de Cobrança ( Santander ) para Cliente Única

@description Relatório de Impressão de Boleto Bancário para o Santander
@files  \system\lgrsantander.jpg - Logo para Boleto do Santander

@author Rafael Rezende
@since 02/04/2019
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
User Function UNIR002( cParamPrefixo, cParamDeNumero, cParamAteNumero, lParamSchedule )
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
	Local cPerg         	:= "UNIR002W"
	Local cTitulo   	    := "Impressão de Boleto Bancário no Layout <font color='red'>SANTANDER.</font><br>Informe os parâmetros desejados e confirme a rotina."

	//Default cParamFilial	:= ""
	Default cParamPrefixo	:= ""
	Default cParamDeNumero	:= ""
	Default cParamAteNumero	:= ""
	//Default cParamNumero    := ""
	//Default cParamTipo      := ""
	//Default cParamParcela   := ""
	//Default cParamCliente   := ""
	//Default cParamLoja	    := ""
	Default lParamSchedule  := .F.

	cTitulo             	:= "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTitulo, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )
	If AllTrim( cParamDeNumero ) == ""

		oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
		oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
		oDlgProc  := MsDialog():New( 091, 232, 324, 659, "Impressão de Boletos de Cobrança SANTANDER",,, .F.,,,,,, .T.,,, .T. )
		oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
		oSayTexto := TSay():New( 016, 014, { || cTitulo }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
		oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || If( FVldParametros(), FImprime( cParamDeNumero, lParamSchedule ), ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
		oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )

		oDlgProc:Activate( ,,,.T. )

	Else

		If AllTrim( cParamPrefixo ) != ""
			MV_PAR01	:= cParamPrefixo
			MV_PAR02	:= cParamPrefixo
		Else
			MV_PAR01	:= Space( TamSX3( "E1_PREFIXO" 	)[01] )
			MV_PAR02	:= Replicate( "Z", TamSX3( "E1_PREFIXO" )[01] )
		EndIf

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
	Local aPergs 	   	:= {}
	Local cAliasSE1		:= GetNextAlias()
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

	Define Font oFont1 NAME "Arial" SIZE 00, 10 OF oPrint
	Define Font oFont2 NAME "Arial" SIZE 00, 12 OF oPrint BOLD
	Define Font oFont3 NAME "Arial" SIZE 00, 16 OF oPrint BOLD
	Define Font oFont4 NAME "Arial" SIZE 00, 11 OF oPrint BOLD
	Define Font oFont5 NAME "Arial" SIZE 00, 19 OF oPrint BOLD
	Define Font oFont7 NAME "Arial" SIZE 00, 25 OF oPrint
	Define Font oFont6 NAME "Arial" SIZE 00, 22 OF oPrint BOLD
	Define FONT oFont8 NAME "Arial" SIZE 00, 16 OF oPrint BOLD

	Tamanho  := "M"
	Titulo   := "Impressão de Boleto com Codigo de Barras"
	cDesc1   := "Este programa destina-se a impressão do Boleto com Codigo de Barras."
	cDesc2   := "para o Banco Santander. Layout Única"
	cDesc3   := ""
	cString  := "SE1"
	WnRel    := "UNIR002"
	lEnd     := .F.
	aReturn  := { "Zebrado", 01, "Administracao", 02, 02, 01, "", 01 }
	nLastKey := 0

	//If !lParamSchedule
	//	If !Pergunte( cPerg  , .T. )
	//		Return
	//	EndIf
	//EndIf

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

	//DbSelectArea( "SE1" )
	//RetIndex( "SE1" )
	//Ferase( cIndexName + OrdBagExt() )

	//DbSelectArea( "SE1" )
	//Set Filter to
	//dbCommitAll()

Return Nil

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
			U_DBOLSAN( lParamSchedule, lEnvMail, .T. )

		EndIf

	Next nT

	/*
DbSelectArea( "SE1" )
SE1->( DbGoTop() )
ProcRegua( SE1->( RecCount() ) )
SE1->( DbGoTop() )
DbSelectArea( "SE1" )
Do While !SE1->( Eof() )

	IncProc( "Imprimindo boleto(s), aguarde..." )
	If !l_imp

		If AllTrim( cParamNumNF ) == ""
			If !Marked( "E1_OK" ) // Verifica se esta flegado
				SE1->( Dbskip() )
				Loop
			EndIf
	    EndIf

	EndIf

	U_DBOLSAN( lParamSchedule, lEnvMail, .T. )

	DbSelectArea( "SE1" )
	SE1->( DbSkip() )
EndDo
	*/

Return

*------------------------------------------------------------------------------*
User Function DBOLSAN( lParamSchedule, lParamEnvMail, lParamSetup, cParamFiles )
	*------------------------------------------------------------------------------*
	Local cNroDoc      :=  " "
	Local aDadosEmp    := {}
	Local aDadosTit    := {}
	Local aDadosBanco  := {}
	Local aDatSacado   := {}
	Local aBolText     := {}
	Local aCB_RN_NN    := {}
	Local nVlrAbat	   := 0
	Local aArea
	Local cDvNf    		//Digito Verificador da NF

	Local cNomeArq 		:= ""

	//Private cSubCon 	:= AllTrim( GetNewPar( "MV_XSUBSAN", "001" ) )

	Private oPrint  	:= NIL
	Private oFont1 		:= NIL
	Private oFont2  	:= NIL
	Private oFont3  	:= NIL
	Private oFont4  	:= NIL
	Private oFont5  	:= NIL
	Private oFont6  	:= NIL
	Private oFont7  	:= NIL

	Default cParamFiles  := Nil

	Define FONT oFont1 NAME "Arial" SIZE 0,10 OF oPrint
	Define FONT oFont2 NAME "Arial" SIZE 0,12 OF oPrint BOLD
	Define FONT oFont3 NAME "Arial" SIZE 0,16 OF oPrint BOLD
	Define FONT oFont4 NAME "Arial" SIZE 0,11 OF oPrint BOLD
	Define FONT oFont5 NAME "Arial" SIZE 0,19 OF oPrint BOLD
	Define FONT oFont7 NAME "Arial" SIZE 0,25 OF oPrint
	Define FONT oFont6 NAME "Arial" SIZE 0,22 OF oPrint BOLD
	Define FONT oFont8 NAME "Arial" SIZE 0,16 OF oPrint BOLD

	aAdd( aDadosEmp  ,  SM0->M0_NOMECOM                                                           ) // [1]Nome da Empresa
	aAdd( aDadosEmp  ,  SM0->M0_ENDCOB                                                            ) // [2]Endereço
	aAdd( aDadosEmp  ,  AllTrim( SM0->M0_BAIRCOB ) + ", " + AllTrim( SM0->M0_CIDCOB ) + ", " + SM0->M0_ESTCOB ) // [3]Complemento
	aAdd( aDadosEmp  ,  "CEP: " + TransForm( SM0->M0_CEPCOB, "@R 99.999-999"   )				   ) // [4]CEP
	aAdd( aDadosEmp  ,  "PABX/FAX: " + SM0->M0_TEL                                                ) // [5]Telefones
	aAdd( aDadosEmp  ,  "CNPJ: " + Transform( SM0->M0_CGC, "@R 99.999.999/9999-99" )              ) // [6] cGC
	aAdd( aDadosEmp  ,  "I.E.: " + SM0->M0_INSC                                                   ) // [7] IE

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

	//Posiciona o SA6 (Bancos)
	DbSelectArea( "SA6" )
	DbSetOrder( 01 )
	//Seek XFilial( "SA6" ) + SE1->( E1_PORTADO + E1_AGEDEP + E1_CONTA )
	Seek XFilial( "SA6" ) + SZ6->( Z6_CODIGO + Z6_AGENCIA + Z6_CONTA )
	If Found()

		nVlrAbat   	:=  SomaAbat( SE1->E1_PREFIXO, SE1->E1_NUM , SE1->E1_PARCELA , "R" , 01, , SE1->E1_CLIENTE, SE1->E1_LOJA )

		//Posiciona na Arq de Parametros CNAB
		DbSelectArea( "SEE" )
		DbSetOrder( 01 )
		//Seek XFilial( "SEE" ) + SE1->( E1_PORTADO + E1_AGEDEP + E1_CONTA ) + cSubCon
		//Seek XFilial( "SEE" ) + SZ6->( Z6_CODIGO + Z6_AGENCIA + Z6_CONTA )
		//Seek SZ6->( Z6_FILIALS + Z6_CODIGO + Z6_AGENCIA + Z6_CONTA + Z6_SUBCTA )
		//Marcelo Amaral 05/11/2019
		Seek xFilial("SEE") + SZ6->( Z6_CODIGO + Z6_AGENCIA + Z6_CONTA + Z6_SUBCTA )
		If Found()

			//If AllTrim( SEE->( EE_FORMEN1 + EE_FORMEN2 + EE_FOREXT1 + EE_FOREXT2 ) ) != ""
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
//			aBolText     := { 	Replace( Replace( SEE->EE_FORMEN1, '"', "" ), "'", "" ) ,;
//  	                      	Replace( Replace( SEE->EE_FORMEN2, '"', "" ), "'", "" ) ,;
//		                      	Replace( Replace( SEE->EE_FOREXT1, '"', "" ), "'", "" ) ,;
//		                      	Replace( Replace( SEE->EE_FOREXT2, '"', "" ), "'", "" )  }

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
			//	"APOS VENCIMENTO COBRAR JUROS DE 10% A.M."		,;


		EndIf

		//	Else
		//		Aviso( "Atenção", "Não encontrou a configuração de Faixa para o Banco!", { "Voltar" } )
		//	EndIf

		//Posiciona o SA1 (Cliente)
		DbSelectArea( "SA1" )
		DbSetOrder( 01 )
		Seek XFilial( "SA1" ) + SE1->( E1_CLIENTE + E1_LOJA )
		If Found()

			aDadosBanco  := {}
			aAdd( aDadosBanco,  SA6->A6_COD     )  // [1]Numero do Banco
			aAdd( aDadosBanco,  SA6->A6_NREDUZ  )  // [2]Nome do Banco
			aAdd( aDadosBanco,  Left( SA6->A6_AGENCIA, 04 ) )  // [3]Agência
			aAdd( aDadosBanco,  AllTrim( SA6->A6_NUMCON  ) ) // [4]Conta Corrente
			aAdd( aDadosBanco,  AllTrim( SA6->A6_DVCTA )  )  // [5]Dígito da conta corrente
			aAdd( aDadosBanco,  "" 			    )  // [6]Codigo da Carteira

			If AllTrim( SA1->A1_ENDCOB ) == ""

				aDatSacado   := { 	AllTrim( SA1->A1_NOME )          							,; 	// [1]Razão Social
					AllTrim( SA1->A1_COD  ) + "-" + SA1->A1_LOJA 				,; 	// [2]Código
					AllTrim( SA1->A1_END  ) + "-" + AllTrim( SA1->A1_BAIRRO )  	,;  // [3]Endereço
					AllTrim( SA1->A1_MUN  )                             	   	,;	// [4]Cidade
					SA1->A1_EST                                       	,;	// [5]Estado
					SA1->A1_CEP                                       	,; 	// [6]CEP
					SA1->A1_CGC									   	,;	// [7]CGC
					SA1->A1_PESSOA										 } 	// [8]PESSOA
			Else

				aDatSacado   := { 	AllTrim( SA1->A1_NOME   )            						,; 	// [1]Razão Social
					AllTrim( SA1->A1_COD    ) + "-" + SA1->A1_LOJA              ,; 	// [2]Código
					AllTrim( SA1->A1_ENDCOB ) + "-" + AllTrim( SA1->A1_BAIRROC ),; 	// [3]Endereço
					AllTrim( SA1->A1_MUNC   )	                            	,; 	// [4]Cidade
					SA1->A1_ESTC	                                    ,; 	// [5]Estado
					SA1->A1_CEPC                                       ,; 	// [6]CEP
					SA1->A1_CGC										,;	// [7]CGC
					SA1->A1_PESSOA										 }	// [8]PESSOA
			EndIf

			cNroDoc		:= SE1->E1_NUMBCO
			cNroDoc		:= AllTrim( cNroDoc )

			DbSelectArea( "SE1" )
			If Empty( SE1->E1_NUMBCO )

				cNroDoc := StrZero( ( Val( Alltrim( SEE->EE_FAXATU ) ) + 01 ), 07 )
				DbSelectArea( "SEE" )
				//RecLock( "SEE", .F. )
				//	SEE->EE_FAXATU := cNroDoc
				//SEE->( MsUnlock() )
				cUpdate := "	UPDATE " + RetSQLName( "SEE" )
				cUpdate += " 	   SET EE_FAXATU 	= '" + cNroDoc + "' "
				cUpdate += "	 WHERE R_E_C_N_O_ 	= " + AllTrim( Str( SEE->( RecNo() ) ) )
				If TcSQLExec( cUpdate ) != 0
					Aviso( "Atenção", "Erro ao tentar atualizar o Nosso número para  a Duplicata." + CRLF + TcSQLError(), { "Continuar" } )
				EndIf

				cNroDoc := cNroDoc + Left( Modulo11( cNroDoc ), 01 )

			Else

				cNroDoc := Left( Alltrim( SE1->E1_NUMBCO ), 08 )

			EndIf

			DbSelectArea("SE1")
			If AllTrim( cNroDoc ) == ""

				Aviso( "Atenção", "O Título: " + SE1->E1_NUM + " prefixo: " + SE1->E1_PREFIXO + " não possui preenchido o campo Nosso Número e por isso não será impresso o seu boleto.", { "OK" } )
				aDadosTit := {}

			Else

				//Monta codigo de barras
				aCB_RN_NN 	:= Ret_cBarra( SE1->E1_PREFIXO	, SE1->E1_NUM , SE1->E1_PARCELA , SE1->E1_TIPO ,  aDadosBanco  , cNroDoc ,(Round((SE1->E1_SALDO+SE1->E1_ACRESC-nVlrAbat-SE1->E1_DECRESC),2))	, SE1->E1_VENCREA	)
				//aCB_RN_NN  	:= FRetCodBarras( SubStr( aDadosBanco[01], 01, 03 ) + "9", aDadosBanco[03], aDadosBanco[04], aDadosBanco[05], AllTrim( SE1->E1_NUM ),( Round( ( SE1->E1_SALDO + SE1->E1_ACRESC - nVlrAbat - SE1->E1_DECRESC ), 02 ) ), SE1->E1_VENCREA )
				cDvNf 		:= Digit001( PadL( SE1->E1_NUM, 08, "0" ) )    // Calculo do Digito Verificador da NF.

				aAdd( aDadosTit, AllTrim( SE1->E1_NUM ) + " " + cDvNf				   ) // [1] Número do título + Digito Verificador da NF
				aAdd( aDadosTit, SE1->E1_EMISSAO                           	) // [2] Data da emissão do título
				aAdd( aDadosTit, dDataBase                    	 	      ) // [3] Data da emissão do boleto
				aAdd( aDadosTit, SE1->E1_VENCREA                             	) // [4] Data do vencimento
				aAdd( aDadosTit, ( Round( ( SE1->( E1_SALDO + E1_ACRESC - nVlrAbat - E1_DECRESC ) ), 02 ) )              		) // [5] Valor do título
				aAdd( aDadosTit, aCB_RN_NN[03]                          	) // [6] Nosso número (Ver fórmula para calculo)
				aAdd( aDadosTit, SE1->E1_PREFIXO                            	) // [7] Prefixo da NF
				aAdd( aDadosTit, SE1->E1_TIPO	                             	) // [8] Tipo do Titulo
				aAdd( aDadosTit, SE1->E1_PORCJUR                     	   		) // [9] Juros
				aAdd( aDadosTit, SE1->E1_PARCELA                     	 		) // [10] Parcela
				aAdd( aDadosTit, SE1->E1_XNOTA                       	 		) // [11] N Nota Fiscal

				//AADD ( aDadosTit  , E1_VENCTO                             	) // [4] Data do vencimento

				// Grava Codigo de Barras, Linha Digitavel e Dv do Nosso Numero no SE1
				DbSelectArea( "SE1" )
				Reclock( "SE1", .F. )
				SE1->E1_CODBAR  := aCB_RN_NN[01]
				SE1->E1_CODDIG  := Replace( Replace( aCB_RN_NN[02], " ", "" ), ".", "" )
				SE1->E1_PORTADO := "033"
				SE1->E1_AGEDEP	:= SZ6->Z6_AGENCIA
				SE1->E1_CONTA	:= SZ6->Z6_CONTA
				SE1->( MSUnLock() )

				cPathPDF  := AllTrim( GetNewPar( "MV_XPTHBOL", "C:\BoletoPDF" ) )
				cPathMail := AllTrim( GetNewPar( "MV_XPTHMAI", "\MailBol"     ) )
				FwMakedir( cPathPDF	, .T. )
				FwMakeDir( cPathMail, .T. )
				cNomeArq := "boletoS-" + AllTrim( SA1->A1_COD ) + "-" + AllTrim( SA1->A1_LOJA ) + "-" + FwTimeStamp( 01 ) + ".pdf"

				//If cParamFiles == Nil
				If !lParamEnvMail //MV_PAR19 == 1
					oPrint := FWMSPrinter():New( cNomeArq,, .T., cPathPDF, .T. )
				Else
					oPrint := FWMSPrinter():New( cNomeArq,, .T., cPathMail,.T.)
				endIf

				If lParamEnvMail //MV_PAR19 == 1
					oPrint:lServer := .T.
					oPrint:SetViewPDF( .F. )
				Else
					oPrint:lServer := .F.
					oPrint:SetViewPDF( .T. )
				EndIf
				oPrint:nDevice := IMP_PDF

				//If cParamFiles == Nil
				If !lParamEnvMail //MV_PAR19 == 1
					oPrint:cPrinter := "PDF"
					oPrint:cPathPDF := AllTrim( cPathPDF ) + "\"
				Else
					oPrint:cPrinter := "PDF"
					oPrint:cPathPDF 	:= AllTrim( cPathMail ) + "\"
				EndIf
				oPrint:SetPortrait()
				oPrint:SetPaperSize( DMPAPER_A4 )

				DbSelectArea( "SZ4" )
				SZ4->( DbSetOrder( 01 )  )

				If Dbseek(xFilial("SZ4")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)  // Alterado por Luiz Otavio Para buscar corretamente a config do envio de boleto
					lMostraBoleto := SZ4->Z4_SHOWBOL == "S"
					lMostraSetUp  := SZ4->Z4_SHOWSET == "S"
				Else
					lMostraBoleto := .T.
					lMostraSetUp  := .T.
				EndIf

				//Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
				FImpBoleto( oPrint, aDadosEmp, aDadosTit, aDadosBanco, aDatSacado, aBolText, aCB_RN_NN, SE1->E1_PEDIDO, SE1->E1_NUMBCO, SE1->E1_NUM )

				If !lParamEnvMail .And. lParamSetup
					If lMostraSetup
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


					U_UNIEnvBoletos( "237", aAuxTitulos, .F. )

					Sleep( 1000  )

				EndIf

			EndIf

		EndIf

	EndIf

Return

*---------------------------------------------------------------------------------------------------------------------------------------------*
Static Function FImpBoleto( oPrint, aDadosEmp, aDadosTit, aDadosBanco, aDatSacado, aBolText, aCB_RN_NN, cParamPedido, cParamNossoNum, cParamNF )
	*---------------------------------------------------------------------------------------------------------------------------------------------*
	Local nI 	:= 00
	Local nLin	:= 30

	oPrint:StartPage()   // Inicia uma nova página

	/*-------------------------------------------------------*
*Imprime a primeira parte do boleto
	*-------------------------------------------------------*/
	oPrint:Line(0110+nLin,0030,0110+nLin,2300)
	oPrint:Line(0220+nLin,0030,0220+nLin,2300)
	oPrint:Line(0290+nLin,0030,0290+nLin,2300)
	oPrint:Line(0360+nLin,0030,0360+nLin,2300)
	oPrint:Line(0710+nLin,0030,0710+nLin,2300)
	oPrint:Line(0890+nLin,0030,0890+nLin,2300)

	// Risco maior na vertical da folha ficha de compensacao, parte superior
	oPrint:Line(0110+nLin,1690,0360+nLin,1690)

	//Linha vertical localizada no coddigo do banco
	//oPrint:Line(0020+nLin,0687-50,0110+nLin,0687-50)
	oPrint:Line(0020+nLin,0688-50,0110+nLin,0688-50)
	oPrint:Line(0020+nLin,0689-50,0110+nLin,0689-50)

	//oPrint:Line(0020+nLin,0891-50,0110+nLin,0891-50)
	oPrint:Line(0020+nLin,0892-50,0110+nLin,0892-50)
	oPrint:Line(0020+nLin,0893-50,0110+nLin,0893-50)

	////oPrint:Line(0020+nLin,0690,0110+nLin,0690)
	////oPrint:Line(0020+nLin,0890,0110+nLin,0890)
	////oPrint:Line(0020+nLin,0891,0110+nLin,0891)

	////oPrint:Line(0020+nLin,0891,0110+nLin,0891)
	//oPrint:Line(0020+nLin,0892,0110+nLin,0892)


	oPrint:Line(0110+nLin,0030,0890+nLin,0030)
	oPrint:Line(0110+nLin,2300,0890+nLin,2300)

	oPrint:Line(0290+nLin,0350,0360+nLin,0350)
	oPrint:Line(0290+nLin,0880,0360+nLin,0880)
	oPrint:Line(0290+nLin,1080,0360+nLin,1080)
	oPrint:Line(0290+nLin,1180,0360+nLin,1180)

	//oPrint:SayBitmap(0010+nLin,0040,"lgrsantander.jpg",354,97)
	oPrint:SayBitmap(0005+nLin,0060,"lgrsantander.jpg",384,102)

	oPrint:Say(0090+nLin,0700+30-50,aDadosBanco[1]  	,oFont6) //Numero do Banco

	//oPrint:Say(0040+nLin,1750,"Recibo Sacado"	,oFont5)
	oPrint:Say(0090+nLin,1750,"Recibo Pagador"	,oFont5)
	nLin += 18
	oPrint:Say(0115+nLin,0040,"Local de Pagamento"										,oFont1)
	oPrint:Say(0160+nLin,0110,"ATÉ O VENCIMENTO, QUALQUER BANCO. APÓS VENCIMENTO, SOMENTE NO SANTANDER"	,oFont4)

	//oPrint:SayBitmap(0115+nLin,01693,"\SIGADOC\PROJETO\iMAGENS\BARRA2.bmp" 		    	,354,97)
	oPrint:Say(0115+nLin,1700,"Vencimento"												,oFont1)
	cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
	oPrint:Say(0175+nLin,1830,cString													,oFont4)

	oPrint:Say(0225+nLin,0040, "Cedente"									     	,oFont1)
	oPrint:Say(0260+nLin,0110, aDadosEmp[01] + "                    " + aDadosEmp[6]	,oFont4)

	*'-------------------------'*
	*'Pegando Codigo do Cedente'*
	*'-------------------------'*
	cCedent := SA6->A6_XCEDENT

	oPrint:Say(0225+nLin,1700,"Agência/Código Cedente",oFont1)
	oPrint:Say(0260+nLin,1830,aDadosBanco[03] + "/" + cCedent,oFont4)
	//oPrint:Say(0260+nLin,1830,aDadosBanco[03] + "/" + aDadosBanco[04] + "-" + aDadosBanco[05], oFont4)

	oPrint:Say(0300+nLin,0040,"Data Documento"				,oFont1)
	oPrint:Say(0330+nLin,0090,StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4)							,oFont4)

	oPrint:Say(0300+nLin,0370,"Nº do Documento"		    	,oFont1)
	oPrint:Say(0330+nLin,0380,aDadosTit[7]+aDadosTit[1]+" "+aDadosTit[10]		,oFont4)//Prefixo +Numero+Parcela

	oPrint:Say(0300+nLin,0900,"Espécie Doc."		   		,oFont1)
	oPrint:Say(0330+nLin,0900,"DM"				   			,oFont4)

	oPrint:Say(0300+nLin,1100,"Aceite"						,oFont1)
	oPrint:Say(0330+nLin,1090,"N"							,oFont4)

	oPrint:Say(0300+nLin,1220,"Data Processamento"		 	,oFont1)
	oPrint:Say(0330+nLin,1230,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4) ,oFont4) // Data impressao

	oPrint:Say(0300+nLin,1700,"(=) Valor Cobrado"								,oFont1)
	oPrint:Say(0330+nLin,1830,Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))	,oFont4)

	oPrint:Say(0365+nLin,0040,"Instruções"	,oFont1)
	/*
oPrint:Say(0440+nLin,0110,"*** "+Alltrim(aBolText[1])+" ***"	,oFont4)
oPrint:Say(0475+nLin,0110,"*** "+Alltrim(aBolText[2])+" ***"	,oFont4)
oPrint:Say(0510+nLin,0110,"***1 "+Alltrim(aBolText[3])+" ***"	,oFont4)
oPrint:Say(0545+nLin,0110,"*** "+Alltrim(aBolText[4])+" ***"	,oFont4)
oPrint:Say(0580+nLin,0110,"*** "+Alltrim(aBolText[5])+" ***"	,oFont4)
oPrint:Say(0615+nLin,0110,"*** "+Alltrim(aBolText[6])+" ***"	,oFont4)
oPrint:Say(0650+nLin,0110,"*** "+Alltrim(aBolText[7])+" ***"	,oFont4)
	*/
	oPrint:Say(0440+nLin ,0110, Alltrim( aBolText[01] ),oFont4 )
	oPrint:Say(0475+nLin ,0110, Alltrim( aBolText[02] ),oFont4 )
	oPrint:Say(0510+nLin ,0110, Alltrim( aBolText[03] ),oFont4 )
	oPrint:Say(0545+nLin ,0110, Alltrim( aBolText[04] ),oFont4 )
	oPrint:Say(0580+nLin ,0110, Alltrim( aBolText[05] ),oFont4 )
	//oPrint:Say(0615 + nLin, 0110, "PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ), oFont4 )




	//Adicionado por Luiz Otavio em 18/03/21 * Exibir o numedo da nota fiscal no boleto bancário
	cParamNF  := Iif(!Empty(aDadosTit[11]),aDadosTit[11],cParamNF)
	oPrint:Say(0615 + nLin, 0110, "PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ), oFont4 )


	//oPrint:Say(0580+nLin,0110,Alltrim(aBolText[6]),oFont4)
	//oPrint:Say(0615+nLin,0110,Alltrim(aBolText[7]),oFont4)

	*'----------------------------------------------------------------------'*
	*'Incluído informação se o título for de Royalty ou de Fundo de Promoção'*
	*'----------------------------------------------------------------------'*
	//oPrint:Say (0670+nLin,0110,"xxxxxxxxxx" /*E1_XBOLETO*/,oFont1)
	*'----------------------------------------------------------------------'*
	*'Fim    -  '*
	*'----------------------------------------------------------------------'*

	oPrint:Say( 0715 + nLin + 3, 0040, "Sacado"													 ,oFont1)
	//oPrint:Say(0670+nLin+10,950, aDadosEmp[01]	 								 			 ,oFont1)
	oPrint:Say( 0715 + nLin + 10, 0250-50, aDatSacado[01] + " ( " + cFilAnt + "-" + aDatSacado[02]+ ") " + If( Len( AllTrim( aDatSacado[07] ) ) >= 14, "  CNPJ: " + Transform( aDatSacado[07], "@R 99.999.999/9999-99" ), "  CPF: " + Transform( aDatSacado[07], "@R 999.999.999-99" ) )		     ,oFont4)
	oPrint:Say( 0750 + nLin + 10, 0250-50, aDatSacado[03]										 		 	 , oFont4 )
	oPrint:Say( 0785 + nLin + 10, 0250-50, aDatSacado[06] + "    " + aDatSacado[04] + " - " + aDatSacado[05], oFont4 )

	oPrint:Say(0860+nLin,0040,"Sacador/Avalista"		  								 ,oFont1)

	oPrint:Say(0895+nLin,1700,"Autênticação Mecânica" 									 ,oFont1)
	oPrint:Say(950+nLin,0030,"_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ __ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",oFont4)

	nLin := nLin + 1005

	oPrint:Line(0110+nLin,0030,0110+nLin,2300)
	oPrint:Line(0220+nLin,0030,0220+nLin,2300)
	oPrint:Line(0290+nLin,0030,0290+nLin,2300)
	oPrint:Line(0360+nLin,0030,0360+nLin,2300)
	oPrint:Line(0430+nLin,0030,0430+nLin,2300)
	oPrint:Line(0780+nLin,0030,0780+nLin,2300)
	oPrint:Line(0960+nLin,0030,0960+nLin,2300)


	// Riscos horizontais para valores da folha ficha de compensacao, parte superior
	oPrint:Line(0500+nLin,1690,0500+nLin,2300)
	oPrint:Line(0570+nLin,1690,0570+nLin,2300)
	oPrint:Line(0640+nLin,1690,0640+nLin,2300)
	oPrint:Line(0710+nLin,1690,0710+nLin,2300)

	// Risco maior na vertical da folha ficha de compensacao, parte superior
	oPrint:Line(0110+nLin,1690,0781+nLin,1690)

	//Linha vertical localizada no coddigo do banco
	//oPrint:Line(0020+nLin,0687-50,0110+nLin,0687-50)
	oPrint:Line(0020+nLin,0688-50,0110+nLin,0688-50)
	oPrint:Line(0020+nLin,0689-50,0110+nLin,0689-50)

	////oPrint:Line(0020+nLin,0690,0110+nLin,0690)
	////oPrint:Line(0020+nLin,0890,0110+nLin,0890)

	//oPrint:Line(0020+nLin,0891,0110+nLin,0891)
	//////oPrint:Line(0020+nLin,0891,0110+nLin,0890)
	//oPrint:Line(0020+nLin,0892,0110+nLin,0892)
	//////oPrint:Line(0020+nLin,0891,0110+nLin,0890)

	//oPrint:Line(0020+nLin,0891-50,0110+nLin,0891-50)
	oPrint:Line(0020+nLin,0892-50,0110+nLin,0892-50)
	oPrint:Line(0020+nLin,0893-50,0110+nLin,0893-50)

	oPrint:Line(0110+nLin,0030,0960+nLin,0030)
	oPrint:Line(0110+nLin,2300,0960+nLin,2300)

	oPrint:Line(0290+nLin,0350,0430+nLin,0350)
	oPrint:Line(0290+nLin,0880,0360+nLin,0880)
	oPrint:Line(0290+nLin,1080,0360+nLin,1080)
	oPrint:Line(0290+nLin,1180,0360+nLin,1180)

	oPrint:Line(0360+nLin,0650,0430+nLin,0650)
	oPrint:Line(0360+nLin,0910,0430+nLin,0910)
	oPrint:Line(0360+nLin,1280,0430+nLin,1280)

	//oPrint:SayBitmap(0010+nLin,0040,"lgrsantander.jpg",354,97)
	oPrint:SayBitmap(0005+nLin,0060,"lgrsantander.jpg",385,102)

	nLin += 18
	//oPrint:Say(0025+nLin,0700,aDadosBanco[1]    	,oFont6) //[1]Numero do Banco
	oPrint:Say(0080+nLin,0700+30-50,aDadosBanco[1]    	,oFont6) //[1]Numero do Banco

	//oPrint:Say(0040+nLin,0965,aCB_RN_NN[2]			,oFont8)
	oPrint:Say(0080+nLin,0965,aCB_RN_NN[2]			,oFont8)

	oPrint:Say(0115+nLin,0040,"Local de Pagamento"										,oFont1)
	oPrint:Say(0160+nLin,0110,"ATÉ O VENCIMENTO, QUALQUER BANCO. APÓS VENCIMENTO, SOMENTE NO SANTANDER"	,oFont4)

	//oPrint:SayBitmap(0115+nLin,01693,"\SIGADOC\PROJETO\iMAGENS\BARRA2.bmp" 		    	,354,97)
	oPrint:Say(0115+nLin,1700,"Vencimento"												,oFont1)
	cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
	oPrint:Say(0175+nLin,1830,cString													,oFont4)

	oPrint:Say(0225+nLin,0040,"Cedente"				 							     	,oFont1)
	oPrint:Say(0260+nLin,0110,aDadosEmp[01] + "                    " + aDadosEmp[06]	,oFont4)

	oPrint:Say(0225+nLin,1700,"Agência/Código Cedente"		,oFont1)
	//oPrint:Say(0260+nLin,1830,aCB_RN_NN[5]+" "+cCedent		,oFont4)
	oPrint:Say(0260+nLin,1830,aDadosBanco[03] + "/" + cCedent,oFont4)
	//oPrint:Say (0260+nLin,1830,aDadosBanco[03] + "/" + aDadosBanco[04] + "-" + aDadosBanco[05], oFont4)

	oPrint:Say(0300+nLin,0040,"Data Documento"				,oFont1)
	oPrint:Say(0330+nLin,0090,StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4)							,oFont4)

	oPrint:Say(0300+nLin,0370,"Nº do Documento"		    	,oFont1)
	oPrint:Say(0330+nLin,0380,aDadosTit[7]+aDadosTit[1]+" "+aDadosTit[10]		,oFont4)//Prefixo +Numero+Parcela

	oPrint:Say(0300+nLin,0900,"Espécie Doc."		   		,oFont1)
	oPrint:Say(0330+nLin,0900,"DM"				   			,oFont4)

	oPrint:Say(0300+nLin,1100,"Aceite"						,oFont1)
	oPrint:Say(0330+nLin,1090,"N"							,oFont4)

	oPrint:Say(0300+nLin,1220,"Data Processamento"		 	,oFont1)
	oPrint:Say(0330+nLin,1230,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4) ,oFont4) // Data impressao

	oPrint:Say(0300+nLin,1700,"Nosso Número"				,oFont1)
	oPrint:Say(0330+nLin,1830,aDadosTit[6]					,oFont4)

	oPrint:Say(0365+nLin,0040,"Uso do Banco"				,oFont1)

	oPrint:Say(0365+nLin,0370,"Carteira"				   	,oFont1)
	oPrint:Say(0400+nLin,0370,aCB_RN_NN[4]			    	,oFont4)

	oPrint:Say(0365+nLin,0670,"Espécie da Moeda"			,oFont1)
	oPrint:Say(0400+nLin,0690,"R$"						    ,oFont4)

	oPrint:Say(0365+nLin,0920,"Quantidade"			   		,oFont1)
	oPrint:Say(0365+nLin,1390,"Valor Moeda"			   		,oFont1)

	//oPrint:SayBitmap(0365+nLin,01693,"\SIGADOC\iMAGENS\BARRA2.bmp" 			,605,065)
	oPrint:Say(0365+nLin,1700,"(=) Valor do Documento"								,oFont1)
	oPrint:Say(0400+nLin,1830,Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))	,oFont4)

	oPrint:Say(0435+nLin,0040,"Instruções"	,oFont1)

	/*
oPrint:Say(0545+nLin,0110,"*** "+Alltrim(aBolText[1])+" ***"	,oFont4)
oPrint:Say(0580+nLin,0110,"*** "+Alltrim(aBolText[2])+" ***"	,oFont4)
oPrint:Say(0615+nLin,0110,"*** "+Alltrim(aBolText[3])+" ***"	,oFont4)
oPrint:Say(0650+nLin,0110,"*** "+Alltrim(aBolText[4])+" ***"	,oFont4)
oPrint:Say(0685+nLin,0110,"*** "+Alltrim(aBolText[5])+" ***"	,oFont4)
oPrint:Say(0720+nLin,0110,"*** "+Alltrim(aBolText[6])+" ***"	,oFont4)
oPrint:Say(0755+nLin,0110,"*** "+Alltrim(aBolText[7])+" ***"	,oFont4)
	*/
	oPrint:Say( 0510 + nLin, 0110, Alltrim( aBolText[01] ), oFont4 )
	oPrint:Say( 0545 + nLin, 0110, Alltrim( aBolText[02] ), oFont4 )
	oPrint:Say( 0580 + nLin, 0110, Alltrim( aBolText[03] ), oFont4 )
	oPrint:Say( 0615 + nLin, 0110, Alltrim( aBolText[04] ), oFont4 )
	oPrint:Say( 0650 + nLin, 0110, Alltrim( aBolText[05] ), oFont4 )
	oPrint:Say( 0685 + nLin ,0110, "PED.: " + AllTrim( cParamPedido ) + " NUM.: BANCÁRIO: " + AllTrim( cParamNossoNum ) + " NF: " + AllTrim( cParamNF ), oFont4 )

	//oPrint:Say(0720+nLin,0110,Alltrim(aBolText[6]),oFont4)
	//oPrint:Say(0755+nLin,0110,Alltrim(aBolText[7]),oFont4)

	*'----------------------------------------------------------------------'*
	*'Inicio - Angelo Henrique - Data: 19/03/2013							'*
	*'Incluído informação se o título for de Royalty ou de Fundo de Promoção'*
	*'----------------------------------------------------------------------'*
	//oPrint:Say (0720+nLin,0110,E1_XBOLETO,oFont1)
	*'----------------------------------------------------------------------'*
	*'Fim    - Angelo Henrique - Data: 19/03/2013							'*
	*'----------------------------------------------------------------------'*

	oPrint:Say(0435+nLin,1700,"(-) Desconto/Abatimento"		,oFont1)
	oPrint:Say(0505+nLin,1700,"(-) Outras Deduções"			,oFont1)
	oPrint:Say(0575+nLin,1700,"(+) Mora/Multa"			    ,oFont1)
	oPrint:Say(0645+nLin,1700,"(+) Outros Acréscimos"		,oFont1)
	oPrint:Say(0715+nLin,1700,"(=) Valor Cobrado"			,oFont1)

	/*
oPrint:Say(0785+nLin,0040,"Sacado"						,oFont1)
oPrint:Say(0740+nLin,950,aDadosEmp[1]	 								 			 ,oFont1)
oPrint:Say(0785+nLin,0250,aDatSacado[1]+" ("+ cfilant + aDatSacado[2]+ ")"+"  CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99")		     ,oFont4) //Vitor Duarte 28/08/2013
oPrint:Say(0820+nLin,0250,aDatSacado[3]										 		 ,oFont4)
oPrint:Say(0855+nLin,0250,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5]	 ,oFont4)
	*/
	oPrint:Say(0785+nLin+3,0040,"Sacado"													 ,oFont1)
	//oPrint:Say(0740+nLin,950,aDadosEmp[1]	 								 			 ,oFont1)
	oPrint:Say( 0785 + nLin+10, 0250-50, aDatSacado[01] + " ( " + cFilAnt + "-" + aDatSacado[02]+ ") " + If( Len( AllTrim( aDatSacado[07] ) ) >= 14, "  CNPJ: " + Transform( aDatSacado[07], "@R 99.999.999/9999-99" ), "  CPF: " + Transform( aDatSacado[07], "@R 999.999.999-99" ) ),oFont4)
	oPrint:Say( 0820 + nLin+10, 0250-50, aDatSacado[03]										 		 	 , oFont4 )
	oPrint:Say( 0855 + nLin+10, 0250-50, aDatSacado[06]+"    " + aDatSacado[04] + " - " + aDatSacado[05]	 , oFont4 )

	oPrint:Say(0930+nLin,0040,"Sacador/Avalista"		  ,oFont1)
	oPrint:Say(0930+nLin,1700,"Código de Baixa"			  ,oFont1)

	oPrint:Say(0965+nLin,1450,"Autênticação Mecânica"		,oFont1)
	oPrint:Say(0965+nLin,1800,"Ficha de compensação"		,oFont1)

	//Chama Função para Gravar Código de barras e linha digitável no registro da SE1
	//FGrvCodBar( CB_RN_NN )

	// Imprime Código de Barras
	//MSBAR("INT25",18,1.6,aCB_RN_NN[1],oPrint,.F.,,.T.,0.028,1.3,,,"A",.F.) //Vitor Duarte 01/11/2013
	oPrint:FWMSBAR("INT25",48,1.6,aCB_RN_NN[1],oPrint,.F.,,.T.,0.028,1.3,,,"A",.F.)

	DbSelectArea( "SE1" )
	RecLock( "SE1", .F.)
	SE1->E1_NUMBCO  := aCB_RN_NN[03]   // Nosso número (Ver fórmula para calculo)
	SE1->E1_PORTADO := "033"
	SE1->E1_AGEDEP	:= SZ6->Z6_AGENCIA
	SE1->E1_CONTA	:= SZ6->Z6_CONTA
	SE1->( MsUnLock() )

	oPrint:EndPage() // Finaliza a página

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
		//RecLock( "SEE", .F. )
		//	SEE->EE_FAXATU := _cNossoNum
		//SEE->( MsUnLock() )
		cUpdate := "	UPDATE " + RetSQLName( "SEE" )
		cUpdate += " 	   SET EE_FAXATU 	= '" + _cNossoNum + "' "
		cUpdate += "	 WHERE R_E_C_N_O_ 	= " + AllTrim( Str( SEE->( RecNo() ) ) )
		If TcSQLExec( cUpdate ) != 0
			Aviso( "Atenção II", "Erro ao tentar atualizar o Nosso número para  a Duplicata." + CRLF + TcSQLError(), { "Continuar" } )
		EndIf

		DbSelectArea( "SE1" )
		RecLock( "SE1", .F. )
		SE1->E1_NUMBCO := _cNossoNum
		SE1->E1_AGEDEP	:= cAgencia
		SE1->E1_CONTA	:= cConta
		SE1->( MsUnlock() )
	Else
		_cNossoNum :=  Alltrim( SE1->E1_NUMBCO )
	EndIf

	//Calcula o DAC para o Nosso Número
	s        	:= ( Alltrim( cAgencia ) + Alltrim( cConta ) + Alltrim( _cCart ) + Alltrim( SubStr( _cNossoNum, 01, 08 ) ) )
	cNnMod10 	:= FRetDACNossoNumero( s )
	cNnMod10 	:= Alltrim( cNnMod10 )
	NN   		:= _cCart + SubStr( _cNossoNum, 01, 08 ) + "-" + cNnMod10

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

/*
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

EndIf

Return
*/

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

/*
*---------------------------------------------------------------------------------------------------------------------------------------------*
Static Function FEnviaBoleto( cParamFilial, cParamPrefixo, cParamNumero, cParamTipo, cParamParcela, cParamCliente, cParamLoja, lParamSchedule )
*---------------------------------------------------------------------------------------------------------------------------------------------*
Local cFiles			:= ""
Local cFileRet  		:= ""
Local cBody				:= ""
Local cCliente			:= ""
Local cNomCli			:= ""
Local aRetMail  		:= { .F., "Nenhum e-mail enviado" }
Local nI				:= 0

Local cServidor 		:= AllTrim( GetMv( "MV_RELSERV" ) )
Local cConta 			:= AllTrim( GetMv( "MV_MAILCOB" ) )
Local cPass 			:= AllTrim( GetMv( "MV_PSWCOB"  ) )
Local cEnMail 			:= AllTrim( GetNewPar( "MV_MAICCBO", "" ) )
Local aTitSel   		:= {}

Private cEmail			:= ""
Private lEhSch 			:= .F.

DbSelectArea( "SA1" )
DbSetOrder( 01 ) // A1_FILIAL + A1_COD + A1_LOJA

DbSelectArea( "SA1" )
Seek XFilial( "SA1" ) + cParamCliente + cParamLoja
If Found()

	cCliente 	:= SA1->A1_COD
	cNomCli	 	:= SA1->A1_NOME
	cEmail      := SA1->A1_EMAIL
	cFiles	 	:= ""
	cFileRet    := ""

	cBody 	 	:= FRetHTMLBoleto( 01, .F. )
	cBody 	 	:= StrTran( cBody, "@Cliente", cNomCli )

	lZebrado := .F.
	//Testa se o Titulo esta em Borderô e com Saldo maior que Zero
	If ( Alltrim( SE1->E1_NUMBOR ) != "" .And. SE1->E1_SALDO > 0 )

		cFileRet := StartJob( "U_DBOLITAU", GetEnvServer(), .T., lParamSchedule, cEmpAnt, cFilAnt, SE1->( E1_RECNO, aTitSel[nI][nPosCBanco] )
		cFiles 	 +=  Iif( AllTrim( cFiles ) == "", cFileRet, "," + AllTrim( cFileRet ) )
		cBody 	 += FRetHTMLBoleto( 02, lZebrado )
		lZebrado := !lZebrado
		cBody 	 := StrTran( cBody, "@Titulo" 	 , 			  aTitSel[nI][nPosCTitulo]										    					  ) // NUMERO
		cBody 	 := StrTran( cBody, "@Vencimento", 		DToC( aTitSel[nI][nPosCVencimento] )                                         			  	  ) // VENCIMENTO
		cBody 	 := StrTran( cBody, "@Parcela"	 , 			  aTitSel[nI][nPosCParcela] 				     										  ) // PARCELA
		cBody 	 := StrTran( cBody, "@Emissao"   , 		DToC( aTitSel[nI][nPosCEmissao] )                   									  	  ) // EMISSÃO
		cBody 	 := StrTran( cBody, "@Valor"  	 , Transform( aTitSel[nI][nPosCValor] + aTitSel[nI][nPosCAcrescimo], "@E 99,999,999,999,999,999.99" ) ) // VALOR

		// Efetivação do Log
		nAuxZAARecNo := FIncLogFollow( aTitSel[nI][nPosFilial], "O boleto do título " + aTitSel[nI][nPosCTitulo] + " / Prefixo " + aTitSel[nI][nPosCPrefixo] + " / Parcela " + aTitSel[nI][nPosCParcela] + " foi reenviado com sucesso para o email do franqueado " + AllTrim( cCliente ) + " / " + AllTrim( cNomCli ), "L", RetSQLName( "SE1" ), aTitSel[nI][nPosCRecNoE1] )

	Else

		Aviso( "Atenção", "O Titulo " + aTitSel[nI][nPosCTitulo] + " não está em Borderô ou Encontra-se Liquidado!", { "Voltar" } )

	EndIf

			Next nI

			cBody += FRetHTMLBoleto( 03, .F. )
			If AllTrim( cFiles ) != ""
				//By RGR --> Aqui
				//cEmail := "workflow@rgrsolucoes.com"
				//cConta := ""
				aRetMail := U_ZSendMail( cConta, cPass, cServidor, cConta, cEmail, cCliente + "-" + cNomCli, cBody, cFiles, cEnMail, .F. )
			EndIf

		Else

	    	Aviso( "Atenção", "Para esse procedimento, pelo menos um Título deverá ser Marcado!", { "Voltar" } )

		EndIf

	Next nC

Else

	Aviso( "Atenção", "Não existem dados para a emissão dos Boletos", { "Voltar" } )

EndIf

Return aRetMail
*/

/*
Static Function Ret_cBarra(	cPrefixo,cNumero,cParcela,cTipo  ,aDadosBanco   ,cNroDoc  ,nValor, dVencimen )

Local aArea:=GetArea()
Local cNosso		:= ""
Local cDVNosso		:= ""
Local cDVNoss1		:= ""
Local NNUM			:= ""
Local cCampoL		:= ""
Local cFatorValor	:= ""
Local cLivre		:= ""
Local cDigBarra		:= ""
Local cBarra		:= ""
Local cParte1		:= ""
Local cDig1			:= ""
Local cParte2		:= ""
Local cDig2			:= ""
Local cParte3		:= ""
Local cDig3			:= ""
Local cParte4		:= ""
Local cParte5		:= ""
Local cDigital		:= ""
Local cDtVenc		:= ""
Local aRet			:= {}
Local cBanco    	:= aDadosBanco [ 1 ]
Local cAgencia  	:= aDadosBanco [ 3 ]
Local cConta    	:= aDadosBanco [ 4 ]
Local cCart     	:= aDadosBanco [ 6 ]
Local c_fdig1
Local c_fdig2
Local Dvag        		//Digito Verificado da agencia

cMoeda := "9"

If nValor > 0
	cValor  := strzero(nValor*100,10)
Else
	cValor  := strzero((Round((SE1->E1_SALDO+SE1->E1_ACRESC-nVlrAbat-SE1->E1_DECRESC),2))*100,10)
Endif

*----------------------------------------------------------------*
* Posição(1 a 19) padrao do Codigo de barra para todos os bancos
*----------------------------------------------------------------*

cBarra :=  cBanco                // 341                       // 3  // 001  003
cBarra +=  cMoeda                // 9                         // 1   // 004  004
cBarra +=  fator()             // 1667  (01/05/2002'        // 4   // 006  009
cBarra +=  cValor                // 0000012345 (123,45)       // 10  // 010  019


*----------------------------------------------------------------*
* Campo Livre do código de barra
*----------------------------------------------------------------*

Do Case

	Case cBanco  = "001"   //  Banco do BrASIL


		cCart          := "17/019"    // carteira chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*
		c_agctnos      := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + Substr(cCart,1,2) + cNroDoc
		c_dacacb       := DIGIT001( c_agctnos  )


		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Brasil
		*-------------------------------------------------------*
		//Tamanho       Inicio     Fim
		cBarra +=  STRZERO(Val(cNroDoc),11)	        // 11         // 020       030     Nosso numero
		cBarra +=  Substr(cAgencia ,1,4  )    	    // 04         // 031       034     agencia
		cBarra +=  PADL(Substr(cConta,1,4),8,"0" )  // 08         // 035       042     Conta
		cBarra +=  Substr(cCart,1,2      )          // 02         // 043       044     Carteira


		*-------------------------------------------------------------------------------------------*
		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco do Brasil
		*--------------------------------------------------------------------------------------------*

		cAgencia:=Substr(cAgencia ,1,4)+"-"+Substr(cAgencia ,5,1)+" /"
		cConta  :=Substr(cConta ,1,4)+"-"+Substr(cConta ,5,1)


		cDVNosso:= CALC_di9(cNroDoc)  					//Calculo do digito verificador do nosso numero
		cNosso   := Substr(cNroDoc,1,11)+"-"+cDVNosso   // Nosso numero + Digito Verificado


	Case cBanco  = '341'   // Itau

		cCart   := "109"    // chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + cCart + cNroDoc
		c_dacacb  := DIGIT001( c_agctnos  )
		cDVNosso  := c_dacacb

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Itau
		*-------------------------------------------------------*

		// Exemplo           //Tamanho   Inico     Fim
		cBarra +=  cCart  + cNroDoc + c_dacacb              		  // 109 52000072 3    //   12    // 020     031   Carteira + Nosso Numero + Digitao de cobrança
		cBarra +=  substr(cAgencia ,1,4)+Substr(cConta,1,6) 		  // 0496 327826       //   10    // 032     041   Agencia  + Conta
		cBarra +=  "000"                                                                   //   03    // 042     044



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:=cAgencia+" /"
		cConta  :=Substr(cConta ,1,5)+"-"+Substr(cConta ,6,1)

		cNosso   := cCart+"/"+cNroDoc+"-"+c_dacacb

	Case cBanco  = '347'    // sudameris

		cCart := "42"

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := DIGIT001( c_agctnos  )


		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Sudameris
		*-------------------------------------------------------*
		// Exemplo           Tamanho  Inicio   fim
		cBarra +=  substr(cAgencia ,1,4)+Substr(cConta,1,7) + c_dacacb         // 1675 1266561 1   // 12   // 020    031
		cBarra +=   PADL(Alltrim(cNroDoc),13,"0")                   		   // 0169977   	   // 13   // 032    044



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= cAgencia+" /"
		cConta  := AllTrim(cConta)+"/"+c_dacacb

		cNosso   := cNroDoc

	Case cBanco  = '237'   // Bradesco

		cCart := "02"    // chumbado

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Bradesco
		*-------------------------------------------------------*
		//Tamanho   inico  fim
		cBarra +=   substr(cAgencia ,1,4)       	// 4       // 20    23
		cBarra +=   cCart                     		// 2       // 24    25
		cBarra +=   PADL(Alltrim(cNroDoc),11,"0")  // 11      // 26    36
		cBarra +=   Substr(cConta,1,7)   	    	// 7       // 37    43
		cBarra +=   "0"                        		// 1       // 44    44



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= AllTrim(cAgencia)+" /"
		cConta	:= Alltrim(cConta)+"-P"   // Digito da Conta Chumdado conforme padrao do banco

		cDVNosso := Mod_11_2A7(cCart+Substr(cNroDoc,1,11))

		//Chumbado conforme padrao do banco
		If cDVNosso ='10'
			cDVNosso:= 'P'
		ElseIf cDVNosso ='11'
			cDVNosso:= '0'
		EndIf

		cNosso   := cCart+"/"+Substr(cNroDoc,1,11)+"-"+cDVNosso


	Case cBanco  = '422'   // Safra

		cCart    := "2"    // carteira chumbada de acordo c/ o banco

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + cCart + cNroDoc
		c_dacacb       := DIGIT001( c_agctnos  )


		//cDVNosso:= Modulo11(cNroDoc)
		cDVNosso := Mod11_422(cNroDoc)

		//If cDVNosso = '0'
		//cDVNosso:='1'
		//Endif

		//ElseIf cDVNosso = '1'
		//cDVNosso:='0'
		//EndIf

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Safra
		*-------------------------------------------------------*
		//Tamanho  Inicio  Fim
		cBarra +="7"  									  // 01  	// 20 	  20
		cBarra +=   Substr(cAgencia ,1,5)       		  // 05  	// 21	  25
		cBarra +=  PADL(Alltrim(cConta),9,"0")   		  // 09   	// 26 	  34
		cBarra +=  PADL(Alltrim(cNroDoc),8,"0")+cDVNosso  // 09  	// 35 	  43
		cBarra +=  cCart                         		  // 01  	// 44 	  44



		* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:=AllTrim(cAgencia)+"-"


		cNosso  := cNroDoc+"-"+cDVNosso

	Case cBanco  = '409'   // UNIBANCO

		cCart    := "CAUCAO"    // chumbado

		cDtVenc	:=Substr(DToC(dVencimen),7,2)+Substr(DToC(dVencimen),4,2)+SubStr(DToC(dVencimen),1,2)


		cDVNosso:= Modulo11(cNroDoc)
		cDVNoss1:=Modulo11("1"+cNroDoc+cDVNosso)

		//If cDVNosso = '10' .or. cDVNosso = '0'
		//cDVNosso:='0'
		//EndIf

		*-------------------------------------------------------*
		*Campo Livre do codigo de barra do UNIBANCO
		*-------------------------------------------------------*
		cBarra +="04"   															// 2  // 20  21    Codigo  p/ transacao CVT
		cBarra += cDtVenc 		        											// 6  // 22  27    Data de vencimento
		cBarra += Right(AllTrim(cAgencia),4)+Modulo11(Right(AllTrim(cAgencia),4)) 	// 5  // 28  32    Agencia + DV
		cBarra += PADL(Alltrim(cNroDoc),10,"0")+cDVNosso		  					// 11 // 33  43    Nosso Numero + DV
		cBarra += cDVNoss1															// 01 // 44  44    Super Dígito



		* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


		Dvag :=Modulo11(Right(AllTrim(cAgencia),4))
		Dvag := IIf(Dvag = '0' .Or. Dvag = '1' .Or. Dvag = '10', "0", str(Dvag))

		cAgencia:= Right(AllTrim(cAgencia),4)+"-"+Dvag          		  // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:=Substr(cConta,1,6)+" "+Substr(cConta,7,1)   // Digito da Conta Chumdado conforme padrao do banco

		cNosso :="1/"+cNroDoc+"-"+cDVNosso+"/"+cDVNoss1


	Case cBanco  $ "356*033"   // Real    /

		//cCart    := "42"    // chumbado
		cCart    := "COB"    // chumbado
//		cCart    := SEE->EE_CARTEIR    // Vitor Duarte 06/06/2013

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := DIGIT001( c_agctnos  )



		*-------------------------------------------------------*
		*Campo Livre do codigo de barra do banco do Real
		*-------------------------------------------------------*

		DbSelectArea("SA6")
		DbSetOrder(1)
		DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.T.)

		cCedent := AllTrim( GetNewPar( "MV_XCEDESA", "0000" ) )  //SA6->A6_XCEDENT
		cBarra += "9"
		//cBarra += cCedent
		cBarra += PadL( Val( Left( aDadosBanco[04], 04 ) ), 04 )

		//cBarra +=  Substr(cAgencia  ,1,4)    		// 04  // 20  23    Numero cliente
		//cBarra +=  Substr(cConta    ,1,7)			// 07  // 24  30    Vago
		//cBarra +=  c_dacacb    		    			// 01  // 31  31    Digitao de cobranca
		cBarra +=  PadL( Alltrim( cNroDoc ), 13, "0" )   	// 13  // 32  44    Nosso Numero



		* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


		cNosso := cNroDoc

		cAgencia:= AllTrim(cAgencia)+"/"           // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:= Alltrim(cConta)+"/"+c_dacacb    // Digito da Conta Chumdado conforme padrao do banco


	Case cBanco  = "041"  	   // Banrisul

		cCart    := "COBR."    // chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Right(Alltrim(cAgencia) , 3 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := DIGIT001( c_agctnos  )

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Banrisul
		*-------------------------------------------------------*
		cBarra += "2"    						  	// 01  // 20  20    Constante, identifica o produto
		cBarra += "1"    					     	// 01  // 21  21    Constante, Carteira.
		cBarra += Right(Alltrim(cAgencia) , 3 )    	// 03  // 22  24    Agencia do banco
		cBarra += Substr(cConta    ,1,6)+"0"	    // 07  // 25  31    Vago
		cBarra += PADL(Alltrim(cNroDoc),8 ,"0")    // 08  // 32  39    Nosso Numero
		cBarra += "041"              				// 03  // 40  42    Codigo do banco

		//Calcula o Digito verificador do codigo de Barra da posicao 42  e 43
		c_campo := Substr(cBarra,19,23)
		c_fdig1  := DIGIT001(c_campo)
		c_fdig2  := Mod_11_2A7(c_campo+c_fdig1)


		//If c_fdig1  = '9'
		//c_fdig1  := '0'
		//c_fdig2  := Mod_11_2A7(c_campo+c_fdig1)
		//Endif

		//If c_fdig2  = '10'
		//c_fdig1 :=soma1(c_fdig1)
		//c_fdig2  := Mod_11_2A7(c_campo+c_fdig1)
		//EndIf


		if c_fdig2  = '10'
			c_fdig1 :=If(soma1(c_fdig1)='A','0',soma1(c_fdig1))
			c_fdig2  := Mod_11_2A7(c_campo+c_fdig1)
		EndIf


		cBarra +=   c_fdig1 + c_fdig2   	// 02 // 43  44     Modulo10(codBarra19-41) +Modulo11(codbarra 19-41)



		* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= Right(Alltrim(cAgencia) , 3 )+".46" // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:= Substr(Alltrim(cConta),1,6)+".0.38"  // Digito da Conta Chumdado conforme padrao do banco

		// Calculo do DV do nosso numero de acordo c/ o banco
		c_fdig1  := DIGIT001(Substr(cNroDoc,1,8))
		c_fdig2  := Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)

		//If c_fdig1  = '9'
		//c_fdig1  := '0'
		//c_fdig2  := Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		//Endif

		//If c_fdig2  = '10'
		//c_fdig1 := soma1(c_fdig1)
		//c_fdig2  := Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		//EndIf

		If c_fdig2  = '10'
			c_fdig1 :=If(soma1(c_fdig1)='A','0',soma1(c_fdig1))
			c_fdig2  := Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		EndIf

		cDVNosso := c_fdig1 + c_fdig2
		cNosso 	 :=Substr(cNroDoc,1,8)+"-"+cDVNosso

EndCase

cBarra += "0"  //IOF - Seguradoras - Demais clientes = 0(Zero)
cBarra += "101" //Cobrança simples

c_dig := CalcBar(cBarra)
//Incrementa o DAC na quinta posicao do codigo ded barra
cBarra  := substr(cBarra , 1 , 4) + cValToChar(c_dig)  + substr(cBarra , 5 ,44 )


* Calculo da linha digitavel



*-------------------------------------------------------*
* Parte 1   BBBMN.NNNNN
*-------------------------------------------------------*

cParte1   := substr(cBarra , 1 , 4 ) + substr ( cBarra  , 20 , 5 )
// itau := cBanco   +  cMoeda     + cCart + Substr(cNroDoc , 1 , 2 )
cDig1    := DIGIT001( cParte1 )

*-------------------------------------------------------*
* Parte 2   NNNNN.NDNNNN
*-------------------------------------------------------*


cParte2   := substr(cBarra , 25 , 6 ) + substr ( cBarra  , 31 , 1 ) + substr ( cBarra  , 32 , 3 )
// itau  := Substr(cNroDoc , 3 , 6 )   + c_dacacb                     + substr(cAgencia , 1 , 3 )
cDig2    := DIGIT001( cParte2 )


*-------------------------------------------------------*
* Parte 3  NNNNN.NNNNNN
*-------------------------------------------------------*

cParte3   :=  substr(cBarra , 35 , 1 ) + substr ( cBarra  , 36 , 6 ) + substr ( cBarra  , 42 , 3 )
// itau   :=  substr(cAgencia , 4 , 1 )  + Substr(cConta , 1 , 6 )  + "000"
cDig3    := DIGIT001( cParte3 )

*-------------------------------------------------------*
* Parte 4  X
*-------------------------------------------------------*

cParte4    := Transform(c_dig, "@E 9")
// substr(cBarra , 5 , 1 )


*-------------------------------------------------------*
* Parte 5   DDDDVVVVVVVVVV
*-------------------------------------------------------*
cParte5    := substr(cBarra , 6 , 4 )      + substr(cBarra , 10 , 10 )
// itau  fator()                   +  cValor


cDigital := substr(cParte1,1,5)+"."+substr(cparte1,6,4)+Transform(cDig1," @E 9")+"  "+;
substr(cParte2,1,5)+"."+substr(cparte2,6,5)+Transform(cDig2," @E 9")+"  "+;
substr(cParte3,1,5)+"."+substr(cparte3,6,5)+Transform(cDig3," @E 9")+"  "+;
cParte4+" "+cParte5

Aadd(aRet,   cBarra)
Aadd(aRet, cDigital)
Aadd(aRet,   cNosso)
Aadd(aRet,    cCart)
Aadd(aRet, cAgencia)
Aadd(aRet,   cConta)
Aadd(aRet, cDVNosso)


RestArea(aArea)

Return aRet
*/

*-----------------------------------------------------*
Static function Mod11_422(c_num)
	*-----------------------------------------------------*
	* Funcao para calcular o modulo 11  para o bando 422
	*-----------------------------------------------------*
	Local n_acum := 0
	Local n_rest
	Local c_ret  , n_ret
	n_acum += Val(Substr(c_num , 1 , 1 )) * 9
	n_acum += Val(Substr(c_num , 2 , 1 )) * 8
	n_acum += Val(Substr(c_num , 3 , 1 )) * 7
	n_acum += Val(Substr(c_num , 4 , 1 )) * 6
	n_acum += Val(Substr(c_num , 5 , 1 )) * 5
	n_acum += Val(Substr(c_num , 6 , 1 )) * 4
	n_acum += Val(Substr(c_num , 7 , 1 )) * 3
	n_acum += Val(Substr(c_num , 8 , 1 )) * 2

	n_rest := (  n_acum % 11 )
	If n_rest = 0
		n_ret :=  1
	ElseIf n_rest = 1
		n_ret :=  0
	Else
		n_ret := 11 - n_rest
	Endif

	c_ret :=  str( n_ret , 1  , 0 )


Return ( c_ret)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CalcBar   ºAutor  ³Microsiga           º Data ³  03/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

STATIC FUNCTION CalcBar(cData)

	Local aArea	:= GetArea()
	Local L, D, P := 0

	L := Len(cdata)
	D := 0
	P := 1


	While L > 0
		P := P + 1
		D := D + (Val(SubStr(cData, L, 1)) * P)
		If P = 9
			P := 1
		EndIf
		L := L - 1
	EndDo

	D := 11 - (mod(D,11))

	If (D == 0 .Or. D == 1 .Or. D == 10 .Or. D == 11)
		D := 1
	EndIf

	RestArea(aArea)

Return (D)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³FATOR		ºAutor  ³Angelo Henrique                  º Data ³  04/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calculo do FATOR  de vencimento para linha digitavel e codigo de Barras. º±±
±±º          ³                                                            			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BOLETOS                                                    			   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static function Fator()
	//If Len(ALLTRIM(SUBSTR(DTOC(SE1->E1_VENCTO),7,4))) = 4
	If Len(ALLTRIM(SUBSTR(DTOC(SE1->E1_VENCREA),7,4))) = 4
		//cData := SUBSTR(DTOC(SE1->E1_VENCTO),7,4)+SUBSTR(DTOC(SE1->E1_VENCTO),4,2)+SUBSTR(DTOC(SE1->E1_VENCTO),1,2)
		cData := SUBSTR(DTOC(SE1->E1_VENCREA),7,4)+SUBSTR(DTOC(SE1->E1_VENCREA),4,2)+SUBSTR(DTOC(SE1->E1_VENCREA),1,2)
	Else
		//cData := "20"+SUBSTR(DTOC(SE1->E1_VENCTO),7,2)+SUBSTR(DTOC(SE1->E1_VENCTO),4,2)+SUBSTR(DTOC(SE1->E1_VENCTO),1,2)
		cData := "20"+SUBSTR(DTOC(SE1->E1_VENCREA),7,2)+SUBSTR(DTOC(SE1->E1_VENCREA),4,2)+SUBSTR(DTOC(SE1->E1_VENCREA),1,2)
	EndIf
	cFator := STR((STOD(cData)-STOD("19971007")),4)
Return(cFator)


/****************************************


****************************************/
Static Function DIGIT001(cVariavel)
	Local Auxi := 0, sumdig := 0

	cbase  := cVariavel
	lbase  := LEN(cBase)
	umdois := 2
	sumdig := 0
	Auxi   := 0
	iDig   := lBase
	While iDig >= 1
		auxi   := Val(SubStr(cBase, idig, 1)) * umdois
		sumdig := SumDig+If (auxi < 10, auxi, (auxi-9))
		umdois := 3 - umdois
		iDig:=iDig-1
	EndDo
	cValor:=Mod(sumdig,10)
	auxi  := 10 - cValor

	If auxi >= 10
		auxi := 0
	EndIf
Return(str(auxi,1,0))


*-------------------------------------------------------------------------*
Static Function Mod_11_2A7(c_cod)
	*-------------------------------------------------------------------------*
	* função para calcular o modulo 11 com peso de e a 7
	*-------------------------------------------------------------------------*

	Local c_car     :=  alltrim(c_cod)
	Local n_tam     :=  len(c_car)
	Local n_a
	Local n_aglut   := 0
	Local n_var
	Local l_2       := .T.
	Local n_ret
	Local n_tre     := 0
	Local c_tre
	Local n_fator   := 2


	For  n_a := 1 to n_tam

		n_var   :=  substr( c_car  , ( n_tam - n_a  + 1 )   , 1 )
		n_var   := Val (n_var )

		If n_fator > 7
			n_fator := 2
		Endif

		n_tre := n_fator   *  n_var
		n_fator++

		n_aglut += n_tre

	Next

	n_ret := mod(n_aglut  , 11 )

	n_ret := If( n_ret=0, 0, 11 - n_ret )

	n_ret := alltrim(str(n_ret , 2 , 0 ) )

Return ( n_ret )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³CALC_di9  ºAutor  ³Angelo Henrique     º Data ³  05/03/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Para calculo do nosso numero do banco santander             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BOLETOS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CALC_di9(cVariavel)
	Local Auxi := 0, sumdig := 0

	cbase  := cVariavel
	lbase  := LEN(cBase)
	base   := 9
	sumdig := 0
	Auxi   := 0
	iDig   := lBase
	While iDig >= 1
		If base == 1
			base := 9
		EndIf
		auxi   := Val(SubStr(cBase, idig, 1)) * base
		sumdig := SumDig+auxi
		base   := base - 1
		iDig   := iDig-1
	EndDo
	auxi := mod(Sumdig,11)
	If auxi == 10
		auxi := "X"
	Else
		auxi := str(auxi,1,0)
	EndIf
Return(auxi)


Static Function Ret_cBarra(	cPrefixo,cNumero,cParcela,cTipo  ,aDadosBanco   ,cNroDoc  ,nValor, dVencimen )

	Local aArea			:= GetArea()
	Local cNosso		:= ""
	Local cDVNosso		:= ""
	Local cDVNoss1		:= ""
	Local NNUM			:= ""
	Local cCampoL		:= ""
	Local cFatorValor	:= ""
	Local cLivre		:= ""
	Local cDigBarra		:= ""
	Local cBarra		:= ""
	Local cParte1		:= ""
	Local cDig1			:= ""
	Local cParte2		:= ""
	Local cDig2			:= ""
	Local cParte3		:= ""
	Local cDig3			:= ""
	Local cParte4		:= ""
	Local cParte5		:= ""
	Local cDigital		:= ""
	Local cDtVenc		:= ""
	Local aRet			:= {}
	Local cBanco    	:= aDadosBanco [ 1 ]
	Local cAgencia  	:= aDadosBanco [ 3 ]
	Local cConta    	:= aDadosBanco [ 4 ]
	Local cCart     	:= aDadosBanco [ 6 ]
	Local c_fdig1
	Local c_fdig2
	Local Dvag        		//Digito Verificado da agencia

	cMoeda := "9"

	If nValor > 0
		cValor  := strzero(nValor*100,10)
	Else
		cValor  := strzero((Round((SE1->E1_SALDO+SE1->E1_ACRESC-nVlrAbat-SE1->E1_DECRESC),2))*100,10)
	Endif

	*----------------------------------------------------------------*
	* Posição(1 a 19) padrao do Codigo de barra para todos os bancos
	*----------------------------------------------------------------*

	cBarra :=  cBanco                // 341                       // 3  // 001  003
	cBarra +=  cMoeda                // 9                         // 1   // 004  004
	cBarra +=  u_fator()             // 1667  (01/05/2002'        // 4   // 006  009
	cBarra +=  cValor                // 0000012345 (123,45)       // 10  // 010  019


	*----------------------------------------------------------------*
	* Campo Livre do código de barra
	*----------------------------------------------------------------*

	Do Case
		/*
	Case cBanco  = "001"   //  Banco do BrASIL


		cCart          := "17/019"    // carteira chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*
		c_agctnos      := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + Substr(cCart,1,2) + cNroDoc
		c_dacacb       := U_DIGIT001( c_agctnos  )


		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Brasil
		*-------------------------------------------------------*
		//Tamanho       Inicio     Fim
		cBarra +=  STRZERO(Val(cNroDoc),11)	        // 11         // 020       030     Nosso numero
		cBarra +=  Substr(cAgencia ,1,4  )    	    // 04         // 031       034     agencia
		cBarra +=  PADL(Substr(cConta,1,4),8,"0" )  // 08         // 035       042     Conta
		cBarra +=  Substr(cCart,1,2      )          // 02         // 043       044     Carteira


		*-------------------------------------------------------------------------------------------*
		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco do Brasil
		*--------------------------------------------------------------------------------------------*

		cAgencia:=Substr(cAgencia ,1,4)+"-"+Substr(cAgencia ,5,1)+" /"
		cConta  :=Substr(cConta ,1,4)+"-"+Substr(cConta ,5,1)


		cDVNosso:= U_CALC_di9(cNroDoc)  					//Calculo do digito verificador do nosso numero
		cNosso   := Substr(cNroDoc,1,11)+"-"+cDVNosso   // Nosso numero + Digito Verificado


	Case cBanco  = '341'   // Itau

		cCart   := "109"    // chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + cCart + cNroDoc
		c_dacacb  := U_DIGIT001( c_agctnos  )
		cDVNosso  := c_dacacb

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Itau
		*-------------------------------------------------------*

		// Exemplo           //Tamanho   Inico     Fim
		cBarra +=  cCart  + cNroDoc + c_dacacb              		  // 109 52000072 3    //   12    // 020     031   Carteira + Nosso Numero + Digitao de cobrança
		cBarra +=  substr(cAgencia ,1,4)+Substr(cConta,1,6) 		  // 0496 327826       //   10    // 032     041   Agencia  + Conta
		cBarra +=  "000"                                                                   //   03    // 042     044



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:=cAgencia+" /"
		cConta  :=Substr(cConta ,1,5)+"-"+Substr(cConta ,6,1)

		cNosso   := cCart+"/"+cNroDoc+"-"+c_dacacb

	Case cBanco  = '347'    // sudameris

		cCart := "42"

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := U_DIGIT001( c_agctnos  )


		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Sudameris
		*-------------------------------------------------------*
		// Exemplo           Tamanho  Inicio   fim
		cBarra +=  substr(cAgencia ,1,4)+Substr(cConta,1,7) + c_dacacb         // 1675 1266561 1   // 12   // 020    031
		cBarra +=   PADL(Alltrim(cNroDoc),13,"0")                   		   // 0169977   	   // 13   // 032    044



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= cAgencia+" /"
		cConta  := AllTrim(cConta)+"/"+c_dacacb

		cNosso   := cNroDoc

	Case cBanco  = '237'   // Bradesco

		cCart := "02"    // chumbado

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Bradesco
		*-------------------------------------------------------*
		//Tamanho   inico  fim
		cBarra +=   substr(cAgencia ,1,4)       	// 4       // 20    23
		cBarra +=   cCart                     		// 2       // 24    25
		cBarra +=   PADL(Alltrim(cNroDoc),11,"0")  // 11      // 26    36
		cBarra +=   Substr(cConta,1,7)   	    	// 7       // 37    43
		cBarra +=   "0"                        		// 1       // 44    44



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= AllTrim(cAgencia)+" /"
		cConta	:= Alltrim(cConta)+"-P"   // Digito da Conta Chumdado conforme padrao do banco

		cDVNosso := u_Mod_11_2A7(cCart+Substr(cNroDoc,1,11))

		//Chumbado conforme padrao do banco
		If cDVNosso ='10'
			cDVNosso:= 'P'
		ElseIf cDVNosso ='11'
			cDVNosso:= '0'
		EndIf

		cNosso   := cCart+"/"+Substr(cNroDoc,1,11)+"-"+cDVNosso


	Case cBanco  = '422'   // Safra

		cCart    := "2"    // carteira chumbada de acordo c/ o banco

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + cCart + cNroDoc
		c_dacacb       := U_DIGIT001( c_agctnos  )


		//cDVNosso:= Modulo11(cNroDoc)
		cDVNosso := Mod11_422(cNroDoc)

		//If cDVNosso = '0'
		//cDVNosso:='1'
		//Endif


		//ElseIf cDVNosso = '1'
		//cDVNosso:='0'
		//EndIf


		//-------------------------------------------------------
		// Campo Livre do codigo de barra do banco do Safra
		//-------------------------------------------------------
		//Tamanho  Inicio  Fim
		cBarra +="7"  									  // 01  	// 20 	  20
		cBarra +=   Substr(cAgencia ,1,5)       		  // 05  	// 21	  25
		cBarra +=  PADL(Alltrim(cConta),9,"0")   		  // 09   	// 26 	  34
		cBarra +=  PADL(Alltrim(cNroDoc),8,"0")+cDVNosso  // 09  	// 35 	  43
		cBarra +=  cCart                         		  // 01  	// 44 	  44


		//---------------------------------------------------------------------------------
		// Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco
		//---------------------------------------------------------------------------------

		cAgencia:=AllTrim(cAgencia)+"-"


		cNosso  := cNroDoc+"-"+cDVNosso

	Case cBanco  = '409'   // UNIBANCO

		cCart    := "CAUCAO"    // chumbado

		cDtVenc	:=Substr(DToC(dVencimen),7,2)+Substr(DToC(dVencimen),4,2)+SubStr(DToC(dVencimen),1,2)


		cDVNosso:= Modulo11(cNroDoc)
		cDVNoss1:=Modulo11("1"+cNroDoc+cDVNosso)


		//If cDVNosso = '10' .or. cDVNosso = '0'
		//cDVNosso:='0'
		//EndIf

		//-------------------------------------------------------*
		//Campo Livre do codigo de barra do UNIBANCO
		//-------------------------------------------------------*
		cBarra +="04"   															// 2  // 20  21    Codigo  p/ transacao CVT
		cBarra += cDtVenc 		        											// 6  // 22  27    Data de vencimento
		cBarra += Right(AllTrim(cAgencia),4)+Modulo11(Right(AllTrim(cAgencia),4)) 	// 5  // 28  32    Agencia + DV
		cBarra += PADL(Alltrim(cNroDoc),10,"0")+cDVNosso		  					// 11 // 33  43    Nosso Numero + DV
		cBarra += cDVNoss1															// 01 // 44  44    Super Dígito


		//---------------------------------------------------------------------------------*
		// Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco
		//--------------------------------------------------------------------------------*

		Dvag :=Modulo11(Right(AllTrim(cAgencia),4))
		Dvag := IIf(Dvag = '0' .Or. Dvag = '1' .Or. Dvag = '10', "0", str(Dvag))

		cAgencia:= Right(AllTrim(cAgencia),4)+"-"+Dvag          		  // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:=Substr(cConta,1,6)+" "+Substr(cConta,7,1)   // Digito da Conta Chumdado conforme padrao do banco

		cNosso :="1/"+cNroDoc+"-"+cDVNosso+"/"+cDVNoss1

		*/
		Case cBanco  $ "356*033"   // Real    /

			//cCart    := "42"
			cCart    := "COB"
			//		cCart    := SEE->EE_CARTEIR    // Vitor Duarte 06/06/2013

			*-------------------------------------------------------*
			* Calculo do Digitao de cobrança
			*-------------------------------------------------------*

			c_agctnos      := cNroDoc  + Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 7 )
			c_dacacb       := U_DIGIT001( c_agctnos  )



			*-------------------------------------------------------*
			*Campo Livre do codigo de barra do banco do Real
			*-------------------------------------------------------*
			//aqui
			DbSelectArea("SA6")
			//		DbSetOrder(1)
			//		DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.T.)

			cCedent := SA6->A6_XCEDENT
			//cCedent   := PadL( Right( aDadosBanco[04], 07 ), 07, "0" )

			cBarra += "9"
			cBarra += cCedent
			//cBarra +=  Substr(cAgencia  ,1,4)    		// 04  // 20  23    Numero cliente
			//cBarra +=  Substr(cConta    ,1,7)			// 07  // 24  30    Vago
			//cBarra +=  c_dacacb    		    			// 01  // 31  31    Digitao de cobranca
			cBarra +=  PADL(Alltrim(cNroDoc),13,"0")   	// 13  // 32  44    Nosso Numero



			* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


			cNosso :=cNroDoc

			cAgencia:= AllTrim(cAgencia)+"/"           // Digito da Agencia Chumdado conforme padrao do banco
			cConta	:= Alltrim(cConta)+"/"+c_dacacb    // Digito da Conta Chumdado conforme padrao do banco

			/*
	Case cBanco  = "041"  	   // Banrisul

		cCart    := "COBR."    // chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Right(Alltrim(cAgencia) , 3 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := U_DIGIT001( c_agctnos  )

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Banrisul
		*-------------------------------------------------------*
		cBarra += "2"    						  	// 01  // 20  20    Constante, identifica o produto
		cBarra += "1"    					     	// 01  // 21  21    Constante, Carteira.
		cBarra += Right(Alltrim(cAgencia) , 3 )    	// 03  // 22  24    Agencia do banco
		cBarra += Substr(cConta    ,1,6)+"0"	    // 07  // 25  31    Vago
		cBarra += PADL(Alltrim(cNroDoc),8 ,"0")    // 08  // 32  39    Nosso Numero
		cBarra += "041"              				// 03  // 40  42    Codigo do banco

		//Calcula o Digito verificador do codigo de Barra da posicao 42  e 43
		c_campo := Substr(cBarra,19,23)
		c_fdig1  := U_DIGIT001(c_campo)
		c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)


		//If c_fdig1  = '9'
		//c_fdig1  := '0'
		//c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)
		//Endif

		//If c_fdig2  = '10'
		//c_fdig1 :=soma1(c_fdig1)
		//c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)
		//EndIf

		if c_fdig2  = '10'
			c_fdig1 :=If(soma1(c_fdig1)='A','0',soma1(c_fdig1))
			c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)
		EndIf


		cBarra +=   c_fdig1 + c_fdig2   	// 02 // 43  44     Modulo10(codBarra19-41) +Modulo11(codbarra 19-41)



		* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= Right(Alltrim(cAgencia) , 3 )+".46" // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:= Substr(Alltrim(cConta),1,6)+".0.38"  // Digito da Conta Chumdado conforme padrao do banco

		// Calculo do DV do nosso numero de acordo c/ o banco
		c_fdig1  := U_DIGIT001(Substr(cNroDoc,1,8))
		c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)


		//If c_fdig1  = '9'
		//c_fdig1  := '0'
		//c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		//Endif

		//If c_fdig2  = '10'
		//c_fdig1 := soma1(c_fdig1)
		//c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		//EndIf

		If c_fdig2  = '10'
			c_fdig1 :=If(soma1(c_fdig1)='A','0',soma1(c_fdig1))
			c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		EndIf

		cDVNosso := c_fdig1 + c_fdig2
		cNosso 	 :=Substr(cNroDoc,1,8)+"-"+cDVNosso
			*/
	EndCase

	//c_dig  := U_CALC_5p(cBarra)

	cBarra += "0"  //IOF - Seguradoras - Demais clientes = 0(Zero)
	cBarra += "101" //102 - Cobrança simples

	c_dig := CalcBar(cBarra)
	//Incrementa o DAC na quinta posicao do codigo ded barra
	cBarra  := substr(cBarra , 1 , 4) + cValToChar(c_dig)  + substr(cBarra , 5 ,44 )


	* Calculo da linha digitavel


	*-------------------------------------------------------*
	* Parte 1   BBBMN.NNNNN
	*-------------------------------------------------------*

	cParte1   := substr(cBarra , 1 , 4 ) + substr ( cBarra  , 20 , 5 )
	// itau := cBanco   +  cMoeda     + cCart + Substr(cNroDoc , 1 , 2 )
	cDig1    := U_DIGIT001( cParte1 )

	*-------------------------------------------------------*
	* Parte 2   NNNNN.NDNNNN
	*-------------------------------------------------------*


	cParte2   := substr(cBarra , 25 , 6 ) + substr ( cBarra  , 31 , 1 ) + substr ( cBarra  , 32 , 3 )
	// itau  := Substr(cNroDoc , 3 , 6 )   + c_dacacb                     + substr(cAgencia , 1 , 3 )
	cDig2    := U_DIGIT001( cParte2 )


	*-------------------------------------------------------*
	* Parte 3  NNNNN.NNNNNN
	*-------------------------------------------------------*

	cParte3   :=  substr(cBarra , 35 , 1 ) + substr ( cBarra  , 36 , 6 ) + substr ( cBarra  , 42 , 3 )
	// itau   :=  substr(cAgencia , 4 , 1 )  + Substr(cConta , 1 , 6 )  + "000"
	cDig3    := U_DIGIT001( cParte3 )

	*-------------------------------------------------------*
	* Parte 4  X
	*-------------------------------------------------------*

	cParte4    := Transform(c_dig, "@E 9")
	// substr(cBarra , 5 , 1 )


	*-------------------------------------------------------*
	* Parte 5   DDDDVVVVVVVVVV
	*-------------------------------------------------------*
	cParte5    := substr(cBarra , 6 , 4 )      + substr(cBarra , 10 , 10 )
	// itau  u_fator()                   +  cValor


	cDigital := substr(cParte1,1,5)+"."+substr(cparte1,6,4)+Transform(cDig1," @E 9")+"  "+;
		substr(cParte2,1,5)+"."+substr(cparte2,6,5)+Transform(cDig2," @E 9")+"  "+;
		substr(cParte3,1,5)+"."+substr(cparte3,6,5)+Transform(cDig3," @E 9")+"  "+;
		cParte4+" "+cParte5

	Aadd(aRet,   cBarra)
	Aadd(aRet, cDigital)
	Aadd(aRet,   cNosso)
	Aadd(aRet,    cCart)
	Aadd(aRet, cAgencia)
	Aadd(aRet,   cConta)
	Aadd(aRet, cDVNosso)


	RestArea(aArea)

Return aRet

User function Fator()
	If Len(ALLTRIM(SUBSTR(DTOC(SE1->E1_VENCTO),7,4))) = 4
		cData := SUBSTR(DTOC(SE1->E1_VENCTO),7,4)+SUBSTR(DTOC(SE1->E1_VENCTO),4,2)+SUBSTR(DTOC(SE1->E1_VENCTO),1,2)
	Else
		cData := "20"+SUBSTR(DTOC(SE1->E1_VENCTO),7,2)+SUBSTR(DTOC(SE1->E1_VENCTO),4,2)+SUBSTR(DTOC(SE1->E1_VENCTO),1,2)
	EndIf
	//cFator := STR(1000+(STOD(cData)-STOD("20000703")),4)
	cFator := STR((STOD(cData)-STOD("19971007")),4)
	//cFator := STR(1000+(SE1->E1_VENCREA-STOD("20000703")),4)
Return(cFator)

User Function DIGIT001(cVariavel)
	Local Auxi := 0, sumdig := 0

	cbase  := cVariavel
	lbase  := LEN(cBase)
	umdois := 2
	sumdig := 0
	Auxi   := 0
	iDig   := lBase
	While iDig >= 1
		auxi   := Val(SubStr(cBase, idig, 1)) * umdois
		sumdig := SumDig+If (auxi < 10, auxi, (auxi-9))
		umdois := 3 - umdois
		iDig:=iDig-1
	EndDo
	cValor:=Mod(sumdig,10)
	auxi  := 10 - cValor

	If auxi >= 10
		auxi := 0
	EndIf
Return(str(auxi,1,0))


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
