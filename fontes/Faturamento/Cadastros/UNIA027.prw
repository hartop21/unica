#include "TOTVS.CH"

// ###########################################################################################
// Projeto:
// Modulo :
// Função : 
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 16/09/2019 | Miqueias Dernier  | 
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
User Function UNIA027()
	MsgRun("Aguarde, carregando Pedidos","Pedidos B2W",  { || Run() } )	
Return

Static Function Run()
	Local aAlter := {}

	Local aObjects,aSize,aInfo,aPosObj ,nI
	Local aButtons := {}

	Local oEnch
	Local aField:={}

	Private aHeader,aCols
	Private oDlg,oMSNewGe1
	Private lConfirma
	Private oSaldos := JsonObject():new()

	Private oOk       		:= LoadBitmap( GetResources(), "LBOK" )
	Private oNo       		:= LoadBitmap( GetResources(), "LBNO" )


	Aadd( aButtons, {"Visualiza", {|| Visualiza()}, "Visualiza", "Visualiza" , {|| .T.}} )
	Aadd( aButtons, {"MARCA/DESMARCA", {|| Marca()}, "Marcando...", "Marca/Desmarca" , {|| .T.}} )
	


	//Cabeçalho
	//dbSelectArea("SX3")
	//dbSetOrder(2)
	//
	////C5_NUM
	//SX3->(dbSeek("C5_NUM"))
	//	AADD( aField, {;
	//		"Pedido" ,;//TITULO
	//		SX3->X3_CAMPO,;//SX3->X3_CAMPO
	//		SX3->X3_TIPO,;//TIPO
	//		SX3->X3_TAMANHO,;//TAMANHO
	//		SX3->X3_DECIMAL,;//DECIMAL
	//		SX3->X3_PICTURE,;//PICTURE
	//		{|| .T.},;//VALID
	//		.F.,;//OBRIGAT
	//		1,;//NIVEL
	//		,;//cEmpAnt,;//INICIALIZADOR PADRÃO       (*)Não está sendo avaliado
	//		"",;//F3
	//		,;//WHEN
	//		.T.,;//VISUAL
	//		.F.,;//CHAVE
	//		,;//OPCOES COMBO
	//		,;//FOLDER
	//		.F.,;//NAO ALTERAVEL         (*)OGRIGATORIO
	//		,;//PICT VAR
	//		;//GATILHO
	//	})
	//	M->C5_NUM := SC5->C5_NUM

	//+-----------------------------------------------+
	//¦ Montando aHeader para a Getdados              ¦
	//+-----------------------------------------------+
	dbSelectArea("SX3")
	dbSetOrder(2)
	aHeader:={}
	aAdd(aHeader, {' ', 'STATUS', '@BMP', 1, 0, '',, 'C',,,,,, 'V',,, .F.})

	////FILIAL
	//If dbSeek("D4_FILIAL")
	//	AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
	//		x3_picture,x3_tamanho,x3_decimal,;
	//		X3_VLDUSER,x3_usado,;
	//		x3_tipo, x3_f3, x3_context } )
	//		
	//EndIf
	If .T.
		AADD(aHeader,{ TRIM("Pedido B2W"),"PEDIDOB2W",;
		"",20,0,;
		"",nil,;
		"C", "", "" } )
	EndIf

	If dbSeek("C5_NOTA")
		AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
		x3_picture,x3_tamanho,x3_decimal,;
		X3_VLDUSER,x3_usado,;
		x3_tipo, x3_f3, x3_context } )
	EndIf
	If dbSeek("C5_SERIE")
		AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
		x3_picture,x3_tamanho,x3_decimal,;
		X3_VLDUSER,x3_usado,;
		x3_tipo, x3_f3, x3_context } )
	EndIf
	If dbSeek("C5_CLIENTE")
		AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
		x3_picture,x3_tamanho,x3_decimal,;
		X3_VLDUSER,x3_usado,;
		x3_tipo, x3_f3, x3_context } )
	EndIf
	If dbSeek("C5_LOJACLI")
		AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
		x3_picture,x3_tamanho,x3_decimal,;
		X3_VLDUSER,x3_usado,;
		x3_tipo, x3_f3, x3_context } )
	EndIf
	If dbSeek("A1_NOME")
		AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
		x3_picture,x3_tamanho,x3_decimal,;
		X3_VLDUSER,x3_usado,;
		x3_tipo, x3_f3, x3_context } )
	EndIf
	If dbSeek("A1_CGC")
		AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
		x3_picture,x3_tamanho,x3_decimal,;
		X3_VLDUSER,x3_usado,;
		x3_tipo, x3_f3, x3_context } )
	EndIf


	//+-----------------------------------------------+
	//¦ Montando aCols para a GetDados                ¦
	//+-----------------------------------------------+

	aCols := MontaCols()
	
	If Len(aCols) = 0
		Return
	EndIf


	//Monta Tela
	aObjects := {}
	aSize := MsAdvSize(.T.)
	aSize2 := MsAdvSize(.T.)

	aSize[3]:=aSize[3]*4/4
	aSize[4]:=aSize[4]*4/4
	aSize[5]:=aSize[5]*4/4
	aSize[6]:=aSize[6]*4/4

	AAdd(aObjects,{100,000,.T.,.T.,.F.})
	AAdd(aObjects,{100,100,.T.,.T.,.F.})
	aInfo := {aSize[1],aSize[2],aSize[3],aSize2[4],10,10}
	aPosObj := MsObjSize(aInfo,aObjects,.T.)
	oDlg:=MSDialog():New(aSize[7],aSize[8],aSize[6],aSize[5],'Entrega de Pedidos - B2W',,,,,CLR_BLACK,CLR_WHITE,,,.T.)

	//oEnch:=MSmGet():New(,,3,,,,,{aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]}/*/aPObj[1]*/,,,,,,oDlg,,,,,,,aField)

	oMSNewGe1 := MsNewGetDados():New(aPosObj[2,1], aPosObj[2,2], aPosObj[2,3], aPosObj[2,4],GD_UPDATE , 'AllwaysTrue()', 'AllwaysTrue()', '',aAlter ,, 999, 'AllwaysTrue()', '' , 'AllwaysTrue()', oDlg, aHeader, aCols)
	oMSNewGe1:oBrowse:blDblClick:={|| If(oMsNewGe1:aCols[oMsNewGe1:nAt][1]==oNo, oMsNewGe1:aCols[oMsNewGe1:nAt][1]:=oOk, oMsNewGe1:aCols[oMsNewGe1:nAt][1]:= oNo), oMsNewGe1:Refresh()}


	ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{|| lConfirma:=.T.,oDlg:End()},{|| lConfirma:=.F., oDlg:End()},,@aButtons))

	If lConfirma
		CriaPLP()
	EndIf

