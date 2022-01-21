//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Pré Lista de Postagem (B2W)"

// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 25/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
User Function UNIA026()
	Local aArea       := GetArea()
	Local oBrowse
	Local cFunBkp     := FunName()
	//Local cArquivo    := "\teste"+GetDBExtension()
	Local cArqs       := ""
	Local cArqInd       := ""
	Local aStrut      := {}
	Local aBrowse     := {}
	Local aSeek       := {}
	Local aIndex      := {}
	Private cAliasTmp := "TMP"

	//Pode se usar também a FWTemporaryTable

	//Criando a estrutura que terá na tabela
	aAdd(aStrut, {"TMP_COD", "C", 20, 0} )
	aAdd(aStrut, {"TMP_DAT", "D", 08, 0} )
	aAdd(aStrut, {"TMP_STA", "C", 01, 0} )
	aAdd(aStrut, CpCampStr("TMP_DOC", "C5_NOTA") )
	aAdd(aStrut, CpCampStr("TMP_SER", "C5_SERIE") )
	aAdd(aStrut, {"TMP_PED", "C", 20, 0} )
	aAdd(aStrut, CpCampStr("TMP_CLI", "A1_COD") )
	aAdd(aStrut, CpCampStr("TMP_LOJ", "A1_LOJA") )
	aAdd(aStrut, CpCampStr("TMP_NOM", "A1_NOME") )

	//Se o arquivo dbf / ctree existir, usa ele
	If Select(cAliasTmp) == 0
		If .F. .And. File(cArquivo)
			DbUseArea(.T., "DBFCDX", cArquivo, cAliasTmp, .F., .F.)

			//Senão, cria uma temporária
		Else
			//Criando a temporária
			cArqs := CriaTrab( aStrut, .T. )
			cArqInd := CriaTrab( , .F. )
			DbUseArea(.T., "DBFCDX", cArqs, cAliasTmp, .F., .F.)
			IndRegua(cAliasTmp, cArqInd, "TMP_COD+TMP_PED"	,,, "Indice ID...")
			dbClearIndex()
			dbSetIndex(cArqInd+OrdBagExt())
			//MsgInfo("Arquivo criado '"+cArqs+GetDBExtension()+"'", "Atenção")
		EndIf
	EndIf

	//	U_UNIA027()
	//
	MsgRun("Aguarde, carregando Pré Lista de Postagem","PLP",  { || Carga() } )

	//Definindo as colunas que serão usadas no browse
	aAdd(aBrowse, {"Codigo",    "TMP_COD", "C", 20, 0, "@!"})
	aAdd(aBrowse, {"N. Fiscal",    "TMP_DOC", "C", TamSX3("C5_NOTA")[1], 0, "@!"})
	aAdd(aBrowse, {"Serie",    "TMP_SER", "C", TamSX3("C5_SERIE")[1], 0, "@!"})
	aAdd(aBrowse, {"Cliente",    "TMP_CLI", "C", TamSX3("A1_COD")[1], 0, "@!"})
	aAdd(aBrowse, {"Loja",    "TMP_LOJ", "C", TamSX3("A1_LOJA")[1], 0, "@!"})
	aAdd(aBrowse, {"Nome",    "TMP_NOM", "C", TamSX3("A1_NOME")[1], 0, "@!"})
	aAdd(aBrowse, {"Data de Expiração",      "TMP_DAT", "D", 08, 0, "@D"})

	SetFunName("UNIA026")

	aAdd(aIndex, "TMP_COD+TMP_PED" )
	aAdd(aIndex, "TMP_DOC" )

	//Criando o browse da temporária
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAliasTmp)
	oBrowse:SetQueryIndex(aIndex)
	oBrowse:SetTemporary(.T.)
	oBrowse:SetFields(aBrowse)
	oBrowse:DisableDetails()
	oBrowse:SetDescription(cTitulo)
	oBrowse:AddLegend( cAliasTmp+"->TMP_STA=='S'", "GREEN")
	oBrowse:AddLegend( cAliasTmp+"->TMP_STA=='N'", "BLUE")

	oBrowse:Activate()

	dbCloseArea(cAliasTmp)
	FErase(cArqs+OrdBagExt())
	FErase(cArqInd+OrdBagExt())

	SetFunName(cFunBkp)
	RestArea(aArea)
Return Nil

Static Function CpCampStr(cNome, cCampo)
	Local aRet := {}
	Local aCampo
	Default cCampo = cNome

	aCampo := TamSX3(cCampo)

	AAdd(aRet, cNome)
	AAdd(aRet, aCampo[3])
	AAdd(aRet, aCampo[1])
	AAdd(aRet, aCampo[2])

Return aRet
/*---------------------------------------------------------------------*
| Func:  MenuDef                                                      |
| Desc:  Criação do menu MVC                                          |
*---------------------------------------------------------------------*/
Static Function MenuDef()
	Local aRot := {}

	//Adicionando opções
	//	ADD OPTION aRot TITLE 'Incluir'  ACTION 'VIEWDEF.UNIA026' OPERATION MODEL_OPERATION_INSERT ACCESS 0
	ADD OPTION aRot TITLE 'Incluir'  ACTION {|| Incl()} OPERATION MODEL_OPERATION_INSERT ACCESS 0
	ADD OPTION aRot TITLE 'Imprime Etiquetas'  ACTION {|| ImpTela()} OPERATION MODEL_OPERATION_VIEW ACCESS 0
	ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.UNIA026' OPERATION MODEL_OPERATION_UPDATE ACCESS 0
	ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.UNIA026' OPERATION MODEL_OPERATION_DELETE ACCESS 0
