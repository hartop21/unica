#Include "TOTVS.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "SPEDNFE.ch"
#Include "TOTVS.ch"
#INCLUDE "APWIZARD.CH"
#INCLUDE "FILEIO.CH"
#DEFINE TAMMAXXML 400000 //- Tamanho maximo do XML em bytes
#DEFINE CRLF Chr(13) + Chr(10)
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºPrograma  ³ WSREP001º Autor ³Homero Júnior        º Data ³  16/02/2020 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ API da Koncilia para busca de pedidos já Konciliados dentroº±±
±±º			 ³ da plataforma WEB e retorna no JSON para ser Konciliado	  º±±
±±º			 ³ dentro do ERP e marcado como resolvido na plataforma       º±±
±±º			 ³ afim de que não seja retornado novamente na requisição.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ UNICA ARCONDICIONADO                                     º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function WSREP001()
	Local lRet := .F.
	Local aReturn := {}
	Local cIDs := ""
	Local oWsdl
	Local xRet
	Local cError := ""
	Local cWarning := ""
	Local cResp := ""
	Private aParams := {"01","0101"}
	PREPARE ENVIRONMENT EMPRESA aParams[1] FILIAL aParams[2]
	Private cUserName := "TOTVS"
	Private nTamA6Banc := TamSX3("A6_COD")[1]
	Private  nTamA6Agen := TamSX3("A6_AGENCIA")[1]
	Private nTamA6Nume := TamSX3("A6_NUMCON")[1]
	Private _dDatBai := dDatabase
	Private _xx := 0
	Private nPage := 0
	Private nRecs := 0
	Private nVlOutCr := 0
	Private nVlrComi := 0
	Private aOrdeCod := {}
	Private cConcili := "38833"
	Private initDate := '2019-05-01'
	Private endDate  :=  '2020-03-27
	Private cCanal := "B2W" //
	Private nVenda
	Private nRfndCom := 0
	Private nParcNum := ""
	Private nEstVenda
	Private nComiCanc
	Private nOutrDeb
	Private nOutrCred
	Private aPedsTot := {}
	Private nVenda := 0
	Private nComisao := 0
	Private nEstVenda := 0
	Private nComiCanc := 0
	Private nOutrDeb := 0
	Private nOutrCred := 0
	Private nVlrCoRef := 0 //Valor ref. a comissão do ressarcimento da promoção
	Private nVlrRePro := 0 //Valor ref. ao ressarcimento da promoção
	Private aDiffer := {}
	Private lContunua := .T.
	Private cNumTitDev := 0
	Private aPedidos := {}
	Private aTpNoFnd := {}
	Private cTitJBaix := ""
	Private cVndNotFin := ""
	Private cPedBrnco := ""
	Private cVndNotFnd := ""
	Private cNotFndERP := ""
	Private aCntMKT		:= {}
	Private aConta		:= {}
	//_dDatBai := StoD("20190916")
	SD2->(DbSelectArea("SD2"))
	SD2->(DbSetOrder(08)) // D2_FILIAL + D2_PEDIDO + D2_ITEMPV
	SE1->(DbSelectArea("SE1"))
	SE1->(DbSetOrder(02)) // E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO
	SA1->(DbSelectArea("SA1"))
	SCJ->(DbSelectArea("SL1"))
	SC5->(DbSelectArea("SC5"))
	//SCJ->(DbOrderNickname("PEDMKT"))//CJ_FILIAL + CJ_XPEDMKT
	SC5->(DbSetOrder(10))
	/*------------------------------------------------------
Magazine Luiza:  Santander Ag 3455 CC 13003733-9 (FF)
- ok
B2W:             Santander Ag 3455 CC 13003733-9 (FF) e Itaú Ag 6824 CC 43395-4 (FF)  - ok
Mercado Livre:   Santander Ag 3455 CC 13003733-9 (FF) - ok
CNOVA:           Itaú      Ag 6824 CC 32128-2 (FF)
 - ok
ZOOM:            Santander Ag 3455 CC 13003733-9 (FF) - ok
Carrefour:       Santander Ag 3455 CC 13003733-9 (FF) - ok
Amazon:          Santander Ag 3455 CC 13003733-9 (FF) - ok
	------------------------------------------------------*/
	//De para em contas baixa
	aADD(aCntMKT,GetNewPar("MV_XCNTCNV",{"CNOVA","341","6824","32128"})) //CNOVA (VIA VAREJO)
	aADD(aCntMKT,GetNewPar("MV_XCNTMLV",{"MERCADO_LIVRE","033","3455","13003733"})) // Mercado Livre
	aADD(aCntMKT,GetNewPar("MV_XCNTB2W",{"B2W","033","3455","13003733"})) //B2W ???E quando deve-se usar a conta do itau????
	aADD(aCntMKT,GetNewPar("MV_XCNTCRF",{"CARREFOUR","033","3455","13003733"})) //Carrefour
	aADD(aCntMKT,GetNewPar("MV_XCNTMGL",{"MAGALU","033","3455","13003733"})) //Magazile Luiza
	aADD(aCntMKT,GetNewPar("MV_XCNTAWS",{"AMAZON","033","3455","13003733"})) //Amazon
	aADD(aCntMKT,GetNewPar("MV_XCNTZOM",{"ZOOM","033","3455","13003733"})) //Zoom

	aJsonfields := u_AKonclia()
	aAdd(aPedsTot,aJsonfields[1][2][3][2])
	For __nn := 1 To (Int(aJsonfields[1][2][2][2][3][2] / 100) + 1)
		aJsonfields := u_AKonclia(nPage+=100)
		aAdd(aPedsTot,aJsonfields[1][2][3][2])
	Next
	nPage := 0
	aJsonfields := {}
	aJsonfields := u_AKonclia()
	For __bb := 1 To Len(aCntMKT)
		nPosCh := aScan(aCntMKT,{|x|,x[1]==aJsonfields[1][2][3][2][1][2][12][2]})
		If nPosCh > 0
			Exit
		EndIf
	Next
	For __dd := 1 To (Int(aJsonfields[1][2][2][2][3][2] / 100) + 1) //Número de páginas
		If Len(aJsonfields[1][2][3][2]) > 0 //.And. nRecs > 0 //Tem registros na integração e a query achou esse pedido com o ID Marktplace
			For _xx := 1 To Len(aJsonfields[1][2][3][2]) //Tamanho da página
				nRecs := RodaQry()
				If nRecs == 0 .And. cConcili $ cValToChar(aJsonfields[1][2][3][2][_xx][2][28][2])
					ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUsername + " - Na conciliação " + cConcili + " o pedido MKT/WEB " + aJsonfields[1][2][3][2][_xx][2][5][2] + " não foi localizado no Protheus, portanto não será conciliado.")
					cNotFndERP += "Na conciliação " + cConcili + " o pedido MKT/WEB " + aJsonfields[1][2][3][2][_xx][2][5][2] + " não foi localizado no Protheus SL1 X SE1, portanto não será conciliado." + CRLF
				EndIf
				If !cConcili $ cValToChar(aJsonfields[1][2][3][2][_xx][2][28][2]) .Or. nRecs == 0
					Loop
				EndIf
				For __hh := 1 To Len(aPedsTot)
					For __ll := 1 To Len(aPedsTot[__hh])
						If (nPos := aScan(aPedsTot[__hh][__ll][2][5], {|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]})) > 0
							If aScan(aPedidos,{|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]}) == 0 .And. aPedsTot[__hh][__ll][2][18][nPos] == "RETURN_COMISSION"
								aAdd(aPedidos,aJsonfields[1][2][3][2][_xx][2][5][2])
								CmpEsVda()  //compensação da NCC com a NF pois é uma devolução fora do prazo não pode seguir e tentar baixar a venda.
								nVlrCria := FindTipo("PROMOTION_REFUND") // RESSARCIMENTO PROMOÇÃO REBATE 100
								If nVlrCria > 0
									RecComRef(nVlrCria,0,"") //cria o titulo de 100
								EndIf
								nVlrComi := FindTipo("COMISSION") //
								If nVlrComi > 0
									u_ADMOVBCO("COMISSION","TB",nVlrComi,cNumTitDev)
								EndIf
								nVlrReCom := FindTipo("PROMOTION_REFUND_COMISSION") //
								If nVlrReCom > 0
									u_ADMOVBCO("PROMOTION_REFUND_COMISSION","TD",nVlrReCom,cNumTitDev) //
								EndIf
								Exit
							Else
								Loop
							EndIf
						EndIf
					Next
				Next
				If !aJsonfields[1][2][3][2][_xx][2][30][2]
					cIDs += cValToChar(aJsonfields[1][2][3][2][_xx][2][1][2]) + "," //para usar posteriormente para marcar como resolvidos no koncili
				EndIf
				If aJsonfields[1][2][3][2][_xx][2][18][2] == "SALE" .Or. aJsonfields[1][2][3][2][_xx][2][18][2] == "UNBLOCK_SALE" // .And. "5787" $ aJsonfields[1][2][3][2][_xx][2][26][2] // Acumulando vendas
					nVenda += aJsonfields[1][2][3][2][_xx][2][20][2]
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "COMISSION" .Or. aJsonfields[1][2][3][2][_xx][2][18][2] == "UNBLOCK_COMISSION" //.And. "5787" $ aJsonfields[1][2][3][2][_xx][2][26][2]
					nComisao += aJsonfields[1][2][3][2][_xx][2][20][2] // Acumulando comissao
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "PROMOTION_REFUND_COMISSION"
					nComisao += aJsonfields[1][2][3][2][_xx][2][20][2] // Acumulando comissao
					nRfndCom += aJsonfields[1][2][3][2][_xx][2][20][2] // Acumulando comissao REFUND (ressarcimento de comissao)
					//				If SD2->(DbSeek(xFilial("SD2") + TMP->C5_NUM ))
					//					u_ADOTRCDT("B2W","00001","0000000001",nRfndCom,SD2->D2_DOC)
					//				Else
					//					ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUsername + " Pedido não localizado ou Numero do pedido em branco no TMP->C5_NUM, ID pedido Marktplace-> " + aJsonfields[1][2][3][2][_xx][2][5][2] )
					//				EndIf
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "RETURN_SALE" //.And. "5787" $ aJsonfields[1][2][3][2][_xx][2][26][2]
					nEstVenda += aJsonfields[1][2][3][2][_xx][2][20][2] // Acumulando estorno da venda
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "COMISSION_SALE_CANCELED" //.And. "5787" $ aJsonfields[1][2][3][2][_xx][2][26][2]
					nComiCanc += aJsonfields[1][2][3][2][_xx][2][20][2] // Acumulando comissao cancelamento // EXECUTAR UMA TRANSFERENCIA BANCARIA DA CONTA 76 PARA BW2/CNOVA ETC... CANAL QUE ESTA SENDO CONCILIADO
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "ADDITIONAL_FEE" //.And. "5787" $ aJsonfields[1][2][3][2][_xx][2][26][2]
					nOutrDeb += aJsonfields[1][2][3][2][_xx][2][20][2] // Acumulando outros débitos
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "PROMOTION_REFUND" //.And. "5787" $ aJsonfields[1][2][3][2][_xx][2][26][2]  //outros créditos
					nOutrCred += aJsonfields[1][2][3][2][_xx][2][20][2]
				ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "INCOME_TAX" // verificar possibilidade de baixar dentro da conta b2W
					nOutrCred += aJsonfields[1][2][3][2][_xx][2][20][2]
					//			ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "RETURN_COMISSION"
				Else
					ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUsername + " Não é nenhum dos tipos esperados " )
					aAdd(aTpNoFnd,aJsonfields[1][2][3][2][_xx][2][18][2]) // Exemplo RETURN_COMISSION -- RETURN_PROMOTION //ADJUSTMENT Veio no cnova //DEVOLUTION cnova
				EndIf
				If  "Imposto de Renda" $ aJsonfields[1][2][3][2][_xx][2][5][2] .Or. (nRecs > 0 .And. cConcili $ cValToChar(aJsonfields[1][2][3][2][_xx][2][28][2]) )
					If aJsonfields[1][2][3][2][_xx][2][18][2] == "SALE" .Or. aJsonfields[1][2][3][2][_xx][2][18][2]	== "UNBLOCK_SALE" // Só estou considerando as vendas pois essas foram conciliadas na plataforma
						SE1->(DbGoto(TMP->E1RECNO))
						If  SE1->E1_SALDO > 0 //cValToChar(SE1->E1_BAIXA) == "  /  /  "
							If !RmvJuros(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_TIPO,SE1->E1_PARCELA,SE1->E1_CLIENTE,SE1->E1_LOJA) //remoção de juros
								__quit()
							End
							If lContunua
								For __yy := 1 To Len(aPedsTot) //Buscando o débito da comissao
									If !lContunua
										Exit
									EndIf
									For __yy := 1 To Len(aPedsTot)
										For __zz := 1 To Len(aPedsTot[__yy])
											If (nPos := aScan(aPedsTot[__yy][__zz][2][5], {|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]})) > 0 //(nPos := aScan(aJsonfields[1][2][3][2][__yy][2][5], {|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]})) > 0
												If aPedsTot[__yy][__zz][2][18][nPos] == "COMISSION" .Or. aPedsTot[__yy][__zz][2][18][nPos] == "UNBLOCK_COMISSION"  //.Or. aPedsTot[__yy][__zz][2][18][nPos] == "PROMOTION_REFUND_COMISSION" VERIFICAR PARA BAIXAR NA CONTA B2W REF, A COMISSÃO DE REBATE
													nVlrComi := aPedsTot[__yy][__zz][2][20][nPos]//aJsonfields[1][2][3][2][__yy][2][20][nPos]  // Valor da comissão para descontar na baixa
													Exit
												Else
													Loop
												EndIf
											EndIf
										Next
									Next
									For __cc := 1 To Len(aPedsTot) // ressarcimento da promoção
										For __oo := 1 To Len(aPedsTot[__cc])
											If (nPos := aScan(aPedsTot[__cc][__oo][2][5], {|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]})) > 0
												If aPedsTot[__cc][__oo][2][18][nPos] == "PROMOTION_REFUND" //== "PROMOTION_REFUND_COMISSION"
													nVlrRePro := aPedsTot[__cc][__oo][2][20][nPos]
													Exit
												Else
													Loop
												EndIf
											EndIf
										Next
									Next
									For __nn := 1 To Len(aPedsTot) //Buscando a comissão do ressarcimento da promoção
										For __mm := 1 To Len(aPedsTot[__nn])
											If (nPos := aScan(aPedsTot[__nn][__mm][2][5], {|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]})) > 0
												If aPedsTot[__nn][__mm][2][18][nPos] == "PROMOTION_REFUND_COMISSION"
													nVlrCoRef := aPedsTot[__nn][__mm][2][20][nPos] *-1
													u_BxTit001("PROMOTION_REFUND_COMISSION_B2W",TMP->E1_NUM,nVlrCoRef)
													//	NÃO VOLTAR												u_BxTit001("PROMOTION_REFUND_COMISSION",SD2->D2_DOC,nVlrRePro) //Mudança em definição Vinicius e Bruno para lançar a baixa do título toda e valor ref. a comissao do ressarcimento via movimento bancario//u_BxTit001("PROMOTION_REFUND_COMISSION",SD2->D2_DOC,nVlrRePro - nVlrCoRef) // Baixa do valor menos comissao
													RecComRef(nVlrRePro,nVlrCoRef,TMP->E1_NUM) // Criação do titulo Ressarcimento Promoção // fazer um tratamento de contorno para verificar se o titulo já foi lançado... em caso de reprocessamento após falha ou proposital
													//movimento bancario  NÃO VOLTAR							u_ADMOVBCO("PROMOTION_REFUND_COMISSION",SD2->D2_DOC,nVlrCoRef)//BxSld001("PROMOTION_REFUND_COMISSION",SD2->D2_DOC,nVlrCoRef)    // Baixa da comissão sobre o ressarcimento Promoção
													lContunua := .F.
													Exit
												Else
													Loop
												EndIf
											EndIf
										Next
									Next
								Next
							EndIf
							lContunua := .T.
							SE1->(DbSetOrder(02))
							SE1->(DbGoto(TMP->E1RECNO))
							//                               Canal              Banco             Agencia           Conta
							u_BxTit001("SALE","",nVlrComi,aCntMKT[nPosCh,1],aCntMKT[nPosCh,2],aCntMKT[nPosCh,3],aCntMKT[nPosCh,4])
						Else
							ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUsername + " Titulo da venda já baixado no ERP" + SE1->E1_NUM + " Cliente " + SE1->E1_CLIENTE )
							//Avisar por email
							cTitJBaix += "WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUsername + " Titulo da venda já baixado no ERP" + SE1->E1_NUM + " Cliente " + SE1->E1_CLIENTE  + CRLF
						EndIf
					ElseIf aJsonfields[1][2][3][2][_xx][2][18][2] == "PROMOTION_REFUND" .Or. aJsonfields[1][2][3][2][_xx][2][18][2] == "INCOME_TAX"  //outros créditos
						nVlOutCr += aJsonfields[1][2][3][2][_xx][2][20][2]   //AJSONFIELDS[1][2][3][2][_XX][2][20][2]
					Else
						Loop
					EndIf
				Else
					Loop
				EndIf
			Next
			//		If !Empty(cIDs)
			//			WSRESERP(cIDs)
			//			cIDs := ""
			//		EndIf
		Else
			ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUsername + " Houve erro no parser do JSON..a rotina não pode baixar os pedidos")
			//enviar email de notificação e meios de avisar ao Zabbix para conseguirmos identificar de forma rapida na tela o erro (inclusive por categoria de importancia)
		EndIf
		u_AKonclia(nPage+=100)
		//aAdd(aPedsTot,aJsonfields[1][2][3][2])
	Next
	//u_ADOTRCDT("","","",nOutrCred) //Criacao de um titulo outros creditos (solicitaçao Bruno Dias) EM 03-09-2019 Bruno Dias solicito quebrar esse valor em vários titulos dentro do financeiro
	ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Processo finalizado com sucesso!.")
	RpcClearEnv()
