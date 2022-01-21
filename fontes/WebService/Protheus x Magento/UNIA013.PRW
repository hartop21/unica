
/*/{Protheus.doc} UNIA013

@project Integração Protheus x Magento
@description Rotina com o objetivo de permitir que o usuário altere a TES ou a Transportadora sem precisar alterar o Pedido ( através da rotina padrão de Pedido de Vendas )
@author Rafael Rezende
@since 15/07/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"

*---------------------*
User Function UNIA013()
	*---------------------*
	Local aAreaAnterior 	:= GetArea()
	Local aAreaSC5		 	:= SC5->( GetArea() )
	Private cGetAtuTES 		:= ""
	Private cGetAtuTransp 	:= ""
	Private cGetAtuDesc 	:= ""
	Private cGetAtuNome 	:= ""
	Private cGetNovaTES 	:= Space( TamSX3( "C6_TES"    )[01] )
	Private cGetNovaTransp	:= Space( TamSX3( "C5_TRANSP" )[01] )
	Private cGetNovaDesc 	:= ""
	Private cGetNovaNome 	:= ""

	SetPrvt("oDlgAltPV","oGrpPedido","oSayAtuTES","oSayAtuTransp","oGetAtuTES","oGetAtuDesc","oGetAtuTransp")
	SetPrvt("oSayNovaTES","oGetNovaTES","oSayNovaTransp","oGetNovaTransp","oGetNovaNome","oGetNovaDesc","oBtnConfirm")

	DbSelectArea( "SC5" )
	If ( AllTrim( SC5->C5_XIDMAGE ) == "" .And. AllTrim( SC5->C5_XIDFLUI ) == "" )
		Aviso( "Atenção", "Essa rotina apenas está disponível para Pedidos oriundos da Integração com o Magento ou do Fluig.", { "Voltar" } )
		Return
	EndIf

	If AllTrim( SC5->C5_NOTA ) != ""
		Aviso( "Atenção", "Só será possível alterar as informações de TES e Transportadora para pedidos em aberto ( Não faturados ).", { "Voltar" } )
		Return
	EndIf

	cGetAtuTransp 			:= SC5->C5_TRANSP

	DbSelectArea( "SC6" )
	DbSetOrder( 01 )
	Seek SC5->( C5_FILIAL + C5_NUM )
	If Found()
		cGetAtuTES 			:= SC6->C6_TES
	EndIf

	oDlgAltPV  				:= MSDialog():New( 138,254,400,1076,"Alteração de informações do Pedido",,,.F.,,,,,,.T.,,,.F. )
	oGrpPedido 				:= TGroup():New( 004,008,116,331," PEDIDO N° " + SC5->C5_NUM ,oDlgAltPV,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayAtuTES 				:= TSay():New( 015,016,{||"TES Atual:"},oGrpPedido,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oGetAtuTES 				:= TGet():New( 023,016,,oGrpPedido,028,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SF4","cGetAtuTES",,)
	oGetAtuTES:bSetGet 		:= {|u| If(PCount()>0,cGetAtuTES:=u,cGetAtuTES)}
	oGetAtuTES:bWhen 		:= { || .F. }

	oGetAtuDesc				:= TGet():New( 023,054,,oGrpPedido,269,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetAtuDesc",,)
	oGetAtuDesc:bSetGet 	:= {|u| If(PCount()>0,cGetAtuDesc:=u,cGetAtuDesc)}
	oGetAtuDesc:bWhen 		:= { || .F. }

	oSayAtuTransp			:= TSay():New( 036,016,{||"Transportadora Atual:"},oGrpPedido,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,071,008)
	oGetAtuTransp 			:= TGet():New( 045,016,,oGrpPedido,044,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA4","cGetAtuTransp",,)
	oGetAtuTransp:bSetGet 	:= {|u| If(PCount()>0,cGetAtuTransp:=u,cGetAtuTransp)}
	oGetAtuTransp:bWhen 	:= { || .F. }

	oGetAtuNome 			:= TGet():New( 045,069,,oGrpPedido,253,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetAtuNome",,)
	oGetAtuNome:bSetGet 	:= {|u| If(PCount()>0,cGetAtuNome:=u,cGetAtuNome)}
	oGetAtuNome:bWhen 		:= { || .F. }


	oSayNovaTES 			:= TSay():New( 067,016,{||"Nova TES:"},oGrpPedido,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,045,008)
	oGetNovaTES 			:= TGet():New( 075,016,,oGrpPedido,028,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SF4","cGetNovaTES",,)
	oGetNovaTES:bSetGet 	:= {|u| If(PCount()>0,cGetNovaTES:=u,cGetNovaTES)}
	oGetNovaTES:bValid 		:= { || FVldTES( 2 ) }

	oGetNovaDesc 			:= TGet():New( 075,054,,oGrpPedido,268,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetNovaDesc",,)
	oGetNovaDesc:bSetGet 	:= {|u| If(PCount()>0,cGetNovaDesc:=u,cGetNovaDesc)}
	oGetNovaDesc:bWhen 		:= { || .F. }


	oSayNovaTransp 			:= TSay():New( 088,016,{||"Nova Transportadora :"},oGrpPedido,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,059,008)
	oGetNovaTransp 			:= TGet():New( 097,016,,oGrpPedido,044,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA4","cGetNovaTransp",,)
	oGetNovaTransp:bSetGet 	:= {|u| If(PCount()>0,cGetNovaTransp:=u,cGetNovaTransp)}
	oGetNovaTransp:bValid 	:= { || FVldTransp( 2 ) }

	oGetNovaNome 			:= TGet():New( 097,069,,oGrpPedido,253,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetNovaNome",,)
	oGetNovaNome:bSetGet 	:= {|u| If(PCount()>0,cGetNovaNome:=u,cGetNovaNome)}
	oGetNovaNome:bWhen 		:= { || .F. }

	oBtnConfirm 			:= TButton():New( 006,336,"Confirmar",oDlgAltPV,,064,012,,,,.T.,,"",,,,.F. )
	oBtnConfirm:bAction 	:= { || FConfirmar() }

	oBtnCancelar 			:= TButton():New( 023,336,"Cancelar",oDlgAltPV,,064,012,,,,.T.,,"",,,,.F. )
	oBtnCancelar:bAction 	:= { || oDlgAltPV:End() }

	FVldTES( 1 )
	//FVldTES( 2 )
	FVldTransp( 1 )
	//FVldTransp( 2 )

	oDlgAltPV:Activate( ,,, .T. )

	RestArea( aAreaSC5		)
	RestArea( aAreaAnterior )

Return


Static Function FVldTES( nParamTipo )

	Local aAreaAtu := GetArea()
	Local aAreaSF4 := SF4->( GetArea() )

	Local lRet := .T.

	DbSelectArea( "SF4" )
	DbSetOrder( 01 )

	If nParamTipo == 01

		If AllTrim( cGetAtuTES ) != ""
			Seek XFilial( "SF4" ) + cGetAtuTES
			If Found()

				If AllTrim( SF4->F4_CODIGO ) < "500"
					cGetAtuDesc := ""
					Aviso( "Atenção", "Não encontrou a TES", { "Voltar" } )
					lRet := .F.
				Else
					cGetAtuDesc := SF4->F4_TEXTO
				EndIf

			Else

				cGetAtuDesc := ""
				Aviso( "Atenção", "Não encontrou a TES", { "Voltar" } )
				lRet := .F.

			EndIf
		Else
			cGetAtuDesc := ""
		EndIf

	Else

		If AllTrim( cGetNovaTES ) != ""
			Seek XFilial( "SF4" ) + cGetNovaTES
			If Found()
				cGetNovaDesc := SF4->F4_TEXTO
			Else
				cGetNovaDesc := ""
				Aviso( "Atenção", "Não encontrou a TES", { "Voltar" } )
				lRet := .F.
			EndIf
		Else
			cGetNovaDesc := ""
		EndIf

	EndIf

	RestArea( aAreaSF4 )
	RestArea( aAreaAtu )

Return lRet

*--------------------------------------*
Static Function FVldTransp( nParamTipo )
	*--------------------------------------*
	Local aAreaAtu := GetArea()
	Local aAreaSA4 := SA4->( GetArea() )

	Local lRet := .T.

	DbSelectArea( "SA4" )
	DbSetOrder( 01 )

	If nParamTipo == 01

		If AllTrim( cGetAtuTransp ) != ""
			Seek XFilial( "SA4" ) + cGetAtuTransp
			If Found()
				cGetAtuNome:= SA4->A4_NOME
			Else
				cGetAtuNome := ""
				Aviso( "Atenção", "Não encontrou a Transportadora informada", { "Voltar" } )
				lRet := .F.
			EndIf
		Else
			cGetAtuTransp := ""
		EndIf

	Else

		If AllTrim( cGetNovaTransp ) != ""
			Seek XFilial( "SA4" ) + cGetNovaTransp
			If Found()
				cGetNovaNome:= SA4->A4_NOME
			Else
				cGetNovaNome := ""
				Aviso( "Atenção", "Não encontrou a Transportadora informada", { "Voltar" } )
				lRet := .F.
			EndIf
		Else
			cGetNovaTransp := ""
		EndIf

	EndIf

	RestArea( aAreaSA4 )
	RestArea( aAreaAtu )

Return lRet

*--------------------------*
Static Function FConfirmar()
	*--------------------------*
	Local lErro := .F.

	If AllTrim( cGetNovaTES ) == ""
		Aviso( "Atenção", "O Campo de [ Nova TES ] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	If AllTrim( cGetNovaTransp ) == ""
		Aviso( "Atenção", "O Campo de [ Nova Transportadora ] é obrigatório.", { "Voltar" } )
		Return
	EndIf

	cUpdate := "	UPDATE " + RetSQLName( "SC5" )
	cUpdate += "	   SET C5_TRANSP  = '" + cGetNovaTransp  + "' "
	cUpdate += "	 WHERE C5_FILIAL  = '" + SC5->C5_FILIAL  + "' "
	cUpdate += "	   AND C5_NUM     = '" + SC5->C5_NUM     + "' "
	cUpdate += "	   AND C5_CLIENTE = '" + SC5->C5_CLIENTE + "' "
	cUpdate += "	   AND C5_LOJACLI = '" + SC5->C5_LOJACLI + "' "
	If TcSQLExec( cUpdate ) != 0
		Aviso( "Atenção", "Erro ao tentar atualizar a Transportadora no Pedido." + CRLF + TcSQLError(), { "Sair" } )
		lErro := .F.
	EndIf

	If !lErro

		cUpdate := "	UPDATE " + RetSQLName( "SC6" )
		cUpdate += "	   SET C6_TES 	 = '" + cGetNovaTES + "' "
		cUpdate += "	 WHERE C6_FILIAL = '" + SC5->C5_FILIAL 	+ "' "
		cUpdate += "	   AND C6_NUM    = '" + SC5->C5_NUM    	+ "' "
		cUpdate += "	   AND C6_CLI    = '" + SC5->C5_CLIENTE + "' "
		cUpdate += "	   AND C6_LOJA   = '" + SC5->C5_LOJACLI + "' "
		If TcSQLExec( cUpdate ) != 0
			Aviso( "Atenção", "Erro ao tentar atualizar a TES no Pedido." + CRLF + TcSQLError(), { "Sair" } )
			lErro := .F.
		EndIf

	EndIf

	oDlgAltPV:End()

	If !lErro
		Aviso( "Atenção", "As informações foram atualizadas com sucesso!", { "Ok" } )
	EndIf

Return