Return aRot


Static Function ImpTela()
	Local oBrowser := FWMBrwActive()
	Local xRet
	Private _lGrava := .F.
	xRet := FWExecView('Imprime Etiquetas','VIEWDEF.UNIA026', MODEL_OPERATION_UPDATE,, { || .T. }, {|oModel| oModel:lModify:=.T., ImpEtq(), .T.}, ,,{|oModel| oModel:lModify:=.F., .T.} )
	If xRet == 0
		MsgRun("Aguarde, carregando Pré Lista de Postagem","PLP",  { || Carga() } )
		oBrowser:Refresh()
		oBrowser:ExecuteFilter(.T.)
	EndIf
Return xRet

Static Function Incl()
	Local oModelDad  := FWLoadModel("UNIA026")
	Local oModelForm
	Local oModelGrid
	Local lOk
	Local oBrowser := FWMBrwActive()

	U_UNIA027()
	MsgRun("Aguarde, carregando Pré Lista de Postagem","PLP",  { || Carga() } )
	oBrowser:Refresh()
	oBrowser:ExecuteFilter(.T.)
Return 0

/*---------------------------------------------------------------------*
| Func:  ModelDef                                                     |
| Desc:  Criação do modelo de dados MVC                               |
*---------------------------------------------------------------------*/
Static Function ModelDef()
	//Criação do objeto do modelo de dados
	Local oModel := Nil

	//Criação da estrutura de dados utilizada na interface
	Local oStTMP := FWFormModelStruct():New()
	Local oStFilho := FWFormModelStruct():New()

	Local bVldCom  := {|oModel| ValCom(oModel)}

	Local aRel  := {}

	oStTMP:AddTable(cAliasTmp, {'TMP_COD', 'TMP_DAT'}, "Temporaria")

	//Adiciona os campos da estrutura
	oStTmp:AddField(;
		"Codigo",;                                                                                  // [01]  C   Titulo do campo
		"Codigo",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_COD",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		20,;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_COD,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStTmp:AddField(;
		"Data de Expiração",;                                                                       // [01]  C   Titulo do campo
		"Data de Expiração",;                                                                       // [02]  C   ToolTip do campo
		"TMP_DAT",;                                                                                 // [03]  C   Id do Field
		"D",;                                                                                       // [04]  C   Tipo do campo
		09,;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_DAT,'')" ),;         // [11]  B   Code-block de inicializacao do campo
		.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual


	oStFilho:AddTable(cAliasTmp, {'TMP_STA', 'TMP_DOC', 'TMP_SER', 'TMP_PED'}, "Temporaria")

	//Adiciona os campos da estrutura
	oStFilho:AddField(;
		"Coleta",;                                                                                  // [01]  C   Titulo do campo
		"Coleta Solictada",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_STA",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		1,;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_STA,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStFilho:AddField(;
		"Nro NF",;                                                                                  // [01]  C   Titulo do campo
		"Nro NF",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_DOC",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TamSX3('C5_NOTA')[1],;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_DOC,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStFilho:AddField(;
		"Serie NF",;                                                                                  // [01]  C   Titulo do campo
		"Serie NF",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_SER",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TamSX3('C5_SERIE')[1],;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_SER,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStFilho:AddField(;
		"Pedido B2W",;                                                                                  // [01]  C   Titulo do campo
		"Pedido B2W",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_PED",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TAMSX3("C5_XPEDMKT")[1],;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_PED,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStFilho:AddField(;
		"Cliente",;                                                                                  // [01]  C   Titulo do campo
		"Cliente",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_CLI",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TamSX3('A1_COD')[1],;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_CLI,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStFilho:AddField(;
		"Loja",;                                                                                  // [01]  C   Titulo do campo
		"Loja",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_LOJ",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TamSX3('A1_LOJA')[1],;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_LOJ,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	oStFilho:AddField(;
		"Nome",;                                                                                  // [01]  C   Titulo do campo
		"Nome",;                                                                                  // [02]  C   ToolTip do campo
		"TMP_NOM",;                                                                                 // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TamSX3('A1_NOME')[1],;                                                                                        // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_NOM,'')" ),;                   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual


	//Instanciando o modelo, não é recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
	oModel := MPFormModel():New("UNIA026M",{|oModel| .T.}/*bPre*/, {|oModel| .T.}/*bPos*/, bVldCom/*bCommit*/,{|oModel| .T.}/*bCancel*/)

	//Atribuindo formulários para o modelo
	oModel:AddFields("FORMTMP",/*cOwner*/,oStTMP)
	oModel:AddGrid('GRIDTMP','FORMTMP',oStFilho)

	oModel:GetModel('GRIDTMP'):SetNoInsertLine(.T.)

	//Setando a chave primária da rotina
	oModel:SetPrimaryKey({})

	//Criando o relacionamento
	oModel:SetRelation( 'GRIDTMP',;
		{ { 'TMP_COD', 'TMP_COD' }}, ;
		"TMP_COD" )
	oModel:SetRelation('FORMTMP', aRel, "TMP_COD")

	//Adicionando descrição ao modelo
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)

	//Setando a descrição do formulário
	oModel:GetModel("FORMTMP"):SetDescription("Formulário do Cadastro "+cTitulo)