Return

User Function BxTit001(_cOrigem,_cTitRCP,nVlrBaixa,cCanal,cBcoBaix,cAgeBaix,cConBaix)
	Local lRet := .F.
	Local cHistor := ""
	//Local cBcoBaix := ""
	//Local cAgeBaix := ""
	//Local cConBaix  := ""
	aAdd(aOrdeCod,"OrderCode " + aJsonfields[1][2][3][2][_xx][2][5][2] + " Expected " + cValToChar(aJsonfields[1][2][3][2][_xx][2][18][2]) + " Received " + cValToChar(aJsonfields[1][2][3][2][_xx][2][20][2]) + " Nota " + SE1->E1_NUM + " Pedido " + SE1->E1_PEDIDO)
	If _cOrigem == "PROMOTION_REFUND_COMISSION_B2W"
		cBcoBaix := PadR("B2W", nTamA6Banc)
		cAgeBaix := PadR("00001", nTamA6Agen)
		cConBaix := PadR("0000000001", nTamA6Nume)
	ELse
		cBcoBaix := PadR(cBcoBaix, nTamA6Banc)
		cAgeBaix := PadR(cAgeBaix, nTamA6Agen)
		cConBaix := PadR(cConBaix, nTamA6Nume)  //09104
	EndIf
	If _cOrigem == "PROMOTION_REFUND_COMISSION" .Or. _cOrigem == "PROMOTION_REFUND_COMISSION_B2W"
		cHistor := "AUT.KONCILIA-COM_RESSAR_PROMO/" + _cTitRCP + "/" + cConcili
	ElseIf  _cOrigem == "REBATE"
		nVlrBaixa := SE1->E1_VALOR
		cHistor := "AUT.KONCILIA-RESSAR_PROMO/" + _cTitRCP + "/" + cConcili
	Else
		cHistor := "Bx Aut Mktplace " + aJsonfields[1][2][3][2][_xx][2][5][2] + "/" + cConcili
		nVlrBaixa := SE1->E1_SALDO  //-  (nVlrComi * -1) //Por definição do Nacid e Antonio a baixa sempre ocorre no titulo cheio e valor de comissão como desconto financeiro
		If aJsonfields[1][2][3][2][_xx][2][20][2] <> SE1->E1_VALOR
			aAdd(aDiffer,aJsonfields[1][2][3][2][_xx][2][20][2] - SE1->E1_VALOR) ///aJsonfields[1][2][3][2][_xx][2][5][2]
			If _cOrigem == "SALE"
				nVlrBaixa := aJsonfields[1][2][3][2][_xx][2][20][2] //- ( nVlrCoRef + (nVlrComi * -1)) Por definição do Nacid e Antonio a baixa sempre ocorre no titulo cheio e valor de comissão como desconto financeiro
			EndIf
		EndIf
		If nVlrComi == 0
			ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Valor da comissão não foi localizado para utilizar na baixa")
		EndIf
	EndIf
	aBaixa := {{"E1_PREFIXO",		SE1->E1_PREFIXO		,Nil},;
		{"E1_NUM",						SE1->E1_NUM			,Nil},;
		{"E1_PARCELA",					SE1->E1_PARCELA		,Nil},;
		{"E1_CLIENTE",					SE1->E1_CLIENTE		,Nil},;
		{"E1_LOJA",						SE1->E1_LOJA		,Nil},;
		{"E1_TIPO",						SE1->E1_TIPO		,Nil},;
		{"AUTMOTBX",					"MPL"				,Nil},; // Motivo de baixa "ANT", "ADM", "MPL"
		{"AUTBANCO",					cBcoBaix			,Nil},;
		{"AUTAGENCIA",					cAgeBaix			,Nil},;
		{"AUTCONTA",					cConBaix			,Nil},;
		{"AUTDTBAIXA",					_dDatBai			,Nil},; // Data de baixa
		{"AUTDTCREDITO",				_dDatBai			,Nil},; // Data de credito
		{"AUTVALREC",					nVlrBaixa-(nVlrComi*-1)			,Nil},; // Data de credito
		{"AUTDESCONT",					Iif(_cOrigem == "SALE",(nVlrComi*-1),0)		,Nil,.T.},; // Desconto da baixa
		{"AUTHIST",						cHistor				,Nil}}
	DbSelectArea("SX1")
	SX1->(DbSetOrder(1)) // X1_GRUPO + X1_ORDEM
	If SX1->(MsSeek(PadR("FIN070",10) + "01"))
		RecLock("SX1",.F.)
		SX1->X1_PRESEL := 2 // Mostra Lancamento Contabil? 2=Nao
		SX1->(MsUnlock())
	EndIf
	If SX1->(MsSeek(PadR("FIN070",10) + "04"))
		RecLock("SX1",.F.)
		SX1->X1_PRESEL := 2 // Contabiliza On Line? 2=Nao
		SX1->(MsUnlock())
	EndIf
	If SX1->(MsSeek(PadR("FIN070",10) + "08"))
		RecLock("SX1",.F.)
		SX1->X1_PRESEL := 1 // Gera cheque p/ Adiantamento? 1=Sim
		SX1->(MsUnlock())
	EndIf
	Pergunte("FIN070",.F.) // Contabilizacao deve ser pelo LP 520 Sequenciais 061/062/063
	Mv_Par01 := 2				// Mostra Lancamento Contabil?		1=Sim 2=Nao
	Mv_Par02 := 2				// Aglutina Lancamento Contabil?	1=Sim 2=Nao
	Mv_Par03 := 1				// Abate Desc/Decres Comissao?		1=Sim 2=Nao
	Mv_Par04 := 2 // 1			// Contabiliza On Line?				1=Sim 2=Nao
	Mv_Par05 := 1				// Cons.Juros/Acres Comissao?		1=Sim 2=Nao
	Mv_Par06 := 2				// Destacar Abatimentos?			1=Sim 2=Nao
	Mv_Par07 := 1				// Replica Rateio?					1=Inclusao 2=Baixa 3=Nao Replicar
	Mv_Par08 := 1				// Gera cheque p/ Adiantamento? 	1=Sim 2=Nao
	Mv_Par09 := 1				// Considera Retencäo Bancaria?		1=Sim 2=Nao
	Mv_Par10 := 2				// Utiliza banco anterior?			1=Sim 2=Nao
	lMsErroAuto := .F.
	MsExecAuto({|x,y|, FINA070(x,y)},aBaixa,3)
	If lMsErroAuto // Falha no ExecAuto FINA070
		ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Erro ao baixar o título " + SE1->E1_NUM)
		lRet := .F.
		//Avisar email e zabbix sobre erro na baixa do titulo ref. a venda Mktplace
	Else // Sucesso na baixa receber
		ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Sucesso ao baixar o título " + SE1->E1_NUM)
		//Assim que finalizar a rotina eu pego o acumulado e baixo na conta
		//	If _cOrigem == "SALE"
		//                                    Banco              Agencia           Conta
		//		If BxSld001("","",nVlrComi,cCanal,aCntMKT[nPosCh,2],aCntMKT[nPosCh,3],aCntMKT[nPosCh,4]) //baixa do saldo do título
		//			ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Sucesso ao baixar saldo comissao o título " + SE1->E1_NUM)
		//		Else
		//			ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " ERRO ao baixar saldo comissao o título " + SE1->E1_NUM)
		//Avisar email e zabbix sobre erro na baixa do saldo
		//		EndIf
		//	EndIf
	EndIf
