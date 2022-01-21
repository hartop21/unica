#INCLUDE "prtopdef.ch"
#Include "TOTVS.ch"
#Include "TopConn.Ch"
#Include "Fileio.ch"
#Include "Colors.ch"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"
#Include "Ap5Mail.Ch"

/*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | UNIR011 | Autor | Andre Carralero (Carralero Desenv.)     |*
*+------------+------------------------------------------------------------+*
*|Data        | 07.03.2008                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Impressao do boleto Bradesco Grafico                       |*
*+------------+------------------------------------------------------------+*
*|Solicitante |                                                            |*
*+------------+------------------------------------------------------------+*
*|Arquivos	  | 														   |*
*+------------+------------------------------------------------------------+*
*|			   ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL 		   |*
*+-------------------------------------------------------------------------+*
*| Programador		 |	 Data	| Motivo da alteracao					   |*
*+-------------------+----------+------------------------------------------+*
*|					 |			|										   |*
*+-------------------+----------+------------------------------------------+*
*****************************************************************************/
// PH - 07/03/2008


User Function UNIR011()

	PRIVATE lExec    := .F.
	PRIVATE cIndexName := ''
	PRIVATE cIndexKey  := ''
	PRIVATE cFilter    := ''
	Private _nQtdT := 0

	Private _contalt:=0,_contall:=0,_chkmarc:=.F.,_contmarc:=0,nop:=0
	Private acampos:={{'E1_OK',,''},{'E1_PREFIXO',,'Pref.'},{'E1_NUM',,'Num.'},{'E1_TIPO',,'Tipo'},{'E1_CLIENTE',,'Cliente'},{'E1_LOJA',,'Loja'},;
		{'E1_EMISSAO',,'Emissao'},{'E1_VENCTO',,'Venc.'},{'E1_VENCREA',,'Venc. Real'},{'E1_VALOR',,'Valor',pesqpict("SE1","E1_VALOR")}}
	Private ccadastro:="Emissão de boletos"
	Private arotina:={{'Pesquisar','Axpesqui',0,1},{'Emitir','u_MontaRel()',0,1}}
	Private cmarca:=getmark()
	Private ldtv:=.f.,lrel:=.f.,oprel,msg
	Private dtv:=ctod("")
	Private cConv := ""


	Tamanho  := "M"
	titulo   := "Impressao de Boleto com Codigo de Barras"
	cDesc1   := "Este programa destina-se a impressao do Boleto com Codigo de Barras."
	cDesc2   := ""
	cDesc3   := ""
	cString  := "SE1"
	wnrel    := "BOLETO"
	lEnd     := .F.
	cPerg     :="UNIR011"//"BLTBAR"
	aReturn  := {"Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
	nLastKey := 0
	_cCart	 := "09" // Carteira de Cobrança

	dbSelectArea("SE1")

	Private cPerg     := "UNIR011   "//"BLTBAR    "

	/*
	aRegs	:= {}
//	Aadd(aRegs,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO", "TAMANHO", "DECIMAL","GSC","VAR01"   ,"F3" ,"DEF01","DEF02","DEF03","DEF04","DEF05"})
    Aadd(aRegs,{ cPerg ,"01"   ,"Prefixo de          ","mv_ch1" ,"C"   , 03       , 0        ,"G"  ,"mv_par01",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"02"   ,"Prefixo ate         ","mv_ch2" ,"C"   , 03       , 0        ,"G"  ,"mv_par02",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"03"   ,"Numero de           ","mv_ch3" ,"C"   , 09       , 0        ,"G"  ,"mv_par03",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"04"   ,"Numero ate          ","mv_ch4" ,"C"   , 09       , 0        ,"G"  ,"mv_par04",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"05"   ,"Parcela de          ","mv_ch5" ,"C"   , 01       , 0        ,"G"  ,"mv_par05",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"06"   ,"Parcela ate         ","mv_ch6" ,"C"   , 01       , 0        ,"G"  ,"mv_par06",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"07"   ,"Portador de         ","mv_ch7" ,"C"   , 03       , 0        ,"G"  ,"mv_par07","SA6",""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"08"   ,"Portador ate        ","mv_ch8" ,"C"   , 03       , 0        ,"G"  ,"mv_par08","SA6",""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"09"   ,"Cliente de          ","mv_ch9" ,"C"   , 06       , 0        ,"G"  ,"mv_par09","SE1",""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"10"   ,"Cliente ate         ","mv_cha" ,"C"   , 06       , 0        ,"G"  ,"mv_par10","SE1",""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"11"   ,"Loja de             ","mv_chb" ,"C"   , 02       , 0        ,"G"  ,"mv_par11",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"12"   ,"Loja ate            ","mv_chc" ,"C"   , 02       , 0        ,"G"  ,"mv_par12",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"13"   ,"Emissao de          ","mv_chd" ,"D"   , 08       , 0        ,"G"  ,"mv_par13",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"14"   ,"Emissao ate         ","mv_che" ,"D"   , 08       , 0        ,"G"  ,"mv_par14",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"15"   ,"Vencimento de       ","mv_chf" ,"D"   , 08       , 0        ,"G"  ,"mv_par15",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"16"   ,"Vencimento ate      ","mv_chg" ,"D"   , 08       , 0        ,"G"  ,"mv_par16",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"17"   ,"Bordero de          ","mv_chh" ,"C"   , 06       , 0        ,"G"  ,"mv_par17",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"18"   ,"Bordero ate         ","mv_chi" ,"C"   , 06       , 0        ,"G"  ,"mv_par18",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"19"   ,"Reprocessa          ","mv_chj" ,"N"   , 01       , 0        ,"C"  ,"mv_par19",""   ,"Sim"  ,"Nao"  ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"20"   ,"Banco               ","mv_chk" ,"C"   , 03       , 0        ,"G"  ,"mv_par20","SA6",""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"21"   ,"Agencia             ","mv_chl" ,"C"   , 05       , 0        ,"G"  ,"mv_par21",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"22"   ,"Conta               ","mv_chm" ,"C"   , 10       , 0        ,"G"  ,"mv_par22",""   ,""     ,""     ,""     ,""     ,""     })
    Aadd(aRegs,{ cPerg ,"23"   ,"Sub-Conta           ","mv_chn" ,"C"   , 03       , 0        ,"G"  ,"mv_par23",""   ,""     ,""     ,""     ,""     ,""     })
	*/


	MakeDir("C:\TEMP")

	ValidPerg()

	Pergunte (cPerg,.T.)

	//Wnrel := SetPrint(cString,Wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho,,)

	//Lucas Miranda de Aguiar	-	25/05/2020
	If alltrim(mv_par20) <> "237" .And. alltrim(mv_par20) <> "341" .And. alltrim(mv_par20) <> "033"
		ApMsgAlert("Banco incorreto, os bancos disponíveis para geração de boleto são "+chr(13)+"Bradesco, Santander e Itau!!")
		Return
	EndIf
	//Fim
	DbSelectArea("SEE")
	DbSetOrder(1)
	if !DbSeek(xFilial("SEE")+MV_PAR20+MV_PAR21+MV_PAR22+MV_PAR23)//,.T.)
		MsgStop("Sub-Conta não cadastrada.")
		return
	endif

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	//SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		Return
	Endif
	//cIndexKey	:= "E1_PORTADO+E1_CLIENTE+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+DTOS(E1_EMISSAO)"
	cIndexKey	:= "E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+DTOS(E1_EMISSAO)+E1_CLIENTE+E1_PORTADO"
	cFilter		+= "E1_FILIAL=='"+xFilial("SE1")+"'.And."//E1_SALDO>0.And."
	cFilter		+= "E1_PREFIXO>='" + MV_PAR01 + "'.And.E1_PREFIXO<='" + MV_PAR02 + "'.And."
	cFilter		+= "E1_NUM>='" + MV_PAR03 + "'.And.E1_NUM<='" + MV_PAR04 + "'.And."
	cFilter		+= "E1_PARCELA>='" + MV_PAR05 + "'.And.E1_PARCELA<='" + MV_PAR06 + "'.And."
	cFilter		+= "E1_PORTADO>='" + MV_PAR07 + "'.And.E1_PORTADO<='" + MV_PAR08 + "'.And."
	cFilter		+= "E1_CLIENTE>='" + MV_PAR09 + "'.And.E1_CLIENTE<='" + MV_PAR10 + "'.And."
	cFilter		+= "E1_LOJA>='" + MV_PAR11 + "'.And.E1_LOJA<='"+MV_PAR12+"'.And."
	cFilter		+= "DTOS(E1_EMISSAO)>='"+DTOS(mv_par13)+"'.and.DTOS(E1_EMISSAO)<='"+DTOS(mv_par14)+"'.And."
	cFilter		+= 'DTOS(E1_VENCREA)>="'+DTOS(mv_par15)+'".and.DTOS(E1_VENCREA)<="'+DTOS(mv_par16)+'".And.'
	cFilter		+= "E1_NUMBOR>='" + MV_PAR17 + "'.And.E1_NUMBOR<='" + MV_PAR18 + "'.And."
	cFilter		+= "!(E1_TIPO$MVABATIM)"

	If MV_PAR19 = 1
		cFilter += " .and. !Empty(E1_NUMBCO) "
	Else
		cFilter += " .and. Empty(E1_NUMBCO) "
	EndIf


	//cFilter		+= "E1_PORTADO<>'   '"
	DbSelectArea("SE1")
	SE1->( dbSetFilter( { || &cFilter }, cFilter ) )
	dbGoTop()

	// Cria temporário para colocar no nome do cliente e o valor líquido do título.
	/*aStruTRB := {}Admin
dbSelectArea("SX3")
dbSetOrder(1)
dbseek("SE1")
	while X3_Arquivo = 'SE1'
  aAdd(aStruTRB,{SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL })
  dbskip()
	end

cFile 		:= CriaTrab(aStruTRB,.T.)
dbUseArea(.T.,,cFile,"TRBSND",.T.,.F.)
dbselectarea('SE1')
dbgotop()
	while !eof()
  RecLock("TRBSND",.t.)
  SX3->(dbSetOrder(1))
  SX3->(dbseek("SE1"))
		while SX3->X3_Arquivo = 'SE1'
    &("TRBSND->" + SX3->X3_CAMPO) := &("SE1->" + SX3->X3_CAMPO)
    SX3->(dbskip())
		end
  TRBSND->(dbcommit())
  TRBSND->(dbunlock())
  dbskip()
	end

TRBSND->(dbgotop())

	while !TRBSND->(eof())
  reclock("TRBSND",.f.)
  TRBSND->E1_VALOR := E1_VALOR - E1_CSLL - E1_COFINS - E1_IRRF - E1_PIS
  TRBSND->(dbskip())
	end

	TRBSND->(dbgotop())*/

	markbrow('SE1','E1_OK',"(u_avalse1())",acampos,,cmarca,'u_markall()',,,,'u_mark()')

	/*@ 001,001 TO 400,700 DIALOG oDlg TITLE "Seleção de Titulos"
@ 001,001 TO 170,350 BROWSE "SE1" MARK "E1_MBOL"
@ 180,310 BMPBUTTON TYPE 01 ACTION (lExec := .T.,Close(oDlg))
@ 180,280 BMPBUTTON TYPE 02 ACTION (lExec := .F.,Close(oDlg))
	ACTIVATE DIALOG oDlg CENTERED*/

	/*dbGoTop()
	If lExec
	Processa({|lEnd|MontaRel()})
	Endif*/
	RetIndex("SE1")

Return Nil

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
User function markall()
	Loca nrecno:=recno()
	SE1->(dbgotop())
	While !SE1->(eof())
		u_mark()
		dbskip()
	enddo
	dbgoto(nrecno)
return

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
user function mark()

	reclock("SE1",.F.)

	if ismark('E1_OK',cmarca)
		replace SE1->e1_ok with space(2)
		_nQtdT--
	else
		replace e1_ok with cmarca
		_nQtdT++
	endif

	msunlock("SE1")
return

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
user function avalse1()
	Local cret:="X"


	//Comentado por Luiz Otavio Campos para considerar os titulos parcialmente baixados
	/*
	If empty(dtos(e1_baixa)) //.and. empty(e1_portado)
		cret:=""
	Endif
	*/

	If E1_SALDO >0 //.and. empty(e1_portado)
		cret:=""
	Endif


return cret



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  MontaRel³ Autor ³ Microsiga             ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASER COM CODIGO DE BARRAS			     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MontaRel()

	Processa( {|| U_FazRel() }, "Aguarde...", "Gerando os PDF's em C:\TEMP\'...",.F.)

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	User Function FazRel
		LOCAL oPrint
		LOCAL nX := 0
		Local cNroDoc :=  " "
		LOCAL aDadosEmp    := {	SM0->M0_NOMECOM                                    ,; //[1]Nome da Empresa
			SM0->M0_ENDCOB                                       ,; //[2]Endereço
			AllTrim(SM0->M0_BAIRCOB)+", "+AllTrim(SM0->M0_CIDCOB)+", "+SM0->M0_ESTCOB ,; //[3]Complemento
			"CEP: "+Subs(SM0->M0_CEPCOB,1,5)+"-"+Subs(SM0->M0_CEPCOB,6,3)             ,; //[4]CEP
			"PABX/FAX: "+SM0->M0_TEL                                                  ,; //[5]Telefones
			"CNPJ: "+Subs(SM0->M0_CGC,1,2)+"."+Subs(SM0->M0_CGC,3,3)+"."+              ; //[6]
			Subs(SM0->M0_CGC,6,3)+"/"+Subs(SM0->M0_CGC,9,4)+"-"+                       ; //[6]
			Subs(SM0->M0_CGC,13,2)                                                    ,; //[6]CGC
			"I.E.: "+Subs(SM0->M0_INSC,1,3)+"."+Subs(SM0->M0_INSC,4,3)+"."+            ; //[7]
			Subs(SM0->M0_INSC,7,3)+"."+Subs(SM0->M0_INSC,10,3)                        ,; //[7]I.E
			SM0->M0_COMPCOB 														}    //[8] COMPLEMENTO DO ENDERECO

		LOCAL aDadosTit
		LOCAL aDadosBanco
		LOCAL aDatSacado
		LOCAL aBolText     := {"APÓS VENCIMENTO COBRAR JUROS DE 5% A.M",;
			"30 DIAS APÓS O VENCIMENTO SUJEITO A PROTESTO",;
			"NEGATIVAÇÃO 1 DIA APÓS O VENCIMENTO",;
			"VENDEDORES NÃO ESTÃO AUTORIZADOS A RECEBER",;
			"VISITE NOSSO SITE: WWW.UNICAARCONDICIONADO.COM.BR" }

		LOCAL nI			:= 1
		LOCAL aCB_RN_NN		:= {}
		Private nVlrAbat		:= 0

		Private cAgSantan := ""


		dbGoTop()
		ProcRegua(_nQtdT)
		Do While !EOF()

			if !SE1->E1_OK==cmarca
				dbskip()
				loop
			endif

			IncProc()
			//Posiciona o SA6 (Bancos)
			DbSelectArea("SA6")
			DbSetOrder(1)
			//	DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.T.)
			DbSeek(xFilial("SA6")+MV_PAR20+MV_PAR21+MV_PAR22,.T.)

			//Posiciona na Arq de Parametros CNAB
			DbSelectArea("SEE")
			DbSetOrder(1)
			//	DbSeek(xFilial("SEE")+SE1->(E1_PORTADO+E1_AGEDEP+E1_CONTA),.T.)
			//	DbSeek(xFilial("SEE")+MV_PAR20+MV_PAR21+MV_PAR22+MV_PAR23,.T.)

			//Posiciona o SA1 (Cliente)
			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA,.T.)


			/* Core 280616 - Ajustes no número da conta para não ter que ajusta via SDU para as empresas 17 e 19 que foram cadastradas
			com digito verificador separado, diferentemente das outras empresas já criadas */


			If cEmpAnt $ ("17/19/60")
				cNumCta  := StrZero(Val(SUBSTR(SA6->A6_NUMCON,1,Len(AllTrim(SA6->A6_NUMCON)))),5)
				cDigCta  := AllTrim(SA6->A6_DVCTA)
			Else
				//HECTOR
				cNumCta  := SUBSTR(SA6->A6_NUMCON,1,Len(AllTrim(SA6->A6_NUMCON)))
				cDigCta  := SUBSTR(SA6->A6_DVCTA,Len(AllTrim(SA6->A6_DVCTA)),1)
			Endif


			//HECTOR
			DbSelectArea("SE1")
			aDadosBanco  := {	SA6->A6_COD                        						,; 	// [1] Numero do Banco
				SA6->A6_NREDUZ                                       	,;  // [2] Nome do Banco
				SUBSTR(SA6->A6_AGENCIA, 1, 4)+" "+SA6->A6_DVAGE      	,; 	// [3] Agência
				cNumCta                                                 ,; 	// [4] Conta Corrente
				cDigCta                      				            ,;  // [5] Dígito da conta corrente
				_cCart                                             		}	// [6] Codigo da Carteira

			cAgSantan := AllTrim(SA6->A6_AGENCIA)


			/* Backup
	DbSelectArea("SE1")
	aDadosBanco  := {	SA6->A6_COD                        						,; 	// [1] Numero do Banco
						SA6->A6_NREDUZ                                       	,;  // [2] Nome do Banco
	                	SUBSTR(SA6->A6_AGENCIA, 1, 4)                        	,; 	// [3] Agência
                    	SUBSTR(SA6->A6_NUMCON,1,Len(AllTrim(SA6->A6_NUMCON))-1)	,; 	// [4] Conta Corrente
                    	SUBSTR(SA6->A6_NUMCON,Len(AllTrim(SA6->A6_NUMCON)),1)  	,; 	// [5] Dígito da conta corrente
                    _cCart                                             		}	// [6] Codigo da Carteira
			*/

			if cEmpAnt = '01' .or. cEmpAnt = '02'
				//aDadosBanco[3] := '3369'
			endif

			If Empty(SA1->A1_ENDCOB)
				aDatSacado:={	AllTrim(substr(SA1->A1_NOME,1,86))			    		,;      	// [1]Razão Social
					AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA    	       ,;      	// [2]Código
					AllTrim(SA1->A1_END )+" - "+AllTrim(SA1->A1_BAIRRO)	,;      	// [3]Endereço
					AllTrim(SA1->A1_MUN )                            	,;  		// [4]Cidade
					SA1->A1_EST                                      	,;    		// [5]Estado
					SA1->A1_CEP                                      	,;      	// [6]CEP
					SA1->A1_CGC										 		,;  		// [7]CGC
					SA1->A1_PESSOA									 		,;			// [8]PESSOA
					SA1->A1_TEL													}    	// [9] TELEFONE
				// >> PH - 07/03/2008
				//SA1->A1_PESSOA										}    	// [8]PESSOA
				// << PH - 07/03/2008

			Else
				aDatSacado:={	AllTrim(SA1->A1_NOME)            		 					,;   	// [1]Razão Social
					AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA 	             	,;   	// [2]Código
					AllTrim(SA1->A1_ENDCOB)+" - "+AllTrim(SA1->A1_BAIRROC)	,;   	// [3]Endereço
					AllTrim(SA1->A1_MUNC)	                             	,;   	// [4]Cidade
					SA1->A1_ESTC	                                     		,;   	// [5]Estado
					SA1->A1_CEPC                                         	,;   	// [6]CEP
					SA1->A1_CGC													,;		// [7]CGC
					SA1->A1_PESSOA										 		,;		// [8]PESSOA
					SA1->A1_TEL														}    	// [9] TELEFONE
				// >> PH - 07/03/2008
				//SA1->A1_PESSOA										}    	// [8]PESSOA
				// << PH - 07/03/2008

			Endif

			//nVlrAbat	:= SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
			nVlrAbat    := CalcAbat()

			// >> PH - 07/03/2008
			//_cXXOBS 	:= alltrim(SE1->E1_XXOBS)
			// << PH - 07/03/2008
			//Aqui defino parte do nosso numero. Sao 8 digitos para identificar o titulo.
			//Abaixo apenas uma sugestao

			//If EMPTY(SE1->E1_NUMBCO)

			//cNroDoc := NossoNum()


			cNroDoc:= StrZero(Val(Substr(SEE->EE_FAXATU,2,11)),11)//Len(SEE->EE_FAXATU))

			//alert(SEE->EE_FAXATU)

			//alert(cNroDoc)

			//alert(Soma1(cNroDoc))

			If Empty(SE1->E1_NUMBCO)
				RecLock("SE1",.f.)
				Replace SE1->E1_NUMBCO With cNroDoc + CALC_di7(cNroDoc)
				SE1->( MsUnlock( ) )

				dbSelectArea("SEE")
				RecLock("SEE",.f.)
				Replace EE_FAXATU With Substr(EE_FAXATU,1,1) + Soma1(cNroDoc)//,Len(SEE->EE_FAXATU))
				SEE->( MsUnlock() )

				dbSelectArea("SE1")
			Else
				cNroDoc := Substr(SE1->E1_NUMBCO,1,11)
			EndIf

			/*If EMPTY(SE1->E1_NUMBCO)
		cNroDoc	:= substr(SEE->EE_FAXATU,2,11)
		cNroDoc	:= substr(SEE->EE_FAXATU,2,11)
	Else
		cNroDoc := Substr(SE1->E1_NUMBCO,3,11)
			EndIf*/

			DbSelectArea("SE1")
			_nValor := (E1_SALDO-E1_SDDECRE-nVlrAbat)
			_VlrJur := E1_SDACRES

			cConv := AllTrim(aDadosBanco[3])+"/"+fRetConv(aDadosBanco,cAgSantan)
			//Monta codigo de barras
			If AllTrim(aDadosBanco[1]) == "033"
				aCB_RN_NN 	:= RCbSant( SE1->E1_PREFIXO	, SE1->E1_NUM , SE1->E1_PARCELA , SE1->E1_TIPO ,  aDadosBanco  , cNroDoc ,(Round((SE1->E1_SALDO+SE1->E1_ACRESC-nVlrAbat-SE1->E1_DECRESC),2))	, SE1->E1_VENCREA	)
			Else
				aCB_RN_NN    := u_Ret_cBarra(	SE1->E1_PREFIXO	,SE1->E1_NUM	,SE1->E1_PARCELA	,'DS',; //,SE1->E1_TIPO	,;
					Subs(aDadosBanco[1],1,3)	,aDadosBanco[3]	,aDadosBanco[4] ,aDadosBanco[5]	,;
					cNroDoc		,(_nValor+_VlrJur)	, _cCart	,"9"	)
			EndIF
			aDadosTit	:= {AllTrim(E1_NUM)+AllTrim(E1_PARCELA)		,;  // [1] Número do título
				E1_EMISSAO                          ,;  // [2] Data da emissão do título
				dDataBase                    		,;  // [3] Data da emissão do boleto
				E1_VENCTO                           ,;  // [4] Data do vencimento
				_nValor					            ,;  // [5] Valor do título
				aCB_RN_NN[3]                        ,;  // [6] Nosso número (Ver fórmula para calculo)
				E1_PREFIXO                          ,;  // [7] Prefixo da NF
				'DS'	                           	,;  // [8] Tipo do Titulo  //E1_TIPO
				E1_VALJUR							,; // [9] Valor da Mora Diaria
				_VlrJur                             ,;	//[10] Valor de Juros e Multa
				E1_ACRESC							,;   //[11] Valor do acréscimo - Lucas Miranda de Aguiar - 25/05/2020
				E1_JUROS							,;	//[12]Valor do Juros - Lucas Miranda de Aguiar - 25/05/2020
				E1_XNOTA							,;	//[13] Valor da nota fiscal (Campo customizado)
				E1_XSERIE							}	//[14]Valor da série da nota fiscal (campo customizado)



			_cNomArq := SE1->E1_PREFIXO+"-"+SE1->E1_NUM+iif(!Empty(SE1->E1_PARCELA),"-"+SE1->E1_PARCELA,"")

			/*
	__cAux := ''
	For w = 1 to len(_cNomArq)
		If Substr(_cNomArq,w,1) <> '/' .and. Substr(_cNomArq,w,1) <> ' '
			__cAux += Substr(_cNomArq,w,1)
		EndIf
	Next
	__cAux := "Boleto NF " + __cAux
	//Alert(__cAux)
			*/

			cPathPDF  := AllTrim( GetNewPar( "MV_XPTHBOL", "C:\BoletoPDF" ) )
			cPathMail := AllTrim( GetNewPar( "MV_XPTHMAI", "\MailBol"     ) )
			FwMakedir( cPathPDF	, .T. )
			FwMakeDir( cPathMail, .T. )
			cNomeArq := "boletoB-" + AllTrim( SA1->A1_COD ) + "-" + AllTrim( SA1->A1_LOJA ) + "-" + FwTimeStamp( 01 ) + ".pdf"



			oPrint:= FWMSPrinter():New(cNomeArq, IMP_PDF, .T., "C:\TEMP\", .t. )
			oPrint:SetPortrait() // ou SetLandscape()
			oPrint:SetPaperSize(9)			// papel A4
			//oPrint:lViewPDF := .F.
			//oPrint:lServer := .F.
			//oPrint:cPathPDF := 'C:\TEMP\'


			If mv_par24 == 1
				oPrint:lServer := .T.
				oPrint:SetViewPDF( .F. )
			Else
				oPrint:lServer := .F.
				oPrint:SetViewPDF( .T. )
			EndIf

			oPrint:nDevice := IMP_PDF


			//If cParamFiles == Nil
			If !mv_par24 == 1  //MV_PAR19 == 1
				oPrint:cPrinter := "PDF"
				oPrint:cPathPDF := AllTrim( cPathPDF ) + "\"
			Else
				oPrint:cPrinter := "PDF"
				oPrint:cPathPDF 	:= AllTrim( cPathMail ) + "\"
			EndIf

			oPrint:SetPortrait()
			oPrint:SetPaperSize( DMPAPER_A4 )

			DbSelectArea( "SZ4" )
			SZ4->( DbSetOrder( 01 )  )

			If Dbseek(xFilial("SZ4")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)  // Alterado por Luiz Otavio Para buscar corretamente a config do envio de boleto
				lMostraBoleto := SZ4->Z4_SHOWBOL == "S"
				lMostraSetUp  := SZ4->Z4_SHOWSET == "S"
			Else
				lMostraBoleto := .T.
				lMostraSetUp  := .T.
			EndIf


			Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
			//FImpBoleto( oPrint, aDadosEmp, aDadosTit, aDadosBanco, aDatSacado, aBolText, aCB_RN_NN, SE1->E1_PEDIDO, SE1->E1_NUMBCO, SE1->E1_NUM )

			oPrint:EndPage()     // Finaliza a página

			//Comentado por Luiz Otavio Campos
			//If mv_par24 == 1
			//	fEnvBolMail()
			//EndIf

			/***********ADICIONADO POR LUIZ OTAVIO PARA ENVIO DE E-MAIL ****** EM * 08/07/2021 ******************************************************************/


			If !(mv_par24 == 1)  //.And. lParamSetup
				If lMostraSetup
					oPrint:Setup()
				EndIf
			EndIf

			If lMostraBoleto
				oPrint:Preview()     // Visualiza antes de imprimir //Vitor Duarte 01/11/2013
			EndIf

			FreeObj( oPrint )
			oPrint := Nil

			If mv_par24 == 1 //MV_PAR19 == 1
				cRetFile := Replace( cPathMail + "\" + cNomeArq, "\\", "\" )
			Else
				cRetFile := Replace( cPathPDF + "\" + cNomeArq, "\\", "\" )
			EndIf

			If mv_par24 == 1

				aAuxTitulos := {}
				aAdd( aAuxTitulos, { SE1->( RecNo() ), SA1->A1_NOME, cRetFile } )
				lParamSchedule:=.F.

				If lParamSchedule
					MsgRun( "Enviando E-mail para cliente, aguarde..", "Enviando E-mail para cliente, aguarde..", { || U_UNIEnvBoletos( "237", aAuxTitulos, lParamSchedule ) } )
				Else
					U_UNIEnvBoletos( "237", aAuxTitulos, lParamSchedule )
				EndIf
				Sleep( 1000  )

			EndIf


			/**********************************************************************************************************************************/


			nX := nX + 1
			DbSelectArea("SE1")
			dbSkip()
			IncProc()
			nI := nI + 1
		EndDo
		//oPrint:Preview()     // Visualiza antes de imprimir
	Return nil

	/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  Impress ³ Autor ³ Microsiga             ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASERDO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	/*/
	Static Function Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
		LOCAL oFont8
		LOCAL oFont11c
		LOCAL oFont10
		LOCAL oFont14
		LOCAL oFont16n
		LOCAL oFont15
		LOCAL oFont14n
		LOCAL oFont24
		LOCAL nI := 0


		lBold := .t.
		lUnder := .t.
		lItalic := .t.
		lNotBold := .f.
		lNotUnder := .f.
		lNotItalic := .f.

		//Parametros de TFont.New()
		//1.Nome da Fonte (Windows)
		//3.Tamanho em Pixels
		//5.Bold (T/F)
		oFont8   := TFont():New("Arial",,8,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont12  := TFont():New("Arial",,12,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont11c := TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont11  := TFont():New("Arial",,11,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont10  := TFont():New("Arial",,10,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont9   := TFont():New("Arial",,9,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont14  := TFont():New("Arial",,14,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont20  := TFont():New("Arial",,20,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont25  := TFont():New("Arial",,25,,lBold, , , , ,lNotUnder, lNotItalic)
		oFont18  := TFont():New("Arial",,18,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont21  := TFont():New("Arial",,21,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont16n := TFont():New("Arial",,16,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont15  := TFont():New("Arial",,15,.T.,.T.,5,.T.,5,.T.,.F.)
		oFont15n := TFont():New("Arial",,15,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont13n := TFont():New("Arial",,13,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont14n := TFont():New("Arial",,14,.T.,.F.,5,.T.,5,.T.,.F.)
		oFont24  := TFont():New("Arial",,24,.T.,.T.,5,.T.,5,.T.,.F.)

		oPrint:StartPage()   // Inicia uma nova página

		nRow2 := -350

		oPrint:Line (nRow2+0650,100,nRow2+0650,2300)
		oPrint:Line (nRow2+0650,500,nRow2+0570, 500)
		oPrint:Line (nRow2+0650,710,nRow2+0570, 710)
		//Lucas Miranda de Aguiar - 25/05/2020
		If AllTrim(aDadosBanco[1]) == "033"
			oPrint:SayBitmap(nRow2+0530,100,"lgrsantander.jpg",384,102)
		ElseIf AllTrim(aDadosBanco[1]) == "237"
			oPrint:SayBitmap(nRow2+0530,100,"lgrbradesco.jpg",384,102)
		ElseIf AllTrim(aDadosBanco[1]) == "341"
			oPrint:SayBitmap(nRow2+0530,100,"lgritau.jpg",384,102)
		EndIf
		//oPrint:Say  (nRow2+0630,100,aDadosBanco[2],oFont20 )		// [2]Nome do Banco
		//Fim
		oPrint:Say  (nRow2+0630,513,aDadosBanco[1]+"-2",oFont20 )	// [1]Numero do Banco
		oPrint:Say  (nRow2+0644,1800,"Recibo do Pagador",oFont10)

		oPrint:Line (nRow2+0810-60,100,nRow2+0810-60,2300 )
		oPrint:Line (nRow2+0910-60,100,nRow2+0910-60,2300 )
		oPrint:Line (nRow2+0980-60,100,nRow2+0980-60,2300 )
		oPrint:Line (nRow2+1050-60,100,nRow2+1050-60,2300 )

		oPrint:Line (nRow2+0910-60,500,nRow2+1050-60,500)
		oPrint:Line (nRow2+0980-60,750,nRow2+1050-60,750)
		oPrint:Line (nRow2+0910-60,1000,nRow2+1050-60,1000)
		oPrint:Line (nRow2+0910-60,1300,nRow2+0980-60,1300)
		oPrint:Line (nRow2+0910-60,1480,nRow2+1050-60,1480)

		oPrint:Say  (nRow2+0710-30,100 ,"Local de Pagamento",oFont12)
		//oPrint:Say  (nRow2+0745,200 ,"PAGÁVEL PREFERENCIALMENTE NAS AGÊNCIAS BRADESCO OU NO BANCO POSTAL.",oFont10)
		//Lucas Miranda de Aguiar	-	25/05/2020
		oPrint:Say  (nRow2+0745-30,200 ,"PAGÁVEL PREFERENCIALMENTE NAS AGÊNCIAS " +aDadosBanco[2]+ ".",oFont10)
		//Fim

		oPrint:Say  (nRow2+0710-30,1810,"Vencimento"                                     ,oFont12)
		cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
		nCol := 1810+(374-(len(cString)*22))
		oPrint:Say  (nRow2+0750-30,nCol,cString,oFont11c)

		oPrint:Say  (nRow2+0810-30,100 ,"Beneficiário"                                        ,oFont12)
		oPrint:Say  (nRow2+0830-30,100 ,alltrim(aDadosEmp[1])+" - "+aDadosEmp[6]	,oFont9) //Nome + CNPJ
		oPrint:Say  (nRow2+0870-30,100 ,alltrim(aDadosEmp[2])+" - "+alltrim(aDadosEmp[8])+" - "+alltrim(aDadosEmp[3])+" - "+alltrim(aDadosEmp[4]))

		oPrint:Say  (nRow2+0810-30,1810,"Agência/Código Beneficiário",oFont12)

		/*
	if cEmpAnt = "08"
   cString := Alltrim("0"+aDadosBanco[3]+"-3"+"/"+"0"+aDadosBanco[4]+"-"+aDadosBanco[5])
	elseif cEmpAnt $ "17/19/60"
   cString := Alltrim("0"+aDadosBanco[3]+"-3"+"/"+"0"+StrZero(Val(SA6->A6_NUMCON),7)+"-"+SA6->A6_DVCTA)
	else
   cString := Alltrim("0"+aDadosBanco[3]+"-3"+"/"+"0"+aDadosBanco[4]+aDadosBanco[5])
	endif
		*/
		If AllTrim(aDadosBanco[1]) == "033"
			cString := cConv
		Else
			cString := Alltrim(aDadosBanco[3]+"/"+StrZero(val(aDadosBanco[4]),8)+"-"+aDadosBanco[5])
		EndIf
		nCol := 1810+(416-(len(cString)*22))
		oPrint:Say  (nRow2+0850-30,nCol,cString,oFont11c)

		oPrint:Say  (nRow2+0910-30,100 ,"Data do Documento"                              ,oFont12)
		oPrint:Say  (nRow2+0940-30,100, StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4),oFont10)

		oPrint:Say  (nRow2+0910-30,505 ,"Nro.Documento"                                  ,oFont12)
		If AllTrim(aDadosTit[13]) == ""
			oPrint:Say  (nRow2+0940-30,605 ,aDadosTit[7]+aDadosTit[1]						  ,oFont10) //Prefixo +Numero+Parcela
		Else
			oPrint:Say  (nRow2+0940-30,580 ,"Nota fiscal: " +aDadosTit[13]+ " Serie: " + aDadosTit[14]						  ,oFont10) //Numero da nota fiscal
		EndIf
		oPrint:Say  (nRow2+0910-30,1005,"Espécie Doc."                                   ,oFont12)
		oPrint:Say  (nRow2+0940-30,1050,aDadosTit[8]									  ,oFont10) //Tipo do Titulo

		oPrint:Say  (nRow2+0910-30,1305,"Aceite"                                         ,oFont12)
		oPrint:Say  (nRow2+0940-30,1400,"N"                                             ,oFont10)

		oPrint:Say  (nRow2+0910-30,1485,"Data do Processamento"                          ,oFont12)
		oPrint:Say  (nRow2+0940-30,1550,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4),oFont10) // Data impressao

		oPrint:Say  (nRow2+0910-30,1810,"Nosso Número"                                   ,oFont12)
		If AllTrim(aDadosBanco[1]) == "033"
			cString := Alltrim(aDadosTit[6])
		else
			cString := Alltrim(Substr(aDadosTit[6],1,2)+"/"+Substr(aDadosTit[6],3,11)+"-"+Substr(aDadosTit[6],14,1))
		EndIf
		nCol := 1810+(374-(len(cString)*22))
		//cString := Alltrim(Substr(aDadosBanco[6],1,2)+"/"+Substr(aDadosTit[6],4))
		//nCol := 1810+(374-(len(cString)*22))
		oPrint:Say  (nRow2+0940-30,nCol,cString,oFont11c)

		oPrint:Say  (nRow2+0980-30,100,"Uso do Banco"                                   ,oFont12)
		//oPrint:Say  (nRow2+1010,180,"08650",oFont10)

		oPrint:Say  (nRow2+0980-30,505 ,"Carteira"                                       ,oFont12)
		oPrint:Say  (nRow2+1010-30,555 ,aDadosBanco[6]                                  	,oFont10)

		oPrint:Say  (nRow2+0980-30,755 ,"Espécie"                                        ,oFont12)
		oPrint:Say  (nRow2+1010-30,805 ,"R$"                                             ,oFont10)

		oPrint:Say  (nRow2+0980-30,1005,"Quantidade"                                     ,oFont12)
		oPrint:Say  (nRow2+0980-30,1485,"Valor"                                          ,oFont12)

		oPrint:Say  (nRow2+0980-30,1810,"Valor do Documento"                          	,oFont12)
		cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
		nCol := 1810+(374-(len(cString)*22))
		oPrint:Say  (nRow2+1010-30,nCol,cString ,oFont11c)

		oPrint:Say  (nRow2+1050-30,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do beneficiário)",oFont12)
		// >> PH - 07/03/2008
		//oPrint:Say  (nRow2+1150,100 ,aBolText[1]+" "+AllTrim(Transform(aDadosTit[9],"@E 99,999.99")) ,oFont10)
		oPrint:Say  (nRow2+1100-30,100 ,aBolText[1] ,oFont10) //oFont10 //+" "+AllTrim(Transform(aDadosTit[9],"@E 99,999.99") + " PARA CADA DIA DE ATRASO")
		// << PH - 07/03/2008

		oPrint:Say  (nRow2+1150-30,100 ,aBolText[2] ,oFont10)
		oPrint:Say  (nRow2+1200-30,100 ,aBolText[3] ,oFont10)
		oPrint:Say  (nRow2+1250-30,100 ,aBolText[4] ,oFont10)
		oPrint:Say  (nRow2+1300-30,100 ,aBolText[5] ,oFont10)

		// >> PH - 07/03/2008
		// oPrint:Say  (nRow2+1250,100 ,_cXXOBS                                        ,oFont10)
		// << PH - 07/03/2008

		oPrint:Say  (nRow2+1050-30,1810,"(-)Desconto/Abatimento"                         ,oFont12)
		oPrint:Say  (nRow2+1120-30,1810,"(+)Juros"                             ,oFont12)
		oPrint:Say	(nRow2+1150-30,1810,Alltrim(Transform(aDadosTit[11],"@E 99,999,999.99")),oFont12)

		oPrint:Say  (nRow2+1190-30,1810,"(+)Mora/Multa"                                  ,oFont12)

		//cString := Alltrim(Transform(aDadosTit[10],"@E 99,999,999.99"))
		//nCol := 1810+(374-(len(cString)*22))
		//oPrint:Say  (nRow2+1220-30,nCol,cString ,oFont11c)

		oPrint:Say  (nRow2+1260-30,1810,"(+)Outros Acréscimos"                           ,oFont12)

		oPrint:Say  (nRow2+1330-30,1810,"(=)Valor Cobrado"                               ,oFont12)
		oPrint:Say  (nRow2+1360-30,1810,Transform(_nValor+aDadosTit[11],"@E 99,999,999.99"),oFont12)
		//cString := Alltrim(Transform(aDadosTit[10]+aDadosTit[5],"@E 99,999,999.99"))
		//nCol := 1810+(374-(len(cString)*22))
		//oPrint:Say  (nRow2+1360-30,nCol,cString ,oFont11c)

		if aDatSacado[8] = "J" .or. empty(aDatSacado[8])
			cDocSacado := "CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99") // CGC
		Else
			cDocSacado := "CPF: "+TRANSFORM(aDatSacado[7],"@R 999.999.999-99") // CPF
		EndIf
		oPrint:Say  (nRow2+1400-30,100 ,"Pagador"                                         ,oFont12)
		oPrint:Say  (nRow2+1430-30,400 ,aDatSacado[1], oFont10)
		oPrint:Say  (nRow2+1483-30,400 ,cDocSacado+" ("+aDatSacado[2]+")" ,oFont10)
		oPrint:Say  (nRow2+1536-30,400 ,aDatSacado[3]                                    ,oFont10)
		oPrint:Say  (nRow2+1589-30,400 ,alltrim(aDatSacado[4])+" - "+aDatSacado[5]+" - "+aDatSacado[6],oFont10) // Cidade+Estado+CEP

		//oPrint:Say  (nRow2+1605-30,1850,Alltrim(Substr(aDadosTit[6],1,2)+"/"+Substr(aDadosTit[6],3,11)+"-"+Substr(aDadosTit[6],14,1)),oFont10)

		oPrint:Say  (nRow2+1645-30,100 ,"Pagador/Avalista",oFont12)
		oPrint:Say  (nRow2+1685-30,1500,"Autenticação Mecânica",oFont12)

		oPrint:Line (nRow2+0710-60,1800,nRow2+1400-60,1800 )
		oPrint:Line (nRow2+1120-60,1800,nRow2+1120-60,2300 )
		oPrint:Line (nRow2+1190-60,1800,nRow2+1190-60,2300 )
		oPrint:Line (nRow2+1260-60,1800,nRow2+1260-60,2300 )
		oPrint:Line (nRow2+1330-60,1800,nRow2+1330-60,2300 )
		oPrint:Line (nRow2+1400-60,100 ,nRow2+1400-60,2300 )

		oPrint:Line (nRow2+1640-60,100 ,nRow2+1640-60,2300 )


		/******************/
		/* TERCEIRA PARTE */
		/******************/

		nRow3 := -350

		For nI := 100 to 2300 step 50
			oPrint:Line(nRow3+1880-60, nI, nRow3+1880-60, nI+30)
		Next nI

		oPrint:Line (nRow3+2000-60,100,nRow3+2000-60,2300)
		oPrint:Line (nRow3+2000-60,500,nRow3+1920-60, 500)
		oPrint:Line (nRow3+2000-60,710,nRow3+1920-60, 710)
		//Lucas Miranda de Aguiar - 25/05/2020
		//oPrint:Say  (nRow3+1934-30,100,aDadosBanco[2],oFont20 )		// 	[2]Nome do Banco
		If AllTrim(aDadosBanco[1]) == "033"
			oPrint:SayBitmap(nRow2+1865-30,100,"lgrsantander.jpg",384,102)
		ElseIf AllTrim(aDadosBanco[1]) == "237"
			oPrint:SayBitmap(nRow2+1865-30,100,"lgrbradesco.jpg",384,102)
		ElseIf AllTrim(aDadosBanco[1]) == "341"
			oPrint:SayBitmap(nRow2+1865-30,100,"lgritau.jpg",384,102)
		EndIf
		//Fim
		oPrint:Say  (nRow3+1934-30,513,aDadosBanco[1]+"-2",oFont20 )	// 	[1]Numero do Banco
		oPrint:Say  (nRow3+1934-30,755,aCB_RN_NN[2],oFont15n)			//	Linha Digitavel do Codigo de Barras

		oPrint:Line (nRow3+2100-60,100,nRow3+2100-60,2300 )
		oPrint:Line (nRow3+2200-60,100,nRow3+2200-60,2300 )
		oPrint:Line (nRow3+2270-60,100,nRow3+2270-60,2300 )
		oPrint:Line (nRow3+2340-60,100,nRow3+2340-60,2300 )

		oPrint:Line (nRow3+2200-60,500 ,nRow3+2340-60,500 )
		oPrint:Line (nRow3+2270-60,750 ,nRow3+2340-60,750 )
		oPrint:Line (nRow3+2200-60,1000,nRow3+2340-60,1000)
		oPrint:Line (nRow3+2200-60,1300,nRow3+2270-60,1300)
		oPrint:Line (nRow3+2200-60,1480,nRow3+2340-60,1480)

		oPrint:Say  (nRow3+2000-30,100 ,"Local de Pagamento",oFont12)
		//Lucas Miranda de Aguiar - 25/05/2020
		oPrint:Say  (nRow3+2035-30,200 ,"PAGÁVEL PREFERENCIALMENTE NAS AGÊNCIAS " + aDadosBanco[2] + ".",oFont10)
		//Fim
		oPrint:Say  (nRow3+2000-30,1810,"Vencimento",oFont12)
		cString := StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
		nCol	 	 := 1810+(374-(len(cString)*22))
		oPrint:Say  (nRow3+2040-30,nCol,cString,oFont11c)

		oPrint:Say  (nRow3+2100-30,100 ,"Beneficiário",oFont12)
		oPrint:Say  (nRow3+2120-30,100 ,AllTrim(aDadosEmp[1])+" - "+aDadosEmp[6],oFont9) //Nome + CNPJ
		oPrint:Say  (nRow3+2160-30,100 ,alltrim(aDadosEmp[2])+" - "+alltrim(aDadosEmp[8])+" - "+alltrim(aDadosEmp[3])+" - "+alltrim(aDadosEmp[4]))

		oPrint:Say  (nRow3+2100-30,1810,"Agência/Código Beneficiário",oFont12)

		/*
	if cEmpAnt = "08"
   cString := Alltrim("0"+aDadosBanco[3]+"-3"+"/"+"0"+aDadosBanco[4]+"-"+aDadosBanco[5])
	elseif cEmpAnt $ "17/19/60"
   cString := Alltrim("0"+aDadosBanco[3]+"-3"+"/"+"0"+StrZero(Val(SA6->A6_NUMCON),7)+"-"+SA6->A6_DVCTA)
	else
   cString := Alltrim("0"+aDadosBanco[3]+"-3"+"/"+"0"+aDadosBanco[4]+aDadosBanco[5])
	endif
		*/
		If AllTrim(aDadosBanco[1]) == "033"
			cString := AllTrim(aDadosBanco[3])+"/"+fRetConv(aDadosBanco,cAgSantan)
		Else
			cString := Alltrim(aDadosBanco[3]+"/"+StrZero(val(aDadosBanco[4]),8)+"-"+aDadosBanco[5])
		EndIf

		nCol 	 := 1810+(416-(len(cString)*22))
		oPrint:Say  (nRow3+2140-30,nCol,cString ,oFont11c)


		oPrint:Say  (nRow3+2200-30,100 ,"Data do Documento"                              ,oFont12)
		oPrint:Say (nRow3+2230-30,100, StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4), oFont10)


		oPrint:Say  (nRow3+2200-30,505 ,"Nro.Documento"                                  ,oFont12)

		If AllTrim(aDadosTit[13]) == ""
			oPrint:Say  (nRow3+2230-30,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
		Else
			oPrint:Say  (nRow3+2230-30,580 ,"Nota fiscal: " +aDadosTit[13]+ " Serie: " + aDadosTit[14]						  ,oFont10) //Numero da nota fiscal
		EndIf


		oPrint:Say  (nRow3+2200-30,1005,"Espécie Doc."                                   ,oFont12)
		oPrint:Say  (nRow3+2230-30,1050,aDadosTit[8]										,oFont10) //Tipo do Titulo

		oPrint:Say  (nRow3+2200-30,1305,"Aceite"                                         ,oFont12)
		oPrint:Say  (nRow3+2230-30,1400,"N"                                             ,oFont10)

		oPrint:Say  (nRow3+2200-30,1485,"Data do Processamento"                          ,oFont12)
		oPrint:Say  (nRow3+2230-30,1550,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4)                               ,oFont10) // Data impressao


		oPrint:Say  (nRow3+2200-30,1810,"Nosso Número"                                   ,oFont12)
		If AllTrim(aDadosBanco[1]) == "033"
			cString := Alltrim(aDadosTit[6])
		else
			cString := Alltrim(Substr(aDadosTit[6],1,2)+"/"+Substr(aDadosTit[6],3,11)+"-"+Substr(aDadosTit[6],14,1))
		EndIf
		nCol 	 	:= 1810+(374-(len(cString)*22))
		//cString 	:= Alltrim(Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4))
		//nCol 	 	:= 1810+(374-(len(cString)*22))
		oPrint:Say  (nRow3+2230-30,nCol,cString,oFont11c)


		oPrint:Say  (nRow3+2270-30,100,"Uso do Banco"                                   ,oFont12)
		//oPrint:Say  (nRow3+2300,195,"08650",oFont10)

		oPrint:Say  (nRow3+2270-30,505 ,"Carteira"                                       ,oFont12)
		oPrint:Say  (nRow3+2300-30,555 ,aDadosBanco[6]                                  	,oFont10)

		oPrint:Say  (nRow3+2270-30,755 ,"Espécie"                                        ,oFont12)
		oPrint:Say  (nRow3+2300-30,805 ,"R$"                                             ,oFont10)

		oPrint:Say  (nRow3+2270-30,1005,"Quantidade"                                     ,oFont12)
		oPrint:Say  (nRow3+2270-30,1485,"Valor"                                          ,oFont12)

		oPrint:Say  (nRow3+2270-30,1810,"Valor do Documento"                          	,oFont12)
		cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
		nCol 	 := 1810+(374-(len(cString)*22))
		oPrint:Say  (nRow3+2300-30,nCol,cString,oFont11c)

		oPrint:Say  (nRow3+2340-30,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do beneficiário)",oFont12)

		// >> PH - 07/03/2008
		//oPrint:Say  (nRow3+2440,100 ,aBolText[1]+" "+AllTrim(Transform(aDadosTit[9],"@E 99,999.99"))	,oFont10)
		oPrint:Say  (nRow3+2390-30,100 ,aBolText[1] ,oFont10) //oFont10 //+" "+AllTrim(Transform(aDadosTit[9],"@E 99,999.99") + " PARA CADA DIA DE ATRASO")
		// << PH - 07/03/2008


		oPrint:Say  (nRow3+2440-30,100 ,aBolText[2]	,oFont10)
		oPrint:Say  (nRow3+2490-30,100 ,aBolText[3]	,oFont10)
		oPrint:Say  (nRow3+2540-30,100 ,aBolText[4]	,oFont10)
		oPrint:Say  (nRow3+2590-30,100 ,aBolText[5]	,oFont10)

		// >> PH - 07/03/2008
		//oPrint:Say  (nRow2+2540,100 ,_cXXOBS                                        					,oFont10)
		// << PH - 07/03/2008

		oPrint:Say  (nRow3+2340-30,1810,"(-)Desconto/Abatimento"                         ,oFont12)
		oPrint:Say  (nRow3+2410-30,1810,"(+)Juros"                             ,oFont12)
		oPrint:Say  (nRow3+2440-30,1810,Alltrim(Transform(aDadosTit[11],"@E 99,999,999.99")),oFont12)

		oPrint:Say  (nRow3+2480-30,1810,"(+)Mora/Multa"                                  ,oFont12)


		//cString := Alltrim(Transform(aDadosTit[10],"@E 99,999,999.99"))
		//nCol := 1810+(374-(len(cString)*22))
		//oPrint:Say  (nRow2+2510-30,nCol,cString ,oFont11c)

		oPrint:Say  (nRow3+2550-30,1810,"(+)Outros Acréscimos"                           ,oFont12)


		oPrint:Say  (nRow3+2620-30,1810,"(=)Valor Cobrado"                               ,oFont12)
		oPrint:Say  (nRow3+2650-30,1810,Transform(_nValor+aDadosTit[11],"@E 99,999,999.99"),oFont12)
		//cString := Alltrim(Transform(aDadosTit[10]+aDadosTit[5],"@E 99,999,999.99"))
		//nCol := 1810+(374-(len(cString)*22))
		//oPrint:Say  (nRow2+2650-30,nCol,cString ,oFont11c)

		if aDatSacado[8] = "J" .or. empty(aDatSacado[8])
			cDocSacado := "CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99") // CGC
		Else
			cDocSacado := "CPF: "+TRANSFORM(aDatSacado[7],"@R 999.999.999-99") // CPF
		EndIf
		oPrint:Say  (nRow3+2690-30,100 ,"Pagador"                                         ,oFont12)
		oPrint:Say  (nRow3+2700-30,400 ,aDatSacado[1], oFont10)
		oPrint:Say  (nRow3+2753-30,400 ,cDocSacado+" ("+aDatSacado[2]+")", oFont10)
		oPrint:Say  (nRow3+2806-30,400 ,aDatSacado[3]                                    ,oFont10)
		oPrint:Say  (nRow3+2859-30,400 ,alltrim(aDatSacado[4])+" - "+aDatSacado[5]+" - "+aDatSacado[6],oFont10) // CEP+Cidade+Estado

		//oPrint:Say  (nRow3+2912-30,1750,Alltrim(Substr(aDadosTit[6],1,2)+"/"+Substr(aDadosTit[6],3,11)+"-"+Substr(aDadosTit[6],14,1)),oFont10)

		oPrint:Say  (nRow3+2952-30,100 ,"Pagador/Avalista"                               ,oFont12)
		oPrint:Say  (nRow3+2992-30,1500,"Autenticação Mecânica - Ficha de Compensação"                        ,oFont12)

		oPrint:Line (nRow3+2000-60,1800,nRow3+2690-60,1800 )
		oPrint:Line (nRow3+2410-60,1800,nRow3+2410-60,2300 )
		oPrint:Line (nRow3+2480-60,1800,nRow3+2480-60,2300 )
		oPrint:Line (nRow3+2550-60,1800,nRow3+2550-60,2300 )
		oPrint:Line (nRow3+2620-60,1800,nRow3+2620-60,2300 )
		oPrint:Line (nRow3+2690-60,100 ,nRow3+2690-60,2300 )

		oPrint:Line (nRow3+2942-60,100,nRow3+2942-60,2300  )

		//MSBAR("INT25",16,1,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.014,1,Nil,Nil,"A",.F.) //,0.025,1.5,
		//MSBAR         ("INT25",20  ,1.6,aCB_RN_NN[1] ,oPrint,.F.,Nil,Nil,0.028,1,Nil,Nil,"A",.F.) //,0.025,1.5,
		oPrint:FWMSBAR("INT25",65,1.6,aCB_RN_NN[1] ,oPrint,.F.,   ,.T.,0.018,1,   ,   ,"A",.F.)
		//MSBAR("INT25",66.5,1.6,aDadosTit[10],oPrint,.F.,   ,.T.,0.028,1,   ,   ,"A",.F.)

		/*For nI := 050 to 2500 step 50
	oPrint:Line(nRow3+3200, nI, nRow3+3200, nI+15)
		Next nI*/


		/*DbSelectArea("SEE")
SEE->(RecLock("SEE",.F.))
_NextSEE := soma1(substr(aCB_RN_NN[3],3,11))  // Incrementa 1 na faixa de nosso numero.
SEE->EE_FAXATU := _NextSEE
SEE->(MsUnlock())

DbSelectArea("SE1")
se1->(RecLock("SE1",.f.))
SE1->E1_NUMBCO 	:=	aCB_RN_NN[3]   // Nosso número (Ver fórmula para calculo)
se1->(MsUnlock())
		*/


		oPrint:EndPage() // Finaliza a página

	Return Nil



	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³RetDados  ºAutor  ³Microsiga           º Data ³  02/13/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera SE1                        					          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BOLETOS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	*/
	User Function Ret_cBarra(	cPrefixo, cNumero, cParcela, cTipo,;
			cBanco,   cAgencia, cConta, cDacCC,;
			cNroDoc, nValor, cCart, cMoeda)

		Local cNosso		:= ""
		Local cDigNosso		:= ""
		//Local NNUM			:= ""
		Local cCampoL		:= ""
		Local cFatorValor	:= ""
		Local cLivre		:= ""
		Local cDigBarra		:= ""
		Local cBarra		:= ""
		Local cParte1		:= ""
		Local cDig1			:= ""
		Local cParte2		:= ""
		Local cDig2			:= ""
		Local cParte3		:= ""
		Local cDig3			:= ""
		Local cParte4		:= ""
		Local cParte5		:= ""
		Local cDigital		:= ""
		Local aRet			:= {}

		//DEFAULT nValor := 0

		cAgencia:=STRZERO(Val(cAgencia),4)
		cNosso := ""
		NNUM := STRZERO(Val(cNroDoc),11)

		//Nosso Numero
		cDigNosso  	:= CALC_di7(NNUM)
		cNosso     	:= cCart + NNUM + cDigNosso

		// campo livre			// verificar a conta e carteira
		//			cCampoL := cNosso+substr(e1_agedep,1,4)+STRZERO(VAL(e1_conta),8)+'18'
		//cCampoL := NNUM+cAgencia+StrZero(Val(cConta),8)+cCart
		cCampoL := cAgencia+cCart+NNUM+StrZero(Val(cConta),7)+"0"

		//campo livre do codigo de barra                   // verificar a conta
		If nValor > 0
			cFatorValor  := fator()+strzero(nValor*100,10)
		Else
			cFatorValor  := fator()+strzero(SE1->E1_SALDO*100,10)
		Endif

		cLivre := cBanco+cMoeda+cFatorValor+cCampoL

		// campo do codigo de barra
		cDigBarra := CALC_5p( cLivre )
		cBarra    := Substr(cLivre,1,4)+cDigBarra+Substr(cLivre,5,40)

		// composicao da linha digitavel
		cParte1  := cBanco+cMoeda
		cParte1  := cParte1 + SUBSTR(cCampoL,1,5)
		cDig1    := fDAC(cParte1,2)
		cParte2  := SUBSTR(cCampoL,6,10)
		cDig2    := fDAC(cParte2,1)
		cParte3  := SUBSTR(cCampoL,16,10)
		cDig3    := fDAC(cParte3,1)
		cParte4  := " "+cDigBarra+" "
		cParte5  := cFatorValor

		cDigital := substr(cParte1,1,5)+"."+substr(cparte1,6,4)+cDig1+" "+;
			substr(cParte2,1,5)+"."+substr(cparte2,6,5)+cDig2+" "+;
			substr(cParte3,1,5)+"."+substr(cparte3,6,5)+cDig3+" "+;
			cParte4+;
			cParte5

		Aadd(aRet,cBarra)
		Aadd(aRet,cDigital)
		Aadd(aRet,cNosso)

		Mar := ""
	Return aRet

	*----------------------------------*
	Static Function fDAC(cConteudo,nIni)
		*----------------------------------*
		Local aMult  := If( nIni==1 , { 1 , 2 } , { 2 , 1 } )
		Local cDAC   := ""
		Local nCalc  := 0
		Local nTotal := 0
		For nDig := 1 To Len(cConteudo)
			nCalc  := Val(SubStr(cConteudo,nDig,1)) * aMult[If(Mod(nDig,2) != 0, 1 , 2 )]
			nCalc  -= If(nCalc >= 10,9,0)
			nTotal += nCalc
		Next nDig
		If Mod(nTotal,10) == 0
			nCalc := 0
			//For nDig := 1 To Len(StrZero(nTotal,6))
			//    nCalc += Val(SubStr(StrZero(nTotal,6),nDig,1))
			//Next nDig
			cDAC := AllTrim(Str(nCalc,6))
		Else
			cDAC := AllTrim(Str(((Val(Left(AllTrim(StrZero(nTotal,2)),1))+1)*10) - nTotal,6))
		EndIf
	Return(cDAC)

	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³FATOR		ºAutor  ³Microsiga           º Data ³  02/13/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calculo do FATOR  de vencimento para linha digitavel.       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BOLETOS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	*/
	Static Function Fator()
		If Len(ALLTRIM(SUBSTR(DTOC(SE1->E1_VENCTO),7,4))) = 4
			cData := SUBSTR(DTOC(SE1->E1_VENCTO),7,4)+SUBSTR(DTOC(SE1->E1_VENCTO),4,2)+SUBSTR(DTOC(SE1->E1_VENCTO),1,2)
		Else
			cData := "20"+SUBSTR(DTOC(SE1->E1_VENCTO),7,2)+SUBSTR(DTOC(SE1->E1_VENCTO),4,2)+SUBSTR(DTOC(SE1->E1_VENCTO),1,2)
		EndIf
		cFator := STR(1000+(STOD(cData)-STOD("20000703")),4)
	Return(cFator)


	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³CALC_5p   ºAutor  ³Microsiga           º Data ³  02/13/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calculo do digito do nosso numero do                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BOLETOS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	*/
	Static Function CALC_5p(cVariavel)
		Local Auxi := 0, sumdig := 0

		cbase  := cVariavel
		lbase  := LEN(cBase)
		base   := 2
		sumdig := 0
		Auxi   := 0
		iDig   := lBase
		While iDig >= 1
			If base >= 10
				base := 2
			EndIf
			auxi   := Val(SubStr(cBase, idig, 1)) * base
			sumdig := SumDig + auxi
			base   := base + 1
			iDig   := iDig - 1
		EndDo
		auxi := mod(sumdig,11)
		If auxi == 0 .or. auxi == 1 .or. auxi >= 10
			auxi := 1
		Else
			auxi := 11 - auxi
		EndIf

	Return(str(auxi,1,0))


	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³CALC_di7  ºAutor  ³Microsiga           º Data ³  02/13/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Para calculo do nosso numero do banco do brasil             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BOLETOS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	*/
	Static Function CALC_di7(cVariavel)
		Local Auxi := 0, sumdig := 0
		//cbase  := "09"+cVariavel
		cbase  := _cCart+cVariavel
		lbase  := LEN(cBase)
		base   := 2
		sumdig := 0
		Auxi   := 0
		iDig   := lBase
		//While iDig >= 2
		For _nIx := 1 to iDig
			If base == 1
				base := 7
			EndIf
			//	auxi   := Val(SubStr(cBase, idig, 1)) * base
			auxi   := Val(SubStr(cBase, _nIx, 1)) * base
			sumdig := SumDig+auxi
			base   := base - 1
		Next _nIx
		//EndDo
		auxi := mod(Sumdig,11)  //Resto
		auxi := 11 - auxi

		If auxi == 10
			auxi := "P"
		ElseIf auxi == 11
			auxi := 0
			auxi := str(auxi,1,0)
		Else
			auxi := str(auxi,1,0)
		EndIf

	Return(auxi)



	Static Function ValidPerg()

		Local _sAlias := Alias()
		Local aRegs := {}
		Local i,j

		dbSelectArea("SX1")
		dbSetOrder(1)
		cPerg := PADR(cPerg,10)//6)

		aRegs	:= {}
		//	Aadd(aRegs,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO", "TAMANHO", "DECIMAL","GSC","VAR01"   ,"F3" ,"DEF01","DEF02","DEF03","DEF04","DEF05"})
		Aadd(aRegs,{ cPerg ,"01"   ,"Prefixo de          ", "","","mv_ch1" ,"C"   , 03       , 0, 0        ,"G"  , "","mv_par01",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"02"   ,"Prefixo ate         ", "","","mv_ch2" ,"C"   , 03       , 0, 0        ,"G"  , "","mv_par02",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"03"   ,"Numero de           ", "","","mv_ch3" ,"C"   , 09       , 0, 0        ,"G"  , "","mv_par03",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"04"   ,"Numero ate          ", "","","mv_ch4" ,"C"   , 09       , 0, 0        ,"G"  , "","mv_par04",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"05"   ,"Parcela de          ", "","","mv_ch5" ,"C"   , 01       , 0, 0        ,"G"  , "","mv_par05",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"06"   ,"Parcela ate         ", "","","mv_ch6" ,"C"   , 01       , 0, 0        ,"G"  , "","mv_par06",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"07"   ,"Portador de         ", "","","mv_ch7" ,"C"   , 03       , 0, 0        ,"G"  , "","mv_par07",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"08"   ,"Portador ate        ", "","","mv_ch8" ,"C"   , 03       , 0, 0        ,"G"  , "","mv_par08",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"09"   ,"Cliente de          ", "","","mv_ch9" ,"C"   , 06       , 0, 0        ,"G"  , "","mv_par09",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "","SA1", "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"10"   ,"Cliente ate         ", "","","mv_cha" ,"C"   , 06       , 0, 0        ,"G"  , "","mv_par10",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "","SA1", "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"11"   ,"Loja de             ", "","","mv_chb" ,"C"   , 02       , 0, 0        ,"G"  , "","mv_par11",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"12"   ,"Loja ate            ", "","","mv_chc" ,"C"   , 02       , 0, 0        ,"G"  , "","mv_par12",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"13"   ,"Emissao de          ", "","","mv_chd" ,"D"   , 08       , 0, 0        ,"G"  , "","mv_par13",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"14"   ,"Emissao ate         ", "","","mv_che" ,"D"   , 08       , 0, 0        ,"G"  , "","mv_par14",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"15"   ,"Vencimento de       ", "","","mv_chf" ,"D"   , 08       , 0, 0        ,"G"  , "","mv_par15",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"16"   ,"Vencimento ate      ", "","","mv_chg" ,"D"   , 08       , 0, 0        ,"G"  , "","mv_par16",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"17"   ,"Bordero de          ", "","","mv_chh" ,"C"   , 06       , 0, 0        ,"G"  , "","mv_par17",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"18"   ,"Bordero ate         ", "","","mv_chi" ,"C"   , 06       , 0, 0        ,"G"  , "","mv_par18",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"19"   ,"Reprocessa          ", "","","mv_chj" ,"N"   , 01       , 0, 0        ,"C"  , "","mv_par19","Sim"  , "", "", "", "","Nao"  ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"20"   ,"Banco               ", "","","mv_chk" ,"C"   , 03       , 0, 0        ,"G"  , "","mv_par20",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "","SA6", "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"21"   ,"Agencia             ", "","","mv_chl" ,"C"   , 05       , 0, 0        ,"G"  , "","mv_par21",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"22"   ,"Conta               ", "","","mv_chm" ,"C"   , 10       , 0, 0        ,"G"  , "","mv_par22",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"23"   ,"Sub-Conta           ", "","","mv_chn" ,"C"   , 03       , 0, 0        ,"G"  , "","mv_par23",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
		Aadd(aRegs,{ cPerg ,"24"   ,"Envia email		 ", "","","mv_chj" ,"N"   , 01       , 0, 0        ,"C"  , "","mv_par24","Sim"  , "", "", "", "","Nao"  ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })

		For i:=1 to Len(aRegs)
			If !dbSeek(cPerg+aRegs[i,2])
				RecLock("SX1",.T.)
				For j:=1 to FCount()
					If j <= Len(aRegs[i])
						FieldPut(j,aRegs[i,j])
					Endif
				Next
				MsUnlock()
			Endif
		Next
		dbSelectArea(_sAlias)

	Return

	///////////////////////////
	Static Function CalcAbat()
		Local cSql

		cSql := "SELECT SUM(E1_SALDO) as Total FROM " + RetSqlName("SE1")
		cSql += " WHERE D_E_L_E_T_ = '' AND E1_NUM = '" + SE1->E1_NUM + "' AND E1_PREFIXO = '" + SE1->E1_PREFIXO + "' AND E1_PARCELA = '" + SE1->E1_PARCELA
		cSql += "' AND E1_TIPO IN ('IN-','IS-','CF-','CS-','IR-','PI-','AB-') AND E1_CLIENTE = '" + SE1->E1_CLIENTE + "' AND E1_LOJA = '" + SE1->E1_LOJA + "'"

		TcQuery cSql alias TotRef new
		nTotRet = TotRef->Total
		TotRef->(dbclosearea())
	Return nTotRet

	Static Function fEnvBolMail()

		Local cTitulo := "Boleto de Cobrança"
		Local cBody   := ""
		Local cMailTo := ""
		Local cMailCC := ""
		Local aAnexo  := {}
		Local cGuardaLoc := "C:\TEMP\"
		Local cGuardaServ := "\system\"
		Local cNomeRel    := __cAux

		cBody := '<body style="font-family: arial;font-size: 12px;">'
		cBody += '	<h4>Boleto de Cobrança</h4>'
		cBody += '	<br>'
		cBody += '	<font color="red">'
		cBody += '		Atenção: Este e-mail foi gerado automaticamente. Favor não respondê-lo.'
		cBody += '	</font>'
		cBody += '	<br><br>'
		cBody += '	Prezado(a) <b>'+AllTrim(SA1->A1_NOME)+'</b>''
		cBody += '	<br>'
		cBody += '	Conforme acordado enviamos em anexo boleto(s) bancário(s) para pagamento'
		cBody += '	<br><br>'
		cBody += '	Em caso de dúvidas ficamos à disposição para esclarecimentos:'
		cBody += '	<br><br>'
		cBody += '	<br><br>'
		cBody += '	Att,'
		cBody += '	<br>'
		cBody += '	<font color="red"><i>Unica</i></font>'
		cBody += '</body>'

		cMailTo 	:= AllTrim( SA1->A1_EMAIL )
		cMailCC 	:= ""
		CpyT2S(cGuardaLoc+cNomeRel+".pdf",cGuardaServ , .T. )
		aAdd( aAnexo, cGuardaServ + __cAux+".pdf")
		If !Empty(AllTrim(cMailTo))
			//U_RGRSendMail( "", cMailTo, cmailCC, "", cTitulo, cBody, aAnexo, .F., "UNIR011",,, )
			U_zEnvMail(cMailTo, cTitulo, cBody, aAnexo, .F., .T.)
		Else
			Aviso( "Atenção", "Não foi possível enviar o email, o usuário não possui email cadastrado.", { "Voltar" } )
		EndIf
		FERASE(cGuardaServ+cNomeRel+".pdf")

	Return

	Static Function fRetConv(aDadosBanco,cAgSantan)

		Local aArea := GetArea()
		Local cAliasSEE := GetNextAlias()
		Local cQuery := ""
		Local cRet 	:= ""




		cQuery := "		SELECT EE_CONVCOB  "
		cQuery += "		  FROM " + RetSQLName( "SEE" )
		cQuery += "		 WHERE D_E_L_E_T_ 	= ' ' "
		cQuery += "			AND EE_FILIAL = '"+XFilial("SEE")+"'"
		cQuery += "		   AND EE_CONVCOB 	<> ' ' "
		cQuery += "		   AND EE_CODIGO 	= '" +AllTrim(aDadosBanco[1]) + "'"
		cQuery += "		   AND EE_AGENCIA 	= '" +AllTrim(cAgSantan) + "'"
		cQuery += "		   AND EE_CONTA 	= '" +AllTrim(aDadosBanco[4]) + "'"

		If Select( cAliasSEE ) > 0
			( cAliasSEE )->( DbCloseArea() )
		EndIf
		TcQuery cQuery Alias ( cAliasSEE ) New
		If !( cAliasSEE )->( Eof() )
			cRet := Right(AllTrim(( cAliasSEE )->EE_CONVCOB),7)
		EndIf
		( cAliasSEE )->( DbCloseArea() )

		RestArea(aArea)
	Return cRet

	Static Function RCbSant(cPrefixo,cNumero,cParcela,cTipo  ,aDadosBanco   ,cNroDoc  ,nValor, dVencimen )

		Local aArea			:= GetArea()
		Local cNosso		:= ""
		Local cDVNosso		:= ""
		Local cDVNoss1		:= ""
		Local NNUM			:= ""
		Local cCampoL		:= ""
		Local cFatorValor	:= ""
		Local cLivre		:= ""
		Local cDigBarra		:= ""
		Local cBarra		:= ""
		Local cParte1		:= ""
		Local cDig1			:= ""
		Local cParte2		:= ""
		Local cDig2			:= ""
		Local cParte3		:= ""
		Local cDig3			:= ""
		Local cParte4		:= ""
		Local cParte5		:= ""
		Local cDigital		:= ""
		Local aRet			:= {}
		Local cBanco    	:= aDadosBanco [ 1 ]
		Local cAgencia  	:= aDadosBanco [ 3 ]
		Local cConta    	:= aDadosBanco [ 4 ]
		Local cCart     	:= aDadosBanco [ 6 ]
		Local c_fdig1
		Local c_fdig2
		Local Dvag        		//Digito Verificado da agencia

		cMoeda := "9"

		If nValor > 0
			cValor  := strzero(nValor*100,10)
		Else
			cValor  := strzero((Round((SE1->E1_SALDO+SE1->E1_ACRESC-nVlrAbat-SE1->E1_DECRESC),2))*100,10)
		Endif

		*----------------------------------------------------------------*
		* Posição(1 a 19) padrao do Codigo de barra para todos os bancos
		*----------------------------------------------------------------*

		cBarra :=  cBanco                // 341                       // 3  // 001  003
		cBarra +=  cMoeda                // 9                         // 1   // 004  004
		cBarra +=  u_fator()             // 1667  (01/05/2002'        // 4   // 006  009
		cBarra +=  cValor                // 0000012345 (123,45)       // 10  // 010  019


		*----------------------------------------------------------------*
		* Campo Livre do código de barra
		*----------------------------------------------------------------*

		Do Case
			/*
	Case cBanco  = "001"   //  Banco do BrASIL


		cCart          := "17/019"    // carteira chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*
		c_agctnos      := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + Substr(cCart,1,2) + cNroDoc
		c_dacacb       := U_DIGIT001( c_agctnos  )


		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Brasil
		*-------------------------------------------------------*
		//Tamanho       Inicio     Fim
		cBarra +=  STRZERO(Val(cNroDoc),11)	        // 11         // 020       030     Nosso numero
		cBarra +=  Substr(cAgencia ,1,4  )    	    // 04         // 031       034     agencia
		cBarra +=  PADL(Substr(cConta,1,4),8,"0" )  // 08         // 035       042     Conta
		cBarra +=  Substr(cCart,1,2      )          // 02         // 043       044     Carteira


		*-------------------------------------------------------------------------------------------*
		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco do Brasil
		*--------------------------------------------------------------------------------------------*

		cAgencia:=Substr(cAgencia ,1,4)+"-"+Substr(cAgencia ,5,1)+" /"
		cConta  :=Substr(cConta ,1,4)+"-"+Substr(cConta ,5,1)


		cDVNosso:= U_CALC_di9(cNroDoc)  					//Calculo do digito verificador do nosso numero
		cNosso   := Substr(cNroDoc,1,11)+"-"+cDVNosso   // Nosso numero + Digito Verificado


	Case cBanco  = '341'   // Itau

		cCart   := "109"    // chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + cCart + cNroDoc
		c_dacacb  := U_DIGIT001( c_agctnos  )
		cDVNosso  := c_dacacb

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Itau
		*-------------------------------------------------------*

		// Exemplo           //Tamanho   Inico     Fim
		cBarra +=  cCart  + cNroDoc + c_dacacb              		  // 109 52000072 3    //   12    // 020     031   Carteira + Nosso Numero + Digitao de cobrança
		cBarra +=  substr(cAgencia ,1,4)+Substr(cConta,1,6) 		  // 0496 327826       //   10    // 032     041   Agencia  + Conta
		cBarra +=  "000"                                                                   //   03    // 042     044



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:=cAgencia+" /"
		cConta  :=Substr(cConta ,1,5)+"-"+Substr(cConta ,6,1)

		cNosso   := cCart+"/"+cNroDoc+"-"+c_dacacb

	Case cBanco  = '347'    // sudameris

		cCart := "42"

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := U_DIGIT001( c_agctnos  )


		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Sudameris
		*-------------------------------------------------------*
		// Exemplo           Tamanho  Inicio   fim
		cBarra +=  substr(cAgencia ,1,4)+Substr(cConta,1,7) + c_dacacb         // 1675 1266561 1   // 12   // 020    031
		cBarra +=   PADL(Alltrim(cNroDoc),13,"0")                   		   // 0169977   	   // 13   // 032    044



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= cAgencia+" /"
		cConta  := AllTrim(cConta)+"/"+c_dacacb

		cNosso   := cNroDoc

	Case cBanco  = '237'   // Bradesco

		cCart := "02"    // chumbado

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Bradesco
		*-------------------------------------------------------*
		//Tamanho   inico  fim
		cBarra +=   substr(cAgencia ,1,4)       	// 4       // 20    23
		cBarra +=   cCart                     		// 2       // 24    25
		cBarra +=   PADL(Alltrim(cNroDoc),11,"0")  // 11      // 26    36
		cBarra +=   Substr(cConta,1,7)   	    	// 7       // 37    43
		cBarra +=   "0"                        		// 1       // 44    44



		* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= AllTrim(cAgencia)+" /"
		cConta	:= Alltrim(cConta)+"-P"   // Digito da Conta Chumdado conforme padrao do banco

		cDVNosso := u_Mod_11_2A7(cCart+Substr(cNroDoc,1,11))

		//Chumbado conforme padrao do banco
		If cDVNosso ='10'
			cDVNosso:= 'P'
		ElseIf cDVNosso ='11'
			cDVNosso:= '0'
		EndIf

		cNosso   := cCart+"/"+Substr(cNroDoc,1,11)+"-"+cDVNosso


	Case cBanco  = '422'   // Safra

		cCart    := "2"    // carteira chumbada de acordo c/ o banco

		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 5 )  + cCart + cNroDoc
		c_dacacb       := U_DIGIT001( c_agctnos  )


		//cDVNosso:= Modulo11(cNroDoc)
		cDVNosso := Mod11_422(cNroDoc)

		//If cDVNosso = '0'
		//cDVNosso:='1'
		//Endif


		//ElseIf cDVNosso = '1'
		//cDVNosso:='0'
		//EndIf


		//-------------------------------------------------------
		// Campo Livre do codigo de barra do banco do Safra
		//-------------------------------------------------------
		//Tamanho  Inicio  Fim
		cBarra +="7"  									  // 01  	// 20 	  20
		cBarra +=   Substr(cAgencia ,1,5)       		  // 05  	// 21	  25
		cBarra +=  PADL(Alltrim(cConta),9,"0")   		  // 09   	// 26 	  34
		cBarra +=  PADL(Alltrim(cNroDoc),8,"0")+cDVNosso  // 09  	// 35 	  43
		cBarra +=  cCart                         		  // 01  	// 44 	  44


		//---------------------------------------------------------------------------------
		// Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco
		//---------------------------------------------------------------------------------

		cAgencia:=AllTrim(cAgencia)+"-"


		cNosso  := cNroDoc+"-"+cDVNosso

	Case cBanco  = '409'   // UNIBANCO

		cCart    := "CAUCAO"    // chumbado

		cDtVenc	:=Substr(DToC(dVencimen),7,2)+Substr(DToC(dVencimen),4,2)+SubStr(DToC(dVencimen),1,2)


		cDVNosso:= Modulo11(cNroDoc)
		cDVNoss1:=Modulo11("1"+cNroDoc+cDVNosso)


		//If cDVNosso = '10' .or. cDVNosso = '0'
		//cDVNosso:='0'
		//EndIf

		//-------------------------------------------------------*
		//Campo Livre do codigo de barra do UNIBANCO
		//-------------------------------------------------------*
		cBarra +="04"   															// 2  // 20  21    Codigo  p/ transacao CVT
		cBarra += cDtVenc 		        											// 6  // 22  27    Data de vencimento
		cBarra += Right(AllTrim(cAgencia),4)+Modulo11(Right(AllTrim(cAgencia),4)) 	// 5  // 28  32    Agencia + DV
		cBarra += PADL(Alltrim(cNroDoc),10,"0")+cDVNosso		  					// 11 // 33  43    Nosso Numero + DV
		cBarra += cDVNoss1															// 01 // 44  44    Super Dígito


		//---------------------------------------------------------------------------------*
		// Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco
		//--------------------------------------------------------------------------------*

		Dvag :=Modulo11(Right(AllTrim(cAgencia),4))
		Dvag := IIf(Dvag = '0' .Or. Dvag = '1' .Or. Dvag = '10', "0", str(Dvag))

		cAgencia:= Right(AllTrim(cAgencia),4)+"-"+Dvag          		  // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:=Substr(cConta,1,6)+" "+Substr(cConta,7,1)   // Digito da Conta Chumdado conforme padrao do banco

		cNosso :="1/"+cNroDoc+"-"+cDVNosso+"/"+cDVNoss1

			*/
			Case cBanco  $ "356*033"   // Real    /

				//cCart    := "42"
				cCart    := "COB"
				//		cCart    := SEE->EE_CARTEIR    // Vitor Duarte 06/06/2013

				*-------------------------------------------------------*
				* Calculo do Digitao de cobrança
				*-------------------------------------------------------*

				c_agctnos      := cNroDoc  + Substr(cAgencia , 1 , 4 ) + Substr(cConta , 1 , 7 )
				c_dacacb       := U_DIGIT001( c_agctnos  )



				*-------------------------------------------------------*
				*Campo Livre do codigo de barra do banco do Real
				*-------------------------------------------------------*
				//aqui
				DbSelectArea("SA6")
				//		DbSetOrder(1)
				//		DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.T.)

				cCedent := SA6->A6_XCEDENT
				//cCedent   := PadL( Right( aDadosBanco[04], 07 ), 07, "0" )

				cBarra += "9"
				cBarra += cCedent
				//cBarra +=  Substr(cAgencia  ,1,4)    		// 04  // 20  23    Numero cliente
				//cBarra +=  Substr(cConta    ,1,7)			// 07  // 24  30    Vago
				//cBarra +=  c_dacacb    		    			// 01  // 31  31    Digitao de cobranca
				cBarra +=  PADL(Alltrim(cNroDoc),13,"0")   	// 13  // 32  44    Nosso Numero



				* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


				cNosso :=cNroDoc

				cAgencia:= AllTrim(cAgencia)+"/"           // Digito da Agencia Chumdado conforme padrao do banco
				cConta	:= Alltrim(cConta)+"/"+c_dacacb    // Digito da Conta Chumdado conforme padrao do banco

				/*
	Case cBanco  = "041"  	   // Banrisul

		cCart    := "COBR."    // chumbado


		*-------------------------------------------------------*
		* Calculo do Digitao de cobrança
		*-------------------------------------------------------*

		c_agctnos      := cNroDoc  + Right(Alltrim(cAgencia) , 3 ) + Substr(cConta , 1 , 7 )
		c_dacacb       := U_DIGIT001( c_agctnos  )

		*-------------------------------------------------------*
		* Campo Livre do codigo de barra do banco do Banrisul
		*-------------------------------------------------------*
		cBarra += "2"    						  	// 01  // 20  20    Constante, identifica o produto
		cBarra += "1"    					     	// 01  // 21  21    Constante, Carteira.
		cBarra += Right(Alltrim(cAgencia) , 3 )    	// 03  // 22  24    Agencia do banco
		cBarra += Substr(cConta    ,1,6)+"0"	    // 07  // 25  31    Vago
		cBarra += PADL(Alltrim(cNroDoc),8 ,"0")    // 08  // 32  39    Nosso Numero
		cBarra += "041"              				// 03  // 40  42    Codigo do banco

		//Calcula o Digito verificador do codigo de Barra da posicao 42  e 43
		c_campo := Substr(cBarra,19,23)
		c_fdig1  := U_DIGIT001(c_campo)
		c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)


		//If c_fdig1  = '9'
		//c_fdig1  := '0'
		//c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)
		//Endif

		//If c_fdig2  = '10'
		//c_fdig1 :=soma1(c_fdig1)
		//c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)
		//EndIf

		if c_fdig2  = '10'
			c_fdig1 :=If(soma1(c_fdig1)='A','0',soma1(c_fdig1))
			c_fdig2  := u_Mod_11_2A7(c_campo+c_fdig1)
		EndIf


		cBarra +=   c_fdig1 + c_fdig2   	// 02 // 43  44     Modulo10(codBarra19-41) +Modulo11(codbarra 19-41)



		* Configura a agencia e o Nosso numero de  acordo c/ os padroes do banco


		cAgencia:= Right(Alltrim(cAgencia) , 3 )+".46" // Digito da Agencia Chumdado conforme padrao do banco
		cConta	:= Substr(Alltrim(cConta),1,6)+".0.38"  // Digito da Conta Chumdado conforme padrao do banco

		// Calculo do DV do nosso numero de acordo c/ o banco
		c_fdig1  := U_DIGIT001(Substr(cNroDoc,1,8))
		c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)


		//If c_fdig1  = '9'
		//c_fdig1  := '0'
		//c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		//Endif

		//If c_fdig2  = '10'
		//c_fdig1 := soma1(c_fdig1)
		//c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		//EndIf

		If c_fdig2  = '10'
			c_fdig1 :=If(soma1(c_fdig1)='A','0',soma1(c_fdig1))
			c_fdig2  := u_Mod_11_2A7(Substr(cNroDoc,1,8)+c_fdig1)
		EndIf

		cDVNosso := c_fdig1 + c_fdig2
		cNosso 	 :=Substr(cNroDoc,1,8)+"-"+cDVNosso
				*/
		EndCase

		//c_dig  := U_CALC_5p(cBarra)

		cBarra += "0"  //IOF - Seguradoras - Demais clientes = 0(Zero)
		cBarra += "101" //102 - Cobrança simples

		c_dig := CalcBar(cBarra)
		//Incrementa o DAC na quinta posicao do codigo ded barra
		cBarra  := substr(cBarra , 1 , 4) + cValToChar(c_dig)  + substr(cBarra , 5 ,44 )


		* Calculo da linha digitavel


		*-------------------------------------------------------*
		* Parte 1   BBBMN.NNNNN
		*-------------------------------------------------------*

		cParte1   := substr(cBarra , 1 , 4 ) + substr ( cBarra  , 20 , 5 )
		// itau := cBanco   +  cMoeda     + cCart + Substr(cNroDoc , 1 , 2 )
		cDig1    := U_DIGIT001( cParte1 )

		*-------------------------------------------------------*
		* Parte 2   NNNNN.NDNNNN
		*-------------------------------------------------------*


		cParte2   := substr(cBarra , 25 , 6 ) + substr ( cBarra  , 31 , 1 ) + substr ( cBarra  , 32 , 3 )
		// itau  := Substr(cNroDoc , 3 , 6 )   + c_dacacb                     + substr(cAgencia , 1 , 3 )
		cDig2    := U_DIGIT001( cParte2 )


		*-------------------------------------------------------*
		* Parte 3  NNNNN.NNNNNN
		*-------------------------------------------------------*

		cParte3   :=  substr(cBarra , 35 , 1 ) + substr ( cBarra  , 36 , 6 ) + substr ( cBarra  , 42 , 3 )
		// itau   :=  substr(cAgencia , 4 , 1 )  + Substr(cConta , 1 , 6 )  + "000"
		cDig3    := U_DIGIT001( cParte3 )

		*-------------------------------------------------------*
		* Parte 4  X
		*-------------------------------------------------------*

		cParte4    := Transform(c_dig, "@E 9")
		// substr(cBarra , 5 , 1 )


		*-------------------------------------------------------*
		* Parte 5   DDDDVVVVVVVVVV
		*-------------------------------------------------------*
		cParte5    := substr(cBarra , 6 , 4 )      + substr(cBarra , 10 , 10 )
		// itau  u_fator()                   +  cValor


		cDigital := substr(cParte1,1,5)+"."+substr(cparte1,6,4)+Transform(cDig1," @E 9")+"  "+;
			substr(cParte2,1,5)+"."+substr(cparte2,6,5)+Transform(cDig2," @E 9")+"  "+;
			substr(cParte3,1,5)+"."+substr(cparte3,6,5)+Transform(cDig3," @E 9")+"  "+;
			cParte4+" "+cParte5

		Aadd(aRet,   cBarra)
		Aadd(aRet, cDigital)
		Aadd(aRet,   cNosso)
		Aadd(aRet,    cCart)
		Aadd(aRet, cAgencia)
		Aadd(aRet,   cConta)
		Aadd(aRet, cDVNosso)


		RestArea(aArea)

	Return aRet

	STATIC FUNCTION CalcBar(cData)

		Local aArea	:= GetArea()
		Local L, D, P := 0

		L := Len(cdata)
		D := 0
		P := 1


		While L > 0
			P := P + 1
			D := D + (Val(SubStr(cData, L, 1)) * P)
			If P = 9
				P := 1
			EndIf
			L := L - 1
		EndDo

		D := 11 - (mod(D,11))

		If (D == 0 .Or. D == 1 .Or. D == 10 .Or. D == 11)
			D := 1
		EndIf

		RestArea(aArea)

	Return (D)
