#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"
#Include "Rwmake.Ch"
#Include "Fileio.ch"
#Include "Colors.ch"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"
#Include "Ap5Mail.Ch"
#include "fwmvcdef.ch"
/* -------------------------------------------------------------------------------
Esta funcão tem o objetivo de realizar a integração da postagem de notas fiscais
com os correios, via WebService, utilizando o método PostarObjeto()

Desenvolvedor: Lucas Aguiar
Data: 26/08/2020

------------------------------------------------------------------------------- */

User Function UNIWSC01()

    Local oMark
    Local cTitle := "Envio de NF para postagem nos correios."
    Local cFilter := ""
    Local cError  := ""
    Local cCorreio := ""

    Private cMark  := ""
    Private cPerg     := "WSCORREIO"
    Private cIdPerf := ""

    Pergunte (cPerg,.T.)

    If Empty(AllTrim(MV_PAR03))
        Aviso("WS CORREIOS","A transportadora deverá ser preenchida")
        Return
    EndIf

    cCorreio := fGetTranspCor()

    If cCorreio == "TRANSPORTADORA NAO EXISTE"
        Aviso("WS CORREIOS","A transportadora não existe no Protheus.")
        Return

    ElseIf cCorreio == "TRANSPORTADORA ERRO"
        Aviso("WS CORREIOS","A transportadora não é dos correios, favor verificar.")
        Return
    ElseIf AllTrim(cIdPerf) == ""
        Aviso("WS CORREIOS","A transportadora dos correios não possui ID de perfil")
        Return
    EndIf

    //Filtro para exibir as notas que foram enviadas para o SEFAZ
    cFilter		+= "         F2_CHVNFE    != ' ' "
    cFilter		+= " .AND. DTOS(F2_EMISSAO) >= '"+Dtos(MV_PAR01)  +"'.And. DTOS(F2_EMISSAO) <= '"+Dtos(MV_PAR02)+"'"
    cFilter     += " .AND. F2_TRANSP == '"+AllTrim(MV_PAR03)+"'"

    oMark := FWMarkBrowse():New()
    oMark:SetAlias( "SF2" )
    oMark:SetSemaphore(.T.)
    oMark:SetDescription( cTitle )
    oMark:SetFieldMark( "F2_OK" )
    oMark:SetFilterDefault( cFilter )
    oMark:AddLegend( "SF2->F2_XFLGPOS=='S'", "GREEN")
    oMark:AddLegend( "SF2->F2_XFLGPOS=='N'", "RED")
    oMark:AddLegend( "SF2->F2_XFLGPOS==' '", "BLUE")

    //Ativa
    oMark:Activate()

Return