Return



// ###########################################################################################
// Projeto:
// Modulo :
// Função : 
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 23/10/2019 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function MontaCols(oPedidos, cQryAlias)
	Local aCols := {}
	Local nI, nJ
	Local aOrders := GetOrders()

	For nJ:=1 To Len(aOrders)
		cQuery := " SELECT TOP 1 * FROM "+RetFullName("SC5")+" SC5 "+CRLF
		cQuery += " JOIN "+RetFullName("SA1")+" SA1 "+CRLF
		cQuery += " 	ON SA1.D_E_L_E_T_='' AND A1_FILIAL='"+XFilial("SA1")+"' "+CRLF
		cQuery += " 	AND A1_COD = C5_CLIENTE AND A1_LOJA=C5_LOJACLI "+CRLF
		cQuery += " WHERE SC5.D_E_L_E_T_='' "+CRLF
		cQuery += " 	AND C5_FILIAL = '"+XFilial("SC5")+"' "+CRLF
		cQuery += " 	AND C5_XPEDMKT = '"+AllTrim(aOrders[nJ]:code)+"' "+CRLF

		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,'TOPCONN', TCGenQry(,,cQuery),(cQryAlias:=GetNextAlias()), .F., .T.)

		If (cQryAlias)->(!Eof())
			AADD( aCOLS, Array( Len( aHeader ) + 1 ) )
			For nI := 1 To Len( aHeader )
				Do Case
					Case Trim(aHeader[nI,2]) == "STATUS"
					aCols[Len(aCols)][nI] := If(.F., oOk, oNo)
					Case Trim(aHeader[nI,2]) == "PEDIDOB2W"
					aCols[Len(aCols)][nI] := aOrders[nJ]:code
					OtherWise
					If TamSx3(aHeader[nI,2])[3]=='D'
						aCols[Len(aCols)][nI] := STOD((cQryAlias)->(FieldGet(FieldPos(aHeader[nI,2]))))
					Else
						aCols[Len(aCols)][nI] := (cQryAlias)->(FieldGet(FieldPos(aHeader[nI,2])))
					EndIf
				EndCase
			Next nI
			aCOLS[Len(aCOLS),Len(aHeader)+1] := .F.

		EndIf
		(cQryAlias)->(dbCloseArea())


	Next

