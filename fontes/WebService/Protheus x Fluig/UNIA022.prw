
/*/{Protheus.doc} UNIA022

@project Integração Protheus x Magento
@description Rotina com o objetivo de mostrar a Lista ( Fila ) de Pedidos do Fluig
@author Rafael Rezende
@since 24/09/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"

*---------------------*
User Function UNIA022()
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
	Local cPerg         	 := "UNIA022"
	Local cTitulo   	     := "Integração Protheus x Fluig - Fila de Pedidos"
	Local cTexto	         := "<font color='red'> Integração Protheus x Fluig </font><br> Esta rotina tem como objetivo mostrar a fila de Pedidos do Fluig.<br>Selecione os parâmetros desejados e confirme a consulta</font>."
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
		Aviso( "Atenção", "O Parâmetro [ Filial até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR04 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Id Fluig até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR06 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Pedido Vendas até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. Empty( MV_PAR08 )
		Aviso( "Atenção", "O Parâmetro [ Data Pedido até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

	If lRet .And. AllTrim( MV_PAR10 ) == ""
		Aviso( "Atenção", "O Parâmetro [ Vendedor até ? ] é obrigatório.", { "Voltar" } )
		lRet := .F.
	EndIf

Return lRet


Static Function FMostraPedidos()

	Private oVerde     		:= LoadBitmap( GetResources() , "BR_VERDE" 	  ) // Liberado
	Private oVermelho 		:= LoadBitmap( GetResources() , "BR_VERMELHO" ) // Faturado
	Private oMarrom	    	:= LoadBitmap( GetResources() , "BR_MARROM"   ) // Rejeitado
	Private oAzul       	:= LoadBitmap( GetResources() , "BR_AZUL" 	  ) // Bloqueado por Crédito
	Private oCinza 		  	:= LoadBitmap( GetResources() , "BR_CINZA" 	  ) // Bloqueado por Estoque
	Private oBranco		  	:= LoadBitmap( GetResources() , "BR_BRANCO"   ) //
	Private aListPedidos	:= {}
	Private aTitListPedidos := {}
	Private aSizeListPedidos:= {}
	Private bLinesPedidos	:= { || }
	Private lMarcaDesmarca  := .T.

	Private nPosLegenda		:= 01
	Private nPosFilial		:= 02
	Private nPosPedido		:= 03
	Private nPosEmissao		:= 04
	Private nPosIdFluig		:= 05
	Private nPosCliente		:= 06
	Private nPosLoja		:= 07
	Private nPosNome		:= 08
	Private nPosValor		:= 09
	Private nPosStatus		:= 10
	Private nPosDtSepacao	:= 11
	Private nPosHrSepacao	:= 12
	Private nPosDtFaturam	:= 13
	Private nPosDtColeta	:= 14
	Private nPosDtEntrega	:= 15
	Private nPosVendedor	:= 16
	Private nPosVendNome	:= 17
	Private nPosParceiro	:= 18
	Private nPosParcNome	:= 19
	Private nPosNota		:= 20
	Private nPosSerie 		:= 21
	Private nPosChave 		:= 22
	Private nPosTransport	:= 23
	Private nPosRazao  		:= 24
	Private nPosMinuta 		:= 25
	Private nPosIdMagento	:= 26
	Private nPosInstancia	:= 27
	Private nPosRecSC5		:= 28
	Private nPosRecSF2		:= 29

	SetPrvt("oDlgLstFluig","oGrpLista","oBtnEnviar","oBtnSair","oListPedidos")

	Processa( { || FCarregaPedidos() }, "Carregando Lista de Pedidos, aguarde..." )

	oDlgLstFluig		:= MsDialog():New( 0127, 0233, 0697, 1358, "Atualiação de Status de Pedidos ",,,.F.,,,,,,.T.,,,.F. )
	oGrpLista  			:= TGroup():New( 000,008,269,502," Lista de Pedidos ",oDlgLstFluig,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	aTitListPedidos  := {}
	aSizeListPedidos := {}

	aAdd( aTitListPedidos , "" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListPedidos , "FIL" 			)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListPedidos , "PEDIDO" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB"	 ) )
	aAdd( aTitListPedidos , "DATA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB" ) )
	aAdd( aTitListPedidos , "ID.FLUIG" 		)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB" ) )
	aAdd( aTitListPedidos , "CLIENTE" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListPedidos , "LOJA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BB" 	 ) )
	aAdd( aTitListPedidos , "NOME" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBB" ) )
	aAdd( aTitListPedidos , "VALOR" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB" ) )
	aAdd( aTitListPedidos , "STATUS" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBB" ) )
	aAdd( aTitListPedidos , "DT. SEPAR." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBB" ) )
	aAdd( aTitListPedidos , "HR. SEPAR." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "DT. FATUR." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "DT. COLETA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "DT. ENTREGA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB"  ) )
	aAdd( aTitListPedidos , "VENDEDOR" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB" 	 ) )
	aAdd( aTitListPedidos , "NOME VENDEDOR" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBB" ) )
	aAdd( aTitListPedidos , "PARCEIRO" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBB" 	 ) )
	aAdd( aTitListPedidos , "NOME PARCEIRO" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBB" ) )
	aAdd( aTitListPedidos , "NOTA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBB" 	 ) )
	aAdd( aTitListPedidos , "SERIE" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBB" 	 ) )
	aAdd( aTitListPedidos , "CHAVE NOTA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBBBBBBB"  ) )
	aAdd( aTitListPedidos , "TRANSPORT." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB" 	 ) )
	aAdd( aTitListPedidos , "NOME TRANSPORT." 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBBBBBBB" ) )
	aAdd( aTitListPedidos , "MINUTA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBB" 	 ) )
	aAdd( aTitListPedidos , "ID MAGENTO" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBB" 	 ) )
	aAdd( aTitListPedidos , "INSTANCIA" 	)
	aAdd( aSizeListPedidos, GetTextWidth( 0, "BBBBBB" 	 ) )
	oListPedidos 	:= TwBrowse():New( 011, 015, 480,250,, aTitListPedidos, aSizeListPedidos, oGrpLista,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
	oListPedidos:SetArray( aListPedidos )

	bLinesPedidos	:= 				{ || { 			 aListPedidos[oListPedidos:nAt][nPosLegenda]		 				,; // 01-Legenda
		AllTrim( aListPedidos[oListPedidos:nAt][nPosFilial]  	 ) 					,; // 02-Filial
		AllTrim( aListPedidos[oListPedidos:nAt][nPosPedido]  	 ) 					,; // 03-Id. Magento
		DToC( aListPedidos[oListPedidos:nAt][nPosEmissao]   	 ) 					,; // 04- Pedido
		AllTrim( aListPedidos[oListPedidos:nAt][nPosIdFluig] 	 ) 					,; // 05- Nota
		AllTrim( aListPedidos[oListPedidos:nAt][nPosCliente] 	 ) 					,; // 06- Série
		AllTrim( aListPedidos[oListPedidos:nAt][nPosLoja]  	 	 ) 					,; // 07- Loja
		AllTrim( aListPedidos[oListPedidos:nAt][nPosNome]  	 	 ) 					,; // 08- Razão Social
		AllTrim( TransForm( aListPedidos[oListPedidos:nAt][nPosValor], "@E 999,999,999.99" ) ) ,; // 09- Data de Faturamento
		AllTrim( aListPedidos[oListPedidos:nAt][nPosStatus]  	 ) 					,; // 10- Razão Social
		DToC( aListPedidos[oListPedidos:nAt][nPosDtSepacao] 	 ) 					,; // 11- Data de Faturamento
		aListPedidos[oListPedidos:nAt][nPosHrSepacao] 	  					,; // 12- Data de Faturamento
		DToC( aListPedidos[oListPedidos:nAt][nPosDtFaturam] 	 ) 					,; // 13- Data de Coleta
		DToC( aListPedidos[oListPedidos:nAt][nPosDtColeta] 	 ) 					,; // 14- Data de Coleta
		DToC( aListPedidos[oListPedidos:nAt][nPosDtEntrega]   ) 					,; // 15- Data de Entrega
		AllTrim( aListPedidos[oListPedidos:nAt][nPosVendedor] 	 ) 					,; // 16- Vendedor
		AllTrim( aListPedidos[oListPedidos:nAt][nPosVendNome] 	 ) 					,; // 17- Nome Vendedor
		AllTrim( aListPedidos[oListPedidos:nAt][nPosParceiro] 	 ) 					,; // 18- Parceiro
		AllTrim( aListPedidos[oListPedidos:nAt][nPosParcNome] 	 ) 					,; // 19- Nome Parceiro
		AllTrim( aListPedidos[oListPedidos:nAt][nPosNota]    	 )					,; // 20- Nota
		AllTrim( aListPedidos[oListPedidos:nAt][nPosSerie]    	 )					,; // 21- Série
		AllTrim( aListPedidos[oListPedidos:nAt][nPosChave]    	 )					,; // 22- Chave
		AllTrim( aListPedidos[oListPedidos:nAt][nPosTransport]   )					,; // 23- Transportadora
		AllTrim( aListPedidos[oListPedidos:nAt][nPosRazao]    	 )					,; // 24- Noem Transportadora
		AllTrim( aListPedidos[oListPedidos:nAt][nPosMinuta]    	 )					,; // 25- Minuta
		AllTrim( aListPedidos[oListPedidos:nAt][nPosIdMagento]   )					,; // 26- Id Magento
		AllTrim( aListPedidos[oListPedidos:nAt][nPosInstancia]   )					}} // 26- Id Magento
	oListPedidos:bLine 	   		:= bLinesPedidos
	oListPedidos:bLDblClick 	:= { || FSeleciona() }
	//oListPedidos:bHeaderClick 	:= { || FSelectAll() }
	oListPedidos:Refresh()

	oBtnExcel 			:= TButton():New( 004,508,"Excel",oDlgLstFluig,,045,012,,,,.T.,,"",,,,.F. )
	oBtnExcel:bAction 	:= { || Processa( { || FExportaExcel() 	 }, "Exportando para Excel, aguarde..." ) }

	oBtnSair   			:= TButton():New( 020,508,"Sair",oDlgLstFluig,,045,012,,,,.T.,,"",,,,.F. )
	oBtnSair:bAction 	:= { || oDlgLstFluig:End() }

	oDlgLstFluig:Activate( ,,, .T. )

Return

*---------------------------*
Static Function  FSeleciona()
	*---------------------------*

	If oListPedidos:nColPos == nPosLegenda
		FLegenda()
	EndIf

Return

/*
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
*/

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
	Local nPosNFValor  	:= 03
	Local nPosNFEmissao	:= 04
	Local nPosNFMinuta	:= 05
	Local nPosNFRecNo  	:= 06
	Local aAuxInfoNF	:= {}

	aListPedidos	:= {}

	DbSelectArea( "SA1" ) // Cadastro de Clientes
	DbSetOrder( 01 ) 	  // A1_FILIAL + A1_COD
	DbSelectArea( "SA3" ) // Cadastro de endedores
	DbSetOrder( 01 ) 	  // A3_FILIAL + A3_COD
	DbSelectArea( "SA4" ) // Cadastro de Transportado
	DbSetOrder( 01 ) 	  //A4_FILIAL + A4_COD
	DbSelectArea( "CB7" ) // Cadastro de Transportado
	DbSetOrder( 01 ) 	  //A4_FILIAL + A4_COD

	cQuery := "		 SELECT C5_FILIAL	, "
	cQuery += "		 		C5_XIDFLUI	, "
	cQuery += "		 		C5_NUM		, "
	cQuery += "		 		C5_EMISSAO	, "
	cQuery += "		 		C5_NOTA		, "
	cQuery += "		 		C5_SERIE	, "
	cQuery += "		 		C5_CLIENTE	, "
	cQuery += "		 		C5_LOJACLI	, "
	cQuery += "		 		C5_XDTEXPE	, "
	cQuery += "		 		C5_XDTCOLE	, "
	cQuery += "		 		C5_XDTENTR	, "
	cQuery += "		 		C5_TRANSP   , "
	cQuery += "		 		C5_VEND1    , "
	cQuery += "		 		C5_VEND2    , "
	cQuery += "		 		C5_BLQ      , "
	cQuery += "		 		C5_LIBEROK  , "
	cQuery += "		 		C5_XDTCOLE  , "
	cQuery += "		 		C5_XDTENTR  , "
	cQuery += "		 		C5_XIDMAGE  , "
	cQuery += "		 		C5_XCODSZ8  , "
	cQuery += "				SC5.R_E_C_N_O_ AS NUMRECSC5 "
	cQuery += "		   FROM " + RetSQLName( "SC5" ) + " SC5 (NOLOCK)   "
	cQuery += "		  WHERE SC5.D_E_L_E_T_ 		 = ' ' "
	cQuery += "		    AND SC5.C5_FILIAL  BETWEEN '" + MV_PAR01 		 + "' AND '" + MV_PAR02 		+ "' "
	cQuery += "		 	AND SC5.C5_XIDFLUI BETWEEN '" + MV_PAR03 		 + "' AND '" + MV_PAR04 		+ "' "
	cQuery += "		 	AND SC5.C5_NUM     BETWEEN '" + MV_PAR05 		 + "' AND '" + MV_PAR06 		+ "' "
	cQuery += "		 	AND SC5.C5_EMISSAO BETWEEN '" + DToS( MV_PAR07 ) + "' AND '" + DToS( MV_PAR08 ) + "' "
	cQuery += "		 	AND SC5.C5_VEND1   BETWEEN '" + MV_PAR09 		 + "' AND '" + MV_PAR10 		+ "' "
	//cQuery += "		 	AND SC5.C5_XIDFLUI      != '' "
	cQuery += "	   ORDER BY SC5.C5_XIDFLUI, SC5.C5_FILIAL, SC5.C5_NUM "
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasQry ) New
	nContador := 0
	Count To nContador
	ProcRegua( nContador )
	( cAliasQry )->( DbGoTop() )
	Do While !( cAliasQry )->( Eof() )

		IncProc()

		aAuxInfoNF := {}
		If Alltrim( ( cAliasQry )->C5_NOTA ) != ""

			aAuxInfoNF := FRetInfoNota( ( cAliasQry )->C5_FILIAL , ;
				( cAliasQry )->C5_NOTA	 , ;
				( cAliasQry )->C5_SERIE	 , ;
				( cAliasQry )->C5_CLIENTE, ;
				( cAliasQry )->C5_LOJACLI  )

		EndIf

		If Len( aAuxInfoNF ) > 0

			If aAuxInfoNF[nPosNFValor] > 0

				nValor 			:= aAuxInfoNF[nPosNFValor]
				dDtFaturamento 	:= aAuxInfoNF[nPosNFEmissao]
				cChaveNota   	:= aAuxInfoNF[nPosNFChave]
				nRecNoSF2 	 	:= aAuxInfoNF[nPosNFRecNo]
				cAuxMinuta		:= aAuxInfoNF[nPosNFMinuta]
				cAuxTransp 		:= aAuxInfoNF[nPosNFTransp]

			Else

				cAuxTransp 		:= ( cAliasQry )->C5_TRANSP
				dDtFaturamento 	:= CToD( "" )
				cChaveNota   	:= ""
				nRecNoSF2 	 	:= 0
				cAuxMinuta		:= ""
				nValor 			:= FRetVlrPedido( ( cAliasQry )->C5_FILIAL 	, ;
					( cAliasQry )->C5_NUM	 	, ;
					( cAliasQry )->C5_CLIENTE	, ;
					( cAliasQry )->C5_LOJACLI   )

			EndIf

		Else

			cAuxTransp 		:= ( cAliasQry )->C5_TRANSP
			dDtFaturamento 	:= CToD( "" )
			cChaveNota   	:= ""
			nRecNoSF2 	 	:= 0
			cAuxMinuta		:= ""
			nValor 			:= FRetVlrPedido( ( cAliasQry )->C5_FILIAL 	, ;
				( cAliasQry )->C5_NUM	 	, ;
				( cAliasQry )->C5_CLIENTE	, ;
				( cAliasQry )->C5_LOJACLI   )

		EndIf

		// Descrição da Transportadora
		DbSelectArea( "SA4" )
		Seek XFilial( "SA4" ) + cAuxTransp
		If Found()
			cAuxRazaoSocial := SA4->A4_NOME
		Else
			cAuxRazaoSocial := ""
		EndIf

		// Nome do Vendedor
		cAuxVendedor 	 := ( cAliasQry )->C5_VEND1
		cAuxNomeVendedor := ""
		If AllTrim( cAuxVendedor ) != ""

			DbSelectArea( "SA3" )
			DbSetOrder( 01 )
			Seek XFilial( "SA3" ) + cAuxVendedor
			If Found()
				cAuxNomeVendedor := AllTrim( SA3->A3_NOME )
			EndIf

		EndIf

		// Nome do Parceiro de Vendas
		cAuxParceiro 	 := ( cAliasQry )->C5_VEND2
		cAuxNomeParceiro := ""
		If AllTrim( cAuxParceiro ) != ""

			DbSelectArea( "SA3" )
			DbSetOrder( 01 )
			Seek XFilial( "SA3" ) + cAuxParceiro
			If Found()
				cAuxNomeParceiro := AllTrim( SA3->A3_NOME )
			EndIf

		EndIf

		// Nome do Cliente
		DbSelectArea( "SA1" )
		Seek XFilial( "SA1" ) + ( cAliasQry )->( C5_CLIENTE + C5_LOJACLI )
		If Found()
			cAuxNomeCliente := SA1->A1_NOME
		Else
			cAuxNomeCliente := ""
		EndIf

		// Data e Hora da separação do Pedido
		dDtSeparacao := CToD( "" )
		cHrSeparacao := ""
		DbSelectArea( "CB7" )
		If AllTrim( ( cAliasQry )->C5_NOTA ) != ""
			DbSetOrder( 04 ) //	CB7_FILIAL+CB7_NOTA+CB7_SERIE+CB7_LOCAL+CB7_STATUS
			Seek ( cAliasQry )->C5_FILIAL + ( cAliasQry )->C5_NOTA + ( cAliasQry )->C5_SERIE
		Else
			DbSetOrder( 02 ) //	CB7_FILIAL+CB7_PEDIDO+CB7_LOCAL+CB7_STATUS+CB7_CLIENT+CB7_LOJA+CB7_COND+CB7_LOJENT+CB7_AGREG
			Seek ( cAliasQry )->C5_FILIAL + ( cAliasQry )->C5_NUM
		EndIf
		If Found()
			dDtSeparacao := CB7->CB7_DTFIMS
			cHrSeparacao := CB7->CB7_HRFIMS
		EndIf

		// Monta a Legenda do Pedido
		oAuxLegenda := Nil
		cAuxStatus  := ""
		If AllTrim( ( cAliasQry )->C5_NOTA ) == ""

			DbSelectArea( "SC9" )
			DbSetOrder( 01 )
			Seek ( cAliasQry )->( C5_FILIAL + C5_NUM )
			Do While !SC9->( Eof() ) .And. ;
					AllTrim( SC9->C9_FILIAL ) == Alltrim( ( cAliasQry )->C5_FILIAL ) .And. ;
					AllTrim( SC9->C9_PEDIDO ) == Alltrim( ( cAliasQry )->C5_NUM    )

				If AllTrim( SC9->C9_BLEST ) == "01"
					cAuxStatus 	:= "Bloq. Estoque"
					oAuxLegenda := oCinza
					Exit
				ElseIf AllTrim( SC9->C9_BLEST ) == "09"
					cAuxStatus 	:= "Rejeitado"
					oAuxLegenda := oMarrom
					Exit
				EndIf

				If AllTrim( SC9->C9_BLCRED ) == "01"
					cAuxStatus 	:= "Bloq. Crédito"
					oAuxLegenda := oAzul
					Exit
				ElseIf AllTrim( SC9->C9_BLCRED ) == "09"
					cAuxStatus 	:= "Rejeitado"
					oAuxLegenda := oMarrom
					Exit
				EndIf

				DbSelectArea( "SC9" )
				SC9->( DbSkip() )
			EndDo
			If AllTrim( cAuxStatus ) == ""
				cAuxStatus 	:= "Liberado"
				oAuxLegenda := oVerde
			EndIf

		Else

			cAuxStatus 	:= "Faturado"
			oAuxLegenda := oVermelho

		EndIf

		aAdd( aListPedidos, { oAuxLegenda					, ; // 01- Legenda
			( cAliasQry )->C5_FILIAL		, ; // 02- Filial
			( cAliasQry )->C5_NUM		 	, ; // 03- Pedido
			SToD( ( cAliasQry )->C5_EMISSAO )	, ; // 04- Emissão
			( cAliasQry )->C5_XIDFLUI	  	, ; // 05- Id Fluig
			( cAliasQry )->C5_CLIENTE		, ; // 06- Cliente
			( cAliasQry )->C5_LOJACLI		, ; // 07- Loja
			cAuxNomeCliente 		 	  	, ; // 08- Nome
			nValor 				  		, ; // 09- Valor
			cAuxStatus					, ; // 10- Status
			dDtSeparacao					, ; // 11- Data Separação
			cHrSeparacao 					, ; // 12- Hora Separação
			dDtFaturamento				, ; // 13- Data Faturamento
			SToD( ( cAliasQry )->C5_XDTCOLE )  	, ; // 14- Data Coleta
			SToD( ( cAliasQry )->C5_XDTENTR )  	, ; // 15- Data Entrega
			cAuxVendedor					, ; // 16- Vendedor
			cAuxNomeVendedor				, ; // 17- Nome Vendedor
			cAuxParceiro					, ; // 18- Parceiro
			cAuxNomeParceiro				, ; // 19- Nome Parceiro
			( cAliasQry )->C5_NOTA	  	, ; // 20- Nota
			( cAliasQry )->C5_SERIE	  	, ; // 21- Série
			cChaveNota			 	  	, ; // 22- Chave da Nota
			cAuxTransp					, ; // 23- Transportadora
			cAuxRazaoSocial 				, ; // 24- Nome da Transportadora
			cAuxMinuta 					, ; // 25- Código da Minuta
			( cAliasQry )->C5_XIDMAGE  	, ; // 26- Id Magento
			( cAliasQry )->C5_XCODSZ8  	, ; // 27- Instância
			( cAliasQry )->NUMRECSC5	  	, ; // 28- RecNo Pedido
			nRecNoSF2					  	} ) // 29- RecNo Nota

		DbSelectArea( cAliasQry )
		( cAliasQry )->( DbSkip() )
	EndDo
	( cAliasQry )->( DbCloseArea() )

	If Len( aListPedidos ) == 0

		aAdd( aListPedidos, { oBranco		, ; // 01- Legenda
			""			, ; // 02- Filial
			""		 	, ; // 03- Pedido
			CToD( "" )	, ; // 04- Emissão
			""		  	, ; // 05- Id Fluig
			""			, ; // 06- Cliente
			""			, ; // 07- Loja
			"" 	  		, ; // 08- Nome
			0 			, ; // 09- Valor
			""			, ; // 10- Status
			CToD( "" )	, ; // 11- Data Separação
			""			, ; // 12- Hora Separação
			CToD( "" )	, ; // 13- Data Faturamento
			CToD( "" )	, ; // 14- Data Coleta
			CToD( "" )	, ; // 15- Data Entrega
			""			, ; // 16- Vendedor
			""			, ; // 17- Nome Vendedor
			""			, ; // 18- Parceiro
			""			, ; // 19- Nome Parceiro
			""			, ; // 20- Nota
			""			, ; // 21- Série
			""			, ; // 22- Chave da Nota
			""			, ; // 23- Transportadora
			""			, ; // 24- Nome da Transportadora
			""			, ; // 25- Código da Minuta
			""  			, ; // 26- Id Magento
			""  			, ; // 27- Instância
			0		   		, ; // 28- RecNo Pedido
			0 			} ) // 29- RecNo Nota

	EndIf

	RestArea( aAreaOld )

