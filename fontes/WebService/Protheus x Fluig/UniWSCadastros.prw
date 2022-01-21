
/*/{Protheus.doc} oUniWSCadastros

@project Integração Protheus x Fluig
@description Webservice de consumo para permitir a consulta dos cadastros do Protheus pelo Fluig
@WSDL http://192.168.0.225:9001/OUNIWSCADASTROS.apw?WSDL
@author Rafael Rezende
@since 08/05/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "ApWebsrv.ch"
#Include "TbiConn.ch"
#Include "TopConn.ch"

WSService oUniWSCadastros Description "WebService de Integração do Fluig com os Cadastros do Protheus"

	// Filtros para os Métodos
	WSData oEmpresaFiltro			As oFilEmpresa
	WSData oCabecTabPrecoFiltro 	As oFilCabecalhoTabelaPreco
	WSData oItemTabPrecoFiltro  	As oFilItemTabelaPreco
	WSData oCondPagtoFiltro			As oFilCondicaoPagamento
	WSData oTabGenericaFiltro		As oFilTabelaGenerica
	WSData oMunicipioFiltro			As oFilMunicipio
	WSData oDepartamentoFiltro  	As oFilDepartamento
	WSData oCategoriaFiltro			As oFilCategoria
	WSData oLinhaFiltro				As oFilLinha
	WSData oTESFiltro				As oFilTES
	WSData oNaturezaFiltro			As oFilNatureza
	WSData oBancoFiltro				As oFilBanco
	WSData oVendedorFiltro			As oFilVendedor
	WSData oTransportadoraFiltro	As oFilTransportadora
	WsData oParcelaFiltro 			As oFilParcela
	WSData oCompartilhamentoFiltro	As oFilCompartilhamento

	// Retorno para os Métodos
	WsData oListEmpresas			As Array Of oEmpresa
	WsData oListCabTabPreco  		As Array Of oCabecalhoTabelaPreco
	WsData oListItensTabPreco    	As Array Of oItensTabelaPreco
	WsData oListCondPagamento   	As Array Of oCondicaoPagamento
	WsData oListTabGenerica     	As Array Of oTabelaGenerica
	WsData oListMunicipio			As Array Of oMunicipio
	WsData oListDepartamento		As Array Of oDepartamento
	WsData oListCategoria			As Array Of oCategoria
	WsData oListLinha				As Array Of oLinha
	WsData oListTES					As Array Of oTES
	WsData oListNatureza			As Array Of oNatureza
	WsData oListBanco				As Array Of oBanco
	WsData oListVendedor			As Array Of oVendedor
	WsData oListTransportadora		As Array Of oTransportadora
	WsData oListParcela 			As Array Of oParcela
	WsData cRetCompartilhamento		As String

	// Métodos
	WSMethod GetEmpresas				Description "Método para buscar as informações do Cadastro de Empresas do Protheus"
	WSMethod GetCabecalhoTabelasPreco   Description "Método para buscar as informações das Tabela de Preços do Protheus"
	WSMethod GetItensTabelasPreco 		Description "Método para buscar as informações dos Itens das Tabelas de Preços do Protheus"
	WSMethod GetCondicoesPagamento 		Description "Método para buscar as informações das Condições de Pagamento do Protheus"
	WSMethod GetTabelasGenericas		Description "Método para buscar as informações das Tabelas Genéricas ( SX5 ) do Protheus"
	WSMethod GetMunicipios				Description "Método para buscar as informações das Tabelas de Municípios do Protheus"
	WSMethod GetDepartamentos			Description "Método para buscar as informações dos Departamentos do Protheus"
	WSMethod GetCategorias				Description "Método para buscar as informações das Categorias do Protheus"
	WSMethod GetLinhas					Description "Método para buscar as informações das Linhas do Protheus"
	WSMethod GetTESs					Description "Método para buscar as informações das TES do Protheus"
	WSMethod GetNaturezas				Description "Método para buscar as informações das Naturezas do Protheus"
	WSMethod GetBancos					Description "Método para buscar as informações dos Bancos do Protheus"
	WSMethod GetVendedores				Description "Método para buscar as informações dos Vendedores do Protheus"
	WSMethod GetTransportadoras			Description "Método para buscar as informações das Transportadoras do Protheus"
	WSMethod GetParcelas				Description "Método para retornar as Parcelas para uma determinada Condição de Pagamento"
	WsMethod GetCompartilhamento		Description "Método para buscar as informações de Compartilhamento das Tabelas"

EndWSService


// Entidade: Empresa/Filial - SM0
WSStruct oEmpresa
	WSData cCodEmpresa		 	As String
	WSData cRazaoSocial			AS String
	WSData cCodFilial			AS String
	WSData cNomeFilial			AS String
	WSData cCGC					As String
EndWSStruct

WSStruct oFilEmpresa
	WSData cCodEmpresa 			As String
	WSData cCodFilial 			AS String
EndWSStruct

// Entidade: Tabela de Preço - Cabeçalho (Tabelas Ativas) - DA0
WSStruct oCabecalhoTabelaPreco
	WSData cCodFilial 			As String
	WSData cCodTabela 			As String
	WSData cDescTabela			As String
	WSData cDataInicio 			As String
	WSData cHoraInicio 			As String
	WSData cDataFinal 			As String
	WSData cHoraFinal 			As String
	WSData cAtiva 				As String
	WSData cTipoHorario			As String
	WSData cCondPagto 			As String
EndWSStruct

WSStruct oFilCabecalhoTabelaPreco
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodTabela			As String
	WSData cAtivo				As String
EndWSStruct

// Entidade: Itens da Tabela de Preços - DA1
WSStruct oItensTabelaPreco
	WSData cCodFilial			As String
	WSData cTipoPreco			As String
	WSData cItem				As String
	WSData cCodTabela			As String
	WSData cCodProduto			As String
	WSData cCodDepartamento		As String
	WSData nPrecoVenda			As Float
	WSData nValorDesconto		As Float
	WSData nPercDesconto		As Float
	WSData cAtivo				As String
	WSData nFrete				As Float
	WSData cEstado				As String
	WSData cTipoOperacao		As String
	WSData nPrecoMaximo			As Float
EndWSStruct

WSStruct oFilItemTabelaPreco
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodTabela			As String
	WSData cCodProduto			As String
	WSData cCodDepartamento 	As String
	WSData cAtivo				As String
EndWSStruct

// Entidade: Condição de Pagamento - SE4
WSStruct oCondicaoPagamento
	WSData cCodigo 				As String
	WSData cTipo 				As String
	WSData cCondPagamento	 	As String
	WSData cDescricao 			As String
	WSData cFormaPagto	 		As String
	WSData nTxAcrescimo			As Float
	WSData cStatus 				As String
EndWSStruct

WSStruct oFilCondicaoPagamento
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCondPagamento		As String
	WSData cDescricao			As String
	WSData cFormaPagto			As String
	WSData cStatus				As String
EndWSStruct

// Entidade: SX5 - Tabela 12 (Estado) e 24 (Forma de Pagamento)
WSStruct oTabelaGenerica
	WSData cCodFilial  			As String
	WSData cCodTabela			As String
	WSData cChave				As String
	WSData cDescPortugues		As String
	WSData cDescEspanhol		As String
	WSData cDescIngles			As String
EndWSStruct

WSStruct oFilTabelaGenerica
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodTabela 			As String
	WSData cChave 				As String
EndWSStruct

// Entidade: Código do Município - CC2
WSStruct oMunicipio
	WSData cCodFilial			As String
	WSData cEstado				As String
	WSData cCodMunicipio		As String
	WSData cDescMunicipio		As String
EndWSStruct

WSStruct oFilMunicipio
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cEstado	 			As String
	WSData cCodMunicipio		As String
	WSData cDescMunicipio		As String
EndWSStruct

// Entidade: Grupo/Departamento – SBM
WSStruct oDepartamento
	WSData cCodFilial			As String
	WSData cCodDepartamento 	As String
	WSData cDescDepartamento	As String
EndWSStruct

WSStruct oFilDepartamento
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodDepartamento 	As String
	WSData cDescDepartamento	As String
EndWSStruct

// Entidade: Categoria - SZ1
WSStruct oCategoria
	WSData cCodFilial			As String
	WSData cCodCategoria		As String
	WSData cDescCategoria		As String
	WSData cCodDepartamento		As String
	WSData cDescDepartamento	As String
EndWSStruct

WSStruct oFilCategoria
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodCategoria	 	As String
	WSData cCodDepartamento		As String
	WSData cDescCategoria	 	As String
EndWSStruct

// Entidade: Linha - SZ2
WSStruct oLinha
	WSData cCodFilial			As String
	WSData cCodLinha			As String
	WSData cDescLinha			As String
	WSData cCodCategoria		As String
	WSData cDesCategoria		As String
EndWSStruct

WSStruct oFilLinha
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodLinha		 	As String
	WSData cCodCategoria		As String
	WSData cDescLinha		 	As String
EndWSStruct

// Entidade: TES - SF4
WSStruct oTES
	WSData cCodFilial			As String
	WSData cCodigoTES			As String
	WSData cTipo				As String
	WSData cCFOP				As String
	WSData cDescricao 			As String
EndWSStruct

WSStruct oFilTES
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodTES			 	As String
	WSData cCFOP				As String
EndWSStruct

// Entidade: Natureza – SED
WSStruct oNatureza
	WSData cCodFilial			As String
	WSData cCodNatureza			As String
	WSData cDescNatureza 		As String
EndWSStruct

WSStruct oFilNatureza
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodNatureza		 	As String
EndWSStruct

// Entidade: Bancos - SA6
WSStruct oBanco
	WSData cCodFilial 			As String
	WSData cBanco				As String
	WSData cAgencia				As String
	WSData cConta				As String
	WSData cNome				As String
EndWSStruct

WSStruct oFilBanco
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cBanco			 	As String
	WSData cAgencia			 	As String
EndWSStruct

// Entidade: Vendedor - SA3
WSStruct oVendedor
	WSData cCodFilial			As String
	WSData cCodVendedor 		As String
	WSData cNomeVendedor 		As String
	WSData cTipoPessoa 			As String
	WSData cCNPJ 				As String
	WSData cNomeReduzido 		As String
	WSData cTipoVendedor	 	As String
	WSData nComissao 			As Float
	WSData cCargo		 		As String
	WSData cSupervisor 			As String
	WSData cGerente 			As String
EndWSStruct

WSStruct oFilVendedor
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodVendedor		 	As String
	WSData cSupervisor		 	As String
	WSData cGerente			 	As String
EndWSStruct

// Entidade: Transportadora - SA4
WSStruct oTransportadora
	WSData cCodFilial			As String
	WSData cCodTransportadora	As String
	WSData cNomeTransportadora	As String
	WSData cCNPJ 				As String
	WSData cNomeReduzido 		As String
	WSData cUF				 	As String
EndWSStruct

WSStruct oFilTransportadora
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCodTransportadora 	As String
	WSData cUF				 	As String
EndWSStruct

// Entidade: Parcela
WSStruct oParcela
	WSData nValorParcela		As Float
	WSData cDataParcela			As String
EndWSStruct

WSStruct oFilParcela
	WSData cCodEmpresa			As String
	WSData cCodFilial			As String
	WSData cCondPagamento		As String
	WSData nValorOrcamento		As Float
	WSData nValorAcrescimo		As Float
	WSData cDataOrcamento		As String
EndWSStruct

// Filtro para o Método de Compartilhamento de Tabelas no Protheus
WSStruct oFilCompartilhamento
	WSData cCodEmpresa			As String
	WSData cAliasTabela			As String
EndWSStruct


WSMethod GetEmpresas WSReceive oEmpresaFiltro WSSend oListEmpresas WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE EMPRESAS ________________________________" )

	::oListEmpresas := {}
	DbSelectArea( "SM0" )
	If Select( "SM0" ) == 0

		ConOut( "Precisou abrir a SM0!" )
		OpenSM0( "01", .T. )
		DbSelectArea( "SM0" )

	Else
		ConOut( "SM0 ja aberta!" )
	EndIf
	aAreaSM0 := SM0->( GetArea() )
	SM0->( DbGoTop() )
	Do While !SM0->( Eof() )

		If AllTrim( ::oEmpresaFiltro:cCodEmpresa ) == "" .And. ;
				AllTrim( ::oEmpresaFiltro:cCodFilial  ) == ""

			aAdd( ::oListEmpresas, WsClassNew( "oEmpresa" ) )
			aTail( ::oListEmpresas ):cCodEmpresa	:= SM0->M0_CODIGO
			aTail( ::oListEmpresas ):cRazaoSocial	:= SM0->M0_NOME
			aTail( ::oListEmpresas ):cCodFilial		:= SM0->M0_CODFIL
			aTail( ::oListEmpresas ):cNomeFilial	:= SM0->M0_FILIAL
			aTail( ::oListEmpresas ):cCGC			:= SM0->M0_CGC

		ElseIf AllTrim( ::oEmpresaFiltro:cCodEmpresa ) == "" .And. ;
				AllTrim( ::oEmpresaFiltro:cCodFilial  ) != ""

			If AllTrim( ::oEmpresaFiltro:cCodFilial  ) == AllTrim( SM0->M0_CODFIL )

				aAdd( ::oListEmpresas, WsClassNew( "oEmpresa" ) )
				aTail( ::oListEmpresas ):cCodEmpresa	:= SM0->M0_CODIGO
				aTail( ::oListEmpresas ):cRazaoSocial	:= SM0->M0_NOME
				aTail( ::oListEmpresas ):cCodFilial		:= SM0->M0_CODFIL
				aTail( ::oListEmpresas ):cNomeFilial	:= SM0->M0_FILIAL
				aTail( ::oListEmpresas ):cCGC			:= SM0->M0_CGC

			EndIf

		ElseIf AllTrim( ::oEmpresaFiltro:cCodEmpresa ) != "" .And. ;
				AllTrim( ::oEmpresaFiltro:cCodFilial  ) == ""

			If AllTrim( ::oEmpresaFiltro:cCodEmpresa ) == AllTrim( SM0->M0_CODIGO )

				aAdd( ::oListEmpresas, WsClassNew( "oEmpresa" ) )
				aTail( ::oListEmpresas ):cCodEmpresa	:= SM0->M0_CODIGO
				aTail( ::oListEmpresas ):cRazaoSocial	:= SM0->M0_NOME
				aTail( ::oListEmpresas ):cCodFilial		:= SM0->M0_CODFIL
				aTail( ::oListEmpresas ):cNomeFilial	:= SM0->M0_FILIAL
				aTail( ::oListEmpresas ):cCGC			:= SM0->M0_CGC

			EndIf

		Else

			If AllTrim( ::oEmpresaFiltro:cCodEmpresa ) == AllTrim( SM0->M0_CODIGO ) .And. ;
					AllTrim( ::oEmpresaFiltro:cCodFilial  ) == AllTrim( SM0->M0_CODFIL )

				aAdd( ::oListEmpresas, WsClassNew( "oEmpresa" ) )
				aTail( ::oListEmpresas ):cCodEmpresa	:= SM0->M0_CODIGO
				aTail( ::oListEmpresas ):cRazaoSocial	:= SM0->M0_NOME
				aTail( ::oListEmpresas ):cCodFilial		:= SM0->M0_CODFIL
				aTail( ::oListEmpresas ):cNomeFilial	:= SM0->M0_FILIAL
				aTail( ::oListEmpresas ):cCGC			:= SM0->M0_CGC

			EndIf

		EndIf

		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo
	RestArea( aAreaSM0 )

	If Len( ::oListEmpresas ) == 0

		aAdd( ::oListEmpresas, WsClassNew( "oEmpresa" ) )
		aTail( ::oListEmpresas ):cCodEmpresa	:= ""
		aTail( ::oListEmpresas ):cRazaoSocial	:= ""
		aTail( ::oListEmpresas ):cCodFilial		:= ""
		aTail( ::oListEmpresas ):cNomeFilial	:= ""
		aTail( ::oListEmpresas ):cCGC			:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE EMPRESAS ________________________________" )

Return lSucesso


WSMethod GetCabecalhoTabelasPreco WSReceive oCabecTabPrecoFiltro WSSend oListCabTabPreco WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE CABEÇALHO DE TABELA DE PRECOS ________________________________" )


	cQuery := "	 SELECT DA0_FILIAL , "
	cQuery += "			DA0_CODTAB , "
	cQuery += "			DA0_DESCRI , "
	cQuery += "			DA0_DATDE  , "
	cQuery += "			DA0_HORADE , "
	cQuery += "			DA0_DATATE , "
	cQuery += "			DA0_HORATE , "
	cQuery += "			DA0_ATIVO  , "
	cQuery += "			DA0_TPHORA , "
	cQuery += "			DA0_CONDPG   "
	cQuery += "	   FROM " + FRetSQLName( "DA0", ::oCabecTabPrecoFiltro:cCodEmpresa ) //RetSQLName( "DA0" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	lFilCompartilhada := ( FRetCompartilhamento( ::oCabecTabPrecoFiltro:cCodEmpresa, "DA0" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oCabecTabPrecoFiltro:cCodFilial ) != ""
			cQuery += "	    AND DA0_FILIAL = '" + ::oCabecTabPrecoFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oCabecTabPrecoFiltro:cCodTabela ) != ""
		cQuery += "	    AND DA0_CODTAB = '" + ::oCabecTabPrecoFiltro:cCodTabela + "' "
	EndIf
	If AllTrim( ::oCabecTabPrecoFiltro:cAtivo ) != ""
		cQuery += "	    AND DA0_ATIVO = '" + ::oCabecTabPrecoFiltro:cAtivo + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListCabTabPreco := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListCabTabPreco, WsClassNew( "oCabecalhoTabelaPreco" ) )
			aTail( ::oListCabTabPreco ):cCodFilial	:= ( cAliasQry )->DA0_FILIAL
			aTail( ::oListCabTabPreco ):cCodTabela	:= ( cAliasQry )->DA0_CODTAB
			aTail( ::oListCabTabPreco ):cDescTabela	:= ( cAliasQry )->DA0_DESCRI
			aTail( ::oListCabTabPreco ):cDataInicio	:= ( cAliasQry )->DA0_DATDE
			aTail( ::oListCabTabPreco ):cHoraInicio	:= ( cAliasQry )->DA0_HORADE
			aTail( ::oListCabTabPreco ):cDataFinal	:= ( cAliasQry )->DA0_DATATE
			aTail( ::oListCabTabPreco ):cHoraFinal	:= ( cAliasQry )->DA0_HORATE
			aTail( ::oListCabTabPreco ):cAtiva 		:= ( cAliasQry )->DA0_ATIVO
			aTail( ::oListCabTabPreco ):cTipoHorario:= ( cAliasQry )->DA0_TPHORA
			aTail( ::oListCabTabPreco ):cCondPagto 	:= ( cAliasQry )->DA0_CONDPG

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )

	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListCabTabPreco ) == 0

		aAdd( ::oListCabTabPreco, WsClassNew( "oCabecalhoTabelaPreco" ) )
		aTail( ::oListCabTabPreco ):cCodFilial		:= ""
		aTail( ::oListCabTabPreco ):cCodTabela		:= ""
		aTail( ::oListCabTabPreco ):cDescTabela		:= ""
		aTail( ::oListCabTabPreco ):cDataInicio		:= ""
		aTail( ::oListCabTabPreco ):cHoraInicio		:= ""
		aTail( ::oListCabTabPreco ):cDataFinal		:= ""
		aTail( ::oListCabTabPreco ):cHoraFinal		:= ""
		aTail( ::oListCabTabPreco ):cAtiva 			:= ""
		aTail( ::oListCabTabPreco ):cTipoHorario	:= ""
		aTail( ::oListCabTabPreco ):cCondPagto 		:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE CABEÇALHO DE TABELA DE PRECOS ________________________________" )

Return lSucesso


WSMethod GetItensTabelasPreco WSReceive oItemTabPrecoFiltro WSSend oListItensTabPreco WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE ITENS DA TABELA DE PRECOS ________________________________" )


	cQuery := "	 SELECT DA1_FILIAL	, "
	cQuery += "			DA1_TIPPRE	, "
	cQuery += "			DA1_ITEM	, "
	cQuery += "			DA1_CODTAB	, "
	cQuery += "			DA1_CODPRO	, "
	cQuery += "			DA1_GRUPO	, "
	cQuery += "			DA1_PRCVEN	, "
	cQuery += "			DA1_VLRDES	, "
	cQuery += "			DA1_PERDES	, "
	cQuery += "			DA1_ATIVO	, "
	cQuery += "			DA1_FRETE	, "
	cQuery += "			DA1_ESTADO	, "
	cQuery += "			DA1_TPOPER	, "
	cQuery += "			DA1_PRCMAX	  "
	cQuery += "	   FROM " + FRetSQLName( "DA1", ::oItemTabPrecoFiltro:cCodEmpresa ) //RetSQLName( "DA1" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "


	lFilCompartilhada := ( FRetCompartilhamento( ::oItemTabPrecoFiltro:cCodEmpresa, "DA1" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oItemTabPrecoFiltro:cCodFilial ) != ""
			cQuery += "	    AND DA1_FILIAL = '" + ::oItemTabPrecoFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oItemTabPrecoFiltro:cCodTabela ) != ""
		cQuery += "	    AND DA1_CODTAB = '" + ::oItemTabPrecoFiltro:cCodTabela + "' "
	EndIf
	If AllTrim( ::oItemTabPrecoFiltro:cCodProduto ) != ""
		cQuery += "	    AND DA1_CODPRO = '" + ::oItemTabPrecoFiltro:cCodProduto + "' "
	EndIf
	If AllTrim( ::oItemTabPrecoFiltro:cCodDepartamento ) != ""
		cQuery += "	    AND DA1_GRUPO = '" + ::oItemTabPrecoFiltro:cCodDepartamento + "' "
	EndIf
	If AllTrim( ::oItemTabPrecoFiltro:cAtivo ) != ""
		cQuery += "	    AND DA1_ATIVO = '" + ::oItemTabPrecoFiltro:cCodTabela + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListItensTabPreco := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListItensTabPreco, WsClassNew( "oItensTabelaPreco" ) )
			aTail( ::oListItensTabPreco ):cCodFilial		:= ( cAliasQry )->DA1_FILIAL
			aTail( ::oListItensTabPreco ):cTipoPreco		:= ( cAliasQry )->DA1_TIPPRE
			aTail( ::oListItensTabPreco ):cItem				:= ( cAliasQry )->DA1_ITEM
			aTail( ::oListItensTabPreco ):cCodTabela		:= ( cAliasQry )->DA1_CODTAB
			aTail( ::oListItensTabPreco ):cCodProduto		:= ( cAliasQry )->DA1_CODPRO
			aTail( ::oListItensTabPreco ):cCodDepartamento	:= ( cAliasQry )->DA1_GRUPO
			aTail( ::oListItensTabPreco ):nPrecoVenda		:= ( cAliasQry )->DA1_PRCVEN
			aTail( ::oListItensTabPreco ):nValorDesconto	:= ( cAliasQry )->DA1_VLRDES
			aTail( ::oListItensTabPreco ):nPercDesconto		:= ( cAliasQry )->DA1_PERDES
			aTail( ::oListItensTabPreco ):cAtivo			:= ( cAliasQry )->DA1_ATIVO
			aTail( ::oListItensTabPreco ):nFrete			:= ( cAliasQry )->DA1_FRETE
			aTail( ::oListItensTabPreco ):cEstado			:= ( cAliasQry )->DA1_ESTADO
			aTail( ::oListItensTabPreco ):cTipoOperacao		:= ( cAliasQry )->DA1_TPOPER
			aTail( ::oListItensTabPreco ):nPrecoMaximo		:= ( cAliasQry )->DA1_PRCMAX

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )

	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListItensTabPreco ) == 0

		aAdd( ::oListItensTabPreco, WsClassNew( "oItensTabelaPreco" ) )
		aTail( ::oListItensTabPreco ):cCodFilial		:= ""
		aTail( ::oListItensTabPreco ):cTipoPreco		:= ""
		aTail( ::oListItensTabPreco ):cItem				:= ""
		aTail( ::oListItensTabPreco ):cCodTabela		:= ""
		aTail( ::oListItensTabPreco ):cCodProduto		:= ""
		aTail( ::oListItensTabPreco ):cCodDepartamento	:= ""
		aTail( ::oListItensTabPreco ):nPrecoVenda		:= 0
		aTail( ::oListItensTabPreco ):nValorDesconto	:= 0
		aTail( ::oListItensTabPreco ):nPercDesconto		:= 0
		aTail( ::oListItensTabPreco ):cAtivo			:= ""
		aTail( ::oListItensTabPreco ):nFrete			:= 0
		aTail( ::oListItensTabPreco ):cEstado			:= ""
		aTail( ::oListItensTabPreco ):cTipoOperacao		:= ""
		aTail( ::oListItensTabPreco ):nPrecoMaximo		:= 0

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE ITENS DA TABELA DE PRECOS ________________________________" )

Return lSucesso

WSMethod GetCondicoesPagamento WSReceive oCondPagtoFiltro WSSend oListCondPagamento WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE CONDICOES DE PAGAMENTO ________________________________" )


	cQuery := "	 SELECT E4_CODIGO  	, "
	cQuery += "	   		E4_TIPO  	, "
	cQuery += "	   		E4_COND  	, "
	cQuery += "	   		E4_DESCRI  	, "
	cQuery += "	   		E4_FORMA  	, "
	cQuery += "			E4_ACRSFIN	, "
	cQuery += "	   		E4_MSBLQL     "
	cQuery += "	   FROM " + FRetSQLName( "SE4", ::oCondPagtoFiltro:cCodEmpresa ) //RetSQLName( "SE4" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	//cQuery += "		AND E4_XFLUIG  = 'S' "

	lFilCompartilhada := ( FRetCompartilhamento( ::oCondPagtoFiltro:cCodEmpresa, "SE4" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oCondPagtoFiltro:cCodFilial ) != ""
			cQuery += "	    AND E4_FILIAL = '" + ::oCondPagtoFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oCondPagtoFiltro:cCondPagamento ) != ""
		cQuery += "	    AND E4_CODIGO = '" + ::oCondPagtoFiltro:cCondPagamento + "' "
	EndIf
	If AllTrim( ::oCondPagtoFiltro:cDescricao ) != ""
		cQuery += "	    AND E4_DESCRI = '" + ::oCondPagtoFiltro:cDescricao + "' "
	EndIf
	If AllTrim( ::oCondPagtoFiltro:cStatus ) != ""
		cQuery += "	    AND E4_MSBLQL = '" + ::oCondPagtoFiltro:cStatus + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListCondPagamento := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListCondPagamento, WsClassNew( "oCondicaoPagamento" ) )
			aTail( ::oListCondPagamento ):cCodigo			:= ( cAliasQry )->E4_CODIGO
			aTail( ::oListCondPagamento ):cTipo				:= ( cAliasQry )->E4_TIPO
			aTail( ::oListCondPagamento ):cCondPagamento	:= ( cAliasQry )->E4_COND
			aTail( ::oListCondPagamento ):cDescricao		:= ( cAliasQry )->E4_DESCRI
			aTail( ::oListCondPagamento ):cFormaPagto		:= ( cAliasQry )->E4_FORMA
			aTail( ::oListCondPagamento ):nTxAcrescimo		:= ( cAliasQry )->E4_ACRSFIN
			aTail( ::oListCondPagamento ):cStatus			:= ( cAliasQry )->E4_MSBLQL

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )

	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListCondPagamento ) == 0

		aAdd( ::oListCondPagamento, WsClassNew( "oCondicaoPagamento" ) )
		aTail( ::oListCondPagamento ):cCodigo			:= ""
		aTail( ::oListCondPagamento ):cTipo				:= ""
		aTail( ::oListCondPagamento ):cCondPagamento	:= ""
		aTail( ::oListCondPagamento ):cDescricao		:= ""
		aTail( ::oListCondPagamento ):cFormaPagto		:= ""
		aTail( ::oListCondPagamento ):nTxAcrescimo		:= 0
		aTail( ::oListCondPagamento ):cStatus			:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE CONDIÇÕES DE PAGAMENTO  ________________________________" )

Return lSucesso

WSMethod GetTabelasGenericas WSReceive oTabGenericaFiltro WSSend oListTabGenerica WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE TABELAS GENERICAS ________________________________" )

	cQuery := "	 SELECT X5_FILIAL	, "
	cQuery += "	   		X5_TABELA	, "
	cQuery += "	   		X5_CHAVE	, "
	cQuery += "	   		X5_DESCRI	, "
	cQuery += "	   		X5_DESCSPA	, "
	cQuery += "	   		X5_DESCENG	  "
	cQuery += "	   FROM " + FRetSQLName( "SX5", ::oTabGenericaFiltro:cCodEmpresa ) //RetSQLName( "SX5" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	If AllTrim( ::oTabGenericaFiltro:cCodFilial ) != ""
		cQuery += "	    AND X5_FILIAL = '" + ::oTabGenericaFiltro:cCodFilial + "' "
	EndIf
	If AllTrim( ::oTabGenericaFiltro:cCodTabela ) != ""
		cQuery += "	    AND X5_TABELA = '" + ::oTabGenericaFiltro:cCodTabela + "' "
	EndIf
	If AllTrim( ::oTabGenericaFiltro:cChave ) != ""
		cQuery += "	    AND X5_CHAVE = '" + ::oTabGenericaFiltro:cChave + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListTabGenerica := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListTabGenerica, WsClassNew( "oTabelaGenerica" ) )
			aTail( ::oListTabGenerica ):cCodFilial		:= ( cAliasQry )->X5_FILIAL
			aTail( ::oListTabGenerica ):cCodTabela		:= ( cAliasQry )->X5_TABELA
			aTail( ::oListTabGenerica ):cChave			:= ( cAliasQry )->X5_CHAVE
			aTail( ::oListTabGenerica ):cDescPortugues	:= ( cAliasQry )->X5_DESCRI
			aTail( ::oListTabGenerica ):cDescEspanhol	:= ( cAliasQry )->X5_DESCSPA
			aTail( ::oListTabGenerica ):cDescIngles		:= ( cAliasQry )->X5_DESCENG

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )

	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListTabGenerica ) == 0

		aAdd( ::oListTabGenerica, WsClassNew( "oTabelaGenerica" ) )
		aTail( ::oListTabGenerica ):cCodFilial		:= ""
		aTail( ::oListTabGenerica ):cCodTabela		:= ""
		aTail( ::oListTabGenerica ):cChave			:= ""
		aTail( ::oListTabGenerica ):cDescPortugues	:= ""
		aTail( ::oListTabGenerica ):cDescEspanhol	:= ""
		aTail( ::oListTabGenerica ):cDescIngles		:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE TABELAS GENERICAS  ________________________________" )

Return lSucesso


WSMethod GetMunicipios WSReceive oMunicipioFiltro WSSend oListMunicipio WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE MUNICIPIOS ________________________________" )


	cQuery := "	 SELECT CC2_FILIAL	, "
	cQuery += "			CC2_EST		, "
	cQuery += "			CC2_CODMUN	, "
	cQuery += "			CC2_MUN		  "
	cQuery += "	   FROM " + FRetSQLName( "CC2", ::oMunicipioFiltro:cCodEmpresa ) //RetSQLName( "CC2" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "

	lFilCompartilhada := ( FRetCompartilhamento( ::oMunicipioFiltro:cCodEmpresa, "CC2" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oMunicipioFiltro:cCodFilial ) != ""
			cQuery += "	    AND CC2_FILIAL 	= '" + ::oMunicipioFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oMunicipioFiltro:cEstado ) != ""
		cQuery += "	    AND CC2_EST 	= '" + ::oMunicipioFiltro:cEstado + "' "
	EndIf
	If AllTrim( ::oMunicipioFiltro:cCodMunicipio ) != ""
		cQuery += "	    AND CC2_CODMUN 	= '" + ::oMunicipioFiltro:cCodMunicipio + "' "
	EndIf
	If AllTrim( ::oMunicipioFiltro:cDescMunicipio ) != ""
		cQuery += "	    AND CC2_MUN    	= '" + ::oMunicipioFiltro:cDescMunicipio + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListMunicipio := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListMunicipio, WsClassNew( "oMunicipio" ) )
			aTail( ::oListMunicipio ):cCodFilial		:= ( cAliasQry )->CC2_FILIAL
			aTail( ::oListMunicipio ):cEstado			:= ( cAliasQry )->CC2_EST
			aTail( ::oListMunicipio ):cCodMunicipio		:= ( cAliasQry )->CC2_CODMUN
			aTail( ::oListMunicipio ):cDescMunicipio	:= ( cAliasQry )->CC2_MUN

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )

	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListMunicipio ) == 0

		aAdd( ::oListMunicipio, WsClassNew( "oMunicipio" ) )
		aTail( ::oListMunicipio ):cCodFilial		:= ""
		aTail( ::oListMunicipio ):cEstado			:= ""
		aTail( ::oListMunicipio ):cCodMunicipio		:= ""
		aTail( ::oListMunicipio ):cDescMunicipio	:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE MUNICIPIOS ________________________________" )

Return lSucesso

WSMethod GetDepartamentos WSReceive oDepartamentoFiltro WSSend oListDepartamento WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE DEPARTAMENTOS ________________________________" )

	cQuery := "	 SELECT BM_FILIAL	, "
	cQuery += "			BM_GRUPO	, "
	cQuery += "			BM_DESC		  "
	cQuery += "	   FROM " + FRetSQLName( "SBM", ::oDepartamentoFiltro:cCodEmpresa ) //RetSQLName( "SBM" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	lFilCompartilhada := ( FRetCompartilhamento( ::oDepartamentoFiltro:cCodEmpresa, "SBM" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oDepartamentoFiltro:cCodFilial ) != ""
			cQuery += "	    AND BM_FILIAL 	= '" + ::oDepartamentoFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oDepartamentoFiltro:cCodDepartamento ) != ""
		cQuery += "	    AND BM_GRUPO 	= '" + ::oDepartamentoFiltro:cCodDepartamento + "' "
	EndIf
	If AllTrim( ::oDepartamentoFiltro:cDescDepartamento ) != ""
		cQuery += "	    AND BM_DESC 	= '" + ::oDepartamentoFiltro:cDescDepartamento + "' "
	EndIf
	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListDepartamento := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListDepartamento, WsClassNew( "oDepartamento" ) )
			aTail( ::oListDepartamento ):cCodFilial			:= ( cAliasQry )->BM_FILIAL
			aTail( ::oListDepartamento ):cCodDepartamento	:= ( cAliasQry )->BM_GRUPO
			aTail( ::oListDepartamento ):cDescDepartamento	:= ( cAliasQry )->BM_DESC

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListDepartamento ) == 0

		aAdd( ::oListDepartamento, WsClassNew( "oDepartamento" ) )
		aTail( ::oListDepartamento ):cCodFilial			:= ""
		aTail( ::oListDepartamento ):cCodDepartamento	:= ""
		aTail( ::oListDepartamento ):cDescDepartamento	:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE DEPARTAMENTOS ________________________________" )

Return lSucesso

WSMethod GetCategorias WSReceive oCategoriaFiltro WSSend oListCategoria WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE CATEGORIAS ________________________________" )

	cQuery := "	 SELECT DISTINCT 	  "
	CQuery += "			Z1_FILIAL	, "
	cQuery += "			Z1_CATEGOR	, "
	cQuery += "			Z1_DESC		, "
	cQuery += "			Z1_GRUPO	, "
	cQuery += "			BM_DESC AS Z1_DESCGRU	"
	cQuery += "	   FROM " + FRetSQLName( "SZ1", ::oCategoriaFiltro:cCodEmpresa ) + " SZ1, " // RetSQLName( "SZ1" ) + " SZ1, "
	cQuery += "	        " + FRetSQLName( "SBM", ::oCategoriaFiltro:cCodEmpresa ) + " SBM  " // RetSQLName( "SBM" ) + " SBM  "
	cQuery += "	  WHERE SZ1.D_E_L_E_T_ = ' ' "
	cQuery += "	    AND SBM.D_E_L_E_T_ = ' ' "
	cQuery += "	    AND SBM.BM_GRUPO   = SZ1.Z1_GRUPO "
	lFilCompartilhada := ( FRetCompartilhamento( ::oCategoriaFiltro:cCodEmpresa, "SZ1" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oCategoriaFiltro:cCodFilial ) != ""
			cQuery += "	    AND Z1_FILIAL 	= '" + ::oCategoriaFiltro:cCodFilial + "' "
		EndIf
	EndIf
	lFilCompartilhada := ( FRetCompartilhamento( ::oCategoriaFiltro:cCodEmpresa, "SBM" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oCategoriaFiltro:cCodFilial ) != ""
			cQuery += "	    AND BM_FILIAL 	= '" + ::oCategoriaFiltro:cCodFilial + "' "
		EndIf
	EndIf

	If AllTrim( ::oCategoriaFiltro:cCodCategoria ) != ""
		cQuery += "	    AND Z1_CATEGOR 	= '" + ::oCategoriaFiltro:cCodCategoria + "' "
	EndIf
	If AllTrim( ::oCategoriaFiltro:cCodDepartamento ) != ""
		cQuery += "	    AND Z1_GRUPO 	= '" + ::oCategoriaFiltro:cCodDepartamento + "' "
	EndIf

	If AllTrim( ::oCategoriaFiltro:cDescCategoria ) != ""
		cQuery += "	    AND Z1_DESC 	= '" + ::oCategoriaFiltro:cDescCategoria + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListCategoria := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListCategoria, WsClassNew( "oCategoria" ) )
			aTail( ::oListCategoria ):cCodFilial		:= ( cAliasQry )->Z1_FILIAL
			aTail( ::oListCategoria ):cCodCategoria		:= ( cAliasQry )->Z1_CATEGOR
			aTail( ::oListCategoria ):cDescCategoria	:= ( cAliasQry )->Z1_DESC
			aTail( ::oListCategoria ):cCodDepartamento	:= ( cAliasQry )->Z1_GRUPO
			aTail( ::oListCategoria ):cDescDepartamento	:= ( cAliasQry )->Z1_DESCGRU

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListCategoria ) == 0

		aAdd( ::oListCategoria, WsClassNew( "oCategoria" ) )
		aTail( ::oListCategoria ):cCodFilial		:= ""
		aTail( ::oListCategoria ):cCodCategoria		:= ""
		aTail( ::oListCategoria ):cDescCategoria	:= ""
		aTail( ::oListCategoria ):cCodDepartamento	:= ""
		aTail( ::oListCategoria ):cDescDepartamento	:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE CATEGORIAS ________________________________" )

Return lSucesso

WSMethod GetLinhas WSReceive oLinhaFiltro WSSend oListLinha WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LINHAS ________________________________" )

	cQuery := "	 SELECT DISTINCT 	  "
	cQuery += "			Z2_FILIAL	, "
	cQuery += "			Z2_LINHA	, "
	cQuery += "			Z2_DESC		, "
	cQuery += "			Z2_CATEGOR	, "
	cQuery += "			Z1_DESC	AS Z2_DESCCAT	  "
	cQuery += "	   FROM " + FRetSQLName( "SZ1", ::oLinhaFiltro:cCodEmpresa ) + " SZ1, " //RetSQLName( "SZ1" ) + " SZ1, "
	cQuery += "	        " + FRetSQLName( "SZ2", ::oLinhaFiltro:cCodEmpresa ) + " SZ2  " //RetSQLName( "SZ2" ) + " SZ2  "
	cQuery += "	  WHERE SZ1.D_E_L_E_T_ = ' ' "
	cQuery += "	    AND SZ2.D_E_L_E_T_ = ' ' "
	cQuery += "	    AND SZ1.Z1_CATEGOR = SZ2.Z2_CATEGOR "

	lFilCompartilhada := ( FRetCompartilhamento( ::oLinhaFiltro:cCodEmpresa, "SZ2" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oLinhaFiltro:cCodFilial ) != ""
			cQuery += "	    AND Z2_FILIAL 	= '" + ::oLinhaFiltro:cCodFilial + "' "
		EndIf
	EndIf
	lFilCompartilhada := ( FRetCompartilhamento( ::oLinhaFiltro:cCodEmpresa, "SZ1" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oLinhaFiltro:cCodFilial ) != ""
			cQuery += "	    AND Z1_FILIAL 	= '" + ::oLinhaFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oLinhaFiltro:cCodLinha ) != ""
		cQuery += "	    AND Z2_LINHA 	= '" + ::oLinhaFiltro:cCodLinha + "' "
	EndIf
	If AllTrim( ::oLinhaFiltro:cCodCategoria ) != ""
		cQuery += "	    AND Z2_CATEGOR 	= '" + ::oLinhaFiltro:cCodCategoria + "' "
	EndIf
	If AllTrim( ::oLinhaFiltro:cDescLinha ) != ""
		cQuery += "	    AND Z2_DESC 	= '" + ::oLinhaFiltro:cDescLinha + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListLinha := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListLinha, WsClassNew( "oLinha" ) )
			aTail( ::oListLinha ):cCodFilial		:= ( cAliasQry )->Z2_FILIAL
			aTail( ::oListLinha ):cCodLinha			:= ( cAliasQry )->Z2_LINHA
			aTail( ::oListLinha ):cDescLinha		:= ( cAliasQry )->Z2_DESC
			aTail( ::oListLinha ):cCodCategoria		:= ( cAliasQry )->Z2_CATEGOR
			aTail( ::oListLinha ):cDesCategoria		:= ( cAliasQry )->Z2_DESCCAT

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListLinha ) == 0

		aAdd( ::oListLinha, WsClassNew( "oLinha" ) )
		aTail( ::oListLinha ):cCodFilial		:= ""
		aTail( ::oListLinha ):cCodLinha			:= ""
		aTail( ::oListLinha ):cDescLinha		:= ""
		aTail( ::oListLinha ):cCodCategoria		:= ""
		aTail( ::oListLinha ):cDesCategoria		:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE LINHAS ________________________________" )

Return lSucesso


WSMethod GetTESs WSReceive oTESFiltro WSSend oListTES WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE TES ________________________________" )

	cQuery := "	 SELECT F4_FILIAL	, "
	cQuery += "			F4_CODIGO	, "
	cQuery += "			F4_TIPO		, "
	cQuery += "			F4_CF		, "
	cQuery += "			F4_TEXTO	  "
	cQuery += "	   FROM " + FRetSQLName( "SF4", ::oTESFiltro:cCodEmpresa ) //RetSQLName( "SF4" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	lFilCompartilhada := ( FRetCompartilhamento( ::oTESFiltro:cCodEmpresa, "SF4" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oTESFiltro:cCodFilial ) != ""
			cQuery += "	    AND F4_FILIAL 	= '" + ::oTESFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oTESFiltro:cCodTES ) != ""
		cQuery += "	    AND F4_CODIGO 	= '" + ::oTESFiltro:cCodTES + "' "
	EndIf
	If AllTrim( ::oTESFiltro:cCFOP ) != ""
		cQuery += "	    AND F4_CF 		= '" + ::oTESFiltro:cCFOP + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListTES := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListTES, WsClassNew( "oTES" ) )
			aTail( ::oListTES ):cCodFilial	:= ( cAliasQry )->F4_FILIAL
			aTail( ::oListTES ):cCodigoTES	:= ( cAliasQry )->F4_CODIGO
			aTail( ::oListTES ):cTipo		:= ( cAliasQry )->F4_TIPO
			aTail( ::oListTES ):cCFOP		:= ( cAliasQry )->F4_CF
			aTail( ::oListTES ):cDescricao	:= ( cAliasQry )->F4_TEXTO

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )

	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListTES ) == 0

		aAdd( ::oListTES, WsClassNew( "oTES" ) )
		aTail( ::oListTES ):cCodFilial	:= ""
		aTail( ::oListTES ):cCodigoTES	:= ""
		aTail( ::oListTES ):cTipo		:= ""
		aTail( ::oListTES ):cCFOP		:= ""
		aTail( ::oListTES ):cDescricao	:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE TES ________________________________" )

Return lSucesso


WSMethod GetNaturezas WSReceive oNaturezaFiltro WSSend oListNatureza WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE NATUREZAS ________________________________" )

	cQuery := "	 SELECT ED_FILIAL	, "
	cQuery += "			ED_CODIGO	, "
	cQuery += "			ED_DESCRIC	  "
	cQuery += "	   FROM " + FRetSQLName( "SED", ::oNaturezaFiltro:cCodEmpresa ) //RetSQLName( "SED" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "

	lFilCompartilhada := ( FRetCompartilhamento( ::oNaturezaFiltro:cCodEmpresa, "SED" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oNaturezaFiltro:cCodFilial ) != ""
			cQuery += "	    AND ED_FILIAL 	= '" + ::oNaturezaFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oNaturezaFiltro:cCodNatureza ) != ""
		cQuery += "	    AND ED_CODIGO 	= '" + ::oNaturezaFiltro:cCodNatureza + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListNatureza := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListNatureza, WsClassNew( "oNatureza" ) )
			aTail( ::oListNatureza ):cCodFilial		:= ( cAliasQry )->ED_FILIAL
			aTail( ::oListNatureza ):cCodNatureza	:= ( cAliasQry )->ED_CODIGO
			aTail( ::oListNatureza ):cDescNatureza	:= ( cAliasQry )->ED_DESCRIC

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf


	If Len( ::oListNatureza ) == 0

		aAdd( ::oListNatureza, WsClassNew( "oNatureza" ) )
		aTail( ::oListNatureza ):cCodFilial		:= ""
		aTail( ::oListNatureza ):cCodNatureza	:= ""
		aTail( ::oListNatureza ):cDescNatureza	:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE NATUREZAS ________________________________" )

Return lSucesso

WSMethod GetBancos WSReceive oBancoFiltro WSSend oListBanco WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE BANCOS ________________________________" )

	cQuery := "	 SELECT A6_FILIAL	, "
	cQuery += "			A6_COD		, "
	cQuery += "			A6_AGENCIA	, "
	cQuery += "			A6_NUMCON	, "
	cQuery += "			A6_NOME	  	  "
	cQuery += "	   FROM " + FRetSQLName( "SA6", ::oBancoFiltro:cCodEmpresa ) //RetSQLName( "SA6" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	lFilCompartilhada := ( FRetCompartilhamento( ::oBancoFiltro:cCodEmpresa, "SA6" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oBancoFiltro:cCodFilial ) != ""
			cQuery += "	    AND A6_FILIAL 	= '" + ::oBancoFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oBancoFiltro:cBanco ) != ""
		cQuery += "	    AND A6_COD 		= '" + ::oBancoFiltro:cBanco + "' "
	EndIf
	If AllTrim( ::oBancoFiltro:cAgencia ) != ""
		cQuery += "	    AND A6_AGENCIA 	= '" + ::oBancoFiltro:cAgencia + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListBanco := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListBanco, WsClassNew( "oBanco" ) )
			aTail( ::oListBanco ):cCodFilial	:= ( cAliasQry )->A6_FILIAL
			aTail( ::oListBanco ):cBanco		:= ( cAliasQry )->A6_COD
			aTail( ::oListBanco ):cAgencia		:= ( cAliasQry )->A6_AGENCIA
			aTail( ::oListBanco ):cConta		:= ( cAliasQry )->A6_NUMCON
			aTail( ::oListBanco ):cNome			:= ( cAliasQry )->A6_NOME

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListBanco ) == 0

		aAdd( ::oListBanco, WsClassNew( "oBanco" ) )
		aTail( ::oListBanco ):cCodFilial	:= ""
		aTail( ::oListBanco ):cBanco		:= ""
		aTail( ::oListBanco ):cAgencia		:= ""
		aTail( ::oListBanco ):cConta		:= ""
		aTail( ::oListBanco ):cNome			:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE BANCOS ________________________________" )

Return lSucesso

WSMethod GetVendedores WSReceive oVendedorFiltro WSSend oListVendedor WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE VENDEDORES ________________________________" )

	cQuery := "	 SELECT A3_FILIAL	, "
	cQuery += "			A3_COD		, "
	cQuery += "			A3_NOME		, "
	cQuery += "			A3_TIPOFJ	, "
	cQuery += "			A3_CGC		, "
	cQuery += "			A3_NREDUZ	, "
	cQuery += "			A3_TIPO		, "
	cQuery += "			A3_COMIS	, "
	cQuery += "			A3_CARGO	, "
	cQuery += "			'' A3_SUPER	, "
	cQuery += "			'' A3_GEREN	  "
	cQuery += "	   FROM " + FRetSQLName( "SA3", ::oVendedorFiltro:cCodEmpresa ) //RetSQLName( "SA3" )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	lFilCompartilhada := ( FRetCompartilhamento( ::oVendedorFiltro:cCodEmpresa, "SA3" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oVendedorFiltro:cCodFilial ) != ""
			cQuery += "	    AND A3_FILIAL 	= '" + ::oVendedorFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oVendedorFiltro:cCodVendedor ) != ""
		cQuery += "	    AND A3_COD 		= '" + ::oVendedorFiltro:cCodVendedor + "' "
	EndIf
	If AllTrim( ::oVendedorFiltro:cSupervisor ) != ""
		cQuery += "	    AND A3_SUPER 	= '" + ::oVendedorFiltro:cSupervisor + "' "
	EndIf
	If AllTrim( ::oVendedorFiltro:cGerente ) != ""
		cQuery += "	    AND A3_GEREN 	= '" + ::oVendedorFiltro:cGerente    + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListVendedor := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListVendedor, WsClassNew( "oVendedor" ) )
			aTail( ::oListVendedor ):cCodFilial		:= ( cAliasQry )->A3_FILIAL
			aTail( ::oListVendedor ):cCodVendedor	:= ( cAliasQry )->A3_COD
			aTail( ::oListVendedor ):cNomeVendedor	:= ( cAliasQry )->A3_NOME
			aTail( ::oListVendedor ):cTipoPessoa	:= ( cAliasQry )->A3_TIPOFJ
			aTail( ::oListVendedor ):cCNPJ			:= ( cAliasQry )->A3_CGC
			aTail( ::oListVendedor ):cNomeReduzido	:= ( cAliasQry )->A3_NREDUZ
			aTail( ::oListVendedor ):cTipoVendedor	:= ( cAliasQry )->A3_TIPO
			aTail( ::oListVendedor ):nComissao		:= ( cAliasQry )->A3_COMIS
			aTail( ::oListVendedor ):cCargo			:= ( cAliasQry )->A3_CARGO
			aTail( ::oListVendedor ):cSupervisor	:= ( cAliasQry )->A3_SUPER
			aTail( ::oListVendedor ):cGerente		:= ( cAliasQry )->A3_GEREN

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListVendedor ) == 0

		aAdd( ::oListVendedor, WsClassNew( "oVendedor" ) )
		aTail( ::oListVendedor ):cCodFilial		:= ""
		aTail( ::oListVendedor ):cCodVendedor	:= ""
		aTail( ::oListVendedor ):cNomeVendedor	:= ""
		aTail( ::oListVendedor ):cTipoPessoa	:= ""
		aTail( ::oListVendedor ):cCNPJ			:= ""
		aTail( ::oListVendedor ):cNomeReduzido	:= ""
		aTail( ::oListVendedor ):cTipoVendedor	:= ""
		aTail( ::oListVendedor ):nComissao		:= 0
		aTail( ::oListVendedor ):cCargo			:= ""
		aTail( ::oListVendedor ):cSupervisor	:= ""
		aTail( ::oListVendedor ):cGerente		:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE VENDEDORES ________________________________" )

Return lSucesso

WSMethod GetTransportadoras WSReceive oTransportadoraFiltro WSSend oListTransportadora WSService oUniWSCadastros

	Local cQuery 			:= ""
	Local cAliasQry			:= GetNextAlias()
	Local lSucesso 			:= .T.
	Local lFilCompartilhada := .F.

	ConOut( "________________________________ INICIO DA SOLICITACAO DE TRANSPORTADORAS ________________________________" )

	cQuery := "	 SELECT A4_FILIAL	, "
	cQuery += "			A4_COD		, "
	cQuery += "			A4_NOME		, "
	cQuery += "			A4_CGC		, "
	cQuery += "			A4_NREDUZ	, "
	cQuery += "			A4_EST		  "
	cQuery += "	   FROM " + FRetSQLName( "SA4", ::oTransportadoraFiltro:cCodEmpresa )
	cQuery += "	  WHERE D_E_L_E_T_ = ' ' "
	lFilCompartilhada := ( FRetCompartilhamento( ::oTransportadoraFiltro:cCodEmpresa, "SA4" ) == "C"  )
	If !lFilCompartilhada
		If AllTrim( ::oTransportadoraFiltro:cCodFilial ) != ""
			cQuery += "	    AND A4_FILIAL 	= '" + ::oTransportadoraFiltro:cCodFilial + "' "
		EndIf
	EndIf
	If AllTrim( ::oTransportadoraFiltro:cCodTransportadora ) != ""
		cQuery += "	    AND A4_COD 		= '" + ::oTransportadoraFiltro:cCodTransportadora + "' "
	EndIf
	If AllTrim( ::oTransportadoraFiltro:cUF ) != ""
		cQuery += "	    AND A4_EST 		= '" + ::oTransportadoraFiltro:cUF + "' "
	EndIf

	If Select( cAliasQry ) > 0
		( cAliasQry )->( DbCloseArea() )
	EndIf

	::oListTransportadora := {}
	If TcSQLExec( cQuery ) == 0

		TcQuery cQuery Alias ( cAliasQry ) New

		Do While !( cAliasQry )->( Eof() )

			aAdd( ::oListTransportadora, WsClassNew( "oTransportadora" ) )
			aTail( ::oListTransportadora ):cCodFilial			:= ( cAliasQry )->A4_FILIAL
			aTail( ::oListTransportadora ):cCodTransportadora	:= ( cAliasQry )->A4_COD
			aTail( ::oListTransportadora ):cNomeTransportadora	:= ( cAliasQry )->A4_NOME
			aTail( ::oListTransportadora ):cCNPJ				:= ( cAliasQry )->A4_CGC
			aTail( ::oListTransportadora ):cNomeReduzido		:= ( cAliasQry )->A4_NREDUZ
			aTail( ::oListTransportadora ):cUF					:= ( cAliasQry )->A4_EST

			DbSelectArea( cAliasQry )
			( cAliasQry )->( DbSkip() )
		EndDo
		( cAliasQry )->( DbCloseArea() )
	Else
		SetSoapFault( "Erro com a Query " + TcSQLError(), "", SOAPFAULT_RECEIVER )
	EndIf

	If Len( ::oListTransportadora ) == 0

		aAdd( ::oListTransportadora, WsClassNew( "oTransportadora" ) )
		aTail( ::oListTransportadora ):cCodFilial			:= ""
		aTail( ::oListTransportadora ):cCodTransportadora	:= ""
		aTail( ::oListTransportadora ):cNomeTransportadora	:= ""
		aTail( ::oListTransportadora ):cCNPJ				:= ""
		aTail( ::oListTransportadora ):cNomeReduzido		:= ""
		aTail( ::oListTransportadora ):cUF					:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE TRANSPORTADORAS ________________________________" )

Return lSucesso

WSMethod GetParcelas WSReceive oParcelaFiltro WSSend oListParcela WSService oUniWSCadastros

	Local nX				:= 0
	Local aRetCondicao 		:= {}
	Local lSucesso 			:= .T.

	ConOut( "________________________________ INICIO PROCESSAMENTO DAS PARCELAS ________________________________" )

	aRetCondicao := Condicao( ::oParcelaFiltro:nValorOrcamento, ::oParcelaFiltro:cCondPagamento, 0, SToD( ::oParcelaFiltro:cDataOrcamento ),,,, ::oParcelaFiltro:nValorAcrescimo )
	If Len( aRetCondicao )

		::oListParcela := {}
		For nX := 01 To Len( aRetCondicao )

			aAdd( ::oListParcela, WsClassNew( "oParcela" ) )
			aTail( ::oListParcela ):nValorParcela 	:= aRetCondicao[nX][02]
			aTail( ::oListParcela ):cDataParcela 	:= DToS( aRetCondicao[nX][01] )

		Next nX

	Else

		SetSoapFault( "Não condição de pagamaneto não retornou parcelas", "", SOAPFAULT_RECEIVER )

	EndIf

	If Len( ::oListParcela ) == 0

		aAdd( ::oListParcela, WsClassNew( "oParcela" ) )
		aTail( ::oListParcela ):nValorParcela 	:= 0
		aTail( ::oListParcela ):cDataParcela 	:= ""

	EndIf

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE PARCELAS ________________________________" )

Return lSucesso


WSMethod GetCompartilhamento WSReceive oCompartilhamentoFiltro  WSSend cRetCompartilhamento WSService oUniWSCadastros

	ConOut( "________________________________ INICIO DA SOLICITACAO DE COMPARTILHAMENTO DE TABELA ________________________________" )

	::cRetCompartilhamento := FRetCompartilhamento( ::oCompartilhamentoFiltro:cCodEmpresa, ::oCompartilhamentoFiltro:cAliasTabela )

	lSucesso := .T.

	ConOut( "________________________________ FIM DA SOLICITACAO DE COMPARTILHAMENTO DE TABELA ________________________________" )

Return lSucesso

*----------------------------------------------------------------*
Static Function FRetCompartilhamento( cParamEmpresa, cParamAlias )
	*----------------------------------------------------------------*
	Local aAreaAtu := GetArea()
	Local cRetModo 			:= ""
	Default cParamEmpresa 	:= cEmpAnt

	If Select("S_X2") = 0
		OpenSxs(,,,,cParamEmpresa,"S_X2","SX2",,.F.)
	EndIf

	DbSelectArea(S_X2)
	DbSetOrder( 01 ) //X2_CHAVE
	Seek cParamAlias
	If Found()
		cRetModo := AllTrim( S_X2->X2_MODO )
	End If
	S_X2->( DbCloseArea() )

	RestArea( aAreaSX2 )
	RestArea( aAreaAtu )

Return cRetModo

*-------------------------------------------------------*
Static Function FRetSQLName( cParamAlias, cParamEmpresa )
	*-------------------------------------------------------*
	Local aArea 			:= GetArea()
	Local cAliasX2	     	:= GetNextAlias()
	Local cIndice      		:= GetNextAlias()
	Local cStartPath	 	:= GetSrvProfString( "StartPath", "" )
	Local cRetTabela		:= ""
	Local cArquivoX2	   	:= ""
	Local cExtensao	  		:= If( "CTREE" $ Upper( AllTrim( RealRdd() ) ), ".dtc", ".dbf" )
	Default cParamEmpresa 	:= cEmpAnt

	ConOut( "FRetSQLName - cParamAlias " + cParamAlias + " cParamEmpresa " + cParamEmpresa )

	If AllTrim( cEmpAnt ) == AllTrim( cParamEmpresa )
		cRetTabela := RetSQLName( cParamAlias )
	Else

		If Select("S_X2") = 0
			OpenSxs(,,,,cParamEmpresa,"S_X2","SX2",,.F.)
		EndIf
		S_X2->(DbSetOrder(1))
		Seek cParamAlias
		If Found()
			cRetTabela := AllTrim( S_X2->X2_ARQUIVO )
		EndIf
		S_X2->( DbCloseArea() )

	EndIf

	RestArea( aArea )

Return cRetTabela


#Include "TOTVS.ch"
#INCLUDE "apwebsrv.ch"

/* ===============================================================================
WSDL Location    http://192.168.0.225:9001/OUNIWSCADASTROS.apw?WSDL
Gerado em        09/07/19 11:17:25
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
Alterações neste arquivo podem causar funcionamento incorreto
e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _EHRSVGR ; Return  // "dummy" function - Internal Use

/* -------------------------------------------------------------------------------
WSDL Service WSOUNIWSCADASTROS
------------------------------------------------------------------------------- */

