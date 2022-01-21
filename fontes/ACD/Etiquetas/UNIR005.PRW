
/*/{Protheus.doc} UNIR005

@project Impressão de Etiquetas Térmicas ( Unica )
@description Rotina responsável pela Impressão da Etiqueta Térmica de Produto
@author Rafael Rezende
@since 20/05/2019
@version 1.0

@obs Necessário mapear a impressora como LPT3
	 NET USE LPT3 \\UNICA1056\ZEBRAESTOQUE /PERSISTENT:YES

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "RwMake.ch"
#Include "FileIo.ch"
#Include "TopConn.ch"

*---------------------*
User Function UNIR005()
	*---------------------*
	Local oFontProc     := Nil
	Local oDlgProc      := Nil
	Local oGrpTexto     := Nil
	Local oSayTexto     := Nil
	Local oBtnConfi     := Nil
	Local oBtnParam     := Nil
	Local oBtnSair      := Nil
	Local lHtml         := .T.
	Local lConfirmou    := .F.
	Local cTitulo       := "Impressão de Etiquetas ACD"
	Local cTexto        := "<font color='red'> Impressão de Etiquetas ACD </font><br> Esta rotina tem como objetivo realizar a Impressão das Etiquetas de Entrada para os Produtos."
	Private cPerg       := "UNIR005"
	Private lSchedule 	:= IsBlind()

	Private nPosMarcado 		:= 01
	Private nPosItem    		:= 02
	Private nPosProduto 		:= 03
	Private nPosDescricao		:= 04
	Private nPosQuantidade		:= 05
	Private nPosEtiquetas		:= 06
	Private nPosCodBarras		:= 07
	Private nPosComplemento		:= 08
	Private nPosRecNo 			:= 09
	Private aListEtiquetas		:= {}
	Private oOk       			:= LoadBitmap( GetResources() , "LBOK" ) // Marcado
	Private oNo       			:= LoadBitmap( GetResources() , "LBNO" ) // Desmarcado
	Private lMarcaDesmarca		:= .T.
	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )

	oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
	oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
	oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
	oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
	oSayTexto := TSay():New( 016, 014, { || cTexto }   , oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
	oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oDlgProc:Activate( ,,,.T. )

	If lConfirmou
		MsgRun( "Imprimindo etiquetas, aguarde...", "Imprimindo etiquetas, aguarde...", { || FImprime() } )
	EndIf

Return


Static Function FVldParametros()

	Local lRetVld := .T.

	If Alltrim( MV_PAR02 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Até o Produto ? ] é obrigatório.", { "Voltar" } )
		lRetVld := .F.
	EndIf

Return lRetVld

*-------------------------*
Static Function FImprime()
	*-------------------------*

	aListEtiquetas := {}
	If !FFilEtiquetas()
		Return
	EndIf

	If Len( aListEtiquetas ) == 0

		Aviso( "Atenção", "Não encontrou Itens para Imprimir.", { "Voltar" } )
		Return

	Else

		lMarcou := .F.
		For nI := 01 To Len( aListEtiquetas )
			If aListEtiquetas[nI][nPosMarcado]
				lMarcou := .T.
				Exit
			EndIf
		Next nI

	EndIf

	If !lMarcou
		Aviso( "Atenção", "Selecione um Item primeiro.", { "Voltar" } )
		Return
	EndIf

	U_UniPrtInicializa()

	For nI := 01 To Len( aListEtiquetas )

		If aListEtiquetas[nI][nPosMarcado]

			If aListEtiquetas[nI][nPosEtiquetas] == 0
				Loop
			EndIf

			For nE := 01 To aListEtiquetas[nI][nPosEtiquetas]

				// Inicializa a montagem da Imagem para cada Etiqueta
				//MsCbBegin( nQtdCopys, nVeloc(1,2,3,4,5,6 polegadas por segundo), nTamanho ( da etiqueta em milímetros ), lSalva )
				MsCbBegin( 01, 01, 64 )

				nColSec1 			:= 01
				nLinSec1 			:= 01
				nAltCodBarras		:= 10
				nLarCodBarras		:= 03
				nLinCodBarras		:= 05
				nColCodBarras		:= 16
				nColExtra			:= 00

				// Imprime o Código de Barras
				// MSCBSayBar - ( nXmm,  nYmm, cConteudo, cRotação,  cTypePrt, [ nAltura ], [ *lDigver ], [ lLinha ], [ *lLinBaixo ], [ cSubSetIni ], [ nLargura ], [ nRelacao ], [ lCompacta ], [ lSerial ] [ cIncr ] [ lZerosL ] )
				MSCBSayBar( nColCodBarras + nColExtra, nLinCodBarras, Alltrim( aListEtiquetas[nI][nPosCodBarras] ), "N", "MB07", nAltCodBarras, .F., .F., .F., /*cSubSetIni*/, nLarCodBarras, /*nRelacao*/, /*_lCompacta*/, /*lSerial*/, /*cIncr*/, /*lZerosL*/ )

				cFonte   	:= "0"
				cTam		:= "35"
				cTam2		:= "40"
				cTam6		:= "55"
				cTam5		:= "85"
				nLinSec2    := 16

				MsCbSay( 020+08, nLinSec2, FRetEspacado( AllTrim( aListEtiquetas[nI][nPosCodBarras] ) ), "N"	    , cFonte	 , cTam, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

				// Imprime Código do Produto
				nLinSec2 += 10
				MsCbSay( 01+10+30, nLinSec2, AllTrim( aListEtiquetas[nI][nPosProduto] ), "N"	    , cFonte	 , cTam5, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

				// Imprime Nome do Produto
				nLinSec2 += 13
				MsCbSay( 01, nLinSec2, PadC( AllTrim( aListEtiquetas[nI][nPosDescricao] ), 48 ) , "N"	    , cFonte	 , cTam2, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

				// Imprime Nome do Produto
				nLinSec2 += 08
				MsCbSay( 01, nLinSec2, PadC( AllTrim( aListEtiquetas[nI][nPosComplemento] ), 42 ) , "N"	    , cFonte	 , cTam6, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

				// Finaliza a Etiqueta
				MsCbEnd()

			Next nE

		EndIf

	Next nI

	U_UniPrtFinaliza()

Return


Static Function FInicializaImpressora()

	Local cNomeImpressora 		:= AllTrim( GetNewPar( "MV_XIMPZEB", "ZEBRA" ) )
	Local cPortaImpressora 		:= AllTrim( GetNewPar( "MV_XPORZEB", "LPT3"  ) )
	Local nAlturaEtiqueta		:= 64   	// mm
	Local nLarguraEtiqueta 		:= 100  	// mm
	Local cBaudRate 		 	:= "9600" 	// "110","19200","300","38400","600","56000","1200","57600","2400","115200","4800","128000","9600","256000","14400"
	Local cParity			 	:= "0" 		// "0"- NoParity,"1"-OddParity,"2"-EvenParity,"3"-MarkParity,"4"-SpaceParity
	Local cData 		 	 	:= "8" 		// "4","5","6","7","8"
	Local cStop					:= "0" 		// "0"-OneStopBit,"1"-One5StopBits,"2"-TwoStopBits

	// Inicializa o tamanho da Etiqueta na Memória da Impressora
	//cParity :=Str(At(Upper(cParity),'NOEMS')-1,1)
	cPortaImpressora += ":" + cBaudRate + "," + cParity + "," + cData + "," + cStop

	//MSCBPrinter( [ cModelPrt ] [ cPorta ] [ nDensidade ] [ nTamanho ] [ lSrv ] [ nPorta ] [ cServer ] [ cEnv ] [ nMemoria ] [ cFila ] [ lDrvWin ] [ cPathSpool ] )
	MSCBPrinter( cNomeImpressora, cPortaImpressora,,, .F./*lSrv*/, /*nPorta*/, /*cServer*/, /*cEnv*/, /*nMemoria*/, /*cFila*/, .F./*lDrvWin*/, /*cPathSpool*/ )

	MsCbChkStatus( .F. )

Return



Static Function FFinalizaImpressora()


	// Fecha a Comunicação com a Impressora
	MsCbClosePrinter()

Return


User Function UNIR005TST()


	RPCSetEnv( "01", "0207" )

	U_UNIR005()

	RPCClearEnv()

Return


*-----------------------------*
Static Function FFilEtiquetas()
	*-----------------------------*
	Local lAcao := .F.

	SetPrvt("oDlgImpEtq","oGrpFiltro","oBtnOk","oBtnSair","oListEtiquetas")

	MsgRun( "Carregando as informações da Nota, aguarde...", "Carregando as informações da Nota, aguarde...", { || FCarregaItens() } )

	oDlgImpEtq := MSDialog():New( 138,254,638,1057,"Impressão de Etiquetas",,,.F.,,,,,,.T.,,,.F. )
	oGrpFiltro := TGroup():New( 004,008,233,340," Selecione as etiquetas ",oDlgImpEtq,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtnOk     := TButton():New( 008,346,"Confirmar",oDlgImpEtq,,044,012,,,,.T.,,"",,,,.F. )
	oBtnOk:bAction := { || lAcao := .T., oDlgImpEtq:End() }

	oBtnSair   := TButton():New( 024,346,"Sair",oDlgImpEtq,,044,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction := { || lAcao := .F., oDlgImpEtq:End() }

	@ 015, 016 ListBox oListEtiquetas Fields Header "X", "ITEM", "PRODUTO", "DESCRICAO", "QUANT", "ETIQUETAS" Size 316, 209 ColSizes GetTextWidth( 0, "BBB" ), GetTextWidth( 0, "BBBB" ), GetTextWidth( 0, "BBBBBBBB" ), GetTextWidth( 0, "BBBBBBBBBBBBBBB" ), GetTextWidth( 0, "BBBBBBBBBBB" ), GetTextWidth( 0, "BBBBBBBB" ) Of oGrpFiltro Pixel
	oListEtiquetas:SetArray( aListEtiquetas )
	bLinesEtiquetas  := { || { If( aListEtiquetas[oListEtiquetas:nAt][nPosMarcado], oOk, oNo )   , ; 	// Marcado
		AllTrim( aListEtiquetas[oListEtiquetas:nAt][nPosItem] ) 				 , ;	// Item
		AllTrim( aListEtiquetas[oListEtiquetas:nAt][nPosProduto] ) 			 , ;	// Produto
		AllTrim( aListEtiquetas[oListEtiquetas:nAt][nPosDescricao] ) 			 , ; 	// Descricao
		AllTrim( TransForm( aListEtiquetas[oListEtiquetas:nAt][nPosQuantidade] 	, "@E 999,999.99" ) ) ,;// Quantidade da Nota
		TransForm( aListEtiquetas[oListEtiquetas:nAt][nPosEtiquetas]	, "@E 999" ) } }    // Quantidade de Etiquetas
	oListEtiquetas:bLine		:= bLinesEtiquetas
	oListEtiquetas:bLDblClick 	:= { || FInformaQtd() }
	oListEtiquetas:bHeaderClick := { || FSelectAll() }

	oListEtiquetas:Refresh()

	oDlgImpEtq:Activate(,,,.T.)

	//If lAcao
	//	FImprime()
	//EndIf

Return lAcao

*---------------------------*
Static Function FInformaQtd()
	*---------------------------*
	Local nLinhaGrid := oListEtiquetas:nAt

	// Linha precisa ser maior que zero
	If nLinhaGrid == 0
		Return
	EndIf

	If Len( aListEtiquetas ) == 00
		Return
	EndIf

	If Len( aListEtiquetas ) == 01 .And. nLinhaGrid == 01
		If AllTrim( aListEtiquetas[nLinhaGrid][nPosProduto] ) == ""
			Return
		EndIf
	EndIf

	If oListEtiquetas:nColPos == nPosEtiquetas

		lEditCell( aListEtiquetas, oListEtiquetas, "@E 999", nPosEtiquetas )

	Else

		aListEtiquetas[nLinhaGrid][nPosMarcado] := !aListEtiquetas[nLinhaGrid][nPosMarcado]
		oListEtiquetas:Refresh()

	EndIf

Return

*--------------------------*
Static Function FSelectAll()
	*--------------------------*
	Local nY := 0

	If Len( aListEtiquetas ) == 00
		Return
	EndIf

	If Len( aListEtiquetas ) == 01
		If AllTrim( aListEtiquetas[01][nPosProduto] ) == ""
			Return
		EndIf
	EndIf

	lMarcaDesmarca  := !lMarcaDesmarca
	For nY := 01 To Len( aListEtiquetas )

		aListEtiquetas[nY][nPosMarcado] := !lMarcaDesmarca

	Next nY

	oListEtiquetas:Refresh()

Return

*-----------------------------*
Static Function FCarregaItens()
	*-----------------------------*
	Local aAreaAnt := GetArea()
	Local aAreaSD1 := SD1->( GetArea() )
	Local aAreaSB1 := SB1->( GetArea() )
	Local aAreaSA5 := SA5->( GetArea() )

	aListEtiquetas := {}
	DbSelectArea( "SD1" )
	DbSetOrder( 01 ) // D1_FILIAL + D1_DOC + D1_SERIE + D1_FORNECE + D1_LOJA + D1_COD + D1_ITEM
	Seek SF1->( F1_FILIAL + F1_DOC + F1_SERIE + F1_FORNECE + F1_LOJA )
	Do While !SD1->( Eof() ) .And. ;
			AllTrim( SD1->D1_FILIAL ) == AllTrim( SF1->F1_FILIAL   ) .And. ;
			AllTrim( SD1->D1_DOC 	 ) == AllTrim( SF1->F1_DOC      ) .And. ;
			AllTrim( SD1->D1_SERIE  ) == AllTrim( SF1->F1_SERIE    ) .And. ;
			AllTrim( SD1->D1_FORNECE) == AllTrim( SF1->F1_FORNECE  ) .And. ;
			AllTrim( SD1->D1_LOJA 	 ) == AllTrim( SF1->F1_LOJA 	)

		If AllTrim( SD1->D1_COD ) >= AllTrim( MV_PAR01 ) .And. ;
				AllTrim( SD1->D1_COD ) <= AllTrim( MV_PAR02 )

			DbSelectArea( "SB1" )
			DbSetOrder( 01 )
			SB1->( DbSeek( XFilial( "SB1" ) + SD1->D1_COD ) )

			DbSelectArea( "SA5" )
			DbSetOrder( 02 ) // A5_FILIAL + A5_PRODUTO + A5_FORNECE + A5_LOJA
			SA5->( DbSeek( XFilial( "SA5" ) + SD1->( D1_COD + D1_FORNECE + D1_LOJA ) ) )

			nQtdEtiquetas := Int( SD1->D1_QUANT )
			If nQtdEtiquetas > SD1->D1_QUANT
				nQtdEtiquetas := nQtdEtiquetas - 1
			EndIf
			aAdd( aListEtiquetas, { lMarcaDesmarca	 , ; // 01-Marcado
				SD1->D1_ITEM	 , ; // 02-Item
				SB1->B1_COD		 , ; // 03-Produto
				SB1->B1_DESC     , ; // 04- Descrição
				SD1->D1_QUANT	 , ; // 05-Quantidade
				nQtdEtiquetas	 , ; // 06-Etiquetas
				SB1->B1_CODBAR   , ; // 07-Código de Barras
				SA5->A5_CODPRF   , ; // 08-Complemento
				SD1->( RecNo() ) } ) // 09-RecNo SD1
		EndIf

		DbSelectArea( "SD1" )
		SD1->( DbSkip() )
	EndDo

	If Len( aListEtiquetas ) == 0

		aAdd( aListEtiquetas, { .F.	, ;
			""	, ;
			""	, ;
			""  , ;
			0	, ;
			0	, ;
			""  , ;
			""  , ;
			0 	} )
	EndIf

	RestArea( aAreaSD1 )
	RestArea( aAreaSB1 )
	RestArea( aAreaSA5 )
	RestArea( aAreaAnt )

Return



Static Function FRetEspacado( cParamTexto )

	Local cRetTexto := ""
	Local nP		:= 01

	cRetTexto := ""
	For nP := 01 To Len( cParamTexto )
		cRetTexto += SubStr( cParamTexto, nP, 01 ) + " "
	Next nP

Return AllTrim( cRetTexto )