Return

*-----------------------------*
Static Function FExportaExcel()
	*-----------------------------*
	Local oExcel 	:= FWMsExcel():New()
	Local aCabec	:= { { "FIL"			, "C" } ,;
		{ "PEDIDO"			, "C" } ,;
		{ "EMISSAO"		, "D" } ,;
		{ "ID.FLUIG"		, "C" } ,;
		{ "CLIENTE"		, "C" } ,;
		{ "LOJA"			, "C" } ,;
		{ "NOME"			, "C" } ,;
		{ "VALOR"			, "N" } ,;
		{ "STATUS"			, "C" } ,;
		{ "DT. SEPAR."		, "D" } ,;
		{ "HR. SEPAR."		, "C" } ,;
		{ "DT. FATUR."		, "D" } ,;
		{ "DT. COLETA"		, "D" } ,;
		{ "DT. ENTREGA"	, "D" } ,;
		{ "VENDEDOR"		, "C" } ,;
		{ "NOME VEND"		, "C" } ,;
		{ "PARCEIRO"		, "C" } ,;
		{ "NOME PARC"		, "C" } ,;
		{ "NOTA"			, "C" } ,;
		{ "SERIE"			, "C" } ,;
		{ "CHAVE NOTA"		, "C" } ,;
		{ "TRANSP."		, "C" } ,;
		{ "RAZÃO SOCIAL"	, "C" } ,;
		{ "MINUTA"			, "C" } ,;
		{ "ID MAGENTO"		, "C" } ,;
		{ "INSTÂNCIA"		, "C" }  }

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
		For nC := 01 To ( Len( aCabec ) )
			aAdd( aAux, aListPedidos[nL][nC+01] )
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
	Local aRetInfo  := { "", "", 0, "", "", 0 }

	cQuery := "		 		  SELECT F2_CHVNFE, F2_TRANSP, F2_VALBRUT, F2_EMISSAO, F2_XMINUTA, R_E_C_N_O_ AS NUMRECSF2 "
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

		aRetInfo  := {  ( cAliasSF2 )->F2_CHVNFE  	,;
			( cAliasSF2 )->F2_TRANSP  	,;
			( cAliasSF2 )->F2_VALBRUT 	,;
			SToD( ( cAliasSF2 )->F2_EMISSAO ) ,;
			( cAliasSF2 )->F2_XMINUTA	,;
			( cAliasSF2 )->NUMRECSF2     }

	EndIf
	( cAliasSF2 )->( DbCloseArea() )

	RestArea( aAreaOld  )