Return  //nVlrComi  nVlrRePro nVlrCoRef // zerar esses valores depois de rodar

Static Function BxSld001(_cOrigem,_cTitRCP,nVlrBaixa,cChanel,cBanc,cAge,cCont)
	Local lRet := .F.
	cBcoBaix := PadR(cBanc, nTamA6Banc)
	cAgeBaix := PadR(cAge, nTamA6Agen)
	cConBaix := PadR(cCont, nTamA6Nume) // cConBaix := PadR("76824", nTamA6Nume)
	If _cOrigem == "PROMOTION_REFUND_COMISSION"
		cHistor := "Bx Aut MKT-" + cChanel +"/" + _cTitRCP + "/" + cConcili
	Else
		cHistor := "Bx Aut MKT-" + cChanel + aJsonfields[1][2][3][2][_xx][2][5][2] + "/" + SE1->E1_PEDIDO
		nVlrBaixa := (nVlrComi *-1)
	EndIf
	aBaixa := {{"E1_PREFIXO",		SE1->E1_PREFIXO		,Nil},;
		{"E1_NUM",						SE1->E1_NUM			,Nil},;
		{"E1_PARCELA",					SE1->E1_PARCELA		,Nil},;
		{"E1_CLIENTE",					SE1->E1_CLIENTE		,Nil},;
		{"E1_LOJA",						SE1->E1_LOJA		,Nil},;
		{"E1_TIPO",						SE1->E1_TIPO		,Nil},;
		{"AUTMOTBX",					"MPL"				,Nil},; // Motivo de baixa "ANT", "ADM", "MPL","RBT"
		{"AUTBANCO",					cBcoBaix			,Nil},;
		{"AUTAGENCIA",					cAgeBaix			,Nil},;
		{"AUTCONTA",					cConBaix			,Nil},;
		{"AUTDTBAIXA",					_dDatBai			,Nil},; // Data de baixa
		{"AUTDTCREDITO",				_dDatBai			,Nil},; // Data de credito
		{"AUTVALREC",					nVlrBaixa			,Nil},; // Valor a ser baixado //{"AUTVALREC",					SE1->E1_SALDO		,Nil},; // Valor a ser baixado
		{"AUTHIST",						cHistor				,Nil}}
	DbSelectArea("SX1")
	SX1->(DbSetOrder(1)) // X1_GRUPO + X1_ORDEM
	If SX1->(MsSeek(PadR("FIN070",10) + "01"))
		RecLock("SX1",.F.)
		SX1->X1_PRESEL := 2 // Mostra Lancamento Contabil? 2=Nao
		SX1->(MsUnlock())
	EndIf
	If SX1->(MsSeek(PadR("FIN070",10) + "04"))
		RecLock("SX1",.F.)
		SX1->X1_PRESEL := 2 // Contabiliza On Line? 2=Nao
		SX1->(MsUnlock())
	EndIf
	If SX1->(MsSeek(PadR("FIN070",10) + "08"))
		RecLock("SX1",.F.)
		SX1->X1_PRESEL := 1 // Gera cheque p/ Adiantamento? 1=Sim
		SX1->(MsUnlock())
	EndIf
	Pergunte("FIN070",.F.) // Contabilizacao deve ser pelo LP 520 Sequenciais 061/062/063
	Mv_Par01 := 2				// Mostra Lancamento Contabil?		1=Sim 2=Nao
	Mv_Par02 := 2				// Aglutina Lancamento Contabil?	1=Sim 2=Nao
	Mv_Par03 := 2				// Abate Desc/Decres Comissao?		1=Sim 2=Nao
	Mv_Par04 := 2 // 1			// Contabiliza On Line?				1=Sim 2=Nao
	Mv_Par05 := 2				// Cons.Juros/Acres Comissao?		1=Sim 2=Nao
	Mv_Par06 := 1				// Destacar Abatimentos?			1=Sim 2=Nao
	Mv_Par07 := 1				// Replica Rateio?					1=Inclusao 2=Baixa 3=Nao Replicar
	Mv_Par08 := 1				// Gera cheque p/ Adiantamento? 	1=Sim 2=Nao
	Mv_Par09 := 1				// Considera Retencäo Bancaria?		1=Sim 2=Nao
	Mv_Par10 := 2				// Utiliza banco anterior?			1=Sim 2=Nao
	lMsErroAuto := .F.
	MsExecAuto({|x,y|, FINA070(x,y)},aBaixa,3)
	If lMsErroAuto // Falha no ExecAuto FINA070
		ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Erro ao baixar o título " + SE1->E1_NUM)
		lRet := .F.
	Else // Sucesso na baixa receber
		ConOut("WSREP001: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Sucesso ao baixar o título " + SE1->E1_NUM)
		//Assim que finalizar a rotina eu pego o acumulado e baixo na conta
		lRet := .T.
	EndIf
