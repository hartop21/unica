#Include "TOTVS.ch"
#Include "RwMake.ch"
#Include "FileIo.ch"
#Include "TopConn.ch"


/*/{Protheus.doc} UNIR008

@project Relatrio de Mapa de Separao
@modulo SIGAACD
@type Relatrio
@description Relatrio de Mapa de Separao
@author Rafael Rezende
@since 25/08/2019
@version 1.0

@obs Necessrio mapear a impressora como LPT2
	 NET USE LPT1 "\\BON1146\ELGIN PRODUTOS" /PERSISTENT:YES

@return

@see www.thebestconsulting.com.br/
/*/

*----------------------------------------------------------*
User Function UNIR008( cParamAlias, nParamRecNo, nParamOpc )
	*----------------------------------------------------------*
	Local oFontProc     := Nil
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cTitulo       := "Mapa de Separao"
	Local cTexto        := "<font color='red'> Relatrio de Mapa de Separao </font><br> Esta rotina tem como objetivo realizar a Impresso do relatrio de Mapa de Separao. Selecione a Ordem de Separao desejada e confirme a impresso"
	Private cPerg       := "UNIR008X"
	Private lSchedule 	:= IsBlind()
	Private nAuxOpc     := nParamOpc

	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )

	oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
	oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
	oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
	oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
	oSayTexto := TSay():New( 016, 014, { || cTexto }   , oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
	oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnParam := TButton():New( 092, 083, "&Parmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oDlgProc:Activate( ,,,.T. )

	If lConfirmou
		MsgRun( "Filtrando os Pedidos, aguarde...", "Filtrando os Pedidos, aguarde...", { || FImprime() } )
	EndIf

Return


Static Function FVldParametros()

	Local lRetVld := .T.

	If Alltrim( MV_PAR02 ) == ""
		Aviso( "Ateno", "O Parmetro [ At o Pedido ? ]  obrigatrio.", { "Voltar" } )
		lRetVld := .F.
	EndIf

	If lRetVld .And. Alltrim( MV_PAR05 ) == ""
		Aviso( "Ateno", "O Parmetro [ At o Cliente ? ]  obrigatrio.", { "Voltar" } )
		lRetVld := .F.
	EndIf

	If lRetVld .And. Alltrim( MV_PAR06 ) == ""
		Aviso( "Ateno", "O Parmetro [ At a Loja ? ]  obrigatrio.", { "Voltar" } )
		lRetVld := .F.
	EndIf

	If lRetVld .And. Alltrim( MV_PAR08 ) == ""
		Aviso( "Ateno", "O Parmetro [ At a Transportadora ? ]  obrigatrio.", { "Voltar" } )
		lRetVld := .F.
	EndIf

	If lRetVld .And. Alltrim( MV_PAR10 ) == ""
		Aviso( "Ateno", "O Parmetro [ At a UF Destino ? ]  obrigatrio.", { "Voltar" } )
		lRetVld := .F.
	EndIf

	If lRetVld .And. Empty( MV_PAR12 )
		Aviso( "Ateno", "O Parmetro [ At a Emisso ? ]  obrigatrio.", { "Voltar" } )
		lRetVld := .F.
	EndIf

	//If lRetVld .And. Empty( MV_PAR14 )
	//	Aviso( "Ateno", "O Parmetro [ At o Status ? ]  obrigatrio.", { "Voltar" } )
	//	lRetVld := .F.
	//EndIf

Return lRetVld



Static Function FImprime()


	Private nPosMarcado			:= 01
	Private nPosFilial			:= 02
	Private nPosPedido			:= 03
	Private nPosData			:= 04
	Private nPosTransp			:= 05
	Private nPosRazao			:= 06
	Private nPosBairro			:= 07
	Private nPosUF				:= 08
	Private nPosCliente			:= 09
	Private nPosLoja			:= 10
	Private nPosNome			:= 11
	Private nPosRecNo			:= 12
	Private oOk       			:= LoadBitmap( GetResources() , "LBOK" ) // Marcado
	Private oNo       			:= LoadBitmap( GetResources() , "LBNO" ) // Desmarcado
	Private lMarcaDesmarca		:= .T.
	Private bLinesPedidos		:= { ||  }
	Private aListPedidos 		:= {}

	If !FFilPedidos()
		Return
	EndIf

	If Len( aListPedidos ) == 0

		Aviso( "Ateno", "No encontrou Pedidos para Imprimir.", { "Voltar" } )
		Return

	Else

		lMarcou := .F.
		For nI := 01 To Len( aListPedidos )
			If aListPedidos[nI][nPosMarcado]
				lMarcou := .T.
				Exit
			EndIf
		Next nI

	EndIf

	If !lMarcou
		Aviso( "Ateno", "Selecione pelo menos um Pedido primeiro.", { "Voltar" } )
		Return
	EndIf

	Processa( { || FProcImpressao( aListPedidos ) }, "Imprimindo Pedidos, aguarde..." )

Return

*--------------------------------------------*
Static Function FProcImpressao( aListPedidos )
	*--------------------------------------------*
	Local aAreaOld := GetArea()
	Local aAreaSC5 := SC5->( GetArea() )
	Local nY 		:= 0

	ProcRegua( Len( aListPedidos ) )
	For nY := 01 To Len( aListPedidos )

		IncProc()
		If aListPedidos[nY][nPosMarcado]

			DbSelectArea( "SC5" )
			DbSetOrder( 01 ) // C5_FILIAL + C5_NUM
			DbGoTo( aListPedidos[nY][nPosRecNo] )
			FPrintPedido()

		EndIf

	Next nY

	RestArea( aAreaSC5 )
	RestArea( aAreaOld )

Return


Static Function FPrintPedido()

	Local oPrn       := TMSPrinter():New()
	Local oPen       := TPen():New(,, 65535,)
	local oFont      := TFont():New( "Lucinda Console",,10,,.T.,,,,,.F. )
	local oFont2     := TFont():New( "Lucinda Console",,18,,.T.,,,,,.F. )
	local oFont3     := TFont():New( "Lucinda Console",,16,,.T.,,,,,.F. )
	local oFont4     := TFont():New( "Lucinda Console",,11,,.T.,,,,,.F. )
	Local nPuloLinha := 040

	//If !oPrn:IsPrinterActive()
	If nAuxOpc == 08
		oPrn:Setup()
	EndIf

	oPrn:StartPage()

	//40
	nTamColunas := 40
	nLinha 		:= 05

	//          10        20       30        40
	//01234567890123456789012345678901234567890
	// 		                     	26/08/2019
	//			                      14:06:34
	oPrn:Say( nLinha , 000, PadR( DToC( Date() ), nTamColunas )	, oFont		, 200,, 0 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 000, PadR( Time(), nTamColunas ), oFont, 400,, 0 )
	nLinha += nPuloLinha
	nLinha += nPuloLinha

	//          10        20       30        40
	//01234567890123456789012345678901234567890
	// 		  	  DISTR. UNICA RIO
	// 		  RUA AGUIAR MOREIRA, 313
	// 	    BOMSUCESSO - RIO DE JANEIRO
	// 	 CEP: 21.041-070 - TEL: 22091-1400
	oPrn:Say( nLinha , 000, PadC( Alltrim( SM0->M0_NOME   ), 21 ), oFont2, 200,, 0 )
	nLinha += nPuloLinha*3
	oPrn:Say( nLinha , 000, PadC( Alltrim( SM0->M0_ENDCOB ), nTamColunas ), oFont, 300,, 0 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 000, PadC( AllTrim( SM0->M0_BAIRCOB ) + " - " + AllTrim( SM0->M0_CIDCOB ), nTamColunas ), oFont, 200,, 0 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 000, PadC( "CEP: " + TransForm( AllTrim( SM0->M0_CEPCOB ), "@R 99.999-999" ), nTamColunas ), oFont, 200,, 0 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 000, PadC( "TEL: " + TransForm( AllTrim( SM0->M0_TEL ), "@R 99999-9999" ), nTamColunas ), oFont, 200,, 0 )

	//          10        20       30        40
	//01234567890123456789012345678901234567890
	// Data: 06/09/2019
	// Pedido: 19525
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, "Data: " + DToC( SC5->C5_EMISSAO ) , oFont3, 200,, 0 )
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, "Pedido: " + SC5->C5_NUM, oFont3, 200,, 0 )

	//          10        20       30        40
	//01234567890123456789012345678901234567890
	// Vend.: VENDEDOR SITE
	DbSelectArea( "SA3" )
	DbSetOrder( 01 )
	Seek XFilial( "SA3" ) + SC5->C5_VEND1
	If Found()
		cAuxVendedor := Left( AllTrim( SA3->A3_NOME ), 40-7 )
	Else
		cAuxVendedor := "NAO IDENTIFICADO"
	EndIf
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, Left( "Vend.: " + AllTrim( cAuxVendedor ), 24 ), oFont3, 100,, 1 )

	//          10        20       30        40
	//01234567890123456789012345678901234567890
	// Cliente: REAL DISTR UNICA RIO COM
	//          REFRIGRE EIRELLI
	// Obs.:
	DbSelectArea( "SA1" )
	DbSetOrder( 01 )
	Seek XFilial( "SA1" ) + SC5->( C5_CLIENTE + C5_LOJACLI )
	If Found()
		cAuxCliente := AllTrim( SA1->A1_NOME )
	Else
		cAuxCliente := "NAO IDENTIFICADO"
	EndIf
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, Left( "Cliente.: " + AllTrim( cAuxCliente ), 24 ), oFont3, 100,, 1 )
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, Substr( AllTrim( cAuxCliente ), 15, Len( AllTrim( cAuxCliente ) ) ), oFont3, 100,, 1 )
	nLinha += nPuloLinha+nPuloLinha

	DbSelectArea( "SA4" )
	DbSetOrder( 01 )
	Seek XFilial( "SA4" ) + SC5->C5_TRANSP
	If Found()
		cAuxTransp := AllTrim( SA4->A4_NOME )
	Else
		cAuxTransp := "NAO IDENTIFICADO"
	EndIf
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, Left( "Transp.: " + AllTrim( cAuxTransp ), 24 ), oFont3, 100,, 1 )
	nLinha += nPuloLinha+nPuloLinha
	oPrn:Say( nLinha , 00, Substr( AllTrim( cAuxTransp ), 14, Len( AllTrim( cAuxTransp ) ) ), oFont3, 100,, 1 )
	nLinha += nPuloLinha+nPuloLinha

	//          10        20       30        40
	//01234567890123456789012345678901234567890
	// ========================================
	// CODIGO	  DESCRICAO"
	// UN	  QUANT 	    ENDERECO
	// ========================================
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 00, Replicate( "=", 40 ), oFont4, 100,, 1 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 000, "CODIGO"	, oFont4, 100,, 1 )
	oPrn:Say( nLinha , 300, "DESCRIO"	, oFont4, 100,, 1 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 000, "UN"		, oFont4, 100,, 1 )
	oPrn:Say( nLinha , 090, "QUANT"		, oFont4, 100,, 1 )
	oPrn:Say( nLinha , 420, "ENDEREO"	, oFont4, 100,, 1 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 00, "COD. FORNECEDOR"	, oFont4, 100,, 1 )
	nLinha += nPuloLinha
	oPrn:Say( nLinha , 00, Replicate( "=", 40 ), oFont4, 100,, 1 )

	DbSelectArea( "SC6" )
	DbSetOrder( 01 ) // C6_FILIAL + C6_NUM + C6_ITEM
	Seek SC5->( C5_FILIAL + C5_NUM )
	If !SC6->( Eof() )

		Do While !SC6->( Eof() ) .And. ;
				AllTrim( SC6->C6_FILIAL ) == AllTrim( SC5->C5_FILIAL ) .And. ;
				AllTrim( SC6->C6_NUM    ) == AllTrim( SC5->C5_NUM    )

			/*
			DbSelectArea( "SBE" )
			DbSetOrder( 10 ) // BE_FILIAL + BE_CODPRO + BE_LOCAL + BE_LOCALIZ
			Seek XFilial( "SBE" ) + SC6->C6_PRODUTO
			If Found()
				cAuxEndereco := SBE->BE_LOCALIZ
			Else
				cAuxEndereco := "NO ENCON"
			EndIf
			*/
			//Marcelo Amaral 08/11/2019
			DbSelectArea( "SB2" )
			DbSetOrder( 1 ) // BE_FILIAL + BE_CODPRO + BE_LOCAL + BE_LOCALIZ
			Seek XFilial( "SB2" ) + SC6->C6_PRODUTO + SC6->C6_LOCAL
			If Found()
				cAuxEndereco := SB2->B2_LOCALIZ
			Else
				cAuxEndereco := "NO ENCON"
			EndIf

			DbSelectArea( "SB1" )
			DbSetOrder( 01 )
			Seek XFilial( "SB1" ) + SC6->C6_PRODUTO
			If Found()
				cAuxProduto := AllTrim( SB1->B1_DESC )
				cAuxUM		:= SB1->B1_UM
			Else
				cAuxProduto := "NAO ENCONTRADO"
				cAuxUM		:= "  "
			EndIf

			DbSelectArea( "SA5" )
			DbSetOrder( 02 ) // A5_FILIAL + A5_PRODUTO + A5_FORNECE + A5_LOJA
			SA5->( DbSeek( XFilial( "SA5" ) + SC6->C6_PRODUTO ) )
			If Found()
				cAuxComplem := AllTrim( SA5->A5_CODPRF )
			Else
				cAuxComplem := "NAO ENCONTRADO"
			EndIf

			nLinha += nPuloLinha
			oPrn:Say( nLinha , 000, SC6->C6_PRODUTO	, oFont4, 100,, 1 )
			oPrn:Say( nLinha , 300, cAuxProduto 	, oFont4, 100,, 1 )
			nLinha += nPuloLinha
			oPrn:Say( nLinha , 000, cAuxUM			, oFont, 100,, 1 )
			oPrn:Say( nLinha , 090, TransForm( SC6->C6_QTDVEN, "@E 999,999.99" )	, oFont, 100,, 1 )
			oPrn:Say( nLinha , 420, cAuxEndereco	, oFont, 100,, 1 )
			nLinha += nPuloLinha
			oPrn:Say( nLinha , 000, cAuxComplem		, oFont4, 100,, 1 )

			DbSelectArea( "SC6" )
			SC6->( DbSkip() )
		EndDo

	EndIf

	oPrn:EndPage()

	oPrn:Print()

