
/*/{Protheus.doc} UNIA016

@project Log para tratamento Magento
@modulo SIGALOJ
@type Atualização
@description Rotina do Consulta dos Logs do Magento que precisam de intervenção manual para continuidade do Processo
@author Rafael Rezende
@since 26/08/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA016()
	*---------------------*
	Local aAreaAntes    := GetArea()
	Local cAuxFiltro	:= ""
	Private cCadastro 	:= "Logs Magento para Intervenção manual"
	Private aRotina     := {}
	Private aCores 		:= { { "Z7_RESOLVIDO == 'S'", 'BR_VERDE'    },;
		{ "Z7_RESOLVIDO != 'S'", 'BR_VERMELHO' } }

	aAdd( aRotina, { "Pesquisar" 	 , "AxPesqui"	, 00, 01 } )
	aAdd( aRotina, { "Visualizar"	 , "AxVisual"	, 00, 02 } )
	aAdd( aRotina, { "Corrigir"		 , "U_UNIA016C"	, 00, 03 } )
	aAdd( aRotina, { "Legenda"	 	 , "U_UNIA016L"	, 00, 05 } )

	If Aviso( "Atenção", "Deseja visualizar apenas os Logs pendentes de intervenção?", { "Sim", "Não" } ) == 01

		cAuxFiltro := "SZ7->Z7_RESOLVIDO == 'S'"
		DbSelectArea( "SZ7" )
		SZ7->( DbSetFilter( { || &cAuxFiltro }, cAuxFiltro ) )

	EndIf

	DbSelectArea( "SZ7" )
	DbSetOrder( 01 )
	mBrowse( 06, 01, 22, 75, "SZ7",,,,,, aCores )

	DbSelectArea( "SZ7" )
	SZ7->( DbClearFilter( ) )

	RestArea( aAreaAntes )

Return


User Function UNIA016C()


	If Aviso( "Atenção", "Você confirma que a pendência no Pedido [ " + SZ7->Z7_IDMAGEN + " ] foi resolvida?", { "Sim", "Não" } ) == 01

		DbSelectArea( "SZ7" )
		RecLock( "SZ7", .F. )
		SZ7->Z7_RESOLVI := "S"
		SZ7->( MsUnLock() )

	EndIf

Return


User Function UNIA016L()

	Local aLegenda  := { { "BR_VERMELHO", "Pendente " } ,;
		{ "BR_VERDE" 	, "Resolvido" }  }

	BrwLegenda( "Status Ped. Magento", "Legenda", aLegenda )

Return