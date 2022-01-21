
/*/{Protheus.doc} MT410INC

Descrição:
Este

@project Integração Protheus x Magento
@description Ponto de entrada pertence à rotina de pedidos de venda, MATA410(). Está localizado na rotina de alteração do pedido, A410INCLUI(). É executado após a gravação das informações. Seu objetivo é a gravação da informação do Id do Pedido do Magento que está no Orçamento do Loja trazendo assim a informação para o Pedido de Vendas
@author Rafael Rezende
@since 11/06/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

#DEFINE _cEnt Chr(10)+Chr(13)


User Function MT410INC()

	Local aAreaOld 		:= GetArea()
	Local aAreaSA1 		:= SA1->( GetArea() )
	Local aAreaSL1 		:= SL1->( GetArea() )
	Local aAreaSC5 		:= SC5->( GetArea() )
	Local aAreaSC6 		:= SC6->( GetArea() )
	Local aAreaSF4 		:= SF4->( GetArea() )
	Local aAreaSB1 		:= SB1->( GetArea() )

	// ---- INCIO ---- LEANDRO RIBEIRO ---- 28/11/2019 ---- //
	Local _cEndEnt  	:= REPLACE(REPLACE(SA1->A1_ENDENT ,CHAR(13) + Char(10) ,' '), CHAR(10), ' ')
	Local _cCompEnt     := REPLACE(REPLACE(SA1->A1_COMPENT,CHAR(13) + Char(10) ,' '), CHAR(10), ' ')
	Local _cBairroE     := REPLACE(REPLACE(SA1->A1_BAIRROE,CHAR(13) + Char(10) ,' '), CHAR(10), ' ')
	Local _cMunEnt      := REPLACE(REPLACE(SA1->A1_MUNE   ,CHAR(13) + Char(10) ,' '), CHAR(10), ' ')
	// ---- FIM ------ LEANDRO RIBEIRO ---- 28/11/2019 ---- //
	ConOut( "PONTO DE ENTRADA MT410INC - Atualizando alguns campos no Pedido de Vendas - SL1 - Orçamento [ " + SL1->L1_NUM 	+ " ] " )
	ConOut( "PONTO DE ENTRADA MT410INC - Atualizando alguns campos no Pedido de Vendas - SL1 - IDMAGENTO [ " + SL1->L1_XIDMAGE+ " ] " )
	ConOut( "PONTO DE ENTRADA MT410INC - Atualizando alguns campos no Pedido de Vendas - SC5 - Orçamento [ " + SC5->C5_ORCRES + " ] " )
	ConOut( "PONTO DE ENTRADA MT410INC - Atualizando alguns campos no Pedido de Vendas - SC5 - IDMAGENTO [ " + SC5->C5_XIDMAGE+ " ] " )
	// ---- INCIO ---- LEANDRO RIBEIRO ---- 28/11/2019 ---- //
	/*
DbSelectArea( "SC5" )
RecLock( "SC5", .F. )
	SC5->C5_MENNOTA := "PEDIDO: " + SC5->C5_NUM + "/" + ;
	"Endereço de Entrega: "+Alltrim(SA1->A1_ENDENT)+;
	iif(Alltrim(SA1->A1_COMPENT)<>"",", "+Alltrim(SA1->A1_COMPENT),"")+;
	", "+Alltrim(SA1->A1_BAIRROE) + ;
	", "+Alltrim(SA1->A1_MUNE) + ;
	", "+Alltrim(SA1->A1_ESTE) + ;
	", "+Alltrim(SA1->A1_CEPE) + "/" + ;
	"Cond.Pagto: " + Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_DESCRI") + Chr(13) + Chr(10)
SC5->( MsUnLock() )
	*/


	DbSelectArea( "SC5" )
	RecLock( "SC5", .F. )
	SC5->C5_MENNOTA := "PEDIDO: " + SC5->C5_NUM + "/" + ;
		"Endereço de Entrega: "+Alltrim(_cEndEnt)+;
		iif(Alltrim(_cCompEnt)<>"",", "+Alltrim(_cCompEnt),"")+;
		", "+Alltrim(_cBairroE)    + ;
		", "+Alltrim(_cMunEnt)     + ;
		", "+Alltrim(SA1->A1_ESTE) + ;
		", "+Alltrim(SA1->A1_CEPE) + "/" + ;
		"Cond.Pagto: " + Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_DESCRI") + Chr(13) + Chr(10)
	SC5->( MsUnLock() )
	// ---- FIM ------ LEANDRO RIBEIRO ---- 28/11/2019 ---- //
	//Busca o Id Magento no Orçamento
	DbSelectArea( "SL1" )
	DbSetOrder( 01 ) // L1_FILIAL + L1_NUM
	Seek XFilial( "SL1" ) + SC5->C5_ORCRES
	If Found()

		If ( AllTrim( SL1->L1_XIDMAGE ) != "" .Or. ;
				AllTrim( SL1->L1_NROPCLI ) != "" )

			ConOut( "	PE - MT410INC - Atualizando campos do PV a partir do Orçamento: " )
			ConOut( "		- C5_XIDMAGE <-- L1_XIDMAGE - " + SL1->L1_XIDMAGE )
			ConOut( "		- C5_FRETE 	 <-- L1_FRETE   - " + AllTrim( Str( SL1->L1_FRETE ) ) )
			ConOut( "		- C5_TRANSP  <-- L1_TRANSP  - " + SL1->L1_TRANSP  )
			ConOut( "		- C5_CONDPAG <-- L1_CONDPG  - " + SL1->L1_CONDPG  )
			ConOut( "		- C5_XCODSZ8 <-- L1_XCODSZ8 - " + SL1->L1_XCODSZ8 )
			ConOut( "		- C5_XIDFLUI <-- L1_NROPCLI - " + SL1->L1_NROPCLI )
			ConOut( "		- C5_VEND2 	 <-- L1_VEND2   - " + SL1->L1_VEND2 )
			ConOut( "		- C5_VEND2 	 <-- L1_XVEND2  - " + SL1->L1_XVEND2 )
			ConOut( "		- C5_MENNOTA <-- PEDIDO: XXXXXX" )

			// Grava o Id Magento no Pedido
			DbSelectArea( "SC5" )
			RecLock( "SC5", .F. )
			SC5->C5_XIDMAGE := SL1->L1_XIDMAGE
			If !empty(SL1->L1_XIDMAGE)
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
			/*
			SC5->C5_MENNOTA := "PEDIDO: " + SC5->C5_NUM + "/" + ;
			"Endereço de Entrega: "+Alltrim(SA1->A1_ENDENT)+;
			iif(Alltrim(SA1->A1_COMPENT)<>"",", "+Alltrim(SA1->A1_COMPENT),"")+;
			", "+Alltrim(SA1->A1_BAIRROE) + ;
			", "+Alltrim(SA1->A1_MUNE) + ;
			", "+Alltrim(SA1->A1_ESTE) + ;
			", "+Alltrim(SA1->A1_CEPE) + "/" + ;
			"Cond.Pagto: " + Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_DESCRI")
			*/
			SC5->C5_XOBS := SL1->L1_XOBS // Marcelo Amaral 11/11/2019
			//Marcelo Amaral 25/10/2019
			SC5->C5_TIPLIB := "2"
			//If SL1->L1_DESCNF > 0
			//	SC5->C5_DESC01  := SL1->L1_DESCNF
			//EndIf
			SC5->( MsUnLock() )

		EndIf

		// Tratativa da TES
		DbSelectArea( "SL1" )
		DbSetOrder( 01 )
		Seek SL1->( L1_FILIAL + L1_NUM )
		If Found()

			aAuxTES := {}
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

					DbSelectArea( "SC6" )
					SC6->( DbSkip() )
				EndDo

			EndIf

		EndIf

	EndIf



	//***************************************************************************************************************************
	//Adicionado por Luiz Otávio - em 29/04/2021
	//Inclusao de Parametro para habilitar
	//******************* Motivo: Atualizar a tributação de produtos importados com origem do ES *********************************

	lICM12:= SuperGetMV("MV_XICM12",, .F.)

	If lICM12

		ConOut( "	PE - MT410INC - Atualizando campos do PV a partir do Orçamento: " )
		ConOut( "	Atualizando campo C6_CLASFISS para tributar com 12% produtos importados." )


		DbSelectArea( "SC6" )
		DbGotop()
		DbSetOrder( 01 )
		DbSeek(SC5->C5_FILIAL + SC5->C5_NUM )

		Do While !SC6->( Eof() ) .And.  AllTrim( SC6->C6_FILIAL ) == AllTrim( SC5->C5_FILIAL ) .And. ;
				AllTrim( SC6->C6_NUM    ) == AllTrim( SC5->C5_NUM    )

			DbSelectArea("SB1")
			DbSetOrder(1)
			dbSeek(xFilial("SB1")+SC6->C6_PRODUTO)
			If SB1->B1_ORIGEM $ "1|2|3|8" // Considero produtos importados

				ConOut( "PE - MT410INC -	Atualizando campo C6_CLASFISS para tributar com 12% produtos importados." )

				DbSelectArea( "SC6" )
				RecLock( "SC6", .F. )
				SC6->C6_CLASFIS:= "000"
				SC6->( MsUnLock() )
			EndIf
			DbSelectArea( "SC6" )
			DbSkip()
		EndDo
	EndIf

	//*********************************************FIM DA ALTERAÇÃO **************************************************************



	U_GRVTESC9()
	RestArea( aAreaSA1 )
	RestArea( aAreaSB1 )
	RestArea( aAreaSL1 )
	RestArea( aAreaSC5 )
	RestArea( aAreaSC6 )
	RestArea( aAreaSF4 )
	RestArea( aAreaOld )

Return

