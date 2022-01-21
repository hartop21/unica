
/*/{Protheus.doc} UNIA015

@project Integração Protheus x Magento
@description Rotina com o objetivo de atualizar o Status do Pedido para "Produto(s) entregue(s)" no Magento
@wsdl Produção 	  - https://www.unicaarcondicionado.com.br/index.php/api/v2_soap?wsdl=1
      Homologação - https://unicario.com.br/homologacao/index.php/api/v2_soap/?wsdl
@author Rafael Rezende
@since 16/08/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"

*---------------------*
User Function UNIA015()
	*---------------------*
	Local oFontProc     	 := Nil
	Local oDlgProc      	 := Nil
	Local oGrpTexto 	     := Nil
	Local oSayTexto	     	 := Nil
	Local oBtnConfi     	 := Nil
	Local oBtnParam 	     := Nil
	Local oBtnSair	      	 := Nil
	Local lHtml		         := .T.
	Local lConfirmou	     := .F.
	Local cPerg         	 := "UNIA015X"
	Local cTitulo   	     := "Integração Protheus x Magento - Atualização do Status dos Pedidos"
	Local cTexto	         := "<font color='red'> Integração Protheus x Magento </font><br> Esta rotina tem como objetivo realizar a atualização do status dos pedidos no Magento para <font color'green'><b>Produto(s) entregue(s)</b></font>."
	Private lSchedule 		 := IsBlind()
	cTexto          	     := "<div style='text-align:Justfy; valign:Center;'>" + Replace( cTexto, CRLF, "<BR>" ) + "</div>"

	Pergunte( cPerg, .F. )

	oFontBtn  := TFont():New( "Ms Sans Serif", 0, -11,, .T., 0,, 700, .F., .F.,	,,,,, )
	oFontMsg  := TFont():New( "Arial"		  ,	 , 018,, .F.,  ,,	 ,	  , .F., .F.,,,,, )
	oDlgProc  := MsDialog():New( 091, 232, 324, 659, cTitulo,,, .F.,,,,,, .T.,,, .T. )
	oGrpTexto := TGroup():New( 004, 006, 084, 202, "", oDlgProc, CLR_BLACK, CLR_WHITE, .T., .F. )
	oSayTexto := TSay():New( 016, 014, { || cTexto }, oGrpTexto,, oFontMsg, .F., .F., .F., .T., CLR_HBLUE, CLR_WHITE, 176, 060 ,,,,,, lHtml )
	oBtnConfi := TButton():New( 092, 006, "&Consultar"  , oDlgProc, { || lConfirmou := .T., If( FVldParametros(), FMostraPedidos(), lConfirmou := .F. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnParam := TButton():New( 092, 083, "&Parâmetros", oDlgProc, { || Pergunte( cPerg, .T. ) } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oBtnSair  := TButton():New( 092, 156, "&Sair"	   , oDlgProc, { || oDlgProc:End() 		   } , 044, 012,, oFontBtn,, .T.,, "",,,, .F. )
	oDlgProc:Activate( ,,,.T. )

Return


Static function FVldParametros()

	Local lRet := .T.

	If AllTrim( MV_PAR02 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Pedido até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR04 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Id Magento até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	/*
If lRet .And. AllTrim( MV_PAR08 ) == ""
	Aviso( "Atenção", "O Parâmetro [ WSDL Magento ? ] é obrigatório.", { "Voltar" } )
	lRet := .F.
EndIf
	*/

Return lRet


