/*//#########################################################################################
Projeto : Afinidade
Modulo  : SIGAFAT
Fonte   : UNIA028
Objetivo: Cadastro de Vendas
*///#########################################################################################

#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

STATIC cTitulo := "Cadastro de Vendas"
STATIC oModel
STATIC oView
STATIC oBrowse

/*/{Protheus.doc} UNIA028

    Cadastro de Vendas

    @author  Bruno Alves de Oliveira
    @table   SZH,SZI
    @since   13-01-2022
/*/

User Function UNIA028()

    Local aArea      := GetArea()
    Local  cFunBkp   := FunName()
    Private __lCopia := .F.

    SZH->(DbSetOrder(1))
    SZI->(DbSetOrder(1))

    SetFunName("UNIA028")

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("SZH")
    oBrowse:SetDescription(cTitulo)

    //Legendas
    oBrowse:AddLegend( "SZH->ZH_ACAO == 'O' .AND. DATE() > (SZH->ZH_EMISSAO + 3) ", "BLACK",    "Vencida" )
    oBrowse:AddLegend( "SZH->ZH_ACAO == 'E'", "RED",    "Efetivada" )
    oBrowse:AddLegend( "SZH->ZH_ACAO == 'O'", "GREEN",    "Orçamento" )

    oBrowse:Activate()

    SetFunName(cFunBkp)
    RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef

    @author  Bruno Alves de Oliveira
	@since   13-01-2022

/*/

Static Function MenuDef()
    Local aRot := {}

    //Adicionando opções
    ADD OPTION aRot TITLE 'Visualizar'      ACTION 'VIEWDEF.UNIA028' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Incluir'         ACTION 'VIEWDEF.UNIA028' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar'         ACTION 'VIEWDEF.UNIA028' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir'         ACTION 'VIEWDEF.UNIA028' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
    ADD OPTION aRot TITLE 'Copiar'          ACTION 'VIEWDEF.UNIA028' OPERATION 9 ACCESS 0 //OPERATION 5

    //Rotina de Copiar
    //ADD OPTION aRot TITLE 'Copiar'     ACTION 'u_CopiaVend'      OPERATION 9                      ACCESS 0
Return aRot

/*/{Protheus.doc} ModelDef

    @author  Bruno Alves de Oliveira
	@since   13-01-2022

