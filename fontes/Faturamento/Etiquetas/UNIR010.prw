
/*/{Protheus.doc} UNIR010

@project Impressão de Etiquetas Térmicas ( Unica )
@description Rotina responsável pela Impressão da Etiqueta Térmica de Pedido e Nota Fiscal
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
User Function UNIR010()
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
	Local cTexto        := "<font color='red'> Impressão de Etiquetas ACD </font><br> Esta rotina tem como objetivo realizar a Impressão das Etiquetas para o ACD.<br>Selecione os parâmetros desejados e confirme a importação."
	Private cPerg       := "UNIR010"
	Private lSchedule 	:= IsBlind()
	cTexto              := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )

	oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
	oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
	oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
	oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
	oSayTexto := TSay():New( 016, 014, { || cTexto }   , oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
	oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), oDlgProc:End(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	//oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || lConfirmou := .T., oDlgProc:End() } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	//oBtnConfi := TButton():New( 092, 006, "&Imprimir"  , oDlgProc, { || FImprime() } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oDlgProc:Activate( ,,,.T. )

	If lConfirmou
		MsgRun( "Imprimindo etiquetas, aguarde...", "Imprimindo etiquetas, aguarde...", { || FImprime() } )
	EndIf

Return


Static Function FVldParametros()

	Local lRetVld := .T.

	If MV_PAR01 == 0
		Aviso( "Atenção", "O Parâmetro [ Qtd. Volumes ? ] é obrigatório.", { "Voltar" } )
		lRetVld := .F.
	EndIf

Return lRetVld


Static Function FImprime()

	Local aAreaAnt    := GetArea()
	//Local aAreaCB7    := CB7->( GetArea() )
	//Local aAreaCB8    := CB8->( GetArea() )
	Local aAreaSA4    := SA4->( GetArea() )
	Local aAreaSC5    := SC5->( GetArea() )
	Local aAreaSF2    := SF2->( GetArea() )
	Local cAliasQry   := GetNextAlias()
	Local cQuery      := ""
	Private lEhPedido := .T.

	DbSelectArea( "SC5" )

	If AllTrim( SC5->C5_NOTA ) != ""
		cLabelEtq   := "NOTA:"
		cNumEtq		:= Right( AllTrim( SC5->C5_NOTA ), 08 )
		lEhPedido 	:= .F.

		aAreaOld := GetArea()
		aAreaSF2 := SF2->( GetArea() )
		DbSelectArea( "SF2" )
		DbSetOrder( 01 ) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
		Seek XFilial( "SF2" ) + SC5->( C5_NOTA + C5_SERIE +  C5_CLIENTE + C5_LOJACLI )
		If Found()
			RecLock( "SF2", .F. )
			SF2->F2_ESPECI1 := "VOLUME"
			SF2->F2_VOLUME1 := MV_PAR01
			SF2->( MsUnLock() )
		EndIf
		RestArea( aAreaSF2 )
		RestArea( aAreaOld )

	Else
		cLabelEtq 	:= "PEDIDO:"
		cNumEtq		:= SC5->C5_NUM
		lEhPedido 	:= .T.

		/*
	aAreaOld := GetArea()
	aAreaSC5 := SC5->( GetArea() )
	DbSelectArea( "SC5" )
	DbSetOrder( 01 ) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	Seek XFilial( "SC5" ) + CB7->CB7_PEDIDO
	If Found()
		*/
		RecLock( "SC5", .F. )
		SC5->C5_ESPECI1 := "VOLUME"
		SC5->C5_VOLUME1 := MV_PAR01
		SC5->( MsUnLock() )
		/*
	EndIf
	RestArea( aAreaSC5 )
	RestArea( aAreaOld )
		*/

	EndIf

	DbSelectArea( "SA4" )
	DbSetOrder( 01 ) // A4_FILIAL + A4_COD
	Seek XFilial( "SA4" ) + SC5->C5_TRANSP

	DbSelectArea( "SC6" )
	DbSetOrder( 01 ) // CB8_FILIAL + CB8_ORDSEP + CB8_ITEM + CB8_SEQUEN + CB8_PROD
	Seek SC5->( C5_FILIAL + C5_NUM )
	If !SC6->( Eof() )

		nColExtra := 0
		If !U_UniPrtInicializa()
			Return
		EndIf

		nContador  	:= MV_PAR01
		nAuxSeq 	:= 00

		/*
	aAreaLoop := GetArea()
	Do While !CB8->( Eof() ) .And. ;
			 AllTrim( CB8->CB8_FILIAL ) == AllTrim( CB7->CB7_FILIAL ) .And. ;
			 AllTrim( CB8->CB8_ORDSEP ) == AllTrim( CB7->CB7_ORDSEP )
		*/

		For nE := 01 To nContador

			cAuxVolume := StrZero( nE, 02 ) + "/" + StrZero( nContador, 02 )

			// Imprime a Etiqueta
			FImpEtiqueta( cLabelEtq, cNumEtq, cAuxVolume )

		Next nE

		//	CB8->( DbSkip() )
		//EndDo

		//Encerra a Impressão da Etiqueta
		U_UniPrtFinaliza()

		// Ponteirar na Nota e gravar a Quantidade de Volumes


	EndIf

	RestArea( aAreaAnt )

Return


