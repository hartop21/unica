#Include "TOTVS.ch"
#INCLUDE "apwebsrv.ch"

/* ===============================================================================
WSDL Location    http://vpsrv.visualset.com.br/?wsdl
Gerado em        08/25/20 13:28:49
Observa��es      C�digo-Fonte gerado por ADVPL WSDL Client 1.120703
Altera��es neste arquivo podem causar funcionamento incorreto
e ser�o perdidas caso o c�digo-fonte seja gerado novamente.
=============================================================================== */

User Function _RXJMKIM ; Return  // "dummy" function - Internal Use

/* -------------------------------------------------------------------------------
WSDL Service WSPostagemVipp
------------------------------------------------------------------------------- */

WSCLIENT WSPostagemVipp

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD BloquearObjetoCorreios
	WSMETHOD BloquearDownloadConhecimento
	WSMETHOD LiberarDownloadConhecimento
	WSMETHOD ListarRastreioObjeto
	WSMETHOD PostarObjeto
	WSMETHOD PostarObjetoObject
	WSMETHOD SolicitarEtiqueta

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   oWSBloquearObjetoCorreios AS PostagemVipp_BloquearObjetoCorreios
	WSDATA   oWSBloquearObjetoCorreiosResult AS PostagemVipp_BloquearObjetoCorreios
	WSDATA   oWSBloquearPostagem       AS PostagemVipp_BloquearDownload
	WSDATA   oWSBloquearDownloadConhecimentoResult AS PostagemVipp_BloquearDownload
	WSDATA   oWSLiberarPostagem        AS PostagemVipp_LiberarDownload
	WSDATA   oWSLiberarDownloadConhecimentoResult AS PostagemVipp_LiberarDownload
	WSDATA   oWSListarRastreio         AS PostagemVipp_ListarRastreio
	WSDATA   oWSListarRastreioObjetoResult AS PostagemVipp_ArrayOfObjetoRastreio
	WSDATA   oWSPostagemVipp           AS PostagemVipp_Postagem
	WSDATA   oWSPostarObjetoResult     AS SCHEMA
	WSDATA   oWSPostarObjetoObjectResult AS PostagemVipp_PostagemRetorno
	WSDATA   cNumeroCartao             AS string
	WSDATA   cUsuario                  AS string
	WSDATA   cSenha                    AS string
	WSDATA   cCodigoServico            AS string
	WSDATA   cQuantidade               AS string
	WSDATA   oWSSolicitarEtiquetaResult AS PostagemVipp_RetornoEtiquetas

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSPostagemVipp
	::Init()
	If !FindFunction("XMLCHILDEX")
		UserException("O C�digo-Fonte Client atual requer os execut�veis do Protheus Build [7.00.191205P-20200424] ou superior. Atualize o Protheus ou gere o C�digo-Fonte novamente utilizando o Build atual.")
	EndIf
	If val(right(GetWSCVer(),8)) < 1.040504
		UserException("O C�digo-Fonte Client atual requer a vers�o de Lib para WebServices igual ou superior a ADVPL WSDL Client 1.040504. Atualize o reposit�rio ou gere o C�digo-Fonte novamente utilizando o reposit�rio atual.")
	EndIf
Return Self

WSMETHOD INIT WSCLIENT WSPostagemVipp
	::oWSBloquearObjetoCorreios := PostagemVipp_BLOQUEAROBJETOCORREIOS():New()
	::oWSBloquearObjetoCorreiosResult := PostagemVipp_BLOQUEAROBJETOCORREIOS():New()
	::oWSBloquearPostagem := PostagemVipp_BLOQUEARDOWNLOAD():New()
	::oWSBloquearDownloadConhecimentoResult := PostagemVipp_BLOQUEARDOWNLOAD():New()
	::oWSLiberarPostagem := PostagemVipp_LIBERARDOWNLOAD():New()
	::oWSLiberarDownloadConhecimentoResult := PostagemVipp_LIBERARDOWNLOAD():New()
	::oWSListarRastreio  := PostagemVipp_LISTARRASTREIO():New()
	::oWSListarRastreioObjetoResult := PostagemVipp_ARRAYOFOBJETORASTREIO():New()
	::oWSPostagemVipp    := PostagemVipp_POSTAGEM():New()
	::oWSPostarObjetoResult := NIL
	::oWSPostarObjetoObjectResult := PostagemVipp_POSTAGEMRETORNO():New()
	::oWSSolicitarEtiquetaResult := PostagemVipp_RETORNOETIQUETAS():New()
Return

WSMETHOD RESET WSCLIENT WSPostagemVipp
	::oWSBloquearObjetoCorreios := NIL
	::oWSBloquearObjetoCorreiosResult := NIL
	::oWSBloquearPostagem := NIL
	::oWSBloquearDownloadConhecimentoResult := NIL
	::oWSLiberarPostagem := NIL
	::oWSLiberarDownloadConhecimentoResult := NIL
	::oWSListarRastreio  := NIL
	::oWSListarRastreioObjetoResult := NIL
	::oWSPostagemVipp    := NIL
	::oWSPostarObjetoResult := NIL
	::oWSPostarObjetoObjectResult := NIL
	::cNumeroCartao      := NIL
	::cUsuario           := NIL
	::cSenha             := NIL
	::cCodigoServico     := NIL
	::cQuantidade        := NIL
	::oWSSolicitarEtiquetaResult := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSPostagemVipp
	Local oClone := WSPostagemVipp():New()
	oClone:_URL          := ::_URL
	oClone:oWSBloquearObjetoCorreios :=  IIF(::oWSBloquearObjetoCorreios = NIL , NIL ,::oWSBloquearObjetoCorreios:Clone() )
	oClone:oWSBloquearObjetoCorreiosResult :=  IIF(::oWSBloquearObjetoCorreiosResult = NIL , NIL ,::oWSBloquearObjetoCorreiosResult:Clone() )
	oClone:oWSBloquearPostagem :=  IIF(::oWSBloquearPostagem = NIL , NIL ,::oWSBloquearPostagem:Clone() )
	oClone:oWSBloquearDownloadConhecimentoResult :=  IIF(::oWSBloquearDownloadConhecimentoResult = NIL , NIL ,::oWSBloquearDownloadConhecimentoResult:Clone() )
	oClone:oWSLiberarPostagem :=  IIF(::oWSLiberarPostagem = NIL , NIL ,::oWSLiberarPostagem:Clone() )
	oClone:oWSLiberarDownloadConhecimentoResult :=  IIF(::oWSLiberarDownloadConhecimentoResult = NIL , NIL ,::oWSLiberarDownloadConhecimentoResult:Clone() )
	oClone:oWSListarRastreio :=  IIF(::oWSListarRastreio = NIL , NIL ,::oWSListarRastreio:Clone() )
	oClone:oWSListarRastreioObjetoResult :=  IIF(::oWSListarRastreioObjetoResult = NIL , NIL ,::oWSListarRastreioObjetoResult:Clone() )
	oClone:oWSPostagemVipp :=  IIF(::oWSPostagemVipp = NIL , NIL ,::oWSPostagemVipp:Clone() )
	oClone:oWSPostarObjetoObjectResult :=  IIF(::oWSPostarObjetoObjectResult = NIL , NIL ,::oWSPostarObjetoObjectResult:Clone() )
	oClone:cNumeroCartao := ::cNumeroCartao
	oClone:cUsuario      := ::cUsuario
	oClone:cSenha        := ::cSenha
	oClone:cCodigoServico := ::cCodigoServico
	oClone:cQuantidade   := ::cQuantidade
	oClone:oWSSolicitarEtiquetaResult :=  IIF(::oWSSolicitarEtiquetaResult = NIL , NIL ,::oWSSolicitarEtiquetaResult:Clone() )
Return oClone

// WSDL Method BloquearObjetoCorreios of Service WSPostagemVipp