Return lRet

Static Function RodaQRY()
	//cQuery := "SELECT L1_XPEDMKT,* FROM SL1010 WHERE L1_XPEDMKT LIKE '%" + aJsonfields[1][2][3][2][_xx][2][5][2] + "%' "
	//cQuery := "SELECT C5_NUM,* FROM SL1010 "
	//cQuery += " INNER JOIN SC5010 ON L1_XIDMAGE = C5_XIDMAGE AND L1_PEDRES = C5_NUM "
	//cQuery += " WHERE SC5010.D_E_L_E_T_ = '' AND SL1010.D_E_L_E_T_ = '' AND L1_XPEDMKT LIKE '%" + aJsonfields[1][2][3][2][_xx][2][5][2] + "%' "
	cQuery := "SELECT L1_DOCPED,E1_NUM,SE1010.R_E_C_N_O_ AS E1RECNO,* FROM SL1010 "
	cQuery += " INNER JOIN SE1010 ON E1_NUM = L1_DOCPED AND E1_PREFIXO = L1_SERPED AND E1_CLIENTE = L1_CLIENTE AND E1_LOJA = L1_LOJA"
	cQuery += " WHERE SE1010.D_E_L_E_T_ = '' AND SL1010.D_E_L_E_T_ = '' AND L1_XPEDMKT LIKE '%" + aJsonfields[1][2][3][2][_xx][2][5][2] + "%' "
	conout(cQuery)
	Iif(Select("TMP")>0,TMP->(DbCloseArea()),Nil)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMP")
	Count To nRecs
	dbGoTop()
Return nRecs

User Function AKonclia()
	Local aHeader := {}
	Local cURL := "https://api.koncilia.com.br"
	Local cApiKey := "259029869L1E1672586022821C157927402282100O1.I"
	Local cEndPnt := StrTran("/externalapi/orderextract/unresolveds?offset='"+cValToChar(nPage)+"'&limit=100&initDate="+initDate+"&endDate="+endDate+"&conciliationId="+cConcili,"offset='"+cValToChar(nPage)+"'","offset="+cValToChar(nPage))
	Local Enter := Chr(13) + Chr(10)
	Local cJson := ""
	Local nRetParser := 0
	Local oJHM := .F.
	Private oRest,oReturn
	oRest := FWRest():New(cURL)
	aAdd(aHeader,"Accept: application/json")
	aAdd(aHeader,"Content-Type: application/json")
	aAdd(aHeader,"gumgaToken: " + cApiKey)
	oRest:SetPath(cEndPnt)
	oRest:SetPostParams("Body")
	oRest:GET(aHeader)
	cResult := oRest:GetResult()
	cResult := DecodeUtf8(cResult)
	LenStrJson := Len(cResult)
	oJson := tJsonParser():New()
	aJsonfields := {}
	lRet = oJson:Json_Hash(cResult, LenStrJson, @aJsonfields, @nRetParser, @oJHM)
	If Len(aJsonfields)== 0
		__quit()
	EndIf
Return aJsonfields


Static Function WSRESERP(cIDs)
	Local aHeader := {}
	Local cURL := "https://api.koncilia.com.br/externalapi/orderextract/resolve/batch" // - HOMOLOGACAO - Local cURL := "https://api-sandbox.koncilia.com.br/externalapi/orderextract/resolve/batch"
	Local cApiKey := "259029869L1E1660749378197C156743737819700O1.I" //- HOMOLOGACAOLocal cApiKey := "3L1E1654971509501C156165950950100O1.I"
	Local cEndPnt := ""//StrTran("/externalapi/orderextract/unresolveds?offset='"+cValToChar(nPage)+"'&limit=100&initDate=2019-08-22&endDate=2019-08-22","offset='"+cValToChar(nPage)+"'","offset="+cValToChar(nPage))
	Local Enter := Chr(13) + Chr(10)
	Local cJson := ""
	Local nRetParser := 0
	Local oJHM := .F.
	Local aResultIDs := {}
	Local oRest,oReturn
	oRest := FWRest():New(cURL)
	aAdd(aHeader,"Accept: application/json")
	aAdd(aHeader,"Content-Type: application/json")
	aAdd(aHeader,"gumgaToken: " + cApiKey)
	oRest:SetPath(cEndPnt)
	oRest:SetPostParams("Body")
	cJson := "[" + Subs(cIDs,1,Len(cIDs)-1) + "]" //6148624
	oRest:PUT(aHeader,cJson)
	cResult := oRest:GetResult()
	cResult := DecodeUtf8(cResult)
	lenStrJson := Len(cResult)
	oJson := tJsonParser():New()
	aResultIDs := {}
	lRet = oJson:Json_Hash(cResult, lenStrJson, @aResultIDs, @nRetParser, @oJHM)
Return

User Function ADOTRCDT(_cBanco,_cAgencia,_cConta,_nVlrCred,_cNumNota)
	Local _cPrfTitu := ""
	Local _cNumTitu := GetNxTit()
	Local _cTipTitu := "RCP"
	Local _cNatTitu := "1012501"  //OUTRAS RECEITAS-RBT
	Local _cCliTit := "343545"
	Local _cLojTit := "01"
	nRfndCom := 0
	SA1->(DbSeek(xFilial("SA1") + _cCliTit + _cLojTit))
	_aFin040 := {}
	aAdd(_aFin040, {"E1_PREFIXO",	_cPrfTitu							,Nil })	// Prefixo
	aAdd(_aFin040, {"E1_NUM",		_cNumNota							,Nil })	// Numero titulo
	aAdd(_aFin040, {"E1_PARCELA",	Space(01)		    				,Nil }) // Parcela
	aAdd(_aFin040, {"E1_TIPO",		_cTipTitu							,Nil }) // Tipo Titulo
	//aAdd(_aFin040, {"E1_PORTADO",	SA6->A6_COD							,Nil }) // Banco
	//aAdd(_aFin040, {"E1_AGEDEP",	SA6->A6_AGENCIA						,Nil })	// Agencia
	//aAdd(_aFin040, {"E1_CONTA",	SA6->A6_NUMCON						,Nil })	// Conta
	aAdd(_aFin040, {"E1_NATUREZ",	_cNatTitu							,Nil }) // Natureza adiantamento
	aAdd(_aFin040, {"E1_CLIENTE",	SA1->A1_COD							,Nil }) // Cliente
	aAdd(_aFin040, {"E1_LOJA",		SA1->A1_LOJA						,Nil }) // Loja
	aAdd(_aFin040, {"E1_NOMCLI",	SA1->A1_NREDUZ						,Nil }) // Nome
	aAdd(_aFin040, {"E1_EMISSAO",	dDatabase							,Nil })	// Emissao
	aAdd(_aFin040, {"E1_VENCTO",	Date()								,Nil })
	aAdd(_aFin040, {"E1_VENCREA",	Date()								,Nil })
	aAdd(_aFin040, {"E1_VENCORI",	Date()								,Nil })
	aAdd(_aFin040, {"E1_EMIS1",		Date()								,Nil })	// Emissao
	aAdd(_aFin040, {"E1_MOEDA",		1									,Nil })	// Moeda
	aAdd(_aFin040, {"E1_VALOR",		(_nVlrCred *-1)						,Nil }) // Valor Liquido
	aAdd(_aFin040, {"E1_VLCRUZ",	(_nVlrCred *-1)						,Nil }) // Valor Liquido
	aAdd(_aFin040, {"E1_ORIGEM",	"FINA040"							,Nil })
	aAdd(_aFin040, {"E1_XHIST",		DtoC(Date()) + " " + cUserName + " AUT.KONCILIA " + _cNumNota + "/" + cConcili 	,Nil })
	aAdd(_aFin040, {"E1_HIST",		DtoC(Date()) + " " + cUserName + " AUT.KONCILIA " + _cNumNota + "/" + cConcili	,Nil })
	aAdd(_aFin040, {"E1_XNIDENT",	"N"									,Nil })
	aAdd(_aFin040, {"E1_CONTRAT",	""									,Nil }) // Contrato
	DbSelectArea("SE1")
	SE1->(DbSetOrder(1)) // E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO
	Pergunte("FIN040",.F.)
	Mv_Par01 := 2 // Mostra Lancamento Contabil		Num	1=Sim 2=Nao
	Mv_Par02 := 2 // Contabiliza Titulo Provisorio 	Num 1=Sim 2=Nao
	Mv_Par03 := 2 // Contabiliza online				Num 1=Sim 2=Nao
	Mv_Par04 := 2 // Rateia valor					Num 1=Bruto 2=Liquido

	lMsErroAuto := .F.
	MsExecAuto({|x,y|, FINA040(x,y) }, _aFin040, 3)
	If lMsErroAuto // Falha no ExecAuto FINA004
		ConOut("ADOTRCDT: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Erro ao incluir titulo REBATE " + _cNumTitu)
		lRet := .F.
	Else // Sucesso na baixa receber
		ConOut("ADOTRCDT: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Sucesso ao incluir titulo REBATE " + SE1->E1_NUM)
		//	u_BxTit001("REBATE",SE1->E1_NUM,SE1->E1_VALOR) // Já que criou baixa na 76
		//Assim que finalizar a rotina eu pego o acumulado e baixo na conta
		lRet := .T.
	EndIf