Static Function FMostraPedidos()

	Private oOk       		:= LoadBitmap( GetResources() , "LBOK" 	      ) // Marcado
	Private oNo       		:= LoadBitmap( GetResources() , "LBNO" 	   	  ) // Desmarcado
	Private oVerde      	:= LoadBitmap( GetResources() , "BR_VERDE"    ) // Verde
	Private oAmarelo    	:= LoadBitmap( GetResources() , "BR_AMARELO"  ) // Amarelo
	Private oAzul       	:= LoadBitmap( GetResources() , "BR_AZUL" 	  )    // Azul
	Private oVermelho   	:= LoadBitmap( GetResources() , "BR_VERMELHO" ) // Vermelho
	Private aListPedidos	:= {}
	Private aTitListPedidos := {}
	Private aSizeListPedidos:= {}
	Private bLinesPedidos	:= { || }
	Private lMarcaDesmarca  := .T.

	Private nPosMarcado		:= 01
	Private nPosLegenda		:= 02
	Private nPosFilial		:= 03
	Private nPosMagento		:= 04
	Private nPosPedido		:= 05
	Private nPosNota		:= 06
	Private nPosSerie		:= 07
	Private nPosCliente		:= 08
	Private nPosLoja		:= 09
	Private nPosTransp		:= 10
	Private nPosRazao		:= 11
	Private nPosFaturam		:= 12
	Private nPosColeta		:= 13
	Private nPosEntrega		:= 14
	Private nPosChave		:= 15
	Private nPosWSDL		:= 16
	Private nPosRecNo		:= 17

	SetPrvt("oDlgProdEntr","oGrpLista","oBtnEnviar","oBtnSair","oListPedidos")

	MsgRun( "Carregando Lista de Pedidos, aguarde...", "Carregando Lista de Pedidos, aguarde...", { || FCarregaPedidos() } )

	oDlgProdEntr		:= MsDialog():New( 0127, 0233, 0697, 1358, "Atualiação de Status de Pedidos ",,,.F.,,,,,,.T.,,,.F. )
	oGrpLista  			:= TGroup():New( 000,008,269,502," Lista de Pedidos ",oDlgProdEntr,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListPedidos  := {}
	aSizeListPedidos := {}
	aAdd( aTitListPedidos , "" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB"	 ) )
	aAdd( aTitListPedidos , "" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB"	 ) )
	aAdd( aTitListPedidos , "FIL" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListPedidos , "ID.MAGENTO" 		)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB" ) )
	aAdd( aTitListPedidos , "PEDIDO" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB"	 ) )
	aAdd( aTitListPedidos , "NOTA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB" ) )
	aAdd( aTitListPedidos , "SERIE" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListPedidos , "CLIENTE" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListPedidos , "LOJA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListPedidos , "TRANSP." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListPedidos , "RAZÃO SOCIAL" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBBBB" ) )
	aAdd( aTitListPedidos , "DT. FATUR." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "DT. COLETA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "DT. ENTREGA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "CHAVE NOTA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBBBBBBB"  ) )
	aAdd( aTitListPedidos , "COD WSDL" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB"  ) )

	//oListPedidos		:= TListBox():New( 011,015,,,480,250,,oGrpLista,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	oListPedidos 	:= TwBrowse():New( 011, 015, 480,250,, aTitListPedidos, aSizeListPedidos, oGrpLista,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListPedidos:SetArray( aListPedidos )
	bLinesPedidos	:= 				{ || { 	If( aListPedidos[oListPedidos:nAt][nPosMarcado], oOk, oNo )	,; // 01-Marcado
		If( aListPedidos[oListPedidos:nAt][nPosLegenda] == "P", oVerde, If( aListPedidos[oListPedidos:nAt][nPosLegenda] == "T", oAmarelo, IF( aListPedidos[oListPedidos:nAt][nPosLegenda] == "C", oAzul, oVermelho ) ) )	,; // 01-Marcado
		AllTrim( aListPedidos[oListPedidos:nAt][nPosFilial]  ) 			,; // 02-Filial
		AllTrim( aListPedidos[oListPedidos:nAt][nPosMagento] ) 			,; // 03-Id. Magento
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPedido]  ) 			,; // 04- Pedido
		AllTrim( aListPedidos[oListPedidos:nAt][nPosNota]   	) 			,; // 05- Nota
		AllTrim( aListPedidos[oListPedidos:nAt][nPosSerie]  	) 			,; // 06- Série
		AllTrim( aListPedidos[oListPedidos:nAt][nPosCliente] ) 			,; // 07- Cliente
		AllTrim( aListPedidos[oListPedidos:nAt][nPosLoja]  	) 			,; // 08- Loja
		AllTrim( aListPedidos[oListPedidos:nAt][nPosTransp]  ) 			,; // 09- Transportadora
		AllTrim( aListPedidos[oListPedidos:nAt][nPosRazao]  	) 			,; // 10- Razão Social
		DToC( aListPedidos[oListPedidos:nAt][nPosFaturam] ) 			,; // 11- Data de Faturamento
		DToC( aListPedidos[oListPedidos:nAt][nPosColeta] 	) 			,; // 12- Data de Coleta
		DToC( aListPedidos[oListPedidos:nAt][nPosEntrega] ) 			,; // 13- Data de Entrega
		AllTrim( aListPedidos[oListPedidos:nAt][nPosChave]   ) 			,; // 14- Chave da Nota
		AllTrim( aListPedidos[oListPedidos:nAt][nPosWSDL]    ) 			}} // 15- Chave da Nota

	oListPedidos:bLine 	   		:= bLinesPedidos
	oListPedidos:bLDblClick 	:= { || FSeleciona() }
	oListPedidos:bHeaderClick 	:= { || FSelectAll() }
	oListPedidos:Refresh()

	oBtnEnviar 			:= TButton():New( 004,508,"Enviar",oDlgProdEntr,,045,012,,,,.T.,,"",,,,.F. )
	oBtnEnviar:bAction 	:= { || Processa( { || FEnviar() }, "Atualizando Status no magento, aguarde..." ) }

	oBtnExcel   		:= TButton():New( 020,508,"Excel",oDlgProdEntr,,045,012,,,,.T.,,"",,,,.F. )
	oBtnExcel:bAction 	:= { || Processa( { || FExportaExcel() 	 }, "Exportando para Excel, aguarde..." ) }

	oBtnSair   			:= TButton():New( 036,508,"Sair",oDlgProdEntr,,045,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction 	:= { || oDlgProdEntr:End() }

	oDlgProdEntr:Activate( ,,, .T. )

Return

*---------------------------*
Static Function  FSeleciona()
	*---------------------------*
	Local nLinhaGrid := oListPedidos:nAt

	// Linha precisa ser maior que zero
	If nLinhaGrid == 0
		Return
	EndIf

	If Len( aListPedidos ) == 00
		Return
	EndIf

	If Len( aListPedidos ) == 01 .And. nLinhaGrid == 01
		If AllTrim( aListPedidos[nLinhaGrid][nPosMagento] ) == ""
			Return
		EndIf
	EndIf

	If ( oListPedidos:nColPos == nPosFaturam  .Or. ;
			oListPedidos:nColPos == nPosColeta   .Or. ;
			oListPedidos:nColPos == nPosEntrega 	   )

		lEditCell( aListPedidos, oListPedidos, "@D", oListPedidos:nColPos )

	Else

		If oListPedidos:nColPos == nPosLegenda
			FLegenda()
		Else
			aListPedidos[nLinhaGrid][nPosMarcado] := !aListPedidos[nLinhaGrid][nPosMarcado]
			oListPedidos:Refresh()
		EndIf
	EndIf

Return

*--------------------------*
Static Function FSelectAll()
	*--------------------------*
	Local nY := 0

	If Len( aListPedidos ) == 00
		Return
	EndIf

	If Len( aListPedidos ) == 01
		If AllTrim( aListPedidos[01][nPosMagento] ) == ""
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
	Local aAreaOld 		:= GetArea()
	Local cAliasQry 	:= GetNextAlias()
	Local cStatus  		:= ""
	Local cQuery 		:= ""
	Local cAuxTransp  	:= ""
	Local cRazaoSocial 	:= ""
	Local cChaveNota   	:= ""
	Local nPosNFChave  	:= 01
	Local nPosNFTransp 	:= 02
	Local nPosNFRecNo  	:= 03
	Local aAuxInfoNF	:= {}


	aListPedidos	:= {}

	DbSelectArea( "SA4" )
	DbSetOrder( 01 ) //A4_FILIAL + A4_COD

	cQuery := "		 SELECT C5_FILIAL	, "
	cQuery += "		 		C5_XIDMAGE	, "
	cQuery += "		 		C5_NUM		, "
	cQuery += "		 		C5_NOTA		, "
	cQuery += "		 		C5_SERIE	, "
	cQuery += "		 		C5_CLIENTE	, "
	cQuery += "		 		C5_LOJACLI	, "
	cQuery += "		 		C5_TRANSP	, "
	cQuery += "		 		C5_XENVCHV	, "
	cQuery += "		 		C5_XENVTRA	, "
	cQuery += "		 		C5_XENVPRO	, "
	cQuery += "		 		C5_XDTEXPE	, "
	cQuery += "		 		C5_XDTCOLE	, "
	cQuery += "		 		C5_XDTENTR	, "
	cQuery += "				C5_XCODSZ8	, "
	cQuery += "				SC5.R_E_C_N_O_ AS NUMRECSC5 "
	cQuery += "		   FROM " + RetSQLName( "SC5" ) + " SC5 (NOLOCK)   "
	cQuery += "		  WHERE SC5.D_E_L_E_T_ 		 = ' ' "
	//cQuery += "		    AND SC5.C5_FILIAL 	 	 = '" + XFilial( "SC5" ) + "' "
	cQuery += "		 	AND SC5.C5_NUM     BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "		 	AND SC5.C5_XIDMAGE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	//cQuery += "		 	AND SC5.C5_XIDMAGE      != '' "
	If AllTrim( MV_PAR08 ) != ""
		cQuery += "			AND SC5.C5_XCODSZ8   = '" + MV_PAR08 + "' "
	EndIf
	If MV_PAR05 != 03
		If MV_PAR05 == 02
			cQuery += "		AND SC5.C5_XENVCHV 	  != 'S' "
		EndIf
	EndIf
	If MV_PAR06 != 03
		If MV_PAR06 == 02
			cQuery += "		AND SC5.C5_XENVTRA 	  != 'S' "
		EndIf
	EndIf
	If MV_PAR07 != 03
		If MV_PAR07 == 02
			cQuery += "		AND SC5.C5_XENVPRO 	  != 'S' "
		EndIf
	EndIf
	cQuery += "	ORDER BY SC5.C5_XIDMAGE, SC5.C5_FILIAL, SC5.C5_NUM "
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasQry ) New
	Do While !( cAliasQry )->( Eof() )

		If AllTrim( ( cAliasQry )->C5_XENVPRO ) != "S"
			If AllTrim( ( cAliasQry )->C5_XENVTRA ) != "S"
				If AllTrim( ( cAliasQry )->C5_XENVCHV ) == "S"
					cStatus := "C" // Chave Enviada
				Else
					cStatus := "" // Pedido Confirmado e Importado para Pedido de Vendas
				EndIf
			Else
				cStatus := "T" // Enviado para Transporte
			EndIf
		Else
			cStatus := "P" // Produtos Entregue
		EndIf

		aAuxInfoNF := {}
		aAuxInfoNF := FRetInfoNota( ( cAliasQry )->C5_FILIAL , ;
			( cAliasQry )->C5_NOTA	 , ;
			( cAliasQry )->C5_SERIE	 , ;
			( cAliasQry )->C5_CLIENTE, ;
			( cAliasQry )->C5_LOJACLI  )

		cChaveNota   := aAuxInfoNF[nPosNFChave]
		If AllTrim( aAuxInfoNF[nPosNFTransp] ) != ""
			cAuxTransp := aAuxInfoNF[nPosNFTransp]
		Else
			cAuxTransp := ( cAliasQry )->C5_TRANSP
		EndIf

		DbSelectArea( "SA4" )
		Seek XFilial( "SA4" ) + cAuxTransp
		If Found()
			cAuxRazaoSocial := SA4->A4_NOME
		Else
			cAuxRazaoSocial := ""
		EndIf

		aAdd( aListPedidos, { .F.						  , ;
			cStatus 					  , ;
			( cAliasQry )->C5_FILIAL	  , ;
			( cAliasQry )->C5_XIDMAGE	  , ;
			( cAliasQry )->C5_NUM		  , ;
			( cAliasQry )->C5_NOTA	  , ;
			( cAliasQry )->C5_SERIE	  , ;
			( cAliasQry )->C5_CLIENTE	  , ;
			( cAliasQry )->C5_LOJACLI	  , ;
			cAuxTransp				  , ;
			cAuxTransportadora	  	  , ;
			SToD( ( cAliasQry )->C5_XDTEXPE	) , ;
			SToD( ( cAliasQry )->C5_XDTCOLE	) , ;
			SToD( ( cAliasQry )->C5_XDTENTR	) , ;
			cChaveNota			 	  , ;
			( cAliasQry )->C5_XCODSZ8	  , ;
			( cAliasQry )->NUMRECSC5	  } )

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If Len( aListPedidos ) == 0

		aAdd( aListPedidos, { .F.			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			""			, ;
			CToD( "" )	, ;
			CToD( "" )	, ;
			CToD( "" )	, ;
			"" 			, ;
			"" 			, ;
			0				} )

	EndIf

	RestArea( aAreaOld )

