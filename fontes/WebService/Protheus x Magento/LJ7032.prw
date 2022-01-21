
/*/{Protheus.doc} LJ7032

@project Integração Protheus x Magento
@description Ponto de entrada para validar o acesso a tela de atendimento da venda no LOJA701

@author Rafael Rezende
@since 21/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*--------------------*
User Function LJ7032()
	*--------------------*
	Local nOpcX := ParamIxb[01]
	Local lRetA := .T.

	If nOpcX != 02 .And. nOpcX != 03

		If AllTrim( SL1->L1_XIDMAGE ) != ""
			Aviso(	"Atenção", "O Orçamento é referente ao Pedido [ " + SL1->L1_XIDMAGE + " ] do Magento e por isso não poderá ser Alterado / Finalizado manualmente.", { "Voltar" } )
			lRetA := .F.
		EndIf

	EndIf

Return lRetA

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ponto de entrada para validar o acesso a tela de atendimento da venda³
//³ Se retornar falso, volta para a MBrowse.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock( "FTVD7032" ) .AND. lFtvdVer12
	lContAtend := ExecBlock( "FTVD7032", .F., .F., { nOpc } )
	If ValType( lContAtend ) == "L" .AND. !lContAtend
		Return Nil
	EndIf
EndIf
*/