Return

Static Function GetNxTit() // Obtencao do proximo titulo
	Local _cNumTitu := StrZero(Val(cConcili),9,0)
	Local _cPrfTitu := "RCP"
	DbSelectArea("SE1")
	SE1->(DbSetOrder(1)) // E1_FILIAL + E1_PREFIXO + E1_NUM + ...
	If SE1->(MsSeek(xFilial("SE1") + _cPrfTitu + _cNumTitu,.T.))
		ConOut("GetNxTit: " + DtoC(Date()) + " " + Time() + " " + "TOTVS" + " Titulo de rebate ref. a conciliação KONCILIA numero " + cConcili + " já existe na base, para criar novamente remova o título " + _cNumTitu + "/" + "RBT" )
		//avisar zabbix e email pois não conseguiu criar o titulo ref. a conciliação xxxx
		Return .F.
	EndIf
Return _cNumTitu


Static Function RecComRef(nVlrRePro,nVlrCoRef,_cTitRCP)
	Local _cPrfTitu := ""
	Local _cTipTitu := "RCP"
	Local _cNatTitu := "10411"  //OUTRAS RECEITAS-RBT
	Local _cCliTit := "000087127"
	Local _cLojTit := "0001"
	SA1->(DbSeek(xFilial("SA1") + _cCliTit + _cLojTit))
	_aFin040 := {}
	aAdd(_aFin040, {"E1_PREFIXO",	_cPrfTitu							,Nil })	// Prefixo
	aAdd(_aFin040, {"E1_NUM",		_cTitRCP							,Nil })	// Numero titulo
	aAdd(_aFin040, {"E1_PARCELA",	Space(01)		    				,Nil }) // Parcela
	aAdd(_aFin040, {"E1_TIPO",		_cTipTitu							,Nil }) // Tipo Titulo
	//aAdd(_aFin040, {"E1_PORTADO",	SA6->A6_COD							,Nil }) // Banco
	//aAdd(_aFin040, {"E1_AGEDEP",	SA6->A6_AGENCIA						,Nil })	// Agencia
	//aAdd(_aFin040, {"E1_CONTA",	SA6->A6_NUMCON						,Nil })	// Conta
	aAdd(_aFin040, {"E1_NATUREZ",	_cNatTitu							,Nil }) // Natureza adiantamento
	aAdd(_aFin040, {"E1_CLIENTE",	SA1->A1_COD							,Nil }) // Cliente
	aAdd(_aFin040, {"E1_LOJA",		SA1->A1_LOJA						,Nil }) // Loja
	aAdd(_aFin040, {"E1_NOMCLI",	SA1->A1_NREDUZ						,Nil }) // Nome
	aAdd(_aFin040, {"E1_EMISSAO",	dDatabase							,Nil })	// Emissao
	aAdd(_aFin040, {"E1_VENCTO",	Date()								,Nil })
	aAdd(_aFin040, {"E1_VENCREA",	Date()								,Nil })
	aAdd(_aFin040, {"E1_VENCORI",	Date()								,Nil })
	aAdd(_aFin040, {"E1_EMIS1",		Date()								,Nil })	// Emissao
	aAdd(_aFin040, {"E1_MOEDA",		1									,Nil })	// Moeda
	aAdd(_aFin040, {"E1_VALOR",		nVlrRePro							,Nil }) // Valor Liquido
	aAdd(_aFin040, {"E1_VLCRUZ",	nVlrRePro							,Nil }) // Valor Liquido
	aAdd(_aFin040, {"E1_ORIGEM",	"FINA040"							,Nil })
	aAdd(_aFin040, {"E1_XHIST",		"AUT.KONCILIA-RESSAR_PROMO/" + _cTitRCP + "/" + cConcili 	,Nil })
	aAdd(_aFin040, {"E1_HIST",		"AUT.KONCILIA-RESSAR_PROMO/" + _cTitRCP + "/" + cConcili	,Nil })
	aAdd(_aFin040, {"E1_XNIDENT",	"N"									,Nil })
	aAdd(_aFin040, {"E1_CONTRAT",	""									,Nil }) // Contrato
	DbSelectArea("SE1")
	SE1->(DbSetOrder(1)) // E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO
	Pergunte("FIN040",.F.)
	Mv_Par01 := 2 // Mostra Lancamento Contabil		Num	1=Sim 2=Nao
	Mv_Par02 := 2 // Contabiliza Titulo Provisorio 	Num 1=Sim 2=Nao
	Mv_Par03 := 2 // Contabiliza online				Num 1=Sim 2=Nao
	Mv_Par04 := 2 // Rateia valor					Num 1=Bruto 2=Liquido

	lMsErroAuto := .F.
	MsExecAuto({|x,y|, FINA040(x,y) }, _aFin040, 3)
	If lMsErroAuto // Falha no ExecAuto FINA004
		ConOut("ADOTRCDT: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Erro ao incluir titulo REBATE " + _cTitRCP)
		lRet := .F.
	Else // Sucesso na baixa receber
		ConOut("ADOTRCDT: " + DtoC(Date()) + " " + Time() + " " + cUserName + " Sucesso ao incluir titulo REBATE " + SE1->E1_NUM)
		//Assim que finalizar a rotina eu pego o acumulado e baixo na conta
		u_BxTit001("REBATE",SE1->E1_NUM,SE1->E1_VALOR) // Já que criou baixa na 76
		lRet := .T.
	EndIf
Return

