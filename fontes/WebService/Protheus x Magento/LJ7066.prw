
/*/{Protheus.doc} LJ7066

Descrio:
Este

@project Integrao Protheus x Magento
@description Ponto de entrada pertence  rotina de gravao do pedidos de venda pelo Loja LJGRVBATCH,  executado aps a gravao das informaes. Seu objetivo  a gravao da informao do Id do Pedido do Magento que est no Oramento do Loja trazendo assim a informao para o Pedido de Vendas
@author Rafael Rezende
@since 11/06/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*--------------------*
User Function LJ7066()
	*--------------------*
	Local aAreaAnt 		:= GetArea()
	Local aAreaSC5 		:= SC5->( GetArea() )
	Local aAreaSC9 		:= SC9->( GetArea() )
	Local aAreaSL1 		:= SL1->( GetArea() )
	Local aAreaSL4 		:= SL4->( GetArea() )
	Local aAreaSA1 		:= SA1->( GetArea() )
	Local aAreaSC6 		:= SC6->( GetArea() )
	Local aAreaSF4 		:= SF4->( GetArea() )
	Local aAreaSB1 		:= SB1->( GetArea() )

	//Busca o Id Magento no Oramento
	//DbSelectArea( "SC5" )
	//DbSetOrder( 01 ) // C5_FILIAL + C5_NUM
	//Seek XFilial( "SC5" ) + SC5->C5_ORCRES
	//If Found()

	ConOut( "PONTO DE ENTRADA LJ7066 - Atualizando alguns campos no Pedido de Vendas - SL1 - Oramento [ " + SL1->L1_NUM 	+ " ] " )
	ConOut( "PONTO DE ENTRADA LJ7066 - Atualizando alguns campos no Pedido de Vendas - SL1 - IDMAGENTO [ " + SL1->L1_XIDMAGE+ " ] " )
	ConOut( "PONTO DE ENTRADA LJ7066 - Atualizando alguns campos no Pedido de Vendas - SC5 - Oramento [ " + SC5->C5_ORCRES + " ] " )
	ConOut( "PONTO DE ENTRADA LJ7066 - Atualizando alguns campos no Pedido de Vendas - SC5 - IDMAGENTO [ " + SC5->C5_XIDMAGE + " ] " )

	If ( AllTrim( SL1->L1_XIDMAGE ) != "" .Or. ;
			AllTrim( SL1->L1_NROPCLI ) != "" )

		ConOut( "	PE - LJ7066 - Atualizando campos do PV a partir do Oramento: " )
		ConOut( "		- C5_XIDMAGE <-- L1_XIDMAGE - " + SL1->L1_XIDMAGE )
		ConOut( "		- C5_FRETE 	 <-- L1_FRETE   - " + AllTrim( Str( SL1->L1_FRETE ) ) )
		ConOut( "		- C5_TRANSP  <-- L1_TRANSP  - " + SL1->L1_TRANSP  )
		ConOut( "		- C5_CONDPAG <-- L1_CONDPG  - " + SL1->L1_CONDPG  )
		ConOut( "		- C5_XCODSZ8 <-- L1_XCODSZ8 - " + SL1->L1_XCODSZ8 )
		ConOut( "		- C5_XIDFLUI <-- L1_NROPCLI - " + SL1->L1_NROPCLI )
		ConOut( "		- C5_TPFRETE <-- L1_TPFRET  - " + SL1->L1_TPFRET  )
		ConOut( "		- C5_VEND2 	 <-- L1_VEND2   - " + SL1->L1_VEND2 )
		ConOut( "		- C5_VEND2 	 <-- L1_XVEND2  - " + SL1->L1_XVEND2 )
		ConOut( "		- C5_MENNOTA <-- NUM PEDIDO"  )
		ConOut( "		- C5_XPEDMKT <-- L1_XPEDMKT  - " + SL1->L1_XPEDMKT )

		// Grava o Id Magento no Pedido
		DbSelectArea( "SC5" )
		RecLock( "SC5", .F. )

		SC5->C5_XIDMAGE := SL1->L1_XIDMAGE

		if !empty(SL1->L1_XIDMAGE)
			SC5->C5_VEND2	:= SL1->L1_VEND2
		else
			SC5->C5_VEND2	:= SL1->L1_XVEND2
		endIf
		SC5->C5_FRETE   := SL1->L1_FRETE
		SC5->C5_TRANSP	:= SL1->L1_TRANSP
		SC5->C5_CONDPAG	:= SL1->L1_CONDPG
		SC5->C5_XCODSZ8 := SL1->L1_XCODSZ8
		SC5->C5_XIDFLUI := SL1->L1_NROPCLI
		SC5->C5_TPFRETE := SL1->L1_TPFRET
		SC5->C5_XPEDMKT := SL1->L1_XPEDMKT
		SC5->C5_MENNOTA := "PEDIDO: " + SC5->C5_NUM + "/" + ;
			"Endereo de Entrega: "+Alltrim(SA1->A1_ENDENT)+;
			iif(Alltrim(SA1->A1_COMPENT)<>"",", "+Alltrim(SA1->A1_COMPENT),"")+;
			", "+Alltrim(SA1->A1_BAIRROE) + ;
			", "+Alltrim(SA1->A1_MUNE) + ;
			", "+Alltrim(SA1->A1_ESTE) + ;
			", "+Alltrim(SA1->A1_CEPE) + "/" + ;
			"Cond.Pagto: " + Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_DESCRI") + Chr(13) + Chr(10)
		SC5->C5_XOBS := SL1->L1_XOBS // Marcelo Amaral 11/11/2019
		//Marcelo Amaral 25/10/2019
		SC5->C5_TIPLIB := "2"
		//If SL1->L1_DESCNF > 0
		//	SC5->C5_DESC01  := SL1->L1_DESCNF //( ( SL1->L1_DESCON / SL1->L1_VLRTOT ) * 100 )
		//EndIf

		SC5->( MsUnLock() )

		If AllTrim( SL1->L1_XIDMAGE ) != ""

			cNumLoteLog := GetSXENum( "SZ5", "Z5_CODIGO" )
			ConfirmSX8()
			cMsgErro 	:= "Gerado o Pedido de vendas [ " + SC5->C5_NUM + " ] Executada para o Pedido Magento [ " + SL1->L1_XIDMAGE + " ]."
			cMsgComp 	:= cMsgErro
			ConOut( "Log Magento - " + cMsgErro )
			U_UNIGrvLog( cNumLoteLog , SL1->L1_NUM,	 SL1->L1_XIDMAGE, "LJ7066",  "", cMsgErro	, cMsgComp	 , "SL1" , SL1->( RecNo() ) )

		EndIf

	EndIf

	// Realiza tratativa para TES
	DbSelectArea( "SL1" )
	DbSetOrder( 01 )
	Seek SL1->( L1_FILIAL + L1_NUM )
	If Found()

		ConOut( "	PONTO DE ENTRADA LJ7066	- Realiza tratativa para TES " )


		aAuxTES := {}
		cAuxTES := ""
		DbSelectArea( "SA1" )
		DbSetOrder( 01 )
		Seek XFilial( "SA1" ) + SC5->( C5_CLIENTE + C5_LOJACLI )
		If Found()
			aAuxTES := U_UNIVerTES( SC5->C5_FILIAL, SA1->A1_ESTE, SA1->A1_TIPO, SL2->L2_ENTREGA )
			If Len( aAuxTES ) > 0
				cAuxTES := aAuxTES[02]
			EndIf
			If AllTrim( cAuxTES ) == ""
				cAuxTES := AllTrim( GetMv( "MV_TESSAI" ) )
			EndIf
		Else
			cAuxTES := AllTrim( GetMv( "MV_TESSAI" ) )
		EndIf

		DbSelectArea( "SF4" )
		DbSetOrder( 01 )
		Seek XFilial( "SF4" ) + cAuxTES
		If Found()

			DbSelectArea( "SC6" )
			DbSetOrder( 01 )
			Seek SC5->( C5_FILIAL + C5_NUM )
			Do While !SC6->( Eof() ) .And. ;
					AllTrim( SC6->C6_FILIAL ) == AllTrim( SC5->C5_FILIAL ) .And. ;
					AllTrim( SC6->C6_NUM    ) == AllTrim( SC5->C5_NUM    )

				DbSelectArea( "SC6" )
				RecLock( "SC6", .F. )
				SC6->C6_TES := SF4->F4_CODIGO
				SC6->C6_CF  := SF4->F4_CF
				SC6->( MsUnLock() )

				If AllTrim(SC6->C6_CF) $ "6108,6117"
					RecLock( "SC5", .F. )
					SC5->C5_MSGNFE := Alltrim(SC5->C5_MENNOTA) + CRLF + "Valor do ICMS destinado a UF de destino: R$0,00. Cobrança do ICMS - Destino, devido" +;
						" ao Estado à título de Diferencial de Alíquota - DIFAL, afastada pela decisão do STF no Rext n." +;
						" 1287019 - Tema de Repercussão Geral 1093 - ADI 5469. Efeitos produzidos pelas alterações trazidas" +;
						" pela PL n.32/21 na Lei Complementar n. 87/96, somente após 90 (noventa) dias da data de sua " +;
						" publicação (DOU 05.01.22 PÁG 01 COL 01 - Lei Complementar 190/2022 x PL n. 32/21), conforme o" +;
						" artigo 180, inc. III da Constituição Federal de 1988."
					SC5->( MsUnLock() )
				EndIf

				//****************** Adicionado por Luiz Otavio  para atualizar a tributação do pedido para as filiais do ES ***************/

				lICM12:= SuperGetMV("MV_XICM12",, .F.)

				If lICM12
					ConOut( "	PONTO DE ENTRADA LJ7066	- Atualiza tributacao para Filial ES" )
					DbSelectArea("SB1")
					DbSetOrder(1)
					dbSeek(xFilial("SB1")+SC6->C6_PRODUTO)
					If SB1->B1_ORIGEM $ "1|2|3|8" // Considero produtos importados
						DbSelectArea( "SC6" )
						RecLock( "SC6", .F. )
						SC6->C6_CLASFIS:= "000"
						SC6->( MsUnLock() )
					EndIf
				EndIf

				/***************************  Fim da Atualizacao ***********************************************************/

				DbSelectArea( "SC6" )
				SC6->( DbSkip() )
			EndDo

		EndIf

	EndIf

	//Verifica se precisa bloquear o Pedido de Vendas
	lAuxBloqueia := .F.
	If AllTrim( SL1->L1_XIDMAGE ) == ""

		DbSelectArea( "SL4" )
		DbSetOrder( 01 )
		Seek SL1->( L1_FILIAL + L1_NUM )
		Do While !SL4->( Eof() ) .And. ;
				AllTrim( SL4->L4_FILIAL ) == AllTrim( SL1->L1_FILIAL ) .And. ;
				AllTrim( SL4->L4_NUM    ) == AllTrim( SL1->L1_NUM    )

			If AllTrim( SL4->L4_FORMA ) $ "BO.DP"
				lAuxBloqueia := .T.
				Exit
			EndIf

			DbSelectArea( "SL4" )
			SL4->( DbSkip() )
		EndDo

	EndIf

	If lAuxBloqueia

		DbSelectArea( "SC9" )
		DbSetOrder( 01 )
		Seek SC5->( C5_FILIAL + C5_NUM )
		Do While !SC9->( Eof() ) .And. ;
				Alltrim( SC9->C9_FILIAL ) == AllTrim( SC5->C5_FILIAL ) .And. ;
				Alltrim( SC9->C9_PEDIDO ) == AllTrim( SC5->C5_NUM    )

			RecLock( "SC9", .F. )
			SC9->C9_BLCRED := "01"
			SC9->( MsUnLock() )

			DbSelectArea( "SC9" )
			SC9->( DbSkip() )
		EndDo

	EndIf

	U_GRVTESC9()// Grava o TES na SC9

	//EndIf

	RestArea( aAreaSA1 )
	RestArea( aAreaSC6 )
	RestArea( aAreaSF4 )

	RestArea( aAreaSB1 )
	RestArea( aAreaSC9 )
	RestArea( aAreaSL4 )
	RestArea( aAreaSL1 )
	RestArea( aAreaSC5 )
	RestArea( aAreaAnt )

Return