/*/
Static Function ModelDef()
    Local oStSZH 	:= FWFormStruct(1, "SZH")
    Local oStSZI 	:= FWFormStruct(1, "SZI")

    oModel := MPFormModel():New("UNI028",/*bPreValidacao*/, {|oModel| U_ValiDesc(oModel) },/*bCommit*/,/*bCancel*/)

    //Gatilhos
    oStSZI:addTrigger( 'ZI_PRODUTO'  , 'ZI_PRCVEN' , {|| .T. }, {|| U_GetPrc28() } )
    oStSZI:addTrigger( 'ZI_PRODUTO'  , 'ZI_PRCTAB' , {|| .T. }, {|| U_GetPrc28() } )
    oStSZI:addTrigger( 'ZI_PRCTAB'   , 'ZI_TOTTAB' , {|| .T. }, {|| oModel:GetModel("FORMSZI"):GetValue("ZI_PRCTAB") * oModel:GetModel("FORMSZI"):GetValue("ZI_QTD") } )
    oStSZI:addTrigger( 'ZI_QTD'      , 'ZI_TOTTAB' , {|| .T. }, {|| oModel:GetModel("FORMSZI"):GetValue("ZI_PRCTAB") * oModel:GetModel("FORMSZI"):GetValue("ZI_QTD") } )
    oStSZI:addTrigger( 'ZI_PRCVEN'   , 'ZI_VLDESC' , {|| .T. }, {|| IIF(oModel:GetModel("FORMSZI"):GetValue("ZI_PRCTAB") - oModel:GetModel("FORMSZI"):GetValue("ZI_PRCVEN") > 0,oModel:GetModel("FORMSZI"):GetValue("ZI_PRCTAB") - oModel:GetModel("FORMSZI"):GetValue("ZI_PRCVEN"),0) } )


    oStSZI:SetProperty("ZI_PRCVEN" , MODEL_FIELD_VALID, {|| U_VldUnit()} )
    oStSZI:SetProperty("ZI_QTD"    , MODEL_FIELD_VALID, {|| U_VldUnit() .AND. ValidSB2()} )

    oStSZH:SetProperty("ZH_FILRET", MODEL_FIELD_VALID, {|| U_AllPrc28()} )
    oStSZH:SetProperty("ZH_TABELA", MODEL_FIELD_VALID, {|| U_AllPrc28()} )

    oModel:AddFields(	"FORMSZH",/*cOwner*/	,oStSZH)
    oModel:AddGrid(	    "FORMSZI","FORMSZH" 	,oStSZI)

    oModel:SetRelation("FORMSZI", {{ 'ZI_FILIAL', 'xFilial( "SZI" )' },{"ZI_CODIGO","ZH_CODIGO"}}, SZI->(IndexKey( 1 )))

    oModel:SetVldActive({ | oModel | fVldActive(oModel)}) //Ativa a validação antes de clicar em umas das opções do browser (incluir, alterar, excluir, etc)

    oModel:SetPrimaryKey({})
    oModel:SetDescription(cTitulo)
    oModel:GetModel("FORMSZI"):SetDescription("Itens")


    //Adicionando totalizadores
    oModel:AddCalc('TOT_VENDA', 'FORMSZH', 'FORMSZI', 'ZI_QTD'    , 'XX_QTD'     , 'SUM'        , , , "Quantidade de Itens" )
    oModel:AddCalc('TOT_VENDA', 'FORMSZH', 'FORMSZI', 'ZI_PERCDES', 'XX_PERCDES' , 'SUM'        , , , "% Desconto Alçada" )
    oModel:AddCalc('TOT_VENDA', 'FORMSZH', 'FORMSZI', 'ZI_VLDESC' , 'XX_VLDESC'  , 'SUM'        , , , "Valor Desconto Alçada" )
    oModel:AddCalc('TOT_VENDA', 'FORMSZH', 'FORMSZI', 'ZI_TOTTAB' , 'XX_TOTTAB'  , 'SUM'        , , , "Valor Total (Tabela)" )
    oModel:AddCalc('TOT_VENDA', 'FORMSZH', 'FORMSZI', 'ZI_TOTAL'  , 'XX_TOTAL'   , 'SUM'        , , , "Valor Total (Pedido)" )
    oModel:AddCalc('TOT_VENDA', 'FORMSZH', 'FORMSZI', 'ZI_TOTAL'  , 'XX_TOTAL1'  , 'FORMULA'	, , , 'Valor Total (Total - Desconto + Frete)',{ || TotalFrete()})

    oModel:setActivate( {|oModel| u_initialize(oModel)} ) // inicializador do model

Return oModel

/*/{Protheus.doc} TotalFrete
	@author  Robson Rogério Silva
	@since   13-01-2022
    Objetivo: Monta o total da venda acrescido do frete
/*/

Static Function TotalFrete()
    Local nLinha
    Local nTotal            := 0

    For nLinha := 1 To oModel:GetModel("FORMSZI"):Length()
        If ! oModel:GetModel("FORMSZI"):IsDeleted(nLinha)
            nTotal += oModel:GetModel("FORMSZI"):GetValue("ZI_TOTAL", nLinha)
        EndIf
    Next

    nTotal += oModel:GetModel("FORMSZH"):GetValue("ZH_VLFRETE")

Return nTotal

