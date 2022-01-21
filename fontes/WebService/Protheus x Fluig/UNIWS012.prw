#include 'protheus.ch'
#include 'apwebsrv.ch'
#include 'tbiconn.ch'
#include "topconn.ch"

#define cEOL CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบM้todo    ณ UNIWS012 บ Autor ณ Marcelo Amaral      บ Data ณ 02/12/2019 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ WebServices Diversos                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Unica                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

/*-----------------------------------------------------------
|Estrutura: tForn	                                  	    |
|-----------------------------------------------------------|
|Descri็ใo : Estrutura que serแ encapsulada pelo array      |
|tGetForn									                |
|-----------------------------------------------------------*/

WSSTRUCT tForn
	WSDATA FILIAL	AS String
	WSDATA COD		AS String
	WSDATA LOJA 	AS String
	WSDATA NOME		AS String
	WSDATA NREDUZ	AS String
	/*
	WSDATA ENDER	AS String
	WSDATA NR_END	AS String
	WSDATA COMPLEM	AS String
	WSDATA EST		AS String
	WSDATA COD_MUN	AS String
	WSDATA MUN		AS String
	WSDATA BAIRRO	AS String
	WSDATA CEP		AS String
	WSDATA TIPO		AS String
	WSDATA PFISICA	AS String
	WSDATA CGC		AS String
	WSDATA DDD		AS String
	WSDATA TEL		AS String
	WSDATA FAX		AS String
	WSDATA INSCR	AS String
	WSDATA INSCRM	AS String
	WSDATA TPESSOA	AS String
	WSDATA BANCO	AS String
	WSDATA AGENCIA	AS String
	WSDATA NUMCON	AS String
	WSDATA DVCTA	AS String
	WSDATA PAIS		AS String
	WSDATA EMAIL	AS String
	WSDATA CODPAIS	AS String
	WSDATA CONTA	AS String
	WSDATA REPRES	AS String
	WSDATA REPRTEL	AS String
	WSDATA MSBLQL	AS String*/
ENDWSSTRUCT

/*-----------------------------------------------------------
|Servi็o: UNIWS012	                                 	    |
|-----------------------------------------------------------|
|Descri็ใo :Servi็o de WebService utilizado para realizar   |
|opera็๕es diversas no ERP									|
|-----------------------------------------------------------*/

WSSERVICE UNIWS012 DESCRIPTION "SERVIวO GENษRICO PARA OPERACOES DIVERSAS"
	WSDATA cEmpWeb      AS String
	WSDATA cFilWeb      AS String
//	WSDATA cUsrWeb      AS String
//	WSDATA cPswWeb      AS String
//	WSDATA dDataIniWeb  AS Date
//	WSDATA dDataFimWeb	AS Date
//	WSDATA cCodFornWeb	AS String
//	WSDATA cNomFornWeb	AS String
	WSDATA tGetForn		AS Array OF tForn
	WSMETHOD UNIWS012A DESCRIPTION "M้todo de Sele็ใo da SA2 - Cadastro de Fornecedores."
ENDWSSERVICE

/*-----------------------------------------------------------
|Servi็o: UNIWS012A	                                  	    |
|-----------------------------------------------------------|
|Descri็ใo :M้todo para consultar Fornecedores.				|
|-----------------------------------------------------------|
|Recebe: cEmpWeb,cFilWeb,cUsrWeb,cPswWeb					|
|-----------------------------------------------------------|
|Retorno: tGetForn - Array da estrutura tForn				|
|-----------------------------------------------------------*/

WSMETHOD UNIWS012A WSRECEIVE cEmpWeb,cFilWeb/*,cUsrWeb,cPswWeb,cCodFornWeb,cNomFornWeb*/ WSSEND tGetForn WSSERVICE UNIWS012

Local oTemp
Local lRet := .T.
Local cEmp := ::cEmpWeb
Local cFil := ::cFilWeb
Local cAliasSA2 := GetNextAlias()
//Local cWhereCodForn := "%1=1%"
//Local cWhereNomForn := "%1=1%"

If Empty(cEmp)
	SetSoapFault(ProcName(),"Empresa nใo preenchida.")
	lRet := .F.
	Return lRet
EndIf

If Empty(cFil)
	SetSoapFault(ProcName(),"Filial nใo preenchida.")
	lRet := .F.
	Return lRet
