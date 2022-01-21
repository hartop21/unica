
/*/{Protheus.doc} RGRSelMultiplos

@project Consulta genérica para Multipla Seleção
@description Rotina de uso genérico com o objetivo de retornar uma lista de opções para que o usuário possa realizar uma multipla seleção.
			 Sua maior utilidade será para seleção de parâmetros.
@author Rafael Rezende
@since 04/10/2011
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.Ch"

*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
User Function RGRSelMultiplos( _cAlias, _cCpoCodigo, _cCpoDescricao, _lEhMvPar, _cVarMvPar, _cTitulo, _lFilFilial, _nOrdem, _cSQLFiltro, _cTabelaSX5, _lRetTodos, _lSelTodos, _lApenasUm )
	*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local _aArea 			:= GetArea()
	Local _nOpc 			:= 00
	Local _cQuery 			:= ""
	Local _oSelTodos    	:= ""
	Local _oOk     			:= LoadBitmap( GetResources(), "LBOK" )
	Local _oNo      		:= LoadBitmap( GetResources(), "LBNO" )
	Local _cAliasPsq    	:= GetNextAlias()
	Local _cCpoFilial   	:= FRetCpoFilial( _cAlias )
	Local _oSBtnCancelar	:= Nil
	Local _oSBtnOk			:= Nil
	Local _oSBtnVisualizar	:= Nil
	Local _oGroup			:= Nil
	Local _oDlgPesq			:= Nil
	Private _oList			:= Nil
	Private _aListItens 	:= {}
	Private _bLine    		:= Nil

	Default _lEhMvPar	:= .F.
	Default _cVarMvPar	:= Nil
	Default _cTitulo    := Capital( Iif( AllTrim( _cTabelaSX5 ) == "", X2Nome( _cAlias ), Posicione( "SX5", 01, XFilial( "SX5" ) + PadR( AllTrim( _cTabelaSX5 ), TamSx3( "X5_TABELA" )[01] ) + "00", "X5_DESCRI" ) ) )
	Default _lFilFilial := .T.
	Default _nOrdem		:= 02
	Default _cSQLFiltro := ""
	Default _cTabelaSX5 := ""
	Default _lRetTodos  := .F.
	Default _lApenasUm  := .F.

	_cQuery := ""
	_cQuery := " SELECT A." + AllTrim ( _cCpoFilial    ) + " AS FILIAL, " + CRLF
	_cQuery += "        A." + AllTrim ( _cCpoCodigo    ) + " AS CODIGO, " + CRLF
	_cQuery += "        A." + AllTrim ( _cCpoDescricao ) + " AS DESCRI  " + CRLF
	_cQuery += "   FROM " + RetSQLName( _cAlias ) + " A "
	_cQuery += "  WHERE A.D_E_L_E_T_ = ' ' "
	If _lFilFilial
		_cQuery += "    AND A." + AllTrim ( _cCpoFilial    ) + " = '" + XFilial( _cAlias ) + "' " + CRLF
	End If
	If AllTrim( _cSQLFiltro ) != ""
		_cQuery += "    AND " + _cSQLFiltro + CRLF
	End If
	If AllTrim( _cTabelaSX5 ) != ""
		_cQuery += "	AND A.X5_TABELA  = '" + _cTabelaSX5 + "' "
	End If
	_cQuery += " ORDER BY A." + Iif( _nOrdem == 1, _cCpoCodigo, _cCpoDescricao )

	_aListItens := {}
	TcQuery _cQuery Alias ( _cAliasPsq ) New
	DbSelectArea( _cAliasPsq )
	( _cAliasPsq )->( DbGoTop() )
	Do While !( _cAliasPsq )->( Eof() )

		aAdd( _aListItens, { _lSelTodos, ( _cAliasPsq )->DESCRI, "", 00, ( _cAliasPsq )->CODIGO } )

		DbSelectArea( _cAliasPsq )
		( _cAliasPsq )->( DbSkip() )

		End Do

		DbSelectArea( _cAliasPsq )
		( _cAliasPsq )->( DbCloseArea() )

		If Len( _aListItens ) == 0
			Aviso( "Atenção", "Não foram encontradas informações para realizar esta consulta." + CRLF + "Alias: " + _cAlias + "Filtra Filial: " + Iif( _lFilFilial, "Sim", "Não" ), { "Voltar" } )
			Return .T.
		End If

		Define MsDialog _oDlgPesq Title _cTitulo FROM 000, 000  To 480, 608 Colors 0, 16777215 Pixel

		@ 009, 005 Group _oGroup To 231, 262 Prompt " Opções " Of _oDlgPesq Color 16711680, 16777215 Pixel
		If _nOrdem == 1
			@ 021, 011 ListBox _oList Fields Header "", "Código"   , "Descrição" FieldSizes 015, 050, 100 Size 243, 184 Of _oDlgPesq Colors 0, 16777215 Pixel
		Else
			@ 021, 011 ListBox _oList Fields Header "", "Descrição", "Código"    FieldSizes 015, 050, 100 Size 243, 184 Of _oDlgPesq Colors 0, 16777215 Pixel
		End If
		_oList:SetArray( _aListItens )
		_bLine    := { || { If ( _aListItens[_oList:nAt][01], _oOk, _oNo )	, ;
			_aListItens[_oList:nAt][02]				, ;
			_aListItens[_oList:nAt][05] 				} }
		_oList:bLine := _bLine
		_oList:bLDblClick := { || FMarcaLinha( _aListItens, _oList, _lApenasUm ) }

		Define SButton _oSBtnOk 		From 011, 268 Type 01 Of _oDlgPesq Enable Action ( _nOpc := 01, Iif( FValidaSel( _cAlias, _cCpoCodigo, _lFilFilial, _cTabelaSX5, _lEhMvPar, _nOrdem ), _oDlgPesq:End(), _nOpc := 00 ) )
		Define SButton _oSBtnCancelar 	From 024, 268 Type 02 Of _oDlgPesq Enable Action ( _nOpc := 00, _oDlgPesq:End() )
		Define SButton _oSBtnVisualizar From 041, 268 Type 15 Of _oDlgPesq Enable Action ( FLocaliza( _oList, _aListItens ) ) OnStop OemToAnsi( "Localizar" )

		If !_lApenasUm
			@ 213, 013 CheckBox _oSelTodos 	Var _lSelTodos Prompt "Marcar / Desmarcar todos" Size 081, 009 Of _oDlgPesq Colors 0, 16777215 Pixel On Click( aEval( _aListItens, { |x| x[01] := _lSelTodos } ), _oList:Refresh() )
		Else
			_lSelTodos := .F.
		End If

		Activate MsDialog _oDlgPesq Centered

		If _lEhMvPar
			If _nOpc == 01
				If !_lRetTodos

					_lTodos := .T.
					aEval( _aListItens, { |x| _lTodos := Iif( !x[01], .F., _lTodos ) } )
					If _lTodos
						_cRet := ""
					Else
						_cRet := FRetSQLIn( _aListItens, _nOrdem )
					End If
				Else
					If _lApenasUm
						_cRet := PadR( Replace( Replace( Replace( FRetSQLIn( _aListItens, _nOrdem ), "'", "" ), ",", "" ), " ", "" ), TamSX3( _cCpoCodigo )[01] )
					Else
						_cRet := FRetSQLIn( _aListItens, _nOrdem )
					End If
				End if
				&_cVarMvPar := _cRet
			End IF
		End If

		Return _aListItens


		*------------------------------------------------------------*
		Static Function FMarcaLinha( _aListItens, _oList, _lApenasUm )
			*------------------------------------------------------------*
			Local _nMarcados := 0

			If !_aListItens[ _oList:nAt][01] // Se for marcação

				If _lApenasUm // Se somente permitir a seleção de 1 item

					For _nI := 01 To Len( _aListItens )

						If _aListItens[_nI][01] // Se estiver marcado
							If ( _nI != _oList:nAt ) // E não é a linha atual
								_nMarcados++
								Exit
							End If
						End If

					Next _nI

					If _nMarcados > 0
						MsgStop( "Somente será permitida a seleção de uma linha." )
						Return
					End If

				End If

			End If

			_aListItens[ _oList:nAt][01] := !_aListItens[ _oList:nAt][01]
			_oList:Refresh()

		Return


		*-------------------------*
		Static Function FLocaliza()
			*-------------------------*
			Local _oDlgLocalizar	:= Nil
			Local _cPesquisa 		:= Space( 50 )
			Local _lCase 			:= .F.
			Local _lWord 			:= .F.
			Local _nUltimaPesq 		:= 0
			Local _cUltimaPesq 		:= ""
			Local _nPos 			:= _oList:nAt
			Local _aBuscas 			:= {}

			aEval( _aListItens, { |x, y| aAdd( _aBuscas, x[02] ) } )

			Define MsDialog _oDlgLocalizar From 00, 00 To 105, 370 Title "Pesquisa" Pixel

			@ 007, 002 Say "Pesquisar: " Of _oDlgLocalizar Pixel
			@ 005, 030 Get _cPesquisa    Of _oDlgLocalizar Pixel Size 100, 009

			@ 020, 002 To 51,130 Label "Opções" Pixel Of _oDlgLocalizar
			@ 027, 005 CheckBox _lCase Prompt "Coincidir maiúsc./minúsc"   Font _oDlgLocalizar:oFont Pixel Size 80, 09
			@ 038, 005 CheckBox _lWord Prompt "Localizar palavra &inteira" Font _oDlgLocalizar:oFont Pixel Size 80, 09

			@ 005, 135 Button "&Próximo"  Pixel Of _oDlgLocalizar Size 44, 11 Action ( _nPos := FBuscaRapida( _cPesquisa, _nPos, _aBuscas, _lCase, _lWord ), _oList:nAt := _nPos, _oList:Refresh() )
			@ 018, 135 Button "&Cancelar" Pixel Of _oDlgLocalizar SIZE 44, 11 Action ( _oDlgLocalizar:End() )

			Activate MsDialog _oDlgLocalizar Centered

		Return

		*--------------------------------------------------------------------------------*
		Static Function FBuscaRapida( _cPesquisa, _nUltimaPesq, _aBuscas, _lCase, _lWord )
			*--------------------------------------------------------------------------------*
			Local _nPesquisa := 0
			Local _bPesquisa := {|| }

			_cPesquisa := AllTrim( _cPesquisa )

			If ( _lCase .And. _lWord )
				_bPesquisa := { |x| AllTrim( x ) == _cPesquisa }
			ElseIf ( !_lCase .And. !_lWord )
				_bPesquisa := { |x| AllTrim( Upper( SubStr( x, 01, Len( _cPesquisa ) ) ) ) == Upper( _cPesquisa ) }
			ElseIf ( _lCase .And. !_lWord )
				_bPesquisa := { |x| AllTrim( SubStr( x, 01, Len( _cPesquisa ) ) ) == _cPesquisa }
			ElseIf ( !_lCase .And. _lWord )
				_bPesquisa := { |x| AllTrim( Upper( x ) ) == Upper( _cPesquisa ) }
			End If

			_nPesquisa := aScan( _aBuscas, _bPesquisa, _nUltimaPesq + 1 )
			If ( _nPesquisa == 0 )
				_nPesquisa := aScan( _aBuscas, _bPesquisa )
				If ( _nPesquisa == 0 )
					_nPesquisa := _nUltimaPesq
				End If
			End If

		Return _nPesquisa

		*--------------------------------------*
		Static Function FRetCpoFilial( _cAlias )
			*--------------------------------------*
			Local _aAux := ( _cAlias )->( DbStruct() )
			Local _nPos := aScan( _aAux, { |X| Right( Alltrim( X[01] ), 07 ) == "_FILIAL" } )

		Return Alltrim( _aAux[_nPos][01] )

		*-------------------------------*
		Static Function X2Nome( _cAlias )
			*-------------------------------*
			Local _cRet  := ""
			Local _aArea := GetArea()

			If Empty( _cAlias )
				_cAlias := Alias()
			End If

			DbSelectArea( "SX2" )
			_aAreaX2 := SX2->( GetArea() )
			DbSetOrder( 01 )
			If MsSeek( _cAlias, .F. )

				#IFDEF ENGLISH
					_cRet := SX2->X2_NOMEENG
				#ELSE
					#IFDEF SPANISH
						_cRet := SX2->X2_NOMESPA
					#ELSE
						_cRet := SX2->X2_NOME
					#ENDIF
				#ENDIF

			End If
			DbSelectArea( "SX2" )
			RestArea( _aAreaX2 )

			RestArea( _aArea )

		Return _cRet


		*-----------------------------------------------*
		Static Function FRetSQLIn( _aListItens, _nOrdem )
			*-----------------------------------------------*
			Local _cRet := ""
			Local _nPosCodigo := 05//Iif( _nOrdem == 1, 5, 3 )

			//aEval( _aListItens, { |x| _cRet += Iif( x[01], "'" + Alltrim( x[_nPosCodigo] ) + "',", "" ) } )
			aEval( _aListItens, { |x| _cRet += Iif( x[01], Alltrim( x[_nPosCodigo] ) + ",", "" ) } )
			//_cRet := "'" + AllTrim( _cRet ) + "," + "' "
			_cRet := AllTrim( _cRet ) + ","
			//_cRet := Replace( Replace( _cRet, ",,", "" ), "''", "'" )
			_cRet := Replace( _cRet, ",,", "" )

		Return _cRet


		*----------------------------------------------------------------------------------------------*
		Static Function FValidaSel( _cAlias, _cCpoCodigo, _lFilFilial, _cTabelaSX5, _lEhMvPar, _nOrdem )
			*----------------------------------------------------------------------------------------------*
			//Local _nTamCpo   := TamSX3( _cCpo )[01] + 1
			Local _nTamCpo   := FRetTamCpo( _cAlias, _cCpoCodigo, _lFilFilial, _cTabelaSX5 ) + 1
			Local _nTamItens := Int( ( 99 / _nTamCpo ) )
			Local _cRet 	 := FRetSQLIn( _aListItens, _nOrdem )
			Local _lRet      := .T.

			If _lEhMvPar
				If Len( _cRet ) > 99
					Aviso( "Atenção", "O Número máximo de Itens que pode ser selecionado é " + StrZero( _nTamItens, 02 ) + ".", { "Voltar" } )
					_lRet := .F.
				End If
			Else
				If Len( _cRet ) <= 2
					Aviso( "Atenção", "Selecione pelo menos 1 (um) item primeiro.", { "Voltar" } )
					_lRet := .F.
				End If
			End If

		Return _lRet



		User Function TRGRSelMul()

			Local _aRet := {}
			Private _cVar := ""

			_aRet := U_RGRSelMu( "SX5","X5_CHAVE","X5_DESCRI",.T.,"_cVar",,,1,,"05")
			Alert( "_cVar SX5: " + _cVar )

			_aRet := U_RGRSelMu( "CNO","CNO_CODTRA","CNO_DESCRI",.T.,"_cVar",,,1)
			Alert( "_cVar : " + _cVar )
			For I := 01 To Len( _aRet )
				If _aRet[I][01]
					alert( StrZero( I, 02 ) + " = " + _aRet[I][05] )
				End If
			Next I

		Return

		*--------------------------------------------------------------------------*
		Static Function FRetTamCpo( _cAlias, _cCpoCodigo, _lFilFilial, _cTabelaSX5 )
			*--------------------------------------------------------------------------*
			Local _aArea     := GetArea()
			Local _nRet		 := 0
			Local _cQuery    := ""
			Local _cAliasTam := GetNextAlias()
			Local _cCpoFilial:= FRetCpoFilial( _cAlias )

			_cQuery := "  SELECT MAX( LEN( RTRIM( LTRIM( " + _cCpoCodigo + " ) ) ) ) AS TAMANHO "
			_cQuery += "    FROM " + RetSQLName( _cAlias )
			_cQuery += "   WHERE D_E_L_E_T_ = ' ' "
			If _lFilFilial
				_cQuery += " AND " + AllTrim ( _cCpoFilial    ) + " = '" + XFilial( _cAlias ) + "' " + CRLF
			End If
			If AllTrim( _cTabelaSX5 ) != ""
				_cQuery += "	AND A.X5_TABELA  = '" + _cTabelaSX5 + "' "
			End If
			TcQuery _cQuery Alias ( _cAliasTam ) New
			If !( _cAliasTam )->( Eof() )
				_nRet := ( _cAliasTam )->TAMANHO
			Else
				_nRet := 0
			End If
			DbSelectArea( _cAliasTam )
			( _cAliasTam )->( DbCloseArea() )

			RestArea( _aArea )

		Return _nRet