/*/{Protheus.doc} ViewDef

    @author  Bruno Alves de Oliveira
	@since   13-01-2022

/*/
Static Function ViewDef()

    Local oModel := FWLoadModel("UNIA028")
    Local oStSZH := FWFormStruct(2, "SZH")
    Local oStSZI := FWFormStruct(2, "SZI")
    Local oStTot := FWCalcStruct(oModel:GetModel('TOT_VENDA'))

    oView := FWFormView():New()
    oView:SetModel(oModel)

    oView:AddField("VIEW_SZH", oStSZH, "FORMSZH")
    oView:AddGrid("VIEW_SZI",  oStSZI, "FORMSZI")
    oView:AddField('VIEW_TOT', oStTot,'TOT_VENDA')

    //Incrementa a linha do item
    oView:AddIncrementField( 'VIEW_SZI', 'ZI_ITEM' )

    // CRIA BOXES HORIZONTAIS
    oView:CreateHorizontalBox("SUPERIOR", 40)
    oView:CreateHorizontalBox("INFERIOR", 40)
    oView:CreateHorizontalBox('TOTAL'   , 20)

    oView:SetOwnerView("VIEW_SZH","SUPERIOR")
    oView:SetOwnerView("VIEW_SZI","INFERIOR")
    oView:SetOwnerView('VIEW_TOT','TOTAL')

    //Habilitando título
    oView:EnableTitleView('VIEW_SZH','Venda Loja')
    oView:EnableTitleView('VIEW_SZI','Itens')
    oView:EnableTitleView('VIEW_TOT','Totalizador')

    //Força o fechamento da janela na confirmação
    oView:SetCloseOnOk({||.T.})


Return oView

/*/{Protheus.doc} ValidSB2

	@author  Bruno Alves de Oliveira
	@since   13-01-2022
    Objetivo: Não permitir a inclusão de um item no cadastro com a quantidade superior ao saldo do estoque

/*/

Static Function ValidSB2()
    Local lOk := .T.

    If FWFldGet("ZI_QTD") > FWFldGet("ZI_QATU")
        Help("ValidSB2",1,"HELP","ValidSB2","Quantidade superior ao saldo do estoque, favor verificar!",1,0)
        lOk := .F.
    EndIf
Return(lOk)

/*/{Protheus.doc} AllPrc28

	@author  Robson Rogério Silva
	@since   13-01-2022
    Objetivo: Obtem o valor do produto de acordo com os dados do pedido

/*/

User Function AllPrc28()
    Local lRet      := .T.
    Local oSubModel := oModel:GetModel("FORMSZI")
    Local nLinhaAtu := oSubModel:nLine
    Local nPreco    := 0
    Local nLinha

    For nLinha := 1 To oSubModel:Length()
        //posiciona na linha desejada e vefifica se não é a atual e não está deletada
        oSubModel:GoLine(nLinha)

        If  Empty(oModel:GetModel("FORMSZH"):GetValue("ZH_TABELA")) .OR. ;
                Empty(oModel:GetModel("FORMSZI"):GetValue("ZI_PRODUTO"))
            LOOP
        EndIf

        nPreco := U_GetPrc28()
        oSubModel:SetValue("ZI_PRCVEN" ,nPreco)
        oSubModel:SetValue("ZI_PRCTAB" ,nPreco)

        If nPreco == 0
            lRet := .F.
            EXIT
        EndIf
    Next
    oSubModel:GoLine(nLinhaAtu)

Return lRet

/*/{Protheus.doc} GetPrc28

	@author  Robson Rogério Silva
	@since   13-01-2022
    Objetivo: Obtem o valor do produto de acordo com os dados do pedido

/*/

