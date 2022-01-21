#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"


User Function LJTST001( aParams )

	Default aParams := {} //ParamIXb

	If aParams == Nil
		aParams 	:= {}
	EndIf

	ConOut( " ################################################################################### " )
	ConOut( " ## INÍCIO INTEGRAÇÃO - IMPORTACAO PEDIDO DE VENDAS - " + DToC( Date() ) + " " + Time() + " ##" )
	ConOut( " ################################################################################### " )

	RPCSetType( 03 )
	RPCSetEnv( "01", "0207", "CX_005", "123456", "LOJ",, { "SLG", "SLF", "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3"},  .T. )

	FIntegra()

	RPCClearEnv()

	ConOut( " ################################################################################ " )
	ConOut( " ## FIM INTEGRAÇÃO - IMPORTACAO PEDIDO DE VENDAS - " + DToC( Date() ) + " " + Time() + " ##" )
	ConOut( " ################################################################################ " )

Return


Static function FIntegra()


	//Reserva o Número do Orçamento
	cAuxNumOrcamento 	:= GetSXENum( "SL1", "L1_NUM" )
	RollBackSX8()
	nParamOpc			:= 03

	DbSelectArea( "SA1" )
	DbSetOrder( 01 )
	Seek XFilial( "SA1" )// + "104826437" + "PF  "

	// Produto com Estoque e Tabela de Preços - VALOR NA TABELA DE PREÇOS : 2959.86
	DbSelectArea( "SB1" )
	DbSetOrder( 01 )
	Seek XFilial( "SB1" ) + "6089           "

	DbSelectArea( "SA3" )
	DbSetOrder( 01 )
	Seek XFilial( "SA3" ) + "000086"

	//Tabela - SLQ – Cabeçalho do Orçamento
	aCabecOrc  		:= { 	{ "LQ_VEND" 	, SA3->A3_COD				, Nil } ,;
		{ "LQ_FILIAL"   , XFilial( "SLQ" )		  	, Nil } ,;
		{ "LQ_COMIS"	, 0 						, Nil } ,;
		{ "LQ_CLIENTE"  , SA1->A1_COD 				, Nil } ,;
		{ "LQ_LOJA"   	, SA1->A1_LOJA				, Nil } ,;
		{ "LQ_NUM"		, cAuxNumOrcamento		  	, Nil } ,;
		{ "LQ_TIPOCLI"  , "R" 						, Nil } ,;
		{ "LQ_VLRTOT"   , 3179.000000				, Nil } ,;
		{ "LQ_DESCONT"  , 0							, Nil } ,;
		{ "LQ_VLRLIQ"  	, 3179.000000				, Nil } ,;
		{ "LQ_NROPCLI" 	, " "          				, Nil } ,;
		{ "LQ_DTLIM"   	, Date()					, Nil } ,;
		{ "LQ_FRETE"    , 0							, Nil } ,;
		{ "LQ_EMISSAO"  , Date()    				, Nil } ,;
		{ "LQ_SITUA"    , "  "                      , NIL } ,;
		{ "LQ_ESTACAO"  , "001"     	            , NIL } ,;
		{ "LQ_PDV"  	, "0001" 	                , NIL } ,;
		{ "LQ_NUMMOV" 	, "1 "						, Nil } ,;
		{ "LQ_OPERADO" 	, "C11" 					, Nil } ,;
		{ "LQ_NUMORIG" 	, "123123"					, Nil } ,;
		{ "LQ_TIPO" 	, "V"						, Nil } ,;
		{ "LQ_PARCELA" 	, "1"						, Nil } ,;
		{ "LQ_IMPRIME" 	, "1S"						, Nil } ,;
		{ "LQ_OPERACA" 	, "C"						, Nil } ,;
		{ "LQ_STATUS" 	, "F"						, Nil } ,;
		{ "LQ_TPORC" 	, "E"						, Nil } ,;
		{ "LQ_TREFETI" 	, .F.						, Nil } ,;
		{ "LQ_STBATCH" 	, "1"						, Nil } ,;
		{ "LQ_INDPRES" 	, "1"						, Nil } ,;
		{ "LQ_SITUA" 	, "RX"						, Nil } ,;
		{ "AUTRESERVA" 	, "000002"					, Nil }  }

	// Itens do Orçamento
	aItensOrc:= {}
	aAuxItem := {}
	aAdd( aAuxItem, { "LR_NUM"	  	, cAuxNumOrcamento			, Nil } )
	aAdd( aAuxItem, { "LR_PRODUTO"	, AllTrim( SB1->B1_COD )   	, Nil } )
	aAdd( aAuxItem, { "LR_QUANT"  	, 1							, Nil } )
	aAdd( aAuxItem, { "LR_UM" 	  	, "UN"					   	, Nil } )
	aAdd( aAuxItem, { "LR_VRUNIT" 	, 3179.000000		 		, Nil } )
	aAdd( aAuxItem, { "LR_DESC"	  	, 0							, Nil } )
	aAdd( aAuxItem, { "LR_TABELA" 	, "001"				  		, Nil } )
	aAdd( aAuxItem, { "LR_FILIAL" 	, XFilial( "SLR" )			, Nil } )
	aAdd( aAuxItem, { "LR_TES"	  	, "700"						, Nil } )
	aAdd( aAuxItem, { "LR_VEND"	  	, SA3->A3_COD				, Nil } )
	aAdd( aAuxItem, { "LR_CF"	  	, "5102"					, Nil } )
	aAdd( aAuxItem, { "LR_FILRES" 	, "0207"					, Nil } )
	aAdd( aAuxItem, { "LR_NUMORIG" 	, "123123"					, Nil } )
	aAdd( aAuxItem, { "LR_PDV   " 	, "0001" 					, Nil } )
	aAdd( aAuxItem, { "LR_ORIGEM" 	, "0"						, Nil } )
	aAdd( aAuxItem, { "LR_MODBC " 	, "3"						, Nil } )
	aAdd( aAuxItem, { "LR_ENTREGA"	, "3"						, Nil } )
	aAdd( aItensOrc, aAuxItem )

	// Pagamentos
	aPgtoOrc := {}
	aAuxCond := { 	{ 	"L4_NUM"		, cAuxNumOrcamento	, Nil  }, ;
		{ 	"L4_FILIAL"		, XFilial( "SL4" )  , Nil  }, ;
		{	"L4_DATA"		, Date()			, Nil  }, ;
		{   "L4_VALOR"		, 3179.000000		, Nil  }, ;
		{   "L4_FORMA"		, "R$"				, Nil  }, ;
		{	"L4_ADMINIS" 	, Space( 20 ) 		, Nil  }, ;
		{	"L4_FORMAID" 	, " "	 			, Nil  }, ;
		{   "L4_MOEDA"		, 0					, Nil  }  }
	aAdd( aPgtoOrc, aClone( aAuxCond ) )

	// Será necessário utilizar um usuário / senha com permissão de caixa para a inclusão do orçamento
	cUsrLogin := "CX_005"
	cUsrPass  := "123456"
	lEhSch := .T.

	DbSelectArea( "SLG" )
	DbSelectArea( "SLF" )
	DbSelectArea( "SLQ" )
	DbSelectArea( "SLR" )
	DbSelectArea( "SLR" )
	DbSelectArea( "SL1" )
	DbSelectArea( "SL2" )
	DbSelectArea( "SL4" )
	DbSelectArea( "DA0" )
	DbSelectArea( "DA1" )
	DbSelectArea( "SX2" )
	DbSelectArea( "SX3" )
	DbSelectArea( "SIX" )
	DbSelectArea( "SX7" )
	DbSelectArea( "SXB" )

	aAutoCab		:= {}
	lPOSLJAUTO      := .T.
	lMsErroAuto 	:= .F.
	lMsHelpAuto 	:= .F.
	SetFunName( "LOJA701" )

	Inclui  		:= .T.
	Altera  		:= .F.
	lAuxAuto 		:= .T.
	lAutoExec		:= .T.

	FGetEnvInfo( "LOJA701.prw" )
	//cAuxMsgErro := StartJob( "U_FGERA2ORC", GetEnvServer(), .T., cEmpAnt, cFilAnt, .F., cUsrLogin, cUsrPass, aCabecOrc, aItensOrc, aPgtoOrc, 03, SA1->A1_COD, SA1->A1_LOJA, .F. )
	cAuxMsgErro := U_FGERA2ORC( cEmpAnt, cFilAnt, .F., cUsrLogin, cUsrPass, aCabecOrc, aItensOrc, aPgtoOrc, 03, SA1->A1_COD, SA1->A1_LOJA, .F. )
	If AllTrim( cAuxMsgErro ) != ""

		DisarmTransaction()
		RollBackSXE()
		ConOut( MostraErro( "-", "-" ) )

	Else

		//ConOut( "ETAPA 14.14 - VAI CHAMAR O LJGRVBATCH")
		//cAuxMsgErro := StartJob( "LJGRVBATCH", GetEnvServer(), .T., cEmpAnt, cFilAnt, 30000, 60000, 0 )
		//If ValType( cAuxMsgErro ) == "C"
		//	ConOut( "ETAPA 14.14 - cAuxMsgErro = " + cAuxMsgErro )
		//ElseIf ValType( cAuxMsgErro ) == "L"
		//	ConOut( "ETAPA 14.14 - cAuxMsgErro = " + Iif( cAuxMsgErro, "T", "F" ) )
		//EndIf

	EndIf

