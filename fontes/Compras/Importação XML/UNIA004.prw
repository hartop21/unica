
/*/{Protheus.doc} UNIA004

@project Importação de XMLs de Pré-Notas de Entrada
@description Programa destinado a importar o XML da nota fiscal eletrônica.                                                      |*
@params MV_PCNFE - Define se a Nota Fiscal tem que ser amarrada  a um Pedido de Compra.
@author Rafael Rezende ( Programa desenvolvido em parceria com Henrique de Jesus )
@since 28/03/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#INCLUDE "RwMake.ch"
#INCLUDE "Font.ch"
#INCLUDE "Colors.ch"

User Function TestThis()

	RpcSetEnv("99","01")

	u_UNIA004()

Return

*---------------------*
User Function UNIA004()
	*---------------------*
	Local X
	Private lLinux     := .F.
	Private cPathXML   := "C:\"
	Private cPathPTH   := CurDir() + IIf( Right( CurDir(), 01 ) $ "\/","","\" ) + AllTrim( FunName() ) + "\" // GetPvProfString(GetEnvServer(), "RootPath", "undefined", GetAdv97()) + "\TIPNFE\"
	Private cPathEMP   := cPathPTH + IIf( Len( AllTrim( SM0->M0_CGC ) ) == 0, "XMLEMP", AllTrim( SM0->M0_CGC ) ) + "\"
	Private cPathEMPXML:= cPathEMP + IIf( Right( AllTrim( cPathEMP ), 01 ) == "\" , "","\" ) +  "XML\" + StrZero( Year( dDataBase ), 04 ) + "\" + StrZero( Month( dDataBase ), 02 ) + "\"

	Private nCmbOrdem
	Private nQtCarNF
	Private lInverte := .F.
	Private cMark    := GetMark()
	Private cCNPJForn:= ""
	Private cFiltro  := "    "
	Private cFiltro1 := ".AND.("
	Private cGetPos  := Space( 200 )
	Private oTempTable1
	Private oTempTable2

	// Faz a verificação das pastas usadas no programa
	If ! FVerificaPath()
		Return Nil
	EndIf

	// Define as cores para legenda das notas fiscais
	aCoresNF := {}
	aAdd(aCoresNF, { "U_RetStatNFe() == 01", "BR_VERDE"    } ) // Tudo OK para importacao
	aAdd(aCoresNF, { "U_RetStatNFe() == 02", "BR_VERMELHO" } ) // Fornecedor não localizado ou nao associado
	aAdd(aCoresNF, { "U_RetStatNFe() == 03", "BR_AMARELO"  } ) // Fornecedor com divergência nos dados
	aAdd(aCoresNF, { "U_RetStatNFe() == 04", "BR_AZUL"     } ) // Já importado
	aAdd(aCoresNF, { "U_RetStatNFe() == 05", "BR_BRANCO"   } ) // Nota Fiscal Normal
	aAdd(aCoresNF, { "U_RetStatNFe() == 06", "BR_LARANJA"  } ) // Nota Fscal de Devolução/Retorno
	aAdd(aCoresNF, { "U_RetStatNFe() == 07", "BR_MARROM"   } ) // Nota Fiscal de Complemento/Ajuste

	// Define as colunas que serão exibidas na MsSelect das Notas Fisccais
	aCposNF := {}
	aAdd( aCposNF, { "OK"     ,, "Mrk"       , "@!"       			} )
	aAdd( aCposNF, { "CNPJ"   ,, "CPF/CNPJ"  , "@!"       			} )  // CNPJ ou CPF do emitente da nota fiscal
	aAdd( aCposNF, { "NUMNF"  ,, "Num.NF"    , "@!"			       	} )  // Número da nota fiscal
	aAdd( aCposNF, { "SERNF"  ,, "Ser."      , "@!"			       	} )  // Série da nota fiscal
	aAdd( aCposNF, { "CODFRN" ,, "Cod."      , "@9"     		  	} )  // Código do fornecedor caso seja localizado no sistema
	aAdd( aCposNF, { "NOMFRN" ,, "Fornecedor", "@!"		    	   	} )  // Nome do fornecedor que esta no XML
	aAdd( aCposNF, { "IESTAD" ,, "Ins.Est."  , "@!" 			    } )  // Inscrição estadual no XML
	aAdd( aCposNF, { "EMISSAO",, "Emissão"   , "99/99/99" 			} )  // Data da emissão da nota fiscal
	aAdd( aCposNF, { "VALORNF",, "Valor NF"  , "@E 999,999,999.99"  } )  // Valor total da nota fiscal
	aAdd( aCposNF, { "CHAVENF",, "Chave NFe" , "@!"       			} )  // Chave da nota fiscal
	aAdd( aCposNF, { "NSUNF"  ,, "NSU"       , "@!"       			} )  // NSU da nota fiscal

	// Define as cores para legenda dos Ítens das notas fiscais
	aCoresIT := {}
	aAdd(aCoresIT, { "U_RetStatIT() == 01", "BR_VERDE"    } )
	aAdd(aCoresIT, { "U_RetStatIT() == 04", "BR_AZUL"     } )
	aAdd(aCoresIT, { "U_RetStatIT() == 00", "BR_VERMELHO" } )

	// Define as colunas que serão exibidas na MsSelect dos Ítens das notas fiscais
	aCposIT := {}
	aAdd( aCposIT, { "OK"     ,, "Mrk"                 , "@!"                } )
	aAdd( aCposIT, { "ITEM"   ,, "It.NF"               , "@9"                } )
	aAdd( aCposIT, { "CODPRT" ,, "Cod.PTH"             , "@!"                } )
	aAdd( aCposIT, { "CODIGO" ,, "Código"              , "@!"                } )
	aAdd( aCposIT, { "DESCRI" ,, "Descrição do Produto", "@!"                } )
	aAdd( aCposIT, { "NCM"    ,, "NCM"                 , "@9"                } )
	aAdd( aCposIT, { "CFOP"   ,, "CFOP"                , "@9"                } )
	aAdd( aCposIT, { "UN"     ,, "UN"                  , "!!"                } )
	aAdd( aCposIT, { "QTD"    ,, "Quant."              , "@E 999,999.999999" } )
	aAdd( aCposIT, { "VLRUNIT",, "Vlr.Unit."           , "@E 999,999,999.99" } )
	aAdd( aCposIT, { "VLRTOT" ,, "Vlr.Total"           , "@E 999,999,999.99" } )
	aAdd( aCposIT, { "PEDIDO" ,, "Pedido"              , "@9"                } )
	aAdd( aCposIT, { "ITEMPC" ,, "Ít.Pc."              , "@9"                } )

	// Cria arquivo temporario para cabecalho das notas fiscais
	MsgRun( "Processando informações das Notas, aguarde...", "Aguarde...", { || FCriaTMPNF() } )

	aCBoxOrdem := { "Data de Emissão" 	, ;
		"CNPJ"			  	, ;
		"Número da NF"		, ;
		"Código Fornecedor"	, ;
		"Nome do Fornecedor"  }

	oFont1		:= TFont():New( "MS Sans Serif",0,-15,,.T.,0,,700,.F.,.F.,,,,,, )
	oDlgNFe 	:= MSDialog():New( 101,245,658,1160,"Processamento XML NFe",,,.F.,,,,,,.T.,,,.T. )
	oSayIndice  := TSay():New( 004,148,{||"Índice"},oDlgNFe,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,016,008)
	oCmbOrdem 	:= TComboBox():New( 001,168,{|u| If(PCount()>0,nCmbOrdem:=u,nCmbOrdem)},aCBoxOrdem,072,010,oDlgNFe,,{|| fMudaOrdemNF()},,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCmbOrdem )
	oGetPos    	:= TGet():New( 001,244,{|u| If(PCount()>0,cGetPos:=u,cGetPos)},oDlgNFe,168,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPos",,)
	oBtnPosNF  	:= TButton():New( 001,415,"&Posicionar",oDlgNFe,{|| FPosicForn()},037,010,,,,.T.,,"",,,,.F. )

	oGrp1		:= TGroup():New( 000,001,084,036,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	For nX := 01 To 07
		cX := AllTrim( Str( nX ) )
		lCBox&cX := .F.
	Next nX

	oBmp1		:= TBitmap():New( 002,020,007,007,"BR_VERDE"   ,"",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oBmp2		:= TBitmap():New( 011,020,007,007,"BR_VERMELHO","",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oBmp3		:= TBitmap():New( 020,020,007,007,"BR_AMARELO" ,"",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oBmp4		:= TBitmap():New( 029,020,007,007,"BR_AZUL"    ,"",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oBmp5		:= TBitmap():New( 038,020,007,007,"BR_BRANCO"  ,"",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oBmp6		:= TBitmap():New( 047,020,007,007,"BR_LARANJA" ,"",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oBmp7		:= TBitmap():New( 056,020,007,007,"BR_MARROM"  ,"",.T.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
	oCBox1		:= TCheckBox():New( 002,004,"",{|u|if(PCount()>0,lCBox1:=u,lCBox1)},oGrp1,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox2		:= TCheckBox():New( 011,004,"",{|u|if(PCount()>0,lCBox2:=u,lCBox2)},oGrp1,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox3		:= TCheckBox():New( 020,004,"",{|u|if(PCount()>0,lCBox3:=u,lCBox3)},oGrp1,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox4		:= TCheckBox():New( 029,004,"",{|u|if(PCount()>0,lCBox4:=u,lCBox4)},oGrp1,011,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox5		:= TCheckBox():New( 038,004,"",{|u|if(PCount()>0,lCBox5:=u,lCBox5)},oGrp1,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox6		:= TCheckBox():New( 047,004,"",{|u|if(PCount()>0,lCBox6:=u,lCBox6)},oGrp1,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox7		:= TCheckBox():New( 056,004,"",{|u|if(PCount()>0,lCBox7:=u,lCBox7)},oGrp1,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oBtnLegNF	:= TButton():New( 068,003,"Legenda",oGrp1,{|| fLegenda()},031,012,,,,.T.,,"",,,,.F. )
	For nX = 01 TO 07
		cX := AllTrim( Str( nX ) )
		oCBox&cX:bLClicked := { || FFilBrwForn() }
	Next nX

	oGrp2		:= TGroup():New( 084,001,117,036,"Localizar",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtnLocPed 	:= TButton():New( 090,003,"Pedido" ,oGrp2,{|| FSelPC( .F. ) },031,012,,,,.T.,,"",,,,.F. )
	oBtnLocFor 	:= TButton():New( 103,003,"Fornec.",oGrp2,{|| FConForn() },031,012,,,,.T.,,"",,,,.F. )
	oBtnMsg		:= TButton():New( 120,002,"Msg. NF",oDlgNFe,{|| FMsgXML()},033,011,,,,.T.,,"",,,,.F. )

	oGrp4:=TGroup():New( 144,001,162,036,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtnLgPrd:=TButton():New( 147,003,"Legenda",oGrp4,{|| fLegItem()},031,012,,,,.T.,,"",,,,.F. )

	oGrp5:= TGroup():New( 187,001,220,036,"Localizar",oDlgNFe,CLR_BLUE,CLR_WHITE,.T.,.F. )
	oBtnLcPdPr := TButton():New( 193,003,"Pedido" ,oGrp5,{|| fSelPC(.T.)},031,012,,,,.T.,,"",,,,.F. )
	oBtnLocPrd := TButton():New( 206,003,"Produto",oGrp5,{|| fConProd() },031,012,,,,.T.,,"",,,,.F. )

	oGrp6:= TGroup():New( 221,001,273,220,"Dados Fornecedor",oDlgNFe,CLR_CYAN,CLR_WHITE,.T.,.F. )
	oSayFornec := TSay():New( 228,005,{||"Fornecedor"},oGrp6,,oFont1,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,176,008)
	oSay4      := TSay():New( 237,005,{||"CNPJ/CPF:" },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,028,008)
	oSayCNPJ   := TSay():New( 237,037,{||""  },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,052,008)
	oSay5      := TSay():New( 237,093,{||"Insc.Est.:"},oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,024,008)
	oSayIE     := TSay():New( 237,121,{||""    },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,040,008)
	oSay6      := TSay():New( 237,165,{||"C.Mun.:"   },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,020,008)
	oSayCMun   := TSay():New( 237,185,{||""  },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,032,008)
	oSay7      := TSay():New( 249,005,{||"Logradoro:"},oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,028,008)
	oSayLograd := TSay():New( 249,033,{||""},oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,124,008)
	oSay8      := TSay():New( 249,157,{||"Número:"   },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,024,008)
	oSayNum    := TSay():New( 249,181,{||""   },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,032,008)
	oSay9      := TSay():New( 261,005,{||"Bairro:"   },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,020,008)
	oSayBairro := TSay():New( 261,021,{||""},oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,040,008)
	oSay10     := TSay():New( 261,065,{||"Cidade:"   },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,020,008)
	oSayCidade := TSay():New( 261,085,{||""},oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,048,008)
	oSay11     := TSay():New( 261,137,{||"UF:"       },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,012,008)
	oSayUF     := TSay():New( 261,149,{||""    },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,012,008)
	oSay12     := TSay():New( 261,165,{||"CEP:"      },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,016,008)
	oSayCEP    := TSay():New( 261,181,{||""   },oGrp6,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,032,008)
	oBtnIncAlt := TButton():New( 225,177,"Incluir",oGrp6,,037,008,,,,.T.,,"",,,,.F. )

	oGrp7:= TGroup():New( 221,224,273,348,"Dados da Nota Fiscal",oDlgNFe,CLR_CYAN,CLR_WHITE,.T.,.F. )
	oSay13     := TSay():New( 229,228,{||"Númer:"     },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,020,008)
	oSayNumNF  := TSay():New( 229,248,{||""  },oGrp7,,oFont1,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,044,008)
	oSay14     := TSay():New( 229,304,{||"Série:"     },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,016,008)
	oSaySerie  := TSay():New( 229,320,{||""  },oGrp7,,oFont1,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,016,008)
	oSay15     := TSay():New( 239,228,{||"Valor:"     },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,016,008)
	oSayValNF  := TSay():New( 239,244,{||""  },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,040,008)
	oSay16     := TSay():New( 239,288,{||"Emissão:"   },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,024,008)
	oSayEmis   := TSay():New( 239,312,{||""   },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,032,008)
	oSay17     := TSay():New( 249,228,{||"Protocolo:" },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,024,008)
	oSayProt   := TSay():New( 249,256,{||""   },oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,084,008)
	oSay18     := TSay():New( 261,228,{||"Finalidade:"},oGrp7,,      ,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,028,008)
	oSayFinali := TSay():New( 261,256,{||""},oGrp7,,oFont1,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,088,008)

	oGrp8:= TGroup():New( 221,352,273,400,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtnCFG    := TButton():New( 225,356,"&Configurações" ,oGrp8,{|| fCFGUNIA004()},040,012,,,,.T.,,"",,,,.F. )
	//oBtnRecEma := TButton():New( 241,356,"&Receber e-Mail",oGrp8,,040,012,,,,.T.,,"",,,,.F. )
	//oBtnRelat  := TButton():New( 257,356,"R&elatório"     ,oGrp8,,040,012,,,,.T.,,"",,,,.F. )

	oGrp9:= TGroup():New( 221,404,256,452,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtnXMLA   := TButton():New( 225,408,"R&PO de XML's"  ,oGrp9,{|| fRPOXML()   },040,012,,,,.T.,,"",,,,.F. )
	oBtnGPNt   := TButton():New( 241,408,"Gerar Pré &Nota",oGrp9,{|| fGrPreNota()},040,012,,,,.T.,,"",,,,.F. )
	oBtnSair   := TButton():New( 257,404,"&Sair"          ,oDlgNFe,{|| oDlgNFe:End() },048,015,,,,.T.,,"",,,,.F. )

	oGrp10:= TGroup():New( 002,040,012,088,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 005,043,{||"Notas Fiscais"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,040,008)

	oGrp11:= TGroup():New( 012,040,132,452,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBrwNF := MsSelect():New("TMPNF","OK","",aCposNF,@lInverte,@cMark,{15,42,129,450},,,oGrp11,,aCoresNF)
	oBrwNF:oBrowse:lCanAllMark := .T.
	oBrwNF:oBrowse:lHasMark    := .T.
	oBrwNF:oBrowse:bChange     := {|| FDadosFornec(),fDadosNF()}
	oBrwNF:oBrowse:bLDblClick  := {|| fEditaBRW(oBrwNF,"CODFRN","TMPNF","SA2","{|| fValForn(_xVar)}")}
	//  oBrwNF:oBrowse:bAllMark    := {|| MarcaCpo(.T.,"WKUSERS")}

	oGrp12:= TGroup():New( 134,040,144,096,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay2:= TSay():New( 137,043,{||"Ítens da Nota Fiscal"},oGrp12,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,048,008)

	oGrp13:= TGroup():New( 144,040,220,452,"",oDlgNFe,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBrwIT := MsSelect():New("TMPIT","OK","",aCposIT,@lInverte,@cMark,{146,42,218,450},,,oGrp13,,aCoresIT)
	oBrwIT:oBrowse:lCanAllMark := .T.
	oBrwIT:oBrowse:lHasMark    := .T.
	oBrwIT:oBrowse:bLDblClick  := {|| fEditaBRW(oBrwIT,"CODPRT","TMPIT","SB1","{|| fValProd(_xVar)}")}

	//         oBrwIT:oBrowse:bChange     := {|| FDadosFornec()}

	oDlgNFe:Activate(,,,.T.,{||TMPIT->(DbCloseArea()),TMPNF->(DbCloseArea()),.T.},,{|| fCarregaXML()} )


	oTempTable1:Delete()
	oTemptable2:Delete()

Return(Nil)


Static Function fMudaOrdemNF()


	TMPNF->( DbSetOrder( oCmbOrdem:nAt ) )
	oBrwNF:oBrowse:Refresh()

Return .T.

*--------------------------*
Static Function FPosicForn()
	*--------------------------*
	lAchou:=.T.

	If oCmbOrdem:nAt == 01
		lAchou := TMPNF->( DbSeek( CToD( AllTrim( cGetPos ) ) ) )
	Else
		lAchou := TMPNF->( DbSeek( AllTrim( cGetPos ) ) )
	EndIf

	If lAchou
		FDadosFornec()
		FDadosNF()
	Else
		MsgAlert("Dados informados não localizados.","Atenção")
	EndIf

Return(.T.)


Static Function FLegenda()


	Local aLegenda := {}

	aAdd( aLegenda, { "BR_VERDE"   , "Tudo OK para importacao"                                } )
	aAdd( aLegenda, { "BR_VERMELHO", "Fornecedor ou Produto não associado(Não gera pré-Nota)" } )
	aAdd( aLegenda, { "BR_AMARELO" , "Fornecedor com divergência nos dados"                   } )
	aAdd( aLegenda, { "BR_AZUL"    , "Nota Fiscal já importada"                               } )
	aAdd( aLegenda, { "BR_BRANCO"  , "Nota Fiscal Normal"                                     } )
	aAdd( aLegenda, { "BR_LARANJA" , "Nota Fscal de Devolução/Retorno"                        } )
	aAdd( aLegenda, { "BR_MARROM"  , "Nota Fiscal de Complemento/Ajuste"                      } )
	BrwLegenda( "Importação de NFe.", "Legenda", aLegenda )

Return


Static Function FLegItem()

	Local aLegenda := {}

	aAdd( aLegenda, { "BR_VERDE"   , "Ok para importação"                       } )
	aAdd( aLegenda, { "BR_VERMELHO", "Produto não associado(Não gera pré-Nota)" } )
	aAdd( aLegenda, { "BR_AZUL"    , "Já importado"                             } )
	BrwLegenda( "Importação de NFe.", "Legenda dos Ítens", aLegenda )

Return


User Function RetStatNFe()


	nRetorno := 0
	If AllTrim( TMPNF->STATUS ) == "4"                                  // Já importado
		nRetorno := 04
	ElseIf AllTrim( TMPNF->STATUS ) == "3" .And. AllTrim( TMPNF->FINALID ) == "1"   // Nota Fiscal Normal
		nRetorno := 05
	ElseIf AllTrim( TMPNF->STATUS ) == "3" .And. AllTrim( TMPNF->FINALID ) == "4"   // Nota Fscal de Devolução/Retorno
		nRetorno := 06
	ElseIf AllTrim( TMPNF->STATUS ) == "3" .And. AllTrim( TMPNF->FINALID ) $ "2|3" // Nota Fiscal de Complemento/Ajuste
		nRetorno := 07
	ElseIf AllTrim( TMPNF->STATUS ) == "1"                              // Tudo OK para importacao
		nRetorno := 01
	ElseIf AllTrim( TMPNF->STATUS ) == "2"                              // Fornecedor não localizado ou nao associado
		nRetorno := 02
	ElseIf AllTrim( TMPNF->STATUS ) == "3"                              // Fornecedor com divergência nos dados
		nRetorno := 03
	EndIf

Return( nRetorno )

*-----------------------*
User Function RetStatIT()
	*-----------------------*

Return( Val( TMPIT->STATUS ) )

*-----------------------------*
Static Function FCFGUNIA004()
	*-----------------------------*

	If File("UNIA004.INI")
		aCampos := Separa( MemoRead( "UNIA004.INI" ), ";", .T. )
	Else
		aCampos := { "", "", "", "", "", "", "" }
	EndIf

	Private cGetSrvMsg := PadR( AllTrim( aCampos[01] ), 200 )
	Private cGetUsu    := PadR( AllTrim( aCampos[02] ), 100 )
	Private cGetSenha  := PadR( AllTrim( aCampos[03] ), 100 )
	Private cGetPorta  := PadR( AllTrim( aCampos[04] ), 004 )
	Private lExclEml   := ( Val( aCampos[05] ) # 0 )
	Private cGetPasta  := PadR( AllTrim( aCampos[06] ), 500 )
	Private cGetQtdCar := PadR( AllTrim( aCampos[07] ), 001 )

	oDlgCFG:= MSDialog():New( 091,232,321,708,"Configurações UNIA004",,,.F.,,,,,,.T.,,,.T. )

	oGrp1:= TGroup():New( 004,004,064,232,"Configuração E-mail",oDlgCFG,CLR_BLUE,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 012,008,{||"Servidor de Mensagens recebidas (POP)"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,172,008)
	oSay2      := TSay():New( 032,008,{||"Usuário"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,020,008)
	oSayIndice      := TSay():New( 032,100,{||"Senha"  },oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,032,008)
	oSay4      := TSay():New( 032,192,{||"Porta"  },oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,020,008)
	oGetSrvMsg := TGet():New( 020,008,{|u| If(PCount()>0,cGetSrvMsg:=u,cGetSrvMsg)},oGrp1,220,008,''    ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetSrvMsg",,)
	oGetSrvMsg:bWhen := { || .F. }
	oGetUsu    := TGet():New( 040,008,{|u| If(PCount()>0,cGetUsu   :=u,cGetUsu   )},oGrp1,088,008,''    ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetUsu",,)
	oGetUsu:bWhen := { || .F. }
	oGetSenha  := TGet():New( 040,100,{|u| If(PCount()>0,cGetSenha :=u,cGetSenha )},oGrp1,088,008,''    ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.T.,"","cGetSenha",,)
	oGetSenha:bWhen := { || .F. }
	oGetPorta  := TGet():New( 040,192,{|u| If(PCount()>0,cGetPorta :=u,cGetPorta )},oGrp1,036,008,'9999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPorta",,)
	oGetPorta:bWhen := { || .F. }
	oCBox1     := TCheckBox():New( 052,008,"Excluir e-mail do servidor",{|u| If(PCount()>0,lExclEml:=u,lExclEml)},oGrp1,072,008,,,,,CLR_BLUE,CLR_WHITE,,.T.,"",, )
	oCBox1:bWhen := { || .F. }

	oGrp2:= TGroup():New( 068,004,108,140,"",oDlgCFG,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay5     := TSay():New( 072,008,{||"Pasta onde os XML's estão gravados"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,096,008)
	oGetPasta := TGet():New( 080,008,{|u| If(PCount()>0,cGetPasta:=u,cGetPasta)},oGrp2,128,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPasta",,)
	oGetPasta:Disable()
	oBtnPasta := TButton():New( 092,008,"Localizar Pasta",oGrp2,{|| fSelPasta()},044,012,,,,.T.,,"",,,,.F. )

	oGrp4:= TGroup():New( 068,144,108,184,"",oDlgCFG,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay6      := TSay():New( 072,146,{||"Quantidade de" },oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,036,008)
	oSay7      := TSay():New( 078,146,{||"Caracteres  na"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,036,008)
	oSay8      := TSay():New( 085,146,{||"Nota Fiscal"   },oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,036,008)
	oGetQtdCar := TGet():New( 093,156,{|u| If(PCount()>0,cGetQtdCar:=u,cGetQtdCar)},oGrp4,012,008,'9',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetQtdCar",,)

	oGrp3:= TGroup():New( 068,188,108,232,"",oDlgCFG,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtnGrv  := TButton():New( 075,192,"Gravar dados",oGrp3,{|| fGrvCFG(.T.)    },037,012,,,,.T.,,"",,,,.F. )
	oBtnSair := TButton():New( 090,192,"Sair"        ,oGrp3,{|| oDlgCFG:End()},037,012,,,,.T.,,"",,,,.F. )

	oDlgCFG:Activate( ,,, .T., { || FGrvCFG( .F. ) } )

Return( Nil )

*-------------------------*
Static Function fSelPasta()
	*-------------------------*
	cPasta := cGetFile( "*.*", "Selecione o Diretorio Origem",, "C:\",, 144 )

	If Len( AllTrim( cPasta ) ) != 0
		cGetPasta:=cPasta
	EndIf

Return( .T. )

*-----------------------------*
Static Function fVerificaPath()
	*-----------------------------*
	lRet		:= .T.
	aDadosSRV 	:= GetSrvInfo()
	lLinux 		:= ( Upper( aDadosSRV[02] ) == "LINUX" )
	cPathPTH   	:= StrTran( cPathPTH	, "\", "/" )
	cPathEMP    := StrTran( cPathEMP	, "\", "/" )
	cPathEMPXML := StrTran( cPathEMPXML	, "\", "/" )

	If !ExistDir( cPathPTH )
		FwMakeDir( cPathPTH, .T. )
	EndIf

	If !ExistDir( cPathEMP )
		FwMakeDir( cPathEMP, .T. )
	EndIf

	If ! ExistDir( cPathEmp + "XML/" )
		FwMakeDir( cPathEmp + "XML/", .T. )
	EndIf

	If !ExistDir( cPathEmp + "XML/" + StrZero( Year( dDataBase ), 04 ) + "/" )
		FwMakeDir( cPathEmp + "XML/" + StrZero( Year( dDataBase), 04 ) + "/", .T. )
	EndIf

	If !ExistDir( cPathEMPXML )
		FwMakeDir( cPathEMPXML )
	EndIf

Return .T.

*-----------------------------*
Static Function fGrvCFG( lMsg )
	*-----------------------------*

	If MemoWrite("UNIA004.INI",AllTrim(cGetSrvMsg)+";"+AllTrim(cGetUsu)+";"+AllTrim(cGetSenha)+";"+AllTrim(cGetPorta)+";"+IIf(lExclEml,"1","0")+";"+AllTrim(cGetPasta)+";"+AllTrim(cGetQtdCar)+";")
		If lMsg
			MsgInfo("Dados gravados com sucesso.","Atenção")
		EndIf
	Else
		MsgInfo("Não foi possível gravar as configurações, tente novamente.","Atenção")
		Return .F.
	EndIf

Return .T.

*---------------------------*
Static Function fCarregaXML()
	*---------------------------*

	aArqsXML	:=	{}

	If File( "UNIA004.INI" )

		aCampos := Separa( MemoRead( "UNIA004.INI" ), ";", .T. )
		cPathXML:= AllTrim( aCampos[06] )

		If Empty( cPathXML )
			MsgAlert("Pasta de localização dos arquivos XML deve ser configurada.","Atenção")
			FCfgUNIA004()
		EndIf

		If aDir( cPathXML + "*.xml", aArqsXML ) == 0
			MsgAlert( "Não há XML para leitura, verifique a pasta [" + cPathXML + "].","Atenção" )
		EndIf

	Else

		MsgAlert("Pasta de localização dos arquivos XML deve ser configurada.","Atenção")
		FCfgUNIA004()
		aCampos		:= Separa( MemoRead( "UNIA004.INI" ), ";", .T. )
		cPathXML	:= AllTrim( aCampos[06] )

	EndIf

	nQtCarNF := Val( aCampos[07] )

	Processa( { || FCargaXML() }, "Aguarde - Lendo Arquivo(s) XML..." )

Return .T.

*--------------------------*
Static Function fCriaTMPNF()
	*--------------------------*

	// Cria arquivo temporario para cabecalho das notas fiscais
	If Select("TMPNF") > 0
		TMPNF->(dbCloseArea())
	EndIf

	aStruct := {}
	aAdd( aStruct, { "OK"        , "C" , 02 ,0} )
	aAdd( aStruct, { "CNPJ"      , "C" , TamSX3( "A2_CGC" 	)[01], 0 } )  // CNPJ ou CPF do emitente da nota fiscal
	aAdd( aStruct, { "NUMNF"     , "C" , TamSX3( "D1_DOC" 	)[01], 0 } )  // Número da nota fiscal
	aAdd( aStruct, { "SERNF"     , "C" , TamSX3( "D1_SERIE" 	)[01], 0 } )  // Série da nota fiscal
	aAdd( aStruct, { "CODFRN"    , "C" , TamSX3( "A2_COD"   	)[01], 0 } )  // Código do fornecedor caso seja localizado no sistema
	aAdd( aStruct, { "LOJAFRN"   , "C" , TamSX3( "A2_LOJA" 	)[01], 0 } )  // Loja do fornecedor caso seja localizado no sistema
	aAdd( aStruct, { "NOMFRN"    , "C" , TamSX3( "A2_NOME"   )[01], 0 } )  // Nome do fornecedor que esta no XML
	aAdd( aStruct, { "IESTAD"    , "C" , 15 ,0} )  // Inscrição estadual no XML
	aAdd( aStruct, { "EMISSAO"   , "D" , 08 ,0} )  // Data da emissão da nota fiscal
	aAdd( aStruct, { "VALORNF"   , "N" , 14 ,2} )  // Valor total da nota fiscal
	aAdd( aStruct, { "DESCONTO"  , "N" , 14 ,2} )  // Valor do desconto na nota fiscal
	aAdd( aStruct, { "FRETE"     , "N" , 14 ,2} )  // Valor do Frete
	aAdd( aStruct, { "DESPESAS"  , "N" , 14 ,2} )  // Valor de outras despesas acessorias
	aAdd( aStruct, { "CHAVENF"   , "C" , 44 ,0} )  // Chave da nota fiscal
	aAdd( aStruct, { "NSUNF"     , "C" , 09 ,0} )  // NSU da nota fiscal
	aAdd( aStruct, { "NOMEMIT"   , "C" , 40 ,0} )
	aAdd( aStruct, { "FINALID"   , "C" , 01 ,0} )  // Finalidade da nota fiscal (1=Normal 2=Complementar 3=Ajuste 4=Devolucao/Retorno) Campo no XML->oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_FINNFE:TEXT")
	aAdd( aStruct, { "NATOPERAC" , "C" , 90 ,0} )  // // Natureza da operacao (Ex.: Devolucao de conserto, Venda, INDUSTRIALIZACAO)
	aAdd( aStruct, { "IEEMIT"    , "C" , 15 ,0} )
	aAdd( aStruct, { "CDMUMEMIT" , "C" , 15 ,0} )
	aAdd( aStruct, { "LGREMIT"   , "C" , 40 ,0} )
	aAdd( aStruct, { "NLGREMIT"  , "C" , 05 ,0} )
	aAdd( aStruct, { "BAIRROEMIT", "C" , 40 ,0} )
	aAdd( aStruct, { "MUNICEMIT" , "C" , 30 ,0} )
	aAdd( aStruct, { "UFEMIT"    , "C" , 02 ,0} )
	aAdd( aStruct, { "CEPEMIT"   , "C" , 10 ,0} )
	aAdd( aStruct, { "PROTOCOL"  , "C" , 20 ,0} )
	aAdd( aStruct, { "NOMEARQ"   , "C" , 90 ,0} )  // Nome do arquivo XML
	aAdd( aStruct, { "MSGNF"     , "M" , 80 ,0} )
	aAdd( aStruct, { "STATUS"    , "C" , 02 ,0} )

	oTempTable1 := FWTemporaryTable():New( "TMPNF" )

	oTemptable1:SetFields( aStruct )

	oTempTable1:AddIndex("01", {"EMISSAO"} )
	oTempTable1:AddIndex("02", {"CNPJ", "EMISSAO"} )
	oTempTable1:AddIndex("03", {"NUMNF", "CNPJ", "EMISSAO"} )
	oTempTable1:AddIndex("04", {"CODFRN", "EMISSAO"} )
	oTempTable1:AddIndex("05", {"NOMFRN", "EMISSAO"} )

	oTempTable1:Create()

	// Cria temporario para os ítens da nota fiscal
	aStruct:={}
	aAdd(aStruct, { "OK"      , "C" , 02 ,0} )
	aAdd(aStruct, { "CNPJ"    , "C" , TamSX3( "A2_CGC"   )[01] ,0} ) // CNPJ ou CPF do emitente da nota fiscal
	aAdd(aStruct, { "NUMNF"   , "C" , TamSX3( "D1_DOC"   )[01] ,0} ) // Número da nota fiscal
	aAdd(aStruct, { "ITEM"    , "C" , TamSX3( "D1_ITEM"   )[01] ,0} ) // Item da NF
	// Marcelo Amaral 14/11/2019
	// aAdd(aStruct, { "CODIGO"  , "C" , TamSX3( "D1_COD"   )[01] ,0} ) // Código do Produto
	// aAdd(aStruct, { "CODPRT"  , "C" , TamSX3( "A5_CODPRF"   )[01] ,0} ) // Código do Produto no Protheus
	aAdd(aStruct, { "CODIGO"  , "C" , TamSX3( "A5_CODPRF"   )[01] ,0} ) // Código do Produto
	aAdd(aStruct, { "CODPRT"  , "C" , TamSX3( "D1_COD"   )[01] ,0} ) // Código do Produto no Protheus
	aAdd(aStruct, { "DESCRI"  , "C" , TamSX3( "B1_DESC"   )[01] ,0} ) // Descrição do Produto
	aAdd(aStruct, { "NCM"     , "C" , TamSX3( "B1_POSIPI"   )[01] ,0} ) // NCM do Produto
	aAdd(aStruct, { "CFOP"    , "C" , 04 ,0} ) // CFOP
	aAdd(aStruct, { "UN"      , "C" , 02 ,0} ) // Unidade do produto
	aAdd(aStruct, { "QTD"     , "N" , 14 ,6} ) // Quantidade
	aAdd(aStruct, { "VLRUNIT" , "N" , 14 ,6} ) // Valor Unitario
	aAdd(aStruct, { "VLRTOT"  , "N" , 14 ,2} ) // Valor Total
	aAdd(aStruct, { "STATUS"  , "C" , 01 ,0} ) // Status
	aAdd(aStruct, { "DESCPTH" , "C" , 40 ,0} ) // Descricao do produto no protheus
	aAdd(aStruct, { "UNPTH  " , "C" , 02 ,0} ) // Unidade do produto no protheus
	aAdd(aStruct, { "PEDIDO"  , "C" , TamSX3( "C7_NUM"   )[01] ,0} ) // Numero do pedido de compra(SC7) a ser associado
	aAdd(aStruct, { "ITEMPC"  , "C" , TamSX3( "C7_ITEM"   )[01] ,0} ) // Ítem do pedido de compras
	aAdd(aStruct, { "CONDICAO", "C" , 03 ,0} ) // Condicao de Pagamento

	oTempTable2 := FWTemporaryTable():New( "TMPIT" )
	oTemptable2:SetFields( aStruct )

	oTempTable2:Create()

Return .T.

*-------------------------*
Static Function FCargaXML()
	*-------------------------*
	Local nK := 0
	Local nL := 0

	nOrdemSF1 := SF1->( DbSetOrder( 01 ) ) // SF1 ordenada por Filizl + Documento

	ProcRegua( Len( aArqsXML ) )
	For nK = 01 To Len( aArqsXML )

		IncProc()

		If Len( aArqsXML[nK] ) == 0
			Loop
		EndIf

		cArqOrig := cPathXML + aArqsXML[nK]
		cArqDest := cPathEmp + aArqsXML[nK]
		cArqXML  := cPathEmp + aArqsXML[nK]
		If lLinux
			cArqXML := StrTran( cArqXML, "\", "/" )
		EndIf

		If !__CopyFile( cArqOrig, cArqDest )
			MsgInfo( "Não foi possível ler o arquivo [" + cArqOrig + "].", "Atenção" )
			Loop
		EndIf

		cXML := MemoRead( cArqXML )
		If !( "NFEPROC" $ Upper( cXML ) ) .Or.; // Chave para nota de cancelamento--> procCancNFe
				Len( AllTrim( cXML ) ) == 0         // Arqivo vazio
			Loop
		EndIf

		cError   := ""
		cWarning := ""
		oXml := XMLParserFile( cArqXML, "_", @cError, @cWarning )
		If ValType( oXml ) != "O"
			Loop
		EndIf

		// Versão da nota fiscal eletronica incompativel
		//If ( AllTrim(oXML:_NFEPROC:_VERSAO:TEXT) != "3.10" .Or. AllTrim(oXML:_NFEPROC:_VERSAO:TEXT) != "4.00"  )//"3.10"
		If AllTrim( oXML:_NFEPROC:_VERSAO:TEXT ) != "4.00"
			Loop
		EndIf

		// Pega o CNPJ do Emitente da NFe
		cCNPJEmit   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_CNPJ:TEXT"				) // Nome do emitente da nota fiscal

		// Verificar se CNPJ do XML é igual ao CNPJ da empresa logada, Caso nao seja nao exibe os dados
		If Type( "oXml:_NFEPROC:_NFE:_INFNFE:_DEST:_CNPJ:TEXT" ) != "U"
			cCNPJForn := oXml:_NFEPROC:_NFE:_INFNFE:_DEST:_CNPJ:TEXT
		ElseIf Type("oXml:_NFEPROC:_NFE:_INFNFE:_DEST:_CNPJ:TEXT") == "U"
			cCNPJForn := oXml:_NFEPROC:_NFE:_INFNFE:_DEST:_CPF:TEXT
		Else
			cCNPJForn := ""
		EndIf

		// Comentar para realizar testes
		If AllTrim( cCNPJForn ) != AllTrim( SM0->M0_CGC )
			Loop
		EndIf

		// Dados do emitente da NFE
		cNomEmit    := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_XNOME:TEXT"				) // Nome do emitente da nota fiscal
		cCEPEmit    := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_CEP:TEXT"		) // CEP
		cCdPaisEmit := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_CPAIS:TEXT"	) // Código do País
		cTelfEmit   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_FONE:TEXT"	) // Telefone
		cLgrEmit    := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_XLGR:TEXT"	) // Logradouro
		cNLgrEmit   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_NRO:TEXT"		) // Número do logradouro
		cBairroEmit := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_XBAIRRO:TEXT"	) // Bairro
		cMunicEmit  := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_XMUN:TEXT"	) // Municipio
		cUFEmit     := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_UF:TEXT"		) // UF
		cPaisEmit   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_ENDEREMIT:_XPAIS:TEXT"	) // Pais
		cInfCEmit   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_INFADIC:_INFCPL:TEXT"			) // Informações complementares sobre o emitente
		cIEEmit     := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_IE:TEXT"					) // Inscrição estadual do emitente
		cCdMumEmit  := Posicione( "CC2", 02, XFilial( "CC2" ) + Upper( AllTrim( cMunicEmit ) ), "CC2_CODMUN" ) // Código do municipio

		// Dados da Nota Fiscal
		cChaveNF    := FRetTag( "oXML:_NFEPROC:_PROTNFE:_INFPROT:_CHNFE:TEXT"  ) // Chave da Nota Fiscal
		cProtcNF    := FRetTag( "oXML:_NFEPROC:_PROTNFE:_INFPROT:_NPROT:TEXT"  ) // Protocolo
		cCNPJDestNF := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_DEST:_CNPJ:TEXT"  ) // CNPJ do destinatario da nota fiscal
		cDtEmisNF   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_DHEMI:TEXT"  ) // Data de emissao
		cFinalidNF  := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_FINNFE:TEXT" ) // Finalidade (1=Normal 2=Complementar 3=Ajuste 4=Devolucao/Retorno)
		cNatOprNF   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_NATOP:TEXT"  ) // Natureza da operacao (Ex.: Devolucao de conserto, Venda, INDUSTRIALIZACAO)
		cNumNF      := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_NNF:TEXT"    ) // Número da Nota Fiscal
		cSerNF      := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_SERIE:TEXT"  ) // Série da Nota
		cTipOprNF   := FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_TPNF:TEXT"   ) // Tipo de Operacao (1=Interna 2=interestadual 3=exterior)

		// Valores
		nValNF      := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VNF:TEXT"		) ) // Valor da nota Fiscal
		nValSegurNF := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VSEG:TEXT"	) ) // Valor do Seguro
		nValODespNF := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VOUTRO:TEXT"	) ) // Valor de Outras despesas acessorias
		nValDescNF  := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VDESC:TEXT"	) ) // Valor de Desconto
		nValFreteNF := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VFRETE:TEXT"	) ) // Valor do Frete
		nValImpNF   := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VTOTTRIB:TEXT") ) // Valor aproximado do total dos tributos federais, estaduais e municipais

		// Impostos
		nValBSICMNF := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VBC:TEXT"			) ) // Valor de Base do ICMS
		nValICMSNF  := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VICMS:TEXT"		) ) // Valor do ICMS
		nValICMDsNF := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VICMSDESON:TEXT"	) ) // Valor do ICMS Desonerado
		nValIINF    := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VII:TEXT"			) ) // Valor do Imposto de Importacao
		nValIPINF   := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VIPI:TEXT"		) ) // Valor do IPI
		nValPISNF   := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VPIS:TEXT"		) ) // Valor PIS
		nValCOFNF   := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VCOFINS:TEXT"		) ) // Valor da COFINS
		nValBSSTNF  := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VBCST:TEXT"		) ) // Valor Base do ICMSST
		nValSTNF    := Val( FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VST:TEXT"			) ) // Valor do ICMSST

		lGrvNF		:= .F.
		nOrdSF1		:= SF1->( IndexOrd() )
		SF1->( DbSetOrder( 08 ) )
		If SF1->( DbSeek( XFilial( "SF1" ) + cChaveNF ) ) // Verifica se a chave ja foi importada ou digitada
			SF1->( DbSetOrder( nOrdSF1 ) )
			Loop
		EndIf
		SF1->( DbSetOrder( nOrdSF1 ) )

		DbSelectArea( "TMPNF" )
		RecLock( "TMPNF", .T. )
		TMPNF->CNPJ      := cCNPJEmit  //cCNPJForn
		TMPNF->NUMNF     := FRetNumNF( cNumNF )
		TMPNF->SERNF     := cSerNF
		TMPNF->CODFRN    := ""
		TMPNF->LOJAFRN   := ""
		TMPNF->NOMFRN    := cNomEmit
		TMPNF->IESTAD    := cIEEmit
		TMPNF->EMISSAO   := SToD( StrTran( Left( cDtEmisNF, 10), "-", "" ) )
		TMPNF->FINALID   := cFinalidNF
		TMPNF->NATOPERAC := cNatOprNF
		TMPNF->VALORNF   := nValNF
		TMPNF->CHAVENF   := cChaveNF
		TMPNF->DESCONTO  := nValDescNF
		TMPNF->FRETE     := nValFreteNF
		TMPNF->DESPESAS  := nValODespNF
		TMPNF->NSUNF     := ""
		TMPNF->NOMEMIT   := cNomEmit
		TMPNF->IEEMIT    := cIEEmit
		TMPNF->CDMUMEMIT := cCdMumEmit
		TMPNF->LGREMIT   := cLgrEmit
		TMPNF->NLGREMIT  := cNLgrEmit
		TMPNF->BAIRROEMIT:= cBairroEmit
		TMPNF->MUNICEMIT := cMunicEmit
		TMPNF->UFEMIT    := cUFEmit
		TMPNF->CEPEMIT   := cCEPEmit
		TMPNF->PROTOCOL  := cProtcNF
		TMPNF->MSGNF     := cInfCEmit
		TMPNF->NomeArq   := aArqsXML[nK]
		TMPNF->( MsUnLock() )
		lGrvNF:=.T.

		FDadosFornec()
		FDadosNF()

		// Gravação e tratamento dos ítens da nota fiscal
		If lGrvNF

			If ValType( oXml:_NFEPROC:_NFE:_INFNFE:_DET ) == "A"

				For nL := 01 To Len( oXML:_NFEPROC:_NFE:_INFNFE:_DET )

					cL := AllTrim( Str( nL ) )
					cDESCPTH := ""
					cUNPTH   := ""
					cITEM    := StrZero( Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_NITEM:TEXT" 		) ), 04 )  	// Item da NF
					cCODIGO  := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_CPROD:TEXT"	)          	// Código do Produto
					cDESCRI  := 			  FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_XPROD:TEXT"	)          	// Descrição do Produto
					cNCM     := 			  FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_NCM:TEXT"	)          	// NCM do Produto
					cCFOP    := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_CFOP:TEXT"	)	       	// CFOP
					cUN      := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_UCOM:TEXT"	)          	// Unidade do produto
					nQTD     := 		 Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_QCOM:TEXT"   ) )        	// Quantidade
					nVLRUNIT := 		 Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_VUNCOM:TEXT" ) )      	// Valor Unitario
					nVLRTOT  := 		 Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_VPROD:TEXT"  ) )       	// Valor Total
					cCODPRT  := FBuscaSA5( cCodigo, @cUNPTH, @cDESCPTH )                                              				// Código do Produto no Protheus
					cPEDIDO  := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET[" + cL + "]:_PROD:_XPED:TEXT"   )           // Pedido de Compras
					cSTATUS  := IIf( !Empty( cCODPRT ), "1", "0" )                                                      			// Status 0=Produto não localizado 1=Produto localizado
					If Left( Upper( AllTrim( cPEDIDO ) ), 06 ) == "ALINHA"
						cPEDIDO := ""
					EndIf

					FGrvItem()

				Next nL

			Else

				cDESCPTH := ""
				cUNPTH   := ""
				cITEM    := StrZero( Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_NITEM:TEXT" 		) ), 04 )	// Item da NF
				cCODIGO  := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT"	)           // Código do Produto
				cDESCRI  := 			  FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_XPROD:TEXT"	)           // Descrição do Produto
				cNCM     := 			  FRetTag( "oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_NCM:TEXT"	)           // NCM do Produto
				cCFOP    := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CFOP:TEXT"	)           // CFOP
				cUN      := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_UCOM:TEXT"	)           // Unidade do produto
				nQTD     := 		 Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_QCOM:TEXT"	) )         // Quantidade
				nVLRUNIT := 		 Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VUNCOM:TEXT"	) )      	// Valor Unitario
				nVLRTOT  := 		 Val( FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VPROD:TEXT"	) )       	// Valor Total
				cCODPRT  := FBuscaSA5( cCodigo, @cUNPTH, @cDESCPTH )                                     			// Código do Produto no Protheus
				cSTATUS  := IIf( !Empty( cCODPRT ), "1", "0" )                                            			// Status 0=Produto não localizado 1=Produto localizado
				cPEDIDO  := 			  FRetTag( "oXml:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_XPED:TEXT" )          	// Pedido de Compras
				If Left( Upper( AllTrim( cPEDIDO ) ), 06 ) == "ALINHA"
					cPEDIDO := ""
				EndIf
				FGrvItem()

			EndIf

		EndIf

	Next nK

	TMPNF->( DbGoTop() )
	oBrwNF:oBrowse:Refresh()
	FDadosFornec()
	FDadosNF()

Return .T.


Static Function FGrvItem()


	DbSelectArea( "TMPIT" )
	RecLock( "TMPIT", .T. )

	TMPIT->OK      := cMark
	TMPIT->CNPJ    := TMPNF->CNPJ
	TMPIT->NUMNF   := TMPNF->NUMNF
	TMPIT->DESCPTH := cDESCPTH
	TMPIT->UNPTH   := Upper( cUNPTH  )
	TMPIT->ITEM    := cITEM
	TMPIT->CODIGO  := cCODIGO
	TMPIT->DESCRI  := cDESCRI
	TMPIT->NCM     := cNCM
	TMPIT->CFOP    := cCFOP
	TMPIT->UN      := Upper( cUN )
	TMPIT->QTD     := nQTD
	TMPIT->VLRUNIT := nVLRUNIT
	TMPIT->VLRTOT  := nVLRTOT
	TMPIT->CODPRT  := cCODPRT
	TMPIT->STATUS  := cSTATUS
	If Left( Upper( AllTrim( cPEDIDO ) ), 06 ) == "ALINHA"
		cPEDIDO := ""
	EndIf
	TMPIT->PEDIDO  := cPedido
	//TMPIT->ITEMPC

	TMPIT->( MsUnLock() )

	If AllTrim( TMPIT->STATUS ) == "0"

		DbSelectArea( "TMPNF" )
		RecLock( "TMPNF", .F. )
		TMPNF->STATUS := "2"
		TMPNF->( MsUnLock() )

	EndIf

Return Nil

*----------------------------------------------------*
Static Function FBuscaSA5( cCodPrd, cUNPTH, cDESCPTH )
	*----------------------------------------------------*

	cRetorno := ""
	If !SA2->( Eof() )

		nOrdemSA5 := SA5->( IndexOrd() )
		SA5->( DbSetOrder( 13 ) )
		If SA5->( DbSeek( XFilial( "SA5" ) + cCodPrd ) )

			Do While !SA5->( Eof() ) .And. ;
					AllTrim( SA5->A5_FILIAL ) == AllTrim( XFilial( "SA5" ) ) .And. ;
					AllTrim( SA5->A5_CODPRF ) == AllTrim( cCodPrd )

				If AllTrim( SA2->A2_COD  ) == AllTrim( SA5->A5_FORNECE ) .And. ;
						AllTrim( SA2->A2_LOJA ) == AllTrim( SA5->A5_LOJA    )

					If SB1->( DbSeek( XFilial( "SB1" ) + SA5->A5_PRODUTO ) )

						cRetorno := SB1->B1_COD
						cDESCPTH := SB1->B1_DESC
						cUNPTH   := SB1->B1_UM

					EndIf
					Exit

				EndIf
				SA5->( DbSkip() )
			EndDo

		EndIf
		SA5->( DbSetOrder( nOrdemSA5 ) )

	EndIf

Return cRetorno


*-----------------------------*
Static Function FRetTag( cStr )
	*-----------------------------*

	cRetorno := ""
	If Type( cStr ) != "U"
		cRetorno := &cStr
	EndIf

Return( cRetorno )

*---------------------------------*
Static Function FRetNumNF( cNumNF )
	*---------------------------------*

	cRetorno 	:= cNumNF
	aTam		:= TamSX3( "F1_DOC" )
	If nQtCarNF == 0
		cRetorno := PadR(AllTrim(cNumNF),aTam[1])
	Else
		If nQtCarNF > aTam[1]
			nQtCarNF:= aTam[1]
		EndIf
		cRetorno := PadR( StrZero( Val( cNumNF ), nQtCarNf), aTam[01] )
	EndIf

Return(cRetorno)


Static Function FDadosNF()


	If TMPNF->Finalid == "1"
		cExtFinali:="NORMAL"
	ElseIf TMPNF->Finalid == "2"
		cExtFinali:="COMPLEMENTO/AJUSTE"
	Else
		cExtFinali:="DEVOLUÇÃO/RETORNO"
	EndIf

	// Inclui conteudo das variaveis nos objetos SAY do fornecedor
	oSayNumNF:cCaption 	:= TMPNF->NUMNF
	oSaySerie:cCaption 	:= TMPNF->SerNF
	oSayValNF:cCaption 	:= AllTrim( Transform( TMPNF->VALORNF, "@E 999,999,999,999.99" ) )
	oSayEmis:cCaption 	:= DToC( TMPNF->EMISSAO )
	oSayProt:cCaption 	:= TMPNF->PROTOCOL
	oSayFinali:cCaption := cExtFinali

Return .T.


Static Function FDadosFornec()


	If TMPNF->( Eof() )
		Return .T.
	EndIf

	cStatus  := "2"  // 1=Fornecedor OK, 2=Fornecedor não localizado 3=Fornecedor com dados incompativeis 4=Já Importado
	lLocForn := .F.
	nOrdemSA2 := SA2->( DbSetOrder( 03 ) )  // SA2 ordenada por Filial + CNPJ
	If SA2->( DbSeek( XFilial( "SA2" ) + TMPNF->CNPJ ) )

		If Empty( TMPNF->CODFRN )

			DbSelectArea( "TMPNF" )
			RecLock( "TMPNF", .F. )
			TMPNF->CODFRN  := SA2->A2_COD
			TMPNF->LOJAFRN := SA2->A2_LOJA
			TMPNF->( MsUnLock() )

		EndIf

		cStatus  := "1"
		lLocForn := .T.

	EndIf

	// Inclui conteudo das variaveis nos objetos SAY do fornecedor
	oSayFornec:cCaption := TMPNF->NomEmit
	oSayCNPJ:cCaption   := TMPNF->CNPJ
	oSayIE:cCaption     := TMPNF->IEEmit
	oSayCMun:cCaption   := TMPNF->CdMumEmit
	oSayLograd:cCaption := TMPNF->LgrEmit
	oSayNum:cCaption    := TMPNF->NLgrEmit
	oSayBairro:cCaption := TMPNF->BairroEmit
	oSayCidade:cCaption := TMPNF->MunicEmit
	oSayUF:cCaption     := TMPNF->UFEmit
	oSayCEP:cCaption    := TMPNF->CEPEmit

	// Muda a cor caso nao ache o fornecedor ou os dados estejam diferentes
	oSayCNPJ:nClrText   := Iif( lLocForn,8388608,70000)
	oSayFornec:nClrText := Iif( lLocForn .And. Upper( AllTrim( TMPNF->NomEmit    ) ) $ Upper( SA2->A2_NOME )   , 8388608, 70000 )
	oSayIE:nClrText     := Iif( lLocForn .And. Upper( AllTrim( TMPNF->IEEmit     ) ) $ Upper( SA2->A2_INSCR )  , 8388608, 70000 )
	oSayCMun:nClrText   := Iif( lLocForn .And. Upper( AllTrim( TMPNF->CdMumEmit  ) ) $ Upper( SA2->A2_COD_MUN ), 8388608, 70000 )
	oSayLograd:nClrText := Iif( lLocForn .And. Upper( AllTrim( TMPNF->LgrEmit    ) ) $ Upper( SA2->A2_END )    , 8388608, 70000 )
	oSayNum:nClrText    := Iif( lLocForn .And. Upper( AllTrim( TMPNF->NLgrEmit   ) ) $ Upper( SA2->A2_END )    , 8388608, 70000 )
	oSayBairro:nClrText := Iif( lLocForn .And. Upper( AllTrim( TMPNF->BairroEmit ) ) $ Upper( SA2->A2_BAIRRO ) , 8388608, 70000 )
	oSayCidade:nClrText := Iif( lLocForn .And. Upper( AllTrim( TMPNF->MunicEmit  ) ) $ Upper( SA2->A2_MUN )    , 8388608, 70000 )
	oSayUF:nClrText     := Iif( lLocForn .And. Upper( AllTrim( TMPNF->UFEmit     ) ) $ Upper( SA2->A2_EST )    , 8388608, 70000 )
	oSayCEP:nClrText    := Iif( lLocForn .And. Upper( AllTrim( TMPNF->CEPEmit    ) ) $ Upper( SA2->A2_CEP )    , 8388608, 70000 )

	If  !Upper( AllTrim( TMPNF->NomEmit   ) ) $ Upper( SA2->A2_NOME    ) .Or. ;
			!Upper( AllTrim( TMPNF->IEEmit    ) ) $ Upper( SA2->A2_INSCR   ) .Or. ;
			!Upper( AllTrim( TMPNF->CdMumEmit ) ) $ Upper( SA2->A2_COD_MUN ) .Or. ;
			!Upper( AllTrim( TMPNF->LgrEmit   ) ) $ Upper( SA2->A2_END     ) .Or. ;
			!Upper( AllTrim( TMPNF->NLgrEmit  ) ) $ Upper( SA2->A2_END	   ) .Or. ;
			!Upper( AllTrim( TMPNF->BairroEmit) ) $ Upper( SA2->A2_BAIRRO  ) .Or. ;
			!Upper( AllTrim( TMPNF->MunicEmit ) ) $ Upper( SA2->A2_MUN	   ) .Or. ;
			!Upper( AllTrim( TMPNF->UFEmit    ) ) $ Upper( SA2->A2_EST	   ) .Or. ;
			!Upper( AllTrim( TMPNF->CEPEmit   ) ) $ Upper( SA2->A2_CEP	   )
		If cStatus == "1"
			cStatus:="3"
		EndIf

	EndIf

	If TMPNF->STATUS != "4"

		DbSelectArea( "TMPNF" )
		RecLock( "TMPNF", .F. )
		TMPNF->STATUS := cStatus
		TMPNF->( MsUnLock() )

	EndIf

	oBtnIncAlt:lVisibleControl:=.T.
	If cStatus = "1"
		oBtnIncAlt:lVisibleControl:=.F.
	ElseIf cStatus = "2"
		oBtnIncAlt:cCaption := "Incluir"
		oBtnIncAlt:bAction  := {|| FManipForn( "I" ) }
	Else
		oBtnIncAlt:cCaption := "Alterar"
		oBtnIncAlt:bAction  := { || FManipForn( "A" ) }
	EndIf

	// Filtra Itens referente a nota
	TMPIT->(DbSetFilter({|| TMPIT->CNPJ == TMPNF->CNPJ .And. TMPIT->NUMNF == TMPNF->NUMNF }, "TMPIT->CNPJ == TMPNF->CNPJ .And. TMPIT->NUMNF == TMPNF->NUMNF"))
	TMPIT->(DbGoTop())
	While ! TMPIT->(Eof())
		If TMPIT->STATUS == "0"
			If TMPNF->(RecLock("TMPNF",.F.))
				TMPNF->STATUS:="2"
				TMPNF->(DbUnLock())
			EndIf
		EndIf
		TMPIT->(DbSkip())
	End
	TMPIT->(DbGoTop())
	oBrwIT:OBROWSE:Refresh()

Return(.T.)

*-------------------------------*
Static Function FManipForn( cTp )
	*-------------------------------*

	nRetorno 	:= 0
	nRecSA2		:= SA2->( RecNo() )
	cCadastro	:= "Cadastro de Fornecedores"
	If cTp == "A"

		cCadastro += " - Alterando"
		nRetorno  := AxAltera( "SA2", nRecSA2, 04 ) // Se retornar 3 // Cancelou

	Else

		cCadastro += " - Incluindo"
		nRetorno  := AxInclui( "SA2", SA2->( RecNo() ), 04,, "U_FAliCpo" )

	EndIf

	If nRetorno == 01
		FDadosFornec()
	EndIf

Return Nil

*---------------------*
User Function FAliCpo()
	*---------------------*

	M->A2_LOJA   := 		 "01"
	M->A2_CGC    :=	 		 TMPNF->CNPJ
	M->A2_NOME   := Upper( 	 TMPNF->NomEmit )
	M->A2_NREDUZ := Upper( 	 TMPNF->NomEmit )
	M->A2_END    := AllTrim( TMPNF->LgrEmit ) + ", " + TMPNF->NLgrEmit
	M->A2_BAIRRO := Upper( 	 TMPNF->BairroEmit )
	M->A2_MUN    := Upper( 	 TMPNF->MunicEmit )
	M->A2_COD_MUN:= 		 TMPNF->CdMumEmit
	M->A2_EST    := UPPER( 	 TMPNF->UFEmit )
	M->A2_CEP    := 		 TMPNF->CEPEmit
	M->A2_INSCR  := 		 TMPNF->IEEmit
	M->A2_TIPO   := 		 "J"

Return Nil

********************************************************
Static Function fEditaBrw(oBrw,cCampo,cAlias,cF3,bValid)
	********************************************************

	Local _xVar    := (cAlias)->&cCampo.
	Local _oDlg    := Nil
	Local _oBtn    := Nil
	Local _sPict   := ""
	Local _aEstrut := dbstruct()
	Local _sPict := oBrw:OBROWSE:ACOLUMNS[oBRW:OBROWSE:COLPOS]:CPICTURE

	If oBrw:oBrowse:ColPos # 4 .And. cAlias == "TMPIT"
		Return(.T.)
	EndIf

	If oBrw:oBrowse:ColPos # 6 .And. cAlias == "TMPNF" // a coluna 6 é a coluna do codigo do fornecedor, caso nao esteja posicionado nesta coluna deve retornar
		(cAlias)->(RecLock(cAlias,.F.))
		If (cAlias)->OK == cMark
			(cAlias)->OK:=""
		Else
			(cAlias)->OK:=cMark
		EndIf
		(cAlias)->(DbUnLock())
		Return(.T.)
	EndIf

	// Obtem as coordenadas da celula (lugar onde a janela de edicao deve ficar)
	oRect := tRect():New(0,0,0,0)
	oBrw:oBrowse:GetCellRect(oBrw:oBrowse:nColPos,,oRect)
	aDim := {oRect:nTop,oRect:nLeft,oRect:nBottom,oRect:nRight}

	// Monta dialogo de tamanho 0, para ter onde colocar o get.
	DEFINE MSDIALOG _oDlg OF oBrw:oBrowse:oWnd FROM 0, 0 TO 0, 0 STYLE nOR( WS_VISIBLE, WS_POPUP ) PIXEL
	// Gera get sobre a celula, dando a impressao que a mesma estah sendo editada.
	oGet1:= TGet():New( 0,0,{|u| If(PCount()>0,_xVar:=u,_xVar)},_oDlg,0,0,_sPict,&bValid.,CLR_BLACK,CLR_WHITE,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,cF3, "_xVar",,,,.T.)
	oGet1:Move(-2,-2, (aDim[ 4 ] - aDim[ 2 ]) + 4, aDim[ 3 ] - aDim[ 1 ] + 4 )

	// Botao de tamanho 0 para pegar o aspassimplesenteraspassimples.
	@ 0, 0 BUTTON _oBtn PROMPT "ze" SIZE 0,0 OF _oDlg
	_oBtn:bGotFocus := {|| _oDlg:nLastKey := VK_RETURN, _oDlg:End(0)}
	ACTIVATE MSDIALOG _oDlg ON INIT _oDlg:Move(aDim[1],aDim[2],aDim[4]-aDim[2], aDim[3]-aDim[1])

	// Grava o novo valor no arquivo.
	//   If (cAlias)->(RecLock(cAlias, .F.))
	//      (cAlias)->&cCampo.:= _xVar
	//      (cAlias)->(DbUnLock())
	//   EndIf

	// Atualiza o browse em tela.
	oBrw:oBrowse:Refresh ()
return

*-------------------------------*
Static Function fValForn( cForn )
	*-------------------------------*

	If Empty( cForn )

		MsgStop( "Campo deve ser informado.", "Atenção" )

	Else

		nOrdSA2 := SA2->( DbSetOrder( 01 ) )
		If SA2->( DbSeek( XFilial( "SA2" ) + cForn ) )

			If AllTrim( TMPNF->CNPJ ) != AllTrim( SA2->A2_CGC )

				MsgStop( "O CNPJ/CPF da nota fiscal não é igual ao CNPJ/CPF do fornecedor selecionado.", "Atenção" )
				SA2->( DbSetOrder( nOrdSA2 ) )
				Return .F.

			Else

				DbSelectArea( "TMPNF" )
				RecLock( "TMPNF", .F. )

				TMPNF->CODFRN 	:= cForn
				TMPNF->NOMFRN 	:= SA2->A2_NOME
				TMPNF->LOJAFRN	:= SA2->A2_LOJA

				TMPNF->( DbUnLock() )

				SA2->( DbSetOrder( nOrdSA2 ) )
				FDadosFornec()
				Return .T.

			EndIf

		Else

			MsgStop( "Código do fornecedor informado não localizado.", "Atenção" )
			SA2->( DbSetOrder( nOrdSA2 ) )

		EndIf

	EndIf

Return .F.

*-------------------------------*
Static Function fValProd( cProd )
	*-------------------------------*

	If Empty( cProd )

		MsgStop( "Código do Produto deve ser informado.", "Atenção" )

	Else

		nOrdSB1 := SB1->( IndexOrd() )
		SB1->( DbSetOrder( 01 ) )
		If SB1->( DbSeek( XFilial( "SB1" ) + cProd ) )

			If MsgYesNo( "Ao importar o XML, o Produto " + AllTrim( cProd ) + " será associado ao código " + TMPIT->CODIGO + " do fornecedor " + AllTrim( TMPNF->CODFRN ) + "-"  + AllTrim( TMPNF->NOMFRN ) + ". Confirma ?", "Atenção")

				DbSelectArea( "TMPIT" )
				RecLock( "TMPIT", .F. )
				TMPIT->CODPRT	:= cProd
				TMPIT->STATUS	:= "1"
				TMPIT->( DbUnLock() )
				SB1->( DbSetOrder( nOrdSB1 ) )
				Return .T.

			EndIf

		Else

			MsgStop( "Código do produto informado não localizado.", "Atenção" )
			SB1->( DbSetOrder( nOrdSB1 ) )

		EndIf

	EndIf

Return .F.

*****************************
Static Function fFilBrwForn()
	*****************************

	cFiltro :="    "
	cFiltro1:=".And.("
	If lCBox1
		cFiltro+="TMPNF->STATUS == '1 ' .Or." // Tudo OK para importacao
	EndIf
	If lCBox2
		cFiltro+="TMPNF->STATUS == '2 ' .Or." // Fornecedor não localizado ou nao associado
	EndIf
	If lCBox3
		cFiltro+="TMPNF->STATUS == '3 ' .Or." // Fornecedor com divergência nos dados
	EndIf
	If lCBox4
		cFiltro+="TMPNF->STATUS == '4 ' .Or." // Já importado
	EndIf
	If lCBox5
		cFiltro1+="TMPNF->FINALID = '1' .Or."  // Nota Fiscal Normal
	EndIf
	If lCBox6
		cFiltro1+="TMPNF->FINALID = '4' .Or."  // Nota Fscal de Devolução/Retorno
	EndIf
	If lCBox7
		cFiltro1+="TMPNF->FINALID $ '2|3' .Or."// Nota Fiscal de Complemento/Ajuste
	EndIf
	If ! cFiltro1 == ".And.("
		cFiltro1:=Left(AllTrim(cFiltro1),Len(cFiltro1)-5) + ")"
		If Len(AllTrim(cFiltro)) == 0
			cFiltro1:=StrTran(cFiltro1, ".And.", "")
		EndIf
	Else
		cFiltro1:=""
	EndIf

	cFiltro:=AllTrim(Left(cFiltro,Len(cFiltro)-5)) + cFiltro1
	If Len(cFiltro) > 4
		TMPNF->(DbSetFilter({|| &cFiltro. }, cFiltro ))
	Else
		TMPNF->(DBClearFilter())
	EndIf
	TMPNF->(DbGoTop())
	oBrwNF:OBROWSE:Refresh()
	FDadosFornec()
	fDadosNF()

Return(.T.)

*-----------------------------*
Static Function FSelPC( lProd )
	*-----------------------------*
	Private oOk  		:= LoadBitmap( GetResources(), "LBOK" )
	Private oNo  		:= LoadBitmap( GetResources(), "LBNO" )

	Private cGetSPCCod 	:= TMPNF->CODFRN
	Private cGetSPCNom 	:= TMPNF->NOMFRN
	Private aPCsForn   	:= {}

	If !fFiltraPed( lProd )
		MsgAlert( "Não há pedido(s) cadastrado(s) para o fornecedor " + AllTrim( cGetSPCCod ) + "-" + AllTrim( cGetSPCNom ) + ".", "Atenção" )
		Return
	EndIf

	oDlg2 := MSDialog():New( 091,232,425,759, "Lista de Pedidos de Compra",,,.F.,,,,,,.T.,,,.T. )
	oGrpSPC1 := TGroup():New( 000,005,024,265, "Fornecedor",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oGetSPCCod := TGet():New( 008,009,{|u| If(PCount()>0,cGetSPCCod :=u,cGetSPCCod )},oGrpSPC1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T., "",,,.F.,.F.,,.F.,.F., "", "cGetSPCCod" ,,)
	oGetSPCNom := TGet():New( 008,073,{|u| If(PCount()>0,cGetSPCNome:=u,cGetSPCNome)},oGrpSPC1,184,008,'',,CLR_BLACK,CLR_WHITE,,,,.T., "",,,.F.,.F.,,.F.,.F., "", "cGetSPCNome",,)
	oGetSPCCod:Disable()
	oGetSPCNom:Disable()

	oGrpSPC2:= TGroup():New( 024,005,148,265, "",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
	@ 026,007 ListBox oLstBxPC Fields ;
		HEADER "", "Fil", "Pedido", "Emissão", "Cond.", "Item", "Produto", "Descrição", "Quant.", "Preço";
		Size 259,120 Of oGrpSPC2 Pixel;
		ColSizes 05, 10, 10, 10, 20, 10, 20, 60, 20, 25;
		On DBLCLICK fMarcaColPC( lProd )

	oLstBxPC:SetArray(aPCsForn)
	oLstBxPC:bLine:= {|| {IIf(aPCsForn[oLstBxPC:nAT,01],oOk,oNo) ,;
		AllTrim( aPCsForn[oLstBxPC:nAT,02] ) ,;
		AllTrim( aPCsForn[oLstBxPC:nAT,03] ) ,;
		DToC( aPCsForn[oLstBxPC:nAT,04] ) ,;
		AllTrim( aPCsForn[oLstBxPC:nAT,05] ) ,;
		AllTrim( aPCsForn[oLstBxPC:nAT,06] ) ,;
		AllTrim( aPCsForn[oLstBxPC:nAT,07] ) ,;
		AllTrim( aPCsForn[oLstBxPC:nAT,08] ) ,;
		AllTrim( TransForm( aPCsForn[oLstBxPC:nAt,09], "@E 999,999.99" ) ) ,;
		AllTrim( TransForm( aPCsForn[oLstBxPC:nAt,10], "@E 999,999,999.99" ) ) }}

	oBtnSPCSel := TButton():New( 152,005, "&Selecionar"   ,oDlg2,{|| fSelecPed( lProd )},037,012,,,,.T.,, "",,,,.F. )
	oBtnVerPc  := TButton():New( 152,190, "&Vizualizar PC",oDlg2,{|| fVerPC()   },037,012,,,,.T.,, "",,,,.F. )
	oBtnSPCSai := TButton():New( 152,229, "S&air"         ,oDlg2,{|| oDlg2:End()},037,012,,,,.T.,, "",,,,.F. )

	oDlg2:Activate(,,,.T.)

Return()

*--------------------------------*
Static Function fSelecPed( lProd )
	*--------------------------------*
	Local aAreaAnt := GetArea()
	Local aAreaSC7 := SC7->( GetArea() )

	Local nX := 0

	nAreaSC7 := SC7->( IndexOrd() )
	SC7->( DbSetOrder( 02 ) )

	nRegIT := TMPIT->( RecNo() )
	For nX := 01 To Len( aPCsForn )

		If aPCsForn[nX][01]

			If !lProd

				nRegIT := TMPIT->( RecNo() )
				TMPIT->( DbGoTop() )
				Do While !TMPIT->( Eof() )

					If AllTrim( TMPIT->PEDIDO ) == ""

						DbSelectArea( "SC7" )
						DbSetOrder( 02 ) //C7_FILIAL + C7_PRODUTO + C7_FORNECE + C7_LOJA + C7_NUM
						Seek XFilial( "SC7" ) + PadR( AllTrim( TMPIT->CODPRT ), TamSX3( "C7_PRODUTO" )[01] ) + TMPNF->CODFRN + TMPNF->LOJAFRN + aPCsForn[nX][03]
						If Found()

							If ( SC7->C7_QUANT - ( SC7->C7_QUJE + SC7->C7_QTDACLA ) ) > 0

								//TMPIT->VLRTOT
								If ( Round( SC7->C7_PRECO, 02 ) == Round( TMPIT->VLRUNIT, 02 ) )

									DbSelectArea( "TMPIT" )
									RecLock( "TMPIT", .F. )
									TMPIT->PEDIDO 	:= SC7->C7_NUM
									TMPIT->ITEMPC 	:= SC7->C7_ITEM
									TMPIT->CONDICAO := SC7->C7_COND
									TMPIT->( MsUnLock() )

								Else

									If Aviso( "Atenção", "O Valor para o Item [" + AllTrim( TMPIT->CODPRT ) + "] do Pedido [" + AllTrim( SC7->C7_NUM ) + "] está divergente do valor do Item na Nota." + CRLF + "Deseja associar mesmo assim?" + CRLF + "Valor no Pedido: " + TransForm( SC7->C7_PRECO, "@E 999,999,999.99" ) + CRLF + "Valor da Nota: " + TransForm( TMPIT->VLRUNIT, "@E 999,999,999.99" ), { "Sim", "Não" } ) == 01

										DbSelectArea( "TMPIT" )
										RecLock( "TMPIT", .F. )
										TMPIT->PEDIDO 	:= SC7->C7_NUM
										TMPIT->ITEMPC 	:= SC7->C7_ITEM
										TMPIT->CONDICAO := SC7->C7_COND
										TMPIT->( MsUnLock() )

									EndIf

								EndIf

							Else

								Aviso( "Atenção", "O Pedido [" + SC7->C7_NUM + "] não possui saldo disponível para a quantidade solicitada para o produto [" + TMPIT->CODPRT + "].", { "Voltar" } )

							EndIf

							Exit

						EndIf

					EndIf

					DbSelectArea( "TMPIT" )
					TMPIT->( DbSkip() )
				EndDo
				TMPIT->( DbGoTo( nRegIT ) )

			Else
				dbSelectArea("SC7")
				dbSetOrder(1)
				dbSeek(XFilial("SC7")+aPCsForn[nX][03]+aPCsForn[nX][06])

				If ( SC7->C7_QUANT - ( SC7->C7_QUJE + SC7->C7_QTDACLA ) ) > 0
					//			If ( SC7->C7_QUANT - aPCsForn[nX][09] ) > 0

					//If Abs( Round( SC7->C7_PRECO, 02 ) - Round( aPCsForn[nX][10], 02 ) ) > 0.02
					If ( Round( TMPIT->VLRUNIT, 02 ) == Round( aPCsForn[nX][10], 02 ) )

						DbSelectArea( "TMPIT" )
						RecLock( "TMPIT", .F. )

						TMPIT->PEDIDO 	:= aPCsForn[nX][03] // SC7->C7_NUM
						TMPIT->ITEMPC 	:= aPCsForn[nX][06] // SC7->C7_ITEM
						TMPIT->CONDICAO := aPCsForn[nX][05] // SC7->C7_COND

						TMPIT->( MsUnLock() )

					Else

						If Aviso( "Atenção", "O Valor para o Item [" + AllTrim( aPCsForn[nX][06] ) + "] do Pedido [" + AllTrim( aPCsForn[nX][03] ) + "] está divergente do valor do Item na Nota." + CRLF + "Deseja associar mesmo assim?" + CRLF + "Valor no Pedido: " + TransForm( aPCsForn[nX][10], "@E 999,999,999.99" ) + CRLF + "Valor da Nota: " + TransForm( TMPIT->VLRUNIT, "@E 999,999,999.99" ), { "Sim", "Não" } ) == 01

							DbSelectArea( "TMPIT" )
							RecLock( "TMPIT", .F. )

							TMPIT->PEDIDO 	:= aPCsForn[nX][03] // SC7->C7_NUM
							TMPIT->ITEMPC 	:= aPCsForn[nX][06] // SC7->C7_ITEM
							TMPIT->CONDICAO := aPCsForn[nX][05] // SC7->C7_COND

							TMPIT->( MsUnLock() )

						EndIf

					EndIf

				Else

					Aviso( "Atenção", "O Pedido [" + SC7->C7_NUM + "] não possui saldo disponível para a quantidade solicitada para o produto [" + TMPIT->CODPRT + "].", { "Voltar" } )

				EndIf

			EndIf

			TMPIT->( DbGoTo( nRegIT ) )

		EndIf

	Next nX

	SC7->( DbSetOrder( nAreaSC7 ) )
	oDlg2:End()

	RestArea( aAreaSC7 )
	RestArea( aAreaAnt )

Return

*---------------------------------*
Static Function FFiltraPed( lProd )
	*---------------------------------*

	cQry := "		SELECT  DISTINCT 	  "
	cQry += "       		C7_FILIAL  	, "
	cQry += "       		C7_NUM     	, "
	cQry += "       		C7_EMISSAO  , "
	cQry += "       		C7_COND     , "
	cQry += "       		C7_ITEM     , "
	cQry += "       		C7_PRODUTO  , "
	cQry += "				B1_DESC		, "
	cQry += "       		( C7_QUANT  - C7_QUJE - C7_QTDACLA ) AS C7_QUANT, "
	cQry += "				C7_PRECO	  "
	cQry += "		   FROM " + RetSQLName( "SC7" ) + " SC7, "
	cQry += "		        " + RetSQLName( "SB1" ) + " SB1  "
	cQry += "		  WHERE C7_FILIAL   = '" + XFilial( "SC7" ) + "' "
	cQry += "      	    AND C7_FORNECE  = '" + TMPNF->CODFRN 	+ "' "
	cQry += "      	    AND C7_LOJA     = '" + TMPNF->LOJAFRN	+ "' " // Solicitacao da SRD
	If lProd
		cQry += "		AND	C7_PRODUTO  = '" + TMPIT->CODPRT	+ "' "
	EndIf
	cQry += "    		AND ( C7_QUANT  - C7_QUJE - C7_QTDACLA ) > 0 "
	cQry += "    		AND C7_RESIDUO  = ' ' "
	cQry += "    		AND C7_TPOP    != 'P' "
	cQry += "    		AND SC7.D_E_L_E_T_  = ' ' "
	cQry += "    		AND SB1.D_E_L_E_T_  = ' ' "
	//If AllTrim( GetNewPar( "MV_RESTNFE", "S" ) ) == "S"
	cQry += "    	AND C7_CONAPRO 	!= 'B' "
	//EndIf
	cQry += "    		AND B1_FILIAL   = '" + XFilial( "SB1" ) + "' "
	cQry += "    		AND B1_COD 	    = C7_PRODUTO "

	MemoWrite( "c:\temp\UNIA004SelPed.sql", cQry )
	DbUseArea( .T., "TOPCONN", TCGenQry( ,, cQry ), "QRY", .F., .T.)
	QRY->( DbGoTop() )
	If QRY->( Eof() )
		QRY->( DbCloseArea() )
		Return .F.
	EndIf

	aPCsForn := {}
	Do While !QRY->( Eof() )

		aAdd( aPCsForn, {  .F., QRY->C7_FILIAL		,;
			QRY->C7_NUM			,;
			SToD( QRY->C7_EMISSAO )	,;
			QRY->C7_COND 		,;
			QRY->C7_ITEM		,;
			QRY->C7_PRODUTO		,;
			QRY->B1_DESC		,;
			QRY->C7_QUANT		,;
			QRY->C7_PRECO		})

		QRY->( DbSkip() )
	EndDo
	QRY->( DbCloseArea() )

	If Len( aPCsForn ) == 0

		aAdd( aPCsForn, {  .F., ""			,;
			""			,;
			DToC( CToD( "" ) )	,;
			"" 			,;
			""			,;
			""			,;
			""			,;
			0			,;
			0			})

	EndIf

Return .T.

*----------------------------------------*
Static Function FMarcaColPC( lAuxProduto )
	*----------------------------------------*
	Local lMarcaDesmarca 	:= !aPCsForn[oLstBxPC:nAT][01]
	Local cAuxPedido 		:= aPCsForn[oLstBxPC:nAT][03]

	If lAuxProduto

		aPCsForn[oLstBxPC:nAT][01] := !aPCsForn[oLstBxPC:nAT][01]

	Else

		For nH := 01 To Len( aPCsForn )

			If AllTrim( cAuxPedido ) == AllTrim( aPCsForn[nH][03] )
				aPCsForn[nH][01] := lMarcaDesmarca
			EndIf

		Next nH
		oLstBxPC:Refresh()

	EndIf

Return .T.


Static Function FVerPC()

	aAreaAnt := GetArea()
	aAreaSC7 := SC7->( GetArea() )

	DbSelectArea( "SC7" )
	SC7->( DbSetOrder( 01 ) )
	If SC7->( DbSeek( XFilial( "SC7" ) + aPCsForn[oLstBxPC:nAT][03] ) )
		Mata120( 02,,, 02 )
	EndIf

	RestArea( aAreaSC7 )
	RestArea( aAreaAnt )

Return .T.


Static Function FConForn()


	If ConPad1( ,,, "SA2",,, .F. )

		If AllTrim(SA2->A2_CGC ) != AllTrim( TMPNF->CNPJ )

			Aviso( "Atenção", "CNPJ do fornecedor selecionado diferente na NFe.", { "Voltar" } )
			Return .F.

		Else

			RecLock( "TMPNF", .F. )
			TMPNF->CODFRN := SA2->A2_COD
			TMPNF->( MsUnLock() )

		EndIf

	EndIf

Return .T.


Static Function FConProd()


	If ConPad1( ,,, "SB1",,, .F. )

		DbSelectArea( "TMPIT" )
		RecLock( "TMPIT", .F. )
		If Aviso( "Atenção", "Ao importar o XML, o Produto "  + AllTrim( SB1->B1_COD ) + " será associado ao código " + TMPIT->CODIGO + " do fornecedor " + AllTrim( TMPNF->CODFRN ) + "-" + AllTrim( TMPNF->NOMFRN ) + ". Confirma ?", { "Sim", "Não" } ) == 01
			TMPIT->CODPRT := SB1->B1_COD
			TMPIT->STATUS := "1"
			TMPIT->( MsUnLock() )
		EndIf

	EndIf

Return .T.

*--------------------------*
Static Function fGrPreNota()
	*--------------------------*

	If Aviso( "Atenção", "A(s) nota(s) selecionada(s) sera(ão) gravada(s). Confirma?", { "Sim", "Não" } ) == 02
		Return Nil
	EndIf

	lTemPendencia := .F.
	DbSelectArea( "TMPIT" )
	DbGoTop()
	Do While !TMPIT->( Eof() )

		If AllTrim( TMPIT->PEDIDO ) == ""
			MsgStop( "Existem Itens sem associação com o Pedido de Compras. A Pré-nota não será importada." + CRLF + "Produto: " + TMPIT->CODPRT, "Atenção" )
			lTemPendencia := .T.
			Exit
		EndIf

		DbSelectArea( "TMPIT" )
		TMPIT->( DbSkip() )
	EndDo

	If !lTemPendencia
		Processa( { || FGrvPNT() }, "Gravando Pré-Nota dos XMLs selecionados..." )
	EndIf

Return Nil

*-----------------------*
Static Function FGrvPNT()
	*-----------------------*

	nRegTMPNF := TMPNF->( RecNo() )

	ProcRegua( TMPNF->( RecCount() ) )
	TMPNF->( DbGoTop() )
	Do While !TMPNF->( Eof() )

		IncProc()

		If  Empty( TMPNF->OK ) .Or.; 		  // Não importa xml das notas nao marcadas
				AllTrim( TMPNF->STATUS ) == "4"   // Não importa notas já importadas

			TMPNF->( DbSkip() )
			Loop
		EndIf

		aCabNF  := {}
		aItens  := {}

		// Finalidade da nota fiscal (1=Normal 2=Complementar 3=Ajuste 4=Devolucao/Retorno) Campo no XML->oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_FINNFE:TEXT")
		If AllTrim( TMPNF->FINALID ) == "2"
			cTipo := "I"
		ElseIf AllTrim( TMPNF->FINALID ) $ "3|4"
		Else
			cTipo := "N"
		EndIf

		aAdd( aCabNF, { "F1_FILIAL" , XFilial( "SF1" ), Nil, Nil } )
		aAdd( aCabNF, { "F1_DOC"    , TMPNF->NUMNF    , Nil, Nil } )
		aAdd( aCabNF, { "F1_SERIE"  , TMPNF->SERNF    , Nil, Nil } )
		aAdd( aCabNF, { "F1_FORNECE", TMPNF->CODFRN   , Nil, Nil } )
		aAdd( aCabNF, { "F1_LOJA"   , TMPNF->LOJAFRN  , Nil, Nil } )
		aAdd( aCabNF, { "F1_EMISSAO", TMPNF->EMISSAO  , Nil, Nil } )
		aAdd( aCabNF, { "F1_EST"    , TMPNF->UFEmit   , Nil, Nil } )
		aAdd( aCabNF, { "F1_FRETE"  , TMPNF->FRETE    , Nil, Nil } )
		aAdd( aCabNF, { "F1_DESPESA", TMPNF->DESPESAS , Nil, Nil } )
		aAdd( aCabNF, { "F1_TIPO"   , cTipo           , Nil, Nil } )
		aAdd( aCabNF, { "F1_DESCONT", TMPNF->DESCONTO , Nil, Nil } )
		aAdd( aCabNF, { "F1_DTDIGIT", dDataBase       , Nil, Nil } )
		aAdd( aCabNF, { "F1_ESPECIE", "SPED"          , Nil, Nil } )
		aAdd( aCabNF, { "F1_CHVNFE" , TMPNF->CHAVENF  , Nil, Nil } )
		aAdd( aCabNF, { "F1_FORMUL" , "N"             , Nil, Nil } )

		lPrimeira := .T.
		// Filtra Itens referente a nota
		TMPIT->( DbSetFilter( { || AllTrim( TMPIT->CNPJ ) == AllTrim( TMPNF->CNPJ ) .And. AllTrim( TMPIT->NUMNF ) == AllTrim( TMPNF->NUMNF ) }, "TMPIT->CNPJ == TMPNF->CNPJ .And. TMPIT->NUMNF == TMPNF->NUMNF" ) )
		TMPIT->( DbGoTop() )
		lImpNF := .T.
		Do While ! TMPIT->( Eof() )

			// Se algum item não estiver associado a um produto no sistema a nota nao sera importada
			If Empty( TMPIT->CODPRT ) .Or. ! SB1->( DbSeek( XFilial( "SB1" ) + TMPIT->CODPRT ) )
				lImpNF:=.F.
				Exit
			EndIf

			If lPrimeira
				aAdd( aCabNF, { "F1_COND", TMPIT->CONDICAO, Nil, Nil } )
				lPrimeira := .F.
			EndIf

			If AllTrim( cTipo ) $ "B|D" // Tipo de nota B-Beneficiamento ou D-Devolucao verifica amarração de cliente X produto SA7

				nOrdSA7:= SA7->( IndexOrd() )
				SA7->( DbSetOrder(01) )
				If !SA7->( DbSeek( XFilial( "SA7" ) + TMPNF->CODFRN + TMPNF->LOJAFRN + TMPIT->CODPRT ) )

					DbSelectArea( "SA7" )
					RecLock( "SA7", .T. )

					SA7->A7_FILIAL  := xFilial("SA7")
					SA7->A7_CLIENTE := TMPNF->CODFRN
					SA7->A7_DESCCLI := TMPNF->NOMFRN
					SA7->A7_LOJA    := TMPNF->LOJAFRN
					SA7->A5_PRODUTO := TMPIT->CODPRT
					SA7->A5_CODCLI  := TMPIT->CODIGO
					SA7->( MsUnLock() )
				EndIf
				SA7->( DbSetOrder( nOrdSA7 ) )

			Else

				nOrdSA5 := SA5->( IndexOrd() )
				SA5->( DbSetOrder( 01 ) )
				If !SA5->( DbSeek( XFilial( "SA5" ) + TMPNF->CODFRN + TMPNF->LOJAFRN + TMPIT->CODPRT ) )

					DbSelectArea( "SA5" )
					RecLock( "SA5", .T. )

					SA5->A5_FILIAL  := XFilial( "SA5" )
					SA5->A5_FORNECE := TMPNF->CODFRN
					SA5->A5_LOJA    := TMPNF->LOJAFRN
					SA5->A5_NOMEFOR := TMPNF->NOMFRN
					SA5->A5_PRODUTO := TMPIT->CODPRT
					SA5->A5_NOMPROD := SB1->B1_DESC
					SA5->A5_CODPRF  := TMPIT->CODIGO

					SA5->( MsUnLock() )

				EndIf
				SA5->( DbSetOrder( nOrdSA5 ) )

			EndIf

			aLinha := {}
			aAdd( aLinha, { "D1_FILIAL" , XFilial("SD1"), Nil } )
			aAdd( aLinha, { "D1_COD"    , TMPIT->CODPRT , Nil } )
			aAdd( aLinha, { "D1_UM"   	, TMPIT->UNPTH  , Nil } )
			aAdd( aLinha, { "D1_QUANT"  , TMPIT->QTD    , Nil } )
			//aAdd( aLinha, { "D1_SEGUM", SB1->B1_SEGUM , Nil } ) // TMPIT->UN
			aAdd( aLinha, { "D1_SEGUM"  , TMPIT->UN		, Nil } ) //	 	Iif( AllTrim( TMPIT->UNPTH ) == "",  SB1->B1_UM, TMPIT->UNPTH ) , Nil } )
			//aAdd( aLinha, { "D1_QTSEGUM", TMPIT->QTD    , Nil } )
			aAdd( aLinha, { "D1_VUNIT"  , TMPIT->VLRUNIT, Nil } )
			aAdd( aLinha, { "D1_TOTAL"  , TMPIT->VLRTOT , Nil } )
			aAdd( aLinha, { "D1_LOCAL"  , SB1->B1_LOCPAD, Nil } )
			aAdd( aLinha, { "D1_FORNECE", TMPNF->CODFRN , Nil } )
			aAdd( aLinha, { "D1_LOJA"   , TMPNF->LOJAFRN, Nil } )
			aAdd( aLinha, { "D1_DOC"    , TMPNF->NUMNF  , Nil } )
			aAdd( aLinha, { "D1_EMISSAO", TMPNF->EMISSAO, Nil } )
			aAdd( aLinha, { "D1_SERIE"  , TMPNF->SERNF  , Nil } )
			aAdd( aLinha, { "D1_GRUPO"  , SB1->B1_GRUPO , Nil } )
			aAdd( aLinha, { "D1_TIPO"   , cTipo         , Nil } )
			aAdd( aLinha, { "D1_DTDIGIT", dDataBase     , Nil } )
			aAdd( aLinha, { "D1_TP"     , SB1->B1_TIPO  , Nil } )
			//Marcelo Amaral 11/11/2019
			aAdd( aLinha, { "D1_PEDIDO" , TMPIT->PEDIDO , Nil } )
			aAdd( aLinha, { "D1_ITEMPC" , TMPIT->ITEMPC , Nil } )
			aAdd( aItens, aLinha )

			TMPIT->( DbSkip() )
		EndDo
		If !lImpNF
			TMPNF->( DbSkip() )
			Loop
		EndIf

		lMsErroAuto := .F.
		MsExecAuto({ |x, y, z| MATA140( x, y, z ) }, aCabNF, aItens, 03 )
		If lMsErroAuto
			MostraErro()
		Else
			RecLock( "TMPNF", .F. )
			TMPNF->STATUS := "4"
			TMPNF->( MsUnLock() )
		EndIf
		cArqLeit := cPathXML    + AllTrim( TMPNF->NOMEARQ )
		cArqOrig := cPathEMP    + AllTrim( TMPNF->NOMEARQ )
		cArqDest := cPathEMPXML + AllTrim( TMPNF->NOMEARQ )
		If __CopyFile( cArqOrig, cArqDest )
			FErase( cArqOrig )
			FErase( cArqLeit )
		EndIf

		TMPNF->(DbSkip())
	EndDo
	TMPNF->( DbGoTo( nRegTMPNF ) )

	FDadosFornec()
	FDadosNF()

Return Nil

*-----------------------*
Static Function FRPOXML()
	*-----------------------*
	Local nX,nY,nZ

	oDlgRPOXML := MSDialog():New(165,312,535,834, "Repositório de XML Nota Fiscal Eletrônica",,,.F.,,,,,,.T.,,,.T. )
	oGrp1 := TGroup():New( 002,002,162,262, "",oDlgRPOXML,CLR_BLACK,CLR_WHITE,.T.,.F. )
	aNodes := {}
	nCount := 1 // ID dos itens da Tree

	// PRIMEIRO NÍVEL
	aAdd( aNodes, {'00', StrZero(nCount,7), "", "RPO de XML NFe", "FOLDER5" , "FOLDER6"} )
	aPastas:=Directory(cPathEMP + "XML" + IIf(lLinux, "\", "/") + "*.*", "D") // Abre as pastas com os Anos
	For nX := 1 To Len(aPastas)
		If aPastas[nX,1] == "." .Or. aPastas[nX,1] == ".."
			Loop
		EndIf
		nCount++

		// SEGUNDO NÍVEL (Anos)
		aAdd( aNodes, {'01', StrZero(nCount,7), "", aPastas[nX,1], "FOLDER5", "FOLDER6"} )
		aPstMes:=Directory(cPathEMP + "XML" + IIf(lLinux, "\", "/") + aPastas[nX,1] + IIf(lLinux, "\", "/") + "*.*", "D") // Incluir pastas com os meses
		For nY := 1 to Len(aPstMes)
			If aPstMes[nY,1] == "." .Or. aPstMes[nY,1] == ".."
				Loop
			EndIf
			nCount++

			// TERCEIRO NÍVEL (Meses)
			aAdd( aNodes, {'02', StrZero(nCount,7), "", aPstMes[nY,1], "FOLDER5", "FOLDER6"} )
			aPstArq:=Directory(cPathEMP + "XML" + IIf(lLinux, "\", "/") + aPastas[nX,1] + IIf(lLinux, "\", "/") + aPstMes[nY,1] + IIf(lLinux, "\", "/") +"*.XML", "D")
			For nZ := 1 to Len(aPstArq)
				If aPstArq[nZ,1] == "." .Or. aPstArq[nZ,1] == ".."
					Loop
				EndIf
				nCount++

				// Quarto Nivel (Arquivos XML dentro do mes)
				aAdd( aNodes, {'03',StrZero(nCount,7), "",aPstArq[nZ,1], "", "",cPathEMP + "XML" + IIf(lLinux, "\", "/") + aPastas[nX,1] + IIf(lLinux, "\", "/") + aPstMes[nY,1] + IIf(lLinux, "\", "/")} )
			Next nZ
		Next nY
	Next nX
	// Cria o objeto Tree
	oTree := DbTree():New(004,004,160,260,oGrp1,,,.T.)
	// Método para carga dos itens da Tree
	oTree:BeginUpdate()
	oTree:PTSendTree( aNodes )
	oTree:EndUpdate()
	oTree:SetScroll(1,.T.)
	oTree:SetScroll(2,.T.)
	oTree:BLDBLCLICK:={|| fAbrXMLTree()}
	oTree:PTRefresh()

	oGrp2 := TGroup():New( 162,002,180,188, "",oDlgRPOXML,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtn1 := TButton():New( 164,005, "Exportar XML"            ,oGrp2,{|| fExpXML()    },037,012,,,,.T.,, "",,,,.F. )
	//oBtn2 := TButton():New( 164,045, "Consultar Chave na SEFAZ",oGrp2,{|| fConsNFe()   },072,012,,,,.T.,, "",,,,.F. )
	//oBtn3 := TButton():New( 164,121, "Abrir XML"               ,oGrp2,{|| fAbrXMLTree()},037,012,,,,.T.,, "",,,,.F. )

	oGrp3 := TGroup():New( 162,195,180,256, "",oDlgRPOXML,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oBtn4 := TButton():New( 164,210, "Retornar",oGrp3,{|| oDlgRPOXML:End()},037,012,,,,.T.,, "",,,,.F. )

	oDlgRPOXML:Activate(,,,.T.)

Return(Nil)

*---------------------------*
Static Function FAbrXMLTree()
	*---------------------------*

	nPo := Val( oTree:CURRENTNODEID )
	If !".XML" $ aNodes[nPo][04]
		Return .F.
	EndIf

	cArqOrig := aNodes[nPo][07] + aNodes[nPo][04]
	cArqDest := "C:\" + aNodes[nPo][04]
	If __CopyFile( cArqOrig, cArqDest )
		ShellExecute( "Open", AllTrim( GetNewPar( "MV_XIEATAL", "%PROGRAMFILES%\Internet Explorer\iexplore.exe" ) ), cArqDest, "C:\", 01 )
		//fErase(cArqDest)
	EndIf

Return .T.


Static Function FConsNFe()


	nPo := Val( oTree:CURRENTNODEID )
	If !".XML" $ aNodes[nPo][04]
		Return .F.
	EndIf
	cChaveNFe := AllTrim( GetNewPar( "MV_XCHVNFE", "http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=&nfe=" ) ) + Left(aNodes[nPo][04], 44 )
	ShellExecute( "Open", AllTrim( GetNewPar( "MV_XIEATAL", "%PROGRAMFILES%\Internet Explorer\iexplore.exe" ) ), cChaveNFe, "", 01 )

Return .T.

*-----------------------*
Static Function FExpXML()
	*-----------------------*
	nPo := Val( oTree:CURRENTNODEID )
	If !".XML" $ aNodes[nPo][04]
		Return(.F.)
	EndIf

	cPasta := cGetFile( "*.*", "Selecione o local de destino do XML.",, "C:\",, 144 )
	If Len( AllTrim( cPasta ) ) != 0

		cArqOrig	:= aNodes[nPo][07] + aNodes[nPo][04]
		cArqDest	:= cPasta + aNodes[nPo][04]
		If __CopyFile( cArqOrig, cArqDest )
			Aviso( "Atenção", "Arquivo " + aNodes[nPo][4] + " copiado para pasta destino com sucesso!", { "Ok" } )
		Else
			Aviso( "Atenção", "Não foi possível copiar o arquivo.", "Atenção" )
		EndIf

	EndIf

Return .T.

*-----------------------*
Static Function FMsgXML()
	*-----------------------*

	cTexto 	:= TMPNF->MSGNF
	oDlg3	:= MSDialog():New( 154,258,350,635, "Mensagem da Nota",,,.F.,,,,,,.T.,,,.T. )
	oMGet1 	:= TMultiGet():New( 002,002,{|u|if(Pcount()>0,cTexto:=u,cTexto)}  ,oDlg3,188,076,,,CLR_BLACK,CLR_WHITE,,.T.)
	Btn1  	:= TButton():New( 080,078, "&Sair",oDlg3,{|| oDlg3:End()},037,012,,,,.T.,, "",,,,.F. )
	oDlg3:Activate( ,,, .T. )

Return .T.