User Function GetPrc28()
    Local cAliasQry			:= GetNextAlias()
    Local cFiltro           := ""
    Local nRet              := 0
    Local c_Fil             := If(Empty(oModel:GetModel("FORMSZH"):GetValue("ZH_FILRET")),cFilAnt,oModel:GetModel("FORMSZH"):GetValue("ZH_FILRET"))

    If Empty(oModel:GetModel("FORMSZH"):GetValue("ZH_TABELA")) .OR. ;
            Empty(oModel:GetModel("FORMSZI"):GetValue("ZI_PRODUTO"))
        Return 0
    EndIf


    cFiltro := " AND DA1_FILIAL = '" + xFilial("DA1", c_Fil) + "' "
    cFiltro += " AND DA1_CODTAB = '" + oModel:GetModel("FORMSZH"):GetValue("ZH_TABELA") + "' "
    cFiltro += " AND DA1_CODPRO = '" + oModel:GetModel("FORMSZI"):GetValue("ZI_PRODUTO") + "' "
    cFiltro := "% " + cFiltro + " %"

    BeginSql Alias cAliasQry
        SELECT
            DA1_FILIAL,
            DA1_TIPPRE,
            DA1_ITEM,
            DA1_CODTAB,
            DA1_CODPRO,
            DA1_GRUPO,
            DA1_PRCVEN,
            DA1_VLRDES,
            DA1_PERDES,
            DA1_ATIVO,
            DA1_FRETE,
            DA1_ESTADO,
            DA1_TPOPER,
            DA1_PRCMAX
        FROM
            %TABLE:DA1%
        WHERE
            D_E_L_E_T_ = ' ' %exp:cFiltro%
    EndSql

    If !( cAliasQry )->( Eof() )
        nRet	:= ( cAliasQry )->DA1_PRCVEN
    Else
        MsgAlert("Não foi encontrado preço com os dados: " + CRLF + "<B>" +;
            "Filial  -> " + c_Fil + CRLF + ;
            "Tabela  -> " + oModel:GetModel("FORMSZH"):GetValue("ZH_TABELA") + CRLF + ;
            "Produto -> " + oModel:GetModel("FORMSZI"):GetValue("ZI_PRODUTO") + "</B>";
            )
    EndIf
    ( cAliasQry )->( DbCloseArea() )

Return(nRet)

/*/{Protheus.doc} VldUnit

	@author  Robson Rogério Silva
	@since   13-01-2022
    Objetivo: Atualiza os campos calculados quando modifica quantidade ou valor unitário

/*/

User Function VldUnit()
    Local nLinha
    Local nTotal            := 0

    If Empty(oModel:GetModel("FORMSZH"):GetValue("ZH_TABELA")) .OR. ;
            Empty(oModel:GetModel("FORMSZI"):GetValue("ZI_PRODUTO"))
        Return .T.
    EndIf

    // Atualiza Total
    oModel:GetModel("FORMSZI"):SetValue("ZI_TOTAL" ,oModel:GetModel("FORMSZI"):GetValue("ZI_PRCVEN") * oModel:GetModel("FORMSZI"):GetValue("ZI_QTD"))

    // Verifica o valor digitado
    oModel:GetModel("FORMSZI"):SetValue("ZI_VLDESC" , ;
        (oModel:GetModel("FORMSZI"):GetValue("ZI_PRCTAB") -  oModel:GetModel("FORMSZI"):GetValue("ZI_PRCVEN") ) * oModel:GetModel("FORMSZI"):GetValue("ZI_QTD"))

    If oModel:GetModel("FORMSZI"):GetValue("ZI_TOTAL") > 0
        oModel:GetModel("FORMSZI"):SetValue("ZI_PERCDES" ,IIF(oModel:GetModel("FORMSZI"):GetValue("ZI_VLDESC") / oModel:GetModel("FORMSZI"):GetValue("ZI_TOTAL") * 100 > 0,oModel:GetModel("FORMSZI"):GetValue("ZI_VLDESC") / oModel:GetModel("FORMSZI"):GetValue("ZI_TOTAL") * 100,0))
    EndIf

    //calcula o Frete
    If oModel:GetModel("FORMSZH"):GetValue("ZH_TPENTRE") == "T"
        For nLinha := 1 To oModel:GetModel("FORMSZI"):Length()
            If ! oModel:GetModel("FORMSZI"):IsDeleted(nLinha)
                nTotal += oModel:GetModel("FORMSZI"):GetValue("ZI_TOTAL", nLinha)
            EndIf
        Next

        // verifica se é frete fixo ou se é percentual
        If nTotal < SuperGetMv("UN_FRTFIX",.F.,10000)
            oModel:GetModel("FORMSZH"):SetValue("ZH_VLFRETE", SuperGetMv("UN_VLRFRT",.F.,70))
        Else
            oModel:GetModel("FORMSZH"):SetValue("ZH_VLFRETE", nTotal * SuperGetMv("UN_PERFRT",.F.,2) / 100 )
        EndIf
    EndIf
