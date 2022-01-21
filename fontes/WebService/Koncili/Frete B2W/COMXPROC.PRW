#include 'protheus.ch'
#Include "Topconn.ch"
#INCLUDE "XMLXFUN.CH"

User Function COMXPROC()

	Local oXml
	Local cXml     := ""
	Local cReplace := ""
	Local cError   := ""
	Local cWarning := ""
	Local cChave   := ""
	Local aAreAnt  := GetArea()

	cXml := GetMV("MV_NGLIDOS") + "\" + ALLTRIM(GETADVFVAL("CKO","CKO_ARQXML",SDS->DS_ARQUIVO,1))
	oXml := XmlParserFile(cXml,cReplace,@cError,@cWarning)

	IF Valtype(oXml) <> "U"
		IF AttIsMemberof(oXml,"_CTEPROC")
			IF AttIsMemberof(OXML:_CTEPROC:_CTE:_INFCTE,"_INFCTENORM")  // Renato Morcerf - 25/05/2021
			  IF VALTYPE(OXML:_CTEPROC:_CTE:_INFCTE:_INFCTENORM:_INFDOC:_INFNFE) == 'O'
				cChave := ALLTRIM(OXML:_CTEPROC:_CTE:_INFCTE:_INFCTENORM:_INFDOC:_INFNFE:_CHAVE:TEXT)
			  Endif	
			Elseif AttIsMemberof(OXML:_CTEPROC:_CTE:_INFCTE,"_INFCTECOMP") 
				cChave := AllTrim(OXML:_CTEPROC:_CTE:_INFCTE:_INFCTECOMP:_CHCTE:TEXT)
			Endif
		ELSE
			IF VALTYPE(OXML:_CTEPROC:_CTE:_INFCTE:_INFCTENORM:_INFDOC:_INFNFE) == 'O'
				cChave := ALLTRIM(OXML:_CTE:_INFCTE:_INFCTENORM:_INFDOC:_INFNFE:_CHAVE:TEXT)
			ENDIF
		ENDIF
		RECLOCK("SDS",.F.)
		SDS->DS_XCHAVE := cChave
		MSUNLOCK()
	Endif

	RestArea(aAreAnt)
Return(.T.)
