/*/
Rotina UNITL001
Rotina responsÃ¡vel por exibir as informaÃ§Ãµes da tabela muro para de log para Análise dos usuários
Data: 09/07/2020
Desenvolvedor: Lucas Miranda de Aguiar
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#INCLUDE "RWMAKE.CH"
#Include "TbiConn.ch"

User Function UNITL001()

    Local aArea := GetArea()
    Local cString := "ZZA"
    Local cFilter := ""
    LOCAL aCores := {}
    Private cPerg := "UNITL001"

    AADD(aCores,{"ZZA_P12ST == 'SUCESSO   ' ", "BR_VERDE" })
    AADD(aCores,{"ZZA_P12ST == 'PENDENTE  ' ", "BR_AMARELO" })
    AADD(aCores,{"ZZA_P12ST == 'ERRO      ' ", "BR_VERMELHO" })
    AADD(aCores,{"ZZA_P12ST == 'IGNORAR   ' ", 'BR_PRETO' })


    Private cCadastro := "Consulta LOG de Integra��o Protheus X Magento"
    Private aRotina   := {}

    aRotina     		:= { { "Legenda", "U_TL01LEG", 00,06} ,;
        { "Visualizar" , "AxVisual", 00, 02 },;
        { "Pesquisar"  , "AxPesqui", 00, 01 } }

    /*/ ValidPerg()
    Pergunte (cPerg,.T.)

    If MV_PAR01 > MV_PAR02
        Alert("A data inicial n�o pode ser maior que a data final.")
    else
        If Empty(MV_PAR01)
            cFilter		+= "ZZA_DATA>='" + AllTrim(MV_PAR01) + "'"
        Else
            cFilter		+= "ZZA_DATA>='" + DtoS(MV_PAR01) + "'.And.ZZA_DATA<='" + DtoS(MV_PAR02) + "'"
        EndIf

        ZZA->( DbSetFilter( { || &cFilter }, cFilter ) )

        DbSelectArea( "ZZA" )
        DbSetOrder( 01 )
        mBrowse( 06, 01, 22, 75, "ZZA",,,,,, aCores )

    EndIf/*/
    DbSelectArea( "ZZA" )
    DbGoTop()
    //mBrowse( 06, 01, 22, 75, "UNI")
    mBrowse( 06, 01, 22, 75, "ZZA",,,,,, aCores )
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
    //Aadd(aRegs,{ cPerg ,"05"   ,"Status        ", "","","mv_ch5" ,"C"   , 20       , 0, 0        ,"G"  , "","mv_par05",""     , "", "", "", "",""     ,""     ,""     ,"", "" , "" , "" , "" , "" ,"", "", "", "", "", "", "", "", "", "",""   , "", "", "","",""     })


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


User Function TL01LEG()

    Local aLegenda  := { { "BR_VERDE", "Integrado" } ,;
        { "BR_AMARELO", "Pendente" } ,;
        { "BR_VERMELHO" 	, "Erro" } ,;
        { "BR_PRETO" 	, "Ignorar" }   }
    BrwLegenda( "Status Ped. Magento", "Legenda", aLegenda )

Return
