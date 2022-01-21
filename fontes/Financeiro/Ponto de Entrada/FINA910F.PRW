*----------------------------------*
/*/{Protheus.doc} FINA910F

@project SITEF

@description Ponto de entrada que ocorre no processo de baixa da Conciliação SITEF, tem por objetivo retornar os dados bancários a serem gravados nas tabelas SE1 (Títulos a Receber) e SE5 (Movimento Bancário).

@author Rafael Rezende
@since 08/10/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

//Static __cFilSA6		:= Nil

#Include "TOTVS.ch"
#Include "TopConn.ch"


User function FINA910F()

	Local aDados 		:= ParamIxB
	Local aAreaOld 		:= GetArea()
	Local cAliasSA6 	:= GetNextAlias()
	Local aRet 			:= {} // Array com os dados do Banco, Agência e Conta Corrente a serem gravadas na tabela SE1 e SE5.

	/*
If Type( "__aBancos" ) != "A"
	aAuxBancos := {}
Else
	aAuxBancos := __aBancos
EndIf
If Type( "__cFilSA6" ) != "C"
	cAuxFilial := XFilial( "SA6" )
Else
	cAuxFilial := __cFilSA6
EndIf

Public __aBancos 	:= aClone( aAuxBancos )
Public __cFilSA6 	:= cAuxFilial
	*/

	// Banco
	cAuxBanco 		:= AllTrim( Str( Val( aDados[01] ) ) )
	//Agência
	cAuxAgencia 	:= AllTrim( Str( Val( aDados[02] ) ) )
	// Conta sem o dígito
	cAuxConta 		:= AllTrim( Str( Val( aDados[03] ) ) )

	aRet   := Nil
	cQuery := "	SELECT A6_FILIAL, A6_COD, A6_AGENCIA, A6_NUMCON, A6_DVAGE, A6_DVCTA, A6_BLOCKED "
	cQuery += "	  FROM " + RetSQLName( "SA6" )
	cQuery += "  WHERE D_E_L_E_T_ = ' ' "
	//cQuery += "    AND A6_FILIAL  = '" + XFilial( "SA6" ) + "' "
	cQuery += "    AND CHARINDEX( '" + cAuxBanco 	+ "', A6_COD	, 01 ) > 0 "
	cQuery += "    AND CHARINDEX( '" + cAuxAgencia 	+ "', A6_AGENCIA, 01 ) > 0 "
	cQuery += "    AND ( CHARINDEX( '" + cAuxConta 	+ "', A6_NUMCON , 01 ) > 0 "
	cQuery += "       OR CHARINDEX( '" + Left( cAuxConta, ( Len( cAuxConta ) - 01 ) ) + "', A6_NUMCON, 01 ) > 0 ) "
	If Select( cAliasSA6 ) > 0
		( cAliasSA6 )->( DbCloseArea() )
	EndIf
	//MemoWrite( "c:\temp\fina910f.txt", cQuery )
	TcQuery cQuery Alias ( cAliasSA6 ) New
	If !( cAliasSA6 )->( Eof() )

		aRet := {}
		//__cFilSA6 := ( cAliasSA6 )->A6_FILIAL
		aAdd( aRet, PadR( AllTrim( ( cAliasSA6 )->A6_COD     ), TamSX3( "E1_PORTADO" )[01] ) )
		aAdd( aRet, PadR( AllTrim( ( cAliasSA6 )->A6_AGENCIA ), TamSX3( "E1_AGEDEP"  )[01] ) )
		aAdd( aRet, PadR( AllTrim( ( cAliasSA6 )->A6_NUMCON  ), TamSX3( "E1_CONTA"   )[01] ) )

		/*
	If Type( "__aBancos" ) != "A"
		__aBancos := {}
	EndIf
	Alert( "Str( Len( __aBancos ) ) - " +  Str( Len( __aBancos ) ) )
	aAdd( __aBancos,	{	XFilial( "SA6" )				, ;
							( cAliasSA6 )->A6_COD			, ;
					 		( cAliasSA6 )->A6_AGENCIA		, ;
							( cAliasSA6 )->A6_DVAGE			, ;
							( cAliasSA6 )->A6_NUMCON		, ;
							( cAliasSA6 )->A6_DVCTA			, ;
							( cAliasSA6 )->A6_BLOCKED		, ;
							Nil								} )
	aAdd( __aBancos,	{	( cAliasSA6 )->A6_FILIAL		, ;
							( cAliasSA6 )->A6_COD			, ;
					 		( cAliasSA6 )->A6_AGENCIA		, ;
							( cAliasSA6 )->A6_DVAGE			, ;
							( cAliasSA6 )->A6_NUMCON		, ;
							( cAliasSA6 )->A6_DVCTA			, ;
							( cAliasSA6 )->A6_BLOCKED		, ;
							Nil								} )
	Alert( "Str( Len( __aBancos ) ) - " +  Str( Len( __aBancos ) ) )
		*/
	Else

		Aviso( "Atenção", "Não encontrou o Cadastro do Banco pelas informações do Arquivo SITEF." + CRLF + "Banco: " + cAuxBanco + CRLF + " Agência: " + cAuxAgencia + CRLF + "Conta: " + cAuxConta, { "Continuar" }, 03 )

	EndIf

	RestArea( aAreaOld )

Return aRet