Return


Static Function FLegenda()

	Local aLegenda  := { { "BR_VERMELHO", "Confirm. Pgto - Importado" } ,;
		{ "BR_AZUL" 	, "Faturado. Chave Enviada"   } ,;
		{ "BR_AMARELO" , "Enviado para Transporte"   } ,;
		{ "BR_VERDE"   , "Produto(s) Entregue(s)"	  }  }

	BrwLegenda( "Status Ped. Magento", "Legenda", aLegenda )

Return

*-----------------------*
Static Function FEnviar()
	*-----------------------*
	Local aAreaAnt 		:= GetArea()
	Local nX			:= 0
	Local lContinuar 	:= .F.

	For nX := 01 To Len( aListPedidos )

		If aListPedidos[nX][nPosMarcado]
			lContinuar := .T.
			Exit
		EndIf

	Next nX

	If !lContinuar
		Aviso( "Atenção", "Será necessário selecionar um ou mais pedidos para enviar para o Status [ Produto(s) Entregue(s)] no Magento.", { "Voltar" } )
		Return
	EndIf

	ProcRegua( Len( aListPedidos ) )
	For nX := 01 To Len( aListPedidos )

		IncProc( "Atualizando Status dos Pedido [ " + aListPedidos[nX][nPosMagento] + " ]" )
		If aListPedidos[nX][nPosMarcado]

			If aListPedidos[nX][nPosLegenda] == "T" // Envia o Pedido para Produtos Entregues

				DbSelectArea( "SC5" )
				SC5->( DbGoTo( aListPedidos[nX][nPosRecNo] ) )
				lProssegue := .T.

				If AllTrim( SC5->C5_XENVCHV ) == "S"

					If AllTrim( SC5->C5_XENVTRA ) == "S"

						If !Empty( aListPedidos[nX][nPosFaturam] )

							If !Empty( aListPedidos[nX][nPosColeta] )

								If !Empty( aListPedidos[nX][nPosEntrega] )

									//Efetiva a Atualização no Magento
									DbSelectArea( "SC5" )
									RecLock( "SC5", .F. )
									SC5->C5_XENVPRO := ""
									SC5->C5_XDTENTR := aListPedidos[nX][nPosEntrega]
									SC5->( MsUnLock() )
									aListPedidos[nX][nPosLegenda] := "P"

								Else

									Aviso( "Atenção", "O Campo de [Data de Entrega ] é obrigatório.", { "Voltar" } )

								EndIf

							Else

								Aviso( "Atenção", "O Pedido ainda não possui [Data de Coleta ]. O mesmo não poderá ser enviado para [ Produto(s) Entregue(s) ].", { "Voltar" } )

							EndIf

						Else

							Aviso( "Atenção", "O Pedido ainda não possui uma nota transmitida. A [Data de Faturamento ] é obrigatório.", { "Voltar" } )

						EndIf

					Else

						Aviso( "Atenção", "O Pedido [ " + SC5->C5_XIDMAGE + "] ainda não foi enviado para Transporte.", { "Voltar" } )

					EndIf

				Else

					Aviso( "Atenção", "O Pedido [ " + SC5->C5_XIDMAGE + "] ainda não teve a Chave da Nota enviada para o Magento.", { "Voltar" } )

				EndIf

			EndIf

		EndIf

	Next nX

	Aviso( "Atenção", "Fim da atualização dos Status dos Pedidos!", { "Ok" } )

	RestArea( aAreaAnt )

