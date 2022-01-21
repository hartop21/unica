*----------------------------------*
/*/{Protheus.doc} ACD166FM

@project Trava no Faturamento

@description Ponto de entrada está localizado no fim do Processo de Separação, com o Objetivo de gravar flag no Pedido de Vendas para ser usado no momento da Geração da Nota

@author Rafael Rezende
@since 08/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"


User Function ACD166FM()

	Local aAreaAnt := GetArea()
	Local aAreaSC5 := SC5->( GetArea() )

	//-- Rotina de customização do usuárioReturn
	DbSelectArea( "SC5" )
	DbSetOrder( 01 )
	Seek CB7->( CB7_FILIAL + CB7_PEDIDO )
	If Found()

		If !Empty( CB7->CB7_DTFIMS )

			DbSelectArea( "SC5" )
			RecLock( "SC5", .F. )
			SC5->C5_XCONF := "S"
			SC5->( MsUnLock() )

		EndIf

	EndIf

	RestArea( aAreaSC5 )
	RestArea( aAreaAnt )

Return