User Function ADMOVBCO(_cOrigem,_cTitRCP,nVlrBaixa,cNumDevTit)
	Local nOpc     := 2
	Local aFINA100 := {}
	Local cBcoBaix := PadR("B2W", nTamA6Banc)
	Local cAgeBaix := PadR("00001", nTamA6Agen)
	Local cConBaix := PadR("0000000001", nTamA6Nume)
	Local _cNatTitu := "1012601"  //COMISSÃO MARKET PLACE
	If _cOrigem == "PROMOTION_REFUND_COMISSION"
		cHistor := "Bx Aut MKT-" + cCanal + "/" + _cTitRCP + "/" + cConcili
	ElseIf _cOrigem == "COMISSION"
		cHistor := "Transf-NCC MKT-" + cCanal + aJsonfields[1][2][3][2][_xx][2][5][2] + "/" + cNumDevTit
	Else
		cHistor := "Bx Aut MKT-" + cCanal + aJsonfields[1][2][3][2][_xx][2][5][2] + "/" + SE1->E1_PEDIDO
		nVlrBaixa := (nVlrComi *-1)
	EndIf
	Private lMsErroAuto := .F.

	nOpc := 5 //Transferencia no caso de notas que possuam NCC
	//    nOpc := Aviso("TESTE EXECAUTO DO FINA100", "Escolha a opção do menu da rotina FINA100 a ser executada via EXECAUTO",{"PAGAR","RECEBER","EXCLUIR","CANCELAR","TRANSF.","EST. TRANSF."})

	If nOpc == 1
		aFINA100 := {    {"E5_DATA"        ,dDataBase                    ,Nil},;
			{"E5_MOEDA"        ,"M1"                            ,Nil},;
			{"E5_VALOR"		,500                            ,Nil},;
			{"E5_NATUREZ"    ,"001"                    ,Nil},;
			{"E5_BANCO"        ,"001"                        ,Nil},;
			{"E5_AGENCIA"    ,"001"                        ,Nil},;
			{"E5_CONTA"        ,"001"                        ,Nil},;
			{"E5_BENEF"        ,"TESTE AUTO - BENEF"    ,Nil},;
			{"E5_HISTOR"    ,"TESTE AUTO - AUTO"        ,Nil}}

		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,3)

		If lMsErroAuto
			MostraErro()
		Else
			MsgAlert("Movto. Bancario Pagar incluido com sucesso !!!")
		EndIf

	ElseIf nOpc == 2
		aFINA100 := {    {"E5_DATA"			,dDataBase	,Nil},;
			{"E5_MOEDA"		,"M1"		,Nil},;
			{"E5_VALOR"		,nVlrBaixa	,Nil},; //cBcoBaix cAgeBaix cConBaix
			{"E5_NATUREZ"	,_cNatTitu	,Nil},;
			{"E5_BANCO"		,cBcoBaix	,Nil},;
			{"E5_AGENCIA"	,cAgeBaix	,Nil},;
			{"E5_CONTA"		,cConBaix	,Nil},;
			{"E5_HISTOR"	,cHistor	,Nil}}

		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,4)
		If lMsErroAuto
			MostraErro()
		Else
			ConOut("ADMOVBCO: " + DtoC(Date()) + " " + Time() + " Movimento bancário criado com sucesso! " )
		EndIf
	ElseIf nOpc == 3
		dbSelectArea("SE5")
		SE5->(dbSetOrder(1))
		SE5->(dbSeek(xFilial("SE5")+DToS(dDataBase) ))
		aFINA100 := {    {"E5_DATA"             ,SE5->E5_DATA            ,Nil},;
			{"E5_MOEDA"             ,SE5->E5_MOEDA            ,Nil},;
			{"E5_VALOR"             ,SE5->E5_VALOR            ,Nil},;
			{"E5_NATUREZ"        ,SE5->E5_NATUREZ        ,Nil},;
			{"E5_BANCO"            ,SE5->E5_BANCO            ,Nil},;
			{"E5_AGENCIA"         ,SE5->E5_AGENCIA        ,Nil},;
			{"E5_CONTA"         ,SE5->E5_CONTA            ,Nil},;
			{"E5_HISTOR"        ,SE5->E5_HISTOR        ,Nil},;
			{"E5_TIPOLAN"        ,SE5->E5_TIPOLAN        ,Nil} }

		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,5)

		If lMsErroAuto
			ConOut("ADMOVBCO: " + DtoC(Date()) + " " + Time() + " Erro ao tentar incluir o movimento bancario " )//MostraErro()
		Else
			MsgAlert("Exclusão realizada com sucesso !!!")
		EndIf

	ElseIf nOpc == 4
		dbSelectArea("SE5")
		SE5->(dbSetOrder(1))
		SE5->(dbSeek(xFilial("SE5")+DToS(dDataBase) ))
		dbSkip() //colocado apenas para esta sequencia de testes
		aFINA100 := {    {"E5_DATA"             ,SE5->E5_DATA            ,Nil},;
			{"E5_MOEDA"             ,SE5->E5_MOEDA            ,Nil},;
			{"E5_VALOR"             ,SE5->E5_VALOR            ,Nil},;
			{"E5_NATUREZ"        ,SE5->E5_NATUREZ        ,Nil},;
			{"E5_BANCO"            ,SE5->E5_BANCO            ,Nil},;
			{"E5_AGENCIA"         ,SE5->E5_AGENCIA        ,Nil},;
			{"E5_CONTA"         ,SE5->E5_CONTA            ,Nil},;
			{"E5_HISTOR"        ,SE5->E5_HISTOR        ,Nil},;
			{"E5_TIPOLAN"        ,SE5->E5_TIPOLAN        ,Nil} }

		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,6)

		If lMsErroAuto
			MostraErro()
		Else
			MsgAlert("Cancelamento realizada com sucesso !!!")
		EndIf


	ElseIf nOpc == 5
		aFINA100 := {       {"CBCOORIG"         ,"341"			,Nil},;
			{"CAGENORIG"        ,"1012"			,Nil},;
			{"CCTAORIG"         ,"76824"		,Nil},;
			{"CNATURORI"        ,"1012501"		,Nil},;
			{"CBCODEST"         ,"B2W"			,Nil},;
			{"CAGENDEST"        ,"00001"		,Nil},;
			{"CCTADEST"         ,"0000000001"	,Nil},;
			{"CNATURDES"        ,"1012501"		,Nil},;
			{"CTIPOTRAN"        ,_cTitRCP		,Nil},;
			{"CDOCTRAN"         ,cNumDevTit		,Nil},;
			{"NVALORTRAN"       ,nVlrBaixa		,Nil},;
			{"CHIST100"         ,cHistor		,Nil},;
			{"CBENEF100"        ,"MPS DISTRIBUIDORA MERCANTIL LT"    ,Nil} }

		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,7)

		If lMsErroAuto
			MostraErro()
		Else
			MsgAlert("Transferência executada com sucesso !!!")
		EndIf

		//Estorno da Transferencia
	ElseIf nOpc == 6
		aFINA100 := {    {"AUTNRODOC"         ,"123456"                ,Nil},;
			{"AUTDTMOV"            ,dDataBase                ,Nil},;
			{"AUTBANCO"             ,"001"                    ,Nil},;
			{"AUTAGENCIA"     ,"001"                    ,Nil},;
			{"AUTCONTA"            ,"001"                    ,Nil} }

		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,8)

		If lMsErroAuto
			MostraErro()
		Else
			MsgAlert("Transferência cancelada com sucesso !!!")
		EndIf
	EndIf
Return(Nil)

Static Function RmvJuros(cPrefixo,cNumTit,cTpTit,cParcTit,cCliTit,cLojaTit,nRecno)
	Local lRet := .T.
	cSQL := "UPDATE "+RetSqlName("SE1")+" SET E1_JUROS='0',E1_PORCJUR='0',E1_VALJUR = '0' WHERE E1_FILIAL='"+xFilial("SE1")+"' AND D_E_L_E_T_=' ' "
	cSQL += "AND E1_PREFIXO='"+cPrefixo+"' AND E1_NUM='"+cNumTit+"' AND E1_TIPO='"+cTpTit+"' AND E1_PARCELA='"+cParcTit+"' AND E1_CLIENTE='"+cCliTit+"' AND E1_LOJA='"+cLojaTit+"' "
	If TcSqlExec( cSQL ) <> 0
		lRet := .F.
		conout( "[Execution Error] " + cSQL + Chr(10) + TCSqlError() )
	EndIf
Return lRet