Return

*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
User Function FGERA2ORC( cParamEmpresa, cParamFilial, lParamSchedule, cParamLogin, cParamSenha, aParamCabecalho, aParamItens, aParamCondicoes, nParamOpc, cParamCliente, cParamLoja, lEhEcommerce  )
	*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local cRetMostraErro := ""
	Local oError    	 := ErrorBlock( { |e| cRetMostraErro := e:Description, ConOut( "STARTJOB - FGERAORC - " + cRetMostraErro ) } )
	Private lMsErroAuto  := .F.
	Default lEhEcommerce := .F.

	ConOut( "INICIO FGERA2ORC" )
	ConOut( "cParamEmpresa 	= " + cParamEmpresa )
	ConOut( "cParamFilial 	= " + cParamFilial	)
	ConOut( "cParamLogin 	= " + cParamLogin	)
	ConOut( "cParamSenha 	= " + cParamSenha 	)
	ConOut( "lParamSchedule = " + If( lParamSchedule, ".T.", ".F."  ) )
	ConOut( "nParamOpc 		= " + StrZero( nParamOpc, 02 			) )
	ConOut( "lEhEcommerce 	= " + Iif( lEhEcommerce,  ".T.", ".F."  ) )

	//RPCSetType( 03 )
	//RPCSetEnv( cParamEmpresa,  cParamFilial,  cParamLogin, cParamSenha, "LOJ", "LOJA701", { "SLG", "SLF",  "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3" },  .T. )

	aAutoCab	:= {}
	lPOSLJAUTO  := .T. //Execauto para eCommerce
	lMsErroAuto := .F.
	lMsHelpAuto := .F.
	SetFunName( "LOJA701" )

	Inclui  	:= .T.
	Altera  	:= .F.
	MsExecAuto( { | a, b, c, d, e, f, g, h | LOJA701( a, b, c, d, e, f, g, h ) }, .F., nParamOpc, cParamCliente, cParamLoja, {}, aParamCabecalho, aParamItens, aParamCondicoes, .F. )
	If lMsErroAuto
		ConOut( MostraErro( "-", "-" ) )
	Else

		RecLock( "SL1", .F. )
		SL1->L1_INDPRES := "1"
		SL1->(MsUnLock())

		ConOut( "EXECAUTO LOJA701 - OK" )
	EndIf

	//RPCClearEnv()

	ErrorBlock( oError )

Return cRetMostraErro


Static Function FGetEnvInfo( cParamRotina )

	Local aRPO 				:= {}
	Default cParamRotina 	:= ""

	aRPO := GetAPOInfo( cParamRotina )
	If !Empty( aRPO )
		ConOut( Replicate( "=", 80 ) )
		ConOut( PadC( "ROTINA: " + aRPO[01], 80 ) )
		ConOut( PadC( "DATA: " + DToC( aRPO[04] ) + " " + aRPO[05], 80 ) )
		ConOut( Replicate( "=", 80 ) )
		ConOut( PadC( "SmartClient: " + GetBuild( .T. ), 80 ) )
		ConOut( PadC( "AppServer: " + GetBuild( .F. ), 80 ) )
		ConOut( PadC( "DbAccess: " + TcAPIBuild() + "/" + TcGetDB(), 80 ) )
		ConOut( Replicate( "=", 80 ) )
		ConOut( "Start at: " + Time() )
		ConOut( Replicate( "=", 80 ) )
	Else
		ConOut( Replicate( "=", 80 ) )
		ConOut( "GETENVINFO - NÃO ENCONTROU A ROTINA ROTINA: " + cParamRotina )
		ConOut( Replicate( "=", 80 ) )
	EndIf

Return