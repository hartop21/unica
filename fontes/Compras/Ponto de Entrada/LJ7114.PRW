#Include "TOTVS.ch"
User Function LJ7114()

    Private oDlg
    Private oSayNumAut
    Private oSayAdmin
    Private oSayInfCrt
    Private oSayInfVlr
    Private oNSU
    Private oAdmin
    Private oBtnOK
    Private oBtVld
    Private oBtnCancel
    Private oCombo     := NIL //Objeto para seleção do POS que irá realizar a venda
    Private aPOS       := {}    //Array com todos os POS cadastrados no sistema
    Private cDesc      := "Informações da Transação"
    Private cLinha1    := "" //Informações da primeira linha da tela
    Private cLinha2    := "" //Informações da segunda linha da tela
    Private cCombo     := ""    //conteudo selecioado no combo
    Private cTexto     := "" //Para alteração do conteudo de exibição quando acionado o botão do MFe
    Private nInObj     := 0
    Private lTemInfo   := .F.
    Private cNSU       := Space(TamSx3("E1_DOCTEF")[1]) //Tratamento para pegar o tamanho correto do campo E1_DOCTEF

    // Aqui validamos a informação recebida no PARAMIXB[1] o tipo da Forma de Pagto.
    If !Empty(PARAMIXB[1])
        // Se não estiver vazia, escrevemos a primeira linha da tela conforme informação recebida pelo PARAMIXB[1]
        // Se for CC, escrevemos: Teste Cartao Crédito / Se for CD, escrevemos: Teste Cartao Débito
        If AllTrim(PARAMIXB[1]) == "CC"
            cLinha1 := "Cartao Crédito"
        ElseIf AllTrim(PARAMIXB[1]) == "CD"
            cLinha1 := "Cartao Débito"
        EndIf

        // Aqui validamos a informação recebida no PARAMIXB[2]
        // Se não estiver vazia, complementamos a escrita na primeira linha da tela com o Id da parcela
        If !Empty(AllTrim(PARAMIXB[2]))
            cLinha1 += "- ID " + PARAMIXB[2]
        EndIf

        // Aqui validamos a informação recebida no PARAMIXB[3]
        // Se o PARAMIXB[3] for maior que 0, escrevemos na segunda linha da tela o valor da parcela
        If PARAMIXB[3] > 0
            cLinha2 += " Valor : " + AllTrim( Str( PARAMIXB[3], 14, 2 ) )
        EndIf

        lTemInfo := .T.
    EndIf

    // Inicializo o objeto responsável pela criação da tela
    // PONTO DE ENTRADA LJ7114 - Informações da Transação
    oDlg := MSDIALOG():Create()
    oDlg:cName := "oDlg"
    oDlg:cCaption := cDesc
    oDlg:nLeft := 0
    oDlg:nTop := 0
    oDlg:nWidth := 370
    oDlg:nHeight := 190
    oDlg:lShowHint := .F.
    oDlg:lCentered := .T.

    // Caso houve informações para preenchimento nas linhas 1 e 2, mostramos na tela
    If lTemInfo

        //Informações do Cartão - LINHA 1
        oSayInfCrt:= TSAY():Create(oDlg)
        oSayInfCrt:cName := "oSayInfCrt"
        oSayInfCrt:cCaption := cLinha1
        oSayInfCrt:nLeft := 10
        oSayInfCrt:nTop := 17
        oSayInfCrt:nWidth := 230
        oSayInfCrt:nHeight := 16
        oSayInfCrt:lShowHint := .F.
        oSayInfCrt:lReadOnly := .T.
        oSayInfCrt:Align := 0
        oSayInfCrt:lVisibleControl := .T.
        oSayInfCrt:lWordWrap := .F.
        oSayInfCrt:lTransparent := .T.

        //Valor - LINHA 2
        oSayInfVlr:= TSAY():Create(oDlg)
        oSayInfVlr:cName := "oSayInfVlr"
        oSayInfVlr:cCaption := cLinha2
        oSayInfVlr:nLeft := 10
        oSayInfVlr:nTop := 37
        oSayInfVlr:nWidth := 230
        oSayInfVlr:nHeight := 16
        oSayInfVlr:lShowHint := .F.
        oSayInfVlr:lReadOnly := .T.
        oSayInfVlr:Align := 0
        oSayInfVlr:lVisibleControl := .T.
        oSayInfVlr:lWordWrap := .F.
        oSayInfVlr:lTransparent := .T.

        nInObj := 40
    EndIf

    // Código de Autorização da Transação(NSU):
    oSayNumAut:= TSAY():Create(oDlg)
    oSayNumAut:cName := "oSayNumAut"
    oSayNumAut:cCaption := "Código de Autorização da Transação(NSU):"
    oSayNumAut:nLeft := 10
    oSayNumAut:nTop := 20 + nInObj
    oSayNumAut:nWidth := 230
    oSayNumAut:nHeight := 16
    oSayNumAut:lShowHint := .F.
    oSayNumAut:lReadOnly := .T.
    oSayNumAut:Align := 0
    oSayNumAut:lVisibleControl := .T.
    oSayNumAut:lWordWrap := .F.
    oSayNumAut:lTransparent := .T.

    // Get para digitação do NSU
    oNSU:= TGET():Create(oDlg)
    oNSU:cName := "oNSU"
    oNSU:nLeft := 240
    oNSU:nTop := 17 + nInObj
    oNSU:nWidth := 100
    oNSU:nHeight := 20
    oNSU:lShowHint := .F.
    oNSU:Align := 0
    oNSU:cVariable := "cNSU"
    oNSU:bSetGet := {|u| If(PCount()>0,cNSU:=u,cNSU) }
    oNSU:lVisibleControl := .T.
    oNSU:lPassword := .F.
    oNSU:Picture := "@!"
    oNSU:lHasButton := .F.

    //BOTÃO OK para confirmar a tela
    oBtnOK:= TButton():Create(oDlg)
    oBtnOK:cName := "oBtnOK"
    oBtnOK:cCaption := "OK" //"OK"
    oBtnOK:nLeft := 240
    oBtnOK:nTop := 110
    oBtnOK:nWidth := 90
    oBtnOK:nHeight := 25
    oBtnOK:lShowHint := .F.
    oBtnOK:lReadOnly := .F.
    oBtnOK:Align := 0
    // Aqui poderá validar a informação digitada antes do encerramento da operação.
    //Ex.: oBtnOK:bAction := {|| lRet := .T., oDlg:End() }
    oBtnOK:bAction := {|| fVal() }

    oDlg:lEscClose := .F.
    oDlg:Activate()

Return(cNSU)



Static Function fVal()

    Local aArea := GetArea()

    If AllTrim(cNsu) == ""
        MsgInfo("O código do NSU é obrigatório!","NSU")
    ElseIf Len(AllTrim(cNsu)) < 12
        MsgInfo("O código do NSU não pode ser menor do que 12 caracteres.","NSU")
    Else
        oDlg:End()
    EndIf

    RestArea(aArea)
Return