WSMETHOD BloquearObjetoCorreios WSSEND oWSBloquearObjetoCorreios WSRECEIVE oWSBloquearObjetoCorreiosResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<BloquearObjetoCorreios xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("BloquearObjetoCorreios", ::oWSBloquearObjetoCorreios, oWSBloquearObjetoCorreios , "BloquearObjetoCorreios", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</BloquearObjetoCorreios>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/BloquearObjetoCorreios",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSBloquearObjetoCorreiosResult:SoapRecv( WSAdvValue( oXmlRet,"_BLOQUEAROBJETOCORREIOSRESPONSE:_BLOQUEAROBJETOCORREIOSRESULT","BloquearObjetoCorreios",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method BloquearDownloadConhecimento of Service WSPostagemVipp

WSMETHOD BloquearDownloadConhecimento WSSEND oWSBloquearPostagem WSRECEIVE oWSBloquearDownloadConhecimentoResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<BloquearDownloadConhecimento xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("BloquearPostagem", ::oWSBloquearPostagem, oWSBloquearPostagem , "BloquearDownload", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</BloquearDownloadConhecimento>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/BloquearDownloadConhecimento",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSBloquearDownloadConhecimentoResult:SoapRecv( WSAdvValue( oXmlRet,"_BLOQUEARDOWNLOADCONHECIMENTORESPONSE:_BLOQUEARDOWNLOADCONHECIMENTORESULT","BloquearDownload",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method LiberarDownloadConhecimento of Service WSPostagemVipp

WSMETHOD LiberarDownloadConhecimento WSSEND oWSLiberarPostagem WSRECEIVE oWSLiberarDownloadConhecimentoResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<LiberarDownloadConhecimento xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("LiberarPostagem", ::oWSLiberarPostagem, oWSLiberarPostagem , "LiberarDownload", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</LiberarDownloadConhecimento>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/LiberarDownloadConhecimento",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSLiberarDownloadConhecimentoResult:SoapRecv( WSAdvValue( oXmlRet,"_LIBERARDOWNLOADCONHECIMENTORESPONSE:_LIBERARDOWNLOADCONHECIMENTORESULT","LiberarDownload",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method ListarRastreioObjeto of Service WSPostagemVipp

WSMETHOD ListarRastreioObjeto WSSEND oWSListarRastreio WSRECEIVE oWSListarRastreioObjetoResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<ListarRastreioObjeto xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("ListarRastreio", ::oWSListarRastreio, oWSListarRastreio , "ListarRastreio", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</ListarRastreioObjeto>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/ListarRastreioObjeto",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSListarRastreioObjetoResult:SoapRecv( WSAdvValue( oXmlRet,"_LISTARRASTREIOOBJETORESPONSE:_LISTARRASTREIOOBJETORESULT","ArrayOfObjetoRastreio",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method PostarObjeto of Service WSPostagemVipp

WSMETHOD PostarObjeto WSSEND oWSPostagemVipp WSRECEIVE oWSPostarObjetoResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<PostarObjeto xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("PostagemVipp", ::oWSPostagemVipp, oWSPostagemVipp , "Postagem", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</PostarObjeto>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/PostarObjeto",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSPostarObjetoResult :=  WSAdvValue( oXmlRet,"_POSTAROBJETORESPONSE","SCHEMA",NIL,NIL,NIL,"O",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method PostarObjetoObject of Service WSPostagemVipp

WSMETHOD PostarObjetoObject WSSEND oWSPostagemVipp WSRECEIVE oWSPostarObjetoObjectResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<PostarObjetoObject xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("PostagemVipp", ::oWSPostagemVipp, oWSPostagemVipp , "Postagem", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</PostarObjetoObject>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/PostarObjetoObject",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSPostarObjetoObjectResult:SoapRecv( WSAdvValue( oXmlRet,"_POSTAROBJETOOBJECTRESPONSE:_POSTAROBJETOOBJECTRESULT","PostagemRetorno",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method SolicitarEtiqueta of Service WSPostagemVipp

WSMETHOD SolicitarEtiqueta WSSEND cNumeroCartao,cUsuario,cSenha,cCodigoServico,cQuantidade WSRECEIVE oWSSolicitarEtiquetaResult WSCLIENT WSPostagemVipp
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<SolicitarEtiqueta xmlns="http://www.visualset.inf.br/">'
	cSoap += WSSoapValue("NumeroCartao", ::cNumeroCartao, cNumeroCartao , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Usuario", ::cUsuario, cUsuario , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Senha", ::cSenha, cSenha , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CodigoServico", ::cCodigoServico, cCodigoServico , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Quantidade", ::cQuantidade, cQuantidade , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</SolicitarEtiqueta>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"http://www.visualset.inf.br/SolicitarEtiqueta",;
	"DOCUMENT","http://www.visualset.inf.br/",,,;
	"http://vpsrv.visualset.com.br/PostagemVipp.asmx")

	::Init()
	::oWSSolicitarEtiquetaResult:SoapRecv( WSAdvValue( oXmlRet,"_SOLICITARETIQUETARESPONSE:_SOLICITARETIQUETARESULT","RetornoEtiquetas",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.


// WSDL Data Structure BloquearObjetoCorreios

WSSTRUCT PostagemVipp_BloquearObjetoCorreios
	WSDATA   oWSPerfilVipp             AS PostagemVipp_PerfilVipp OPTIONAL
	WSDATA   cEtiqueta                 AS string OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_BloquearObjetoCorreios
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_BloquearObjetoCorreios
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_BloquearObjetoCorreios
	Local oClone := PostagemVipp_BloquearObjetoCorreios():NEW()
	oClone:oWSPerfilVipp        := IIF(::oWSPerfilVipp = NIL , NIL , ::oWSPerfilVipp:Clone() )
	oClone:cEtiqueta            := ::cEtiqueta
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_BloquearObjetoCorreios
	Local cSoap := ""
	cSoap += WSSoapValue("PerfilVipp", ::oWSPerfilVipp, ::oWSPerfilVipp , "PerfilVipp", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Etiqueta", ::cEtiqueta, ::cEtiqueta , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ListaErros", ::oWSListaErros, ::oWSListaErros , "ArrayOfErro", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_BloquearObjetoCorreios
	Local oNode1
	Local oNode3
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_PERFILVIPP","PerfilVipp",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSPerfilVipp := PostagemVipp_PerfilVipp():New()
		::oWSPerfilVipp:SoapRecv(oNode1)
	EndIf
	::cEtiqueta          :=  WSAdvValue( oResponse,"_ETIQUETA","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode3 :=  WSAdvValue( oResponse,"_LISTAERROS","ArrayOfErro",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWSListaErros := PostagemVipp_ArrayOfErro():New()
		::oWSListaErros:SoapRecv(oNode3)
	EndIf
Return

// WSDL Data Structure BloquearDownload

WSSTRUCT PostagemVipp_BloquearDownload
	WSDATA   oWSPerfilVipp             AS PostagemVipp_PerfilVipp OPTIONAL
	WSDATA   cEtiqueta                 AS string OPTIONAL
	WSDATA   nStBloqueado              AS short
	WSDATA   cDescricao                AS string OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_BloquearDownload
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_BloquearDownload
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_BloquearDownload
	Local oClone := PostagemVipp_BloquearDownload():NEW()
	oClone:oWSPerfilVipp        := IIF(::oWSPerfilVipp = NIL , NIL , ::oWSPerfilVipp:Clone() )
	oClone:cEtiqueta            := ::cEtiqueta
	oClone:nStBloqueado         := ::nStBloqueado
	oClone:cDescricao           := ::cDescricao
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_BloquearDownload
	Local cSoap := ""
	cSoap += WSSoapValue("PerfilVipp", ::oWSPerfilVipp, ::oWSPerfilVipp , "PerfilVipp", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Etiqueta", ::cEtiqueta, ::cEtiqueta , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("StBloqueado", ::nStBloqueado, ::nStBloqueado , "short", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Descricao", ::cDescricao, ::cDescricao , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ListaErros", ::oWSListaErros, ::oWSListaErros , "ArrayOfErro", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_BloquearDownload
	Local oNode1
	Local oNode5
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_PERFILVIPP","PerfilVipp",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSPerfilVipp := PostagemVipp_PerfilVipp():New()
		::oWSPerfilVipp:SoapRecv(oNode1)
	EndIf
	::cEtiqueta          :=  WSAdvValue( oResponse,"_ETIQUETA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nStBloqueado       :=  WSAdvValue( oResponse,"_STBLOQUEADO","short",NIL,"Property nStBloqueado as s:short on SOAP Response not found.",NIL,"N",NIL,NIL)
	::cDescricao         :=  WSAdvValue( oResponse,"_DESCRICAO","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode5 :=  WSAdvValue( oResponse,"_LISTAERROS","ArrayOfErro",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode5 != NIL
		::oWSListaErros := PostagemVipp_ArrayOfErro():New()
		::oWSListaErros:SoapRecv(oNode5)
	EndIf
Return

// WSDL Data Structure LiberarDownload

WSSTRUCT PostagemVipp_LiberarDownload
	WSDATA   oWSPerfilVipp             AS PostagemVipp_PerfilVipp OPTIONAL
	WSDATA   cEtiqueta                 AS string OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSDATA   nStLiberado               AS short
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_LiberarDownload
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_LiberarDownload
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_LiberarDownload
	Local oClone := PostagemVipp_LiberarDownload():NEW()
	oClone:oWSPerfilVipp        := IIF(::oWSPerfilVipp = NIL , NIL , ::oWSPerfilVipp:Clone() )
	oClone:cEtiqueta            := ::cEtiqueta
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
	oClone:nStLiberado          := ::nStLiberado
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_LiberarDownload
	Local cSoap := ""
	cSoap += WSSoapValue("PerfilVipp", ::oWSPerfilVipp, ::oWSPerfilVipp , "PerfilVipp", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Etiqueta", ::cEtiqueta, ::cEtiqueta , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ListaErros", ::oWSListaErros, ::oWSListaErros , "ArrayOfErro", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("StLiberado", ::nStLiberado, ::nStLiberado , "short", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_LiberarDownload
	Local oNode1
	Local oNode3
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_PERFILVIPP","PerfilVipp",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSPerfilVipp := PostagemVipp_PerfilVipp():New()
		::oWSPerfilVipp:SoapRecv(oNode1)
	EndIf
	::cEtiqueta          :=  WSAdvValue( oResponse,"_ETIQUETA","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode3 :=  WSAdvValue( oResponse,"_LISTAERROS","ArrayOfErro",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWSListaErros := PostagemVipp_ArrayOfErro():New()
		::oWSListaErros:SoapRecv(oNode3)
	EndIf
	::nStLiberado        :=  WSAdvValue( oResponse,"_STLIBERADO","short",NIL,"Property nStLiberado as s:short on SOAP Response not found.",NIL,"N",NIL,NIL)
Return

// WSDL Data Structure ListarRastreio

WSSTRUCT PostagemVipp_ListarRastreio
	WSDATA   oWSPerfilVipp             AS PostagemVipp_PerfilVipp OPTIONAL
	WSDATA   cNrEtiquetaPostagem       AS string OPTIONAL
	WSDATA   cIdConhecimento           AS string OPTIONAL
	WSDATA   cObservacaoUm             AS string OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ListarRastreio
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ListarRastreio
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ListarRastreio
	Local oClone := PostagemVipp_ListarRastreio():NEW()
	oClone:oWSPerfilVipp        := IIF(::oWSPerfilVipp = NIL , NIL , ::oWSPerfilVipp:Clone() )
	oClone:cNrEtiquetaPostagem  := ::cNrEtiquetaPostagem
	oClone:cIdConhecimento      := ::cIdConhecimento
	oClone:cObservacaoUm        := ::cObservacaoUm
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ListarRastreio
	Local cSoap := ""
	cSoap += WSSoapValue("PerfilVipp", ::oWSPerfilVipp, ::oWSPerfilVipp , "PerfilVipp", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("NrEtiquetaPostagem", ::cNrEtiquetaPostagem, ::cNrEtiquetaPostagem , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("IdConhecimento", ::cIdConhecimento, ::cIdConhecimento , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ObservacaoUm", ::cObservacaoUm, ::cObservacaoUm , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ListaErros", ::oWSListaErros, ::oWSListaErros , "ArrayOfErro", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ArrayOfObjetoRastreio

WSSTRUCT PostagemVipp_ArrayOfObjetoRastreio
	WSDATA   oWSObjetoRastreio         AS PostagemVipp_ObjetoRastreio OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfObjetoRastreio
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfObjetoRastreio
	::oWSObjetoRastreio    := {} // Array Of  PostagemVipp_OBJETORASTREIO():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfObjetoRastreio
	Local oClone := PostagemVipp_ArrayOfObjetoRastreio():NEW()
	oClone:oWSObjetoRastreio := NIL
	If ::oWSObjetoRastreio <> NIL
		oClone:oWSObjetoRastreio := {}
		aEval( ::oWSObjetoRastreio , { |x| aadd( oClone:oWSObjetoRastreio , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfObjetoRastreio
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OBJETORASTREIO","ObjetoRastreio",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSObjetoRastreio , PostagemVipp_ObjetoRastreio():New() )
			::oWSObjetoRastreio[len(::oWSObjetoRastreio)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure Postagem

WSSTRUCT PostagemVipp_Postagem
	WSDATA   oWSPerfilVipp             AS PostagemVipp_PerfilVipp OPTIONAL
	WSDATA   oWSContratoEct            AS PostagemVipp_ContratoEct OPTIONAL
	WSDATA   oWSDestinatario           AS PostagemVipp_Destinatario OPTIONAL
	WSDATA   oWSServico                AS PostagemVipp_Servico OPTIONAL
	WSDATA   oWSNotasFiscais           AS PostagemVipp_ArrayOfNotaFiscal OPTIONAL
	WSDATA   oWSVolumes                AS PostagemVipp_ArrayOfVolumeObjeto OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_Postagem
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_Postagem
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_Postagem
	Local oClone := PostagemVipp_Postagem():NEW()
	oClone:oWSPerfilVipp        := IIF(::oWSPerfilVipp = NIL , NIL , ::oWSPerfilVipp:Clone() )
	oClone:oWSContratoEct       := IIF(::oWSContratoEct = NIL , NIL , ::oWSContratoEct:Clone() )
	oClone:oWSDestinatario      := IIF(::oWSDestinatario = NIL , NIL , ::oWSDestinatario:Clone() )
	oClone:oWSServico           := IIF(::oWSServico = NIL , NIL , ::oWSServico:Clone() )
	oClone:oWSNotasFiscais      := IIF(::oWSNotasFiscais = NIL , NIL , ::oWSNotasFiscais:Clone() )
	oClone:oWSVolumes           := IIF(::oWSVolumes = NIL , NIL , ::oWSVolumes:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_Postagem
	Local cSoap := ""
	cSoap += WSSoapValue("PerfilVipp", ::oWSPerfilVipp, ::oWSPerfilVipp , "PerfilVipp", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ContratoEct", ::oWSContratoEct, ::oWSContratoEct , "ContratoEct", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Destinatario", ::oWSDestinatario, ::oWSDestinatario , "Destinatario", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Servico", ::oWSServico, ::oWSServico , "Servico", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("NotasFiscais", ::oWSNotasFiscais, ::oWSNotasFiscais , "ArrayOfNotaFiscal", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Volumes", ::oWSVolumes, ::oWSVolumes , "ArrayOfVolumeObjeto", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure PostagemRetorno

WSSTRUCT PostagemVipp_PostagemRetorno
	WSDATA   oWSPerfilVipp             AS PostagemVipp_PerfilVipp OPTIONAL
	WSDATA   oWSContratoEct            AS PostagemVipp_ContratoEct OPTIONAL
	WSDATA   oWSDestinatario           AS PostagemVipp_Destinatario OPTIONAL
	WSDATA   oWSServico                AS PostagemVipp_Servico OPTIONAL
	WSDATA   oWSNotasFiscais           AS PostagemVipp_ArrayOfNotaFiscal OPTIONAL
	WSDATA   oWSVolumes                AS PostagemVipp_ArrayOfVolumeObjeto OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSDATA   oWSStPostagem             AS PostagemVipp_StSolicitacao
	WSDATA   nIdStatusPostagem         AS int
	WSDATA   cStatusPostagem           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_PostagemRetorno
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_PostagemRetorno
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_PostagemRetorno
	Local oClone := PostagemVipp_PostagemRetorno():NEW()
	oClone:oWSPerfilVipp        := IIF(::oWSPerfilVipp = NIL , NIL , ::oWSPerfilVipp:Clone() )
	oClone:oWSContratoEct       := IIF(::oWSContratoEct = NIL , NIL , ::oWSContratoEct:Clone() )
	oClone:oWSDestinatario      := IIF(::oWSDestinatario = NIL , NIL , ::oWSDestinatario:Clone() )
	oClone:oWSServico           := IIF(::oWSServico = NIL , NIL , ::oWSServico:Clone() )
	oClone:oWSNotasFiscais      := IIF(::oWSNotasFiscais = NIL , NIL , ::oWSNotasFiscais:Clone() )
	oClone:oWSVolumes           := IIF(::oWSVolumes = NIL , NIL , ::oWSVolumes:Clone() )
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
	oClone:oWSStPostagem        := IIF(::oWSStPostagem = NIL , NIL , ::oWSStPostagem:Clone() )
	oClone:nIdStatusPostagem    := ::nIdStatusPostagem
	oClone:cStatusPostagem      := ::cStatusPostagem
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_PostagemRetorno
	Local oNode1
	Local oNode2
	Local oNode3
	Local oNode4
	Local oNode5
	Local oNode6
	Local oNode7
	Local oNode8
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_PERFILVIPP","PerfilVipp",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSPerfilVipp := PostagemVipp_PerfilVipp():New()
		::oWSPerfilVipp:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_CONTRATOECT","ContratoEct",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode2 != NIL
		::oWSContratoEct := PostagemVipp_ContratoEct():New()
		::oWSContratoEct:SoapRecv(oNode2)
	EndIf
	oNode3 :=  WSAdvValue( oResponse,"_DESTINATARIO","Destinatario",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWSDestinatario := PostagemVipp_Destinatario():New()
		::oWSDestinatario:SoapRecv(oNode3)
	EndIf
	oNode4 :=  WSAdvValue( oResponse,"_SERVICO","Servico",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSServico := PostagemVipp_Servico():New()
		::oWSServico:SoapRecv(oNode4)
	EndIf
	oNode5 :=  WSAdvValue( oResponse,"_NOTASFISCAIS","ArrayOfNotaFiscal",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode5 != NIL
		::oWSNotasFiscais := PostagemVipp_ArrayOfNotaFiscal():New()
		::oWSNotasFiscais:SoapRecv(oNode5)
	EndIf
	oNode6 :=  WSAdvValue( oResponse,"_VOLUMES","ArrayOfVolumeObjeto",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode6 != NIL
		::oWSVolumes := PostagemVipp_ArrayOfVolumeObjeto():New()
		::oWSVolumes:SoapRecv(oNode6)
	EndIf
	oNode7 :=  WSAdvValue( oResponse,"_LISTAERROS","ArrayOfErro",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode7 != NIL
		::oWSListaErros := PostagemVipp_ArrayOfErro():New()
		::oWSListaErros:SoapRecv(oNode7)
	EndIf
	oNode8 :=  WSAdvValue( oResponse,"_STPOSTAGEM","StSolicitacao",NIL,"Property oWSStPostagem as tns:StSolicitacao on SOAP Response not found.",NIL,"O",NIL,NIL)
	If oNode8 != NIL
		::oWSStPostagem := PostagemVipp_StSolicitacao():New()
		::oWSStPostagem:SoapRecv(oNode8)
	EndIf
	::nIdStatusPostagem  :=  WSAdvValue( oResponse,"_IDSTATUSPOSTAGEM","int",NIL,"Property nIdStatusPostagem as s:int on SOAP Response not found.",NIL,"N",NIL,NIL)
	::cStatusPostagem    :=  WSAdvValue( oResponse,"_STATUSPOSTAGEM","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure RetornoEtiquetas

WSSTRUCT PostagemVipp_RetornoEtiquetas
	WSDATA   oWSEtiquetas              AS PostagemVipp_ArrayOfEtiquetaPostagem OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSDATA   oWSStSolicitacao          AS PostagemVipp_StSolicitacao
	WSDATA   cStatusSolicitacao        AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_RetornoEtiquetas
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_RetornoEtiquetas
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_RetornoEtiquetas
	Local oClone := PostagemVipp_RetornoEtiquetas():NEW()
	oClone:oWSEtiquetas         := IIF(::oWSEtiquetas = NIL , NIL , ::oWSEtiquetas:Clone() )
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
	oClone:oWSStSolicitacao     := IIF(::oWSStSolicitacao = NIL , NIL , ::oWSStSolicitacao:Clone() )
	oClone:cStatusSolicitacao   := ::cStatusSolicitacao
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_RetornoEtiquetas
	Local oNode1
	Local oNode2
	Local oNode3
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_ETIQUETAS","ArrayOfEtiquetaPostagem",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSEtiquetas := PostagemVipp_ArrayOfEtiquetaPostagem():New()
		::oWSEtiquetas:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_LISTAERROS","ArrayOfErro",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode2 != NIL
		::oWSListaErros := PostagemVipp_ArrayOfErro():New()
		::oWSListaErros:SoapRecv(oNode2)
	EndIf
	oNode3 :=  WSAdvValue( oResponse,"_STSOLICITACAO","StSolicitacao",NIL,"Property oWSStSolicitacao as tns:StSolicitacao on SOAP Response not found.",NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWSStSolicitacao := PostagemVipp_StSolicitacao():New()
		::oWSStSolicitacao:SoapRecv(oNode3)
	EndIf
	::cStatusSolicitacao :=  WSAdvValue( oResponse,"_STATUSSOLICITACAO","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure PerfilVipp

WSSTRUCT PostagemVipp_PerfilVipp
	WSDATA   cUsuario                  AS string OPTIONAL
	WSDATA   cToken                    AS string OPTIONAL
	WSDATA   cIdPerfil                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_PerfilVipp
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_PerfilVipp
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_PerfilVipp
	Local oClone := PostagemVipp_PerfilVipp():NEW()
	oClone:cUsuario             := ::cUsuario
	oClone:cToken               := ::cToken
	oClone:cIdPerfil            := ::cIdPerfil
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_PerfilVipp
	Local cSoap := ""
	cSoap += WSSoapValue("Usuario", ::cUsuario, ::cUsuario , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Token", ::cToken, ::cToken , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("IdPerfil", ::cIdPerfil, ::cIdPerfil , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_PerfilVipp
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cUsuario           :=  WSAdvValue( oResponse,"_USUARIO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cToken             :=  WSAdvValue( oResponse,"_TOKEN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cIdPerfil          :=  WSAdvValue( oResponse,"_IDPERFIL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure ArrayOfErro

WSSTRUCT PostagemVipp_ArrayOfErro
	WSDATA   oWSErro                   AS PostagemVipp_Erro OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfErro
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfErro
	::oWSErro              := {} // Array Of  PostagemVipp_ERRO():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfErro
	Local oClone := PostagemVipp_ArrayOfErro():NEW()
	oClone:oWSErro := NIL
	If ::oWSErro <> NIL
		oClone:oWSErro := {}
		aEval( ::oWSErro , { |x| aadd( oClone:oWSErro , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ArrayOfErro
	Local cSoap := ""
	aEval( ::oWSErro , {|x| cSoap := cSoap  +  WSSoapValue("Erro", x , x , "Erro", .F. , .F., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfErro
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_ERRO","Erro",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSErro , PostagemVipp_Erro():New() )
			::oWSErro[len(::oWSErro)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ObjetoRastreio

WSSTRUCT PostagemVipp_ObjetoRastreio
	WSDATA   nIdConhecimento           AS long OPTIONAL
	WSDATA   cEtiquetaPostagem         AS string OPTIONAL
	WSDATA   cDtPostagem               AS dateTime OPTIONAL
	WSDATA   nIdUltimoStatus           AS long OPTIONAL
	WSDATA   nIdGrupoStatusEvento      AS int OPTIONAL
	WSDATA   cNomeGrupoStatusEvento    AS string OPTIONAL
	WSDATA   nIdStatusEntrega          AS long OPTIONAL
	WSDATA   nStPI                     AS short OPTIONAL
	WSDATA   nIdAoRemetente            AS long OPTIONAL
	WSDATA   nStConhecimento           AS int OPTIONAL
	WSDATA   oWSEventoRastreio         AS PostagemVipp_ArrayOfEventoRastreio OPTIONAL
	WSDATA   cStatusSolicitacao        AS string OPTIONAL
	WSDATA   oWSListaErros             AS PostagemVipp_ArrayOfErro OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ObjetoRastreio
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ObjetoRastreio
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ObjetoRastreio
	Local oClone := PostagemVipp_ObjetoRastreio():NEW()
	oClone:nIdConhecimento      := ::nIdConhecimento
	oClone:cEtiquetaPostagem    := ::cEtiquetaPostagem
	oClone:cDtPostagem          := ::cDtPostagem
	oClone:nIdUltimoStatus      := ::nIdUltimoStatus
	oClone:nIdGrupoStatusEvento := ::nIdGrupoStatusEvento
	oClone:cNomeGrupoStatusEvento := ::cNomeGrupoStatusEvento
	oClone:nIdStatusEntrega     := ::nIdStatusEntrega
	oClone:nStPI                := ::nStPI
	oClone:nIdAoRemetente       := ::nIdAoRemetente
	oClone:nStConhecimento      := ::nStConhecimento
	oClone:oWSEventoRastreio    := IIF(::oWSEventoRastreio = NIL , NIL , ::oWSEventoRastreio:Clone() )
	oClone:cStatusSolicitacao   := ::cStatusSolicitacao
	oClone:oWSListaErros        := IIF(::oWSListaErros = NIL , NIL , ::oWSListaErros:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ObjetoRastreio
	Local oNode11
	Local oNode13
	::Init()
	If oResponse = NIL ; Return ; Endif
	::nIdConhecimento    :=  WSAdvValue( oResponse,"_IDCONHECIMENTO","long",NIL,NIL,NIL,"N",NIL,NIL)
	::cEtiquetaPostagem  :=  WSAdvValue( oResponse,"_ETIQUETAPOSTAGEM","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cDtPostagem        :=  WSAdvValue( oResponse,"_DTPOSTAGEM","dateTime",NIL,NIL,NIL,"S",NIL,NIL)
	::nIdUltimoStatus    :=  WSAdvValue( oResponse,"_IDULTIMOSTATUS","long",NIL,NIL,NIL,"N",NIL,NIL)
	::nIdGrupoStatusEvento :=  WSAdvValue( oResponse,"_IDGRUPOSTATUSEVENTO","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cNomeGrupoStatusEvento :=  WSAdvValue( oResponse,"_NOMEGRUPOSTATUSEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nIdStatusEntrega   :=  WSAdvValue( oResponse,"_IDSTATUSENTREGA","long",NIL,NIL,NIL,"N",NIL,NIL)
	::nStPI              :=  WSAdvValue( oResponse,"_STPI","short",NIL,NIL,NIL,"N",NIL,NIL)
	::nIdAoRemetente     :=  WSAdvValue( oResponse,"_IDAOREMETENTE","long",NIL,NIL,NIL,"N",NIL,NIL)
	::nStConhecimento    :=  WSAdvValue( oResponse,"_STCONHECIMENTO","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode11 :=  WSAdvValue( oResponse,"_EVENTORASTREIO","ArrayOfEventoRastreio",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode11 != NIL
		::oWSEventoRastreio := PostagemVipp_ArrayOfEventoRastreio():New()
		::oWSEventoRastreio:SoapRecv(oNode11)
	EndIf
	::cStatusSolicitacao :=  WSAdvValue( oResponse,"_STATUSSOLICITACAO","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode13 :=  WSAdvValue( oResponse,"_LISTAERROS","ArrayOfErro",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode13 != NIL
		::oWSListaErros := PostagemVipp_ArrayOfErro():New()
		::oWSListaErros:SoapRecv(oNode13)
	EndIf
Return

// WSDL Data Structure ContratoEct

WSSTRUCT PostagemVipp_ContratoEct
	WSDATA   cNrContrato               AS string OPTIONAL
	WSDATA   cCodigoAdministrativo     AS string OPTIONAL
	WSDATA   cNrCartao                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ContratoEct
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ContratoEct
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ContratoEct
	Local oClone := PostagemVipp_ContratoEct():NEW()
	oClone:cNrContrato          := ::cNrContrato
	oClone:cCodigoAdministrativo := ::cCodigoAdministrativo
	oClone:cNrCartao            := ::cNrCartao
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ContratoEct
	Local cSoap := ""
	cSoap += WSSoapValue("NrContrato", ::cNrContrato, ::cNrContrato , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CodigoAdministrativo", ::cCodigoAdministrativo, ::cCodigoAdministrativo , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("NrCartao", ::cNrCartao, ::cNrCartao , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ContratoEct
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cNrContrato        :=  WSAdvValue( oResponse,"_NRCONTRATO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCodigoAdministrativo :=  WSAdvValue( oResponse,"_CODIGOADMINISTRATIVO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cNrCartao          :=  WSAdvValue( oResponse,"_NRCARTAO","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure Destinatario

WSSTRUCT PostagemVipp_Destinatario
	WSDATA   cCnpjCpf                  AS string OPTIONAL
	WSDATA   cIeRg                     AS string OPTIONAL
	WSDATA   cNome                     AS string OPTIONAL
	WSDATA   cSegundaLinhaDestinatario AS string OPTIONAL
	WSDATA   cEndereco                 AS string OPTIONAL
	WSDATA   cEntregaNoVizinho         AS string OPTIONAL
	WSDATA   cNumero                   AS string OPTIONAL
	WSDATA   cComplemento              AS string OPTIONAL
	WSDATA   cBairro                   AS string OPTIONAL
	WSDATA   cCidade                   AS string OPTIONAL
	WSDATA   cUF                       AS string OPTIONAL
	WSDATA   cCep                      AS string OPTIONAL
	WSDATA   cTelefone                 AS string OPTIONAL
	WSDATA   cCelular                  AS string OPTIONAL
	WSDATA   cEmail                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_Destinatario
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_Destinatario
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_Destinatario
	Local oClone := PostagemVipp_Destinatario():NEW()
	oClone:cCnpjCpf             := ::cCnpjCpf
	oClone:cIeRg                := ::cIeRg
	oClone:cNome                := ::cNome
	oClone:cSegundaLinhaDestinatario := ::cSegundaLinhaDestinatario
	oClone:cEndereco            := ::cEndereco
	oClone:cEntregaNoVizinho    := ::cEntregaNoVizinho
	oClone:cNumero              := ::cNumero
	oClone:cComplemento         := ::cComplemento
	oClone:cBairro              := ::cBairro
	oClone:cCidade              := ::cCidade
	oClone:cUF                  := ::cUF
	oClone:cCep                 := ::cCep
	oClone:cTelefone            := ::cTelefone
	oClone:cCelular             := ::cCelular
	oClone:cEmail               := ::cEmail
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_Destinatario
	Local cSoap := ""
	cSoap += WSSoapValue("CnpjCpf", ::cCnpjCpf, ::cCnpjCpf , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("IeRg", ::cIeRg, ::cIeRg , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Nome", ::cNome, ::cNome , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("SegundaLinhaDestinatario", ::cSegundaLinhaDestinatario, ::cSegundaLinhaDestinatario , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Endereco", ::cEndereco, ::cEndereco , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("EntregaNoVizinho", ::cEntregaNoVizinho, ::cEntregaNoVizinho , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Numero", ::cNumero, ::cNumero , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Complemento", ::cComplemento, ::cComplemento , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Bairro", ::cBairro, ::cBairro , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Cidade", ::cCidade, ::cCidade , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("UF", ::cUF, ::cUF , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Cep", ::cCep, ::cCep , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Telefone", ::cTelefone, ::cTelefone , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Celular", ::cCelular, ::cCelular , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Email", ::cEmail, ::cEmail , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_Destinatario
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCnpjCpf           :=  WSAdvValue( oResponse,"_CNPJCPF","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cIeRg              :=  WSAdvValue( oResponse,"_IERG","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cNome              :=  WSAdvValue( oResponse,"_NOME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cSegundaLinhaDestinatario :=  WSAdvValue( oResponse,"_SEGUNDALINHADESTINATARIO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cEndereco          :=  WSAdvValue( oResponse,"_ENDERECO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cEntregaNoVizinho  :=  WSAdvValue( oResponse,"_ENTREGANOVIZINHO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cNumero            :=  WSAdvValue( oResponse,"_NUMERO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cComplemento       :=  WSAdvValue( oResponse,"_COMPLEMENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cBairro            :=  WSAdvValue( oResponse,"_BAIRRO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCidade            :=  WSAdvValue( oResponse,"_CIDADE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cUF                :=  WSAdvValue( oResponse,"_UF","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCep               :=  WSAdvValue( oResponse,"_CEP","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cTelefone          :=  WSAdvValue( oResponse,"_TELEFONE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCelular           :=  WSAdvValue( oResponse,"_CELULAR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cEmail             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure Servico

WSSTRUCT PostagemVipp_Servico
	WSDATA   cServicoECT               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_Servico
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_Servico
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_Servico
	Local oClone := PostagemVipp_Servico():NEW()
	oClone:cServicoECT          := ::cServicoECT
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_Servico
	Local cSoap := ""
	cSoap += WSSoapValue("ServicoECT", ::cServicoECT, ::cServicoECT , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_Servico
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cServicoECT        :=  WSAdvValue( oResponse,"_SERVICOECT","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure ArrayOfNotaFiscal

WSSTRUCT PostagemVipp_ArrayOfNotaFiscal
	WSDATA   oWSNotaFiscal             AS PostagemVipp_NotaFiscal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfNotaFiscal
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfNotaFiscal
	::oWSNotaFiscal        := {} // Array Of  PostagemVipp_NOTAFISCAL():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfNotaFiscal
	Local oClone := PostagemVipp_ArrayOfNotaFiscal():NEW()
	oClone:oWSNotaFiscal := NIL
	If ::oWSNotaFiscal <> NIL
		oClone:oWSNotaFiscal := {}
		aEval( ::oWSNotaFiscal , { |x| aadd( oClone:oWSNotaFiscal , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ArrayOfNotaFiscal
	Local cSoap := ""
	aEval( ::oWSNotaFiscal , {|x| cSoap := cSoap  +  WSSoapValue("NotaFiscal", x , x , "NotaFiscal", .F. , .F., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfNotaFiscal
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_NOTAFISCAL","NotaFiscal",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSNotaFiscal , PostagemVipp_NotaFiscal():New() )
			::oWSNotaFiscal[len(::oWSNotaFiscal)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfVolumeObjeto

WSSTRUCT PostagemVipp_ArrayOfVolumeObjeto
	WSDATA   oWSVolumeObjeto           AS PostagemVipp_VolumeObjeto OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfVolumeObjeto
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfVolumeObjeto
	::oWSVolumeObjeto      := {} // Array Of  PostagemVipp_VOLUMEOBJETO():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfVolumeObjeto
	Local oClone := PostagemVipp_ArrayOfVolumeObjeto():NEW()
	oClone:oWSVolumeObjeto := NIL
	If ::oWSVolumeObjeto <> NIL
		oClone:oWSVolumeObjeto := {}
		aEval( ::oWSVolumeObjeto , { |x| aadd( oClone:oWSVolumeObjeto , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ArrayOfVolumeObjeto
	Local cSoap := ""
	aEval( ::oWSVolumeObjeto , {|x| cSoap := cSoap  +  WSSoapValue("VolumeObjeto", x , x , "VolumeObjeto", .F. , .F., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfVolumeObjeto
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_VOLUMEOBJETO","VolumeObjeto",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSVolumeObjeto , PostagemVipp_VolumeObjeto():New() )
			::oWSVolumeObjeto[len(::oWSVolumeObjeto)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Enumeration StSolicitacao

WSSTRUCT PostagemVipp_StSolicitacao
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_StSolicitacao
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "Invalida" )
	aadd(::aValueList , "Valida" )
Return Self

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_StSolicitacao
	Local cSoap := ""
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_StSolicitacao
	::Value := NIL
	If oResponse = NIL ; Return ; Endif
	::Value :=  oResponse:TEXT
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_StSolicitacao
	Local oClone := PostagemVipp_StSolicitacao():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure ArrayOfEtiquetaPostagem

WSSTRUCT PostagemVipp_ArrayOfEtiquetaPostagem
	WSDATA   oWSEtiquetaPostagem       AS PostagemVipp_EtiquetaPostagem OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfEtiquetaPostagem
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfEtiquetaPostagem
	::oWSEtiquetaPostagem  := {} // Array Of  PostagemVipp_ETIQUETAPOSTAGEM():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfEtiquetaPostagem
	Local oClone := PostagemVipp_ArrayOfEtiquetaPostagem():NEW()
	oClone:oWSEtiquetaPostagem := NIL
	If ::oWSEtiquetaPostagem <> NIL
		oClone:oWSEtiquetaPostagem := {}
		aEval( ::oWSEtiquetaPostagem , { |x| aadd( oClone:oWSEtiquetaPostagem , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfEtiquetaPostagem
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_ETIQUETAPOSTAGEM","EtiquetaPostagem",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSEtiquetaPostagem , PostagemVipp_EtiquetaPostagem():New() )
			::oWSEtiquetaPostagem[len(::oWSEtiquetaPostagem)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure Erro

WSSTRUCT PostagemVipp_Erro
	WSDATA   oWSTipoErro               AS PostagemVipp_TipoErro
	WSDATA   cAtributo                 AS string OPTIONAL
	WSDATA   cDescricao                AS string OPTIONAL
	WSDATA   cMensagem                 AS string OPTIONAL
	WSDATA   cStackTrace               AS string OPTIONAL
	WSDATA   cStackTraceOut            AS string OPTIONAL
	WSDATA   cOrigem                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_Erro
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_Erro
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_Erro
	Local oClone := PostagemVipp_Erro():NEW()
	oClone:oWSTipoErro          := IIF(::oWSTipoErro = NIL , NIL , ::oWSTipoErro:Clone() )
	oClone:cAtributo            := ::cAtributo
	oClone:cDescricao           := ::cDescricao
	oClone:cMensagem            := ::cMensagem
	oClone:cStackTrace          := ::cStackTrace
	oClone:cStackTraceOut       := ::cStackTraceOut
	oClone:cOrigem              := ::cOrigem
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_Erro
	Local cSoap := ""
	cSoap += WSSoapValue("TipoErro", ::oWSTipoErro, ::oWSTipoErro , "TipoErro", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Atributo", ::cAtributo, ::cAtributo , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Descricao", ::cDescricao, ::cDescricao , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Mensagem", ::cMensagem, ::cMensagem , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("StackTrace", ::cStackTrace, ::cStackTrace , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("StackTraceOut", ::cStackTraceOut, ::cStackTraceOut , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Origem", ::cOrigem, ::cOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_Erro
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_TIPOERRO","TipoErro",NIL,"Property oWSTipoErro as tns:TipoErro on SOAP Response not found.",NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSTipoErro := PostagemVipp_TipoErro():New()
		::oWSTipoErro:SoapRecv(oNode1)
	EndIf
	::cAtributo          :=  WSAdvValue( oResponse,"_ATRIBUTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cDescricao         :=  WSAdvValue( oResponse,"_DESCRICAO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cMensagem          :=  WSAdvValue( oResponse,"_MENSAGEM","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cStackTrace        :=  WSAdvValue( oResponse,"_STACKTRACE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cStackTraceOut     :=  WSAdvValue( oResponse,"_STACKTRACEOUT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cOrigem            :=  WSAdvValue( oResponse,"_ORIGEM","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure ArrayOfEventoRastreio

WSSTRUCT PostagemVipp_ArrayOfEventoRastreio
	WSDATA   oWSEventoRastreio         AS PostagemVipp_EventoRastreio OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfEventoRastreio
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfEventoRastreio
	::oWSEventoRastreio    := {} // Array Of  PostagemVipp_EVENTORASTREIO():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfEventoRastreio
	Local oClone := PostagemVipp_ArrayOfEventoRastreio():NEW()
	oClone:oWSEventoRastreio := NIL
	If ::oWSEventoRastreio <> NIL
		oClone:oWSEventoRastreio := {}
		aEval( ::oWSEventoRastreio , { |x| aadd( oClone:oWSEventoRastreio , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfEventoRastreio
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_EVENTORASTREIO","EventoRastreio",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSEventoRastreio , PostagemVipp_EventoRastreio():New() )
			::oWSEventoRastreio[len(::oWSEventoRastreio)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure NotaFiscal

WSSTRUCT PostagemVipp_NotaFiscal
	WSDATA   cProtocoloNotaFiscal      AS string OPTIONAL
	WSDATA   cDtNotaFiscal             AS string OPTIONAL
	WSDATA   cSerieNotaFiscal          AS string OPTIONAL
	WSDATA   cNrNotaFiscal             AS string OPTIONAL
	WSDATA   cVlrTotalNota             AS string OPTIONAL
	WSDATA   cObservacaoNotaFiscal     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_NotaFiscal
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_NotaFiscal
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_NotaFiscal
	Local oClone := PostagemVipp_NotaFiscal():NEW()
	oClone:cProtocoloNotaFiscal := ::cProtocoloNotaFiscal
	oClone:cDtNotaFiscal        := ::cDtNotaFiscal
	oClone:cSerieNotaFiscal     := ::cSerieNotaFiscal
	oClone:cNrNotaFiscal        := ::cNrNotaFiscal
	oClone:cVlrTotalNota        := ::cVlrTotalNota
	oClone:cObservacaoNotaFiscal := ::cObservacaoNotaFiscal
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_NotaFiscal
	Local cSoap := ""
	cSoap += WSSoapValue("ProtocoloNotaFiscal", ::cProtocoloNotaFiscal, ::cProtocoloNotaFiscal , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("DtNotaFiscal", ::cDtNotaFiscal, ::cDtNotaFiscal , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("SerieNotaFiscal", ::cSerieNotaFiscal, ::cSerieNotaFiscal , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("NrNotaFiscal", ::cNrNotaFiscal, ::cNrNotaFiscal , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("VlrTotalNota", ::cVlrTotalNota, ::cVlrTotalNota , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ObservacaoNotaFiscal", ::cObservacaoNotaFiscal, ::cObservacaoNotaFiscal , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_NotaFiscal
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cProtocoloNotaFiscal :=  WSAdvValue( oResponse,"_PROTOCOLONOTAFISCAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cDtNotaFiscal      :=  WSAdvValue( oResponse,"_DTNOTAFISCAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cSerieNotaFiscal   :=  WSAdvValue( oResponse,"_SERIENOTAFISCAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cNrNotaFiscal      :=  WSAdvValue( oResponse,"_NRNOTAFISCAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cVlrTotalNota      :=  WSAdvValue( oResponse,"_VLRTOTALNOTA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cObservacaoNotaFiscal :=  WSAdvValue( oResponse,"_OBSERVACAONOTAFISCAL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure VolumeObjeto

WSSTRUCT PostagemVipp_VolumeObjeto
	WSDATA   cPeso                     AS string OPTIONAL
	WSDATA   cAltura                   AS string OPTIONAL
	WSDATA   cLargura                  AS string OPTIONAL
	WSDATA   cComprimento              AS string OPTIONAL
	WSDATA   cContaLote                AS string OPTIONAL
	WSDATA   cChaveRoteamento          AS string OPTIONAL
	WSDATA   cCodigoBarraVolume        AS string OPTIONAL
	WSDATA   cCodigoBarraCliente       AS string OPTIONAL
	WSDATA   cObservacaoVisual         AS string OPTIONAL
	WSDATA   cObservacaoQuatro         AS string OPTIONAL
	WSDATA   cObservacaoCinco          AS string OPTIONAL
	WSDATA   cPosicaoVolume            AS string OPTIONAL
	WSDATA   cConteudo                 AS string OPTIONAL
	WSDATA   oWSDeclaracaoConteudo     AS PostagemVipp_DeclaracaoConteudo OPTIONAL
	WSDATA   cValorDeclarado           AS string OPTIONAL
	WSDATA   cAdicionaisVolume         AS string OPTIONAL
	WSDATA   cVlrACobrar               AS string OPTIONAL
	WSDATA   cEtiqueta                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_VolumeObjeto
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_VolumeObjeto
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_VolumeObjeto
	Local oClone := PostagemVipp_VolumeObjeto():NEW()
	oClone:cPeso                := ::cPeso
	oClone:cAltura              := ::cAltura
	oClone:cLargura             := ::cLargura
	oClone:cComprimento         := ::cComprimento
	oClone:cContaLote           := ::cContaLote
	oClone:cChaveRoteamento     := ::cChaveRoteamento
	oClone:cCodigoBarraVolume   := ::cCodigoBarraVolume
	oClone:cCodigoBarraCliente  := ::cCodigoBarraCliente
	oClone:cObservacaoVisual    := ::cObservacaoVisual
	oClone:cObservacaoQuatro    := ::cObservacaoQuatro
	oClone:cObservacaoCinco     := ::cObservacaoCinco
	oClone:cPosicaoVolume       := ::cPosicaoVolume
	oClone:cConteudo            := ::cConteudo
	oClone:oWSDeclaracaoConteudo := IIF(::oWSDeclaracaoConteudo = NIL , NIL , ::oWSDeclaracaoConteudo:Clone() )
	oClone:cValorDeclarado      := ::cValorDeclarado
	oClone:cAdicionaisVolume    := ::cAdicionaisVolume
	oClone:cVlrACobrar          := ::cVlrACobrar
	oClone:cEtiqueta            := ::cEtiqueta
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_VolumeObjeto
	Local cSoap := ""
	cSoap += WSSoapValue("Peso", ::cPeso, ::cPeso , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Altura", ::cAltura, ::cAltura , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Largura", ::cLargura, ::cLargura , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Comprimento", ::cComprimento, ::cComprimento , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ContaLote", ::cContaLote, ::cContaLote , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ChaveRoteamento", ::cChaveRoteamento, ::cChaveRoteamento , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CodigoBarraVolume", ::cCodigoBarraVolume, ::cCodigoBarraVolume , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CodigoBarraCliente", ::cCodigoBarraCliente, ::cCodigoBarraCliente , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ObservacaoVisual", ::cObservacaoVisual, ::cObservacaoVisual , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ObservacaoQuatro", ::cObservacaoQuatro, ::cObservacaoQuatro , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ObservacaoCinco", ::cObservacaoCinco, ::cObservacaoCinco , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("PosicaoVolume", ::cPosicaoVolume, ::cPosicaoVolume , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Conteudo", ::cConteudo, ::cConteudo , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("DeclaracaoConteudo", ::oWSDeclaracaoConteudo, ::oWSDeclaracaoConteudo , "DeclaracaoConteudo", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ValorDeclarado", ::cValorDeclarado, ::cValorDeclarado , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("AdicionaisVolume", ::cAdicionaisVolume, ::cAdicionaisVolume , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("VlrACobrar", ::cVlrACobrar, ::cVlrACobrar , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Etiqueta", ::cEtiqueta, ::cEtiqueta , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_VolumeObjeto
	Local oNode14
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cPeso              :=  WSAdvValue( oResponse,"_PESO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cAltura            :=  WSAdvValue( oResponse,"_ALTURA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cLargura           :=  WSAdvValue( oResponse,"_LARGURA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cComprimento       :=  WSAdvValue( oResponse,"_COMPRIMENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cContaLote         :=  WSAdvValue( oResponse,"_CONTALOTE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cChaveRoteamento   :=  WSAdvValue( oResponse,"_CHAVEROTEAMENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCodigoBarraVolume :=  WSAdvValue( oResponse,"_CODIGOBARRAVOLUME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCodigoBarraCliente :=  WSAdvValue( oResponse,"_CODIGOBARRACLIENTE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cObservacaoVisual  :=  WSAdvValue( oResponse,"_OBSERVACAOVISUAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cObservacaoQuatro  :=  WSAdvValue( oResponse,"_OBSERVACAOQUATRO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cObservacaoCinco   :=  WSAdvValue( oResponse,"_OBSERVACAOCINCO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cPosicaoVolume     :=  WSAdvValue( oResponse,"_POSICAOVOLUME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cConteudo          :=  WSAdvValue( oResponse,"_CONTEUDO","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode14 :=  WSAdvValue( oResponse,"_DECLARACAOCONTEUDO","DeclaracaoConteudo",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode14 != NIL
		::oWSDeclaracaoConteudo := PostagemVipp_DeclaracaoConteudo():New()
		::oWSDeclaracaoConteudo:SoapRecv(oNode14)
	EndIf
	::cValorDeclarado    :=  WSAdvValue( oResponse,"_VALORDECLARADO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cAdicionaisVolume  :=  WSAdvValue( oResponse,"_ADICIONAISVOLUME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cVlrACobrar        :=  WSAdvValue( oResponse,"_VLRACOBRAR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cEtiqueta          :=  WSAdvValue( oResponse,"_ETIQUETA","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure EtiquetaPostagem

WSSTRUCT PostagemVipp_EtiquetaPostagem
	WSDATA   cNumeroEtiqueta           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_EtiquetaPostagem
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_EtiquetaPostagem
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_EtiquetaPostagem
	Local oClone := PostagemVipp_EtiquetaPostagem():NEW()
	oClone:cNumeroEtiqueta      := ::cNumeroEtiqueta
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_EtiquetaPostagem
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cNumeroEtiqueta    :=  WSAdvValue( oResponse,"_NUMEROETIQUETA","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Enumeration TipoErro

WSSTRUCT PostagemVipp_TipoErro
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_TipoErro
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "Excecao" )
	aadd(::aValueList , "RegraNegocio" )
	aadd(::aValueList , "Validacao" )
Return Self

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_TipoErro
	Local cSoap := ""
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_TipoErro
	::Value := NIL
	If oResponse = NIL ; Return ; Endif
	::Value :=  oResponse:TEXT
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_TipoErro
	Local oClone := PostagemVipp_TipoErro():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure EventoRastreio

WSSTRUCT PostagemVipp_EventoRastreio
	WSDATA   nIdVolumeObjeto           AS long OPTIONAL
	WSDATA   nIdEventoRastreio         AS long OPTIONAL
	WSDATA   cTipoEvento               AS string OPTIONAL
	WSDATA   nIdStatus                 AS int OPTIONAL
	WSDATA   nIdStatusEvento           AS int OPTIONAL
	WSDATA   cDescricaoStatusEvento    AS string OPTIONAL
	WSDATA   cDtEventoCompleta         AS dateTime OPTIONAL
	WSDATA   nIdGrupoStatusEvento      AS int OPTIONAL
	WSDATA   cNomeGrupoStatusEvento    AS string OPTIONAL
	WSDATA   cCodigoEdi                AS string OPTIONAL
	WSDATA   nIdLocalEventoOrigem      AS long OPTIONAL
	WSDATA   cLocalEvento              AS string OPTIONAL
	WSDATA   cTipoEndereco             AS string OPTIONAL
	WSDATA   cEnderecoEvento           AS string OPTIONAL
	WSDATA   cComplementoEnderecoEvento AS string OPTIONAL
	WSDATA   cBairroEvento             AS string OPTIONAL
	WSDATA   cCidadeEvento             AS string OPTIONAL
	WSDATA   cUFEvento                 AS string OPTIONAL
	WSDATA   cSTOEvento                AS string OPTIONAL
	WSDATA   nIdLocalEventoDestino     AS long OPTIONAL
	WSDATA   cDestino                  AS string OPTIONAL
	WSDATA   cTipoEnderecoDestino      AS string OPTIONAL
	WSDATA   cEnderecoDestino          AS string OPTIONAL
	WSDATA   cComplementoEnderecoDestino AS string OPTIONAL
	WSDATA   cBairroDestino            AS string OPTIONAL
	WSDATA   cCidadeDestino            AS string OPTIONAL
	WSDATA   cUFDestino                AS string OPTIONAL
	WSDATA   cSTODestino               AS string OPTIONAL
	WSDATA   cNomeRecebedor            AS string OPTIONAL
	WSDATA   cDocumentoRecebedor       AS string OPTIONAL
	WSDATA   cObsRecebedor             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_EventoRastreio
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_EventoRastreio
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_EventoRastreio
	Local oClone := PostagemVipp_EventoRastreio():NEW()
	oClone:nIdVolumeObjeto      := ::nIdVolumeObjeto
	oClone:nIdEventoRastreio    := ::nIdEventoRastreio
	oClone:cTipoEvento          := ::cTipoEvento
	oClone:nIdStatus            := ::nIdStatus
	oClone:nIdStatusEvento      := ::nIdStatusEvento
	oClone:cDescricaoStatusEvento := ::cDescricaoStatusEvento
	oClone:cDtEventoCompleta    := ::cDtEventoCompleta
	oClone:nIdGrupoStatusEvento := ::nIdGrupoStatusEvento
	oClone:cNomeGrupoStatusEvento := ::cNomeGrupoStatusEvento
	oClone:cCodigoEdi           := ::cCodigoEdi
	oClone:nIdLocalEventoOrigem := ::nIdLocalEventoOrigem
	oClone:cLocalEvento         := ::cLocalEvento
	oClone:cTipoEndereco        := ::cTipoEndereco
	oClone:cEnderecoEvento      := ::cEnderecoEvento
	oClone:cComplementoEnderecoEvento := ::cComplementoEnderecoEvento
	oClone:cBairroEvento        := ::cBairroEvento
	oClone:cCidadeEvento        := ::cCidadeEvento
	oClone:cUFEvento            := ::cUFEvento
	oClone:cSTOEvento           := ::cSTOEvento
	oClone:nIdLocalEventoDestino := ::nIdLocalEventoDestino
	oClone:cDestino             := ::cDestino
	oClone:cTipoEnderecoDestino := ::cTipoEnderecoDestino
	oClone:cEnderecoDestino     := ::cEnderecoDestino
	oClone:cComplementoEnderecoDestino := ::cComplementoEnderecoDestino
	oClone:cBairroDestino       := ::cBairroDestino
	oClone:cCidadeDestino       := ::cCidadeDestino
	oClone:cUFDestino           := ::cUFDestino
	oClone:cSTODestino          := ::cSTODestino
	oClone:cNomeRecebedor       := ::cNomeRecebedor
	oClone:cDocumentoRecebedor  := ::cDocumentoRecebedor
	oClone:cObsRecebedor        := ::cObsRecebedor
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_EventoRastreio
	::Init()
	If oResponse = NIL ; Return ; Endif
	::nIdVolumeObjeto    :=  WSAdvValue( oResponse,"_IDVOLUMEOBJETO","long",NIL,NIL,NIL,"N",NIL,NIL)
	::nIdEventoRastreio  :=  WSAdvValue( oResponse,"_IDEVENTORASTREIO","long",NIL,NIL,NIL,"N",NIL,NIL)
	::cTipoEvento        :=  WSAdvValue( oResponse,"_TIPOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nIdStatus          :=  WSAdvValue( oResponse,"_IDSTATUS","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nIdStatusEvento    :=  WSAdvValue( oResponse,"_IDSTATUSEVENTO","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cDescricaoStatusEvento :=  WSAdvValue( oResponse,"_DESCRICAOSTATUSEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cDtEventoCompleta  :=  WSAdvValue( oResponse,"_DTEVENTOCOMPLETA","dateTime",NIL,NIL,NIL,"S",NIL,NIL)
	::nIdGrupoStatusEvento :=  WSAdvValue( oResponse,"_IDGRUPOSTATUSEVENTO","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cNomeGrupoStatusEvento :=  WSAdvValue( oResponse,"_NOMEGRUPOSTATUSEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCodigoEdi         :=  WSAdvValue( oResponse,"_CODIGOEDI","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nIdLocalEventoOrigem :=  WSAdvValue( oResponse,"_IDLOCALEVENTOORIGEM","long",NIL,NIL,NIL,"N",NIL,NIL)
	::cLocalEvento       :=  WSAdvValue( oResponse,"_LOCALEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cTipoEndereco      :=  WSAdvValue( oResponse,"_TIPOENDERECO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cEnderecoEvento    :=  WSAdvValue( oResponse,"_ENDERECOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cComplementoEnderecoEvento :=  WSAdvValue( oResponse,"_COMPLEMENTOENDERECOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cBairroEvento      :=  WSAdvValue( oResponse,"_BAIRROEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCidadeEvento      :=  WSAdvValue( oResponse,"_CIDADEEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cUFEvento          :=  WSAdvValue( oResponse,"_UFEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cSTOEvento         :=  WSAdvValue( oResponse,"_STOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nIdLocalEventoDestino :=  WSAdvValue( oResponse,"_IDLOCALEVENTODESTINO","long",NIL,NIL,NIL,"N",NIL,NIL)
	::cDestino           :=  WSAdvValue( oResponse,"_DESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cTipoEnderecoDestino :=  WSAdvValue( oResponse,"_TIPOENDERECODESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cEnderecoDestino   :=  WSAdvValue( oResponse,"_ENDERECODESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cComplementoEnderecoDestino :=  WSAdvValue( oResponse,"_COMPLEMENTOENDERECODESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cBairroDestino     :=  WSAdvValue( oResponse,"_BAIRRODESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cCidadeDestino     :=  WSAdvValue( oResponse,"_CIDADEDESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cUFDestino         :=  WSAdvValue( oResponse,"_UFDESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cSTODestino        :=  WSAdvValue( oResponse,"_STODESTINO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cNomeRecebedor     :=  WSAdvValue( oResponse,"_NOMERECEBEDOR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cDocumentoRecebedor :=  WSAdvValue( oResponse,"_DOCUMENTORECEBEDOR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cObsRecebedor      :=  WSAdvValue( oResponse,"_OBSRECEBEDOR","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure DeclaracaoConteudo

WSSTRUCT PostagemVipp_DeclaracaoConteudo
	WSDATA   cDocumentoRemetente       AS string OPTIONAL
	WSDATA   cDocumentoDestinatario    AS string OPTIONAL
	WSDATA   nPesoTotal                AS int
	WSDATA   oWSItemConteudo           AS PostagemVipp_ArrayOfItemConteudo OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_DeclaracaoConteudo
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_DeclaracaoConteudo
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_DeclaracaoConteudo
	Local oClone := PostagemVipp_DeclaracaoConteudo():NEW()
	oClone:cDocumentoRemetente  := ::cDocumentoRemetente
	oClone:cDocumentoDestinatario := ::cDocumentoDestinatario
	oClone:nPesoTotal           := ::nPesoTotal
	oClone:oWSItemConteudo      := IIF(::oWSItemConteudo = NIL , NIL , ::oWSItemConteudo:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_DeclaracaoConteudo
	Local cSoap := ""
	cSoap += WSSoapValue("DocumentoRemetente", ::cDocumentoRemetente, ::cDocumentoRemetente , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("DocumentoDestinatario", ::cDocumentoDestinatario, ::cDocumentoDestinatario , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("PesoTotal", ::nPesoTotal, ::nPesoTotal , "int", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("ItemConteudo", ::oWSItemConteudo, ::oWSItemConteudo , "ArrayOfItemConteudo", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_DeclaracaoConteudo
	Local oNode4
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cDocumentoRemetente :=  WSAdvValue( oResponse,"_DOCUMENTOREMETENTE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cDocumentoDestinatario :=  WSAdvValue( oResponse,"_DOCUMENTODESTINATARIO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nPesoTotal         :=  WSAdvValue( oResponse,"_PESOTOTAL","int",NIL,"Property nPesoTotal as s:int on SOAP Response not found.",NIL,"N",NIL,NIL)
	oNode4 :=  WSAdvValue( oResponse,"_ITEMCONTEUDO","ArrayOfItemConteudo",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSItemConteudo := PostagemVipp_ArrayOfItemConteudo():New()
		::oWSItemConteudo:SoapRecv(oNode4)
	EndIf
Return

// WSDL Data Structure ArrayOfItemConteudo

WSSTRUCT PostagemVipp_ArrayOfItemConteudo
	WSDATA   oWSItemConteudo           AS PostagemVipp_ItemConteudo OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ArrayOfItemConteudo
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ArrayOfItemConteudo
	::oWSItemConteudo      := {} // Array Of  PostagemVipp_ITEMCONTEUDO():New()
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ArrayOfItemConteudo
	Local oClone := PostagemVipp_ArrayOfItemConteudo():NEW()
	oClone:oWSItemConteudo := NIL
	If ::oWSItemConteudo <> NIL
		oClone:oWSItemConteudo := {}
		aEval( ::oWSItemConteudo , { |x| aadd( oClone:oWSItemConteudo , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ArrayOfItemConteudo
	Local cSoap := ""
	aEval( ::oWSItemConteudo , {|x| cSoap := cSoap  +  WSSoapValue("ItemConteudo", x , x , "ItemConteudo", .F. , .F., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ArrayOfItemConteudo
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_ITEMCONTEUDO","ItemConteudo",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSItemConteudo , PostagemVipp_ItemConteudo():New() )
			::oWSItemConteudo[len(::oWSItemConteudo)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ItemConteudo

WSSTRUCT PostagemVipp_ItemConteudo
	WSDATA   cDescricaoConteudo        AS string OPTIONAL
	WSDATA   nQuantidade               AS int OPTIONAL
	WSDATA   cValor                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT PostagemVipp_ItemConteudo
	::Init()
Return Self

WSMETHOD INIT WSCLIENT PostagemVipp_ItemConteudo
Return

WSMETHOD CLONE WSCLIENT PostagemVipp_ItemConteudo
	Local oClone := PostagemVipp_ItemConteudo():NEW()
	oClone:cDescricaoConteudo   := ::cDescricaoConteudo
	oClone:nQuantidade          := ::nQuantidade
	oClone:cValor               := ::cValor
Return oClone

WSMETHOD SOAPSEND WSCLIENT PostagemVipp_ItemConteudo
	Local cSoap := ""
	cSoap += WSSoapValue("DescricaoConteudo", ::cDescricaoConteudo, ::cDescricaoConteudo , "string", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Quantidade", ::nQuantidade, ::nQuantidade , "int", .F. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("Valor", ::cValor, ::cValor , "string", .F. , .F., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT PostagemVipp_ItemConteudo
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cDescricaoConteudo :=  WSAdvValue( oResponse,"_DESCRICAOCONTEUDO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nQuantidade        :=  WSAdvValue( oResponse,"_QUANTIDADE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cValor             :=  WSAdvValue( oResponse,"_VALOR","string",NIL,NIL,NIL,"S",NIL,NIL)
Return