WSCLIENT WSOUNIWSCADASTROS

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD GETBANCOS
	WSMETHOD GETCABECALHOTABELASPRECO
	WSMETHOD GETCATEGORIAS
	WSMETHOD GETCOMPARTILHAMENTO
	WSMETHOD GETCONDICOESPAGAMENTO
	WSMETHOD GETDEPARTAMENTOS
	WSMETHOD GETEMPRESAS
	WSMETHOD GETITENSTABELASPRECO
	WSMETHOD GETLINHAS
	WSMETHOD GETMUNICIPIOS
	WSMETHOD GETNATUREZAS
	WSMETHOD GETPARCELAS
	WSMETHOD GETTABELASGENERICAS
	WSMETHOD GETTESS
	WSMETHOD GETTRANSPORTADORAS
	WSMETHOD GETVENDEDORES

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   oWSOBANCOFILTRO           AS OUNIWSCADASTROS_OFILBANCO
	WSDATA   oWSGETBANCOSRESULT        AS OUNIWSCADASTROS_ARRAYOFOBANCO
	WSDATA   oWSOCABECTABPRECOFILTRO   AS OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
	WSDATA   oWSGETCABECALHOTABELASPRECORESULT AS OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO
	WSDATA   oWSOCATEGORIAFILTRO       AS OUNIWSCADASTROS_OFILCATEGORIA
	WSDATA   oWSGETCATEGORIASRESULT    AS OUNIWSCADASTROS_ARRAYOFOCATEGORIA
	WSDATA   oWSOCOMPARTILHAMENTOFILTRO AS OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
	WSDATA   cGETCOMPARTILHAMENTORESULT AS string
	WSDATA   oWSOCONDPAGTOFILTRO       AS OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
	WSDATA   oWSGETCONDICOESPAGAMENTORESULT AS OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO
	WSDATA   oWSODEPARTAMENTOFILTRO    AS OUNIWSCADASTROS_OFILDEPARTAMENTO
	WSDATA   oWSGETDEPARTAMENTOSRESULT AS OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO
	WSDATA   oWSOEMPRESAFILTRO         AS OUNIWSCADASTROS_OFILEMPRESA
	WSDATA   oWSGETEMPRESASRESULT      AS OUNIWSCADASTROS_ARRAYOFOEMPRESA
	WSDATA   oWSOITEMTABPRECOFILTRO    AS OUNIWSCADASTROS_OFILITEMTABELAPRECO
	WSDATA   oWSGETITENSTABELASPRECORESULT AS OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO
	WSDATA   oWSOLINHAFILTRO           AS OUNIWSCADASTROS_OFILLINHA
	WSDATA   oWSGETLINHASRESULT        AS OUNIWSCADASTROS_ARRAYOFOLINHA
	WSDATA   oWSOMUNICIPIOFILTRO       AS OUNIWSCADASTROS_OFILMUNICIPIO
	WSDATA   oWSGETMUNICIPIOSRESULT    AS OUNIWSCADASTROS_ARRAYOFOMUNICIPIO
	WSDATA   oWSONATUREZAFILTRO        AS OUNIWSCADASTROS_OFILNATUREZA
	WSDATA   oWSGETNATUREZASRESULT     AS OUNIWSCADASTROS_ARRAYOFONATUREZA
	WSDATA   oWSOPARCELAFILTRO         AS OUNIWSCADASTROS_OFILPARCELA
	WSDATA   oWSGETPARCELASRESULT      AS OUNIWSCADASTROS_ARRAYOFOPARCELA
	WSDATA   oWSOTABGENERICAFILTRO     AS OUNIWSCADASTROS_OFILTABELAGENERICA
	WSDATA   oWSGETTABELASGENERICASRESULT AS OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA
	WSDATA   oWSOTESFILTRO             AS OUNIWSCADASTROS_OFILTES
	WSDATA   oWSGETTESSRESULT          AS OUNIWSCADASTROS_ARRAYOFOTES
	WSDATA   oWSOTRANSPORTADORAFILTRO  AS OUNIWSCADASTROS_OFILTRANSPORTADORA
	WSDATA   oWSGETTRANSPORTADORASRESULT AS OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA
	WSDATA   oWSOVENDEDORFILTRO        AS OUNIWSCADASTROS_OFILVENDEDOR
	WSDATA   oWSGETVENDEDORESRESULT    AS OUNIWSCADASTROS_ARRAYOFOVENDEDOR

	// Estruturas mantidas por compatibilidade - NÃO USAR
	WSDATA   oWSOFILBANCO              AS OUNIWSCADASTROS_OFILBANCO
	WSDATA   oWSOFILCABECALHOTABELAPRECO AS OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
	WSDATA   oWSOFILCATEGORIA          AS OUNIWSCADASTROS_OFILCATEGORIA
	WSDATA   oWSOFILCOMPARTILHAMENTO   AS OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
	WSDATA   oWSOFILCONDICAOPAGAMENTO  AS OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
	WSDATA   oWSOFILDEPARTAMENTO       AS OUNIWSCADASTROS_OFILDEPARTAMENTO
	WSDATA   oWSOFILEMPRESA            AS OUNIWSCADASTROS_OFILEMPRESA
	WSDATA   oWSOFILITEMTABELAPRECO    AS OUNIWSCADASTROS_OFILITEMTABELAPRECO
	WSDATA   oWSOFILLINHA              AS OUNIWSCADASTROS_OFILLINHA
	WSDATA   oWSOFILMUNICIPIO          AS OUNIWSCADASTROS_OFILMUNICIPIO
	WSDATA   oWSOFILNATUREZA           AS OUNIWSCADASTROS_OFILNATUREZA
	WSDATA   oWSOFILPARCELA            AS OUNIWSCADASTROS_OFILPARCELA
	WSDATA   oWSOFILTABELAGENERICA     AS OUNIWSCADASTROS_OFILTABELAGENERICA
	WSDATA   oWSOFILTES                AS OUNIWSCADASTROS_OFILTES
	WSDATA   oWSOFILTRANSPORTADORA     AS OUNIWSCADASTROS_OFILTRANSPORTADORA
	WSDATA   oWSOFILVENDEDOR           AS OUNIWSCADASTROS_OFILVENDEDOR

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSOUNIWSCADASTROS
	::Init()
	If !FindFunction("XMLCHILDEX")
		UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20190114 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
	EndIf