Static Function CmpEsVda()
	Local lRetOK := .T.
	Local aArea  := GetArea()
	Local nTaxaCM := 0
	Local aTxMoeda := {}
	Private nRecnoNDF
	Private nRecnoE1
	DbSelectArea("SD1")
	SD1->(DbSetOrder(19)) // D1_FILIAL + D1_NFORI + D1_SERIORI + D1_FORNECE + D1_LOJA
	DbSelectArea("SE1")
	SE1->(DbSetOrder(2)) // E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
	If SD2->(DbSeek(xFilial("SD2") + TMP->C5_NUM ))
		If SD1->(DbSeek(xFilial("SD1") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA  ))
			If SE1->(DbSeek(xFilial("SE1")+ SD1->D1_FORNECE + SD1->D1_LOJA + SD1->D1_SERIE + SD1->D1_DOC + "A" + "NCC" )) .And. SE1->E1_SALDO > 0
				nRcnoNCC := SE1->(Recno())
				If SE1->(DbSeek(xFilial("SE1")+ SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_SERIE + SD2->D2_DOC + "" )) //SE1->(DbSeek(xFilial("SE1")+ SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_SERIE + "  " + "NF " ))
					nRecnoE1 := SE1->(Recno())
					cNumTitDev := SE1->E1_NUM
					Pergunte("AFI340",.F.)
					lContabiliza  := MV_PAR11 == 1
					lAglutina   := MV_PAR08 == 1
					lDigita   := MV_PAR09 == 1
					nTaxaCM := RecMoeda(dDataBase,SE1->E1_MOEDA)
					aAdd(aTxMoeda, {1, 1} )
					aAdd(aTxMoeda, {2, nTaxaCM} )
					SE1->(DbSetOrder(1)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_FORNECE+E1_LOJA
					aRecNCC := { nRcnoNCC }
					aRecSE1 := { nRecnoE1 }
					If !MaIntBxCR(3,aRecSE1,,aRecNCC,,{lContabiliza,lAglutina,lDigita,.F.,.F.,.F.},,,,,dDatabase )
						Help("XAFCMPAD",1,"HELP","XAFCMPAD","Não foi possível a compensação"+CRLF+" do titulo do adiantamento",1,0)
						lRet := .F.
					Else
						ConOut("NCC Recno " + cValToChar(nRcnoNCC) + " compensada com sucesso. ")
					EndIf
				EndIf
			EndIf
		Else
			ConOut("NCC não foi localizada.")
		EndIf
	Else
		ConOut("Pedido de venda não localizado")
	EndIf
	RestArea(aArea)
Return lRetOK


Static Function FindTipo(cTipo)
	Local nValor := 0
	For __gg := 1 To Len(aPedsTot)
		For __ss := 1 To Len(aPedsTot[__gg])
			If (nPos := aScan(aPedsTot[__gg][__ss][2][5], {|x|,x == aJsonfields[1][2][3][2][_xx][2][5][2]})) > 0
				If aPedsTot[__gg][__ss][2][18][nPos] == cTipo
					nValor := Iif(Positivo(aPedsTot[__gg][__ss][2][20][nPos]),aPedsTot[__gg][__ss][2][20][nPos],aPedsTot[__gg][__ss][2][20][nPos] *-1)
					Exit
				Else
					Loop
				EndIf
			EndIf
		Next
	Next
Return nValor




User Function compvei()
	Local cError := ""
	Local cWarning := ""
	oWsdl := TWsdlManager():New()
	//oWsdl:cSSLCACertFile := "\CA.pem"
	If xRet := !oWsdl:ParseURL( "https://soap.comprovei.com.br/importQueue/v2/index.php?wsdl" )   //!oWsdl:ParseURL( "https://soap.comprovei.com.br/importQueue/index.php?wsdl" )
		Return
	EndIf

	xRet := oWsdl:SetOperation( "uploadRoute" )

	cMsg := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="WebServiceComprovei" xmlns:web1="WebServiceComprovei:uploadRoute">
	cMsg += '   <soapenv:Header>
	cMsg += '      <web:Credenciais>
	cMsg += '         <web:Usuario>sancargo</web:Usuario>
	cMsg += '         <web:Senha>nu7Vxazxb4enJYr2BcOf8yKLJoJX3aXZ</web:Senha>
	cMsg += '      </web:Credenciais>
	cMsg += '   </soapenv:Header>
	cMsg += '   <soapenv:Body>
	cMsg += '      <web1:uploadRoute>
	cMsg += '         <web1:Rotas>
	cMsg += '            <web1:Rota numero="">
	cMsg += '               <web1:rotadestino>4545</web1:rotadestino>
	cMsg += '               <web1:rotanome>tteste</web1:rotanome>
	cMsg += '               <web1:Data>20190701</web1:Data>
	cMsg += '               <web1:Regiao></web1:Regiao>
	cMsg += '               <web1:Transportadora>
	cMsg += '                  <web1:Codigo>66146093000175</web1:Codigo>
	cMsg += '                  <web1:Razao>SANCARGO LOGISTICA DE CARGAS LTDA</web1:Razao>
	cMsg += '               </web1:Transportadora>
	cMsg += '               <web1:Motorista>
	cMsg += '                  <web1:Usuario>02910798134</web1:Usuario>
	cMsg += '                  <web1:PlacaVeiculo>GEB8929</web1:PlacaVeiculo>
	cMsg += '                  <web1:TipoVeiculo></web1:TipoVeiculo>
	cMsg += '                  <web1:Nome>WAGNER MUNIZ</web1:Nome>
	cMsg += '               </web1:Motorista>
	cMsg += '               <web1:Base>
	cMsg += '                  <web1:Origem codigo="66146093000175">
	cMsg += '                     <web1:Nome>SANCARGO LOGISTICA DE CARGAS LTDA</web1:Nome>
	cMsg += '                     <web1:Rua>R ANTONIO RODRIGUES FILHO</web1:Rua>
	cMsg += '                     <web1:Numero>12</web1:Numero>
	cMsg += '                     <web1:Complemento></web1:Complemento>
	cMsg += '                     <web1:Bairro>CUMBICA</web1:Bairro>
	cMsg += '                     <web1:Cidade>GUARULHOS</web1:Cidade>
	cMsg += '                     <web1:Estado>SP</web1:Estado>
	cMsg += '                     <web1:CEP>07170325</web1:CEP>
	cMsg += '                     <web1:Pais>BR</web1:Pais>
	cMsg += '                     <web1:Contato>HUGO</web1:Contato>
	cMsg += '                     <web1:Email>emailhugo@sancargo.com.br</web1:Email>
	cMsg += '                     <web1:Telefone>telefone_do_Hugo</web1:Telefone>
	cMsg += '                     <web1:Cnpj></web1:Cnpj>
	cMsg += '                     <web1:CnpjMatriz></web1:CnpjMatriz>
	cMsg += '                     <web1:TipoMatriz>courier</web1:TipoMatriz>
	cMsg += '                     <web1:CodigoIBGE></web1:CodigoIBGE>
	cMsg += '                  </web1:Origem>
	cMsg += '                  <web1:Destino codigo="66146093000175">
	cMsg += '                     <web1:Nome>SANCARGO LOGISTICA DE CARGAS LTDA</web1:Nome>
	cMsg += '                     <web1:Rua>R ANTONIO RODRIGUES FILHO</web1:Rua>
	cMsg += '                     <web1:Numero>33</web1:Numero>
	cMsg += '                     <web1:Complemento></web1:Complemento>
	cMsg += '                     <web1:Bairro>CUMBICA</web1:Bairro>
	cMsg += '                     <web1:Cidade>GUARULHOS</web1:Cidade>
	cMsg += '                     <web1:Estado>SP</web1:Estado>
	cMsg += '                     <web1:CEP>07170325</web1:CEP>
	cMsg += '                     <web1:Pais>BR</web1:Pais>
	cMsg += '                     <web1:Contato></web1:Contato>
	cMsg += '                     <web1:Email></web1:Email>
	cMsg += '                     <web1:Telefone></web1:Telefone>
	cMsg += '                     <web1:Cnpj></web1:Cnpj>
	cMsg += '                     <web1:CnpjMatriz></web1:CnpjMatriz>
	cMsg += '                     <web1:TipoMatriz>courier</web1:TipoMatriz>
	cMsg += '                     <web1:CodigoIBGE></web1:CodigoIBGE>
	cMsg += '                  </web1:Destino>
	cMsg += '               </web1:Base>
	cMsg += '              <web1:limites>
	cMsg += '                  <web1:inicio>20190701 0400</web1:inicio>
	cMsg += '                  <web1:fim>20190701 1800</web1:fim>
	cMsg += '               </web1:limites>
	cMsg += '               <web1:TipoRota>D</web1:TipoRota>
	cMsg += '               <web1:TipoMaterial></web1:TipoMaterial>
	cMsg += '               <web1:Fornecimento></web1:Fornecimento>
	cMsg += '               <web1:TipoFrete></web1:TipoFrete>
	cMsg += '               <web1:Modal></web1:Modal>
	cMsg += '               <web1:Paradas>
	cMsg += '                  <web1:Parada numero="434">
	cMsg += '                     <web1:Tipo>E</web1:Tipo>
	cMsg += '                     <web1:Mensagem></web1:Mensagem>
	cMsg += '                     <web1:Documento>
	cMsg += '                        <web1:Tipo>NFE</web1:Tipo>
	cMsg += '                        <web1:Serie>0</web1:Serie>
	cMsg += '                        <web1:Emissao>20190830</web1:Emissao>
	cMsg += '                        <web1:Numero>123456</web1:Numero>
	//cMsg += '                        <web1:FotoItem>3434</web1:FotoItem>
	cMsg += '                        <web1:ChaveNota>35190853877627000949550050002308881278510684</web1:ChaveNota>
	cMsg += '                        <web1:ValorNota>30963.26</web1:ValorNota>
	cMsg += '                        <web1:ModeloDoc>teste</web1:ModeloDoc>
	cMsg += '                        <web1:Cnpj>09570732000191</web1:Cnpj>
	cMsg += '                        <web1:CnpjEmissor>09570732000191</web1:CnpjEmissor>
	cMsg += '                        <web1:CnpjTransportador>09570732000191</web1:CnpjTransportador>
	cMsg += '                        <web1:CnpjConsignatario>09570732000191</web1:CnpjConsignatario>
	cMsg += '                        <web1:Romaneio>34343434</web1:Romaneio>
	cMsg += '                        <web1:Remessa>4</web1:Remessa>
	cMsg += '                        <web1:Pedido>43434</web1:Pedido>
	cMsg += '                        <web1:Placa>gdw5233</web1:Placa>
	cMsg += '                        <web1:Filial>01</web1:Filial>
	cMsg += '                        <web1:Peso>44</web1:Peso>
	cMsg += '                        <web1:Cubagem>4</web1:Cubagem>
	cMsg += '                        <web1:ONU>34343434</web1:ONU>
	//cMsg += '                        <web1:Anotacao></web1:Anotacao>
	cMsg += '                        <web1:Agendamento></web1:Agendamento>
	cMsg += '                        <web1:PesoLiquido>1359.66</web1:PesoLiquido>
	cMsg += '                        <web1:Volume>6</web1:Volume>
	cMsg += '                        <web1:Janela>
	cMsg += '                           <web1:DataHoraIni>20190701 0400</web1:DataHoraIni>
	cMsg += '                           <web1:DataHoraFim>20190701 1800</web1:DataHoraFim>
	cMsg += '                        </web1:Janela>
	cMsg += '                        <web1:TipoMaterial>teste</web1:TipoMaterial>
	cMsg += '                        <web1:Fornecimento>3333</web1:Fornecimento>
	cMsg += '                        <web1:TipoFrete>Expresso</web1:TipoFrete>
	cMsg += '                        <web1:Modal>Rodoviario</web1:Modal>
	cMsg += '                        <web1:Sla>
	cMsg += '                           <web1:DiasUteis>0</web1:DiasUteis>
	cMsg += '                        </web1:Sla>
	cMsg += '                        <web1:Embarcador>
	cMsg += '                           <web1:cnpj>09570732000191</web1:cnpj>
	cMsg += '                           <web1:Nome>asdd</web1:Nome>
	cMsg += '                        </web1:Embarcador>
	cMsg += '                     </web1:Documento>
	cMsg += '                     <web1:Cliente>
	cMsg += '                        <web1:Codigo>03816532000351</web1:Codigo>
	cMsg += '                        <web1:codigointerno></web1:codigointerno>
	cMsg += '                        <web1:Contato></web1:Contato>
	cMsg += '                        <web1:Telefone>01137671400</web1:Telefone>
	cMsg += '                        <web1:Email>DOUGLAS.LOURENCO@BASF.COM</web1:Email>
	cMsg += '                        <web1:Razao>COLGATE PALMOLIVE INDUSTRIAL LTDA</web1:Razao>
	cMsg += '                        <web1:Endereco>RUA SANTO EURILO, 195</web1:Endereco>
	cMsg += '                        <web1:Bairro>CUMBICA</web1:Bairro>
	cMsg += '                        <web1:Cidade>GUARULHOS</web1:Cidade>
	cMsg += '                        <web1:Estado>SP</web1:Estado>
	cMsg += '                        <web1:Pais>BR</web1:Pais>
	cMsg += '                        <web1:CEP>07170325</web1:CEP>
	cMsg += '                        <web1:Regiao></web1:Regiao>
	cMsg += '                        <web1:TipoCliente></web1:TipoCliente>
	cMsg += '                        <web1:Mensagem></web1:Mensagem>
	cMsg += '                        <web1:gerentecodigo></web1:gerentecodigo>
	cMsg += '                        <web1:gerentenome></web1:gerentenome>
	cMsg += '                        <web1:gerenteemail></web1:gerenteemail>
	cMsg += '                        <web1:gerentecelular></web1:gerentecelular>
	cMsg += '                        <web1:supervisorcodigo></web1:supervisorcodigo>
	cMsg += '                        <web1:supervisornome></web1:supervisornome>
	cMsg += '                        <web1:supervisoremail></web1:supervisoremail>
	cMsg += '                        <web1:supervisorcelular></web1:supervisorcelular>
	cMsg += '                        <web1:CodigoIBGE></web1:CodigoIBGE>
	cMsg += '                     </web1:Cliente>
	cMsg += '                     <web1:danfes>
	cMsg += '                        <web1:danfe NumDanfe="">
	cMsg += '                           <web1:SerieDanfe></web1:SerieDanfe>
	cMsg += '                           <web1:chavedanfe></web1:chavedanfe>
	cMsg += '                           <web1:dataemissaodanfe></web1:dataemissaodanfe>
	cMsg += '                        </web1:danfe>
	cMsg += '                     </web1:danfes>
	cMsg += '                     <web1:SKUs>
	cMsg += '                        <web1:SKU codigo="4343434">
	cMsg += '                           <web1:PesoBruto>PESOBRUTO</web1:PesoBruto>
	cMsg += '                           <web1:PesoLiquido>1359,66</web1:PesoLiquido>
	cMsg += '                           <web1:Volumes>6</web1:Volumes>
	cMsg += '                           <web1:Descricao>000230888</web1:Descricao>
	cMsg += '                           <web1:Qde>1</web1:Qde>
	cMsg += '                           <web1:Uom>DOC</web1:Uom>
	cMsg += '                           <web1:Barcode></web1:Barcode>
	cMsg += '                        </web1:SKU>
	cMsg += '                     </web1:SKUs>
	cMsg += '                  </web1:Parada>
	cMsg += '               </web1:Paradas>
	cMsg += '            </web1:Rota>
	cMsg += '         </web1:Rotas>
	cMsg += '         <web1:nomeArquivo>teste.xml</web1:nomeArquivo>
	cMsg += '      </web1:uploadRoute>
	cMsg += '   </soapenv:Body>
	cMsg += '</soapenv:Envelope>

	oWsdl:SendSoapMsg(cMsg)
	cResp := oWsdl:GetParsedResponse()
	cRespost := oWsdl:GetSoapResponse()
	oXml := XmlParser( cRespost, "_", @cError, @cWarning )

Return



//ATUPEDIDOFBITS("239083", "103249479", "18", dDataAcao, cHoraAcao)
//User Function ATUPEDIDOFBITS(cNumPed, cPedWeb, cNewFase, dDataAcao, cHoraAcao)

User Function DeusSalva()
	Local cDataEnt := ""
	cNewFase := "11"
	Private aParams := {"01","02"}
	PREPARE ENVIRONMENT EMPRESA aParams[1] FILIAL aParams[2]
	cQuery := "SELECT CJ_XPEDIDO,CJ_XPEDWEB,GWU_DTENT,GWU_DTPENT FROM SCJ010"
	cQuery += " INNER JOIN SC5010"
	cQuery += " ON C5_NUM = CJ_XPEDIDO AND C5_CLIENTE = CJ_CLIENTE AND C5_FILIAL = CJ_FILIAL"
	cQuery += " INNER JOIN GWU010 ON C5_NOTA = GWU_NRDC AND C5_SERIE = GWU_SERDC"
	cQuery += " WHERE CJ_CLIENTE IN (SELECT A1_COD FROM SA1010 WHERE A1_CGC  IN ('99555514453')) "
	cQuery += " AND SC5010.D_E_L_E_T_ = '' AND SCJ010.D_E_L_E_T_ = '' AND GWU010.D_E_L_E_T_ = '' AND CJ_EMISSAO > '20190101' AND CJ_XPEDWEB <> ''"
	Iif(Select("DSA")>0,DSA->(DbCloseArea()),Nil)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"DSA")
	Count To nRecs
	DbGoTop()

	While DSA->(!EOF())
		If !Empty(AllTrim(DSA->CJ_XPEDWEB))
			cDataEnt := Iif(Empty(DSA->GWU_DTPENT),DtoS(dDataBase),DSA->GWU_DTPENT)
			u_ATUPEDIDOFBITS(DSA->CJ_XPEDIDO, DSA->CJ_XPEDWEB, cNewFase, StoD(cDataEnt),Nil)
		EndIf
		DSA->(DbSkip())
	End