Return aRetInfo


Static Function FRetVlrPedido( cParamFilial, cParamNum, cParamCliente, cParamLoja )

	Local aAreaOld  := GetArea()
	Local cAliasSC5 := GetNextAlias()
	Local cQuery 	:= ""
	Local nRet	  	:= 0

	cQuery := "	  SELECT SUM( C6_VALOR ) AS VALOR "
	cQuery += "		FROM " + RetSQLName( "SC6" ) + " SC6 (NOLOCK) "
	cQuery += "	   WHERE SC6.D_E_L_E_T_ = ' ' "
	cQuery += "		 AND SC6.C6_FILIAL  = '" + cParamFilial  + "' "
	cQuery += "		 AND SC6.C6_NUM	    = '" + cParamNum 	 + "' "
	cQuery += "		 AND SC6.C6_CLI 	= '" + cParamCliente + "' "
	cQuery += "		 AND SC6.C6_LOJA    = '" + cParamLoja 	 + "' "
	If Select( cAliasSC5 ) > 0
		( cAliasSC5 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSC5 ) New
	If !( cAliasSC5 )->( Eof() )
		nRet  := ( cAliasSC5 )->VALOR
	EndIf
	( cAliasSC5 )->( DbCloseArea() )

	RestArea( aAreaOld  )

Return nRet


Static Function FLegenda()

	Local aLegenda  := { { "BR_VERDE"	, "Liberado" 				} ,;
		{ "BR_VERMELHO", "Faturado" 				} ,;
		{ "BR_AZUL" 	, "Bloqueado por Crédito"   } ,;
		{ "BR_CINZA" 	, "Bloqueado por Estoque"   } ,;
		{ "BR_MARROM"  , "Rejeitado"	  			}  }

	BrwLegenda( "Status Ped. Fluig", "Legenda", aLegenda )

Return
