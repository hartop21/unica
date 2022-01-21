
/*/{Protheus.doc} UNIR009

@project Impressão de Etiquetas Térmicas ( Unica )
@description Rotina responsável pela Impressão da Etiqueta Térmica de Produto
@author Rafael Rezende
@since 21/10/2019
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
User Function UNIR009()
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
	Local cTitulo       := "Impressão de Etiquetas Produto"
	Local cTexto        := "<font color='red'> Impressão de Etiquetas Produto </font><br> Esta rotina tem como objetivo realizar a Impressão das Etiquetas de Produtos."
	Private cPerg       := "UNIR009"
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

	If Empty( MV_PAR01 )
		Aviso( "Atenção", "O Parâmetro [ Quant. etiquetas ? ] é obrigatório.", { "Voltar" } )
		lRetVld := .F.
	EndIf

Return lRetVld

*-------------------------*
Static Function FImprime()
	*-------------------------*

	U_UniPrtInicializa()

	For nE := 01 To MV_PAR01

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
		MSCBSayBar( nColCodBarras + nColExtra, nLinCodBarras, Alltrim( SB1->B1_CODBAR ), "N", "MB07", nAltCodBarras, .F., .F., .F., /*cSubSetIni*/, nLarCodBarras, /*nRelacao*/, /*_lCompacta*/, /*lSerial*/, /*cIncr*/, /*lZerosL*/ )

		cFonte   	:= "0"
		cTam		:= "35"
		cTam2		:= "40"
		cTam6		:= "55"
		cTam5		:= "85"
		nLinSec2    := 16

		MsCbSay( 020+08, nLinSec2, FRetEspacado( AllTrim( SB1->B1_CODBAR ) ), "N"	    , cFonte	 , cTam, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

		// Imprime Código do Produto
		nLinSec2 += 10
		MsCbSay( 01+10+30, nLinSec2, AllTrim( SB1->B1_COD ), "N"	    , cFonte	 , cTam5, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

		// Imprime Nome do Produto
		nLinSec2 += 13
		MsCbSay( 01, nLinSec2, PadC( AllTrim( SB1->B1_DESC ), 48 ) , "N"	    , cFonte	 , cTam2, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

		//PAREI AQUI
		DbSelectArea( "SA5" )
		DbSetOrder( 02 ) // A5_FILIAL + A5_PRODUTO + A5_FORNECE + A5_LOJA
		If SA5->( DbSeek( XFilial( "SA5" ) + SB1->B1_COD ) ) // D1_FORNECE + D1_LOJA

			// Imprime Nome do Produto
			nLinSec2 += 08
			MsCbSay( 01, nLinSec2, PadC( AllTrim( SA5->A5_CODPRF ), 42 ) , "N"	    , cFonte	 , cTam6, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

		EndIf

		// Finaliza a Etiqueta
		MsCbEnd()

	Next nE

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


User Function UNIR009TST()


	RPCSetEnv( "01", "0207" )

	U_UNIR009()

	RPCClearEnv()

Return



Static Function FRetEspacado( cParamTexto )

	Local cRetTexto := ""
	Local nP		:= 01

	cRetTexto := ""
	For nP := 01 To Len( cParamTexto )
		cRetTexto += SubStr( cParamTexto, nP, 01 ) + " "
	Next nP

Return AllTrim( cRetTexto )