Return .T.



/*/{Protheus.doc} VldVend

	@author  Bruno Alves de Oliveira
	@since   18-01-2022
    Objetivo: Valida o tipo do vendedor

/*/

User Function VldVend(cVendedor,cTipo)

    Local cTpVend := Posicione("SA3",1,xFilial("SA3") + cVendedor,"A3_TIPO")
    Local lOk := .T.

    If cTipo == "V"
        If cTpVend ==  "P"
            Help("VldVend",1,"HELP","VldVend","Tipo do vendedor inválido, favor verificar!",1,0)
            lOk := .F.
        EndIf
    ElseIf cTipo == "P"
        If cTpVend !=  "P"
            Help("VldVend",1,"HELP","VldVend","Tipo do vendedor inválido, favor verificar!",1,0)
            lOk := .F.
        EndIf

    EndIf

Return(lOk)


/*/{Protheus.doc} fVldActive

	@author  Bruno Alves de Oliveira
	@since   19-01-2022
    Objetivo: Programa responsavel pela validação do clique nas opções do mbrowser

/*/


Static Function fVldActive(oModel)


    Local nOpc := oModel:GetOperation() //3 inclusão; 4 alteração; 5 exclusão
    Local lRet := .T.

    //Validador de alteração
    If nOpc == 4

        If SZH->ZH_ACAO == 'O'  .AND. DATE() > (SZH->ZH_EMISSAO + 3)
            Help("fVldActive",1,"HELP","fVldActive","Não é possível alterar orçamento vencido, favor verificar!",1,0)
            lRet := .F.
        EndIf

    EndIf

Return(lRet)



/*/{Protheus.doc} ValiDesc

	@author  Bruno Alves de Oliveira
	@since   20-01-2022
    Objetivo: Valida porcentagem do desconto no tudook

/*/

User Function ValiDesc(oModel)

    Local nOprAtu    := oModel:getOperation()
    Local oModelGrid := oModel:GetModel("FORMSZI")
    Local lValid     := .T.
    Local nLinha     := 0

    // se for inclusão ou alteração ou cópia
    if nOprAtu == MODEL_OPERATION_INSERT .or. nOprAtu == MODEL_OPERATION_UPDATE

        For nLinha := 1 To oModelGrid:Length()

            //Setando a linha atual
            oModelGrid:GoLine(nLinha)

            If oModelGrid:GetValue("ZI_PERCDES") > 5
                help(,,"ValiDesc","% Desconto","Ultrapassou o limite dos 5% de desconto.",1,0,,,,,,{"Produto " + Alltrim(oModelGrid:GetValue("ZI_DESC")) })
                lValid := .F.
            EndIf


        Next

    EndIf

Return lValid

//-------------------------------------------------------------------
/*/{Protheus.doc} initialize
	Executa tarefas de inicialização do modelo
	@type    method
	@author  Bruno Alves
	@since   20/01/2022
	@version 12.0
/*/
//-------------------------------------------------------------------
User Function initialize(oModel)

    local nOpr := oModel:getOperation()
    //Local oModelGrid := oModel:GetModel("FORMSZI")
    //Local nLinha     := 0

    // se for inclusão
    if nOpr == MODEL_OPERATION_INSERT


        // se for cópia
        if oModel:isCopy()

            //Setando os campos do cabeçalho
            oModel:SetValue("FORMSZH", "ZH_CODIGO",  GetSXENum("SZH", "ZH_CODIGO"))
            oModel:SetValue("FORMSZH", "ZH_SOLICIT",  USRRETNAME(RETCODUSR()) )
            oModel:SetValue("FORMSZH", "ZH_EMISSAO",  DATE() )
            oModel:SetValue("FORMSZH", "ZH_ACAO", "" )

            //Responsavel por alterar o grid
            /*
            For nLinha := 1 To oModelGrid:Length()

                //Setando a linha atual
                oModelGrid:GoLine(nLinha)

                oDiaria:setValue("XX_CAMPO", 0)

                EndIf
            EndIf

            Next
            */



        endif
    endif
return .T.