Static Function FImpEtiqueta( cParamLblEtq, cParamNumEtq, cParamVolume )

	Local nColSec1 	:= 05
	Local nLinSec1 	:= 05
	Local cFonte   	:= "0"
	Local cTam		:= "35"
	Local cTam2		:= "40"

	// Inicializa a montagem da Imagem para cada Etiqueta
	//MsCbBegin( nQtdCopys, nVeloc(1,2,3,4,5,6 polegadas por segundo), nTamanho ( da etiqueta em milímetros ), lSalva )
	MsCbBegin( 01, 01, 64 )

	// Imprime a Descrição do Pedidio
	// MSCBSay( nXmm	,  nYmm	  , cTexto	  		, cRotação	, cFonte 	 , cTam, [ *lReverso ], [ lSerial ], [ cIncr ], [ *lZerosL ], [ lNoAlltrim ] )
	MsCbSay	  ( 05	 	, nLinSec1, cParamLblEtq	, "N"	    , cFonte	 , cTam, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )
	MsCbSay	  ( 05 + 20	, nLinSec1, cParamNumEtq	, "N"	    , cFonte	 , cTam2, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )

	// Imprime uma linha Vertical
	nX1mm 		:= 001
	nY1mm 		:= 100
	nX2mm 		:= 003
	nEspessura 	:= 02
	cCor  		:= "B"
	// MSCBLineV( nX1mm, nY1mm, nX2mm, [ nEspessura ( em Pixel ) ], [ *cCor ( String com a Cor Branca ou Preta ("W" ou "B") )] )
	//MsCbLineV( nX1mm, nY1mm, nX2mm, nEspessura, cCor  )

	// Imprime a Descrição do Volume
	// MSCBSay( nXmm	,  nYmm	  , cTexto	  			, cRotação	, cFonte , cTam, [ *lReverso ], [ lSerial ], [ cIncr ], [ *lZerosL ], [ lNoAlltrim ] )
	MsCbSay	  ( 05 + 050, nLinSec1, "VOLUMES: "		, "N"	    , cFonte	 , cTam, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )
	MsCbSay( 01 + 050+025, nLinSec1, cParamVolume	, "N"	    , cFonte	 , cTam2, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )

	//Separa a Seção 1
	// MSCBLineH( nX1mm, nY1mm, nX2mm, [ nEspessura ( em Pixel ) ], [ *cCor ( String com a Cor Branca ou Preta ("W" ou "B") )] )
	nXIniLin  := 001
	nYIniLin  := 005
	nXAteLin  := 100
	nYAteLin  := 008
	//MsCbLineH( nXIniLin, nYIniLin, nYAteLin, nXAteLin )

	// Imprime Nome da Transportadora
	nLinSec2 := nYAteLin + 06
	cTam3	 := "75"
	MsCbSay( 05, nLinSec2, PadC( SA4->( AllTrim( A4_NREDUZ ) + " - " + A4_EST ), 25 ) , "N"	    , cFonte	 , cTam3, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, .T./*lNoAlltrim*/ )

	//Separa a Seção 2
	nXIniLin  := 001
	nYIniLin  := nLinSec2+09   +10
	nXAteLin  := 300
	nYAteLin  := nLinSec2+03
	// MSCBLineH( nX1mm, nY1mm, nX2mm, [ nEspessura ( em Pixel ) ], [ *cCor ( String com a Cor Branca ou Preta ("W" ou "B") )] )
	//MsCbLineH( nXIniLin, nYIniLin, nYAteLin, nXAteLin )

	// Imprime Título "Pedido" + Data e Hora:
	nLinSec3 := nYAteLin + 05+05
	MsCbSay	  ( 005, nLinSec3, cParamLblEtq , "N"	    , cFonte	 , cTam2, /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )
	MsCbSay	  ( 048, nLinSec3, DToC( Date() ) + " - " + Left( Time(), 05 ) , "N"	    , cFonte	 , cTam2 , /*lReverso*/, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )

	// Imprime Número do Pedido com Fundo Preto
	nXIniLin  	:= 001
	nYIniLin  	:= nLinSec3+05
	nXAteLin  	:= 100
	nYAteLin  	:= nYIniLin+25

	cCor  		:= "B"
	If lEhPedido
		cTam4 		:= "250"
	Else
		cTam4 		:= "200"
	EndIf
	lReverso 	:= .T.

	//MSCBBox( nXIniLin, nY1mm, nX2mm, nY2mm, [ nEspessura ( em Pixel ) ], [ *cCor ( String com a Cor Branca ou Preta ("W" ou "B") )] )
	cCor	  	:= "B"

	//MsCbBox( 001, nYIniLin, nXAteLin, nYAteLin, 100, cCor ) //Monta BOX --> A Espessura precisa ser definida para pintar o Box
	If lEhPedido
		MsCbSay( 005, nYIniLin+04+1, Alltrim( cParamNumEtq ) , "N"	, cFonte	 , cTam4 , lReverso, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )
	Else
		MsCbSay( 005, nYIniLin+04+1, Alltrim( cParamNumEtq ) , "N"	, cFonte	 , cTam4 , lReverso, /*lSerial,*/, /*cIncr*/, /*lZerosL*/, /*lNoAlltrim*/ )
	EndIf

	// Finaliza a Etiqueta
	MsCbEnd()

Return


User Function UNIR010TST()


	RPCSetEnv( "01", "0207" )

	DbSelectArea( "SC5" )
	//dbsetorder( 01 )
	//dbgoto( 2 )
	//U_UNIR010()
	MV_PAR01 := 1
	FImprime()

	RPCClearEnv()

Return