Return




User Function TEST()
	Local cDBOra  := "MSSQL/TSS_PRODUCAO" // alterar o alias/dsn para o banco/conexão que está utilizando
	Local cSrvOra  := "192.168.1.30" // alterar para o ip do DbAccess
	Private aParams := {"01","02"}
	PREPARE ENVIRONMENT EMPRESA aParams[1] FILIAL aParams[2]
	nHwnd := TCLink(cDBOra, cSrvOra, 7890)
	If nHwnd >= 0
		conout("Conectado")
		LerTab()
		TCUnlink()
	EndIf
Return


Static Function LerTab()
	Local cQuery := ""
	cQuery := "SELECT ISNULL(CONVERT(VARCHAR(9595), CONVERT(VARBINARY(9595), XML_SIG)),'') AS OBSF2,* FROM SPED050 WHERE STATUS = '6' AND DATE_NFE >= '20190920' AND D_E_L_E_T_ = ''"
	Iif(Select("TSS")>0,TSS->(DbCloseArea()),Nil)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TSS")// TSS->XMLNFE  TSS->EMAIL
	Count To nRecs
	DbGoTop()
Return

User Function EXEC070()

	Local aBaixa := {}

	aBaixa := {{"E1_PREFIXO"  ,"   "                  ,Nil    },;
		{"E1_NUM"      ,"200      "            ,Nil    },;
		{"E1_TIPO"     ,"NF "                  ,Nil    },;
		{"AUTMOTBX"    ,"NOR"                  ,Nil    },;
		{"AUTBANCO"    ,"001"                  ,Nil    },;
		{"AUTAGENCIA"  ,"00001"                ,Nil    },;
		{"AUTCONTA"    ,"0000000001"           ,Nil    },;
		{"AUTDTBAIXA"  ,dDataBase              ,Nil    },;
		{"AUTDTCREDITO",dDataBase              ,Nil    },;
		{"AUTHIST"     ,"BAIXA TESTE"          ,Nil    },;
		{"AUTJUROS"    ,0                      ,Nil,.T.},;
		{"AUTVALREC"   ,700                    ,Nil    }}

	MSExecAuto({|x,y| Fina070(x,y)},aBaixa,3)

Return


user function getCA()
	Local cPFX := "\certs\COMPROVEI.pfx"
	Local cCA := "\certs\ca.pem"
	Local cError := ""
	Local cContent := ""
	Local lRet
	lRet := PFXCA2PEM( cPFX, cCA, @cError, "johSUGkEMGij3OkJ" )
	If( lRet == .F. )
		conout( "Error: " + cError )
	Else
		cContent := MemoRead( cCA )
		varinfo( "CA", cContent )
	Endif
Return


user function getCert()
	Local cPFX := "\certs\COMPROVEI.pfx"
	Local cCert := "\certs\cert.pem"
	Local cError := ""
	Local lRet
	lRet := PFXCert2PEM( cPFX, cCert, @cError, "johSUGkEMGij3OkJ" )
	If( lRet == .F. )
		conout( "Error: " + cError )
	Else
		cContent := MemoRead( cCert )
		varinfo( "Cert", cContent )
	Endif
return


user function getPrivKey()
	Local cPFX := "\certs\COMPROVEI.pfx"
	Local cKey := "\certs\key.pem"
	Local cError := ""
	Local cContent := ""
	Local lRet
	lRet := PFXKey2PEM( cPFX, cKey, @cError, "johSUGkEMGij3OkJ" )
	If( lRet == .F. )
		conout( "Error: " + cError )
	Else
		cContent := MemoRead( cKey )
		varinfo( "Key", cContent )
	Endif
Return