Return Self

WSMETHOD INIT WSCLIENT WSOUNIWSCADASTROS
	::oWSOBANCOFILTRO    := OUNIWSCADASTROS_OFILBANCO():New()
	::oWSGETBANCOSRESULT := OUNIWSCADASTROS_ARRAYOFOBANCO():New()
	::oWSOCABECTABPRECOFILTRO := OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO():New()
	::oWSGETCABECALHOTABELASPRECORESULT := OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO():New()
	::oWSOCATEGORIAFILTRO := OUNIWSCADASTROS_OFILCATEGORIA():New()
	::oWSGETCATEGORIASRESULT := OUNIWSCADASTROS_ARRAYOFOCATEGORIA():New()
	::oWSOCOMPARTILHAMENTOFILTRO := OUNIWSCADASTROS_OFILCOMPARTILHAMENTO():New()
	::oWSOCONDPAGTOFILTRO := OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO():New()
	::oWSGETCONDICOESPAGAMENTORESULT := OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO():New()
	::oWSODEPARTAMENTOFILTRO := OUNIWSCADASTROS_OFILDEPARTAMENTO():New()
	::oWSGETDEPARTAMENTOSRESULT := OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO():New()
	::oWSOEMPRESAFILTRO  := OUNIWSCADASTROS_OFILEMPRESA():New()
	::oWSGETEMPRESASRESULT := OUNIWSCADASTROS_ARRAYOFOEMPRESA():New()
	::oWSOITEMTABPRECOFILTRO := OUNIWSCADASTROS_OFILITEMTABELAPRECO():New()
	::oWSGETITENSTABELASPRECORESULT := OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO():New()
	::oWSOLINHAFILTRO    := OUNIWSCADASTROS_OFILLINHA():New()
	::oWSGETLINHASRESULT := OUNIWSCADASTROS_ARRAYOFOLINHA():New()
	::oWSOMUNICIPIOFILTRO := OUNIWSCADASTROS_OFILMUNICIPIO():New()
	::oWSGETMUNICIPIOSRESULT := OUNIWSCADASTROS_ARRAYOFOMUNICIPIO():New()
	::oWSONATUREZAFILTRO := OUNIWSCADASTROS_OFILNATUREZA():New()
	::oWSGETNATUREZASRESULT := OUNIWSCADASTROS_ARRAYOFONATUREZA():New()
	::oWSOPARCELAFILTRO  := OUNIWSCADASTROS_OFILPARCELA():New()
	::oWSGETPARCELASRESULT := OUNIWSCADASTROS_ARRAYOFOPARCELA():New()
	::oWSOTABGENERICAFILTRO := OUNIWSCADASTROS_OFILTABELAGENERICA():New()
	::oWSGETTABELASGENERICASRESULT := OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA():New()
	::oWSOTESFILTRO      := OUNIWSCADASTROS_OFILTES():New()
	::oWSGETTESSRESULT   := OUNIWSCADASTROS_ARRAYOFOTES():New()
	::oWSOTRANSPORTADORAFILTRO := OUNIWSCADASTROS_OFILTRANSPORTADORA():New()
	::oWSGETTRANSPORTADORASRESULT := OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA():New()
	::oWSOVENDEDORFILTRO := OUNIWSCADASTROS_OFILVENDEDOR():New()
	::oWSGETVENDEDORESRESULT := OUNIWSCADASTROS_ARRAYOFOVENDEDOR():New()

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSOFILBANCO       := ::oWSOBANCOFILTRO
	::oWSOFILCABECALHOTABELAPRECO := ::oWSOCABECTABPRECOFILTRO
	::oWSOFILCATEGORIA   := ::oWSOCATEGORIAFILTRO
	::oWSOFILCOMPARTILHAMENTO := ::oWSOCOMPARTILHAMENTOFILTRO
	::oWSOFILCONDICAOPAGAMENTO := ::oWSOCONDPAGTOFILTRO
	::oWSOFILDEPARTAMENTO := ::oWSODEPARTAMENTOFILTRO
	::oWSOFILEMPRESA     := ::oWSOEMPRESAFILTRO
	::oWSOFILITEMTABELAPRECO := ::oWSOITEMTABPRECOFILTRO
	::oWSOFILLINHA       := ::oWSOLINHAFILTRO
	::oWSOFILMUNICIPIO   := ::oWSOMUNICIPIOFILTRO
	::oWSOFILNATUREZA    := ::oWSONATUREZAFILTRO
	::oWSOFILPARCELA     := ::oWSOPARCELAFILTRO
	::oWSOFILTABELAGENERICA := ::oWSOTABGENERICAFILTRO
	::oWSOFILTES         := ::oWSOTESFILTRO
	::oWSOFILTRANSPORTADORA := ::oWSOTRANSPORTADORAFILTRO
	::oWSOFILVENDEDOR    := ::oWSOVENDEDORFILTRO
