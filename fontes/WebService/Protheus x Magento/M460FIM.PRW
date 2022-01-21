#Include "TOTVS.ch"
#Include "Rwmake.Ch"
#Include "TopConn.Ch"
#Include "Fileio.ch"
#Include "Colors.ch"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"


//±±³Descricao ³ Ponto de entrada executado apos a gravacao dos dados da nf ³±±
//±±³			 ³ Seu objetivo e permitir a gravacao de dados adicionais.    ³±±
*---------------------*
User Function M460FIM()
	*---------------------*
	Local aAreaOld := GetArea()
	Local cQuery   := ""
	Local cAliasSE1	:= GetNextAlias()

	DbSelectArea( "SF2" )
	RecLock( "SF2", .F. )
	SF2->F2_ESPECI1 := "VOLUME"
	SF2->F2_VOLUME1 := SC5->C5_VOLUME1
	SF2->F2_TPFRETE := SC5->C5_TPFRETE
	SF2->( MsUnLock() )

	//Lucas Miranda - 01/06/2020
	//Gravar número da NF nos campos do título(sendo pelo loja ou comum)
	cQuery := "SELECT R_E_C_N_O_, E1_XNOTA FROM " + RetSqlName("SE1")
	If AllTrim(SF2->F2_DUPL) != ""
		cQuery += " WHERE D_E_L_E_T_ = '' AND E1_NUM = '" + SF2->F2_DUPL + "' AND E1_CLIENTE = '" + SF2->F2_CLIENTE +"' AND E1_FILIAL = '"+Xfilial("SE1")+"'"
	Else
		cQuery += " WHERE D_E_L_E_T_ = '' AND E1_EMISSAO = '" + Dtos(SF2->F2_EMISSAO) + "' AND E1_CLIENTE = '" + SF2->F2_CLIENTE + "' AND E1_FILIAL = '"+Xfilial("SE1")+"'"
	EndIf
	If Select( cAliasSE1 ) > 0
		( cAliasSE1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSE1 ) New
	If !( cAliasSE1 )->( Eof() )
		DbSelectArea( "SE1" )
		( cAliasSE1 )->(DbGoTop())
		While !( cAliasSE1 )->( Eof() )
			DbGoto(( cAliasSE1 )->R_E_C_N_O_)
			If Empty(AllTrim(( cAliasSE1 )->E1_XNOTA))
				RecLock("SE1",.F.)
				SE1->E1_NUMNOTA := SF2->F2_DOC
				SE1->E1_XNOTA   := SF2->F2_DOC
				SE1->E1_SERIE   := SF2->F2_SERIE
				SE1->E1_XSERIE  := SF2->F2_SERIE
				SE1->(MsUnLock())
			EndIF
			( cAliasSE1 )->(DbSkip())
		EndDo
		( cAliasSE1 )->( DbCloseArea() )
	EndIf
	//Fim

	RestArea( aAreaOld )

Return