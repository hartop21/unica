#Include "TopConn.Ch"

**************************************************************************************
* Programa    : M030INC                                                Em : 26/05/14 *
* Objetivo    : O Ponto de Entrada M030INC está localizado na inclusão do Cliente    *
*               para gravar o código do Cliente na tabela de Item Contábil.          *
* Autor       : Totvs                                                                *
**************************************************************************************    

User Function M030INC()
Local aArea := getArea()
dbselectarea("SA1")
cQuery := "SELECT * FROM "+RETSQLNAME("CTD")
cQuery := cQuery  + " WHERE CTD_ITEM = '"+SA1->A1_COD+"' AND D_E_L_E_T_ <> '*' AND CTD_FILIAL='"+XFILIAL("CTD")+"'" 

if Select("MCTD") > 0
	dbSelectArea("MCTD")
	dbCloseArea()
EndIf

TcQuery cQuery New Alias "MCTD"
MCTD->(DbGoTop())
If MCTD->(Eof())
		RecLock("CTD",.T.)
			CTD->CTD_FILIAL	:= XFILIAL("CTD")
			CTD->CTD_ITEM	:= SA1->A1_COD
			CTD->CTD_CLASSE	:= "2"
			CTD->CTD_DESC01	:= SUBSTR(SA1->A1_NOME,1,40)
			//CTH->CTH_NORMAL	:= "0"
			CTD->CTD_BLOQ	:= "2"
			CTD->CTD_DTEXIS	:= STOD("19800101")
			CTD->CTD_ITLP	:= SA1->A1_COD
			//CTH->CTH_CLOBRG	:= "2"
			//CTH->CTH_ACCLVL	:= "1"
		CTD->( MsUnlock() )
EndIf
MCTD->(DBCLOSEAREA("MCTD"))

restArea(aArea)  
Return()

  