Return

*-----------------------------*
Static Function FExportaExcel()
	*-----------------------------*
	Local oExcel 	:= FWMsExcel():New()
	Local aCabec	:= { { "STATUS"			, "C" } ,;
		{ "FIL"			, "C" } ,;
		{ "ID.MAGENTO"		, "C" } ,;
		{ "PEDIDO"			, "C" } ,;
		{ "NOTA"			, "C" } ,;
		{ "SERIE"			, "C" } ,;
		{ "CLIENTE"		, "C" } ,;
		{ "LOJA"			, "C" } ,;
		{ "TRANSP."		, "C" } ,;
		{ "RAZÃO SOCIAL"	, "C" } ,;
		{ "DT. FATUR."		, "D" } ,;
		{ "DT. COLETA"		, "D" } ,;
		{ "DT. ENTREGA"	, "D" } ,;
		{ "CHAVE NOTA"		, "C" } ,;
		{ "WSDL MAGENTO"	, "C" }  }

	oExcel:AddworkSheet( "LISTA PEDIDOS" )
	oExcel:AddTable ( "LISTA PEDIDOS", "LISTA PEDIDOS" )

	For nF := 01 To Len( aCabec )

		Do Case
			Case aCabec[nF][02] == "N" // Number
				nAlinhamento := 03 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 02 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
			Case aCabec[nF][02] == "M" // Money
				nAlinhamento := 03 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 03 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
			Case aCabec[nF][02] == "D" // Date
				nAlinhamento := 03 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 04 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
			OtherWise
				nAlinhamento := 01 // ( 1-Left	  , 2-Center , 3-Right )
				nFormato 	 := 01 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )
		EndCase
		lTotal := .F.
		oExcel:AddColumn( "LISTA PEDIDOS", "LISTA PEDIDOS", AllTrim(  aCabec[nF][01] ), nAlinhamento, nFormato, lTotal )

	Next nF

	lTotal 		 := .F.
	nAlinhamento := 01 // ( 1-Left	  , 2-Center , 3-Right )
	nFormato 	 := 01 // ( 1-General , 2-Number , 3-Monetário, 4-DateTime )

	ProcRegua( Len( aListPedidos ) )
	For nL := 01 To Len( aListPedidos )

		IncProc()

		cAuxLegenda := ""
		aAux 		:= {}
		For nC := 01 To ( Len( aCabec )-01 )

			If ( nC+01) == nPosLegenda
				Do Case
					Case aListPedidos[nL][nC+01] == ""
						cAuxLegenda := "Pagamento Confirmado - Importado"
					Case aListPedidos[nL][nC+01] == "C"
						cAuxLegenda := "Chave da Nota Enviada"
					Case aListPedidos[nL][nC+01] == "T"
						cAuxLegenda := "Enviado para Transporte"
					Case aListPedidos[nL][nC+01] == "P"
						cAuxLegenda := "Produto(s) Entregues(s)"
				EndCase
				aAdd( aAux, cAuxLegenda )
			Else
				aAdd( aAux, aListPedidos[nL][nC+01] )
			EndIf

		Next nY
		oExcel:AddRow( 	"LISTA PEDIDOS", "LISTA PEDIDOS", aAux )

	Next nL
	MsgRun( "Aguarde, iniciando Microsoft Excel...", "Aguarde, iniciando Microsoft Excel...", { || oExcel:Activate() } )

	cPath 	 := "c:\temp\"
	FwMakeDir( cPath )
	cNomeXML := cPath + FunName() + "_" + FwTimeStamp( 01 ) + ".xml"
	oExcel:GetXMLFile( cNomeXML )
	If ApOleClient( "MsExcel" )
		oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open( cNomeXML )
		oExcelApp:SetVisible( .T. )
		oExcelApp:Destroy()
	Else
		ShellExecute( "Open", cNomeXML, "", "", 01 )
	EndIf

