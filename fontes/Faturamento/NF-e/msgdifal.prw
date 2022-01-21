/*/{Protheus.doc} msgdifal
    Análise do preenchimento de mensagem DIFAL
    @author Marcos Dourado
    @since 20/01/2022
/*/
User Function msgdifal()
    Local nPosCFOP		:= aScan(aHeader,{|x| AllTrim(x[2]) == "C6_CF" })
    Local nI
    Local cRet := ''
    For nI := 1 to Len(aCols)
        If AllTrim(aCols [nI][nPosCFOP]) $ "6108,6117"
            cRet := "Valor do ICMS destinado a UF de destino: R$0,00. Cobrança do ICMS - Destino, devido" +;
                " ao Estado à título de Diferencial de Alíquota - DIFAL, afastada pela decisão do STF no Rext n." +;
                " 1287019 - Tema de Repercussão Geral 1093 - ADI 5469. Efeitos produzidos pelas alterações trazidas" +;
                " pela PL n.32/21 na Lei Complementar n. 87/96, somente após 90 (noventa) dias da data de sua " +;
                " publicação (DOU 05.01.22 PÁG 01 COL 01 - Lei Complementar 190/2022 x PL n. 32/21), conforme o" +;
                " artigo 180, inc. III da Constituição Federal de 1988."
        EndIf
    Next nI
    M->C5_MSGNFE := cRet
Return cRet