Return oModel
/*---------------------------------------------------------------------*
| Func:  ViewDef                                                      |
| Desc:  Criação da visão MVC                                         |
*---------------------------------------------------------------------*/
Static Function ViewDef()
	Local oModel := FWLoadModel("UNIA026")
	Local oStTMP := FWFormViewStruct():New()
	Local oStFilho := FWFormViewStruct():New()
	Local oView := Nil

	//Adicionando campos da estrutura
	oStTmp:AddField(;
		"TMP_COD",;                 // [01]  C   Nome do Campo
		"01",;                      // [02]  C   Ordem
		"Codigo",;                  // [03]  C   Titulo do campo
		"Codigo",;                  // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.T.,;     					// [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStTmp:AddField(;
		"TMP_DAT",;                 // [01]  C   Nome do Campo
		"02",;                      // [02]  C   Ordem
		"Data de Expiração",;       // [03]  C   Titulo do campo
		"Data de Expiração",;       // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"D",;                       // [06]  C   Tipo do campo
		"@D",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.F.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo

	//Adicionando campos da estrutura
	oStFilho:AddField(;
		"TMP_STA",;                 // [01]  C   Nome do Campo
		"03",;                      // [02]  C   Ordem
		"Coleta",;               // [03]  C   Titulo do campo
		"Coleta Solicitada",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.T.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStFilho:AddField(;
		"TMP_DOC",;                 // [01]  C   Nome do Campo
		"04",;                      // [02]  C   Ordem
		"Nro NF",;               // [03]  C   Titulo do campo
		"Nro NF",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.T.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStFilho:AddField(;
		"TMP_SER",;                 // [01]  C   Nome do Campo
		"05",;                      // [02]  C   Ordem
		"Serie NF",;               // [03]  C   Titulo do campo
		"Serie NF",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.T.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStFilho:AddField(;
		"TMP_PED",;                 // [01]  C   Nome do Campo
		"06",;                      // [02]  C   Ordem
		"Pedido B2W",;               // [03]  C   Titulo do campo
		"Pedido B2W",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.F.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStFilho:AddField(;
		"TMP_CLI",;                 // [01]  C   Nome do Campo
		"07",;                      // [02]  C   Ordem
		"Cliente",;               // [03]  C   Titulo do campo
		"Cliente",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.F.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStFilho:AddField(;
		"TMP_LOJ",;                 // [01]  C   Nome do Campo
		"08",;                      // [02]  C   Ordem
		"Loja",;               // [03]  C   Titulo do campo
		"Loja",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		"@!",;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.F.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	oStFilho:AddField(;
		"TMP_NOM",;                 // [01]  C   Nome do Campo
		"09",;                      // [02]  C   Ordem
		"Nome",;               // [03]  C   Titulo do campo
		"Nome",;               // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		PesqPict( "SA1", "A1_NOME" ),;                      // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.F.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo


	//Criando a view que será o retorno da função e setando o modelo da rotina
	oView := FWFormView():New()
	oView:SetModel(oModel)

	//Atribuindo formulários para interface
	oView:AddField("VIEW_TMP", oStTMP, "FORMTMP")
	oView:AddGrid('VIEW_TMP_GRID',oStFilho,'GRIDTMP')

	//Criando um container com nome tela com 100%
	oView:CreateHorizontalBox("CABEC",30)
	oView:CreateHorizontalBox("DET",70)

	//Colocando título do formulário
	oView:EnableTitleView('VIEW_TMP', 'Dados - '+cTitulo )

	//O formulário da interface será colocado dentro do container
	oView:SetOwnerView("VIEW_TMP","CABEC")
	oView:SetOwnerView('VIEW_TMP_GRID','DET')

	oView:SetCloseOnOk({|oView| .t.})
	oView:showUpdateMsg(.F.)

	//	oView:AddUserButton( 'Imprime Etiquetas', 'PRINT', {|oView| ImpEtq()} )


Return oView


Static Function ValCom(oModelDad)
	Local aArea      := GetArea()
	Local lRet       := .T.
	//	Local cFilSX5    := oModelDad:GetValue('FORMCAB', 'X5_FILIAL')
	Local cCodigo    := oModelDad:GetValue('FORMTMP', 'TMP_COD')
	//	Local cDescri    := oModelDad:GetValue('FORMCAB', 'X5_DESCRI')
	Local nOpc       := oModelDad:GetOperation()
	Local oModelGrid := oModelDad:GetModel('GRIDTMP')
	//	Local aHeadAux   := oModelGrid:aHeader
	//	Local aColsAux   := oModelGrid:aCols
	//	Local nPosChave  := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_CHAVE")})
	//	Local nPosDescPt := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_DESCRI")})
	//	Local nPosDescSp := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_DESCSPA")})
	//	Local nPosDescEn := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_DESCENG")})
	Local nAtual     := 0
	//
	//	DbSelectArea('SX5')
	//	SX5->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
	//
	//Se for Inclusão
	If nOpc == MODEL_OPERATION_INSERT
		Grava(oModelDad)
		//Se for Alteração
	ElseIf nOpc == MODEL_OPERATION_UPDATE
		If Type("_lGrava")=='L' .And. !_lGrava
			Grava(oModelDad)
			Return .T.
		EndIf
		//Percorre o acols
		For nAtual := 1 To oModelGrid:Length()
			oModelGrid:goLine(nAtual)
			If oModelGrid:isDeleted()
				If DelPed(AllTrim(oModelGrid:getValue("TMP_PED")))
					dbSelectArea(cAliasTmp)
					If dbSeek(cCodigo+oModelGrid:GetValue('TMP_PED'))
						RecLock(cAliasTmp, .F.)
						dbDelete()
						MsUnlock()
					EndIf
				EndIf
			EndIf
		Next
		//Se for Exclusão
	ElseIf nOpc == MODEL_OPERATION_DELETE
		//Percorre o acols
		For nAtual:=1 To oModelGrid:Length()
			oModelGrid:goLine(nAtual)
			If DelPed(AllTrim(oModelGrid:getValue("TMP_PED")))
				dbSelectArea(cAliasTmp)
				If dbSeek(cCodigo+oModelGrid:GetValue('TMP_PED'))
					RecLock(cAliasTmp, .F.)
					dbDelete()
					MsUnlock()
				EndIf
			EndIf
		Next
	EndIf
	//
	//	//Se não for inclusão, volta o INCLUI para .T. (bug ao utilizar a Exclusão, antes da Inclusão)
	//	If nOpc != MODEL_OPERATION_INSERT
	//		INCLUI := .T.
	//	EndIf

	RestArea(aArea)
Return lRet

// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function TrataErro(oObjRet, cMsg)
	Local lRet := .T.
	Local aData
	Default cMsg := ''

	If ValType(oObjRet) == 'O'
		aData := ClassDataArr(oObjRet, .T.)
		If ( AScan(aData, {|x| Upper(x[1])=='RESULT'})>0 .And. oObjRet:result == 'erro')
			lRet := .F.
		EndIf
		If ( AScan(aData, {|x| Upper(x[1])=='ERROR'})>0)
			cMsg := oObjRet:ERROR
			lRet := .F.
		EndIf
		If ( AScan(aData, {|x| Upper(x[1])=='MESSAGE'})>0)
			cMsg := oObjRet:MESSAGE
			If 'SUCESSO' $ Upper(cMsg)
				lRet := .T.
			EndIf
		EndIf
	Else
		cMsg := "Erro na requisição"+CRLF
		lRet := .F.
	EndIf
Return lRet



// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function SolColeta()
	Local aHeader := {}
	Local oRestClient := FWRest():New("https://api.skyhub.com.br")
	Local oObjRet := JsonObject():new()
	Local nI, nJ, nAtual, nBkp
	Local oBody := JsonObject():new()
	Local oView := FWViewActive()

	Local oModelDad  := FWModelActive()
	Local cCodigo    := oModelDad:GetValue('FORMTMP', 'TMP_COD')
	Local oModelGrid := oModelDad:GetModel('GRIDTMP')
	Local cMsg := ''
	Local lRet := .F.
	Local aRecs := {}
	Local oBrowser :=  FWMBrwActive()
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")

	// PREENCHE CABEÇALHO DA REQUISIÇÃO
	AAdd(aHeader, "x-user-email: "+cUsuario)
	AAdd(aHeader, "x-api-key: "+cApiKey)
	AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
	AAdd(aHeader, "accept: application/json;charset=UTF-8")
	AAdd(aHeader, "content-type: application/json")

	oRestClient:setPath("/shipments/b2w/confirm_collection")

	oBody['order_codes'] = {}

	//Percorre o acols
	nBkp := oModelGrid:nLine
	For nAtual := 1 To oModelGrid:Length()
		oModelGrid:goLine(nAtual)
		If !oModelGrid:isDeleted() .And. oModelGrid:GetValue("TMP_STA") == 'N'
			oBody['order_codes'] := {}

			AAdd(oBody['order_codes'], AllTrim(oModelGrid:getValue("TMP_PED")))

			oRestClient:SetPostParams(FWJsonSerialize(oBody,.F.,.F.))

			If oRestClient:Post(aHeader)
				FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
				If TrataErro(oObjRet, @cMsg)
					oModelGrid:LoadValue('TMP_STA', 'S')
					lRet := .T.
				EndIf
			Else
				cMsg := oRestClient:GetLastError()
			EndIf

		EndIf
	Next
	oModelGrid:GoLine(nBkp)
	oView:Refresh()

	If !Empty(cMsg)
		//Alert(cMsg)
	Else
		lRet := .T.
	EndIf

Return lRet

// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 25/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function GrvLinha(cSeek)
	Local aArea := GetArea()
	Local aAreaTmp

	dbSelectArea(cAliasTmp)
	aAreaTmp := GetArea()

	If dbSeek(cSeek)
		RecLock(cAliasTmp, .F.)
		(cAliasTmp)->TMP_STA := 'S'
		MsUnlock()
	EndIf

	RestArea(aAreaTmp)
	RestArea(aArea)
Return

// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function Collectable(lAptos)
	Local aHeader := {}
	Local oRestClient := FWRest():New("https://api.skyhub.com.br/shipments/b2w/collectables?requested="+If(lAptos, "true", "false")+"&offset=")
	Local oObjRet
	Local nI, nJ
	Local cQryAlias
	Local cQuery
	Local cMsg := ""
	Local nOffSet
	Local aRet := {}
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")


	// PREENCHE CABEÇALHO DA REQUISIÇÃO
	AAdd(aHeader, "x-user-email: "+cUsuario)
	AAdd(aHeader, "x-api-key: "+cApiKey)
	AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
	AAdd(aHeader, "accept: application/json;charset=UTF-8")
	AAdd(aHeader, "content-type: application/json")


	nOffSet:=1
	oRestClient:setPath(CValToChar(nOffSet))
	While oRestClient:Get(aHeader)
		FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
		If Len(oObjRet['orders']) > 0
			If TrataErro(oObjRet, @cMsg)
				For nI:=1 To Len(oObjRet['orders'])
					AAdd(aRet, oObjRet['orders'][nI]['code'])
				Next
			EndIf

			nOffSet++
			oRestClient:setPath(CValToChar(nOffSet))
		Else
			exit
		Endif
	EndDo
Return aRet


// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function Carga()
	Local oModelDad  := FWLoadModel("UNIA026")
	Local oModelForm
	Local oModelGrid
	Local lOk
	Local aHeader := {}
	Local oRestClient := FWRest():New("https://api.skyhub.com.br/shipments/b2w?offset=")
	Local oObjRet
	Local nI, nJ
	Local cQryAlias
	Local cQuery
	Local cMsg := ""
	Local aReqs
	Local nOffSet
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")
	Local lContinua := .T.

	aReqs := Collectable(.T.)

	//Apaga()

	// PREENCHE CABEÇALHO DA REQUISIÇÃO
	AAdd(aHeader, "x-user-email: "+cUsuario)
	AAdd(aHeader, "x-api-key: "+cApiKey)
	AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
	AAdd(aHeader, "accept: application/json;charset=UTF-8")
	AAdd(aHeader, "content-type: application/json")

	nOffSet:=1
	lContinua := .T.
	oRestClient:setPath(CValToChar(nOffSet))
	While lContinua .And. oRestClient:Get(aHeader)
		FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
		If TrataErro(oObjRet, @cMsg)
			If Len(oObjRet:plp)>0
				nOffSet++
				oRestClient:setPath(CValToChar(nOffSet))
				For nI:=1 To Len(oObjRet:plp)
					If(oObjRet:plp[nI]:type == "DIRECT")
						oModelDad  := FWLoadModel("UNIA026")
						oModelForm := oModelDad:GetModel('FORMTMP')
						oModelGrid := oModelDad:GetModel('GRIDTMP')

						dbSelectArea(cAliasTmp)
						If dbSeek(CValToChar(oObjRet:plp[nI]:id))
							oModelDad:SetOperation(MODEL_OPERATION_UPDATE)
						Else
							oModelDad:SetOperation(MODEL_OPERATION_INSERT)
						EndIf

						oModelDad:Activate()
						oModelGrid:SetNoInsertLine(.F.)
						For nJ:=1 To Len(oObjRet:plp[nI]:orders)
							cQuery := " SELECT TOP 1 * FROM "+RetFullName("SC5")+" SC5 "+CRLF
							cQuery += " JOIN "+RetFullName("SA1")+" SA1 "+CRLF
							cQuery += " 	ON SA1.D_E_L_E_T_='' AND A1_FILIAL='"+XFilial("SA1")+"' "+CRLF
							cQuery += " 	AND A1_COD = C5_CLIENTE AND A1_LOJA=C5_LOJACLI "+CRLF
							cQuery += " WHERE SC5.D_E_L_E_T_='' "+CRLF
							cQuery += " 	AND C5_FILIAL = '"+XFilial("SC5")+"' "+CRLF
							cQuery += " 	AND C5_XPEDMKT = '"+AllTrim(oObjRet:plp[nI]:orders[nJ]:code)+"' "+CRLF

							cQuery := ChangeQuery(cQuery)
							dbUseArea(.T.,'TOPCONN', TCGenQry(,,cQuery),(cQryAlias:=GetNextAlias()), .F., .T.)
							If (cQryAlias)->(!Eof())

								If nJ > 1
									oModelGrid:AddLine()
								EndIf
								oModelForm:LoadValue('TMP_COD', PADR(CValToChar(oObjRet:plp[nI]:id),20))
								oModelForm:LoadValue('TMP_DAT', STOD(StrTran(oObjRet:plp[nI]:expiration_date, "-","")))

								oModelGrid:LoadValue('TMP_PED', PADR(oObjRet:plp[nI]:orders[nJ]:code, TAMSX3("C5_XPEDMKT")[1]))

								oModelGrid:LoadValue('TMP_DOC', (cQryAlias)->C5_NOTA)
								oModelGrid:LoadValue('TMP_SER', (cQryAlias)->C5_SERIE)

								oModelGrid:LoadValue('TMP_CLI', (cQryAlias)->A1_COD)
								oModelGrid:LoadValue('TMP_LOJ', (cQryAlias)->A1_LOJA)
								oModelGrid:LoadValue('TMP_NOM', (cQryAlias)->A1_NOME)

								If AScan(aReqs, {|x| AllTrim(x) == AllTrim(oObjRet:plp[nI]:orders[nJ]:code) }) > 0
									oModelGrid:LoadValue('TMP_STA', 'S')
								Else
									oModelGrid:LoadValue('TMP_STA', 'N')
								EndIf
							EndIf
							(cQryAlias)->(dbCloseArea())
						Next
						If oModelDad:vlddata()
							oModelDad:commitData()
						EndIf
						oModelDad:DeActivate()

					EndIf
				Next
			Else
				lContinua := .F.
			EndIf
		Else
			lContinua := .F.
			cMsg := oRestClient:getLastError()
		EndIf
	EndDo

	If !Empty(cMsg)
		Alert(cMsg)
	EndIf
Return

// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 22/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function DelPed(cPed)
	Local aHeader := {}
	Local oRestClient := FWRest():New("https://api.skyhub.com.br/shipments/b2w/")
	Local oObjRet := JsonObject():new()
	Local nI, nJ
	Local lRet := .F.
	Local aData
	Local cMsg := ""
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")


	// PREENCHE CABEÇALHO DA REQUISIÇÃO
	AAdd(aHeader, "x-user-email: "+cUsuario)
	AAdd(aHeader, "x-api-key: "+cApiKey)
	AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
	AAdd(aHeader, "accept: application/json;charset=UTF-8")
	AAdd(aHeader, "content-type: application/json")

	oRestClient:setPath(cPed)
	If oRestClient:Delete(aHeader)
		FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
		lRet := TrataErro(oObjRet, @cMsg)
	Else
		cMsg := oRestClient:GetLastError()
		lRet := .F.
	EndIf
	If !Empty(cMsg) .And. !lRet
		Alert(cMsg)
	EndIf
Return lRet


// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 21/06/2020 | Miqueias Dernier  |
// -----------+-------------------+-----------------------------------------------------------
Static Function ImpEtq()
	Local aArea := GetArea()
	Local oModelDad  := FWModelActive()

	Local aHeader := {}
	Local oRestClient := FWRest():New("http://localhost:3000/api/shipments/b2w/view?plp_id=")
	// -----------+-------------------+-----------------------------------------------------------
	// 21/06/2020 | Miqueias Dernier  | Foi necessário utilizar um serviço local para intermediar
	//            |                   |a conexão com a skyhub pois o protheus adiciona um "*"
	//            |                   |à chave  "accept: application/json" no cabeçalho da requisição.
	//            |                   |A skyhub entende esse "*" como se devesse entregar o documento
	//            |                   |em PDF ao invés do JSON
	// -----------+-------------------+-----------------------------------------------------------

	Local oObjRet := JsonObject():new()
	Local nI, nJ
	Local lRet := .F.
	Local cPed := oModelDad:getValue('FORMTMP', "TMP_COD")
	Local cMsg := ""
	Local aData
	Local cUsuario := GetNewPar("MV_XB2WUSR", "anderson.fernandes@unicario.com.br")
	Local cApiKey := GetNewPar("MV_XB2WKAP", "BkBvN4CXrBuqqExxT7vH")
	Local cAccKey := GetNewPar("MV_XB2WAKE", "xk21bPa9jQ")



	// PREENCHE CABEÇALHO DA REQUISIÇÃO
	AAdd(aHeader, "x-user-email: "+cUsuario)
	AAdd(aHeader, "x-api-key: "+cApiKey)
	AAdd(aHeader, "x-accountmanager-key: "+cAccKey)
	AAdd(aHeader, "accept: application/json;charset=UTF-8")
	AAdd(aHeader, "Content-Type: application/json")


	oRestClient:setPath(AllTrim(cPed))
	If oRestClient:Get(aHeader)
		FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
		If !TrataErro(oObjRet, @cMsg)
			lRet := .F.
			Return lRet
		EndIf
	EndIf

	If !Empty(cMsg)
		Alert(cMsg)
		Return
	EndIf

	If SolColeta()
		FWJsonDeserialize(oRestClient:GetResult(),@oObjRet)
		If MsgYesNo("Imprime Etiquetas?")
			FImprime(oObjRet)
		EndIf
	EndIf

	RestArea(aArea)
Return .T.


#Include "TOTVS.ch"
#Include "RwMake.ch"
#Include "FileIo.ch"
#Include "TopConn.ch"

Static Function FImprime(oObjRet)

	Local aAreaAnt    := GetArea()
	Local nAuxXeq, nE, nI, nJ
	Local oModel := FWModelActive()
	Local oGrid := oModel:getModel('GRIDTMP')

	// Imprime a Etiqueta
	For nI:=1 To Len(oObjRet:DOCSEXTERNOS)
		If oGrid:SeekLine({{"TMP_COD",PADR(CValToChar(oObjRet:plp:id),20)},{"TMP_PED",PADR(oObjRet:docsexternos[nI]:docexterno, TAMSX3("C5_XPEDMKT")[1])}});
				.And. !oGrid:isDeleted()
			For nJ:=1 To Len(oObjRet:DOCSEXTERNOS[nI]:awbs)
				If !U_UniPrtInicializa()
					Return
				EndIf
				FImpEtiqueta(oObjRet, nI, nJ)
				//Encerra a Impressão da Etiqueta
				U_UniPrtFinaliza()
				Sleep(1500)
			Next
		EndIf
	Next

Return


Static Function FImpEtiqueta(oObjRet, nI, nJ)

	Local nColSec1 	:= 05
	Local nLinSec1 	:= 05
	Local cFonte   	:= "0"
	Local cTam		:= "35"
	Local cTam2		:= "40"
	Local oEtiqueta := oObjRet:DOCSEXTERNOS[nI]

	Local nLinha := 5

	// Inicializa a montagem da Imagem para cada Etiqueta
	//MsCbBegin( nQtdCopys, nVeloc(1,2,3,4,5,6 polegadas por segundo), nTamanho ( da etiqueta em milímetros ), lSalva )
	MsCbBegin( 01, 01, 130)

	//MSCBBOX(nX1mm, nY1mm, nX2mm, nY2mm, nExpessura, cCor)
	MSCBBOX(0, 0, 100, 130, 3)

	//MSCBBOX(7, nLinha+2, 7+20, nLinha + 20+2, 10)
	MSCBWrite("^FO50,70^GFA,3699,3699,27,,:::::::::::::::::::::::::::::::T07F,T0FF8,S01FF8,::S01FF,S01F,:::::::R0JFE,Q01KF,Q03KF8,Q03KFC,Q07KFC,:::::M03SF8,M0TFE,K061UF,J01E3UF8P0E,J03E3UFCP0E,J01E7UFCP0E,J01C7UFEP0E,K0CVFEI07E063E1FC7303F00F8C0FE,K0CVFE001FF077E3FE778FF81FFE1FF,K0XF001EF8IF1FC7F0F7C3FFE1FF8,K0XF003838F8F0E07E1C1C3C3E0078,K0XF003838F070E07C1C1E781E0038,K0XF00701CF070E078380E701E003C,K0CWF00783CF070E0783C1E700E07BC,K0CVFE007FFCF070E0703FFE701E1FFC,J01CVFE007FF8F070E0703FFC701E3C7C,J01E7UFE007I0F070E0703800781E383C,J03E7UFC003800F070E0703C003C3E703C,J01E3UFC383810F070F0701C083FFE783C,K061UF8383E38F070FC701F1C1FDE387C,M0UF0381FF8F070FC700FFC0F8E3FFC,M07SFC0380FF060707C7007F8001C1FB8,N0SF001003CK0382001EI01C06,hG0303C,hG03FF8,:hH0FE,hH038,,::::::::::::::::::::::::::::::::::::::::::::::::::::^FS")

	//MSCBBOX(38.5, nLinha+0, 38.5+25, nLinha + 25, 10)

	//MSCBBOX(-7+80, nLinha+2, -7+100, nLinha + 20+2, 10)
	MSCBWrite("^FO587,54^GFA,3078,3078,19,,::::::::::::::W0JFC,U01LFE,T01NFC,T0PF8,S03PFE,S0RF8,R03RFE,R0TF8,Q03TFE,Q07UF,P01VFC,P03VFE,P07WF,P0XFC,O01XFE,O07YF,O0gF8,N01gFC,N03gFE,N03gGF,N07gGF8,N0gHF8,M01gHFC,M03gHFE,M03gIF,M07gIF,M0gJF8,M0gJFC,L01gJFC,L03gJFE,:L07gKF,:L0gLF8,:K01gLFC,:K01gLFE,K03gLFE,:K03gMF,K07gMF,:K07gMF8,K0gNF8,::K0gNFC,J01gNFC,::::J01gNFE,:J03gNFE,:::::J03QF8K0QFE,J03PF8M07OFE,J03OF8O0OFE,J03NFCP01NFE,J03MFER03MFE,J03MF8S0MFE,J03LFET03LFE,J03LF8U0LFE,J03KFEV03KFE,J03KF8W0KFE,J03KFX07JFE,J03JFCX01JFE,J03JF8Y0JFE,J03JFg03IFE,J03IFCg01IFE,J03IF8gG0IFE,J03IFgH07FFE,J03FFEgH01FFE,J03FFCgI0FFE,J03FF8gI07FE,J03FFgJ03FE,J03FEgJ01FE,J03FCgK0FE,J03F8gK0FE,J03FgL07E,J03EgL03E,J03CgL01E,J03CgM0E,J038gM0E,J03gN06,J02gN02,,::::W03FFE,V03JFE,V0LFC,U07MF,U0NFC,T03NFE,T07OF8,S01PFC,S03PFE,S07QF,S0RF8,R01RFC,R03RFE,R07SF,R07SF8,R0TF8,Q01TFC,Q01TFE,Q03TFE,Q03UF,Q07UF,Q07UF8,Q0VF8,:P01VFC,::P01VFE,P03VFE,::::P03WF,:,::::::::::::::^FS")


	nLinha := nLinha + 24 + 2
	//MSCBSAY(nXmm, nYmm, cTexto, cRotacao, cFonte, cTam, lReverso, lSerial, cIncr, lZerosL, lNoAlltrim)
	MSCBSAY(05, nLinha, "Nota Fiscal: "+oEtiqueta:NUMNOTAFISCAL, "N", "0", "22, 28")
	MSCBSAY(-5+80, nLinha, "Volume "+CValToChar(oEtiqueta:aWbs[nJ]:posicaoVolume)+"/"+CValToChar(oEtiqueta:qtVolumes), "N", "0", "22, 28")
	nLinha += 2.7
	MSCBSAY(05, nLinha, "Pedido: "+oEtiqueta:DOCEXTERNO, "N", "0", "22, 28")
	nLinha += 2.7
	MSCBSAY(05, nLinha, "PL: "+CValToChar(oObjRet:plp:id), "N", "0", "22, 28")
	nLinha += 2.7
	MSCBSAY(05, nLinha, "DtPr: "+oEtiqueta:dtPrometida, "N", "0", "22, 28")


	nLinha := 43
	MSCBSAYBAR(17, nLinha+2,oEtiqueta:awbs[nJ]:codigoAwb,"N","MB07",12,.F.,.T.,.T.,,3,2)
	//MSCBBOX(10, nLinha+0, 90, nLinha := nLinha+15, 10)
	nLinha += 15

	nLinha += 2
	MSCBSAY(05, nLinha, "Recebedor:", "N", "0", "26, 25")
	MSCBLineH(23.5, nLinha + 2.6, 100-5, 2)
	nLinha += 5.5
	MSCBSAY(05, nLinha, "Assinatura:", "N", "0", "26, 25")
	MSCBLineH(23.5, nLinha + 2.6, 100-45-5-1, 2)
	MSCBSAY(05 + 45, nLinha, "Documento:", "N", "0", "26, 25")
	MSCBLineH(70, nLinha + 2.6, 100-5, 2)


	//MSCBLineH(nX1mm, nY1mm, nX2mm, nExpessura, cCor)
	MSCBLineH(0, 70, 100, 3)
	MSCBBOX(0, 70, 35, 70+7, 3)
	nLinha := 70 + 7 + 1
	MSCBSAY(7, nLinha, oEtiqueta:destinatario:nome, "N", "0", "26, 25")
	MSCBSAY(94, nLinha+2, oEtiqueta:rota, "B", "0", "50, 60")

	nLinha += 3.7
	MSCBSAY(7, nLinha, oEtiqueta:destinatario:enderecoLogradouro+ ' - '+oEtiqueta:destinatario:enderecoNumero, "N", "0", "26, 25")
	nLinha += 3.7
	MSCBSAY(7, nLinha, oEtiqueta:destinatario:enderecoBairro, "N", "0", "26, 25")
	nLinha += 3.7
	MSCBSAY(7, nLinha, oEtiqueta:destinatario:enderecoComplemento, "N", "0", "26, 25")
	nLinha += 3.7
	MSCBSAY(7, nLinha, Transform(strzero(Val(oEtiqueta:destinatario:enderecoCep),8),"@R 99999-999")+" "+oEtiqueta:destinatario:enderecoCidade+"/"+oEtiqueta:destinatario:enderecoUf, "N", "0", "26, 25")

	//MSCBSAYBAR(nXmm, nYmm, cConteudo, cRotacao, cTypePrt, nAltura, lDigVer,
	// lLinha, lLinBaixo, cSubSetIni, nLargura, nRelacao, lCompacta, lSerial, cIncr, lZerosL)
	MSCBSAYBAR(7, 110-13,strzero(Val(oEtiqueta:destinatario:enderecoCep),8),"N","MB07",12,.F.,.F.,.T.,,2,1)
	nLinha += 6
	MSCBSAY(47, nLinha, oEtiqueta:megaRota, "N", "0", "28, 25")
	nLinha += 4
	MSCBSAY(47, nLinha, "FRETE", "N", "0", "28, 34")

	MSCBBOX(0, 70, 40, 70+7, 30, "B")
	MSCBSAY(3, 70 + 2.1, "DESTINATÁRIO", "N", "0", "31, 45",.T.)





	MSCBLineH(0, 110, 100, 3)
	nLinha := 110 + 2.5
	MSCBSAY(5, nLinha, "Remetente: "+oEtiqueta:remetente:nome, "N", "0", "26, 25")
	nLinha += 3.7
	MSCBSAY(5, nLinha, oEtiqueta:remetente:enderecoLogradouro+ ' - '+oEtiqueta:remetente:enderecoNumero, "N", "0", "26, 25")
	nLinha += 3.7
	MSCBSAY(5, nLinha, oEtiqueta:remetente:enderecoComplemento, "N", "0", "26, 25")
	nLinha += 3.7
	MSCBSAY(5, nLinha, Transform(strzero(Val(oEtiqueta:remetente:enderecoCep),8),"@R 99999-999")+" "+oEtiqueta:remetente:enderecoCidade+"/"+oEtiqueta:remetente:enderecoUf, "N", "0", "26, 25")

	//MSCBWrite("^FXPARAMETROS GERAIS ^FS")
	//MSCBWrite("^LL120")
	//MSCBWrite("^LH30,30")
	//MSCBWrite("^PRA")
	//MSCBWrite("^PQ10,2,,N")
	//MSCBWrite("^FXCONTEUDO DA ETIQUETA^FS")
	//MSCBWrite("^F01,1^GB250,90,10^FS")
	//MSCBWrite("^F035,40^ADN,18,10^FDMicrosiga Software S/A^FS")


	// Finaliza a Etiqueta
	MsCbEnd()

Return

// ###########################################################################################
// Projeto:
// Modulo :
// Função :
// -----------+-------------------+-----------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+-----------------------------------------------------------
// 25/06/2020 | Miqueias Dernier  |
//            |                   |
// -----------+-------------------+-----------------------------------------------------------
Static Function Apaga()
	Local aArea := GetArea()

	dbSelectArea(cAliasTmp)
	dbGoTop()
	ZAP

	RestArea(aArea)
Return

Static Function Grava(oModel)
	Local oStruct := oModel:GetModel("FORMTMP"):GetStruct()
	Local oGrid := oModel:GetModel("GRIDTMP")
	Local oStruct2 := oModel:GetModel("GRIDTMP"):GetStruct()
	Local nI, nJ, nK, nPos
	Local aAux1, aAux2


	aAux1 := oStruct:GetFields()
	aAux2 := oStruct2:GetFields()


	For nJ:=1 To oGrid:Length()
		oGrid:goLine(nJ)
		If !oGrid:isDeleted()

			dbSelectArea(cAliasTmp)
			If oModel:GetOperation() == MODEL_OPERATION_UPDATE;
					.And. dbSeek(oModel:getValue("FORMTMP", "TMP_COD")+oModel:GetValue("GRIDTMP",'TMP_PED'))
				RecLock(cAliasTmp, .F.)
			Else
				RecLock(cAliasTmp, .T.)
			EndIf


			For nI := 1 To Len( aAux1 )
				(cAliasTmp)->(&(aAux1[nI][3])) := oModel:GetValue('FORMTMP', aAux1[nI][3])
			Next

			For nI := 1 To Len( aAux2 )
				(cAliasTmp)->(&(aAux2[nI][3])) := oModel:GetValue('GRIDTMP', aAux2[nI][3])
			Next
			MSUnlock()
		EndIf
	Next

Return
