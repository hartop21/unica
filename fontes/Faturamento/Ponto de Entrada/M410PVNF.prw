*----------------------------------*
/*/{Protheus.doc} M410PVNF

@project Trava no Faturamento

@description Ponto de entrada que ocorre no momento da gera��o do Faturamento, com o objetivo de realizar a valida��o se ocorreu a separa��o no ACD antes do faturamento

@author Rafael Rezende
@since 08/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"


User Function M410PVNF()

	Local aAreaAnt 		:= GetArea()
	Local aAreaCB7 		:= CB7->( GetArea() )
	Local lProssegue	:= .T.

	If AllTrim( SC5->C5_XCONF ) != "S"

		//Verificar se o pedido possui Ordem de Separa��o, caso contr�rio n�o permite a gera�ao da NF
		DbSelectArea( "CB7" )
		DbSetOrder( 02 ) // CB7_FILIAL+CB7_PEDIDO+CB7_LOCAL+CB7_STATUS+CB7_CLIENT+CB7_LOJA+CB7_COND+CB7_LOJENT+CB7_AGREG
		//Seek SC9->( C9_FILIAL + C9_PEDIDO )
		Seek SC5->( C5_FILIAL + C5_NUM )
		If Found()

			If Empty( CB7->CB7_DTFIMS )
				Aviso( "Aten��o", "O Pedido ainda encontr�-se em processo de Separa��o, o mesmo n�o poder� ser Faturado!", { "Voltar" } )
				lProssegue := .F.
			EndIf

		Else

			// Se n�o for Pedido oriundo do Magento ou Fluig
			If ( AllTrim( SC5->C5_XIDFLUI ) != "" .Or. AllTrim( SC5->C5_XIDMAGE ) != "" )

				Aviso( "Aten��o", "O Pedido precisa de processo de Separa��o para ser Faturado!", { "Voltar" } )
				lProssegue := .F.

			Else

				// Verifica se � uma Exce��o ( Atualizado o campo C5_XCONF
				If AllTrim( SC5->C5_FILIAL ) $ AllTrim( GetNewPar( "MV_XFILTRV", "0101, 0201" ) )

					Aviso( "Aten��o", "O Pedido precisa de processo de Separa��o para ser Faturado!", { "Voltar" } )
					lProssegue := .F.

				EndIf

			EndIf

		EndIf

	EndIf

	RestArea( aAreaCB7 )
	RestArea( aAreaAnt )

Return lProssegue