Return


User Function UNIR008TST()


	RPCSetEnv( "01", "0101" )

	DbSelectArea( "SC5" )
	DbSetOrder( 01 )
	Seek XFilial( "SC5" ) + "000128"
	U_UNIR008()

	RPCClearEnv()

Return

*---------------------------*
Static Function FFilPedidos()
	*---------------------------*
	Local lAcao 				:= .F.

	SetPrvt("oDlgImpMap","oGrpFiltro","oBtnOk","oBtnSair","oListPedidos")

	MsgRun( "Carregando os Pedidos de Vendas, aguarde...", "Carregando os Pedidos de Vendas, aguarde...", { || FCarregaPedidos() } )

	oDlgImpMap := MSDialog():New( 138,254,638,1057,"Impresso de Mapa de Separao",,,.F.,,,,,,.T.,,,.F. )
	oGrpFiltro := TGroup():New( 004,008,233,340," Selecione os Pedidos ",oDlgImpMap,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtnOk     := TButton():New( 008,346,"Confirmar",oDlgImpMap,,044,012,,,,.T.,,"",,,,.F. )
	oBtnOk:bAction := { || lAcao := .T., oDlgImpMap:End() }

	oBtnSair   := TButton():New( 024,346,"Sair",oDlgImpMap,,044,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction := { || lAcao := .F., oDlgImpMap:End() }

	@ 015, 016 ListBox oListPedidos Fields Header "X", "FIL", "PEDIDO", "DATA", "TRANSP.", "RAZAO SOCIAL", "BAIRRO", "UF", "CLIENTE", "LOJA", "NOME" Size 316, 209 ColSizes GetTextWidth( 0, "BBB" ), GetTextWidth( 0, "BBB" ), GetTextWidth( 0, "BBBBBB" ), GetTextWidth( 0, "BBBBBB" ), GetTextWidth( 0, "BBBBB" ), GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ), GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ), GetTextWidth( 0, "BBB" ), GetTextWidth( 0, "BBBBB" ), GetTextWidth( 0, "BBB" ), GetTextWidth( 0, "BBBBBBBBBBBBBBB" ) Of oGrpFiltro Pixel
	oListPedidos:SetArray( aListPedidos )

	bLinesPedidos    := { || { If( aListPedidos[oListPedidos:nAt][nPosMarcado], oOk, oNo )   , ; 	// 01- Marcado
		AllTrim( aListPedidos[oListPedidos:nAt][nPosFilial] ) 			 , ;	// 02- Filial
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPedido] ) 			 , ;	// 03- Pedido
		DToC( aListPedidos[oListPedidos:nAt][nPosData]   ) 		 	 , ; 	// 04- Data
		AllTrim( aListPedidos[oListPedidos:nAt][nPosTransp] ) 			 , ; 	// 05- Transp
		AllTrim( aListPedidos[oListPedidos:nAt][nPosRazao]  ) 			 , ; 	// 06- Razo Social
		AllTrim( aListPedidos[oListPedidos:nAt][nPosBairro] ) 			 , ; 	// 07- Bairro Entrega
		AllTrim( aListPedidos[oListPedidos:nAt][nPosUF] 	  ) 		 	 , ; 	// 08- UF Entrega
		AllTrim( aListPedidos[oListPedidos:nAt][nPosCliente]) 		 	 , ; 	// 09- Cliente
		AllTrim( aListPedidos[oListPedidos:nAt][nPosLoja]   ) 		 	 , ; 	// 10- Loja
		AllTrim( aListPedidos[oListPedidos:nAt][nPosNome]   ) 		 	 } }    // 11- Nome Cliente
	oListPedidos:bLine			:= bLinesPedidos
	oListPedidos:bLDblClick 	:= { || FSeleciona() }
	oListPedidos:bHeaderClick 	:= { || FSelectAll() }
	oListPedidos:Refresh()

	oDlgImpMap:Activate(,,,.T.)

