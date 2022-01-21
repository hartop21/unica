
/*/{Protheus.doc} UNIA017

@project Integra��o Protheus x Magento
@modulo SIGACFG
@type Atualiza��o
@description Rotina para permitir a manute��o das configura��es para as Inst�ncias do Magento.
@obs Para cada Inst�ncia criada e ativa dever� ser criado um Job para que a inst�ncia seja integrada no Protheus passando como par�metro o C�digo da Inst�ncia
@author Rafael Rezende
@since 27/08/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"

*---------------------*
User Function UNIA017()
	*---------------------*
	Local aAreaAntes    := GetArea()
	Local cAuxFiltro	:= ""
	Private cCadastro 	:= "Manuten��o Instancias Magento"
	Private aRotina     := {}
	Private aCores 		:= { { "Z8_MSBLQL != '1'", 'BR_VERDE'    },;
		{ "Z8_MSBLQL == '1'", 'BR_VERMELHO' } }

	aAdd( aRotina, { "Pesquisar" 	 , "AxPesqui"	, 00, 01 } )
	aAdd( aRotina, { "Visualizar"	 , "AxVisual"	, 00, 02 } )
	aAdd( aRotina, { "Incluir"		 , "AxInclui"	, 00, 03 } )
	aAdd( aRotina, { "Alterar"		 , "AxAltera"	, 00, 04 } )
	aAdd( aRotina, { "Testar"		 , "U_UNIA017T" , 00, 06 } )
	aAdd( aRotina, { "Legenda"	 	 , "U_UNIA017L"	, 00, 07 } )

	DbSelectArea( "SZ8" )
	DbSetOrder( 01 )
	mBrowse( 06, 01, 22, 75, "SZ8",,,,,, aCores )

	RestArea( aAreaAntes )

Return


User Function UNIA017L()

	Local aLegenda  := { { "BR_VERMELHO", "Habilitado" } ,;
		{ "BR_VERDE" 	, "Bloqueado"  }  }

	BrwLegenda( "Status das Inst�ncias", "Legenda", aLegenda )

Return


User Function UNIA017T()

	Local oWS := Nil

	If Aviso( "Aten��o", "Este � um teste de conex�o com a Inst�ncia selecionada do Magento." + CRLF + "Clique em [ Confirmar ] para a realiza��o do teste:", { "Confirmar", "Sair" } ) == 01

		Public _c_WsCodInstancia := Alltrim( SZ8->Z8_CODIGO )
		Public _c_WsLnkMagento   := AllTrim( SZ8->Z8_API    )
		Public _c_WsUserMagento  := AllTrim( SZ8->Z8_LOGIN  )
		Public _c_WsPassMagento  := AllTrim( SZ8->Z8_SENHA  )

		// Realiza o Login na API
		oWS 		 	:= WSMagentoService():New()
		oWs:cUserName	:= _c_WsUserMagento
		oWs:cApiKey		:= _c_WsPassMagento
		If !oWs:Login()
			Aviso( "Falha no Teste de Conex�o !!", "N�o foi poss�vel realizar a conex�o com a Inst�ncia Magento abaixo:" + CRLF + "Inst�ncia: " + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + CRLF + "Usu�rio: " + AllTrim( SZ8->Z8_LOGIN ) + CRLF + "Erro: " + AllTrim( GetWSCError() ), { "Voltar" }, 03 )
		Else
			oWs:EndSession()
			Aviso( "Sucesso no Teste de Conex�o !!", "A Conex�o com a Inst�ncia Magento abaixo foi realizada com sucesso !!." + CRLF + "Inst�ncia: " + SZ8->Z8_CODIGO + " - " + AllTrim( SZ8->Z8_DESCRIC ) + CRLF + "Usu�rio: " + AllTrim( SZ8->Z8_LOGIN ), { "Voltar" }, 03 )
		EndIf

		_c_WsCodInstancia := Nil
		_c_WsLnkMagento   := Nil
		_c_WsUserMagento  := Nil
		_c_WsPassMagento  := Nil

	EndIf

Return