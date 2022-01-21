#Include "TopConn.Ch"

**************************************************************************************
* Programa    : M020INC                                                Em : 05/11/19 *
* Objetivo    : O Ponto de Entrada M020INC está localizado na inclusão do Fornecedor *
*               para gravar o código do Fornecedor na tabela de Item Contábil.       *
* Autor       : Totvs                                                                *
**************************************************************************************    

User Function M020INC()


cQuery := "SELECT * FROM "+RETSQLNAME("CTD")
cQuery := cQuery  + " WHERE CTD_ITEM = '"+M->A2_COD+"' AND D_E_L_E_T_ <> '*' AND CTD_FILIAL='"+XFILIAL("CTD")+"'"
TcQuery cQuery New Alias "NCTD"
NCTD->(DbGoTop())
If NCTD->(Eof())
		RecLock("CTD",.T.)
			CTD->CTD_FILIAL	:= XFILIAL("CTD")
			CTD->CTD_ITEM	:= M->A2_COD
			CTD->CTD_CLASSE	:= "2"
			CTD->CTD_DESC01	:= SUBSTR(M->A2_NOME,1,40)
			//CTH->CTH_NORMAL	:= "0"
			CTD->CTD_BLOQ	:= "2"
			CTD->CTD_DTEXIS	:= STOD("19800101")
			CTD->CTD_ITLP	:= M->A2_COD
			//CTH->CTH_CLOBRG	:= "2"
			//CTH->CTH_ACCLVL	:= "1"
		CTD->( MsUnlock() )
EndIf
NCTD->(DBCLOSEAREA("NCTD"))
  
Return()

  