Return


*---------------------------------------------------------------------------------------------*
Static Function FRetInfoNota( cParamFilial, cParamDoc, cParamSerie, cParamCliente, cParamLoja )
	*---------------------------------------------------------------------------------------------*
	Local aAreaOld  := GetArea()
	Local cAliasSF2 := GetNextAlias()
	Local cQuery 	:= ""
	Local aRetInfo  := { "", "", 0 }

	cQuery := "		 		  SELECT F2_CHVNFE, F2_TRANSP, R_E_C_N_O_ AS NUMRECSF2 "
	cQuery += "		 			FROM " + RetSQLName( "SF2" ) + " SF2 (NOLOCK) "
	cQuery += "		 		   WHERE SF2.D_E_L_E_T_ = ' ' "
	cQuery += "			 		 AND SF2.F2_FILIAL  = '" + cParamFilial  + "' "
	cQuery += "			 		 AND SF2.F2_DOC	    = '" + cParamDoc 	 + "' "
	cQuery += "			 		 AND SF2.F2_SERIE   = '" + cParamSerie 	 + "' "
	cQuery += "			 		 AND SF2.F2_CLIENTE = '" + cParamCliente + "' "
	cQuery += "			 		 AND SF2.F2_LOJA    = '" + cParamLoja 	 + "' "
	If Select( cAliasSF2 ) > 0
		( cAliasSF2 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSF2 ) New
	If !( cAliasSF2 )->( Eof() )

		aRetInfo  := {  ( cAliasSF2 )->F2_CHVNFE  ,;
			( cAliasSF2 )->F2_TRANSP  ,;
			( cAliasSF2 )->NUMRECSF2   }

	EndIf
	( cAliasSF2 )->( DbCloseArea() )

	RestArea( aAreaOld  )

Return aRetInfo