Return aCols


// ###########################################################################################
// Projeto:
// Modulo :
// Função : 
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 21/06/2020 | Miqueias Dernier  | 
//            |                   |
// -----------+-------------------+-----------------------------------------------------------

Static Function GetOrders()
	Local aHeader := {}
	Local oRestClient := FWRest():New("https://api.skyhub.com.br/shipments/b2w/to_group?offset=")
	Local oObjRet := JsonObject():new()
	Local aOrders := {}
	Local nI
	Local nOffSet
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")


	// PREENCHE CABEÇALHO DA REQUISIÇÃO
	AAdd(aHeader, "x-user-email: "+cUsuario)
	AAdd(aHeader, "x-api-key: "+cApiKey)
	AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
	AAdd(aHeader, "accept: application/json;charset=UTF-8")
	AAdd(aHeader, "content-type: application/json")

	nOffSet:=1
	oRestClient:setPath(CValToChar(nOffSet))
	While oRestClient:Get(aHeader)
		FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
		If Len(oObjRet:orders)>0
			For nI:=1 To Len(oObjRet:orders)
				If("DIRECT" $ oObjRet:orders[nI]:shipping)
					AAdd(aOrders, oObjRet:orders[nI])
				EndIf
			Next
		Else
			exit
		EndIf

		nOffSet++
		oRestClient:setPath(CValToChar(nOffSet))
	EndDo
Return aOrders


// ###########################################################################################
// Projeto:
// Modulo :
// Função : 
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |  
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function Visualiza()
	Local aArea := GetArea()
	Local aAreaSF2
	Local nPosDoc := AScan(aHeader,{|x| Trim(x[2])=="C5_NOTA" })
	Local nPosSer := AScan(aHeader,{|x| Trim(x[2])=="C5_SERIE" })

	dbSelectArea("SF2")
	aAreaSF2 := GetArea()
	dbSetOrder(1)
	If SF2->(dbSeek(XFilial("SF2")+oMsNewGe1:aCols[oMsNewGe1:nAt][nPosDoc]+oMsNewGe1:aCols[oMsNewGe1:nAt][nPosSer]))
		Mc090Visual()
	EndIf
	RestArea(aAreaSF2)
	RestArea(aArea)
Return


// ###########################################################################################
// Projeto:
// Modulo :
// Função : 
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |  
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function CriaPLP()
	Local lRet := .T.
	Local aHeader := {}
	Local oRestClient := FWRest():New("https://api.skyhub.com.br")
	Local oObjRet := JsonObject():new()

	Local nI
	Local nPosPed := AScan(oMSNewGe1:aHeader,{|x| Trim(x[2])=="PEDIDOB2W" })
	Local aPedidos := {}
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")
	

	oRestClient:setPath("/shipments/b2w/")

	For nI:=1 To Len(oMSNewGe1:aCols)
		If(!ATail(oMSNewGe1:aCols[nI]) .And. oMSNewGe1:aCols[nI][1] == oOk)
			AAdd(aPedidos, oMSNewGe1:aCols[nI][nPosPed])
		EndIf
	Next

	If Len(aPedidos)>0
		// PREENCHE CABEÇALHO DA REQUISIÇÃO
		AAdd(aHeader, "x-user-email: "+cUsuario)
		AAdd(aHeader, "x-api-key: "+cApiKey)
		AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
		AAdd(aHeader, "accept: application/json;charset=UTF-8")
		AAdd(aHeader, "content-type: application/json")


		oObjRet["order_remote_codes"] = aPedidos

		oRestclient:SetPostParams(FWJsonSerialize(oObjRet,.F.,.F.))


		lRet := oRestClient:Post(aHeader)

		If !lRet
			Alert(oRestClient:GetLastError())
		EndIf

	EndIf
Return lRet

// ###########################################################################################
// Projeto:
// Modulo :
// Função : 
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 25/06/2020 | Miqueias Dernier  | 
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function Marca()
Local nI
Local nPos := AScan(aHeader,{|x| Trim(x[2])=="STATUS" })
Local aCols := oMsNewGe1:aCols

//Se existe algum pedido marcado, desmarca
For nI:=1 To Len(aCols)
	aCols[nI, nPos] := If(aCols[nI, nPos] == oOk, oNo, oOk)
Next

oMsNewGe1:Refresh()
Return