Return

WSMETHOD RESET WSCLIENT WSOUNIWSCADASTROS
	::oWSOBANCOFILTRO    := NIL
	::oWSGETBANCOSRESULT := NIL
	::oWSOCABECTABPRECOFILTRO := NIL
	::oWSGETCABECALHOTABELASPRECORESULT := NIL
	::oWSOCATEGORIAFILTRO := NIL
	::oWSGETCATEGORIASRESULT := NIL
	::oWSOCOMPARTILHAMENTOFILTRO := NIL
	::cGETCOMPARTILHAMENTORESULT := NIL
	::oWSOCONDPAGTOFILTRO := NIL
	::oWSGETCONDICOESPAGAMENTORESULT := NIL
	::oWSODEPARTAMENTOFILTRO := NIL
	::oWSGETDEPARTAMENTOSRESULT := NIL
	::oWSOEMPRESAFILTRO  := NIL
	::oWSGETEMPRESASRESULT := NIL
	::oWSOITEMTABPRECOFILTRO := NIL
	::oWSGETITENSTABELASPRECORESULT := NIL
	::oWSOLINHAFILTRO    := NIL
	::oWSGETLINHASRESULT := NIL
	::oWSOMUNICIPIOFILTRO := NIL
	::oWSGETMUNICIPIOSRESULT := NIL
	::oWSONATUREZAFILTRO := NIL
	::oWSGETNATUREZASRESULT := NIL
	::oWSOPARCELAFILTRO  := NIL
	::oWSGETPARCELASRESULT := NIL
	::oWSOTABGENERICAFILTRO := NIL
	::oWSGETTABELASGENERICASRESULT := NIL
	::oWSOTESFILTRO      := NIL
	::oWSGETTESSRESULT   := NIL
	::oWSOTRANSPORTADORAFILTRO := NIL
	::oWSGETTRANSPORTADORASRESULT := NIL
	::oWSOVENDEDORFILTRO := NIL
	::oWSGETVENDEDORESRESULT := NIL

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSOFILBANCO       := NIL
	::oWSOFILCABECALHOTABELAPRECO := NIL
	::oWSOFILCATEGORIA   := NIL
	::oWSOFILCOMPARTILHAMENTO := NIL
	::oWSOFILCONDICAOPAGAMENTO := NIL
	::oWSOFILDEPARTAMENTO := NIL
	::oWSOFILEMPRESA     := NIL
	::oWSOFILITEMTABELAPRECO := NIL
	::oWSOFILLINHA       := NIL
	::oWSOFILMUNICIPIO   := NIL
	::oWSOFILNATUREZA    := NIL
	::oWSOFILPARCELA     := NIL
	::oWSOFILTABELAGENERICA := NIL
	::oWSOFILTES         := NIL
	::oWSOFILTRANSPORTADORA := NIL
	::oWSOFILVENDEDOR    := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSOUNIWSCADASTROS
	Local oClone := WSOUNIWSCADASTROS():New()
	oClone:_URL          := ::_URL
	oClone:oWSOBANCOFILTRO :=  IIF(::oWSOBANCOFILTRO = NIL , NIL ,::oWSOBANCOFILTRO:Clone() )
	oClone:oWSGETBANCOSRESULT :=  IIF(::oWSGETBANCOSRESULT = NIL , NIL ,::oWSGETBANCOSRESULT:Clone() )
	oClone:oWSOCABECTABPRECOFILTRO :=  IIF(::oWSOCABECTABPRECOFILTRO = NIL , NIL ,::oWSOCABECTABPRECOFILTRO:Clone() )
	oClone:oWSGETCABECALHOTABELASPRECORESULT :=  IIF(::oWSGETCABECALHOTABELASPRECORESULT = NIL , NIL ,::oWSGETCABECALHOTABELASPRECORESULT:Clone() )
	oClone:oWSOCATEGORIAFILTRO :=  IIF(::oWSOCATEGORIAFILTRO = NIL , NIL ,::oWSOCATEGORIAFILTRO:Clone() )
	oClone:oWSGETCATEGORIASRESULT :=  IIF(::oWSGETCATEGORIASRESULT = NIL , NIL ,::oWSGETCATEGORIASRESULT:Clone() )
	oClone:oWSOCOMPARTILHAMENTOFILTRO :=  IIF(::oWSOCOMPARTILHAMENTOFILTRO = NIL , NIL ,::oWSOCOMPARTILHAMENTOFILTRO:Clone() )
	oClone:cGETCOMPARTILHAMENTORESULT := ::cGETCOMPARTILHAMENTORESULT
	oClone:oWSOCONDPAGTOFILTRO :=  IIF(::oWSOCONDPAGTOFILTRO = NIL , NIL ,::oWSOCONDPAGTOFILTRO:Clone() )
	oClone:oWSGETCONDICOESPAGAMENTORESULT :=  IIF(::oWSGETCONDICOESPAGAMENTORESULT = NIL , NIL ,::oWSGETCONDICOESPAGAMENTORESULT:Clone() )
	oClone:oWSODEPARTAMENTOFILTRO :=  IIF(::oWSODEPARTAMENTOFILTRO = NIL , NIL ,::oWSODEPARTAMENTOFILTRO:Clone() )
	oClone:oWSGETDEPARTAMENTOSRESULT :=  IIF(::oWSGETDEPARTAMENTOSRESULT = NIL , NIL ,::oWSGETDEPARTAMENTOSRESULT:Clone() )
	oClone:oWSOEMPRESAFILTRO :=  IIF(::oWSOEMPRESAFILTRO = NIL , NIL ,::oWSOEMPRESAFILTRO:Clone() )
	oClone:oWSGETEMPRESASRESULT :=  IIF(::oWSGETEMPRESASRESULT = NIL , NIL ,::oWSGETEMPRESASRESULT:Clone() )
	oClone:oWSOITEMTABPRECOFILTRO :=  IIF(::oWSOITEMTABPRECOFILTRO = NIL , NIL ,::oWSOITEMTABPRECOFILTRO:Clone() )
	oClone:oWSGETITENSTABELASPRECORESULT :=  IIF(::oWSGETITENSTABELASPRECORESULT = NIL , NIL ,::oWSGETITENSTABELASPRECORESULT:Clone() )
	oClone:oWSOLINHAFILTRO :=  IIF(::oWSOLINHAFILTRO = NIL , NIL ,::oWSOLINHAFILTRO:Clone() )
	oClone:oWSGETLINHASRESULT :=  IIF(::oWSGETLINHASRESULT = NIL , NIL ,::oWSGETLINHASRESULT:Clone() )
	oClone:oWSOMUNICIPIOFILTRO :=  IIF(::oWSOMUNICIPIOFILTRO = NIL , NIL ,::oWSOMUNICIPIOFILTRO:Clone() )
	oClone:oWSGETMUNICIPIOSRESULT :=  IIF(::oWSGETMUNICIPIOSRESULT = NIL , NIL ,::oWSGETMUNICIPIOSRESULT:Clone() )
	oClone:oWSONATUREZAFILTRO :=  IIF(::oWSONATUREZAFILTRO = NIL , NIL ,::oWSONATUREZAFILTRO:Clone() )
	oClone:oWSGETNATUREZASRESULT :=  IIF(::oWSGETNATUREZASRESULT = NIL , NIL ,::oWSGETNATUREZASRESULT:Clone() )
	oClone:oWSOPARCELAFILTRO :=  IIF(::oWSOPARCELAFILTRO = NIL , NIL ,::oWSOPARCELAFILTRO:Clone() )
	oClone:oWSGETPARCELASRESULT :=  IIF(::oWSGETPARCELASRESULT = NIL , NIL ,::oWSGETPARCELASRESULT:Clone() )
	oClone:oWSOTABGENERICAFILTRO :=  IIF(::oWSOTABGENERICAFILTRO = NIL , NIL ,::oWSOTABGENERICAFILTRO:Clone() )
	oClone:oWSGETTABELASGENERICASRESULT :=  IIF(::oWSGETTABELASGENERICASRESULT = NIL , NIL ,::oWSGETTABELASGENERICASRESULT:Clone() )
	oClone:oWSOTESFILTRO :=  IIF(::oWSOTESFILTRO = NIL , NIL ,::oWSOTESFILTRO:Clone() )
	oClone:oWSGETTESSRESULT :=  IIF(::oWSGETTESSRESULT = NIL , NIL ,::oWSGETTESSRESULT:Clone() )
	oClone:oWSOTRANSPORTADORAFILTRO :=  IIF(::oWSOTRANSPORTADORAFILTRO = NIL , NIL ,::oWSOTRANSPORTADORAFILTRO:Clone() )
	oClone:oWSGETTRANSPORTADORASRESULT :=  IIF(::oWSGETTRANSPORTADORASRESULT = NIL , NIL ,::oWSGETTRANSPORTADORASRESULT:Clone() )
	oClone:oWSOVENDEDORFILTRO :=  IIF(::oWSOVENDEDORFILTRO = NIL , NIL ,::oWSOVENDEDORFILTRO:Clone() )
	oClone:oWSGETVENDEDORESRESULT :=  IIF(::oWSGETVENDEDORESRESULT = NIL , NIL ,::oWSGETVENDEDORESRESULT:Clone() )

	// Estruturas mantidas por compatibilidade - NÃO USAR
	oClone:oWSOFILBANCO  := oClone:oWSOBANCOFILTRO
	oClone:oWSOFILCABECALHOTABELAPRECO := oClone:oWSOCABECTABPRECOFILTRO
	oClone:oWSOFILCATEGORIA := oClone:oWSOCATEGORIAFILTRO
	oClone:oWSOFILCOMPARTILHAMENTO := oClone:oWSOCOMPARTILHAMENTOFILTRO
	oClone:oWSOFILCONDICAOPAGAMENTO := oClone:oWSOCONDPAGTOFILTRO
	oClone:oWSOFILDEPARTAMENTO := oClone:oWSODEPARTAMENTOFILTRO
	oClone:oWSOFILEMPRESA := oClone:oWSOEMPRESAFILTRO
	oClone:oWSOFILITEMTABELAPRECO := oClone:oWSOITEMTABPRECOFILTRO
	oClone:oWSOFILLINHA  := oClone:oWSOLINHAFILTRO
	oClone:oWSOFILMUNICIPIO := oClone:oWSOMUNICIPIOFILTRO
	oClone:oWSOFILNATUREZA := oClone:oWSONATUREZAFILTRO
	oClone:oWSOFILPARCELA := oClone:oWSOPARCELAFILTRO
	oClone:oWSOFILTABELAGENERICA := oClone:oWSOTABGENERICAFILTRO
	oClone:oWSOFILTES    := oClone:oWSOTESFILTRO
	oClone:oWSOFILTRANSPORTADORA := oClone:oWSOTRANSPORTADORAFILTRO
	oClone:oWSOFILVENDEDOR := oClone:oWSOVENDEDORFILTRO