Return lAcao

*--------------------------*
Static Function FSeleciona()
	*--------------------------*
	Local nLinhaGrid := oListPedidos:nAt

	// Linha precisa ser maior que zero
	If nLinhaGrid == 0
		Return
	EndIf

	If Len( aListPedidos ) == 00
		Return
	EndIf

	If Len( aListPedidos ) == 01 .And. nLinhaGrid == 01
		If AllTrim( aListPedidos[nLinhaGrid][nPosPedido] ) == ""
			Return
		EndIf
	EndIf

	aListPedidos[nLinhaGrid][nPosMarcado] := !aListPedidos[nLinhaGrid][nPosMarcado]
	oListPedidos:Refresh()

Return

*--------------------------*
Static Function FSelectAll()
	*--------------------------*
	Local nY := 0

	If Len( aListPedidos ) == 00
		Return
	EndIf

	If Len( aListPedidos ) == 01
		If AllTrim( aListPedidos[01][nPosPedido] ) == ""
			Return
		EndIf
	EndIf

	lMarcaDesmarca  := !lMarcaDesmarca
	For nY := 01 To Len( aListPedidos )

		aListPedidos[nY][nPosMarcado] := !lMarcaDesmarca

	Next nY

	oListPedidos:Refresh()

Return

*-------------------------------*
Static Function FCarregaPedidos()
	*-------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local aAreaSA4 	:= SA4->( GetArea() )
	Local cAliasQry := GetNextAlias()
	Local cQuery 	:= ""

	aListPedidos 	:= {}

	cQuery := "		SELECT C5_FILIAL, C5_NUM, C5_EMISSAO, C5_TRANSP, A1_BAIRROE, A1_ESTE, A1_COD, A1_LOJA, A1_NOME, SC5.R_E_C_N_O_ AS [NUMRECSC5] "
	cQuery += "		  FROM " + RetSQLName( "SA1" ) + " SA1 (NOLOCK), "
	cQuery += "		       " + RetSQLName( "SC5" ) + " SC5 (NOLOCK)  "
	cQuery += "		 WHERE SC5.D_E_L_E_T_ 	= ' ' "
	cQuery += "		   AND SA1.D_E_L_E_T_ 	= ' ' "
	cQuery += "		   AND A1_FILIAL  	    = '" + XFilial( "SA1" ) + "' "
	//cQuery += "		   AND C5_FILIAL  	    = '" + XFilial( "SC5" ) + "' "
	cQuery += "		   AND C5_CLIENTE 		= A1_COD  "
	cQuery += "		   AND C5_LOJACLI 		= A1_LOJA "
	cQuery += "		   AND C5_NUM     BETWEEN '" + MV_PAR01 		+ "' AND '" + MV_PAR02 			+ "' "
	cQuery += "		   AND C5_CLIENTE BETWEEN '" + MV_PAR03 		+ "' AND '" + MV_PAR05 			+ "' "
	cQuery += "		   AND C5_LOJACLI BETWEEN '" + MV_PAR04 		+ "' AND '" + MV_PAR06 			+ "' "
	cQuery += "		   AND C5_TRANSP  BETWEEN '" + MV_PAR07 		+ "' AND '" + MV_PAR08 			+ "' "
	cQuery += "		   AND A1_ESTE	  BETWEEN '" + MV_PAR09 		+ "' AND '" + MV_PAR10 			+ "' "
	cQuery += "		   AND C5_EMISSAO BETWEEN '" + DToS( MV_PAR11 ) + "' AND '" + DToS( MV_PAR12 ) 	+ "' "
	If MV_PAR13 == 01
		cQuery += "		   AND LTRIM( RTRIM( C5_NOTA ) )  != '' "
	Else
		cQuery += "		   AND LTRIM( RTRIM( C5_NOTA ) )   = '' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasQry ) New
	Do While !( cAliasQry )->( Eof() )

		DbSelectArea( "SA4" )
		DbSetOrder( 01 )
		Seek XFilial( "SA4" ) + ( cAliasQry )->C5_TRANSP
		If Found()
			cAuxTransportadora := SA4->A4_NOME
		Else
			cAuxTransportadora := ""
		EndIf
		aAdd( aListPedidos,   { lMarcaDesmarca	 			, ;
			( cAliasQry )->C5_FILIAL	, ;
			( cAliasQry )->C5_NUM		, ;
			SToD( ( cAliasQry )->C5_EMISSAO ) , ;
			( cAliasQry )->C5_TRANSP	, ;
			cAuxTransportadora			, ;
			( cAliasQry )->A1_BAIRROE	, ;
			( cAliasQry )->A1_ESTE		, ;
			( cAliasQry )->A1_COD		, ;
			( cAliasQry )->A1_LOJA		, ;
			( cAliasQry )->A1_NOME		, ;
			( cAliasQry )->NUMRECSC5 	} )

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If Len( aListPedidos ) == 0

		aAdd( aListPedidos,   { lMarcaDesmarca	, ;
			""				, ;
			""				, ;
			CToD( "" ) 		, ;
			""				, ;
			""				, ;
			""				, ;
			""				, ;
			""				, ;
			""				, ;
			""				, ;
			0 				} )

	EndIf

	RestArea( aAreaSA4 )
	RestArea( aAreaAnt )

Return


User Function UNIR008C()

	Local oPrn  := TMSPrinter():New()

	oPrn:Setup()

Return
