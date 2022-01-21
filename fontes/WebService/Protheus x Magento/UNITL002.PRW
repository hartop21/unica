/*/
Rotina UNITL001
Rotina responsÃ¡vel por exibir as informaÃ§Ãµes da tabela muro para anÃ¡lise dos usuÃ¡rios
Data: 09/07/2020
Desenvolvedor: Lucas Miranda de Aguiar
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#INCLUDE "RWMAKE.CH"
#Include "TbiConn.ch"

User Function UNITL002()

    Local aArea := GetArea()
    Local cString := "UNI"
    Local cFilter := ""
    LOCAL aCores := {}
    Private cPerg := "UNITL002"


    AADD(aCores,{"UNI_INTEG == 'SUCESSO    ' ", 'BR_VERDE' })
    AADD(aCores,{"UNI_INTEG == 'PENDENTE   ' ", 'BR_AMARELO' })
    AADD(aCores,{"UNI_INTEG == 'ERRO       ' ", 'BR_VERMELHO' })
    AADD(aCores,{"UNI_INTEG == 'IGNORAR    ' ", 'BR_PRETO' })

    Private cCadastro := "Tabela Intermediária da Integra��o Protheus X Magento"
    Private aRotina   := {}


    /*/     AADD(aRotina,{"Visualizar","AxVisual", 0, 2 })
    aAdd( aRotina, { "Legenda"	 	 , "U_TL02LEG"	, 00, 05 } )

 ValidPerg()
    Pergunte (cPerg,.T.)

    If MV_PAR01 > MV_PAR02
        Alert("A data inicial n�o pode ser maior que a data final.")
    else
        If Empty(MV_PAR01)
            cFilter		+= "UNI_DATA>='" + AllTrim(MV_PAR01) + "'"
            cFilter		+= "UNI_INTEG<>'IGNORAR'"
        Else
            cFilter		+= "UNI_DATA>='" + DtoS(MV_PAR01) + "'.And.UNI_DATA<='" + DtoS(MV_PAR02) + "'"
            cFilter		+= "UNI_INTEG<>'IGNORAR'"
        EndIf

        UNI->( DbSetFilter( { || &cFilter }, cFilter ) )


        DbSelectArea( "UNI" )
        DbGotop()
        mBrowse( 06, 01, 22, 75, "UNI",,,,,, aCores )
    EndIf
    /*/

    aRotina     		:= { { "Legenda", "U_TL02LEG", 00,06} ,;
        { "Visualizar" , "AxVisual", 00, 02 },;
        { "Pesquisar"  , "AxPesqui", 00, 01 } }

    DbSelectArea( "UNI" )
    DbGoTop()
    //mBrowse( 06, 01, 22, 75, "UNI")
    mBrowse( 06, 01, 22, 75, "UNI",,,,,, aCores )

    RestArea(aArea)
Return


Static Function ValidPerg()

    Local _sAlias := Alias()
    Local aRegs := {}
    Local i,j

    dbSelectArea("SX1")
    dbSetOrder(1)
    cPerg := PADR(cPerg,10)//6)

    aRegs	:= {}
    //	Aadd(aRegs,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO", "TAMANHO", "DECIMAL","GSC","VAR01"   ,"F3" ,"DEF01","DEF02","DEF03","DEF04","DEF05"})
    //Aadd(aRegs,{ cPerg ,"01"   ,"ID Magento de          ", "","","mv_ch1" ,"C"   , 20       , 0, 0        ,"G"  , "","mv_par01",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
    //Aadd(aRegs,{ cPerg ,"02"   ,"ID Magento ate         ", "","","mv_ch2" ,"C"   , 20       , 0, 0        ,"G"  , "","mv_par02",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
    Aadd(aRegs,{ cPerg ,"01"   ,"Data de           ", "","","mv_ch1" ,"D"   , 09       , 0, 0        ,"G"  , "","mv_par01",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })
    Aadd(aRegs,{ cPerg ,"02"   ,"Data ate          ", "","","mv_ch2" ,"D"   , 09       , 0, 0        ,"G"  , "","mv_par02",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })


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


User Function TL02LEG()

    Local aLegenda  := { { "BR_VERDE", "Integrado" } ,;
        { "BR_AMARELO", "Pendente" } ,;
        { "BR_VERMELHO" 	, "Erro" } ,;
        { "BR_PRETO" 	, "Ignorar" }   }

    BrwLegenda( "Status Ped. Magento", "Legenda", aLegenda )

Return
