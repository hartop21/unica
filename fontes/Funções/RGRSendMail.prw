*---------------------------------------------------------------------------*
/*/{Protheus.doc} RGRSendMail

@description Função de reaproveitamento com o objetivo de realizar o envio de e-mail conforme parâmetros passados para a função
@params
		_cFrom    --> Email que vai Enviar
		_cTo      --> Email para
		_cCC      --> Com Copia Para
		_cBCC     --> Com Copia Oculta Para
		_cAssunto --> Assunto do E-mail
		_cBody    --> Mensagem do E-mail
		_aAnexos  --> Vetor de Arquivos Anexos. Segue Ex. de Anexo - aAdd( _aAnexos, "\sigaadv\" + _cArqHTMLouGif )
		_lSchedule--> Define se vai rodar em Schedule para tratamento das menssagens de Log.
		_cRotina  --> Nome da Rotina para identificação dentro do Log.

@author Rafael Rezemde
@email rafael.rezende@rgrsolucoes.com
@since 14/08/2017
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/
*---------------------------------------------------------------------------*

#Include "TOTVS.ch"
#Include "Ap5Mail.Ch"
#Include "TbiConn.Ch"

*-----------------------------------------------------------------------------------------------------------------------------------------------------------*
User Function RGRSendMail( _cFrom, _cTo, _cCC, _cBCC, _cAssunto, _cBody, _aAnexos, _lSchedule, _cRotina, _lConfirmMail, _cMailFrom, _cPassMailFrom, _cError )
	*-----------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local _lAltentica  	  	:= GetNewPar( "MV_RELAUTH", .T. )
	Local _cMailServer   	:= AllTrim( GetNewPar( "MV_RELSERV", "email-ssl.com.br:587" ) ) //465
	Local _cContaEmail		:= AllTrim( GetNewPar( "MV_RELACNT", "workflow@rgrsolucoes.com" ) )
	Local _cPassConta  		:= AllTrim( GetNewPar( "MV_RELPSW", "RgRW@rkf10w2019"  ) )
	Local _cUserAltentic  	:= IIf( AllTrim( GetNewPar( "MV_RELAUSR", "" ) ) == "", AllTrim( GetMV( "MV_RELACNT" ) ), AllTrim( GetMv( "MV_RELAUSR" ) ) )
	Local _lHabilitado 		:= AllTrim( GetNewPar( "MV_XENVMAI", "S" ) ) == "S" // Parâmetro para Desabilitar o Envio dos E-mail. . .
	Local _cAnexo	 		:= ""
	Local _nK 				:= 0
	Local lDebugRGRSendMail := .T.
	Private _lResult   	  	:= .F.

	//Inicializa as Variaveis
	Default _cFrom   	  := _cContaEmail //If( AllTrim( GetNewPar( "MV_RELFROM", "" ) ) == "", _cContaEmail, AllTrim( GetNewPar( "MV_RELFROM", "" ) ) ) //Alnterado por L.Otavio 25/03
	Default _cTo     	  := ""
	Default _cCC     	  := ""
	Default _cBCC         := ""
	Default _cAssunto     := ""
	Default _cBody        := ""
	Default _aAnexos      := {}
	Default _lSchedule    := .F.
	Default _cRotina	  := ""
	Default _lAltentica	  := .F.
	Default _lConfirmMail := .F.
	Default _cMailFrom	  := ""
	Default _cPassMailFrom:= ""
	Default _cError 	  := ""

	If lDebugRGRSendMail

		ConOut( "##############################################" )
		ConOut( "#### RGRSENDMAIL - " + DToC( Date() ) + " - " + Time() + " ####" )
		ConOut( "##############################################" )
		ConOut( " - Servidor: 	   		 " + _cMailServer )
		ConOut( " - Conta Email:   		 " + _cContaEmail )
		ConOut( " - Senha Email:   		 " + Left( _cPassConta, 02 ) + Replicate( "*", ( Len( AllTrim( _cPassConta ) ) - 04 ) ) + Right( _cPassConta, 02 ) )
		ConOut( " - Exige Autenticação:  " + IIf( _lAltentica, "Sim", "Não" ) )
		ConOut( " - Conta Autenticação:  " + _cUserAltentic )
		ConOut( " - Envio Habilitado:    " + Iif( _lHabilitado, "Sim", "Não" ) )
		ConOut( "----------------------------------------------" )

	EndIf

	If !_lHabilitado
		Return .T.
	End If

	If AllTrim( _cMailFrom ) != ""
		_cContaEmail	  := _cMailFrom
		_cPassConta  	  := _cPassMailFrom
		_cUserAltentic    := _cMailFrom
	EndIf

	//Conecta no Servidor de SMTP para o Envio do E-mail
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cContaEmail PASSWORD _cPassConta RESULT _lResult
	If !_lResult
		_cError := ""
		GET MAIL ERROR _cError
		If !_lSchedule
			Aviso( "Atenção", "Houve um erro ao tentar conectar no Servidor SMTP para realizar o Envio de E-mail. " + _cError, { "Voltar" } )
		Else
			ConOut( _cRotina + " - Houve um erro ao tentar conectar no Servidor SMTP para realizar o Envio de E-mail. " + _cError )
		End If

	End If


	//Faz a Autenticação do Servidor de E-mails SMTP
	If _lResult
		If _lAltentica
			_lResult := MailAuth( _cUserAltentic, _cPassConta )
			If !_lResult
				If !_lSchedule
					Aviso( "Atenção", "Houve um erro ao tentar Autenticar no Servidor SMTP para realizar o Envio de E-mail. " + _cError, { "Voltar" } )
				Else
					ConOut( _cRotina + " - Houve um erro ao tentar Autenticar no Servidor SMTP para realizar o Envio de E-mail."  + _cError )
				End If
			End If
		End If
	End If

	//Realiza o Envio da Mensagem
	If _lResult

		If _lConfirmMail
			ConfirmMailRead( .T. )
		End If

		If Len( _aAnexos ) > 0

			_cAnexo := ""
			For _nK := 1 To Len( _aAnexos )
				_cAnexo += _aAnexos[_nK] + ","
			Next _nK
			_cAnexo := Replace( AllTrim( _cAnexo ) + ",", ",,", "" )

			If ( AllTrim( _cCC ) != "" .And. AllTrim( _cBCC ) != "" )
				SEND MAIL FROM _cFrom TO _cTo CC _cCC BCC _cBCC SUBJECT _cAssunto BODY _cBody ATTACHMENT _cAnexo RESULT _lResult
			ElseIf ( AllTrim( _cCC ) == "" .And. AllTrim( _cBCC ) == "" )
				SEND MAIL FROM _cFrom TO _cTo SUBJECT _cAssunto BODY _cBody ATTACHMENT _cAnexo RESULT _lResult
			ElseIf AllTrim( _cCC ) == ""
				SEND MAIL FROM _cFrom TO _cTo BCC _cBCC SUBJECT _cAssunto BODY _cBody ATTACHMENT _cAnexo RESULT _lResult
			Else
				SEND MAIL FROM _cFrom TO _cTo CC _cCC SUBJECT _cAssunto BODY _cBody ATTACHMENT _cAnexo RESULT _lResult
			End If

		Else

			If ( AllTrim( _cCC ) != "" .And. AllTrim( _cBCC ) != "" )
				SEND MAIL FROM _cFrom TO _cTo CC _cCC BCC _cBCC SUBJECT _cAssunto BODY _cBody RESULT _lResult
			ElseIf ( AllTrim( _cCC ) == "" .And. AllTrim( _cBCC ) == "" )
				SEND MAIL FROM _cFrom TO _cTo SUBJECT _cAssunto BODY _cBody RESULT _lResult
			ElseIf AllTrim( _cCC ) == ""
				SEND MAIL FROM _cFrom TO _cTo BCC _cBCC SUBJECT _cAssunto BODY _cBody RESULT _lResult
			Else
				SEND MAIL FROM _cFrom TO _cTo CC _cCC SUBJECT _cAssunto BODY _cBody RESULT _lResult
			EndIf

		EndIf

		If !_lResult
			_cError := ""
			GET MAIL ERROR _cError
			If !_lSchedule
				Aviso( "Atenção", "Houve um erro ao tentar enviar o E-mail." + _cError, { "Voltar" } )
			Else
				ConOut( _cRotina + " - Houve um erro ao tentar enviar o E-mail." + _cError )
			End If
		Else
			Conout("E-mail envado consucesso para "+_cTo)
		EndIf

	End If

	//Desconecta do Servidor SMTP.
	DISCONNECT SMTP SERVER

	ConOut( "##############################################" )


Return _lResult


*-----------------------------*
User Function RGRTSTSENDMAIL()
	*-----------------------------*

	//Prepare Environment Empresa "01" Filial "0101"
	RPCSetType( 03 )
	RPCSetEnv( "01", "0101" )

	// RGRSendMail( _cFrom, _cTo, _cCC, _cBCC, _cAssunto, _cBody, _aAnexos, _lSchedule, _cRotina, _lConfirmMail, _cMailFrom, _cPassMailFrom, _cError )
	_lRet := U_RGRSendMail( "", "rafael.rezende@rgrsolucoes.com", "", "", "Teste de envio de e-mail", "<html><body> <font Name='Arial' Sieze='2'> TESTE TESTE TESTE TESTE TESTE </font></body></html>", {}, .F., "RGRTSTSENDMAIL" )

	If _lRet
		Alert( "Um E-mail foi enviado." )
	Else
		Alert( "Não foi possível realizar o envio do Email." )
	End If

	RPCClearEnv()
	//Reset Environment

Return