EndIf

RpcClearEnv()
RpcSetType(3)
If !RpcSetEnv(cEmp,cFil)
	SetSoapFault(ProcName(),"Nใo foi possํvel Preparar o Ambiente para a Empresa " + cEmp + " / Filial " + cFil + ".")
	lRet := .F.
	Return lRet
EndIf

aRetUsr := fVldUsr(cUsrWeb,cPswWeb)

If !aRetUsr[1]
	SetSoapFault(ProcName(),aRetUsr[2])
	lRet := .F.
	Return lRet
EndIf

::tGetForn := {}

/*
if !Empty(cCodFornWeb)
	cWhereCodForn := "%A2_COD = '" + cCodFornWeb + "'%"
endif

if !Empty(cNomFornWeb)
	cWhereNomForn := "%A2_NOME LIKE '%" + cNomFornWeb + "%'%"
endif
*/

BEGINSQL ALIAS cAliasSA2
	SELECT A2_FILIAL,A2_COD,A2_LOJA,A2_NOME,A2_NREDUZ/*,A2_END,A2_NR_END,A2_COMPLEM,
	A2_EST,A2_COD_MUN,A2_MUN,A2_BAIRRO,A2_CEP,A2_TIPO,A2_PFISICA,A2_CGC,
	A2_DDD,A2_TEL,A2_FAX,A2_INSCR,A2_INSCRM,A2_TPESSOA,A2_BANCO,A2_AGENCIA,A2_NUMCON,A2_DVCTA,
	A2_PAIS,A2_EMAIL,A2_CODPAIS,A2_CONTA,A2_REPRES,A2_REPRTEL,A2_MSBLQL*/
	FROM %table:SA2%
	WHERE A2_FILIAL = %xFilial:SA2%
	AND A2_XTERC = %exp:'S'%
	AND A2_MSBLQL <> %exp:'1'%
	AND D_E_L_E_T_ = ' '
	AND %exp:cWhereCodForn%
	AND %exp:cWhereNomForn%
	ORDER BY A2_COD,A2_LOJA
ENDSQL

DbSelectArea(cAliasSA2)
(cAliasSA2)->(DbGoTop())

If (cAliasSA2)->(Eof())
	oTemp 			:= WsClassNew("tForn")
	oTemp:FILIAL	:= ""
	oTemp:COD		:= ""
	oTemp:LOJA		:= ""
	oTemp:NOME		:= ""
	oTemp:NREDUZ	:= ""
	/*
	oTemp:ENDER		:= ""
	oTemp:NR_END	:= ""
	oTemp:COMPLEM	:= ""
	oTemp:EST		:= ""
	oTemp:COD_MUN	:= ""
	oTemp:MUN		:= ""
	oTemp:BAIRRO	:= ""
	oTemp:CEP		:= ""
	oTemp:TIPO		:= ""
	oTemp:PFISICA	:= ""
	oTemp:CGC		:= ""
	oTemp:DDD		:= ""
	oTemp:TEL		:= ""
	oTemp:FAX		:= ""
	oTemp:INSCR		:= ""
	oTemp:INSCRM	:= ""
	oTemp:TPESSOA	:= ""
	oTemp:BANCO		:= ""
	oTemp:AGENCIA	:= ""
	oTemp:NUMCON	:= ""
	oTemp:DVCTA		:= ""
	oTemp:PAIS		:= ""
	oTemp:EMAIL		:= ""
	oTemp:CODPAIS	:= ""
	oTemp:CONTA		:= ""
	oTemp:REPRES	:= ""
	oTemp:REPRTEL	:= ""
	oTemp:MSBLQL	:= ""
	*/
	aAdd(::tGetForn,oTemp)
//	SetSoapFault(ProcName(),"Nใo hแ dados para serem exibidos.")
	DbSelectArea(cAliasSA2)
	(cAliasSA2)->(DbCloseArea())
//	lRet := .F.
	Return lRet
EndIf