User Function FENVCORR()

    Local aArea := GetArea()
    Local lPostou := .F.
    Local aDadosCli := {}
    Local cCNPJUnica := ""
    Local xRet       := .T.
    Local oWsdl                 := NIL
    Private aConteudoNF := {}
    Private nPeso   := 0


    DbSelectArea("SF2")
    DbGoTop()

    cMark := oMark:Mark()

    While !SF2->(EoF()) //PENSAR EM FAZER VIA QUERY PELA DEMORA DO WHILE

        If !SF2->F2_OK == cMark
            SF2->(DbSkip())
        Else

            //Busca os dados do cliente
            aDadosCli := fDadosCli()

            //Busca os conteÃºdos dos produtos da NF
            aConteudoNF := fConteudoNF()

            //Busca o CNPJ da filial em que a nota fiscal foi emitida.
            cCNPJUnica := fSeekCNPJ()

            //Alimentando as variáveis do WebService
            oWS                 := WSPostagemVipp():NEW()
            oWs:oWSPostagemVipp    := PostagemVipp_POSTAGEM():New()
            oWs:oWSPostagemVipp:OWSCONTRATOECT := PostagemVipp_ContratoEct():New()
            oWs:oWSPostagemVipp:OWSDESTINATARIO := PostagemVipp_Destinatario():New()
            oWs:oWSPostagemVipp:OWSPERFILVIPP := PostagemVipp_PerfilVipp():New()
            oWs:oWSPostagemVipp:OWSSERVICO := PostagemVipp_Servico():New()
            oWs:oWSPostagemVipp:OWSNOTASFISCAIS := PostagemVipp_ArrayOfNotaFiscal():New()
            oWs:oWSPostagemVipp:OWSVOLUMES := PostagemVipp_VolumeObjeto():NEW()
            oWs:oWSPostagemVipp:OWSVOLUMES:OWSDECLARACAOCONTEUDO := PostagemVipp_DeclaracaoConteudo():NEW()


            //<PerfilVipp>
            oWs:oWSPostagemVipp:OWSPERFILVIPP:cUsuario                    := GetNewPar("MV_XUSRCOR", "onbiws")
            oWs:oWSPostagemVipp:OWSPERFILVIPP:cToken                      := GetNewPar("MV_XPSWCOR", "112233")
            oWs:oWSPostagemVipp:OWSPERFILVIPP:cIdPerfil                   := AllTrim(cIdPerf)

            //<ContratoEct>
            oWs:oWSPostagemVipp:OWSCONTRATOECT:cNrContrato                 := ""
            oWs:oWSPostagemVipp:OWSCONTRATOECT:cCodigoAdministrativo       := ""
            oWs:oWSPostagemVipp:OWSCONTRATOECT:cNrCartao                   := ""

            //<DestinatÃ¡rio>
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cCnpjCpf                    := AllTrim(aDadosCli[1][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cIeRg                       := ""
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cNome                       := AllTrim(aDadosCli[2][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cSegundaLinhaDestinatario   := ""
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cEndereco                   := AllTrim(aDadosCli[3][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cNumero                     := ""
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cComplemento                := AllTrim(aDadosCli[4][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cBairro                     := AllTrim(aDadosCli[5][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cCidade                     := AllTrim(aDadosCli[6][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cUF                         := AllTrim(aDadosCli[7][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cCEP                        := AllTrim(aDadosCli[8][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cTelefone                   := AllTrim(aDadosCli[9][2])
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cCelular                    := ""
            oWs:oWSPostagemVipp:OWSDESTINATARIO:cEmail                      := AllTrim(aDadosCli[10][2])

            //<Servico>
            oWs:oWSPostagemVipp:OWSSERVICO:cServicoECT                 := ""

            //<Notas Fiscais>
            oWsNF := PostagemVipp_NotaFiscal():New()
            oWsNF:cDtNotaFiscal               := AllTrim(dToC(SF2->F2_EMISSAO))
            oWsNF:cSerieNotaFiscal            := AllTrim(SF2->F2_SERIE)
            oWsNF:cNrNotaFiscal               := AllTrim(SF2->F2_DOC)
            oWsNF:cVlrTotalNota               := AllTrim(cValToChar(SF2->F2_VALMERC))

            AADD(oWs:oWSPostagemVipp:OWSNOTASFISCAIS:OWSNOTAFISCAL,oWsNF)


            //<Volumes>
            oWs:oWSPostagemVipp:OWSVOLUMES:cPeso                       := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cAltura                     := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cLargura                    := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cComprimento                := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cContaLote                  := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cChaveRoteamento            := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cCodigoBarraVolume          := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cCodigoBarraCliente         := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cObservacaoVisual           := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cObservacaoQuatro           := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cObservacaoCinco            := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cPosicaoVolume              := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cConteudo                   := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cValorDeclarado             := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cAdicionaisVolume           := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cVlrACobrar                 := ""
            oWs:oWSPostagemVipp:OWSVOLUMES:cEtiqueta                   := ""

            //<DeclaracaoConteudo>
            oWs:oWSPostagemVipp:OWSVOLUMES:OWSDECLARACAOCONTEUDO:cDocumentoRemetente         :=  AllTrim(cCNPJUnica)
            oWs:oWSPostagemVipp:OWSVOLUMES:OWSDECLARACAOCONTEUDO:cDocumentoDestinatario      :=  AllTrim(aDadosCli[1][2])
            oWs:oWSPostagemVipp:OWSVOLUMES:OWSDECLARACAOCONTEUDO:nPesoTotal                  :=  nPeso

            //<ItemConteudo>
            oWs:oWSPostagemVipp:OWSVOLUMES:OWSDECLARACAOCONTEUDO:oWSItemConteudo := PostagemVipp_ArrayOfItemConteudo():New()
            For nX := 1 To Len (aConteudoNF)
                oWsItens := PostagemVipp_ItemConteudo():New()

                oWsItens:cDescricaoConteudo := aConteudoNF[nX][4][2]
                oWsItens:cValor := aConteudoNF[nX][2][2]
                oWsItens:nQuantidade := Val(aConteudoNF[nX][3][2])

                AADD(oWs:oWSPostagemVipp:OWSVOLUMES:OWSDECLARACAOCONTEUDO:oWSItemConteudo:oWSItemConteudo,oWsItens)
            Next Nx
            If !oWS:PostarObjeto()
                cError := "Erro ao tentar conectar com o méotodo PostarObjeto() " + Replace( Replace( AllTrim( GetWSCError() ), Chr( 10 ), " " ), Chr( 13 ), " " )
            Else
                //If Type(oWS:OWSPOSTAROBJETORESULT:_POSTAROBJETORESULT:_RETORNO) == "U"
                lPostou := .T.
                //Else
                //  cError := AllTrim(oWS:OWSPOSTAROBJETORESULT:_POSTAROBJETORESULT:_RETORNO:_ERROS:_ERRO:_MESSAGE:TEXT)
                //EndIf
            EndIf

            If lPostou
                Reclock("SF2",.F.)
                SF2->F2_XFLGPOS := "S"
                SF2->F2_OK := ""
                MsUnlock()
            Else
                Reclock("SF2",.F.)
                SF2->F2_XFLGPOS := "N"
                SF2->F2_OK := ""
                SF2->F2_XERRCOR := cError
                MsUnlock()
            EndIf

            SF2->(DbSkip())
        EndIf
    EndDo
    RestArea(aArea)
Return



user function avalsf2()

return

User function markallf2()
    Local nrecno:=recno()
    SF2->(dbgotop())
    While !SF2->(eof())
        u_markF2()
        dbskip()
    enddo
    dbgoto(nrecno)
return

user function markf2()

    reclock("SF2",.F.)

    replace SF2->F2_OK with cMark

    msunlock("SF2")

return




Static Function fDadosCli()

    Local aArea := GetArea()
    Local cQuery := ""
    Local cAliasSA1 := GetNextAlias()
    Local aDados := {}

    cQuery := "SELECT * FROM " + RetSqlName("SA1") + " A1 "
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND "
    cQuery += "A1_COD = '"+SF2->F2_CLIENTE+"'"

    If Select( cAliasSA1 ) > 0
        ( cAliasSA1 )->( DbCloseArea() )
    EndIf
    TcQuery cQuery Alias ( cAliasSA1 ) New

    If !( cAliasSA1 )->( Eof() )
        aAdd( aDados, { "A1_CGC" , ( cAliasSA1 )->A1_CGC	, Nil } )
        aAdd( aDados, { "A1_NOME" , ( cAliasSA1 )->A1_NOME	, Nil } )
        aAdd( aDados, { "A1_END" , ( cAliasSA1 )->A1_END	, Nil } )
        aAdd( aDados, { "A1_COMPLEM" , ( cAliasSA1 )->A1_COMPLEM	, Nil } )
        aAdd( aDados, { "A1_BAIRRO" , ( cAliasSA1 )->A1_BAIRRO	, Nil } )
        aAdd( aDados, { "A1_MUN" , ( cAliasSA1 )->A1_MUN	, Nil } )
        aAdd( aDados, { "A1_EST" , ( cAliasSA1 )->A1_EST	, Nil } )
        aAdd( aDados, { "A1_CEP" , ( cAliasSA1 )->A1_CEP	, Nil } )
        aAdd( aDados, { "A1_TEL" , ( cAliasSA1 )->A1_TEL	, Nil } )
        aAdd( aDados, { "A1_EMAIL" , ( cAliasSA1 )->A1_EMAIL	, Nil } )
    EndIf

    RestArea(aArea)

Return aDados


Static Function fConteudoNF()

    Local aArea := GetArea()
    Local cQuery := ""
    Local cAliasSD2 := GetNextAlias()
    Local aDados := {}
    Local nItem  := 1

    cQuery := "SELECT * FROM " + RetSqlName("SD2") + " D2 "
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND "
    cQuery += " D2_DOC = '"+SF2->F2_DOC+"' AND"
    cQuery += " D2_SERIE = '"+SF2->F2_SERIE+"' AND"
    cQuery += " D2_CLIENTE = '"+SF2->F2_CLIENTE+"' AND"
    cQuery += " D2_FILIAL = '"+SF2->F2_FILIAL+"'"

    If Select( cAliasSD2 ) > 0
        ( cAliasSD2 )->( DbCloseArea() )
    EndIf
    TcQuery cQuery Alias ( cAliasSD2 ) New

    If !( cAliasSD2 )->( Eof() )
        While !( cAliasSD2 )->( Eof() )

            aDados := { {{ "ITEM " + cValtoChar(nItem)	, AllTrim(( cAliasSD2 )->D2_COD)	        } ,;
                { "Valor Item " + cValtoChar(nItem)	, AllTrim(cValToChar(( cAliasSD2 )->D2_PRCVEN))	    } ,;
                { "Quantidade Item " + cValtoChar(nItem)	, AllTrim(cValToChar(( cAliasSD2 )->D2_QUANT))		    } ,;
                { "Descri Item " + cValtoChar(nItem)	, AllTrim(Posicione("SB1",1,xFilial("SB1")+( cAliasSD2 )->D2_COD,"B1_DESC")) }}}
            nPeso := nPeso + SD2->D2_PESO
            nItem++
            ( cAliasSD2 )->( DbSkip() )
        End

    EndIf

    RestArea(aArea)


Return aDados


Static Function MenuDef()

    Local aRotina := {}
    Local aSubMnu := {}

    ADD OPTION aRotina TITLE 'Enviar XML'    ACTION 'U_FENVCORR' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Legendas'    ACTION 'U_LegCor' OPERATION 4 ACCESS 0

Return aRotina


User Function LegCor()

    Local aLegenda := {}

    aAdd(aLegenda,{"BR_VERMELHO",     "WS enviado com erro!"})
    aAdd(aLegenda,{"BR_VERDE",        "WS enviado com sucesso!"})
    aAdd(aLegenda,{"BR_AZUL",         "WS não enviado!"})

    BrwLegenda("Envio de WS para postagem nos correios", "Status", aLegenda)

Return



Static Function fSeekCNPJ()

    Local cEmp := "01"
    Local cFilial := SF2->F2_FILIAL
    Local cCNPJ := ""

    cCNPJ := Posicione("SM0",1,cEmp+cFilial,"M0_CGC")

Return cCNPJ



Static Function fGetTranspCor()

    Local aArea := GetArea()
    Local cAliasA4 := GetNextAlias()
    Local cQuery := ""
    Local cRet := "TRANSPORTADORA NAO EXISTE"

    cQuery := "SELECT * FROM " + RetSqlName("SA4") + " A4 "
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND "
    cQuery += " A4_COD = '"+AllTrim(MV_PAR03)+"'"

    If Select( cAliasA4 ) > 0
        ( cAliasA4 )->( DbCloseArea() )
    EndIf
    TcQuery cQuery Alias ( cAliasA4 ) New

    If !( cAliasA4 )->( Eof() )
        If AllTrim(( cAliasA4 )->A4_XCORREI) == "S"
            cRet := "TRANSPORTADORA OK"
            cIdPerf := ( cAliasA4 )->A4_XIDPERF
        Else
            cRet := "TRANSPORTADORA ERRO"
        EndIf
    EndIf

    RestArea(aArea)
Return cRet

/*---------------------------------------------------*
 | Função: fPutHelp                                  |
 | Desc:   Função que insere o Help do Parametro     |
*---------------------------------------------------*/

Static Function fPutHelp(cKey, cHelp, lUpdate)
    Local cFilePor  := "SIGAHLP.HLP"
    Local cFileEng  := "SIGAHLE.HLE"
    Local cFileSpa  := "SIGAHLS.HLS"
    Local nRet      := 0
    Default cKey    := ""
    Default cHelp   := ""
    Default lUpdate := .F.

    //Se a Chave ou o Help estiverem em branco
    If Empty(cKey) .Or. Empty(cHelp)
        Return
    EndIf

    //**************************** Português
    nRet := SPF_SEEK(cFilePor, cKey, 1)

    //Se não encontrar, será inclusão
    If nRet < 0
        SPF_INSERT(cFilePor, cKey, , , cHelp)

        //Senão, será atualização
    Else
        If lUpdate
            SPF_UPDATE(cFilePor, nRet, cKey, , , cHelp)
        EndIf
    EndIf



    //**************************** Inglês
    nRet := SPF_SEEK(cFileEng, cKey, 1)

    //Se não encontrar, será inclusão
    If nRet < 0
        SPF_INSERT(cFileEng, cKey, , , cHelp)

        //Senão, será atualização
    Else
        If lUpdate
            SPF_UPDATE(cFileEng, nRet, cKey, , , cHelp)
        EndIf
    EndIf



    //**************************** Espanhol
    nRet := SPF_SEEK(cFileSpa, cKey, 1)

    //Se não encontrar, será inclusão
    If nRet < 0
        SPF_INSERT(cFileSpa, cKey, , , cHelp)

        //Senão, será atualização
    Else
        If lUpdate
            SPF_UPDATE(cFileSpa, nRet, cKey, , , cHelp)
        EndIf
    EndIf
Return
