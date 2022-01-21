/*/
============================================================================
AUTOR     :  Renato Morcerf (Korus Consultoria)
----------------------------------------------------------------------------
DATA      :  06/04/2021
----------------------------------------------------------------------------
DESCRICAO :  
----------------------------------------------------------------------------
PARTIDA   :  Menu de Usuario
============================================================================
/*/

#include "rwmake.ch"
#include "tbicode.ch"
#include "tbiconn.ch

#DEFINE CRLF ( chr(13)+chr(10) )

User Function MT103FIM

Local nOpcAuto  := 3
Local cDoc	    := ""
Local aItemxp   := {}
Local aAuto     := {}

Private lMsHelpAuto := .T.
Private lMsErroAuto := .F.
Private _aArea    := GetArea()
Private cDt       := SF1->F1_EMISSAO
Private xF1FILIAL := SF1->F1_FILIAL
Private xF1DOC    := SF1->F1_DOC
Private xF1SERIE  := SF1->F1_SERIE  
Private nFornx    := SF1->F1_FORNECE
Private nLojx     := SF1->F1_LOJA
Private XFORNEC   := SF1->F1_FORNECE
Private XLOJA     := SF1->F1_LOJA
Private nOrigx    := ""
Private nSerx     := ""
Private NX        := 0
Private cArmx     := ""

cDoc      := ""

// So executa no LOJA720 - Rotina de troca
If Upper(Alltrim(Funname())) = "LOJA720"

  dbSelectArea("SD1")
  SD1->(dbSetOrder(1))
  SD1->(dbSeek(xF1FILIAL+xF1DOC+xF1SERIE+nFornx+nLojx))

  nOrigx := SD1->D1_NFORI  
  nSerx  := SD1->D1_SERIORI
	
  // Chama tela de motivo de devolução
 If !Empty(nOrigx)
  U_GERASZG(xF1FILIAL,nOrigx,nSerx,nFornx,nLojx,SD1->D1_EMISSAO)

  DbSelectArea("SZG")  /// Tabela de movimento de devolucao
  SZG->(DbSetOrder(1))

  dbSelectArea("SB2")
  SB2->(dbSetOrder(1))

  dbSelectArea("SD1")
  SD1->(dbSetOrder(1))
  IF SD1->(dbSeek(xF1FILIAL+xF1DOC+xF1SERIE+nFornx+nLojx))

	Do While !SD1->(EoF()) .and. xF1FILIAL+xF1DOC+xF1SERIE+XFORNEC+XLOJA==SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA
		
			nOrigx := SD1->D1_NFORI  
			nSerx  := SD1->D1_SERIORI
			cProdx := SD1->D1_COD
			cArmx  := "01"

			IF SZG->(DbSeek(xFilial("SZG") + nOrigx + nSerx + nFornx + nLojx))
				cArmx := SZG->ZG_LOCAL
			Endif

			// Verifica se armazem destino existe na SB2
            IF SB2->(DbSeek(xFilial("SB2") + cProdx + cArmx))
			Else
				SB2->(RecLock("SB2",.T.))
				SB2->B2_FILIAL := xFilial("SB2")
				SB2->B2_COD    := cProdx
				SB2->B2_LOCAL  := cArmx
				SB2->(MsUnlock())
			Endif

		    aItemxp := {}
			aLinha  := {}
		    aAuto   := {}
	    	cDoc    := ""
			NX      := NX +1
		
			ndesc   := POSICIONE("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_DESC")
			cunidx  := POSICIONE("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_UM")
			
			cDoc	:= xF1DOC  //GetSX8Num("SD3", "D3_DOC")
			//Cabecalho a Incluir
            aadd(aAuto,{cDoc         ,dDataBase}) //Cabecalho
			
			aadd(aLinha,{"ITEM"      ,'00'+cvaltochar(nX), Nil})
			aadd(aLinha,{"D3_COD"    , SD1->D1_COD       , Nil}) //Cod Produto origem 
			aadd(aLinha,{"D3_DESCRI" , ndesc             , Nil}) //descr produto origem 
			aadd(aLinha,{"D3_UM"     , cunidx            , Nil}) //unidade medida origem 
			aadd(aLinha,{"D3_LOCAL"  , SD1->D1_LOCAL     , Nil}) //armazem origem 
			aadd(aLinha,{"D3_LOCALIZ", PadR("ENDER01", tamsx3('D3_LOCALIZ') [1]),Nil}) //Informar endereço origem

			//Destino 
			aadd(aLinha,{"D3_COD"    , SD1->D1_COD       , Nil}) //cod produto destino 
			aadd(aLinha,{"D3_DESCRI" , ndesc             , Nil}) //descr produto destino 
			aadd(aLinha,{"D3_UM"     , cunidx            , Nil}) //unidade medida destino 
			aadd(aLinha,{"D3_LOCAL"  , cArmx             , Nil}) //armazem destino 
			aadd(aLinha,{"D3_LOCALIZ", PadR("ENDER02", tamsx3('D3_LOCALIZ') [1]),Nil}) //Informar endereço destino

			aadd(aLinha,{"D3_NUMSERI", ""                , Nil}) //Numero serie
			aadd(aLinha,{"D3_LOTECTL", ""                , Nil}) //Lote Origem
			aadd(aLinha,{"D3_NUMLOTE", ""                , Nil}) //sublote origem
			aadd(aLinha,{"D3_DTVALID", ''                , Nil}) //data validade 
			aadd(aLinha,{"D3_POTENCI", 0                 , Nil}) // Potencia
			aadd(aLinha,{"D3_QUANT"  , SD1->D1_QUANT     , Nil}) //Quantidade
			aadd(aLinha,{"D3_QTSEGUM", 0                 , Nil}) //Seg unidade medida
			aadd(aLinha,{"D3_ESTORNO", ""                , Nil}) //Estorno 
			aadd(aLinha,{"D3_NUMSEQ" , ""                , Nil}) // Numero sequencia D3_NUMSEQ

			aadd(aLinha,{"D3_LOTECTL", ""                , Nil}) //Lote destino
			aadd(aLinha,{"D3_NUMLOTE", ""                , Nil}) //sublote destino 
			aadd(aLinha,{"D3_DTVALID", ''                , Nil}) //validade lote destino
			aadd(aLinha,{"D3_ITEMGRD", ""                , Nil}) //Item Grade

			aadd(aLinha,{"D3_CODLAN", ""                 , Nil}) //cat83 prod origem
			aadd(aLinha,{"D3_CODLAN", ""                 , Nil}) //cat83 prod destino 

			aAdd(aAuto,aLinha)
		
		If Len(aLinha) >0 
		  IF Alltrim(cArmx) <> Alltrim(SD1->D1_LOCAL)
			
			lMsHelpAuto := .T.
			lMsErroAuto := .F.
			
			MSExecAuto({|x,y| mata261(x,y)},aAuto,nOpcAuto)
			
			If lMsErroAuto
				
				MostraErro()
				DisarmTransaction()
				
			EndIf
		 Endif	
		Endif
		
		SD1->(dbSkip())
	Enddo
  Endif
 Endif
Endif
RestArea(_aArea)
Return