While !(cAliasSA2)->(Eof())
	oTemp 			:= WsClassNew("tForn")
	oTemp:FILIAL	:= (cAliasSA2)->A2_FILIAL
	oTemp:COD		:= (cAliasSA2)->A2_COD
	oTemp:LOJA		:= (cAliasSA2)->A2_LOJA
	oTemp:NOME		:= (cAliasSA2)->A2_NOME
	oTemp:NREDUZ	:= (cAliasSA2)->A2_NREDUZ
	/*
	oTemp:ENDER		:= (cAliasSA2)->A2_END
	oTemp:NR_END	:= (cAliasSA2)->A2_NR_END
	oTemp:COMPLEM	:= (cAliasSA2)->A2_COMPLEM
	oTemp:EST		:= (cAliasSA2)->A2_EST
	oTemp:COD_MUN	:= (cAliasSA2)->A2_COD_MUN
	oTemp:MUN		:= (cAliasSA2)->A2_MUN
	oTemp:BAIRRO	:= (cAliasSA2)->A2_BAIRRO
	oTemp:CEP		:= (cAliasSA2)->A2_CEP
	if (cAliasSA2)->A2_TIPO == "F"
		oTemp:TIPO	:= "Fํsico"
	elseif (cAliasSA2)->A2_TIPO == "J"
		oTemp:TIPO	:= "Jurํdico"
	elseif (cAliasSA2)->A2_TIPO == "X"
		oTemp:TIPO	:= "Outros"
	else
		oTemp:TIPO	:= ""
	endif
	oTemp:PFISICA	:= (cAliasSA2)->A2_PFISICA
	oTemp:CGC		:= (cAliasSA2)->A2_CGC
	oTemp:DDD		:= (cAliasSA2)->A2_DDD
	oTemp:TEL		:= (cAliasSA2)->A2_TEL
	oTemp:FAX		:= (cAliasSA2)->A2_FAX
	oTemp:INSCR		:= (cAliasSA2)->A2_INSCR
	oTemp:INSCRM	:= (cAliasSA2)->A2_INSCRM
	if (cAliasSA2)->A2_TPESSOA == "CI"
		oTemp:TPESSOA	:= "Com้rcio/Ind๚stria"
	elseif (cAliasSA2)->A2_TPESSOA == "PF"
		oTemp:TPESSOA	:= "Pessoa Fํsica"
	elseif (cAliasSA2)->A2_TPESSOA == "OS"
		oTemp:TPESSOA	:= "Presta็ใo de Servi็os"
	else
		oTemp:TPESSOA	:= ""
	endif
	oTemp:BANCO		:= (cAliasSA2)->A2_BANCO
	oTemp:AGENCIA	:= (cAliasSA2)->A2_AGENCIA
	oTemp:NUMCON	:= (cAliasSA2)->A2_NUMCON
	oTemp:DVCTA		:= (cAliasSA2)->A2_DVCTA
	oTemp:PAIS		:= (cAliasSA2)->A2_PAIS
	oTemp:EMAIL		:= (cAliasSA2)->A2_EMAIL
	oTemp:CODPAIS	:= (cAliasSA2)->A2_CODPAIS
	oTemp:CONTA		:= (cAliasSA2)->A2_CONTA
	oTemp:REPRES	:= (cAliasSA2)->A2_REPRES
	oTemp:REPRTEL	:= (cAliasSA2)->A2_REPRTEL
	if (cAliasSA2)->A2_MSBLQL == "1"
		oTemp:MSBLQL	:= "Sim"
	elseif (cAliasSA2)->A2_MSBLQL == "2"
		oTemp:MSBLQL	:= "Nใo"
	else
		oTemp:MSBLQL	:= ""
	endif
	*/
	aAdd(::tGetForn,oTemp)
	(cAliasSA2)->(DbSkip())
EndDo

DbSelectArea(cAliasSA2)
(cAliasSA2)->(DbCloseArea())

Return lRet

Static Function fVldUsr(cUsr,cPsw)

Local lRet := .T.
Local cErro := ""

PswOrder(2) // Seleciona a Ordem de Pesquisa do Usuแrio pelo seu Nome

If Empty(cUsr)
	cErro := "Usuแrio Nใo Informado!"
	lRet := .F.
	Return {lRet,cErro}
EndIf

if !PswSeek(cUsr) // Pesquisa o Arquivo de Senhas
	cErro := "Usuแrio Nใo Encontrado!"
	lRet := .F.
	Return {lRet,cErro}
Endif

If !PswName(cPsw) // Verifica a Senha do Usuแrio
	cErro := "Senha Invแlida!"
	lRet := .F.
	Return {lRet,cErro}
EndIf

Return {lRet,cErro}
