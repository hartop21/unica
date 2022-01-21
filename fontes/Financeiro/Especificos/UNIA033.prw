#Include "TOTVS.ch"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UNIA033  ºAutor  ³ LUIZ OTAVIO CAMPOS  º Data ³  21/08/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela para mostrar o saldo do Cashback no cadastro do client º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³protheus                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function UNIA033
	Local oDlgCB  						// Objeto da tela
	Local oCB							// Objeto Get
	Local nCB   	:= 0         		// Conteudo capturado da leitura do documento

	oFont2 := TFont():New( "Ms Sans Serif", 09, 10,.T.,.T.,5,.T.,5,.T.,.F. )



	nCB := fbuscSaldo()

	DEFINE MSDIALOG oDlgCB FROM 12, 13 TO 140,220 TITLE "Consulta Cashback" PIXEL

	@ 2,5 TO 45,100 OF oDlgCB PIXEL

	@ 10,15 SAY "Saldo do Cashback"		SIZE 100,120  FONT  oFont2 PIXEL
	@ 23,15 MSGET oCB VAR nCB OF oDlgCB Picture "@E 999,999,999.99" when .F.  FONT  oFont2 SIZE 75,15 PIXEL

	DEFINE SBUTTON FROM 50,45 TYPE 1 ACTION oDlgCB:End() ENABLE OF oDlgCB PIXEL

	ACTIVATE MSDIALOG oDlgCB CENTERED


Return




/*-------------------------------------------------------------------*/
/* Função para buscar o saldo do cashback do cliente                 */
/*-------------------------------------------------------------------*/

Static Function fbuscSaldo()
	Local nSaldo := 0
	Local cquery := ""
	Local cNewAlias := GetNextAlias()

	cquery := " SELECT SUM(E1_SALDO) E1_SALDO"
	cquery += " FROM "+RetSqlName("SE1")
	cquery += " WHERE D_E_L_E_T_ = ' ' "
	//cquery += " AND E1_FILIAL = '"+xFilial("SE1")+"'"
	cquery += " AND E1_CLIENTE = '"+SA1->A1_COD+"'"
	cquery += " AND E1_LOJA = '"+SA1->A1_LOJA+"'"
	cquery += " AND E1_TIPO = 'NCC' "
	cquery += " AND E1_SALDO > 0 "
	cquery += " AND E1_PREFIXO = 'CSB' "

	Tcquery cQuery new Alias (cNewAlias)

	DbSelectArea(cNewAlias)
	DbGoTop()

	nSaldo := (cNewAlias)->E1_SALDO


	DbSelectArea(cNewAlias)
	dbCloseArea()

Return nSaldo
