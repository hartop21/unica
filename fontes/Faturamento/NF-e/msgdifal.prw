/*/{Protheus.doc} msgdifal
    An�lise do preenchimento de mensagem DIFAL
    @author Marcos Dourado
    @since 20/01/2022
/*/
User Function msgdifal()
    Local nPosCFOP		:= aScan(aHeader,{|x| AllTrim(x[2]) == "C6_CF" })
    Local nI
    Local cRet := ''
    For nI := 1 to Len(aCols)
        If AllTrim(aCols [nI][nPosCFOP]) $ "6108,6117"
            cRet := "Valor do ICMS destinado a UF de destino: R$0,00. Cobran�a do ICMS - Destino, devido" +;
                " ao Estado � t�tulo de Diferencial de Al�quota - DIFAL, afastada pela decis�o do STF no Rext n." +;
                " 1287019 - Tema de Repercuss�o Geral 1093 - ADI 5469. Efeitos produzidos pelas altera��es trazidas" +;
                " pela PL n.32/21 na Lei Complementar n. 87/96, somente ap�s 90 (noventa) dias da data de sua " +;
                " publica��o (DOU 05.01.22 P�G 01 COL 01 - Lei Complementar 190/2022 x PL n. 32/21), conforme o" +;
                " artigo 180, inc. III da Constitui��o Federal de 1988."
        EndIf
    Next nI
    M->C5_MSGNFE := cRet
Return cRet