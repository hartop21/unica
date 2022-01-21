/*//#########################################################################################
	Projeto : LORD
	Modulo  : Util
	Fonte   : MDIOk
	Objetivo: Adiciona Teclas de Atalho para usuários
*///#########################################################################################
#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} SIGACFG

	Adiciona Teclas de Atalho para usuários

	@author  Robson Rogério Silva
	@since   23/10/2018
/*/
User Function SIGACFG()
	U_MDIOK()
Return

/*/{Protheus.doc} SIGALOJA

	Adiciona Teclas de Atalho para usuários

	@author  Robson Rogério Silva
	@since   23/10/2018
/*/
User Function SIGALOJA()
	U_MDIOK()
Return

/*/{Protheus.doc} SIGAFAT

	Adiciona Teclas de Atalho para usuários

	@author  Robson Rogério Silva
	@since   23/10/2018
/*/
User Function SIGAFAT()
	U_MDIOK()
Return

/*/{Protheus.doc} SIGAADV

	Adiciona Teclas de Atalho para usuários

	@author  Robson Rogério Silva
	@since   23/10/2018
/*/
User Function SIGAADV()
	U_MDIOK()
Return

/*/{Protheus.doc} MDIOk

	Adiciona Teclas de Atalho para usuários

	@author  Robson Rogério Silva
	@since   23/10/2018
/*/
User Function MDIOk()
	Local aDicionarios := RetSxs()
	FwMsgRun(, { || aEVal(aDicionarios, {|x| DbSelectArea(x[1])}) }, , "Preparando ambiente..."  )

	If FwIsAdmin()
		SetKey( K_CTRL_F12,  {|| ProtectMdi("U_PXRUNPRG()") } )
	EndIf
Return

/*/{Protheus.doc} ProtectMdi

	Protege a execução de rotina na TRHEAD do MAIN pois a mesma não reabre as SX's quando troca de empresa.

	@author  Robson Rogério Silva
	@since   24-01-2019
/*/

Static Function ProtectMdi(cPrograma)
	Local aDicionarios := RetSxs()
	Local nI

	For nI := 1 To Len(aDicionarios)
		If( Select(aDicionarios[ni][1]) > 0)
			(aDicionarios[ni][1])->(DbCloseArea())
		EndIf
	Next nI

	FwMsgRun(, { || aEVal(aDicionarios, {|x| DbSelectArea(x[1])}) }, , "Preparando ambiente..."  )

	&cPrograma
Return

/*/{Protheus.doc} PXRUNPRG

	Executa uma função fora do menu

	@author  Robson Rogério Silva
	@since   17-01-2019
/*/

User Function PXRUNPRG()
	Local cPrograma	:= SPACE(250)//GetMv("LD_PROG") + SPACE(250)
	Local lLogin    := Type("cEmpAnt") != "U"
	Local aPergs := {}

	If ! lLogin
		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "0101"
	EndIf

	aAdd( aPergs ,{1,"Nome da Função"    		, cPrograma                    ,,'.T.',"" ,'.T.',60, .T.})
	aAdd( aPergs ,{4,"Protege execução"  		, .T.,"Protege execução",85,,})

	While ParamBox( @aPergs , "Processa FUNCAO" , NIL , NIL , NIL , .T. )
		RodaPrg(AllTrim(MV_PAR01))
	Enddo
Return

/*/{Protheus.doc} RodaPrg

	Executa o programa recebido.

	@author  Robson Rogério
	@since   17-01-2019
/*/

Static Function RodaPrg(cPrograma)
	Local cFunName		:= FunName()
	Local cProgramaOld  := cPrograma
	Local nPos
	// Salva bloco de código do tratamento de erro
	Local oError 		:= ErrorBlock({|e| MsgAlert("Mensagem de Erro: " + CRLF + e:Description, "MDIOK.prw")})

	//monta o FunName que precisa para rodar
	// Verifica se tem U_ e remove
	If SubStr(cPrograma,1,2) == "U_"
		cPrograma := SubStr(cPrograma,3)
	EndIf

	// Encontra o Parenteses e corta antes
	nPos          := At("(",cPrograma)

	cPrograma   := SubStr(cPrograma,1,nPos-1)

	SetFunName(cPrograma)

	If MV_PAR02
		&cProgramaOld
		ErrorBlock(oError)
	Else
		ErrorBlock(oError)
		&cProgramaOld
	EndIf

	SetFunName(cFunName)
Return

/*/{Protheus.doc} LOGOFF

	Rotina que faz o Logoff

	@author  Robson Rogério
	@since   13-01-2020
/*/

User Function Logoff()
	//fecha as tabelas, reinicia variavei e chama tela de login
	DbCloseAll()
	ResetSPLog()
	Eval(oApp:bMDILogOff)
Return