Return oClone

// WSDL Method GETBANCOS of Service WSOUNIWSCADASTROS

WSMETHOD GETBANCOS WSSEND oWSOBANCOFILTRO WSRECEIVE oWSGETBANCOSRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETBANCOS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OBANCOFILTRO", ::oWSOBANCOFILTRO, oWSOBANCOFILTRO , "OFILBANCO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETBANCOS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETBANCOS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETBANCOSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETBANCOSRESPONSE:_GETBANCOSRESULT","ARRAYOFOBANCO",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETCABECALHOTABELASPRECO of Service WSOUNIWSCADASTROS

WSMETHOD GETCABECALHOTABELASPRECO WSSEND oWSOCABECTABPRECOFILTRO WSRECEIVE oWSGETCABECALHOTABELASPRECORESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETCABECALHOTABELASPRECO xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OCABECTABPRECOFILTRO", ::oWSOCABECTABPRECOFILTRO, oWSOCABECTABPRECOFILTRO , "OFILCABECALHOTABELAPRECO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETCABECALHOTABELASPRECO>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETCABECALHOTABELASPRECO",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETCABECALHOTABELASPRECORESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETCABECALHOTABELASPRECORESPONSE:_GETCABECALHOTABELASPRECORESULT","ARRAYOFOCABECALHOTABELAPRECO",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETCATEGORIAS of Service WSOUNIWSCADASTROS

WSMETHOD GETCATEGORIAS WSSEND oWSOCATEGORIAFILTRO WSRECEIVE oWSGETCATEGORIASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETCATEGORIAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OCATEGORIAFILTRO", ::oWSOCATEGORIAFILTRO, oWSOCATEGORIAFILTRO , "OFILCATEGORIA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETCATEGORIAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETCATEGORIAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETCATEGORIASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETCATEGORIASRESPONSE:_GETCATEGORIASRESULT","ARRAYOFOCATEGORIA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETCOMPARTILHAMENTO of Service WSOUNIWSCADASTROS

WSMETHOD GETCOMPARTILHAMENTO WSSEND oWSOCOMPARTILHAMENTOFILTRO WSRECEIVE cGETCOMPARTILHAMENTORESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETCOMPARTILHAMENTO xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OCOMPARTILHAMENTOFILTRO", ::oWSOCOMPARTILHAMENTOFILTRO, oWSOCOMPARTILHAMENTOFILTRO , "OFILCOMPARTILHAMENTO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETCOMPARTILHAMENTO>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETCOMPARTILHAMENTO",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::cGETCOMPARTILHAMENTORESULT :=  WSAdvValue( oXmlRet,"_GETCOMPARTILHAMENTORESPONSE:_GETCOMPARTILHAMENTORESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETCONDICOESPAGAMENTO of Service WSOUNIWSCADASTROS

WSMETHOD GETCONDICOESPAGAMENTO WSSEND oWSOCONDPAGTOFILTRO WSRECEIVE oWSGETCONDICOESPAGAMENTORESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETCONDICOESPAGAMENTO xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OCONDPAGTOFILTRO", ::oWSOCONDPAGTOFILTRO, oWSOCONDPAGTOFILTRO , "OFILCONDICAOPAGAMENTO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETCONDICOESPAGAMENTO>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETCONDICOESPAGAMENTO",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETCONDICOESPAGAMENTORESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETCONDICOESPAGAMENTORESPONSE:_GETCONDICOESPAGAMENTORESULT","ARRAYOFOCONDICAOPAGAMENTO",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETDEPARTAMENTOS of Service WSOUNIWSCADASTROS

WSMETHOD GETDEPARTAMENTOS WSSEND oWSODEPARTAMENTOFILTRO WSRECEIVE oWSGETDEPARTAMENTOSRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETDEPARTAMENTOS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("ODEPARTAMENTOFILTRO", ::oWSODEPARTAMENTOFILTRO, oWSODEPARTAMENTOFILTRO , "OFILDEPARTAMENTO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETDEPARTAMENTOS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETDEPARTAMENTOS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETDEPARTAMENTOSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETDEPARTAMENTOSRESPONSE:_GETDEPARTAMENTOSRESULT","ARRAYOFODEPARTAMENTO",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETEMPRESAS of Service WSOUNIWSCADASTROS

WSMETHOD GETEMPRESAS WSSEND oWSOEMPRESAFILTRO WSRECEIVE oWSGETEMPRESASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETEMPRESAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OEMPRESAFILTRO", ::oWSOEMPRESAFILTRO, oWSOEMPRESAFILTRO , "OFILEMPRESA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETEMPRESAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETEMPRESAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETEMPRESASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETEMPRESASRESPONSE:_GETEMPRESASRESULT","ARRAYOFOEMPRESA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETITENSTABELASPRECO of Service WSOUNIWSCADASTROS

WSMETHOD GETITENSTABELASPRECO WSSEND oWSOITEMTABPRECOFILTRO WSRECEIVE oWSGETITENSTABELASPRECORESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETITENSTABELASPRECO xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OITEMTABPRECOFILTRO", ::oWSOITEMTABPRECOFILTRO, oWSOITEMTABPRECOFILTRO , "OFILITEMTABELAPRECO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETITENSTABELASPRECO>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETITENSTABELASPRECO",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETITENSTABELASPRECORESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETITENSTABELASPRECORESPONSE:_GETITENSTABELASPRECORESULT","ARRAYOFOITENSTABELAPRECO",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETLINHAS of Service WSOUNIWSCADASTROS

WSMETHOD GETLINHAS WSSEND oWSOLINHAFILTRO WSRECEIVE oWSGETLINHASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETLINHAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OLINHAFILTRO", ::oWSOLINHAFILTRO, oWSOLINHAFILTRO , "OFILLINHA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETLINHAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETLINHAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETLINHASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETLINHASRESPONSE:_GETLINHASRESULT","ARRAYOFOLINHA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETMUNICIPIOS of Service WSOUNIWSCADASTROS

WSMETHOD GETMUNICIPIOS WSSEND oWSOMUNICIPIOFILTRO WSRECEIVE oWSGETMUNICIPIOSRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETMUNICIPIOS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OMUNICIPIOFILTRO", ::oWSOMUNICIPIOFILTRO, oWSOMUNICIPIOFILTRO , "OFILMUNICIPIO", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETMUNICIPIOS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETMUNICIPIOS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETMUNICIPIOSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETMUNICIPIOSRESPONSE:_GETMUNICIPIOSRESULT","ARRAYOFOMUNICIPIO",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETNATUREZAS of Service WSOUNIWSCADASTROS

WSMETHOD GETNATUREZAS WSSEND oWSONATUREZAFILTRO WSRECEIVE oWSGETNATUREZASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETNATUREZAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("ONATUREZAFILTRO", ::oWSONATUREZAFILTRO, oWSONATUREZAFILTRO , "OFILNATUREZA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETNATUREZAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETNATUREZAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETNATUREZASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETNATUREZASRESPONSE:_GETNATUREZASRESULT","ARRAYOFONATUREZA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETPARCELAS of Service WSOUNIWSCADASTROS

WSMETHOD GETPARCELAS WSSEND oWSOPARCELAFILTRO WSRECEIVE oWSGETPARCELASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETPARCELAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OPARCELAFILTRO", ::oWSOPARCELAFILTRO, oWSOPARCELAFILTRO , "OFILPARCELA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETPARCELAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETPARCELAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETPARCELASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETPARCELASRESPONSE:_GETPARCELASRESULT","ARRAYOFOPARCELA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETTABELASGENERICAS of Service WSOUNIWSCADASTROS

WSMETHOD GETTABELASGENERICAS WSSEND oWSOTABGENERICAFILTRO WSRECEIVE oWSGETTABELASGENERICASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETTABELASGENERICAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OTABGENERICAFILTRO", ::oWSOTABGENERICAFILTRO, oWSOTABGENERICAFILTRO , "OFILTABELAGENERICA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETTABELASGENERICAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETTABELASGENERICAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETTABELASGENERICASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTABELASGENERICASRESPONSE:_GETTABELASGENERICASRESULT","ARRAYOFOTABELAGENERICA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETTESS of Service WSOUNIWSCADASTROS

WSMETHOD GETTESS WSSEND oWSOTESFILTRO WSRECEIVE oWSGETTESSRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETTESS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OTESFILTRO", ::oWSOTESFILTRO, oWSOTESFILTRO , "OFILTES", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETTESS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETTESS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETTESSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTESSRESPONSE:_GETTESSRESULT","ARRAYOFOTES",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETTRANSPORTADORAS of Service WSOUNIWSCADASTROS

WSMETHOD GETTRANSPORTADORAS WSSEND oWSOTRANSPORTADORAFILTRO WSRECEIVE oWSGETTRANSPORTADORASRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETTRANSPORTADORAS xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OTRANSPORTADORAFILTRO", ::oWSOTRANSPORTADORAFILTRO, oWSOTRANSPORTADORAFILTRO , "OFILTRANSPORTADORA", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETTRANSPORTADORAS>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETTRANSPORTADORAS",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETTRANSPORTADORASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTRANSPORTADORASRESPONSE:_GETTRANSPORTADORASRESULT","ARRAYOFOTRANSPORTADORA",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method GETVENDEDORES of Service WSOUNIWSCADASTROS

WSMETHOD GETVENDEDORES WSSEND oWSOVENDEDORFILTRO WSRECEIVE oWSGETVENDEDORESRESULT WSCLIENT WSOUNIWSCADASTROS
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<GETVENDEDORES xmlns="http://leblon:9001/">'
	cSoap += WSSoapValue("OVENDEDORFILTRO", ::oWSOVENDEDORFILTRO, oWSOVENDEDORFILTRO , "OFILVENDEDOR", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += "</GETVENDEDORES>"

	oXmlRet := SvcSoapCall(	Self,cSoap,;
		"http://leblon:9001/GETVENDEDORES",;
	"DOCUMENT","http://leblon:9001/",,"1.031217",;
	"http://192.168.0.225:9001/OUNIWSCADASTROS.apw")

	::Init()
	::oWSGETVENDEDORESRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETVENDEDORESRESPONSE:_GETVENDEDORESRESULT","ARRAYOFOVENDEDOR",NIL,NIL,NIL,NIL,NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.


// WSDL Data Structure OFILBANCO

WSSTRUCT OUNIWSCADASTROS_OFILBANCO
	WSDATA   cCAGENCIA                 AS string
	WSDATA   cCBANCO                   AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILBANCO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILBANCO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILBANCO
	Local oClone := OUNIWSCADASTROS_OFILBANCO():NEW()
	oClone:cCAGENCIA            := ::cCAGENCIA
	oClone:cCBANCO              := ::cCBANCO
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILBANCO
	Local cSoap := ""
	cSoap += WSSoapValue("CAGENCIA", ::cCAGENCIA, ::cCAGENCIA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CBANCO", ::cCBANCO, ::cCBANCO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOBANCO

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOBANCO
	WSDATA   oWSOBANCO                 AS OUNIWSCADASTROS_OBANCO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOBANCO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOBANCO
	::oWSOBANCO            := {} // Array Of  OUNIWSCADASTROS_OBANCO():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOBANCO
	Local oClone := OUNIWSCADASTROS_ARRAYOFOBANCO():NEW()
	oClone:oWSOBANCO := NIL
	If ::oWSOBANCO <> NIL
		oClone:oWSOBANCO := {}
		aEval( ::oWSOBANCO , { |x| aadd( oClone:oWSOBANCO , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOBANCO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OBANCO","OBANCO",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOBANCO , OUNIWSCADASTROS_OBANCO():New() )
			::oWSOBANCO[len(::oWSOBANCO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILCABECALHOTABELAPRECO

WSSTRUCT OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
	WSDATA   cCATIVO                   AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTABELA               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
	Local oClone := OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO():NEW()
	oClone:cCATIVO              := ::cCATIVO
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTABELA          := ::cCCODTABELA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILCABECALHOTABELAPRECO
	Local cSoap := ""
	cSoap += WSSoapValue("CATIVO", ::cCATIVO, ::cCATIVO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODTABELA", ::cCCODTABELA, ::cCCODTABELA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOCABECALHOTABELAPRECO

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO
	WSDATA   oWSOCABECALHOTABELAPRECO  AS OUNIWSCADASTROS_OCABECALHOTABELAPRECO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO
	::oWSOCABECALHOTABELAPRECO := {} // Array Of  OUNIWSCADASTROS_OCABECALHOTABELAPRECO():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO
	Local oClone := OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO():NEW()
	oClone:oWSOCABECALHOTABELAPRECO := NIL
	If ::oWSOCABECALHOTABELAPRECO <> NIL
		oClone:oWSOCABECALHOTABELAPRECO := {}
		aEval( ::oWSOCABECALHOTABELAPRECO , { |x| aadd( oClone:oWSOCABECALHOTABELAPRECO , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOCABECALHOTABELAPRECO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OCABECALHOTABELAPRECO","OCABECALHOTABELAPRECO",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOCABECALHOTABELAPRECO , OUNIWSCADASTROS_OCABECALHOTABELAPRECO():New() )
			::oWSOCABECALHOTABELAPRECO[len(::oWSOCABECALHOTABELAPRECO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILCATEGORIA

WSSTRUCT OUNIWSCADASTROS_OFILCATEGORIA
	WSDATA   cCCODCATEGORIA            AS string
	WSDATA   cCCODDEPARTAMENTO         AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCDESCCATEGORIA           AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILCATEGORIA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILCATEGORIA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILCATEGORIA
	Local oClone := OUNIWSCADASTROS_OFILCATEGORIA():NEW()
	oClone:cCCODCATEGORIA       := ::cCCODCATEGORIA
	oClone:cCCODDEPARTAMENTO    := ::cCCODDEPARTAMENTO
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCDESCCATEGORIA      := ::cCDESCCATEGORIA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILCATEGORIA
	Local cSoap := ""
	cSoap += WSSoapValue("CCODCATEGORIA", ::cCCODCATEGORIA, ::cCCODCATEGORIA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODDEPARTAMENTO", ::cCCODDEPARTAMENTO, ::cCCODDEPARTAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CDESCCATEGORIA", ::cCDESCCATEGORIA, ::cCDESCCATEGORIA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOCATEGORIA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOCATEGORIA
	WSDATA   oWSOCATEGORIA             AS OUNIWSCADASTROS_OCATEGORIA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOCATEGORIA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOCATEGORIA
	::oWSOCATEGORIA        := {} // Array Of  OUNIWSCADASTROS_OCATEGORIA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOCATEGORIA
	Local oClone := OUNIWSCADASTROS_ARRAYOFOCATEGORIA():NEW()
	oClone:oWSOCATEGORIA := NIL
	If ::oWSOCATEGORIA <> NIL
		oClone:oWSOCATEGORIA := {}
		aEval( ::oWSOCATEGORIA , { |x| aadd( oClone:oWSOCATEGORIA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOCATEGORIA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OCATEGORIA","OCATEGORIA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOCATEGORIA , OUNIWSCADASTROS_OCATEGORIA():New() )
			::oWSOCATEGORIA[len(::oWSOCATEGORIA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILCOMPARTILHAMENTO

WSSTRUCT OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
	WSDATA   cCALIASTABELA             AS string
	WSDATA   cCCODEMPRESA              AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
	Local oClone := OUNIWSCADASTROS_OFILCOMPARTILHAMENTO():NEW()
	oClone:cCALIASTABELA        := ::cCALIASTABELA
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILCOMPARTILHAMENTO
	Local cSoap := ""
	cSoap += WSSoapValue("CALIASTABELA", ::cCALIASTABELA, ::cCALIASTABELA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure OFILCONDICAOPAGAMENTO

WSSTRUCT OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCONDPAGAMENTO           AS string
	WSDATA   cCDESCRICAO               AS string
	WSDATA   cCFORMAPAGTO              AS string
	WSDATA   cCSTATUS                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
	Local oClone := OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCONDPAGAMENTO      := ::cCCONDPAGAMENTO
	oClone:cCDESCRICAO          := ::cCDESCRICAO
	oClone:cCFORMAPAGTO         := ::cCFORMAPAGTO
	oClone:cCSTATUS             := ::cCSTATUS
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILCONDICAOPAGAMENTO
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCONDPAGAMENTO", ::cCCONDPAGAMENTO, ::cCCONDPAGAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CDESCRICAO", ::cCDESCRICAO, ::cCDESCRICAO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CFORMAPAGTO", ::cCFORMAPAGTO, ::cCFORMAPAGTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CSTATUS", ::cCSTATUS, ::cCSTATUS , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOCONDICAOPAGAMENTO

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO
	WSDATA   oWSOCONDICAOPAGAMENTO     AS OUNIWSCADASTROS_OCONDICAOPAGAMENTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO
	::oWSOCONDICAOPAGAMENTO := {} // Array Of  OUNIWSCADASTROS_OCONDICAOPAGAMENTO():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO
	Local oClone := OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO():NEW()
	oClone:oWSOCONDICAOPAGAMENTO := NIL
	If ::oWSOCONDICAOPAGAMENTO <> NIL
		oClone:oWSOCONDICAOPAGAMENTO := {}
		aEval( ::oWSOCONDICAOPAGAMENTO , { |x| aadd( oClone:oWSOCONDICAOPAGAMENTO , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOCONDICAOPAGAMENTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OCONDICAOPAGAMENTO","OCONDICAOPAGAMENTO",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOCONDICAOPAGAMENTO , OUNIWSCADASTROS_OCONDICAOPAGAMENTO():New() )
			::oWSOCONDICAOPAGAMENTO[len(::oWSOCONDICAOPAGAMENTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILDEPARTAMENTO

WSSTRUCT OUNIWSCADASTROS_OFILDEPARTAMENTO
	WSDATA   cCCODDEPARTAMENTO         AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCDESCDEPARTAMENTO        AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILDEPARTAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILDEPARTAMENTO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILDEPARTAMENTO
	Local oClone := OUNIWSCADASTROS_OFILDEPARTAMENTO():NEW()
	oClone:cCCODDEPARTAMENTO    := ::cCCODDEPARTAMENTO
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCDESCDEPARTAMENTO   := ::cCDESCDEPARTAMENTO
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILDEPARTAMENTO
	Local cSoap := ""
	cSoap += WSSoapValue("CCODDEPARTAMENTO", ::cCCODDEPARTAMENTO, ::cCCODDEPARTAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CDESCDEPARTAMENTO", ::cCDESCDEPARTAMENTO, ::cCDESCDEPARTAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFODEPARTAMENTO

WSSTRUCT OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO
	WSDATA   oWSODEPARTAMENTO          AS OUNIWSCADASTROS_ODEPARTAMENTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO
	::oWSODEPARTAMENTO     := {} // Array Of  OUNIWSCADASTROS_ODEPARTAMENTO():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO
	Local oClone := OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO():NEW()
	oClone:oWSODEPARTAMENTO := NIL
	If ::oWSODEPARTAMENTO <> NIL
		oClone:oWSODEPARTAMENTO := {}
		aEval( ::oWSODEPARTAMENTO , { |x| aadd( oClone:oWSODEPARTAMENTO , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFODEPARTAMENTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_ODEPARTAMENTO","ODEPARTAMENTO",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSODEPARTAMENTO , OUNIWSCADASTROS_ODEPARTAMENTO():New() )
			::oWSODEPARTAMENTO[len(::oWSODEPARTAMENTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILEMPRESA

WSSTRUCT OUNIWSCADASTROS_OFILEMPRESA
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILEMPRESA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILEMPRESA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILEMPRESA
	Local oClone := OUNIWSCADASTROS_OFILEMPRESA():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILEMPRESA
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOEMPRESA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOEMPRESA
	WSDATA   oWSOEMPRESA               AS OUNIWSCADASTROS_OEMPRESA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOEMPRESA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOEMPRESA
	::oWSOEMPRESA          := {} // Array Of  OUNIWSCADASTROS_OEMPRESA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOEMPRESA
	Local oClone := OUNIWSCADASTROS_ARRAYOFOEMPRESA():NEW()
	oClone:oWSOEMPRESA := NIL
	If ::oWSOEMPRESA <> NIL
		oClone:oWSOEMPRESA := {}
		aEval( ::oWSOEMPRESA , { |x| aadd( oClone:oWSOEMPRESA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOEMPRESA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OEMPRESA","OEMPRESA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOEMPRESA , OUNIWSCADASTROS_OEMPRESA():New() )
			::oWSOEMPRESA[len(::oWSOEMPRESA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILITEMTABELAPRECO

WSSTRUCT OUNIWSCADASTROS_OFILITEMTABELAPRECO
	WSDATA   cCATIVO                   AS string
	WSDATA   cCCODDEPARTAMENTO         AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODPRODUTO              AS string
	WSDATA   cCCODTABELA               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILITEMTABELAPRECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILITEMTABELAPRECO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILITEMTABELAPRECO
	Local oClone := OUNIWSCADASTROS_OFILITEMTABELAPRECO():NEW()
	oClone:cCATIVO              := ::cCATIVO
	oClone:cCCODDEPARTAMENTO    := ::cCCODDEPARTAMENTO
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODPRODUTO         := ::cCCODPRODUTO
	oClone:cCCODTABELA          := ::cCCODTABELA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILITEMTABELAPRECO
	Local cSoap := ""
	cSoap += WSSoapValue("CATIVO", ::cCATIVO, ::cCATIVO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODDEPARTAMENTO", ::cCCODDEPARTAMENTO, ::cCCODDEPARTAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODPRODUTO", ::cCCODPRODUTO, ::cCCODPRODUTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODTABELA", ::cCCODTABELA, ::cCCODTABELA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOITENSTABELAPRECO

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO
	WSDATA   oWSOITENSTABELAPRECO      AS OUNIWSCADASTROS_OITENSTABELAPRECO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO
	::oWSOITENSTABELAPRECO := {} // Array Of  OUNIWSCADASTROS_OITENSTABELAPRECO():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO
	Local oClone := OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO():NEW()
	oClone:oWSOITENSTABELAPRECO := NIL
	If ::oWSOITENSTABELAPRECO <> NIL
		oClone:oWSOITENSTABELAPRECO := {}
		aEval( ::oWSOITENSTABELAPRECO , { |x| aadd( oClone:oWSOITENSTABELAPRECO , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOITENSTABELAPRECO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OITENSTABELAPRECO","OITENSTABELAPRECO",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOITENSTABELAPRECO , OUNIWSCADASTROS_OITENSTABELAPRECO():New() )
			::oWSOITENSTABELAPRECO[len(::oWSOITENSTABELAPRECO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILLINHA

WSSTRUCT OUNIWSCADASTROS_OFILLINHA
	WSDATA   cCCODCATEGORIA            AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODLINHA                AS string
	WSDATA   cCDESCLINHA               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILLINHA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILLINHA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILLINHA
	Local oClone := OUNIWSCADASTROS_OFILLINHA():NEW()
	oClone:cCCODCATEGORIA       := ::cCCODCATEGORIA
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODLINHA           := ::cCCODLINHA
	oClone:cCDESCLINHA          := ::cCDESCLINHA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILLINHA
	Local cSoap := ""
	cSoap += WSSoapValue("CCODCATEGORIA", ::cCCODCATEGORIA, ::cCCODCATEGORIA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODLINHA", ::cCCODLINHA, ::cCCODLINHA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CDESCLINHA", ::cCDESCLINHA, ::cCDESCLINHA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOLINHA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOLINHA
	WSDATA   oWSOLINHA                 AS OUNIWSCADASTROS_OLINHA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOLINHA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOLINHA
	::oWSOLINHA            := {} // Array Of  OUNIWSCADASTROS_OLINHA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOLINHA
	Local oClone := OUNIWSCADASTROS_ARRAYOFOLINHA():NEW()
	oClone:oWSOLINHA := NIL
	If ::oWSOLINHA <> NIL
		oClone:oWSOLINHA := {}
		aEval( ::oWSOLINHA , { |x| aadd( oClone:oWSOLINHA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOLINHA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OLINHA","OLINHA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOLINHA , OUNIWSCADASTROS_OLINHA():New() )
			::oWSOLINHA[len(::oWSOLINHA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILMUNICIPIO

WSSTRUCT OUNIWSCADASTROS_OFILMUNICIPIO
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODMUNICIPIO            AS string
	WSDATA   cCDESCMUNICIPIO           AS string
	WSDATA   cCESTADO                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILMUNICIPIO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILMUNICIPIO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILMUNICIPIO
	Local oClone := OUNIWSCADASTROS_OFILMUNICIPIO():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODMUNICIPIO       := ::cCCODMUNICIPIO
	oClone:cCDESCMUNICIPIO      := ::cCDESCMUNICIPIO
	oClone:cCESTADO             := ::cCESTADO
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILMUNICIPIO
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODMUNICIPIO", ::cCCODMUNICIPIO, ::cCCODMUNICIPIO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CDESCMUNICIPIO", ::cCDESCMUNICIPIO, ::cCDESCMUNICIPIO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CESTADO", ::cCESTADO, ::cCESTADO , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOMUNICIPIO

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOMUNICIPIO
	WSDATA   oWSOMUNICIPIO             AS OUNIWSCADASTROS_OMUNICIPIO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOMUNICIPIO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOMUNICIPIO
	::oWSOMUNICIPIO        := {} // Array Of  OUNIWSCADASTROS_OMUNICIPIO():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOMUNICIPIO
	Local oClone := OUNIWSCADASTROS_ARRAYOFOMUNICIPIO():NEW()
	oClone:oWSOMUNICIPIO := NIL
	If ::oWSOMUNICIPIO <> NIL
		oClone:oWSOMUNICIPIO := {}
		aEval( ::oWSOMUNICIPIO , { |x| aadd( oClone:oWSOMUNICIPIO , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOMUNICIPIO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OMUNICIPIO","OMUNICIPIO",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOMUNICIPIO , OUNIWSCADASTROS_OMUNICIPIO():New() )
			::oWSOMUNICIPIO[len(::oWSOMUNICIPIO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILNATUREZA

WSSTRUCT OUNIWSCADASTROS_OFILNATUREZA
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODNATUREZA             AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILNATUREZA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILNATUREZA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILNATUREZA
	Local oClone := OUNIWSCADASTROS_OFILNATUREZA():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODNATUREZA        := ::cCCODNATUREZA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILNATUREZA
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODNATUREZA", ::cCCODNATUREZA, ::cCCODNATUREZA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFONATUREZA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFONATUREZA
	WSDATA   oWSONATUREZA              AS OUNIWSCADASTROS_ONATUREZA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFONATUREZA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFONATUREZA
	::oWSONATUREZA         := {} // Array Of  OUNIWSCADASTROS_ONATUREZA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFONATUREZA
	Local oClone := OUNIWSCADASTROS_ARRAYOFONATUREZA():NEW()
	oClone:oWSONATUREZA := NIL
	If ::oWSONATUREZA <> NIL
		oClone:oWSONATUREZA := {}
		aEval( ::oWSONATUREZA , { |x| aadd( oClone:oWSONATUREZA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFONATUREZA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_ONATUREZA","ONATUREZA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSONATUREZA , OUNIWSCADASTROS_ONATUREZA():New() )
			::oWSONATUREZA[len(::oWSONATUREZA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILPARCELA

WSSTRUCT OUNIWSCADASTROS_OFILPARCELA
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCONDPAGAMENTO           AS string
	WSDATA   cCDATAORCAMENTO           AS string
	WSDATA   nNVALORACRESCIMO          AS float
	WSDATA   nNVALORORCAMENTO          AS float
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILPARCELA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILPARCELA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILPARCELA
	Local oClone := OUNIWSCADASTROS_OFILPARCELA():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCONDPAGAMENTO      := ::cCCONDPAGAMENTO
	oClone:cCDATAORCAMENTO      := ::cCDATAORCAMENTO
	oClone:nNVALORACRESCIMO     := ::nNVALORACRESCIMO
	oClone:nNVALORORCAMENTO     := ::nNVALORORCAMENTO
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILPARCELA
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCONDPAGAMENTO", ::cCCONDPAGAMENTO, ::cCCONDPAGAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CDATAORCAMENTO", ::cCDATAORCAMENTO, ::cCDATAORCAMENTO , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("NVALORACRESCIMO", ::nNVALORACRESCIMO, ::nNVALORACRESCIMO , "float", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("NVALORORCAMENTO", ::nNVALORORCAMENTO, ::nNVALORORCAMENTO , "float", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOPARCELA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOPARCELA
	WSDATA   oWSOPARCELA               AS OUNIWSCADASTROS_OPARCELA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOPARCELA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOPARCELA
	::oWSOPARCELA          := {} // Array Of  OUNIWSCADASTROS_OPARCELA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOPARCELA
	Local oClone := OUNIWSCADASTROS_ARRAYOFOPARCELA():NEW()
	oClone:oWSOPARCELA := NIL
	If ::oWSOPARCELA <> NIL
		oClone:oWSOPARCELA := {}
		aEval( ::oWSOPARCELA , { |x| aadd( oClone:oWSOPARCELA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOPARCELA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OPARCELA","OPARCELA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOPARCELA , OUNIWSCADASTROS_OPARCELA():New() )
			::oWSOPARCELA[len(::oWSOPARCELA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILTABELAGENERICA

WSSTRUCT OUNIWSCADASTROS_OFILTABELAGENERICA
	WSDATA   cCCHAVE                   AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTABELA               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILTABELAGENERICA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILTABELAGENERICA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILTABELAGENERICA
	Local oClone := OUNIWSCADASTROS_OFILTABELAGENERICA():NEW()
	oClone:cCCHAVE              := ::cCCHAVE
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTABELA          := ::cCCODTABELA
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILTABELAGENERICA
	Local cSoap := ""
	cSoap += WSSoapValue("CCHAVE", ::cCCHAVE, ::cCCHAVE , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODTABELA", ::cCCODTABELA, ::cCCODTABELA , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOTABELAGENERICA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA
	WSDATA   oWSOTABELAGENERICA        AS OUNIWSCADASTROS_OTABELAGENERICA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA
	::oWSOTABELAGENERICA   := {} // Array Of  OUNIWSCADASTROS_OTABELAGENERICA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA
	Local oClone := OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA():NEW()
	oClone:oWSOTABELAGENERICA := NIL
	If ::oWSOTABELAGENERICA <> NIL
		oClone:oWSOTABELAGENERICA := {}
		aEval( ::oWSOTABELAGENERICA , { |x| aadd( oClone:oWSOTABELAGENERICA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOTABELAGENERICA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OTABELAGENERICA","OTABELAGENERICA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOTABELAGENERICA , OUNIWSCADASTROS_OTABELAGENERICA():New() )
			::oWSOTABELAGENERICA[len(::oWSOTABELAGENERICA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILTES

WSSTRUCT OUNIWSCADASTROS_OFILTES
	WSDATA   cCCFOP                    AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTES                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILTES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILTES
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILTES
	Local oClone := OUNIWSCADASTROS_OFILTES():NEW()
	oClone:cCCFOP               := ::cCCFOP
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTES             := ::cCCODTES
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILTES
	Local cSoap := ""
	cSoap += WSSoapValue("CCFOP", ::cCCFOP, ::cCCFOP , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODTES", ::cCCODTES, ::cCCODTES , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOTES

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOTES
	WSDATA   oWSOTES                   AS OUNIWSCADASTROS_OTES OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOTES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOTES
	::oWSOTES              := {} // Array Of  OUNIWSCADASTROS_OTES():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOTES
	Local oClone := OUNIWSCADASTROS_ARRAYOFOTES():NEW()
	oClone:oWSOTES := NIL
	If ::oWSOTES <> NIL
		oClone:oWSOTES := {}
		aEval( ::oWSOTES , { |x| aadd( oClone:oWSOTES , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOTES
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OTES","OTES",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOTES , OUNIWSCADASTROS_OTES():New() )
			::oWSOTES[len(::oWSOTES)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILTRANSPORTADORA

WSSTRUCT OUNIWSCADASTROS_OFILTRANSPORTADORA
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTRANSPORTADORA       AS string
	WSDATA   cCUF                      AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILTRANSPORTADORA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILTRANSPORTADORA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILTRANSPORTADORA
	Local oClone := OUNIWSCADASTROS_OFILTRANSPORTADORA():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTRANSPORTADORA  := ::cCCODTRANSPORTADORA
	oClone:cCUF                 := ::cCUF
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILTRANSPORTADORA
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODTRANSPORTADORA", ::cCCODTRANSPORTADORA, ::cCCODTRANSPORTADORA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CUF", ::cCUF, ::cCUF , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOTRANSPORTADORA

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA
	WSDATA   oWSOTRANSPORTADORA        AS OUNIWSCADASTROS_OTRANSPORTADORA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA
	::oWSOTRANSPORTADORA   := {} // Array Of  OUNIWSCADASTROS_OTRANSPORTADORA():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA
	Local oClone := OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA():NEW()
	oClone:oWSOTRANSPORTADORA := NIL
	If ::oWSOTRANSPORTADORA <> NIL
		oClone:oWSOTRANSPORTADORA := {}
		aEval( ::oWSOTRANSPORTADORA , { |x| aadd( oClone:oWSOTRANSPORTADORA , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOTRANSPORTADORA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OTRANSPORTADORA","OTRANSPORTADORA",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOTRANSPORTADORA , OUNIWSCADASTROS_OTRANSPORTADORA():New() )
			::oWSOTRANSPORTADORA[len(::oWSOTRANSPORTADORA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OFILVENDEDOR

WSSTRUCT OUNIWSCADASTROS_OFILVENDEDOR
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODVENDEDOR             AS string
	WSDATA   cCGERENTE                 AS string
	WSDATA   cCSUPERVISOR              AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OFILVENDEDOR
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OFILVENDEDOR
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OFILVENDEDOR
	Local oClone := OUNIWSCADASTROS_OFILVENDEDOR():NEW()
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODVENDEDOR        := ::cCCODVENDEDOR
	oClone:cCGERENTE            := ::cCGERENTE
	oClone:cCSUPERVISOR         := ::cCSUPERVISOR
Return oClone

WSMETHOD SOAPSEND WSCLIENT OUNIWSCADASTROS_OFILVENDEDOR
	Local cSoap := ""
	cSoap += WSSoapValue("CCODEMPRESA", ::cCCODEMPRESA, ::cCCODEMPRESA , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODFILIAL", ::cCCODFILIAL, ::cCCODFILIAL , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CCODVENDEDOR", ::cCCODVENDEDOR, ::cCCODVENDEDOR , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CGERENTE", ::cCGERENTE, ::cCGERENTE , "string", .T. , .F., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("CSUPERVISOR", ::cCSUPERVISOR, ::cCSUPERVISOR , "string", .T. , .F., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ARRAYOFOVENDEDOR

WSSTRUCT OUNIWSCADASTROS_ARRAYOFOVENDEDOR
	WSDATA   oWSOVENDEDOR              AS OUNIWSCADASTROS_OVENDEDOR OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ARRAYOFOVENDEDOR
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ARRAYOFOVENDEDOR
	::oWSOVENDEDOR         := {} // Array Of  OUNIWSCADASTROS_OVENDEDOR():New()
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ARRAYOFOVENDEDOR
	Local oClone := OUNIWSCADASTROS_ARRAYOFOVENDEDOR():NEW()
	oClone:oWSOVENDEDOR := NIL
	If ::oWSOVENDEDOR <> NIL
		oClone:oWSOVENDEDOR := {}
		aEval( ::oWSOVENDEDOR , { |x| aadd( oClone:oWSOVENDEDOR , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ARRAYOFOVENDEDOR
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNodes1 :=  WSAdvValue( oResponse,"_OVENDEDOR","OVENDEDOR",{},NIL,.T.,"O",NIL,NIL)
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOVENDEDOR , OUNIWSCADASTROS_OVENDEDOR():New() )
			::oWSOVENDEDOR[len(::oWSOVENDEDOR)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OBANCO

WSSTRUCT OUNIWSCADASTROS_OBANCO
	WSDATA   cCAGENCIA                 AS string
	WSDATA   cCBANCO                   AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCONTA                   AS string
	WSDATA   cCNOME                    AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OBANCO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OBANCO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OBANCO
	Local oClone := OUNIWSCADASTROS_OBANCO():NEW()
	oClone:cCAGENCIA            := ::cCAGENCIA
	oClone:cCBANCO              := ::cCBANCO
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCONTA              := ::cCCONTA
	oClone:cCNOME               := ::cCNOME
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OBANCO
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCAGENCIA          :=  WSAdvValue( oResponse,"_CAGENCIA","string",NIL,"Property cCAGENCIA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCBANCO            :=  WSAdvValue( oResponse,"_CBANCO","string",NIL,"Property cCBANCO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCONTA            :=  WSAdvValue( oResponse,"_CCONTA","string",NIL,"Property cCCONTA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCNOME             :=  WSAdvValue( oResponse,"_CNOME","string",NIL,"Property cCNOME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OCABECALHOTABELAPRECO

WSSTRUCT OUNIWSCADASTROS_OCABECALHOTABELAPRECO
	WSDATA   cCATIVA                   AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTABELA               AS string
	WSDATA   cCCONDPAGTO               AS string
	WSDATA   cCDATAFINAL               AS string
	WSDATA   cCDATAINICIO              AS string
	WSDATA   cCDESCTABELA              AS string
	WSDATA   cCHORAFINAL               AS string
	WSDATA   cCHORAINICIO              AS string
	WSDATA   cCTIPOHORARIO             AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OCABECALHOTABELAPRECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OCABECALHOTABELAPRECO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OCABECALHOTABELAPRECO
	Local oClone := OUNIWSCADASTROS_OCABECALHOTABELAPRECO():NEW()
	oClone:cCATIVA              := ::cCATIVA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTABELA          := ::cCCODTABELA
	oClone:cCCONDPAGTO          := ::cCCONDPAGTO
	oClone:cCDATAFINAL          := ::cCDATAFINAL
	oClone:cCDATAINICIO         := ::cCDATAINICIO
	oClone:cCDESCTABELA         := ::cCDESCTABELA
	oClone:cCHORAFINAL          := ::cCHORAFINAL
	oClone:cCHORAINICIO         := ::cCHORAINICIO
	oClone:cCTIPOHORARIO        := ::cCTIPOHORARIO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OCABECALHOTABELAPRECO
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCATIVA            :=  WSAdvValue( oResponse,"_CATIVA","string",NIL,"Property cCATIVA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODTABELA        :=  WSAdvValue( oResponse,"_CCODTABELA","string",NIL,"Property cCCODTABELA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCONDPAGTO        :=  WSAdvValue( oResponse,"_CCONDPAGTO","string",NIL,"Property cCCONDPAGTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDATAFINAL        :=  WSAdvValue( oResponse,"_CDATAFINAL","string",NIL,"Property cCDATAFINAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDATAINICIO       :=  WSAdvValue( oResponse,"_CDATAINICIO","string",NIL,"Property cCDATAINICIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCTABELA       :=  WSAdvValue( oResponse,"_CDESCTABELA","string",NIL,"Property cCDESCTABELA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCHORAFINAL        :=  WSAdvValue( oResponse,"_CHORAFINAL","string",NIL,"Property cCHORAFINAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCHORAINICIO       :=  WSAdvValue( oResponse,"_CHORAINICIO","string",NIL,"Property cCHORAINICIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPOHORARIO      :=  WSAdvValue( oResponse,"_CTIPOHORARIO","string",NIL,"Property cCTIPOHORARIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OCATEGORIA

WSSTRUCT OUNIWSCADASTROS_OCATEGORIA
	WSDATA   cCCODCATEGORIA            AS string
	WSDATA   cCCODDEPARTAMENTO         AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCDESCCATEGORIA           AS string
	WSDATA   cCDESCDEPARTAMENTO        AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OCATEGORIA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OCATEGORIA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OCATEGORIA
	Local oClone := OUNIWSCADASTROS_OCATEGORIA():NEW()
	oClone:cCCODCATEGORIA       := ::cCCODCATEGORIA
	oClone:cCCODDEPARTAMENTO    := ::cCCODDEPARTAMENTO
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCDESCCATEGORIA      := ::cCDESCCATEGORIA
	oClone:cCDESCDEPARTAMENTO   := ::cCDESCDEPARTAMENTO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OCATEGORIA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCODCATEGORIA     :=  WSAdvValue( oResponse,"_CCODCATEGORIA","string",NIL,"Property cCCODCATEGORIA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODDEPARTAMENTO  :=  WSAdvValue( oResponse,"_CCODDEPARTAMENTO","string",NIL,"Property cCCODDEPARTAMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCCATEGORIA    :=  WSAdvValue( oResponse,"_CDESCCATEGORIA","string",NIL,"Property cCDESCCATEGORIA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCDEPARTAMENTO :=  WSAdvValue( oResponse,"_CDESCDEPARTAMENTO","string",NIL,"Property cCDESCDEPARTAMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OCONDICAOPAGAMENTO

WSSTRUCT OUNIWSCADASTROS_OCONDICAOPAGAMENTO
	WSDATA   cCCODIGO                  AS string
	WSDATA   cCCONDPAGAMENTO           AS string
	WSDATA   cCDESCRICAO               AS string
	WSDATA   cCFORMAPAGTO              AS string
	WSDATA   cCSTATUS                  AS string
	WSDATA   cCTIPO                    AS string
	WSDATA   nNTXACRESCIMO             AS float
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OCONDICAOPAGAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OCONDICAOPAGAMENTO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OCONDICAOPAGAMENTO
	Local oClone := OUNIWSCADASTROS_OCONDICAOPAGAMENTO():NEW()
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCCONDPAGAMENTO      := ::cCCONDPAGAMENTO
	oClone:cCDESCRICAO          := ::cCDESCRICAO
	oClone:cCFORMAPAGTO         := ::cCFORMAPAGTO
	oClone:cCSTATUS             := ::cCSTATUS
	oClone:cCTIPO               := ::cCTIPO
	oClone:nNTXACRESCIMO        := ::nNTXACRESCIMO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OCONDICAOPAGAMENTO
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCODIGO           :=  WSAdvValue( oResponse,"_CCODIGO","string",NIL,"Property cCCODIGO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCONDPAGAMENTO    :=  WSAdvValue( oResponse,"_CCONDPAGAMENTO","string",NIL,"Property cCCONDPAGAMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCRICAO        :=  WSAdvValue( oResponse,"_CDESCRICAO","string",NIL,"Property cCDESCRICAO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCFORMAPAGTO       :=  WSAdvValue( oResponse,"_CFORMAPAGTO","string",NIL,"Property cCFORMAPAGTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCSTATUS           :=  WSAdvValue( oResponse,"_CSTATUS","string",NIL,"Property cCSTATUS as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPO             :=  WSAdvValue( oResponse,"_CTIPO","string",NIL,"Property cCTIPO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::nNTXACRESCIMO      :=  WSAdvValue( oResponse,"_NTXACRESCIMO","float",NIL,"Property nNTXACRESCIMO as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
Return

// WSDL Data Structure ODEPARTAMENTO

WSSTRUCT OUNIWSCADASTROS_ODEPARTAMENTO
	WSDATA   cCCODDEPARTAMENTO         AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCDESCDEPARTAMENTO        AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ODEPARTAMENTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ODEPARTAMENTO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ODEPARTAMENTO
	Local oClone := OUNIWSCADASTROS_ODEPARTAMENTO():NEW()
	oClone:cCCODDEPARTAMENTO    := ::cCCODDEPARTAMENTO
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCDESCDEPARTAMENTO   := ::cCDESCDEPARTAMENTO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ODEPARTAMENTO
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCODDEPARTAMENTO  :=  WSAdvValue( oResponse,"_CCODDEPARTAMENTO","string",NIL,"Property cCCODDEPARTAMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCDEPARTAMENTO :=  WSAdvValue( oResponse,"_CDESCDEPARTAMENTO","string",NIL,"Property cCDESCDEPARTAMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OEMPRESA

WSSTRUCT OUNIWSCADASTROS_OEMPRESA
	WSDATA   cCCGC                     AS string
	WSDATA   cCCODEMPRESA              AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCNOMEFILIAL              AS string
	WSDATA   cCRAZAOSOCIAL             AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OEMPRESA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OEMPRESA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OEMPRESA
	Local oClone := OUNIWSCADASTROS_OEMPRESA():NEW()
	oClone:cCCGC                := ::cCCGC
	oClone:cCCODEMPRESA         := ::cCCODEMPRESA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCNOMEFILIAL         := ::cCNOMEFILIAL
	oClone:cCRAZAOSOCIAL        := ::cCRAZAOSOCIAL
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OEMPRESA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCGC              :=  WSAdvValue( oResponse,"_CCGC","string",NIL,"Property cCCGC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODEMPRESA       :=  WSAdvValue( oResponse,"_CCODEMPRESA","string",NIL,"Property cCCODEMPRESA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCNOMEFILIAL       :=  WSAdvValue( oResponse,"_CNOMEFILIAL","string",NIL,"Property cCNOMEFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCRAZAOSOCIAL      :=  WSAdvValue( oResponse,"_CRAZAOSOCIAL","string",NIL,"Property cCRAZAOSOCIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OITENSTABELAPRECO

WSSTRUCT OUNIWSCADASTROS_OITENSTABELAPRECO
	WSDATA   cCATIVO                   AS string
	WSDATA   cCCODDEPARTAMENTO         AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODPRODUTO              AS string
	WSDATA   cCCODTABELA               AS string
	WSDATA   cCESTADO                  AS string
	WSDATA   cCITEM                    AS string
	WSDATA   cCTIPOOPERACAO            AS string
	WSDATA   cCTIPOPRECO               AS string
	WSDATA   nNFRETE                   AS float
	WSDATA   nNPERCDESCONTO            AS float
	WSDATA   nNPRECOMAXIMO             AS float
	WSDATA   nNPRECOVENDA              AS float
	WSDATA   nNVALORDESCONTO           AS float
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OITENSTABELAPRECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OITENSTABELAPRECO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OITENSTABELAPRECO
	Local oClone := OUNIWSCADASTROS_OITENSTABELAPRECO():NEW()
	oClone:cCATIVO              := ::cCATIVO
	oClone:cCCODDEPARTAMENTO    := ::cCCODDEPARTAMENTO
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODPRODUTO         := ::cCCODPRODUTO
	oClone:cCCODTABELA          := ::cCCODTABELA
	oClone:cCESTADO             := ::cCESTADO
	oClone:cCITEM               := ::cCITEM
	oClone:cCTIPOOPERACAO       := ::cCTIPOOPERACAO
	oClone:cCTIPOPRECO          := ::cCTIPOPRECO
	oClone:nNFRETE              := ::nNFRETE
	oClone:nNPERCDESCONTO       := ::nNPERCDESCONTO
	oClone:nNPRECOMAXIMO        := ::nNPRECOMAXIMO
	oClone:nNPRECOVENDA         := ::nNPRECOVENDA
	oClone:nNVALORDESCONTO      := ::nNVALORDESCONTO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OITENSTABELAPRECO
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCATIVO            :=  WSAdvValue( oResponse,"_CATIVO","string",NIL,"Property cCATIVO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODDEPARTAMENTO  :=  WSAdvValue( oResponse,"_CCODDEPARTAMENTO","string",NIL,"Property cCCODDEPARTAMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODPRODUTO       :=  WSAdvValue( oResponse,"_CCODPRODUTO","string",NIL,"Property cCCODPRODUTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODTABELA        :=  WSAdvValue( oResponse,"_CCODTABELA","string",NIL,"Property cCCODTABELA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCESTADO           :=  WSAdvValue( oResponse,"_CESTADO","string",NIL,"Property cCESTADO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCITEM             :=  WSAdvValue( oResponse,"_CITEM","string",NIL,"Property cCITEM as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPOOPERACAO     :=  WSAdvValue( oResponse,"_CTIPOOPERACAO","string",NIL,"Property cCTIPOOPERACAO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPOPRECO        :=  WSAdvValue( oResponse,"_CTIPOPRECO","string",NIL,"Property cCTIPOPRECO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::nNFRETE            :=  WSAdvValue( oResponse,"_NFRETE","float",NIL,"Property nNFRETE as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
	::nNPERCDESCONTO     :=  WSAdvValue( oResponse,"_NPERCDESCONTO","float",NIL,"Property nNPERCDESCONTO as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
	::nNPRECOMAXIMO      :=  WSAdvValue( oResponse,"_NPRECOMAXIMO","float",NIL,"Property nNPRECOMAXIMO as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
	::nNPRECOVENDA       :=  WSAdvValue( oResponse,"_NPRECOVENDA","float",NIL,"Property nNPRECOVENDA as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
	::nNVALORDESCONTO    :=  WSAdvValue( oResponse,"_NVALORDESCONTO","float",NIL,"Property nNVALORDESCONTO as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
Return

// WSDL Data Structure OLINHA

WSSTRUCT OUNIWSCADASTROS_OLINHA
	WSDATA   cCCODCATEGORIA            AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODLINHA                AS string
	WSDATA   cCDESCATEGORIA            AS string
	WSDATA   cCDESCLINHA               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OLINHA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OLINHA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OLINHA
	Local oClone := OUNIWSCADASTROS_OLINHA():NEW()
	oClone:cCCODCATEGORIA       := ::cCCODCATEGORIA
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODLINHA           := ::cCCODLINHA
	oClone:cCDESCATEGORIA       := ::cCDESCATEGORIA
	oClone:cCDESCLINHA          := ::cCDESCLINHA
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OLINHA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCODCATEGORIA     :=  WSAdvValue( oResponse,"_CCODCATEGORIA","string",NIL,"Property cCCODCATEGORIA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODLINHA         :=  WSAdvValue( oResponse,"_CCODLINHA","string",NIL,"Property cCCODLINHA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCATEGORIA     :=  WSAdvValue( oResponse,"_CDESCATEGORIA","string",NIL,"Property cCDESCATEGORIA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCLINHA        :=  WSAdvValue( oResponse,"_CDESCLINHA","string",NIL,"Property cCDESCLINHA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OMUNICIPIO

WSSTRUCT OUNIWSCADASTROS_OMUNICIPIO
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODMUNICIPIO            AS string
	WSDATA   cCDESCMUNICIPIO           AS string
	WSDATA   cCESTADO                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OMUNICIPIO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OMUNICIPIO
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OMUNICIPIO
	Local oClone := OUNIWSCADASTROS_OMUNICIPIO():NEW()
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODMUNICIPIO       := ::cCCODMUNICIPIO
	oClone:cCDESCMUNICIPIO      := ::cCDESCMUNICIPIO
	oClone:cCESTADO             := ::cCESTADO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OMUNICIPIO
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODMUNICIPIO     :=  WSAdvValue( oResponse,"_CCODMUNICIPIO","string",NIL,"Property cCCODMUNICIPIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCMUNICIPIO    :=  WSAdvValue( oResponse,"_CDESCMUNICIPIO","string",NIL,"Property cCDESCMUNICIPIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCESTADO           :=  WSAdvValue( oResponse,"_CESTADO","string",NIL,"Property cCESTADO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure ONATUREZA

WSSTRUCT OUNIWSCADASTROS_ONATUREZA
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODNATUREZA             AS string
	WSDATA   cCDESCNATUREZA            AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_ONATUREZA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_ONATUREZA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_ONATUREZA
	Local oClone := OUNIWSCADASTROS_ONATUREZA():NEW()
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODNATUREZA        := ::cCCODNATUREZA
	oClone:cCDESCNATUREZA       := ::cCDESCNATUREZA
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_ONATUREZA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODNATUREZA      :=  WSAdvValue( oResponse,"_CCODNATUREZA","string",NIL,"Property cCCODNATUREZA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCNATUREZA     :=  WSAdvValue( oResponse,"_CDESCNATUREZA","string",NIL,"Property cCDESCNATUREZA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OPARCELA

WSSTRUCT OUNIWSCADASTROS_OPARCELA
	WSDATA   cCDATAPARCELA             AS string
	WSDATA   nNVALORPARCELA            AS float
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OPARCELA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OPARCELA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OPARCELA
	Local oClone := OUNIWSCADASTROS_OPARCELA():NEW()
	oClone:cCDATAPARCELA        := ::cCDATAPARCELA
	oClone:nNVALORPARCELA       := ::nNVALORPARCELA
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OPARCELA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCDATAPARCELA      :=  WSAdvValue( oResponse,"_CDATAPARCELA","string",NIL,"Property cCDATAPARCELA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::nNVALORPARCELA     :=  WSAdvValue( oResponse,"_NVALORPARCELA","float",NIL,"Property nNVALORPARCELA as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
Return

// WSDL Data Structure OTABELAGENERICA

WSSTRUCT OUNIWSCADASTROS_OTABELAGENERICA
	WSDATA   cCCHAVE                   AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTABELA               AS string
	WSDATA   cCDESCESPANHOL            AS string
	WSDATA   cCDESCINGLES              AS string
	WSDATA   cCDESCPORTUGUES           AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OTABELAGENERICA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OTABELAGENERICA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OTABELAGENERICA
	Local oClone := OUNIWSCADASTROS_OTABELAGENERICA():NEW()
	oClone:cCCHAVE              := ::cCCHAVE
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTABELA          := ::cCCODTABELA
	oClone:cCDESCESPANHOL       := ::cCDESCESPANHOL
	oClone:cCDESCINGLES         := ::cCDESCINGLES
	oClone:cCDESCPORTUGUES      := ::cCDESCPORTUGUES
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OTABELAGENERICA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCHAVE            :=  WSAdvValue( oResponse,"_CCHAVE","string",NIL,"Property cCCHAVE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODTABELA        :=  WSAdvValue( oResponse,"_CCODTABELA","string",NIL,"Property cCCODTABELA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCESPANHOL     :=  WSAdvValue( oResponse,"_CDESCESPANHOL","string",NIL,"Property cCDESCESPANHOL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCINGLES       :=  WSAdvValue( oResponse,"_CDESCINGLES","string",NIL,"Property cCDESCINGLES as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCPORTUGUES    :=  WSAdvValue( oResponse,"_CDESCPORTUGUES","string",NIL,"Property cCDESCPORTUGUES as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OTES

WSSTRUCT OUNIWSCADASTROS_OTES
	WSDATA   cCCFOP                    AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODIGOTES               AS string
	WSDATA   cCDESCRICAO               AS string
	WSDATA   cCTIPO                    AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OTES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OTES
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OTES
	Local oClone := OUNIWSCADASTROS_OTES():NEW()
	oClone:cCCFOP               := ::cCCFOP
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODIGOTES          := ::cCCODIGOTES
	oClone:cCDESCRICAO          := ::cCDESCRICAO
	oClone:cCTIPO               := ::cCTIPO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OTES
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCFOP             :=  WSAdvValue( oResponse,"_CCFOP","string",NIL,"Property cCCFOP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODIGOTES        :=  WSAdvValue( oResponse,"_CCODIGOTES","string",NIL,"Property cCCODIGOTES as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCDESCRICAO        :=  WSAdvValue( oResponse,"_CDESCRICAO","string",NIL,"Property cCDESCRICAO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPO             :=  WSAdvValue( oResponse,"_CTIPO","string",NIL,"Property cCTIPO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OTRANSPORTADORA

WSSTRUCT OUNIWSCADASTROS_OTRANSPORTADORA
	WSDATA   cCCNPJ                    AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODTRANSPORTADORA       AS string
	WSDATA   cCNOMEREDUZIDO            AS string
	WSDATA   cCNOMETRANSPORTADORA      AS string
	WSDATA   cCUF                      AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OTRANSPORTADORA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OTRANSPORTADORA
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OTRANSPORTADORA
	Local oClone := OUNIWSCADASTROS_OTRANSPORTADORA():NEW()
	oClone:cCCNPJ               := ::cCCNPJ
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODTRANSPORTADORA  := ::cCCODTRANSPORTADORA
	oClone:cCNOMEREDUZIDO       := ::cCNOMEREDUZIDO
	oClone:cCNOMETRANSPORTADORA := ::cCNOMETRANSPORTADORA
	oClone:cCUF                 := ::cCUF
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OTRANSPORTADORA
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCNPJ             :=  WSAdvValue( oResponse,"_CCNPJ","string",NIL,"Property cCCNPJ as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODTRANSPORTADORA :=  WSAdvValue( oResponse,"_CCODTRANSPORTADORA","string",NIL,"Property cCCODTRANSPORTADORA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCNOMEREDUZIDO     :=  WSAdvValue( oResponse,"_CNOMEREDUZIDO","string",NIL,"Property cCNOMEREDUZIDO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCNOMETRANSPORTADORA :=  WSAdvValue( oResponse,"_CNOMETRANSPORTADORA","string",NIL,"Property cCNOMETRANSPORTADORA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCUF               :=  WSAdvValue( oResponse,"_CUF","string",NIL,"Property cCUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure OVENDEDOR

WSSTRUCT OUNIWSCADASTROS_OVENDEDOR
	WSDATA   cCCARGO                   AS string
	WSDATA   cCCNPJ                    AS string
	WSDATA   cCCODFILIAL               AS string
	WSDATA   cCCODVENDEDOR             AS string
	WSDATA   cCGERENTE                 AS string
	WSDATA   cCNOMEREDUZIDO            AS string
	WSDATA   cCNOMEVENDEDOR            AS string
	WSDATA   cCSUPERVISOR              AS string
	WSDATA   cCTIPOPESSOA              AS string
	WSDATA   cCTIPOVENDEDOR            AS string
	WSDATA   nNCOMISSAO                AS float
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT OUNIWSCADASTROS_OVENDEDOR
	::Init()
Return Self

WSMETHOD INIT WSCLIENT OUNIWSCADASTROS_OVENDEDOR
Return

WSMETHOD CLONE WSCLIENT OUNIWSCADASTROS_OVENDEDOR
	Local oClone := OUNIWSCADASTROS_OVENDEDOR():NEW()
	oClone:cCCARGO              := ::cCCARGO
	oClone:cCCNPJ               := ::cCCNPJ
	oClone:cCCODFILIAL          := ::cCCODFILIAL
	oClone:cCCODVENDEDOR        := ::cCCODVENDEDOR
	oClone:cCGERENTE            := ::cCGERENTE
	oClone:cCNOMEREDUZIDO       := ::cCNOMEREDUZIDO
	oClone:cCNOMEVENDEDOR       := ::cCNOMEVENDEDOR
	oClone:cCSUPERVISOR         := ::cCSUPERVISOR
	oClone:cCTIPOPESSOA         := ::cCTIPOPESSOA
	oClone:cCTIPOVENDEDOR       := ::cCTIPOVENDEDOR
	oClone:nNCOMISSAO           := ::nNCOMISSAO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT OUNIWSCADASTROS_OVENDEDOR
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cCCARGO            :=  WSAdvValue( oResponse,"_CCARGO","string",NIL,"Property cCCARGO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCNPJ             :=  WSAdvValue( oResponse,"_CCNPJ","string",NIL,"Property cCCNPJ as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODFILIAL        :=  WSAdvValue( oResponse,"_CCODFILIAL","string",NIL,"Property cCCODFILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCCODVENDEDOR      :=  WSAdvValue( oResponse,"_CCODVENDEDOR","string",NIL,"Property cCCODVENDEDOR as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCGERENTE          :=  WSAdvValue( oResponse,"_CGERENTE","string",NIL,"Property cCGERENTE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCNOMEREDUZIDO     :=  WSAdvValue( oResponse,"_CNOMEREDUZIDO","string",NIL,"Property cCNOMEREDUZIDO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCNOMEVENDEDOR     :=  WSAdvValue( oResponse,"_CNOMEVENDEDOR","string",NIL,"Property cCNOMEVENDEDOR as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCSUPERVISOR       :=  WSAdvValue( oResponse,"_CSUPERVISOR","string",NIL,"Property cCSUPERVISOR as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPOPESSOA       :=  WSAdvValue( oResponse,"_CTIPOPESSOA","string",NIL,"Property cCTIPOPESSOA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cCTIPOVENDEDOR     :=  WSAdvValue( oResponse,"_CTIPOVENDEDOR","string",NIL,"Property cCTIPOVENDEDOR as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::nNCOMISSAO         :=  WSAdvValue( oResponse,"_NCOMISSAO","float",NIL,"Property nNCOMISSAO as s:float on SOAP Response not found.",NIL,"N",NIL,NIL)
Return
