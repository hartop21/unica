//-----------------------------------*
/*/{Protheus.doc} UNIWS003

@project Integração Protheus x Fluig
@description Implementação de WebService para permitir a Integração do Fluig com o Protheus.
@wsdl http://192.168.0.225:9901/OWSUNICA.apw?WSDL
@author Rafael Rezende
@since 25/02/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/

#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"
#Include "ApWebSrv.ch"
#Include "XMLxFun.ch"

#DEFINE _cEnt Chr(10)+ Chr(13) // ---- LEANDRO RIBEIRO ---- 10/12/2019 ---- //

// Classe para a Integração do Cadastro de orçamentos de Vendas
WSService oWSUnica Description "WebService de Integração do Fluig com o Protheus"

	WSData cCodigoEmpresa		As String
	WSData cCodigoFilial		As String
	WSData cListEmpFiliais		As String
	WSData cListProdutos		As String
	WSData cListGrupos			As String
	WSData cListCategorias		As String
	WSData cListLinhas			As String
	WSData cListDescricao		As String
	WSData cListFab				As String
	WSData cListCapac			As String
	WSData cListVolt			As String
	WSData cParamCPFCNPJ		As String
	WSData cParamVendedor		As String
	WSData cParamCidade			As String
	WSData cParamEstado			As String
	WSData cAlterEmpFiliais 	As String
	WSData cAlterProdutos 		As String
	WSData cLojaCliente			As String
	WSData oCliente 			As oStructOrcCliente
	WSData oOrcamentoVenda 		As oStructOrcamentoVenda
	WSData oListaProdutos 		As oStructListaProdutos
	WSData oListaAlternativos 	As oStructListaProdutos
	WSData oListaClientes 		As oStructListaClientes
	WSData cRetornoWS			As String
	WSData oPrecoVenda		As oPrecoVenda
	WSData cTabelaPreco			As String
	WSData cProduto				As String
	WSData nQuant				As float
	WSData cCliente				As String
	WSData cLoja				As String
	WSData cCondPg				As String
	WSMethod EnviaCadastroCliente		Description "Método para permitir a inclusão / alteração de um Cadastro de Clientes"
	WSMethod EnviaOrcamentoVenda   		Description "Método para permitir a inclusão / alteração de um Orçamento de Vendas no Protheus"
	WSMethod ListaCadastroProdutos 		Description "Método para permitir a consulta ao Cadastro de Produtos no Protheus"
	WSMethod ListaProdutosAlternativos 	Description "Método para permitir a consulta de Produtos Alternativos"
	WSMethod ListaCadastroClientes		Description "Método para permitir a Consulta ao Cadastro de Clientes"
	WSMethod precoVenda					Description "Método para permitir a Consulta ao Preço de Venda do produto"

EndWSService

WSStruct oStructOrcamentoVenda

	WSData cNumOrcamento		As String
	WsData cDataOrcamento		As String
	WsData cDataValidade		As String
	WSData cCodigoVendedor1		As String
	WSData cCodigoVendedor2		As String
	WSData cCodigoVendedor3		As String
	WSData cCondicaoPagamento	As String
	WSData cTransportadora		As String
	WSData cTabelaPreco			As String
	WSData cReservaEstoque		As String
	WSData cFilialReserva		As String
	WSData cObservacao			As String
	WSData nValorTotal			As Float
	WSData nValorFrete			As Float
	WSData nPercentualJuros		As Float
	WSData nValorAcrescimo		As Float
	WSData oCliente 			As oStructOrcCliente
	WSData oCondicaoPagamento	As oStructFormaPagamento
	WSData aItensOrcamento  	As Array Of oStructItemOrcamento

EndWSStruct

WSStruct oStructListaClientes

	WSData cRetornoWS			As String
	WSData aListaClientes 		As Array Of oStructConCliente

EndWSStruct

WSStruct oStructConCliente

	WSData cCodigoCliente 		As String
	WSData cLojaCliente 		As String
	WSData cCPF_CNPJ			As String
	WSData cTipoPessoa			As String // F=Fisica | J=Jurídica
	WSData cNomeCompleto		As String
	WSData cNomeReduzido		As String
	WSData cTipoCliente			As String // Final?
	WSData cContato 			As String
	WSData cDataNascimento	    As String

	WSData cRegiao				As String
	WSData cRGCedEstr			As String
	WSData cInscrEstadual		As String
	WSData cInscrMunicipal		As String
	WSData cEmail				As String
	WSData cHomePage			As String
	WSData cStatus 				As String

	WSData cNatureza			As String
	WSData cEndCentralCompras   As String
	WSData cVendedor 			As String
	WSData nComissao 			As Float
	WSData cContaContabil		As String
	WSData cBanco 				As String
	WSData cTipoFrete			As String
	WSData cTipoPJ				As String
	WSData cTransportadora		As String
	WSData cCondicaoPagamento	As String
	WSData cTabelaPreco			As String

	//	WSData cDDI					As String
	WSData cDDD					As String
	WSData cTelefone			As String
	WSData cFax					As String

	WSData cContrib				As String
	WSData cEntId				As String

	//	WSData cIdFluig				As String
	WsData aEnderecos			As Array Of oStructEndereco
	//WsData oEnderercoPrincipal 	As oStructEndereco
	//WsData oEnderercoCobranca 	As oStructEndereco
	//WSData oEnderercoEntrega 	As oStructEndereco

EndWSStruct

WSStruct oStructOrcCliente

	WSData cCodigoCliente 		As String
	WSData cLojaCliente 		As String
	WSData cCPF_CNPJ			As String
	WSData cTipoPessoa			As String // F=Fisica | J=Jurídica
	WSData cNomeCompleto		As String
	WSData cNomeReduzido		As String
	WSData cTipoCliente			As String // Final?
	WSData cContato 			As String
	WSData cDataNascimento	    As String

	WSData cRegiao				As String
	WSData cRGCedEstr			As String
	WSData cInscrEstadual		As String
	WSData cInscrMunicipal		As String
	WSData cEmail				As String
	WSData cHomePage			As String
	WSData cStatus 				As String

	WSData cNatureza			As String
	WSData cEndCentralCompras   As String
	WSData cVendedor 			As String
	WSData nComissao 			As Float
	WSData cContaContabil		As String
	WSData cBanco 				As String
	WSData cTipoFrete			As String
	WSData cTipoPJ				As String
	WSData cTransportadora		As String
	WSData cCondicaoPagamento	As String
	WSData cTabelaPreco			As String

	//	WSData cDDI					As String
	WSData cDDD					As String
	WSData cTelefone			As String
	WSData cFax					As String

	WSData cContrib				As String
	WSData cEntId				As String

	//	WSData cIdFluig				As String
	WsData oEnderercoPrincipal 	As oStructEndereco
	WsData oEnderercoCobranca 	As oStructEndereco
	WSData oEnderercoEntrega 	As oStructEndereco

EndWSStruct


WSStruct oStructEndereco

	WSData cTipoEndereco		As String //P=Principal | C=Cobrança | E=Entrega
	WSData cLogradouro 			As String
	WSData cComplemento 		As String
	WSData cBairro				As String
	WSData cCodigoMunicipio 	As String
	WSData cNomeMunicipio		As String
	WSData cEstado 				As String
	WSData cUF					As String
	WSData cCodigoPais	 		As String
	WSData cPais				As String
	WSData cCEP		 			As String

EndWSStruct

WSStruct oStructItemOrcamento

	WSData cSequencia 			As String
	WSData cCodigoProduto  		As String
	WSData cNomeProduto  		As String
	WSData cLocal 				As String
	WSData cUnidadeMedida		As String
	WSData cTES 				As String
	WSData cCF					As String
	WSData cDataEntrega 		As String
	WSData cTabela 				As String
	WSData cCodigoVendedor		As String
	//WSData cIdFluig			As String
	//WSData cSKU				As String
	WSData nQuantidade 			As Float
	WSData nValorUnitario		As Float
	WSData nSubTotal			As Float
	WSData nPercentualDesconto	As Float
	WSData nValorDesconto		As Float
	WSData cEntrega				As String

EndWSStruct

WSStruct oStructFormaPagamento

	WSData nValorOrcamento		As Float
	WSData cFormaPagamento		As String
	WSData cAdministradora 		As String
	WSData cIdFormaPagamento	As String
	WSData nCodigoMoeda			As Integer

EndWSStruct

WSStruct oStructListaProdutos

	WSData cRetornoWS			As String
	WSData aListaProdutos 		As Array Of oStructProduto

EndWSStruct

WSStruct oStructProduto

	//WSData cWSB1_EMPRESA		As String    		// 01-Empresa
	//WSData cWSB1_FILIAL 		As String    		// 02-Filial
	WSData cWSB1_COD    		As String    		// 01-Codigo
	WSData cWSB1_DESC   		As String    		// 02-Descricao
	WSData cWSB1_TIPO   		As String    		// 03-Tipo
	WSData cWSB1_UM     		As String    		// 04-Unidade
	WSData cWSB1_LOCPAD 		As String    		// 05-Armazem Pad.
	WSData cWSB1_GRUPO  		As String    		// 06-Grupo
	WSData cWSBM_DESC	  		As String    		// 07-Descrição do Grupo
	WSData cWSB1_CATEGOR  		As String    		// 08-Categoria
	WSData cWSZ1_DESC	  		As String    		// 09-Descrição da Categoria
	WSData cWSB1_LINHA  		As String    		// 10-Linha
	WSData cWSZ2_DESC	  		As String    		// 11-Descrição da Linha
	WSData nWSB1_PRV1   		As Float     		// 12-Preco Venda
	WSData nWSB1_PESO   	    As Float 			// 13-Peso Liquido
	WSData cWSB1_CODBAR 		As String    		// 14-Cod Barras
	WSData cWSB1_TS 			As String    		// 15-TES saída
	WSData cWSB1_ATIVO  		As String    		// 16-Ativo
	WSData cWSB1_XOBSERV  		As String    		// 17-Observação
	WSData CWSB1_XALERTA		As String			// 18-Alerta
	WSData aListaSaldo			As Array Of oStructSaldoProduto // 17-Saldo Atual
	WSData CWSB1_FABRIC			As String			// 18-Alerta
	WSData CWSB1_CAPACID		As String			// 18-Alerta
	WSData CWSB1_VOLTAGE		As String			// 18-Alerta

EndWSStruct

WSStruct oStructSaldoProduto

	WSData cEmpresaFilial		As String
	WSData cDescricao			As String
	WSData nSaldoAtual 			As Float
	WSData nSaldoStr 			As String

EndWSStruct


WSStruct oPrecoVenda

	WSData cRetornoWS			As String
	WSData nPrecoVenda	 		As Float

EndWSStruct


// Método da Classe para o Cadastro do orçamento no Protheus
WSMethod EnviaOrcamentoVenda WSReceive cCodigoEmpresa, cCodigoFilial, oOrcamentoVenda WSSend cRetornoWS  WSService oWsUnica

	Local cAuxNumOrcamento 		:= ""
	Local lCtrlPorLoja 			:= .T.
	Local lSsucesso 			:= .T.
	Local aItensOrc	 			:= {}
	Local aCabecalhoOrcamento	:= {}
	Local aItensOrcamento		:= {}
	Local aCondicoespagamento	:= {}
	Local nItem					:= 0
	Local nCondicao 			:= 0
	Local bError 				:= ErrorBlock( { |oError| cErro := oError:Description } )
	Local _aCondPag 			 // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
	Local nDesconto
	Local nTotPrcKT
	Local nPrcAcu

	Private cUserCaixa			:= ""
	Private cPswCaixa			:= ""
	Private cLojaReserva 		:= ""
	Private cAuxEntrega 		:= ""

	Private INCLUI      := .T. // Variavel necessária para o ExecAuto identificar que se trata de uma inclusão
	Private ALTERA      := .F. // Variavel necessária para o ExecAuto identificar que se trata de uma inclusão
	Private lMsHelpAuto := .T.		// ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
	Private lMsErroAuto := .F.      // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
	Private lAutoErrNoFile := .T.   // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //


	::cRetornoWS := "OK"

	ConOut( "________________________________ INICIO DO PROCESSO INCLUSAO DE ORCAMENTO DE VENDAS ________________________________")

	ConOut( "Abriu as tabelas..." )
	If Select( "SLQ" ) > 0
		ConOut( "ALIAS - SLQ" )
	EndIf
	If Select( "SLR" ) > 0
		ConOut( "ALIAS - SLR" )
	EndIf
	If Select( "SL1" ) > 0
		ConOut( "ALIAS - SL1" )
	EndIf
	If Select( "SL2" ) > 0
		ConOut( "ALIAS - SL2" )
	EndIf
	If Select( "SL4" ) > 0
		ConOut( "ALIAS - SL4" )
	EndIf
	If Select( "SA1" ) > 0
		ConOut( "ALIAS - SA1" )
	EndIf
	If Select( "SB1" ) > 0
		ConOut( "ALIAS - SB1" )
	EndIf
	If Select( "DA0" ) > 0
		ConOut( "ALIAS - DA0" )
	EndIf
	If Select( "DA1" ) > 0
		ConOut( "ALIAS - DA1" )
	EndIf
	If Select( "SA3" ) > 0
		ConOut( "ALIAS - SA3" )
	EndIf
	If Select( "SZ9" ) > 0
		ConOut( "ALIAS - SZ9" )
	EndIf

	//cEmpAnt 		:= ::cCodigoEmpresa
	cFilAnt 		:= ::cCodigoFilial

	DbSelectArea( "SZ9" )
	DbSetOrder( 01 ) // Z9_FILIAL + Z9_CODIGO
	Seek cFilAnt
	If !Found()

		lSucesso 					:= .F.
		::cRetornoWS := "Não encontrou a configuração no protheus para a Filial [ " + cFilAnt + " ]"
		SetSoapFault( "Não encontrou a configuração no protheus para a Filial [ " + cFilAnt + " ]", "", SOAPFAULT_RECEIVER )
		Return .F.

	Else

		ConOut( "Encontrou as Informações de Configuração para a Filial ETAPA 1")
		cUserCaixa		:= SZ9->Z9_USRCX
		cPswCaixa		:= SZ9->Z9_PSSCX
		//cLojaReserva 	:= SZ9->Z9_AUTRESE  // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
		cLojaReserva 	:= GetAdvFVal("SLJ","LJ_CODIGO",xFilial("SLJ")+"01"+::oOrcamentoVenda:cFilialReserva,3,"")   // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //

	EndIf

	If FExisteOrcamento( ::oOrcamentoVenda:cNumOrcamento )

		lSucesso := .F.
		::cRetornoWS := "O Pedido já existe no Protheus"
		SetSoapFault( "Erro no envio do Orçamento. " + "O Pedido já existe no Protheus - Id [ " + ::oOrcamentoVenda:cNumOrcamento + " ]", "", SOAPFAULT_RECEIVER )
		Return .F.

	EndIf

	ConOut( "ETAPA 1")
	//Verifica se o Cliente existe e se precisa cadastrá-lo:
	nAuxRecNoSA1  	:= U_UNICliExiste( ::oOrcamentoVenda:oCliente:cCPF_CNPJ )
	ConOut( "ETAPA 1.2")
	If FIntCliente( ::oOrcamentoVenda:oCliente, @nAuxRecNoSA1 )

		ConOut( "ETAPA 2")
		// Caso o Cliente já esteja cadastrado, pontera no mesmo?
		If nAuxRecNoSA1 > 0
			DbSelectArea( "SA1" )
			SA1->( DbGoTo( nAuxRecNoSA1 ) )
			ConOut( "ETAPA 3")
		EndIf

		nVlrTotal 		:= ::oOrcamentoVenda:nValorTotal
		nPercentJuros 	:= ::oOrcamentoVenda:nPercentualJuros
		ConOut( "ETAPA 4")

		//Reserva o Número do Orçamento
		ConOut( "ETAPA 5")
		cAuxNumOrcamento := GetSXENum( "SL1", "L1_NUM" )
		//RollBackSX8()
		//Linha removida para evitar duas solicitações vinda do Fluig reservar a mesma numeração - 13/09/2020 - RAA
		ConOut( "ETAPA 5.1 - LQ_NUM = " + cAuxNumOrcamento )

		ConOut( "ETAPA 6")
		nVlrTotal 		:= 0
		nVlrDesc		:= 0
		lSucesso 		:= .T.
		aItensOrcamento := {}

		ConOut( "ETAPA 5.1.X - ITENS A PROCESSAR DO FLUIG = " + StrZero( Len( ::oOrcamentoVenda:aItensOrcamento ), 03 ) )
		For nItem := 01 To Len( ::oOrcamentoVenda:aItensOrcamento )

			ConOut( "ETAPA 7")
			If FVerProduto( ::oOrcamentoVenda:aItensOrcamento[nItem] )

				DbSelectArea( "SB1" )
				DbSetOrder( 01 )
				Seek XFilial( "SB1" ) + PadR( ::oOrcamentoVenda:aItensOrcamento[nItem]:cCodigoProduto, TamSX3( "B1_COD" )[01] )
				If Found()

					nAuxQtd := ::oOrcamentoVenda:aItensOrcamento[nItem]:nQuantidade
					If AllTrim( SB1->B1_TIPO ) == "PA"

						ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Produto do Tipo [ PA ] precisara realizar a Desmontagem da OP" )

						// Desmonta a OP e o Kit caso o produto seja de um desses tipos
						aArea2Ant := SB1->( GetArea() )
						cParamError := ""
						If !U_UNIDesmontaOP( SB1->B1_COD, nAuxQtd, @cParamError )

							ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Não conseguiu realizar a desmontagem da OP" )
							ConOut( "	UNIWS003 - EnviaOrcamentoVenda - " + cParamError )

							lRetA := .F.
							Exit

						Else

							ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Produto Desmontado. Ok" )

						EndIf
						RestArea( aArea2Ant )

					Else

						ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Produto do Tipo [ " + SB1->B1_TIPO + " ] não precisara de Desmontagem." )

					EndIf

					// 1- Código do Componente
					// 2- Local Padrão
					// 3- Descrição do Componente
					// 4- Quantidade para a composição do Kit
					// 5- Percentual de distribuição para o Item
					ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Vai pegar os Componentes do PA / Kit " )
					cParamError 	:= ""
					aRetComponentes := {}
					If U_UNIRComponentes( SB1->B1_COD, @aRetComponentes, cParamError )

						// 01 - Cód. Produto, ;
						// 02 - Armazém
						// 03 - Desconto
						// 04 - Quant
						// 05 - % Distribução
						If Len( aRetComponentes ) >= 01

							nTamCodProd 	:= TamSX3( "B1_COD" )[01]
							//aItensOrcamento := {}
							ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Vai tratar cada Componentes do " + SB1->B1_TIPO )
							nDesconto := ::oOrcamentoVenda:aItensOrcamento[nItem]:nValorDesconto

							nTotPrcKT :=  U_PrcDesc( cFilAnt, SB1->B1_COD, ::oOrcamentoVenda:cTabelaPreco, ::oOrcamentoVenda:cCondicaoPagamento, 1, SA1->A1_COD, SA1->A1_LOJA )
							nPrcAcu := 0
							For nC := 01 To Len( aRetComponentes )

								ConOut( "ETAPA 77")
								//Pontera no Cadastro do Produto
								DbSelectArea( "SB1" )
								DbSetOrder( 01 ) // B1_FILIAL + B1_COD
								Seek XFilial( "SB1" ) + PadR( aRetComponentes[nC][01], nTamCodProd )
								If Found()

									ConOut( "	UNIWS003 - EnviaOrcamentoVenda - Gerando o SLR do Componente [ " + AllTrim( aRetComponentes[nC][01] ) + " ]." )

									// Preço = Valor Unitátio do Produto * % Distribuição do Item do Kit
									//nAuxPreco	 	:= ( ::oOrcamentoVenda:aItensOrcamento[nItem]:nValorUnitario * ( aRetComponentes[nC][05] / 100 ) )
									//Marcelo Amaral 13/11/2019
									//nAuxPreco := ( U_UNIRetPreco( SB1->B1_COD, ::oOrcamentoVenda:cTabelaPreco, XFilial( "DA1" ) ) * ( aRetComponentes[nC][05] / 100 ) )
									nAuxQuant       := ( ::oOrcamentoVenda:aItensOrcamento[nItem]:nQuantidade * aRetComponentes[nC][04] )
									nAuxPreco := U_PrcDesc( cFilAnt, SB1->B1_COD, ::oOrcamentoVenda:cTabelaPreco, ::oOrcamentoVenda:cCondicaoPagamento, 1, SA1->A1_COD, SA1->A1_LOJA )
									If nC == Len(aRetComponentes)
										If Abs(nAuxPreco - (nTotPrcKT - nPrcAcu)) < 1
											nAuxPreco := nTotPrcKT - nPrcAcu
										EndIf
									Else
										nPrcAcu += nAuxPreco
									EndIf
									U_UNIRetPreco( SB1->B1_COD, ::oOrcamentoVenda:cTabelaPreco, XFilial( "DA1" ))
									conout("nAuxPreco UNIWS003: "+cValToChar(nAuxPreco))
									conout("SB1->B1_COD: "+SB1->B1_COD)
									conout("::oOrcamentoVenda:cTabelaPreco: "+::oOrcamentoVenda:cTabelaPreco)
									conout("XFilial( 'DA1' ): "+XFilial( "DA1" ))

									ConOut( "111.1" )
									nAuxValDesc 	:= 0
									nAuxPerDesc		:= 0
									// Se foi informado o % de Desconto - Calcula o Valor do desconto
									If ::oOrcamentoVenda:aItensOrcamento[nItem]:nPercentualDesconto > 0
										//nAuxValDesc    	:= nAuxPreco * ( ::oOrcamentoVenda:aItensOrcamento[nItem]:nPercentualDesconto / 100 )
										nAuxPerDesc    	:= ::oOrcamentoVenda:aItensOrcamento[nItem]:nPercentualDesconto
										ConOut( "111.2" )
									EndIf
									ConOut( "111.3" )

									// Se foi informado o Valor do Desconto - Calcula o desconto para o % de distribuiçã do  Item do Kit
									If ::oOrcamentoVenda:aItensOrcamento[nItem]:nValorDesconto > 0
										// % de desconto do Kit
										If nC < Len(aRetComponentes)
											nAuxValDesc    	:= Ceiling((::oOrcamentoVenda:aItensOrcamento[nItem]:nValorDesconto * ( aRetComponentes[nC][05] / 100 ))*100)/100
											nDesconto -= nAuxValDesc
										Else
											nAuxValDesc := nDesconto
										EndIf

										ConOut( "111.4" )
									EndIf

									nAuxPrcFinal	:= ( ( nAuxPreco * nAuxQuant ) - nAuxValDesc )
									ConOut( "111.5" )

									aAuxTES := {}
									aAuxTES := U_UNIVerTES( cFilAnt, SA1->A1_ESTE, SA1->A1_TIPO, "3" )
									If Len( aAuxTES ) > 0
										cAuxTES := aAuxTES[01]
									EndIf
									If AllTrim( cAuxTES ) == ""
										cAuxTES := "700"
									EndIf



									ConOut( "111.9" )
									// Tabela SLR – Itens do Orçamento
									_nTotItem := (nAuxPreco*nAuxQuant)-nAuxValDesc
									fGrvSB0(aRetComponentes[nC][01],_nTotItem,Date())  // ---- LEANDRO RIBEIRO ---- 27/11/2019 ---- //

									aAux := {}
									aAdd( aAux, { "LR_NUM"	  , cAuxNumOrcamento												, Nil } )
									//Marcelo Amaral 19/11/2019
									conout("ITEM UNIWS003")
									conout("LR_NUM "+cAuxNumOrcamento)
									aAdd( aAux, { "LR_PRODUTO", aRetComponentes[nC][01]											, Nil } ) // ::oOrcamentoVenda:aItensOrcamento[nItem]:cCodigoProduto
									conout("LR_PRODUTO "+aRetComponentes[nC][01])
									//aAdd( aAux, { "LR_QUANT"  , ::oOrcamentoVenda:aItensOrcamento[nItem]:nQuantidade			, Nil } )
									aAdd( aAux, { "LR_QUANT"  , nAuxQuant														, Nil } )
									conout("LR_QUANT "+cvaltochar(nAuxQuant))
									//aAdd( aAux, { "LR_UM" 	  , ::oOrcamentoVenda:aItensOrcamento[nItem]:cUnidadeMedida			, Nil } )
									//Marcelo Amaral 06/11/2019
									aAdd( aAux, { "LR_UM" 	  , SB1->B1_UM														, Nil } )
									conout("LR_UM "+SB1->B1_UM)
									//aAdd( aAux, { "LR_VRUNIT" , ::oOrcamentoVenda:aItensOrcamento[nItem]:nValorUnitario		, Nil } )
									//aAdd( aAux, { "LR_VRUNIT" , nAuxPreco													, Nil } )
									//Marcelo Amaral 25/10/2019
									aAdd( aAux, { "LR_VRUNIT" , nAuxPreco											, Nil } )// ---- LEANDRO RIBEIRO ---- 27/11/2019 ---- //
									conout("LR_VRUNIT "+cvaltochar(nAuxPreco))
									//aAdd( aAux, { "LR_VRUNIT" , nAuxPreco // nAuxPrcFinal													, Nil } )
									If nAuxPerDesc > 0
										//aAdd( aAux, { "LR_DESC"	  , nAuxPerDesc, Nil } )
										conout("LR_DESC "+cvaltochar(nAuxPerDesc))
									EndIf
									aAdd( aAux, { "LR_VALDESC", nAuxValDesc														, Nil } )
									conout("LR_VALDESC "+cvaltochar(nAuxValDesc))
									//EndIf
									//aAdd( aAux, { "LR_TABELA" , ::oOrcamentoVenda:cTabelaPreco									, Nil } )
									//aAdd( aAux, { "LR_DESCPRO", ""																, Nil } )
									aAdd( aAux, { "LR_FILIAL" , XFilial( "SLR" )												, Nil } )
									conout("LR_FILIAL "+XFilial( "SLR" ))
									aAdd( aAux, { "LR_TES"	  , cAuxTES															, Nil } )
									//aAdd( aAux, { "LR_CF"	  , cAuxCFOP														, Nil } )
									aAdd( aAux, { "LR_VEND"	  , ::oOrcamentoVenda:cCodigoVendedor1								, Nil } )
									conout("VENDEDOR UNIWS003 LR_VEND "+(::oOrcamentoVenda:cCodigoVendedor1))
									aAdd( aAux, { "LR_PRCTAB" , nAuxPreco														, Nil } )
									//aAdd( aAux, { "LR_ENTREGA", ::oOrcamentoVenda:aItensOrcamento[nItem]:cEntrega   			, Nil } )
									aAdd( aAux, { "LR_ENTREGA", "3"													   			, Nil } )
									aAdd( aAux, { "LR_FDTENTR", SToD( ::oOrcamentoVenda:aItensOrcamento[nItem]:cDataEntrega ) 	, Nil } )
									aAdd( aAux, { "LR_LOCAL"  , "01"															, Nil } )
									aAdd( aAux, { "LR_SITUA"  , "  "															, Nil } )

									cAuxEntrega := ::oOrcamentoVenda:aItensOrcamento[nItem]:cEntrega

									aAdd( aItensOrcamento, aAux )
									ConOut( "ETAPA 8")
									lSucesso := .T.
									//nVlrTotal 	+= nAuxPrcFinal //::oOrcamentoVenda:aItensOrcamento[nItem]:nSubTotal  // ---- LEANDRO RIBEIRO ---- 04/12/2019 ---- //
									nVlrTotal 	+= _nTotItem															  // ---- LEANDRO RIBEIRO ---- 04/12/2019 ---- //
									nVlrDesc 	+= nAuxValDesc  //::oOrcamentoVenda:aItensOrcamento[nItem]:nValorDesconto
									Conout("TOTAL ITEM: "+cvaltochar(nAuxPrcFinal))
									Conout("TOTAL NOTA: "+cvaltochar(nVlrTotal))
									Conout("TOTAL DESC: "+cvaltochar(nVlrDesc))
								Else

									ConOut( "ETAPA 9")
									DisarmTransaction()
									RollBackSX8()
									lSucesso 					:= .F.
									::cRetornoWS := "Erro na validação dos Itens do Orçamento de Vendas."
									SetSoapFault( "Erro na validação dos Itens do Orçamento de Vendas. " + "Não encontrou o Produto da estrutura [ " + aRetComponentes[nC][01] + " ] referente ao Produto Kit [ " + ::oOrcamentoVenda:aItensOrcamento[nItem]:cCodigoProduto + " ]", "", SOAPFAULT_RECEIVER )
									Exit

								EndIf

							Next nC

						EndIf

					Else

						ConOut( "ETAPA 11" )
						DisarmTransaction()
						RollBackSX8()
						lSucesso 					:= .F.
						::cRetornoWS := "Erro na validação dos Itens do Orçamento de Vendas."
						SetSoapFault( "Erro na validação dos Itens do Orçamento de Vendas. " + "Não conseguiu retornar a Estrutura para o Produto [ " + ::oOrcamentoVenda:aItensOrcamento[nItem]:cCodigoProduto + " ]", "", SOAPFAULT_RECEIVER )
						Exit

					EndIf

				Else

					ConOut( "ETAPA 12")
					DisarmTransaction()
					RollBackSX8()
					lSucesso 					:= .F.
					::cRetornoWS := "Erro na validação dos Itens do Orçamento de Vendas."
					SetSoapFault( "Erro na validação dos Itens do Orçamento de Vendas. " + "Não encontrou o Produto [ " + ::oOrcamentoVenda:aItensOrcamento[nItem]:cCodigoProduto + " ]", "", SOAPFAULT_RECEIVER )
					Exit

				EndIf

			Else

				ConOut( "ETAPA 12")
				DisarmTransaction()
				RollBackSX8()
				lSucesso 					:= .F.
				::cRetornoWS := "Erro na validação dos Itens do Orçamento de Vendas."
				SetSoapFault( "Erro na validação dos Itens do Orçamento de Vendas. " + "Não conseguiu validar o Produto [ " + ::oOrcamentoVenda:aItensOrcamento[nItem]:cCodigoProduto + " ]", "", SOAPFAULT_RECEIVER )
				Exit

			EndIf

			If !lSucesso
				Exit
			EndIf

		Next nItens

		ConOut( "ETAPA 10")
		ConOut( "ETAPA 10.2")

		If lSucesso

			ConOut( "ETAPA 10.3")
			//Tabela - SLQ – Cabeçalho do Orçamento
			conout("VENDEDOR UNIWS003 LQ_VEND "+(::oOrcamentoVenda:cCodigoVendedor1))
			conout("VENDEDOR UNIWS003 LQ_VEND2 "+(::oOrcamentoVenda:cCodigoVendedor2))
			conout("VENDEDOR UNIWS003 LQ_VEND3 "+(::oOrcamentoVenda:cCodigoVendedor3))
			conout("LQ_FILIAL "+XFilial( "SLQ" ))
			conout("LQ_NUM "+cAuxNumOrcamento)
			aCabecalhoOrcamento  		:= { 	{ "LQ_VEND" 	, ::oOrcamentoVenda:cCodigoVendedor1		, Nil } ,;
				{ "LQ_VEND2" 	, ::oOrcamentoVenda:cCodigoVendedor2		, .T. } ,;
				{ "LQ_VEND3" 	, ::oOrcamentoVenda:cCodigoVendedor3		, .T. } ,;
				{ "LQ_FILIAL"   , XFilial( "SLQ" ) 							, Nil } ,;
				{ "LQ_COMIS"	, 0 										, Nil } ,;
				{ "LQ_CLIENTE"  , SA1->A1_COD								, Nil } ,;
				{ "LQ_LOJA"   	, SA1->A1_LOJA								, Nil } ,;
				{ "LQ_NUM"		, cAuxNumOrcamento							, Nil } ,;//						                        { "LQ_EMISSAO" , Date()         							, Nil } ,;
				{ "LQ_TIPOCLI"  , SA1->A1_TIPO							, Nil } ,;
				{ "LQ_VLRTOT"   , nVlrTotal       							, Nil } ,;
				{ "LQ_DESCONT"  , 0                							, Nil } ,;
				{ "LQ_VLRLIQ"  	, nVlrTotal+oOrcamentoVenda:nValorFrete		, Nil } ,;//{ "LQ_VLRLIQ"  	, nVlrTotal    								, Nil } ,;
				{ "LQ_JUROS"	, nPercentJuros								, Nil } ,;
				{ "LQ_VLRJUR"	, ::oOrcamentoVenda:nValorAcrescimo			, Nil } ,;
				{ "LQ_VALBRUT"  , nVlrTotal+oOrcamentoVenda:nValorFrete		, Nil } ,; //( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,; //					, Nil } ,; //(nVlrTotal-nVlrFrete-nVlrDesconto)	 				, Nil } ,;
				{ "LQ_VALMERC"  , nVlrTotal									, Nil } ,; //{ "LQ_VALMERC"  , nVlrTotal-::oOrcamentoVenda:nValorFrete	, Nil } ,; //( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,; //					, Nil } ,; //(nVlrTotal-nVlrFrete-nVlrDesconto)	 				, Nil } ,;//( nVlrTotal - Abs( nVlrDesconto ) - nVlrFrete ), Nil } ,; //					, Nil } ,; //(nVlrTotal-nVlrFrete-nVlrDesconto)	 				, Nil } ,;
				{ "LQ_NROPCLI" 	, " "          								, Nil } ,;
				{ "LQ_DTLIM"   	, SToD( ::oOrcamentoVenda:cDataValidade ) 	, Nil } ,;
				{ "LQ_FRETE"    , ::oOrcamentoVenda:nValorFrete				, Nil } ,;
				{ "LQ_TPFRET"	, "C"										, Nil } ,;
				{ "LQ_EMISSAO" 	, SToD( ::oOrcamentoVenda:cDataOrcamento )	, Nil } ,;
				{ "LQ_TABELA"	, ::oOrcamentoVenda:cTabelaPreco			, Nil } ,;
				{ "LQ_VLRDEBI" 	, 0    										, Nil } ,;
				{ "LQ_HORA"    	, ""    									, Nil } ,;
				{ "LQ_NUMMOV" 	, "1 "										, Nil } ,;
				{ "LQ_TIPO" 	, "V"										, Nil } ,;
				{ "LQ_IMPRIME" 	, "1S"										, Nil } ,;
				{ "LQ_OPERACA" 	, "C"										, Nil } ,;
				{ "LQ_STATUS" 	, "F"										, Nil } ,;
				{ "LQ_TPORC" 	, "E"										, Nil } ,;
				{ "LQ_STBATCH" 	, "1"										, Nil } ,;
				{ "LQ_INDPRES" 	, "1"										, Nil } ,;
				{ "AUTRESERVA" 	, cLojaReserva								, Nil }  }

			// Não efetua Reserva
			If ::oOrcamentoVenda:cReservaEstoque != Nil

				If AllTrim( ::oOrcamentoVenda:cReservaEstoque ) == "N"
					aDel( aCabecalhoOrcamento, Len( aCabecalhoOrcamento ) )
					aSize( aCabecalhoOrcamento, ( Len( aCabecalhoOrcamento ) - 01 ) )
				EndIf

			EndIf

			ConOut( "ETAPA 11-5")
			aCondicoesPagamento := {}
			aAuxPgtoOrc 		:= {}
			aAuxCond			:= {}
			//aAuxCond 			:= Condicao( ::oOrcamentoVenda:nValorTotal, ::oOrcamentoVenda:cCondicaoPagamento, 0, SToD( ::oOrcamentoVenda:cDataOrcamento ),,,, ::oOrcamentoVenda:nValorAcrescimo ) // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
			_nVlrTotal          := oOrcamentoVenda:nValorTotal+oOrcamentoVenda:nValorFrete
			Conout("Executando GetArea")
			_aCondPag           := GetArea()
			aAuxCond 			:= Condicao(_nVlrTotal, ::oOrcamentoVenda:cCondicaoPagamento, 0, SToD( ::oOrcamentoVenda:cDataOrcamento ),,,, ::oOrcamentoVenda:nValorAcrescimo ) // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
			RestArea(_aCondPag)
			Conout("Voltando a Area Anterior")
			For nCondicao := 01 To Len( aAuxCond )

				aAuxPgtoOrc := { 	{ 	 "L4_NUM"		, cAuxNumOrcamento			, Nil  }, ;
					{ 	 "L4_FILIAL"	, XFilial( "SL4" )  		, Nil  }, ;
					{	 "L4_DATA"		, aAuxCond[nCondicao][01]	, Nil  }, ;
					{    "L4_VALOR"		, aAuxCond[nCondicao][02]	, Nil  }, ;
					{    "L4_FORMA"		, ::oOrcamentoVenda:oCondicaoPagamento:cIdFormaPagamento, Nil  }, ;
					{	 "L4_ADMINIS" 	, Space( 20 )	 			, Nil  }, ;
					{	 "L4_FORMAID" 	,"1" 						, Nil  }, ;
					{    "L4_MOEDA"		, 0							, Nil  }, ;
					{    "L4_SITUA"		, "  "						, Nil  }  }

				aAdd( aCondicoesPagamento, aClone( aAuxPgtoOrc ) )

			Next nCondicao

		EndIf

		ConOut( "ETAPA 13")
		// Realiza a Inclusão / Alteração do Orçamento de Vendas através de 'Auto
		If lSucesso

			ConOut( "ETAPA 14")

			U_UNIDebugExecAuto( "LOJA701 - CABEC", 3, aCabecalhoOrcamento, 1 )
			U_UNIDebugExecAuto( "LOJA701 - ITENS", 3, aItensOrcamento 	 , 2 )
			U_UNIDebugExecAuto( "LOJA701 - PGTO" , 3, aCondicoesPagamento, 2 )
			// Será necessário utilizar um usuário / senha com permissão de caixa para ainclusão do orçamento
			//cUsrLogin := "CX_005"
			//cUsrPass  := "123456"
			//cUsrLogin 		:= AllTrim( GetNewPar( "MV_XUCXFLU", "CX_005" ) )
			//cUsrPass  		:= AllTrim( GetNewPar( "MV_XPCXFLU", "123456"	) )

			cUsrLogin 		:= AllTrim( cUserCaixa )
			cUsrPass  		:= AllTrim( cPswCaixa  )
			ConOut( "	- USUARIO LOJA: " + cUsrLogin )

			lEhSch := .T.

			If  ( aCabecalhoOrcamento	 == Nil .Or. ;
					aItensOrcamento		 == Nil .Or. ;
					aCondicoesPagamento	 == Nil )

				lSucesso 	 := .F.
				::cRetornoWS := "Erro ao tentar incluir o Orçamento de Vendas no Protheus. Estrutura do ExecAuto não foi montada corretamente."
				SetSoapFault( "Erro ao tentar incluir o Orçamento de Vendas no Protheus. Estrutura do ExecAuto não foi montada corretamente.", "", SOAPFAULT_RECEIVER )

			EndIf


			If  ( Len( aCabecalhoOrcamento 	) == 0 .Or. ;
					Len( aItensOrcamento	 	) == 0 .Or. ;
					Len( aCondicoesPagamento 	) == 0  )

				lSucesso 	 := .F.
				::cRetornoWS := "Erro ao tentar incluir o Orçamento de Vendas no Protheus. Estrutura do ExecAuto não foi montada corretamente."
				SetSoapFault( "Erro ao tentar incluir o Orçamento de Vendas no Protheus. Estrutura do ExecAuto não foi montada corretamente.", "", SOAPFAULT_RECEIVER )

			EndIf

			DbSelectArea( "SX2" )
			DbSelectArea( "SIX" )
			DbSelectArea( "SX3" )
			DbSelectArea( "SX6" )
			DbSelectArea( "SL1" )
			DbSelectArea( "SL2" )
			DbSelectArea( "SL4" )
			DbSelectArea( "DA0" )
			DbSelectArea( "DA1" )

			lPOSLJAUTO      := .T.
			aAutoCab		:= {}
			lMsErroAuto 	:= .F.
			lMsHelpAuto 	:= .F.
			SetFunName( "LOJA701" )

			Inclui  	:= .T.
			Altera  	:= .F.
			lAuxAuto 	:= .T.
			lAutoExec	:= .T.									// verifica se esta sendo executada por EXECAUTO

			U_UNIGetEnvInfo( "LOJA701.prw" )
			cMsgErro := StartJob( "U_FGERAORC", GetEnvServer(), .T., cEmpAnt, cFilAnt, .F., cUsrLogin, cUsrPass, aCabecalhoOrcamento, aItensOrcamento, aCondicoesPagamento, 03, SA1->A1_COD, SA1->A1_LOJA,.F.)
			//cMsgErro := U_FGERAORC( cEmpAnt, cFilAnt, .F., cUsrLogin, cUsrPass, aCabecalhoOrcamento, aItensOrcamento, aCondicoesPagamento, 03, SA1->A1_COD, SA1->A1_LOJA )
			Conout("Aguardando!")
			Sleep(10000)
			Conout(cMsgErro)
			Conout("Voltando!!!")

			/*
			// Alterado por RAA 07/11/2020 para forçar o retorno quando o orçamento for incluido com sucesso, ou quando der erro interno no Protheus (cMsgErro == Nil)
			If AllTrim( cMsgErro ) == "SUCESSO"
				cMsgErro := ""
			Elseif cMsgErro == Nil
				cMsgErro := "Erro interno no Webservice do Protheus."
			Endif
			*/
			If AllTrim( cMsgErro ) != ""

				ConOut( "ETAPA 14.1")
				DisarmTransaction()
				RollBackSX8()
				lSucesso 	 := .F.
				//MARCELO AMARAL 09/11/2019
				::cRetornoWS := "Erro ao tentar incluir / alterar o Orçamento de Vendas no Protheus. " + cMsgErro
				SetSoapFault( "Erro ao tentar incluir / alterar o Orçamento de Vendas no Protheus. " + cMsgErro , "", SOAPFAULT_RECEIVER )

			Else

				ConOut( "ETAPA 14.2")
				ConfirmSX8()

				cUpdate := ""
				// Grava o Id do pedido no Fluig
				DbSelectArea( "SL1" )
				DbSetOrder( 01 ) // L1_FILIAL + L1_NUM
				Seek XFilial( "SL1" ) + cAuxNumOrcamento
				If Found()

					// Pontera no Cadastro do Cliente
					DbSelectArea( "SA1" )
					DbSetOrder( 01 ) // A1_FILIAL + A1_COD + A1_LOJA
					Seek XFilial( "SA1" ) + SL1->( L1_CLIENTE + L1_LOJA )

					DbSelectArea( "SL1" )
					RecLock( "SL1", .F. )

					conout("SL1->L1_FILIAL "+SL1->L1_FILIAL)
					conout("SL1->L1_NUM "+SL1->L1_NUM)
					SL1->L1_XIDFLUI := ::oOrcamentoVenda:cNumOrcamento
					SL1->L1_NROPCLI := ::oOrcamentoVenda:cNumOrcamento
					If ::oOrcamentoVenda:cCodigoVendedor2 != Nil
						CONOUT("VENDEDOR UNIWS003 SL1->L1_XVEND2 ANTES "+(SL1->L1_XVEND2))
						SL1->L1_XVEND2	:= Padr(::oOrcamentoVenda:cCodigoVendedor2,TamSX3("L1_VEND2")[1])
						conout("TAM cCodigoVendedor2 "+cvaltochar(len(alltrim(::oOrcamentoVenda:cCodigoVendedor2))))
						CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND2 DEPOIS "+(SL1->XL1_VEND2))
					EndIf
					If ::oOrcamentoVenda:cCodigoVendedor3 != Nil
						CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND3 ANTES "+(SL1->L1_VEND3))
						SL1->L1_VEND3	:= Padr(::oOrcamentoVenda:cCodigoVendedor3,TamSX3("L1_VEND3")[1])
						SL1->L1_VEND5	:= Padr(::oOrcamentoVenda:cCodigoVendedor3,TamSX3("L1_VEND5")[1])///MATHEUS ANDRADE
						conout("TAM cCodigoVendedor3 "+cvaltochar(len(alltrim(::oOrcamentoVenda:cCodigoVendedor3))))
						CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND3 DEPOIS "+(SL1->L1_VEND3))
					EndIf
					If ::oOrcamentoVenda:cCondicaoPagamento != Nil
						SL1->L1_CONDPG  := ::oOrcamentoVenda:cCondicaoPagamento
					EndIf
					If ::oOrcamentoVenda:cCondicaoPagamento != Nil
						SL1->L1_TRANSP  := ::oOrcamentoVenda:cTransportadora
					EndIf

					If ::oOrcamentoVenda:cTabelaPreco		!= Nil
						SL1->L1_TABELA  := ::oOrcamentoVenda:cTabelaPreco
					Else
						SL1->L1_TABELA  := "001"
					EndIf

					SL1->L1_ENDCOB  := SA1->A1_END
					SL1->L1_BAIRROC := SA1->A1_BAIRRO
					SL1->L1_CEPC 	:= SA1->A1_CEP
					SL1->L1_MUNC    := SA1->A1_COD_MUN
					SL1->L1_ESTC 	:= SA1->A1_EST

					SL1->L1_ENDENT  := SA1->A1_ENDENT
					SL1->L1_BAIRROE := SA1->A1_BAIRROE
					SL1->L1_CEPE 	:= SA1->A1_CEPE
					SL1->L1_MUNE    := SA1->A1_CODMUNE
					SL1->L1_ESTE	:= SA1->A1_ESTE

					// By RGR
					//SL1->L1_VLRTOT	:= nVlrTotal									// ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
					//SL1->L1_DESCONT	:= nVlrDesconto									// ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
					//SL1->L1_VALBRUT := nVlrTotal //+ nVlrDesconto
					//SL1->L1_VALMERC := nVlrTotal// - ::oOrcamentoVenda:nValorFrete	// ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
					//SL1->L1_VLRLIQ	:= nVlrTotal - ::oOrcamentoVenda:nValorFrete	// ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
					SL1->L1_DESCNF  := 0
					SL1->L1_TPFRET	:= "C"

					If ::oOrcamentoVenda:oCondicaoPagamento:cIdFormaPagamento != Nil
						SL1->L1_FORMPG  := ::oOrcamentoVenda:oCondicaoPagamento:cIdFormaPagamento
					EndIf

					SL1->L1_XOBS := ::oOrcamentoVenda:cObservacao // Marcelo Amaral 11/11/2019

					nRecSL1 := SL1->(Recno())



					if SL1->(Recno()) = nRecSL1
						cUpdate := "UPDATE " + RetSQLName( "SL1" ) + " "
						cUpdate += "SET L1_XVEND2 = '" + Padr(::oOrcamentoVenda:cCodigoVendedor2,TamSX3("L1_VEND2")[1]) + "', "
						cUpdate += "L1_VEND3 = '" + Padr(::oOrcamentoVenda:cCodigoVendedor3,TamSX3("L1_VEND3")[1]) + "', "
						cUpdate += "L1_VEND5 = '" + Padr(::oOrcamentoVenda:cCodigoVendedor3,TamSX3("L1_VEND5")[1]) + "' "
						cUpdate += "WHERE R_E_C_N_O_ = " + AllTrim( Str( SL1->( RecNo() ) ) )
						if TcSQLExec( cUpdate ) < 0
							conout("ERRO UPDATE RECLOCK FALSE SL1 UNIWS003 "+cUpdate)
						else
							conout("SUCESSO UPDATE RECLOCK FALSE SL1 UNIWS003 "+cUpdate)
						endif
					else
						conout("RECNO RECLOCK FALSE SL1 DIFERENTE")
					endif

					DbSelectArea( "SL2" )
					DbSetOrder( 01 ) // SL2_FILIAL + SL2_NUM
					Seek SL1->( L1_FILIAL + L1_NUM )
					Do While !SL2->( Eof() ) .And. ;
							AllTrim( SL2->L2_FILIAL ) == AllTrim( SL1->L1_FILIAL ) .And. ;
							AllTrim( SL2->L2_NUM	 ) == AllTrim( SL1->L1_NUM	  )

						DbSelectArea( "SL2" )
						RecLock( "SL2", .F. )
						SL2->L2_VLRITEM := SL2->( L2_VRUNIT * L2_QUANT )
						SL2->L2_ENTREGA := cAuxEntrega
						SL2->L2_DESCRI := Posicione( "SB1", 1, XFilial( "SB1" ) + SL2->L2_PRODUTO, "B1_DESC" )
						SL2->( MsUnLock() )

						DbSelectArea( "SL2" )
						SL2->( DbSkip() )
					EndDo

					SL1->( MsUnLock() )

				Else

					// Tentativa de Identificar o Problema gerador do erroo.

					//nPrcTabela  := U_UNIRetPreco( aRetComponentes[nC][01], _c_WsTabelaMagento, cFilAnt )
					//If nPrcTabela > 0 .And. Len( aRetComponentes ) > 01
					//	nAuxPreco	 	:= nPrcTabela
					//Else

					lSucesso 	 := .F.
					/*
					ConOut( "ETAPA 14.7")
					//DisarmTransaction()
					//RollBackSXE()
					::cRetornoWS := "Erro ao tentar incluir o Orçamento de Vendas no Protheus. Erro não identificado, o orcamento nao foi importado para o Protheus " + AllTrim( MostraErro( "-", "-" ) )
					SetSoapFault( "Erro ao tentar incluir o Orçamento de Vendas no Protheus. Erro nao identificado, o orcamento nAo foi importado para o Protheus " + AllTrim( MostraErro( "-", "-" ) ), "", SOAPFAULT_RECEIVER )
					*/
				EndIf

				/*
				// Realiza o Bloqueio do Pedido de Vendas
				If AllTrim( cUpdate ) != ""
					If TcSQLExec( cUpdate ) != 0
						ConOut( "Erro ao tentar bloquear o Pedido de Vendas Gerado pela Integração Fluig." )
						ConOut( "Descrição: " + TCSQLError() )
					EndIf
				EndIf
				*/

				//lSucesso 	 := .T.
				//::cRetornoWS := "Registros atualizado com sucesso no Protheus!"

				// ---- INICIO ---- LEANDRO RIBEIRO ---- 10/12/2019 ---- //
				//FUNÇÃO PARA VERIFICAR SE FOI GRAVADA A TABELA SC0
				Conout("UNIWS003: INICIO - VERIFICAÇÃO DA TABELA SC0 - Hora: "+cValtoChar(Time())+" Data: "+DTOC(date())+".")
				If(SL1->L1_RESERVA = "S")
					VerifSC0LJ(SL1->L1_NUM,cLojaReserva)
				EndIf
				Conout("UNIWS003: FIM - VERIFICAÇÃO DA TABELA SC0 - Hora: "+cValtoChar(Time())+" Data: "+DTOC(date())+".")
				// ---- FIM ------- LEANDRO RIBEIRO ---- 10/12/2019 ---- //

				lSucesso 	 := .T.
				::cRetornoWS := "Registros atualizado com sucesso no Protheus!"
				//SetSoapFault( "Registros atualizado com sucesso no Protheus!", "", SOAPFAULT_RECEIVER )

			EndIf
			/* ---- INICIO ---- LEANDRO RIBEIRO ---- 12/10/2019 -------------------------------------------------------------------------- //
			RETIRADO A FUNÇÃO DE GRAVAÇÃO VIA RECLOCK PARA SEMPRE USAR A TRATATIVA DE EXECAUTO
			If !lSucesso

				/*RETIRADO MARCELO AMARAL 09/11/2019 ConOut( "Erro ao tentar incluir / alterar o Orçamento de Vendas no Protheus.")
				DisarmTransaction()
				RollBackSXE()
				//lSucesso 	 := .F.
				::cRetornoWS := "Erro ao tentar incluir / alterar o Orçamento de Vendas no Protheus. "
				SetSoapFault( "Erro ao tentar incluir / alterar o Orçamento de Vendas no Protheus. " , "", SOAPFAULT_RECEIVER )
			*/

			/*NÃO RETIRADO MARCELO AMARAL 07/11/2019 */
			/* ---- CONTINUAÇÃO ---- LEANDRO RIBEIRO ---- 12/10/2019 -------------------------------------------------------------------------- //
				ConOut( "	UNIWS003 - Vai realizar a entrada por RecLock()" )
				BeginTran()

					DbSelectArea( "SL1" )
					DbSetOrder( 01 )
					RecLock( "SL1", .T. )

						For nR := 01 To Len( aCabecalhoOrcamento )

							cAuxCpo := "SL1->" + Replace( AllTrim( aCabecalhoOrcamento[nR][01] ), "LQ_", "L1_" )
							&cAuxCpo := aCabecalhoOrcamento[nR][02]

						Next nR

						conout("SL1->L1_FILIAL "+SL1->L1_FILIAL)
						conout("SL1->L1_NUM "+SL1->L1_NUM)
						SL1->L1_XIDFLUI := ::oOrcamentoVenda:cNumOrcamento
						SL1->L1_NROPCLI := ::oOrcamentoVenda:cNumOrcamento
						If ::oOrcamentoVenda:cCodigoVendedor2 != Nil
						 	CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND2 ANTES "+(SL1->L1_VEND2))
							SL1->L1_VEND2	:= Padr(::oOrcamentoVenda:cCodigoVendedor2,TamSX3("L1_VEND2")[1])
							conout("TAM cCodigoVendedor2 "+cvaltochar(len(alltrim(::oOrcamentoVenda:cCodigoVendedor2))))
							CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND2 DEPOIS "+(SL1->L1_VEND2))
						EndIf
						If ::oOrcamentoVenda:cCodigoVendedor3 != Nil
							CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND3 ANTES "+(SL1->L1_VEND3))
							SL1->L1_VEND3	:= Padr(::oOrcamentoVenda:cCodigoVendedor3,TamSX3("L1_VEND3")[1])
							conout("TAM cCodigoVendedor3 "+cvaltochar(len(alltrim(::oOrcamentoVenda:cCodigoVendedor3))))
							CONOUT("VENDEDOR UNIWS003 SL1->L1_VEND3 DEPOIS "+(SL1->L1_VEND3))
						EndIf
						If ::oOrcamentoVenda:cCondicaoPagamento != Nil
							SL1->L1_CONDPG  := ::oOrcamentoVenda:cCondicaoPagamento
						EndIf
						If ::oOrcamentoVenda:oCondicaoPagamento:cIdFormaPagamento != Nil
							SL1->L1_FORMPG  := ::oOrcamentoVenda:oCondicaoPagamento:cIdFormaPagamento
						EndIf
						If ::oOrcamentoVenda:cCondicaoPagamento != Nil
							SL1->L1_TRANSP  := ::oOrcamentoVenda:cTransportadora
						EndIf

						If ::oOrcamentoVenda:cTabelaPreco		!= Nil
							SL1->L1_TABELA  := ::oOrcamentoVenda:cTabelaPreco
						Else
							SL1->L1_TABELA  := "001"
						EndIf

						SL1->L1_ENDCOB  := SA1->A1_END
						SL1->L1_BAIRROC := SA1->A1_BAIRRO
						SL1->L1_CEPC 	:= SA1->A1_CEP
						SL1->L1_MUNC    := SA1->A1_COD_MUN
						SL1->L1_ESTC 	:= SA1->A1_EST

						SL1->L1_ENDENT  := SA1->A1_ENDENT
						SL1->L1_BAIRROE := SA1->A1_BAIRROE
						SL1->L1_CEPE 	:= SA1->A1_CEPE
						SL1->L1_MUNE    := SA1->A1_CODMUNE
						SL1->L1_ESTE	:= SA1->A1_ESTE
						SL1->L1_EMISSAO := Date()
						SL1->L1_CONFVEN := "SSSSSSSSNSSS        "
						SL1->L1_HORA 	:= Time()

						// Não Efetua Reserva
						If ::oOrcamentoVenda:cReservaEstoque != Nil
							If AllTrim( ::oOrcamentoVenda:cReservaEstoque ) == "S"
								SL1->L1_RESERVA := "S"
							EndIf
						EndIf

						// By RGR
						//SL1->L1_VLRTOT	:= nVlrTotal
						//SL1->L1_DESCONT	:= nVlrDesconto
		   		        //SL1->L1_VALBRUT := nVlrTotal //+ nVlrDesconto
		   		        //SL1->L1_VALMERC := nVlrTotal// - ::oOrcamentoVenda:nValorFrete
						//SL1->L1_VLRLIQ	:= nVlrTotal - ::oOrcamentoVenda:nValorFrete
						SL1->L1_DESCNF  := 0
			/*NÃO RETIRADO MARCELO AMARAL 07/11/2019 */

			//Verifica se Libera o Pedido para o Faturamento ( Apenas Tipo Boleto )
			/*
						If ::oOrcamentoVenda:oCondicaoPagamento:cFormaPagamento != Nil

							If AllTrim( ::oOrcamentoVenda:oCondicaoPagamento:cFormaPagamento ) == ""
								cAuxForma := FRetForma( ::oOrcamentoVenda:cCondicaoPagamento )
							Else
								cAuxForma := ::oOrcamentoVenda:oCondicaoPagamento:cFormaPagamento
							EndIf
							If AllTrim( cAuxForma ) == "BO"

								SL1->L1_TIPO 	:= "V"  	// Venda , Dev, Troca
								SL1->L1_IMPRIME := "1S" 	//
								SL1->L1_OPERACA := "C"  	//
								SL1->L1_STATUS  := "F"  	// Finalizado | Cancelado...
								SL1->L1_TPORC 	:= "E"  	//
								SL1->L1_STBATCH := "1"  	//
								SL1->L1_TREFETI	:= .F.  	//
								SL1->L1_SITUA 	:= "RX"
								SL1->L1_FORMPG  := cAuxForma
							Else
								SL1->L1_FORMPG  := cAuxForma
							EndIf

						EndIf
			*/
			/*NÃO RETIRADO MARCELO AMARAL 07/11/2019 */

			//					SL1->L1_XOBS := ::oOrcamentoVenda:cObservacao // Marcelo Amaral 11/11/2019
			/* ---- CONTINUAÇÃO ---- LEANDRO RIBEIRO ---- 12/10/2019 -------------------------------------------------------------------------- //
					nRecSL1 := SL1->(Recno())

					SL1->( MsUnLock() )

					if SL1->(Recno()) = nRecSL1
						cUpdate := "UPDATE " + RetSQLName( "SL1" ) + " "
						cUpdate += "SET L1_VEND2 = '" + Padr(::oOrcamentoVenda:cCodigoVendedor2,TamSX3("L1_VEND2")[1]) + "', "
						cUpdate += "L1_VEND3 = '" + Padr(::oOrcamentoVenda:cCodigoVendedor3,TamSX3("L1_VEND3")[1]) + "' "
						cUpdate += "WHERE R_E_C_N_O_ = " + AllTrim( Str( SL1->( RecNo() ) ) )
					    if TcSQLExec( cUpdate ) < 0
					    	conout("ERRO UPDATE RECLOCK TRUE SL1 UNIWS003 "+cUpdate)
					    else
					    	conout("SUCESSO UPDATE RECLOCK TRUE SL1 UNIWS003 "+cUpdate)
					    endif
					else
						conout("RECNO RECLOCK TRUE SL1 DIFERENTE")
					endif

					DbSelectArea( "SL2" )
					DbSetOrder( 02 )
					For nR := 01 To Len( aItensOrcamento )

						RecLock( "SL2", .T. )

							SL2->L2_ITEM := StrZero( nR, 02 )

						cAuxProduto := ""
						For nK := 01 To Len( aItensOrcamento[nK] )

							cAuxCpo := "SL2->" + Replace( AllTrim( aItensOrcamento[nR][nK][01] ), "LR_", "L2_" )
							&cAuxCpo := aItensOrcamento[nR][nK][02]
							If AllTrim( aItensOrcamento[nR][nK][01] ) == "LR_PRODUTO"
								cAuxProduto := aItensOrcamento[nR][nK][02]
							EndIf

						Next nK

						SL2->L2_DESCRI := Posicione( "SB1", 1, XFilial( "SB1" ) + cAuxProduto, "B1_DESC" )
						SL2->L2_EMISSAO := Date()
						SL2->L2_VLRITEM := SL2->( L2_VRUNIT * L2_QUANT )
						SL2->L2_ENTREGA := cAuxEntrega

						SL2->( MsUnLock() )

						// Não Efetua Reserva
						If ::oOrcamentoVenda:cReservaEstoque != Nil

							If AllTrim( ::oOrcamentoVenda:cReservaEstoque ) == "S"

								cAuxRes := FReserva()
								RecLock( "SL2", .F. )
									SL2->L2_RESERVA := cAuxRes
									SL2->L2_LOJARES := cLojaReserva
									SL2->L2_FILRES  := SL2->L2_FILIAL
								SL2->( MsUnLock() )

							EndIf

						EndIf

					Next nR

					DbSelectArea( "SL4" )
					DbSetOrder( 02 )
					For nR := 01 To Len( aCondicoesPagamento )

						RecLock( "SL4", .T. )
						For nK := 01 To Len( aCondicoesPagamento[nK] )
							cAuxCpo := "SL4->" + AllTrim( aCondicoesPagamento[nR][nK][01] )
							&cAuxCpo := aCondicoesPagamento[nR][nK][02]
						Next nK
						SL4->( MsUnLock() )

					Next nR

				EndTran()
				lSucesso 	 := .T.
				::cRetornoWS := "Registros atualizado com sucesso no Protheus!"
				//SetSoapFault( "Registros atualizado com sucesso no Protheus!", "", SOAPFAULT_RECEIVER )
			/*NÃO RETIRADO MARCELO AMARAL 07/11/2019 */
			/*
			EndIf
			// ---- FIM ------- LEANDRO RIBEIRO ---- 12/10/2019 -------------------------------------------------------------------------- */
			//EndIf

		EndIf

	Else

		ConOut( "ETAPA 17")
		DisarmTransaction()
		lSucesso 						:= .F.
		::cRetornoWS := "Não conseguiu Incluir / Atualizar o cadastro de Cliente."
		SetSoapFault( "Não conseguiu Incluir / Atualizar o cadastro de Cliente. " + "Cliente Inválido.", "", SOAPFAULT_RECEIVER )

	EndIf

	//EndTran()

	ConOut( "________________________________ FIM DO PROCESSO INCLUSAO DE ORCAMENTO DE VENDAS ________________________________")

Return lSucesso

// RetornaListaProdutos

//WSMethod ListaCadastroProdutos WSReceive cCodigoEmpresa, cCodigoFilial WSSend oListaProdutos WSService oWsUnica
WSMethod ListaCadastroProdutos WSReceive cListEmpFiliais, cListProdutos, cListGrupos, cListCategorias, cListLinhas, cListDescricao, cListFab, cListCapac, cListVolt WSSend oListaProdutos WSService oWsUnica

	Local cQuery 			:= ""
	Local cAliasProd		:= ""
	Local aEmpresas 		:= {}
	Local lSucesso 			:= .T.

	//Local nPosEmpresa		:= 01
	//Local nPosFilial		:= 02
	Local nPosB1COD     	:= 01
	Local nPosB1_DESC   	:= 02
	Local nPosB1_TIPO		:= 03
	Local nPosB1_UM	  		:= 04
	Local nPosB1_LOCPAD 	:= 05
	Local nPosB1_GRUPO  	:= 06
	Local nPosBM_DESC   	:= 07
	Local nPosB1_CATEGOR	:= 08
	Local nPosZ1_DESC   	:= 09
	Local nPosB1_LINHA		:= 10
	Local nPosZ2_DESC   	:= 11
	Local nPosB1_PESO   	:= 12
	Local nPosB1_CODBAR 	:= 13
	Local nPosB1_ATIVO 		:= 14
	Local nPosB1_TS			:= 15
	Local nPosB1_XOBSERV	:= 16
	Local nPosB1_XALERTA	:= 17
	Local nPosB1_PRV1		:= 18
	Local nPosB2_SALDO		:= 19
	Local nPosB1_FAB		:= 20
	Local nPosB1_CAP		:= 21
	Local nPosB1_VOL		:= 22

	Default cListEmpFiliais	:= ""
	Default cListProdutos	:= ""
	Default cListGrupos		:= ""
	Default cListCategorias	:= ""
	Default cListLinhas		:= ""
	Default cListDescricao  := ""
	Default cListFab 		:= ""
	Default cListCapac 		:= ""
	Default cListVolt 		:= ""
	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE PRODUTOS ________________________________" )

	aAreaSM0 := GetArea()

	lParamWebService	:= .T.
	aParamEmpresas 		:= {}
	aListEstoque		:= {}
	U_UNIRetConsulta( lParamWebService, cListEmpFiliais, cListProdutos, cListGrupos, cListCategorias, cListLinhas, cListDescricao, @aParamEmpresas, @aListEstoque, .T., cListFab, cListCapac, cListVolt )

	::oListaProdutos:aListaProdutos := {}
	ConOut( "ETAPA 3" )

	nLimite := 250

	For nProd := 01 To Len( aListEstoque )

		aAdd( ::oListaProdutos:aListaProdutos, WSClassNew( "oStructProduto" ) )

		//ConOut( "ETAPA 6" )
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_COD    	 := aListEstoque[nProd][nPosB1COD]    		// 03-Codigo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_DESC   	 := aListEstoque[nProd][nPosB1_DESC]   		// 04-Descricao
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_TIPO   	 := aListEstoque[nProd][nPosB1_TIPO]   		// 05-Tipo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_UM     	 := aListEstoque[nProd][nPosB1_UM]     		// 06-Unidade
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_LOCPAD 	 := aListEstoque[nProd][nPosB1_LOCPAD] 		// 07-Armazem Pad.
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_GRUPO  	 := aListEstoque[nProd][nPosB1_GRUPO]  		// 08-Grupo
		aTail( ::oListaProdutos:aListaProdutos ):cWSBM_DESC 	 := aListEstoque[nProd][nPosBM_DESC]  		// 09-Descrição do Grupo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_CATEGOR 	 := aListEstoque[nProd][nPosB1_CATEGOR]  	// 10-Categoria
		aTail( ::oListaProdutos:aListaProdutos ):cWSZ1_DESC 	 := aListEstoque[nProd][nPosZ1_DESC]  		// 11-Descrição da Categoria
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_LINHA  	 := aListEstoque[nProd][nPosB1_LINHA]  		// 12-Linha
		aTail( ::oListaProdutos:aListaProdutos ):cWSZ2_DESC  	 := aListEstoque[nProd][nPosZ2_DESC]  		// 13-Descrição da Linha
		aTail( ::oListaProdutos:aListaProdutos ):nWSB1_PRV1   	 := aListEstoque[nProd][nPosB1_PRV1]   		// 14-Preco Venda
		aTail( ::oListaProdutos:aListaProdutos ):nWSB1_PESO   	 := aListEstoque[nProd][nPosB1_PESO]   		// 15-Peso Liquido
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_CODBAR 	 := aListEstoque[nProd][nPosB1_CODBAR] 		// 16-Cod Barras
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_TS        := aListEstoque[nProd][nPosB1_TS] 			// 17-Cod Barras
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_ATIVO  	 := aListEstoque[nProd][nPosB1_ATIVO]  		// 18-Ativo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_XOBSERV	 := aListEstoque[nProd][nPosB1_XOBSERV]  	// 19-Observação
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_XALERTA	 := aListEstoque[nProd][nPosB1_XALERTA]  	// 20-Alerta
		aTail( ::oListaProdutos:aListaProdutos ):CWSB1_FABRIC	 := aListEstoque[nProd][nPosB1_FAB]  	// 20-Alerta
		aTail( ::oListaProdutos:aListaProdutos ):CWSB1_CAPACID	 := aListEstoque[nProd][nPosB1_CAP]  	// 20-Alerta
		aTail( ::oListaProdutos:aListaProdutos ):CWSB1_VOLTAGE	 := aListEstoque[nProd][nPosB1_VOL]  	// 20-Alerta

		//Carrega os Saldos em Estoque
		nLinha := Len( ::oListaProdutos:aListaProdutos )
		::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo := {}
		For nSld := 01 To Len( aListEstoque[nProd][nPosB2_SALDO] )

			aAdd( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo, WsClassNew( "oStructSaldoProduto" ) )
			aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):cEmpresaFilial	:= aListEstoque[nProd][nPosB2_SALDO][nSld][01]
			aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):cDescricao		:= FRetDescEmpFil( aListEstoque[nProd][nPosB2_SALDO][nSld][01] )//aListEstoque[nProd][nPosB2_SALDO][nSld][02]
			aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoAtual	:= Round( aListEstoque[nProd][nPosB2_SALDO][nSld][03], 02 )
			aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoStr		:= AllTrim( TransForm( aListEstoque[nProd][nPosB2_SALDO][nSld][03], "@E 999999999999.99" ) )  // Replace( AllTrim( TransForm( aListEstoque[nProd][nPosB2_SALDO][nSld][02], "@E 999999999999,99" ) ), ",", "." )

		Next nSld

		If nProd > nLimite
			Exit
		EndIf

	Next nProd

	If Len( ::oListaProdutos:aListaProdutos ) == 0

		aAdd( ::oListaProdutos:aListaProdutos, WSClassNew( "oStructProduto" ) )

		//ConOut( "ETAPA 6" )
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_COD    	 := ""    		// 03-Codigo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_DESC   	 := ""   		// 04-Descricao
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_TIPO   	 := ""   		// 05-Tipo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_UM     	 := ""     		// 06-Unidade
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_LOCPAD 	 := "" 			// 07-Armazem Pad.
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_GRUPO  	 := ""  		// 08-Grupo
		aTail( ::oListaProdutos:aListaProdutos ):cWSBM_DESC 	 := ""  		// 09-Descrição do Grupo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_CATEGOR 	 := "" 	 		// 10-Categoria
		aTail( ::oListaProdutos:aListaProdutos ):cWSZ1_DESC 	 := ""  		// 11-Descrição da Categoria
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_LINHA  	 := ""  		// 12-Linha
		aTail( ::oListaProdutos:aListaProdutos ):cWSZ2_DESC  	 := ""  		// 13-Descrição da Linha
		aTail( ::oListaProdutos:aListaProdutos ):nWSB1_PRV1   	 := 0   		// 14-Preco Venda
		aTail( ::oListaProdutos:aListaProdutos ):nWSB1_PESO   	 := 0   		// 15-Peso Liquido
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_CODBAR 	 := "" 			// 16-Cod Barras
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_TS        := "" 			// 17-Cod Barras
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_ATIVO  	 := ""  		// 18-Ativo
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_XOBSERV	 := ""  		// 19-Observação
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_XALERTA	 := ""  		// 19-Alerta
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_FABRIC	 := ""  		// 19-Alerta
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_CAPACID	 := ""  		// 19-Alerta
		aTail( ::oListaProdutos:aListaProdutos ):cWSB1_VOLTAGE	 := ""  		// 19-Alerta

		//Carrega os Saldos em Estoque
		nLinha := Len( ::oListaProdutos:aListaProdutos )
		::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo := {}
		aAdd( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo, WsClassNew( "oStructSaldoProduto" ) )
		aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):cEmpresaFilial	:= ""
		aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):cDescricao		:= ""
		aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoAtual	:= 0.00
		aTail( ::oListaProdutos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoStr		:= "0,00"

	EndIf

	ConOut( "ETAPA 10" )

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE PRODUTOS ________________________________" )

	lSucesso 	 := .T.
	::cRetornoWS := "0"

	ConOut( "ETAPA 12" )

Return .T.


WSMethod ListaProdutosAlternativos WSReceive cAlterEmpFiliais, cAlterProdutos WSSend oListaAlternativos WSService oWsUnica

	Local cQuery 					:= ""
	Local aEmpresas	 				:= {}
	Local lSucesso 					:= .T.
	Local cAliasAlter 				:= GetNextAlias()

	Default cAlterEmpFiliais	:= ""
	Default cAlterProdutos		:= ""

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE PRODUTOS ALTERNATIVOS ________________________________" )

	aAreaSM0 := GetArea()

	lParamWebService	:= .T.
	aEmpresas 			:= {}

	aEmpresas 			:= {}
	DbSelectArea( "SM0" )
	SM0->( DbGoTop() )
	Do While !SM0->( Eof() )

		ConOut( "Entrei aqui " + SM0->M0_CODFIL + " - " + SM0->M0_FILIAL )
		If AllTrim( SM0->M0_CODIGO ) != "99"

			If AllTrim( cAlterEmpFiliais ) == ""
				aAdd( aEmpresas, { SM0->M0_CODFIL, SM0->M0_FILIAL } )
				ConOut( "Vai Considerar " + SM0->M0_CODFIL + " - " + SM0->M0_FILIAL )
			Else
				If ( AllTrim( SM0->M0_CODFIL ) $ AllTrim( cAlterEmpFiliais ) )
					aAdd( aEmpresas, { SM0->M0_CODFIL, SM0->M0_FILIAL } )
					ConOut( "Vai Considerar " + SM0->M0_CODFIL + " - " + SM0->M0_FILIAL )
				EndIf
			EndIf

		EndIf

		DbSelectArea( "SM0" )
		SM0->( DbSkip() )
	EndDo


	cQuery := " 	SELECT 	DISTINCT  "
	cQuery += "			B1_COD    	, "	// Codigo
	cQuery += "			B1_DESC   	, "	// Descricao
	cQuery += "			B1_TIPO   	, "	// Tipo
	cQuery += "			B1_UM     	, "	// Unidade
	cQuery += "			B1_LOCPAD 	, "	// Armazem Pad.
	cQuery += "			B1_GRUPO  	, "	// Grupo
	cQuery += "			BM_DESC     , " // Descrição Grupo
	cQuery += "			B1_CATEGOR 	, " // Categoria
	cQuery += "			Z1_DESC		, " // Descrição Categoria
	cQuery += "			B1_LINHA 	, " // Linha
	cQuery += "			Z2_DESC		, " // Descrição Linha
	cQuery += "			B1_PESO   	, "	// Peso Liquido
	cQuery += "			B1_CODBAR 	, "	// Cod Barras
	cQuery += "			B1_TS	 	, "	// Cod Barras
	cQuery += "			RTRIM( LTRIM( CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B1_XOBSERV ) ) ) )AS B1_XOBSERV	, "	// Observação
	cQuery += "			RTRIM( LTRIM( CONVERT( VARCHAR( 4000 ), CONVERT( VARBINARY( 4000 ), B1_XALERTA ) ) ) )AS B1_XALERTA	, "	// Alerta
	cQuery += "			B1_MSBLQL 	  "	// Blq. de Tela
	cQuery += " 	   FROM " + RetSQLName( "SB1" ) + " SB1, "
	cQuery += "				" + RetSQLName( "SBM" ) + " SBM, "
	cQuery += "		  		" + RetSQLName( "SZ1" ) + " SZ1, "
	cQuery += "		  		" + RetSQLName( "SZ2" ) + " SZ2, "
	cQuery += "	        	" + RetSQLName( "SGI" ) + " SGI  "
	cQuery += "	      WHERE SB1.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SBM.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SZ1.D_E_L_E_T_   = ' '  "
	cQuery += "	        AND SZ2.D_E_L_E_T_   = ' '  "
	cQuery += "	  		AND SGI.D_E_L_E_T_ 	 = ' ' 	"
	cQuery += "	        AND SB1.B1_FILIAL    = '" + XFilial( "SB1" ) + "' "
	cQuery += "	        AND SBM.BM_FILIAL    = '" + XFilial( "SBM" ) + "' "
	cQuery += "	        AND SZ1.Z1_FILIAL    = '" + XFilial( "SZ1" ) + "' "
	cQuery += "	        AND SZ2.Z2_FILIAL    = '" + XFilial( "SZ2" ) + "' "
	cQuery += "	        AND SGI.GI_FILIAL    = '" + XFilial( "SGI" ) + "' "
	cQuery += "		    AND B1_GRUPO 		 = BM_GRUPO    "
	cQuery += "		    AND B1_CATEGOR       = Z1_CATEGOR  "
	cQuery += "		    AND B1_LINHA	     = Z2_LINHA	   "
	cQuery += "			AND B1_COD 			 = GI_PRODALT  "
	If AllTrim( cAlterProdutos ) != ""
		cQuery += "		AND GI_PRODORI IN " + FormatIN( cAlterProdutos, "," )
	EndIf
	cONoUT( cQuery )
	If Select( cAliasAlter ) > 0
		( cAliasAlter )->( DbCloseArea() )
	EndIf

	nLimite := 250

	::oListaAlternativos:aListaProdutos := {}
	TcQuery cQuery Alias ( cAliasAlter ) New
	Do While !( cAliasAlter )->( Eof() )

		Conout( " ETAPA 3" )
		aAdd( ::oListaAlternativos:aListaProdutos, WSClassNew( "oStructProduto" ) )

		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_COD    	 := ( cAliasAlter )->B1_COD   		// 01-Codigo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_DESC   	 := ( cAliasAlter )->B1_DESC   		// 02-Descricao
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_TIPO   	 := ( cAliasAlter )->B1_TIPO   		// 03-Tipo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_UM     	 := ( cAliasAlter )->B1_UM     		// 04-Unidade
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_LOCPAD 	 := ( cAliasAlter )->B1_LOCPAD 		// 05-Armazem Pad.
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_GRUPO  	 := ( cAliasAlter )->B1_GRUPO  		// 06-Grupo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSBM_DESC 	 := ( cAliasAlter )->BM_DESC  		// 07-Descrição do Grupo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_CATEGOR 	 := ( cAliasAlter )->B1_CATEGOR  	// 08-Categoria
		aTail( ::oListaAlternativos:aListaProdutos ):cWSZ1_DESC 	 := ( cAliasAlter )->Z1_DESC  		// 09-Descrição da Categoria
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_LINHA  	 := ( cAliasAlter )->B1_LINHA  		// 10-Linha
		aTail( ::oListaAlternativos:aListaProdutos ):cWSZ2_DESC  	 := ( cAliasAlter )->Z2_DESC  		// 11-Descrição da Linha

		nPreco := U_UNIRetPreco( ( cAliasAlter )->B1_COD )
		aTail( ::oListaAlternativos:aListaProdutos ):nWSB1_PRV1   	 := nPreco					   		// 12-Preco Venda
		aTail( ::oListaAlternativos:aListaProdutos ):nWSB1_PESO   	 := ( cAliasAlter )->B1_PESO   		// 13-Peso Liquido
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_CODBAR 	 := ( cAliasAlter )->B1_CODBAR 		// 14-Cod Barras
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_TS        := ( cAliasAlter )->B1_TS 			// 15-Cod Barras
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_ATIVO  	 := ( cAliasAlter )->B1_MSBLQL 		// 16-Ativo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_XOBSERV	 := ( cAliasAlter )->B1_XOBSERV  	// 17-Observação
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_XALERTA	 := ( cAliasAlter )->B1_XALERTA  	// 18-Alerta

		Conout( " ETAPA 4" )
		//Carrega os Saldos em Estoque
		nLinha := Len( ::oListaAlternativos:aListaProdutos )
		::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo := {}
		For nY := 01 To Len( aEmpresas )

			Conout( " ETAPA 5" )

			aAdd( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo, WsClassNew( "oStructSaldoProduto" ) )

			nSaldo := U_UNIRetSldProd( aEmpresas[nY][01], ( cAliasAlter )->B1_TIPO, ( cAliasAlter )->B1_COD )
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):cEmpresaFilial	:= aEmpresas[nY][01]
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):cDescricao		:= FRetDescEmpFil( aEmpresas[nY][01] ) //aEmpresas[nY][02]
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoAtual	:= Round( nSaldo, 02 )
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoStr		:= AllTrim( TransForm( Round( nSaldo, 02 ), "@E 999999999999.99" ) ) // Replace( AllTrim( TransForm( Round( nSaldo, 02 ), "@E 999999999999.99" ) ), ",", "." )

		Next nSld

		Conout( " ETAPA 6" )
		If nLinha > nLimite
			Conout( " ETAPA 10" )
			Exit
		EndIf

		DbSelectArea( cAliasAlter )
		( cAliasAlter )->( DbSkip() )
	EndDo
	( cAliasAlter )->( DbCloseArea() )

	Conout( " ETAPA 11" )
	If Len( ::oListaAlternativos:aListaProdutos ) == 0

		Conout( " ETAPA 7" )
		::oListaAlternativos:aListaProdutos := {}
		aAdd( ::oListaAlternativos:aListaProdutos, WSClassNew( "oStructProduto" ) )

		//ConOut( "ETAPA 6" )
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_COD    	 := ""   	// 01-Codigo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_DESC   	 := ""   	// 02-Descricao
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_TIPO   	 := ""  	// 03-Tipo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_UM     	 := ""     	// 04-Unidade
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_LOCPAD 	 := "" 		// 05-Armazem Pad.
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_GRUPO  	 := ""  	// 06-Grupo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSBM_DESC 	 := ""  	// 07-Descrição do Grupo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_CATEGOR 	 := ""  	// 08-Categoria
		aTail( ::oListaAlternativos:aListaProdutos ):cWSZ1_DESC 	 := ""  	// 09-Descrição da Categoria
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_LINHA  	 := ""  	// 10-Linha
		aTail( ::oListaAlternativos:aListaProdutos ):cWSZ2_DESC  	 := ""  	// 11-Descrição da Linha
		aTail( ::oListaAlternativos:aListaProdutos ):nWSB1_PRV1   	 := 0   	// 12-Preco Venda
		aTail( ::oListaAlternativos:aListaProdutos ):nWSB1_PESO   	 := 0   	// 13-Peso Liquido
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_CODBAR 	 := "" 		// 14-Cod Barras
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_TS        := "" 		// 15-Cod Barras
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_ATIVO  	 := ""  	// 16-Ativo
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_XOBSERV	 := ""	 	// 17-Observação
		aTail( ::oListaAlternativos:aListaProdutos ):cWSB1_XALERTA	 := ""	 	// 18-Alerta

		Conout( " ETAPA 8" )
		//Carrega os Saldos em Estoque
		nLinha := Len( ::oListaAlternativos:aListaProdutos )
		::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo := {}
		ConOut( "Len aEmpresas " + cValToChar( Len( aEmpresas )  ) )
		For nY := 01 To Len( aEmpresas )

			Conout( " ETAPA 9" )
			aAdd( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo, WsClassNew( "oStructSaldoProduto" ) )
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):cEmpresaFilial	:= aEmpresas[nY][01]
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):cDescricao		:= FRetDescEmpFil( aEmpresas[nY][01] ) //aEmpresas[nY][02]
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoAtual	:= 0.00
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoStr		:= "0,00"

		Next nSld

		If Len( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ) == 0

			Conout( " ETAPA 10" )
			aAdd( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo, WsClassNew( "oStructSaldoProduto" ) )
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):cEmpresaFilial	:= ""
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):cDescricao		:= ""
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoAtual	:= 0
			aTail( ::oListaAlternativos:aListaProdutos[nLinha]:aListaSaldo ):nSaldoStr		:= "0,00"

		EndIf

	EndIf

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE PRODUTOS ALTERNATIVOS ________________________________" )

	lSucesso 	 := .T.
	::cRetornoWS := "0"

Return .T.

*----------------------------------------------------------*
Static Function FIntCliente( oParamCliente, nParamRecNoSA1 )
	*----------------------------------------------------------*
	Local lRet  			:= .T.
	Local aExecAuto 		:= {}
	Default nParamRecNoSA1 	:= 00

	ConOut( "FINTCLIENTE 1" )

	aExecAuto 				:= {}
	DbSelectArea( "SA1" )
	If nParamRecNoSA1 > 0

		ConOut( "FCLIENTE 2" )
		SA1->( DbGoTo( nParamRecNoSA1 ) )
		nAuxOpc	:= 04

		aAdd( aExecAuto, { "A1_PESSOA" , SA1->A1_PESSOA	, Nil } )
		aAdd( aExecAuto, { "A1_CGC"    , SA1->A1_CGC	, Nil } )
		aAdd( aExecAuto, { "A1_TIPO"   , SA1->A1_TIPO	, Nil } )  //F Final???
		aAdd( aExecAuto, { "A1_FILIAL" , SA1->A1_FILIAL	, Nil } )
		aAdd( aExecAuto, { "A1_COD"	   , SA1->A1_COD	, Nil } )
		aAdd( aExecAuto, { "A1_LOJA"   , SA1->A1_LOJA	, Nil } )

		If AllTrim( SA1->A1_PESSOA ) == "F"
			cContrib 	:= "2"
			cEntId		:= "00"
		Else
			cContrib 	:= "1"
			cEntId		:= "00"
		EndIf

	Else

		ConOut( "FCLIENTE 3" )
		nAuxOpc		:= 03
		//cAuxCodigo 	:= GetSXENum( "SA1", "A1_COD" )
		//cAuxLoja 	:= PadL( "0", TamSX3( "A1_LOJA" )[01], "0" )
		cAuxCGC		:= oParamCliente:cCPF_CNPJ
		cAuxPessoa  := oParamCliente:cTipoPessoa
		cAuxTipo    := oParamCliente:cTipoCliente

		If AllTrim( cAuxPessoa ) == "F"
			cAuxCodigo 	:= Left( cAuxCGC, 09 ) //GetSXENum( "SA1", "A1_COD" )
			cAuxLoja 	:= "PF"
			cContrib 	:= "2"
			cEntId		:= "00"
		Else
			cAuxCodigo 	:= Left( cAuxCGC, 08 ) //GetSXENum( "SA1", "A1_COD" )
			cAuxLoja 	:= SubStr( cAuxCGC, 09, 04 )
			cContrib 	:= "1"
			cEntId		:= "00"
		EndIf

		aAdd( aExecAuto, { "A1_FILIAL" , XFilial( "SA1" )						 , Nil } )
		aAdd( aExecAuto, { "A1_PESSOA" , cAuxPessoa								 , Nil } )
		aAdd( aExecAuto, { "A1_CGC"    , cAuxCGC								 , Nil } )
		aAdd( aExecAuto, { "A1_TIPO"   , cAuxTipo								 , Nil } )  //F Final???
		aAdd( aExecAuto, { "A1_COD"	   , cAuxCodigo								 , Nil } )
		aAdd( aExecAuto, { "A1_LOJA"   , cAuxLoja								 , Nil } )
		//aAdd( aExecAuto, { "A1_XIDFLUI", oParamCliente:cIdFluig  , Nil } )

	EndIf

	ConOut( "FCLIENTE 4" )

	aAdd( aExecAuto, { "A1_NOME"  	, FWNoAccent( oParamCliente:cNomeCompleto )								 , Nil } )
	aAdd( aExecAuto, { "A1_NREDUZ"	, FWNoAccent( oParamCliente:cNomeReduzido )								 , Nil } )
	If oParamCliente:cContato != Nil .And. oParamCliente:cContato != ""
		aAdd( aExecAuto, { "A1_CONTATO" , FWNoAccent( oParamCliente:cContato )								 , Nil } )
	EndIf
	If oParamCliente:cDataNascimento != Nil .And. oParamCliente:cDataNascimento != ""
		aAdd( aExecAuto, { "A1_DTNASC"  , SToD( oParamCliente:cDataNascimento ) 								 , Nil } )
	EndIf

	//Else
	//	aAdd( aExecAuto, { "A1_INSCR"   , "ISENTO"			 								 				 , Nil } )
	//EndIf
	If oParamCliente:cInscrMunicipal != Nil .And. oParamCliente:cInscrMunicipal != ""
		aAdd( aExecAuto, { "A1_INSCRM"  , oParamCliente:cInscrMunicipal			 								 , Nil } )
	EndIf

	ConOut( "FCLIENTE 5" )

	If oParamCliente:cRegiao != Nil .And. oParamCliente:cRegiao != ""
		aAdd( aExecAuto, { "A1_REGIAO"	, FWNoAccent( oParamCliente:cRegiao )		, Nil } )
	EndIf
	If oParamCliente:cRGCedEstr != Nil .And. oParamCliente:cRGCedEstr != ""
		aAdd( aExecAuto, { "A1_PFISICA"	, FWNoAccent( oParamCliente:cRGCedEstr )	, Nil } )
	EndIf
	aAdd( aExecAuto, { "A1_EMAIL"	, oParamCliente:cEmail 						, Nil } )

	If oParamCliente:cHomePage != Nil .And. oParamCliente:cHomePage != ""
		aAdd( aExecAuto, { "A1_HPAGE"	, oParamCliente:cHomePage 					, Nil } )
	EndIf
	aAdd( aExecAuto, { "A1_MSBLQL"	, oParamCliente:cStatus 					, Nil } )

	ConOut( "FCLIENTE 5.1" )

	If oParamCliente:cNatureza != Nil .And. oParamCliente:cNatureza != ""
		aAdd( aExecAuto, { "A1_NATUREZ"	, oParamCliente:cNatureza 					, Nil } )
	EndIf
	If oParamCliente:cEndCentralCompras != Nil .And. oParamCliente:cEndCentralCompras != ""
		aAdd( aExecAuto, { "A1_ENDREC"	, oParamCliente:cEndCentralCompras			, Nil } )
	EndIf
	If oParamCliente:cVendedor != Nil .And. oParamCliente:cVendedor != ""
		aAdd( aExecAuto, { "A1_VEND"	, oParamCliente:cVendedor 					, Nil } )
	EndIf
	If oParamCliente:nComissao != Nil
		aAdd( aExecAuto, { "A1_COMIS"	, oParamCliente:nComissao 					, Nil } )
	EndIf
	If oParamCliente:cContaContabil != Nil .And. oParamCliente:cContaContabil != ""
		aAdd( aExecAuto, { "A1_CONTA"	, oParamCliente:cContaContabil				, Nil } )
	Else
		aAdd( aExecAuto, { "A1_CONTA"	, "11201001"								, Nil } )
	EndIf

	ConOut( "FCLIENTE 5.2" )

	If oParamCliente:cBanco != Nil .And. oParamCliente:cBanco != ""
		aAdd( aExecAuto, { "A1_BCO1"	, oParamCliente:cBanco						, Nil } )
	EndIf
	If oParamCliente:cTipoFrete != Nil .And. oParamCliente:cTipoFrete != ""
		aAdd( aExecAuto, { "A1_TPFRET"	, oParamCliente:cTipoFrete					, Nil } )
	EndIf
	If oParamCliente:cTipoPJ != Nil .And. oParamCliente:cTipoPJ != ""
		aAdd( aExecAuto, { "A1_TPJ"		, oParamCliente:cTipoPJ						, Nil } )
	EndIf
	If oParamCliente:cTransportadora != Nil .And. oParamCliente:cTransportadora != ""
		aAdd( aExecAuto, { "A1_TRANSP"	, oParamCliente:cTransportadora				, Nil } )
	EndIf
	If oParamCliente:cCondicaoPagamento != Nil .And. oParamCliente:cCondicaoPagamento != ""
		aAdd( aExecAuto, { "A1_COND"	, oParamCliente:cCondicaoPagamento			, Nil } )
	EndIf
	If oParamCliente:cTabelaPreco != Nil .And. oParamCliente:cTabelaPreco != ""
		aAdd( aExecAuto, { "A1_TABELA"	, oParamCliente:cTabelaPreco				, Nil } )
	EndIf

	ConOut( "FCLIENTE 5.3" )

	// Definição do Endereço Principal
	aAdd( aExecAuto, { "A1_END"		, Upper( FWNoAccent( oParamCliente:oEnderercoPrincipal:cLogradouro  )	), Nil } )
	If oParamCliente:oEnderercoPrincipal:cComplemento != Nil .And. oParamCliente:oEnderercoPrincipal:cComplemento != ""
		aAdd( aExecAuto, { "A1_COMPLEM"	, Upper( FWNoAccent( oParamCliente:oEnderercoPrincipal:cComplemento )	), Nil } )
	EndIf
	aAdd( aExecAuto, { "A1_BAIRRO"	, Upper( FWNoAccent( oParamCliente:oEnderercoPrincipal:cBairro 	   )	), Nil } )

	aAdd( aExecAuto, { "A1_ESTADO"	, Upper( FRetEstado( oParamCliente:oEnderercoPrincipal:cUF  ) 	), Nil } )

	aAdd( aExecAuto, { "A1_EST"		, 					 oParamCliente:oEnderercoPrincipal:cUF	 	 	 , Nil } )
	aAdd( aExecAuto, { "A1_CEP"		,  Replace( Replace( oParamCliente:oEnderercoPrincipal:cCEP, "-", "" ), ".", "" ), Nil } )

	ConOut( "FCLIENTE 5.4" )

	cAuxCodMun := U_UNIRetMunicipio( oParamCliente:oEnderercoPrincipal:cNomeMunicipio, oParamCliente:oEnderercoPrincipal:cUF )
	ConOut( "FCLIENTE 5.5" )
	If AllTrim( oParamCliente:oEnderercoPrincipal:cCodigoMunicipio ) != ""
		aAdd( aExecAuto, { "A1_COD_MUN"	, 					 oParamCliente:oEnderercoPrincipal:cCodigoMunicipio	 , Nil } )
		//	aAdd( aExecAuto, { "A1_CODMUN"	, 					 oParamCliente:oEnderercoPrincipal:cCodigoMunicipio	 , Nil } )
	Else
		If AllTrim( cAuxCodMun ) != ""
			aAdd( aExecAuto, { "A1_COD_MUN"	, 				 cAuxCodMun	 , Nil } )
		EndIf
	EndIf
	ConOut( "FCLIENTE 5.6" )

	aAdd( aExecAuto, { "A1_MUN"		, Upper( FWNoAccent( oParamCliente:oEnderercoPrincipal:cNomeMunicipio )	), Nil } )
	If AllTrim( oParamCliente:oEnderercoPrincipal:cCodigoPais ) != ""
		aAdd( aExecAuto, { "A1_CODPAIS"	, 					 oParamCliente:oEnderercoPrincipal:cCodigoPais	 	 , Nil } )
	Else
		aAdd( aExecAuto, { "A1_CODPAIS"	, 					 "01058"														 	 , Nil } )
	EndIf
	ConOut( "FCLIENTE 5.7" )

	//If oParamCliente:cInscrEstadual != Nil .And. oParamCliente:cInscrEstadual != ""
	If AllTrim( cContrib ) == "2"
		aAdd( aExecAuto, { "A1_INSCR"   , ""									 							 , Nil } )
	Else
		aAdd( aExecAuto, { "A1_INSCR"   , oParamCliente:cInscrEstadual			 							 , Nil } )
	EndIf

	//If AllTrim( oParamCliente:oEnderercoCobranca:cNomePais ) == "BRASIL"
	If AllTrim( oParamCliente:oEnderercoPrincipal:cPais ) == ""
		ConOut( "FCLIENTE 5.7.1" )
		aAdd( aExecAuto, { "A1_PAIS"	, 					 "105"														 	 	 , Nil } )
	Else
		ConOut( "FCLIENTE 5.7.2" )
		aAdd( aExecAuto, { "A1_PAIS"	, AllTrim( oParamCliente:oEnderercoPrincipal:cPais )					 , Nil } )
	EndIf
	ConOut( "FCLIENTE 5.8" )

	// Definição do Endereço de Cobrança
	aAdd( aExecAuto, { "A1_ENDCOB"		, Upper( FWNoAccent( oParamCliente:oEnderercoCobranca:cLogradouro  )	), Nil } )
	//aAdd( aExecAuto, { "A1_COMPCOB"	, Upper( FWNoAccent( oParamCliente:oEnderercoCobranca:cComplemento )	), Nil } )
	aAdd( aExecAuto, { "A1_BAIRROC"		, Upper( FWNoAccent( oParamCliente:oEnderercoCobranca:cBairro 	   )	), Nil } )
	//aAdd( aExecAuto, { "A1_ESTADOC"	, Upper( FWNoAccent( oParamCliente:oEnderercoCobranca:cEstado  ) 	), Nil } )
	aAdd( aExecAuto, { "A1_ESTC"		, 					 oParamCliente:oEnderercoCobranca:cUF	 	 	 , Nil } )
	aAdd( aExecAuto, { "A1_CEPC"		, 			Replace( Replace( oParamCliente:oEnderercoCobranca:cCEP, "-", "" ), ".", "" )	 	 	 	 , Nil } )

	ConOut( "FCLIENTE 5.9" )

	/*
cAuxCodMun := U_UNIRetMunicipio( oParamCliente:oEnderercoCobranca:cNomeMunicipio, oParamCliente:oEnderercoCobranca:cUF )
If AllTrim( oParamCliente:oEnderercoCobranca:cCodigoMunicipio ) != ""
	aAdd( aExecAuto, { "A1_COD_MUNC"	, 					 oParamCliente:oEnderercoCobranca:cCodigoMunicipio	 , Nil } )
	aAdd( aExecAuto, { "A1_CODMUNC"	, 					 oParamCliente:oEnderercoCobranca:cCodigoMunicipio	 , Nil } )
Else
	If AllTrim( cAuxCodMun ) != ""
		aAdd( aExecAuto, { "A1_COD_MUNC"	, 					 cAuxCodMun	 , Nil } )
	EndIf
EndIf
	*/

	aAdd( aExecAuto, { "A1_MUNC"		, Upper( FWNoAccent( oParamCliente:oEnderercoCobranca:cNomeMunicipio )	), Nil } )

	/*
If AllTrim( oParamCliente:oEnderercoCobranca:cCodigoPais ) != ""
	aAdd( aExecAuto, { "A1_CODPAIS"	, 					 oParamCliente:oEnderercoCobranca:cCodigoPais	 	 , Nil } )
Else
	aAdd( aExecAuto, { "A1_CODPAIS"	, 					 "01058"														 	 , Nil } )
EndIf
If AllTrim( oParamCliente:oEnderercoCobranca:cNomePais ) == "BRASIL"
	aAdd( aExecAuto, { "A1_PAIS"	, 					 "105"														 	 	 , Nil } )
EndIf

aAdd( aExecAuto, { "A1_EMAIL"		, 					 oParamCliente:oEnderercoCobranca:cEmail , Nil } )
	*/

	ConOut( "FCLIENTE 6" )

	aAdd( aExecAuto, { "A1_ENDENT"	, Upper( FWNoAccent( oParamCliente:oEnderercoEntrega:cLogradouro ) 		), Nil } )
	If oParamCliente:oEnderercoEntrega:cComplemento != Nil .And. oParamCliente:oEnderercoEntrega:cComplemento != ""
		aAdd( aExecAuto, { "A1_COMPENT"	, Upper( FWNoAccent( oParamCliente:oEnderercoEntrega:cComplemento )		), Nil } )
	EndIf
	aAdd( aExecAuto, { "A1_BAIRROE"	, Upper( FWNoAccent( oParamCliente:oEnderercoEntrega:cBairro )			), Nil } )
	//aAdd( aExecAuto, { "A1_ESTADE"	, Upper( FWNoAccent( oParamCliente:oEnderercoEntrega:cEstado )	 	)	 , Nil } )
	aAdd( aExecAuto, { "A1_ESTE"	, 					 oParamCliente:oEnderercoEntrega:cUF 		 	 	 , Nil } )
	aAdd( aExecAuto, { "A1_CEPE"	,  Replace( Replace( oParamCliente:oEnderercoEntrega:cCEP, ".", "" ), "-", "" ), Nil } )

	cAuxECodMun := U_UNIRetMunicipio( oParamCliente:oEnderercoEntrega:cNomeMunicipio, oParamCliente:oEnderercoEntrega:cUF )
	If oParamCliente:oEnderercoEntrega:cCodigoMunicipio != Nil .And. AllTrim( oParamCliente:oEnderercoEntrega:cCodigoMunicipio ) != ""
		aAdd( aExecAuto, { "A1_CODMUNE"	, 					 oParamCliente:oEnderercoEntrega:cCodigoMunicipio	 , Nil } )
	Else
		If AllTrim( cAuxECodMun ) != ""
			aAdd( aExecAuto, { "A1_CODMUNE"	, 					 cAuxECodMun	 , Nil } )
		EndIf
	EndIf
	aAdd( aExecAuto, { "A1_MUNE"	, Upper( FWNoAccent( oParamCliente:oEnderercoEntrega:cNomeMunicipio )	), Nil } )
	//If AllTrim( oParamCliente:oEnderercoEntrega:cNomePais ) == "BRASIL"
	//	aAdd( aExecAuto, { "A1_PAISE"	, 					 "105"	 	 	 , Nil } )
	//EndIf
	//If AllTrim( oParamCliente:oEnderercoEntrega:cPais ) == ""
	//	aAdd( aExecAuto, { "A1_PAISE"	, 					 "105"														 	 	 , Nil } )
	//Else
	//	aAdd( aExecAuto, { "A1_PAISE"	, AllTrim( oParamCliente:oEnderercoEntrega:cCodPais )					 , Nil } )
	//EndIf

	ConOut( "FCLIENTE 7" )

	//If AllTrim( oParamCliente:oEnderercoCobranca:cDDI ) != ""
	//	aAdd( aExecAuto, { "A1_DDI"	, 					 oParamCliente:oEnderercoCobranca:cDDI	 	 	 	 , Nil } )
	//Else
	//	aAdd( aExecAuto, { "A1_DDI"	, 					 "55"													 	 	 	 , Nil } )
	//EndIf
	aAdd( aExecAuto, { "A1_DDD"		, 					 oParamCliente:cDDD	 	 	 	 , Nil } )
	aAdd( aExecAuto, { "A1_TEL"		, 					 oParamCliente:cTelefone	 	 	 , Nil } )
	If oParamCliente:cFax != Nil .And. oParamCliente:cFax != ""
		aAdd( aExecAuto, { "A1_FAX"		, 					 oParamCliente:cFax	 	 	 	 , Nil } )
	EndIf

	//If nAuxOpc == 03

	//If oParamCliente:cContrib != Nil
	//	aAdd( aExecAuto, { "A1_CONTRIB"	, 					 oParamCliente:cContrib	 	 	 , Nil } )
	//EndIf
	//If oParamCliente:cEntId != Nil
	//	aAdd( aExecAuto, { "A1_ENTID"	, 					 oParamCliente:cEntId	 	 	 , Nil } )
	//EndIf

	aAdd( aExecAuto, { "A1_CONTRIB"	, 					 cContrib	 	 , Nil } )
	aAdd( aExecAuto, { "A1_ENTID"	, 					 cEntId	 	 	 , Nil } )

	//EndIf

	aAdd( aExecAuto, { "A1_DDD"		, 					 oParamCliente:cDDD	 	 	 	 , Nil } )

	//If AllTrim( oParamCliente:oEnderercoCobranca:cFax ) != ""
	//	aAdd( aExecAuto, { "A1_DDI"		, 					 oParamCliente:oEnderercoCobranca:cEmail	 	 	 , Nil } )
	//EndIf
	//aAdd( aExecAuto, { "A1_XIDFLUI"	, 					 oParamCliente:oEnderercoCobranca:cIdFluig	 	 	 , Nil } )

	ConOut( "FCLIENTE 8" )
	U_UNIDebugExecAuto( "MATA030", nAuxOpc, aExecAuto )
	lMsErroAuto := .F.
	MsExecAuto( { |x, y| MATA030( x, y ) }, aExecAuto, nAuxOpc )
	If lMsErroAuto

		RollbackSX8()
		cMsgErro := "Erro ao tentar integrar as informações do Cadastro de Clientes oriundas do Fluig. " + MostraErro( "-", "-" )
		ConOut( "FCLIENTE 9" )
		ConOut( "Erro ao tentar integrar as informações do Cadastro de Clientes oriundas do Fluig." )
		ConOut( "MOSTRAERRO - " + MostraErro( "-", "-" ) )
		SetSoapFault( cMsgErro, "", SOAPFAULT_RECEIVER )
		lRet := .F.

	Else

		ConOut( "FCLIENTE 10" )
		ConfirmSX8()
		lRet := .T.

	EndIf

	ConOut( "FCLIENTE 11" )

Return lRet

/*
*------------------------------------------------------------------------*
Static Function FRetSldProduto( cParamEmpresa, cParamTipo, cParamProduto )
*------------------------------------------------------------------------*
Local aAreaAtu 	:= GetArea()
Local nRet 		:= 0
Local cQuery 	:= ""
Local cAliasSld := "SLDTMP"

If AllTrim( cParamTipo ) == "PA"

	cQuery := "	SELECT ISNULL( SUM( B2_QATU - B2_QEMP - B2_RESERVA ), 0 ) SALDO " + CRLF
	cQuery += "	  FROM " + RetSQLName( "SB2" ) + " SB2 "
	cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "	   AND B2_FILIAL  = '" + cParamEmpresa + "' "
	cQuery += "	   AND B2_COD     = '" + cParamProduto + "' "
	If Select( cAliasSld ) > 0
		( cAliasSld )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSld ) New
	If !( cAliasSld )->( Eof() )
		nRet := ( cAliasSld )->SALDO
	EndIf
	( cAliasSld )->( DbCloseArea() )

Else

	aRetKit := StaticCall( UNIA003, FRetEstrutura, cParamProduto )
	//aRetKit := FRetEstrutura( cParamProduto )
	// 01 - Código do Componente
	// 02 - Quantidade para Produção
	// 03 - Saldo em Estoque do Componente
	// 04 - Quantidade Possível de Produção
	nPosCodigo 			:= 01
	nPosQtdComponente 	:= 02
	nPosSldComponente   := 03
	nPosQtdPossivel     := 04

	If Len( aRetKit ) > 0

		nQtdProducaoPossivel := 0
		For nK := 01 To Len( aRetKit )

			// Tratativa para Conjuntos ( Kits )
			cQuery := "	SELECT ISNULL( SUM( B2_QATU - B2_QEMP - B2_RESERVA ), 0 ) SALDO " + CRLF
			cQuery += "	  FROM SB2" + cParamEmpresa + "0 SB2 "
			cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
			cQuery += "	   AND B2_COD     = '" + cParamProduto + "' "
			If Select( cAliasSld ) > 0
				( cAliasSld )->( DbCloseArea() )
			EndIf
			TcQuery cQuery Alias ( cAliasSld ) New
			If !( cAliasSld )->( Eof() )

				aRetKit[nK][nPosSldComponente] := ( cAliasSld )->SALDO
				If ( cAliasSld )->SALDO > aRetKit[nK][nPosQtdComponente] // Quantidade necessária para a Produção
					aRetKit[nK][nPosQtdPossivel] := Int( ( cAliasSld )->SALDO / aRetKit[nK][nPosQtdComponente] )
				Else
					aRetKit[nK][nPosQtdPossivel] := 0
				EndIf

			EndIf
			( cAliasSld )->( DbCloseArea() )

		Next nK

		nRet := aRetKit[01][nPosQtdPossivel]
		For nK := 01 To Len( aRetKit )

			If aRetKit[nK][nPosQtdPossivel] == 0
				nRet := 0
				Exit
			Else
				If nRet > aRetKit[01][nPosQtdPossivel]
					nRet := aRetKit[01][nPosQtdPossivel]
				EndIf
			EndIf

		Next nK

	Else

		nRet := 0
		cQuery := "	SELECT ISNULL( SUM( B2_QATU - B2_QEMP - B2_RESERVA ), 0 ) SALDO " + CRLF
		cQuery += "	  FROM SB2" + cParamEmpresa + "0 SB2 "
		cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
		cQuery += "	   AND B2_COD     = '" + cParamProduto + "' "
		If Select( cAliasSld ) > 0
			( cAliasSld )->( DbCloseArea() )
		EndIf
		TcQuery cQuery Alias ( cAliasSld ) New
		If !( cAliasSld )->( Eof() )
			nRet := ( cAliasSld )->SALDO
		EndIf
		( cAliasSld )->( DbCloseArea() )

	EndIf

EndIf

RestArea( aAreaAtu )

Return nRet


Static Function FRetEstrutura( cParamCodKit )

Local aAreaMEV 		:= GetArea()
Local aRetEstrutura := {}

ConOut( "FRetEstrutura 1" )

DbSelectArea( "MEV" ) // Itens do Cadastro de Kits
DbSetOrder( 01 )      // MEV_FILIAL + MEV_CODKIT + MEV_PRODUT
Seek XFilial( "MEV" ) + PadR( cParamCodKit, TamSX3( "MEV_PRODUTO" )[01] )
Do While !MEV->( Eof() ) .And. ;
		 AllTrim( MEV->MEV_FILIAL ) == AllTrim( XFilial( "MEV" ) ) .And. ;
		 AllTrim( MEV->MEV_CODKIT ) == AllTrim( cParamCodKit )

	ConOut( "FRetEstrutura 2" )
	aAdd( aRetEstrutura, {  MEV->MEV_PRODUT	, ;   // Produto
							MEV->MEV_QTD    , ;   // Quantidade do Componente
							0				, ;   // Saldo em Estoque do Componente
							0				} )   // Saldo Possível para Produção de PA
	MEV->( DbSkip() )
EndDo

ConOut( "FRetEstrutura 3" )
RestArea( aAreaMEV )

Return aRetEstrutura
*/

//if nDay == 1 .Or. nDay == 7
//    SetSoapFault( "Metodo não disponível", "Este serviço não funciona no fim de semana." )

*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
User Function FGERAORC( cParamEmpresa, cParamFilial, lParamSchedule, cParamLogin, cParamSenha, aParamCabecalho, aParamItens, aParamCondicoes, nParamOpc, cParamCliente, cParamLoja, lEhEcommerce  )
	*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
	Local cRetMostraErro := ""
	Local oError    	 := ErrorBlock( { |e| cRetMostraErro := e:Description, ConOut( "STARTJOB - FGERAORC - " + cRetMostraErro ) } )
	Local _lAuto         := IsBlind() // ---- LEANDRO RIBEIRO ---- 05/12/2019 ---- //
	Local _nErro      	 := 0
	Local _cStrErro      := ""
	Local _aErros        := {}
	Private INCLUI      := .T. // Variavel necessária para o ExecAuto identificar que se trata de uma inclusão
	Private ALTERA      := .F. // Variavel necessária para o ExecAuto identificar que se trata de uma inclusão
	Private lMsHelpAuto := .T.		// ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
	Private lMsErroAuto := .F.      // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
	Private lAutoErrNoFile := .T.   // ---- LEANDRO RIBEIRO ---- 12/12/2019 ---- //
	Default lEhEcommerce := .F.

	If(_lAuto) // ---- LEANDRO RIBEIRO ---- 05/12/2019 ---- //

		ConOut("EXECUTANDO ROTINA AUTOMATICA")

		ConOut( "INICIO FGERAORC" )
		ConOut( "cParamEmpresa 	= " + cParamEmpresa )
		ConOut( "cParamFilial 	= " + cParamFilial	)
		ConOut( "cParamLogin 	= " + cParamLogin	)
		ConOut( "cParamSenha 	= " + cParamSenha 	)
		ConOut( "lParamSchedule = " + If( lParamSchedule, ".T.", ".F."  ) )
		ConOut( "nParamOpc 		= " + StrZero( nParamOpc, 02 			) )
		ConOut( "lEhEcommerce 	= " + Iif( lEhEcommerce,  ".T.", ".F."  ) )

		RpcClearEnv()  // ---- LEANDRO RIBEIRO ---- 10/12/2019 ---- //
		RPCSetType( 03 )
		RPCSetEnv( cParamEmpresa,  cParamFilial,  cParamLogin, cParamSenha, "LOJ", "LOJA701", { "SLQ", "SLR", "SL1", "SL2", "SL4", "SA1", "SB1", "DA0", "DA1", "SA3", "SE4" },  .T. )

		ConOut( "	Logou na Empresa / Filial / usuario..." )
		//ChkFile( "SLQ", .T. )
		//DbSelectArea ( "SLQ" )
		/*
		ChkFile( "SX7", .T. )
		DbSelectArea( "SX7" )
		ChkFile( "SXB", .T. )
		DbSelectArea( "SXB" )
		ChkFile( "SL1", .T. )
		DbSelectArea( "SL1" )
		*/
		////////////////////////////////////////////////
		// Mudar para Modulo 12 - SigaLoja            //
		////////////////////////////////////////////////
		nModulo := 12  							// ---- LEANDRO RIBEIRO ---- 04/12/2019 ---- //
		Conout(" Setando no Modulo SIGALOJA ")	// ---- LEANDRO RIBEIRO ---- 04/12/2019 ---- //

		ChkFile( "SX2", .T. )
		DbSelectArea( "SX2" )
		ChkFile( "SIX", .T. )
		DbSelectArea( "SIX" )
		ChkFile( "SX3", .T. )
		DbSelectArea( "SX3" )
		ChkFile( "SX6", .T. )
		DbSelectArea( "SX6" )
		aAutoCab	:= {}
		//lPOSLJAUTO  := .T. //Execauto para eCommerce
		//lMsErroAuto := .F.
		//lMsHelpAuto := .F.
		SetFunName( "LOJA701" )

		//Inclui  	:= .T.
		//Altera  	:= .F.
		//If lEhEcommerce
		//	MsExecAuto( { | a, b, c, d, e, f, g, h | LOJA701( a, b, c, d, e, f, g, h ) }, .F., nParamOpc, cParamCliente, cParamLoja, {}, aParamCabecalho, aParamItens, aParamCondicoes, lEhEcommerce )
		//Else
		BEGIN SEQUENCE
			MsExecAuto( { | a, b, c, d, e, f, g, h, i, j | LOJA701( a, b, c, d, e, f, g, h, i, j ) }, .F., nParamOpc, cParamCliente, cParamLoja, {}, aParamCabecalho, aParamItens, aParamCondicoes, .F. )
		END SEQUENCE

		ErrorBlock( oError )
		If (Empty(cRetMostraErro) == .F.)
			ConOut("Houve um erro na rotina automática LOJA701: " + cRetMostraErro)
		EndIf

		//EndIf
		If lMsErroAuto

			conout("ERRO DO EXECAUTO DO LOJA701: "+MostraErro("-","-"))

			If lParamSchedule

				If lEhEcommerce

					cMsgErro := "Erro ao tentar gravar o orçamento de Vendas no Protheus."
					cMsgComp := "Erro ao tentar gravar o orçamento de Vendas no Protheus. Erro : " + MostraErro( "-", "-" )
					ConOut( "UNIWS001 - FIntegra - EXECAUTO LOJA701 - " + cMsgComp )
					UNIGrvLog( "", "", "", "UNIWS001", "FIntegra", cMsgErro, cMsgComp, "", 0 )

				Else

					//MARCELO AMARAL 09/11/2019
					cMsgErro := "Erro ao tentar gravar o orçamento de Vendas no Protheus."
					ConOut( "	UNIWS001 - FIntegra - " + cMsgErro )
					//cRetMostraErro := "MOSTRAERRO - " + MostraErro( "-", "-" )
					cMsgComp := "MOSTRAERRO - " + MostraErro( "-", "-" )
					ConOut( "EXECAUTO LOJA701 - Erro com o ExecAuto " )
					//ConOut( cRetMostraErro )
					ConOut( cMsgComp )

				EndIf

			Else

				/*RETIRADO MARCELO AMARAL 09/11/2019
				ConOut( "EXECAUTO LOJA701 - OK" )
				cRetMostraErro     := ""
				*/

				//cRetMostraErro := MostraErro( "-", "-" )
				// ---- INICIO ---- LEANDRO RIBEIRO ---- //
				_aErros	:= GetAutoGRLog() // retorna o erro encontrado no execauto.
				_nErro  := Ascan(_aErros,{|x| "INVALIDO" $ alltrim(Upper(x))})

				If(_nErro > 0)
					_cStrErro += _aErros[_nErro]
				Else
					For _nErro := 1 To Len(_aErros)

						_cStrErro += (_aErros[_nErro]+_cEnt)

					Next _nErro
				EndIf

				cRetMostraErro := _cStrErro
				Conout("Numero do Orçamento: "+AllTrim(SL1->L1_NUM))

				Conout("UNIWS003: JOB INTEGRAÇÃO PROTHEUS X FLUIG - Hora: "+cValtoChar(Time())+" Data: "+DTOC(date())+".")
				Conout("UNIWS003: ERRO - "+_cStrErro+" - Hora: "+cValtoChar(Time())+" Data: "+DTOC(date())+".")

				//Inutilizar Cupom
				If(Empty(SL1->L1_SITUA) .AND. Empty(SL1->L1_KEYNFCE))
					DbSelectArea("SL1")
					Reclock("SL1",.F.)
					SL1->L1_SITUA := "X0"
					MsUnLock()

					Conout("UNIWS003: EXCLUINDO ORÇAMENTO COM ERRO NUMERO - "+SL1->L1_NUM+" - Hora: "+cValtoChar(Time())+" Data: "+DTOC(date())+".")

					//Processa a Exclusão do Cupom
					LJ140Exc("SL1" ,SL1->(Recno()),2,,.T.,,,,,,.T.)

				EndIf
				// ---- FIM ------- LEANDRO RIBEIRO ---- //
			EndIf

			//Else

			//cRetMostraErro := "SUCESSO"
		Else
			RecLock( "SL1", .F. )
			SL1->L1_INDPRES := "1"
			SL1->(MsUnLock())
		EndIf

		RPCClearEnv()
	EndIf // ---- LEANDRO RIBEIRO ---- 05/12/2019 ---- //

	//MARCELO AMARAL 09/11/2019
	//ErrorBlock( oError )

Return cRetMostraErro

*---------------------------*
Static Function FVerProduto()
	*---------------------------*

Return .T.

// Método da Classe para o Cadastro de Clientes
WSMethod EnviaCadastroCliente WSReceive oCliente WSSend cRetornoWS  WSService oWsUnica

	Local lSucesso  := .T.
	Local bError 	:= ErrorBlock( { |oError| cErro := oError:Description } )

	ConOut( "________________________________ INICIO DO PROCESSO INCLUSAO DE CADASTRO DE CLIENTE ________________________________")

	ConOut( "	- EnviaCadastroCliente - ETAPA 1" )

	//Verifica se o Cliente existe e se precisa cadastrá-lo:
	nAuxRecNoSA1  	:= U_UNICliExiste( ::oCliente:cCPF_CNPJ )

	lSucesso := FIntCliente( ::oCliente, @nAuxRecNoSA1 )

	ConOut( "________________________________ FIM DO PROCESSO INCLUSAO DE CADASTRO DE CLIENTE ________________________________")

Return lSucesso

WSMethod ListaCadastroClientes WSReceive cParamCPFCNPJ, cParamVendedor, cParamCidade, cParamEstado WSSend oListaClientes WSService oWsUnica

	Local cQuery 			:= ""
	Local cAliasSA1			:= GetNextAlias()
	Local lSucesso 			:= .T.

	Default cParamCPFCNPJ 	:= ""
	Default cParamVendedor	:= ""
	Default cParamCidade	:= ""
	Default cParamEstado	:= ""

	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE CLIENTES ________________________________" )

	cQuery := "			SELECT DISTINCT 	  "
	cQuery += "			       A1_PESSOA	, "
	cQuery += "			       A1_CGC   	, "
	cQuery += "			       A1_TIPO   	, "
	cQuery += "			       A1_COD   	, "
	cQuery += "			       A1_LOJA   	, "
	cQuery += "			       A1_NOME  	, "
	cQuery += "			       A1_NREDUZ	, "
	cQuery += "			       A1_CONTATO 	, "
	cQuery += "			       A1_DTNASC  	, "
	cQuery += "			       A1_INSCR   	, "
	cQuery += "			       A1_INSCRM  	, "
	cQuery += "			       A1_REGIAO	, "
	cQuery += "			       A1_PFISICA	, "
	cQuery += "			       A1_EMAIL		, "
	cQuery += "			       A1_HPAGE		, "
	cQuery += "			       A1_MSBLQL	, "
	cQuery += "			       A1_DDD		, "
	cQuery += "			       A1_TEL		, "
	cQuery += "			       A1_FAX		, "
	cQuery += "			       A1_NATUREZ	, "
	cQuery += "			       A1_ENDREC	, "
	cQuery += "			       A1_VEND		, "
	cQuery += "			       A1_COMIS		, "
	cQuery += "			       A1_CONTA		, "
	cQuery += "			       A1_BCO1		, "
	cQuery += "			       A1_TPFRET	, "
	cQuery += "			       A1_TPJ		, "
	cQuery += "			       A1_TRANSP	, "
	cQuery += "			       A1_COND		, "
	cQuery += "			       A1_TABELA	, "
	cQuery += "			       A1_END		, "
	cQuery += "			       A1_COMPLEM	, "
	cQuery += "			       A1_BAIRRO	, "
	cQuery += "			       A1_ESTADO	, "
	cQuery += "			       A1_EST		, "
	cQuery += "			       A1_CEP		, "
	cQuery += "			       A1_COD_MUN	, "
	cQuery += "			       A1_MUN		, "
	cQuery += "			       A1_CODPAIS	, "
	cQuery += "			       A1_PAIS		, "
	cQuery += "			       A1_ENDCOB	, "
	cQuery += "			       A1_BAIRROC	, "
	cQuery += "			       A1_ESTC		, "
	cQuery += "			       A1_CEPC		, "
	cQuery += "			       A1_MUNC		, "
	cQuery += "			       A1_ENDENT	, "
	cQuery += "			       A1_COMPENT	, "
	cQuery += "			       A1_BAIRROE	, "
	//cQuery += "			       A1_ESTADE	, "
	cQuery += "			       A1_ESTE		, "
	cQuery += "			       A1_CEPE		, "
	cQuery += "			       A1_CODMUNE	, "
	cQuery += "			       A1_CONTRIB	, "
	cQuery += "			       A1_ENTID		, "
	cQuery += "			       A1_MUNE		  "
	//cQuery += "			       A1_PAISE		, "
	//cQuery += "			       A1_XIDFLUI	  "
	cQuery += "			  FROM " + RetSQLName( "SA1" )
	cQuery += "			 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "			   AND A1_FILIAL  	  = '" + XFilial( "SA1" ) 			+ "' "
	If AllTrim( cParamCPFCNPJ ) != ""
		cQuery += "			   AND A1_CGC     = '" + cParamCPFCNPJ 			 	+ "' "
	EndIf
	If AllTrim( cParamVendedor ) != ""
		cQuery += "			   AND A1_VEND    = '" + cParamVendedor			 	+ "' "
	EndIf
	If AllTrim( cParamCidade ) != ""
		cQuery += "			   AND A1_MUN  LIKE '%" + AllTrim( cParamCidade )	+ "%' "
	EndIf
	If AllTrim( cParamEstado ) != ""
		cQuery += "			   AND A1_EST    = '" + cParamEstado 			 	+ "' "
	EndIf
	cQuery += "		  ORDER BY A1_NOME 		  "

	If Select( cAliasSA1 ) > 0
		( cAliasSA1 )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasSA1 ) New

	If !( cAliasSA1 )->( Eof() )

		nLimiteRetorno := 250
		::oListaClientes:aListaClientes := {}
		Do While !( cAliasSA1 )->( Eof() )


			aAdd( ::oListaClientes:aListaClientes, WSClassNew( "oStructConCliente" ) )

			//ConOut( "ETAPA 6" )
			aTail( ::oListaClientes:aListaClientes ):cCodigoCliente 	:= ( cAliasSA1 )->A1_COD
			aTail( ::oListaClientes:aListaClientes ):cLojaCliente 		:= ( cAliasSA1 )->A1_LOJA
			aTail( ::oListaClientes:aListaClientes ):cCPF_CNPJ			:= ( cAliasSA1 )->A1_CGC
			aTail( ::oListaClientes:aListaClientes ):cTipoPessoa		:= ( cAliasSA1 )->A1_PESSOA
			aTail( ::oListaClientes:aListaClientes ):cNomeCompleto		:= ( cAliasSA1 )->A1_NOME
			aTail( ::oListaClientes:aListaClientes ):cNomeReduzido		:= ( cAliasSA1 )->A1_NREDUZ
			aTail( ::oListaClientes:aListaClientes ):cTipoCliente		:= ( cAliasSA1 )->A1_TIPO
			aTail( ::oListaClientes:aListaClientes ):cContato 			:= ( cAliasSA1 )->A1_CONTATO
			aTail( ::oListaClientes:aListaClientes ):cDataNascimento	:= ( cAliasSA1 )->A1_DTNASC
			aTail( ::oListaClientes:aListaClientes ):cRegiao			:= ( cAliasSA1 )->A1_REGIAO
			aTail( ::oListaClientes:aListaClientes ):cRGCedEstr			:= ( cAliasSA1 )->A1_PFISICA
			aTail( ::oListaClientes:aListaClientes ):cInscrEstadual		:= ( cAliasSA1 )->A1_INSCR
			aTail( ::oListaClientes:aListaClientes ):cInscrMunicipal	:= ( cAliasSA1 )->A1_INSCRM
			aTail( ::oListaClientes:aListaClientes ):cEmail				:= ( cAliasSA1 )->A1_EMAIL
			aTail( ::oListaClientes:aListaClientes ):cHomePage			:= ( cAliasSA1 )->A1_HPAGE
			aTail( ::oListaClientes:aListaClientes ):cStatus 			:= ( cAliasSA1 )->A1_MSBLQL
			aTail( ::oListaClientes:aListaClientes ):cNatureza			:= ( cAliasSA1 )->A1_NATUREZ
			aTail( ::oListaClientes:aListaClientes ):cEndCentralCompras := ( cAliasSA1 )->A1_ENDREC
			aTail( ::oListaClientes:aListaClientes ):cVendedor 			:= ( cAliasSA1 )->A1_VEND
			aTail( ::oListaClientes:aListaClientes ):nComissao 			:= ( cAliasSA1 )->A1_COMIS
			aTail( ::oListaClientes:aListaClientes ):cContaContabil		:= ( cAliasSA1 )->A1_CONTA
			aTail( ::oListaClientes:aListaClientes ):cBanco 			:= ( cAliasSA1 )->A1_BCO1
			aTail( ::oListaClientes:aListaClientes ):cTipoFrete			:= ( cAliasSA1 )->A1_TPFRET
			aTail( ::oListaClientes:aListaClientes ):cTipoPJ			:= ( cAliasSA1 )->A1_TPJ
			aTail( ::oListaClientes:aListaClientes ):cTransportadora	:= ( cAliasSA1 )->A1_TRANSP
			aTail( ::oListaClientes:aListaClientes ):cCondicaoPagamento	:= ( cAliasSA1 )->A1_COND
			aTail( ::oListaClientes:aListaClientes ):cTabelaPreco		:= ( cAliasSA1 )->A1_TABELA
			aTail( ::oListaClientes:aListaClientes ):cDDD				:= ( cAliasSA1 )->A1_DDD
			aTail( ::oListaClientes:aListaClientes ):cTelefone			:= ( cAliasSA1 )->A1_TEL
			aTail( ::oListaClientes:aListaClientes ):cFax				:= ( cAliasSA1 )->A1_FAX
			//aTail( ::oListaClientes:aListaClientes ):cContrib			:= ( cAliasSA1 )->A1_CONTRIB
			//aTail( ::oListaClientes:aListaClientes ):cEntId				:= ( cAliasSA1 )->A1_ENTID
			//		aTail( ::oListaClientes:aListaClientes ):cContrib			:= ( cAliasSA1 )->A1_CONTRIB
			//		aTail( ::oListaClientes:aListaClientes ):cEntId				:= ( cAliasSA1 )->A1_ENTID

			//		aTail( ::oListaClientes:aListaClientes ):cIdFluig			:= ( cAliasSA1 )->A1_XIDFLUI

			// Endereços

			/*
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:= WsClassNew( "oStructEndereco" )
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cLogradouro 		:= ( cAliasSA1 )->A1_END
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cComplemento 		:= ( cAliasSA1 )->A1_COMPLEM
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cBairro			:= ( cAliasSA1 )->A1_BAIRRO
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cCodigoMunicipio 	:= ( cAliasSA1 )->A1_COD_MUN
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cNomeMunicipio		:= ( cAliasSA1 )->A1_MUN
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cEstado 			:= ( cAliasSA1 )->A1_ESTADO
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cUF				:= ( cAliasSA1 )->A1_EST
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cCodigoPais	 	:= ( cAliasSA1 )->A1_CODPAIS
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cPais				:= ( cAliasSA1 )->A1_PAIS
		aTail( ::oListaClientes:aListaClientes ):oEnderercoPrincipal:cCEP		 		:= ( cAliasSA1 )->A1_CEP
			*/

			// Endereço Principal
			oAuxEndPrincipal 					:= WsClassNew( "oStructEndereco" )
			oAuxEndPrincipal:cTipoEndereco 		:= "P"
			oAuxEndPrincipal:cLogradouro 		:= ( cAliasSA1 )->A1_END
			oAuxEndPrincipal:cComplemento 		:= ( cAliasSA1 )->A1_COMPLEM
			oAuxEndPrincipal:cBairro			:= ( cAliasSA1 )->A1_BAIRRO
			oAuxEndPrincipal:cCodigoMunicipio 	:= ( cAliasSA1 )->A1_COD_MUN
			oAuxEndPrincipal:cNomeMunicipio		:= ( cAliasSA1 )->A1_MUN
			oAuxEndPrincipal:cEstado 			:= ( cAliasSA1 )->A1_ESTADO
			oAuxEndPrincipal:cUF				:= ( cAliasSA1 )->A1_EST
			oAuxEndPrincipal:cCodigoPais	 	:= ( cAliasSA1 )->A1_CODPAIS
			oAuxEndPrincipal:cPais				:= ( cAliasSA1 )->A1_PAIS
			oAuxEndPrincipal:cCEP		 		:= ( cAliasSA1 )->A1_CEP


			// Endereço Cobrança
			/*
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:= WsClassNew( "oStructEndereco" )
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cLogradouro 		:= ( cAliasSA1 )->A1_ENDCOB
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cComplemento 		:= ""
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cBairro				:= ( cAliasSA1 )->A1_BAIRROC
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cCodigoMunicipio 	:= ""
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cNomeMunicipio		:= ( cAliasSA1 )->A1_MUNC
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cEstado 			:= ""
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cUF					:= ( cAliasSA1 )->A1_ESTC
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cCodigoPais	 		:= ""
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cPais				:= ""
		aTail( ::oListaClientes:aListaClientes ):oEnderercoCobranca:cCEP		 		:= ( cAliasSA1 )->A1_CEPC
			*/
			// Endereço Cobrança
			oAuxEndCobranca  					:= WsClassNew( "oStructEndereco" )
			oAuxEndCobranca:cTipoEndereco 		:= "C"
			oAuxEndCobranca:cLogradouro 		:= ( cAliasSA1 )->A1_ENDCOB
			oAuxEndCobranca:cComplemento 		:= ( cAliasSA1 )->A1_COMPENT
			oAuxEndCobranca:cBairro				:= ( cAliasSA1 )->A1_BAIRROC
			oAuxEndCobranca:cCodigoMunicipio 	:= ""
			oAuxEndCobranca:cNomeMunicipio		:= ( cAliasSA1 )->A1_MUNC
			oAuxEndCobranca:cEstado 			:= ""
			oAuxEndCobranca:cUF					:= ( cAliasSA1 )->A1_ESTC
			oAuxEndCobranca:cCodigoPais	 		:= ""
			oAuxEndCobranca:cPais				:= ""
			oAuxEndCobranca:cCEP		 		:= ( cAliasSA1 )->A1_CEPC

			// Endereço Entrega
			/*
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:= WsClassNew( "oStructEndereco" )
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cLogradouro 			:= ( cAliasSA1 )->A1_ENDENT
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cComplemento 		:= ( cAliasSA1 )->A1_COMPENT
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cBairro				:= ( cAliasSA1 )->A1_BAIRROE
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cCodigoMunicipio 	:= ( cAliasSA1 )->A1_CODMUNE
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cNomeMunicipio		:= ( cAliasSA1 )->A1_MUNE
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cEstado 				:= ""// ( cAliasSA1 )->A1_ESTADE
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cUF					:= ( cAliasSA1 )->A1_ESTE
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cCodigoPais	 		:= ""
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cPais				:= "" //( cAliasSA1 )->A1_PAISE
		aTail( ::oListaClientes:aListaClientes ):oEnderercoEntrega:cCEP		 			:= ( cAliasSA1 )->A1_CEPE
			*/

			// Endereço Entrega
			oAuxEndEntrega  					:= WsClassNew( "oStructEndereco" )
			oAuxEndEntrega:cTipoEndereco 		:= "E"
			oAuxEndEntrega:cLogradouro 			:= ( cAliasSA1 )->A1_ENDENT
			oAuxEndEntrega:cComplemento 		:= ( cAliasSA1 )->A1_COMPENT
			oAuxEndEntrega:cBairro				:= ( cAliasSA1 )->A1_BAIRROE
			oAuxEndEntrega:cCodigoMunicipio 	:= ( cAliasSA1 )->A1_CODMUNE
			oAuxEndEntrega:cNomeMunicipio		:= ( cAliasSA1 )->A1_MUNE
			oAuxEndEntrega:cEstado 				:= ""// ( cAliasSA1 )->A1_ESTADE
			oAuxEndEntrega:cUF					:= ( cAliasSA1 )->A1_ESTE
			oAuxEndEntrega:cCodigoPais	 		:= ""
			oAuxEndEntrega:cPais				:= "" //( cAliasSA1 )->A1_PAISE
			oAuxEndEntrega:cCEP		 			:= ( cAliasSA1 )->A1_CEPE

			aTail( ::oListaClientes:aListaClientes ):aEnderecos := {}
			aAdd( aTail( ::oListaClientes:aListaClientes ):aEnderecos, oAuxEndPrincipal )
			aAdd( aTail( ::oListaClientes:aListaClientes ):aEnderecos, oAuxEndCobranca  )
			aAdd( aTail( ::oListaClientes:aListaClientes ):aEnderecos, oAuxEndEntrega	)

			If Len( ::oListaClientes:aListaClientes ) > nLimiteRetorno
				Exit
			EndIf
			ConOut( "ETAPA 8" )

			( cAliasSA1 )->( DbSkip() )
		EndDo
		lSucesso := .T.
		::cRetornoWS := "Consulta retornada com sucesso!"

	Else

		::oListaClientes:aListaClientes := {}
		aAdd( ::oListaClientes:aListaClientes, WSClassNew( "oStructConCliente" ) )
		lSucesso := .F.
		::cRetornoWS := "Não encontrou Clientes para a consulta"
		SetSoapFault( "Não encontrou Clientes para a consulta", "", SOAPFAULT_RECEIVER )

	EndIf

	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE CLIENTES ________________________________" )

Return lSucesso

WSMethod precoVenda WSReceive cCodigoFilial, cProduto, cTabelaPreco, cCondPg, nQuant, cCliente, cLoja WSSend oPrecoVenda WSService oWsUnica
	Local lSucesso
	Local nDesconto
	ConOut( "________________________________ INICIO DA SOLICITACAO DE LISTAGEM DE PRECOS DE VENDA ________________________________" )

	cFilAnt := cCodigoFilial

	cProduto := PadR(cProduto, TamSX3("B1_COD")[1])
	DbSelectArea("SB1")
	dbSetOrder(1)
	If !dbSeek(XFilial("SB1")+cProduto)
		lSucesso := .F.
		::cRetornoWS := "Não encontrou Produto para a consulta"
		SetSoapFault( "Não encontrou Produto para a consulta", "", SOAPFAULT_RECEIVER )
		return lSucesso
	EndIf

	::oPrecoVenda := WsClassNew("oPrecoVenda")

	::oPrecoVenda:cRetornoWS := "ok"
	::oPrecoVenda:nPrecoVenda := MaTabPrVen(cTabelaPreco, cProduto, nQuant, cCliente, cLoja)

	nDesconto := MaRgrDesc(cProduto, cCliente, cLoja, cTabelaPreco, nQuant, cCondPg, "", 2, NIL, {},/*cCodRegDe*/, ::oPrecoVenda:nPrecoVenda )

	::oPrecoVenda:nPrecoVenda := Round((1 - nDesconto/100) * ::oPrecoVenda:nPrecoVenda, 2)


	ConOut( "________________________________ FIM DA SOLICITACAO DE LISTAGEM DE PRECOS DE VENDA ________________________________" )

	lSucesso 	 := .T.

Return lSucesso





Static Function FReserva()

	Local cAuxReserva := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Estrutura do array aReserva                                               ³
	//³ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³
	//³aReserva[1]-Codigo da Loja                                                ³
	//³aReserva[2]-Array contendo:                                               ³
	//³            [1] - Item do produto na aCols                                ³
	//³            [2] - Codigo do produto                                       ³
	//³            [3] - Quantidade                                              ³
	//³            [4] - Array contendo                                          ³
	//³                  [1] - Local                                             ³
	//³                  [2] - Quantidade em estoque                             ³
	//³            [5] - Armazem                                                 ³
	//³            [6] - Lote: Array contendo                                    ³
	//³                  [1] - Sublote                                           ³
	//³                  [2] - Lote                                              ³
	//³                  [3] - Endereco                                          ³
	//³                  [4] - Numero Serie                                      ³
	//³            [7] - Numero do Recno da Tabela de Contingencia "MES"         ³
	//³aReserva[3]-Codigo da reserva (SC0)                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	ConOut( "	UNIWS003 - FReserva - " + SL2->L2_PRODUTO )
	DbSelectArea( "SB1" )
	DbSetOrder( 01 )
	Seek XFilial( "SB1" ) + SL2->L2_PRODUTO

	aReserva := {}
	aAdd( aReserva, SL2->L2_ITEM 					) // [1] - Item do produto na aCols                                ³
	aAdd( aReserva, SL2->L2_PRODUTO 				) // [2] - Codigo do produto                                       ³
	aAdd( aReserva, SL2->L2_QUANT					) // [3] - Quantidade                                              ³
	aAdd( aReserva, { SB1->B1_UM, SL2->L2_QUANT }   ) // [4] - Array contendo                                          ³
	// 	[1] - Local                                             ³
	// 	[2] - Quantidade em estoque                             ³
	aAdd( aReserva, SB1->B1_UM						) // [5] - Armazem                                                 ³
	aAdd( aReserva, {}								) // [6] - Lote: Array contendo                                    ³
	// 	[1] - Sublote                                           ³
	// 	[2] - Lote                                              ³
	// 	[3] - Endereco                                          ³
	// 	[4] - Numero Serie                                      ³
	aAdd( aReserva, SB1->B1_UM						) // [7] - Numero do Recno da Tabela de Contingencia "MES"         ³

	aCliente := {}
	DbSelectArea( "SA1" )
	For nZ := 01 To FCount()
		aAdd( aCliente, { Field( nZ ), FieldGet( nZ ) } )
	Next nZ

	aNumRes := {}
	cAuxReserva := Lj7GeraSC0(  aReserva		,;
		dDatabase		,;
		aCliente		,;
		SL2->L2_FILIAL,,,;
		@aNumRes 		 )

	ConOut( "	UNIWS003 - FReserva - Reserva Gerada - " + cAuxReserva )

Return cAuxReserva


*-----------------------------------------------*
Static Function FExisteOrcamento( cParamIdFluig )
	*-----------------------------------------------*
	Local aAreaOld 	 := GetArea()
	Local cAliasExis := GetNextAlias()
	Local lRetExiste := .F.
	Local cQuery 	 := ""

	cQuery := "	SELECT COUNT( * ) AS NACHOU "
	cQuery += "	  FROM " + RetSQLName( "SL1" ) + " ( NOLOCK )
	cQuery += "	 WHERE D_E_L_E_T_  = ' ' "
	cQuery += "	   AND L1_NROPCLI  = '" + cParamIdFluig + "' "
	If Select( cAliasExis ) > 0
		( cAliasExis )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasExis ) New
	If !( cAliasExis )->( Eof() )
		lRetExiste := ( ( cAliasExis )->NACHOU > 0 )
	EndIf
	( cAliasExis )->( DbCloseArea() )

	RestArea( aAreaOld )

Return lRetExiste


Static Function FRetForma( cParamCondicao )

	Local aAreaFor	:= GetArea()
	Local aAreaSE4 	:= SE4->( GetArea() )
	Local cRetForma := ""

	cRetForma := ""
	DbSelectArea( "SE4" )
	DbSetOrder( 01 ) // E4_FILIAL + E4_CODIGO
	Seek XFilial( "SE4" ) + AllTrim( cParamCondicao )
	If Found()
		cRetForma := AllTrim( SE4->E4_FORMA )
	EndIf

	RestArea( aAreaSE4 )
	RestArea( aAreaFor )

Return cRetForma

*------------------------------------*
Static Function FRetEstado( cParamUF )
	*------------------------------------*
	Local aAreaAnt 	:= GetArea()
	Local cAliasUF  := GetNextAlias()
	Local cRetEst	:= ""
	Local cQuery    := ""

	cQuery := "	SELECT X5_DESCRI "
	cQuery += "	  FROM " + RetSQLName( "SX5" )
	cQuery += "	 WHERE D_E_L_E_T_ = ' ' "
	cQuery += "    AND X5_FILIAL  = '" + XFilial( "SX5" ) 	+ "' "
	cQuery += "    AND X5_TABELA  = '12' "
	cQuery += "	   AND X5_CHAVE   = '" + Upper( FwNoAccent( AllTrim( cParamUF ) ) ) + "' "
	If Select( cAliasUF ) > 0
		( cAliasUF )->( DbCloseArea() )
	EndIf
	TcQuery cQuery Alias ( cAliasUF ) New
	If !( cAliasUF )->( Eof() )
		cRetEst := AllTrim( ( cAliasUF )->X5_DESCRI )
	EndIf
	( cAliasUF )->( DbCloseArea() )
	RestArea( aAreaAnt )

Return cRetEst

*--------------------------------------------*
Static Function FRetDescEmpFil( cParamFilial )
	*--------------------------------------------*
	Local aAreaX 	 := GetArea()
	Local cRetEmpFil := ""

	DbSelectArea( "SZC" )
	DbSetOrder( 01 )
	Seek XFilial( "SZC" ) + cParamFilial
	If Found()
		cRetEmpFil := Alltrim( SZC->ZC_FLUIG )
	Else
		cRetEmpFil := "N/E"
	EndIf

	RestArea( aAreaX )

Return cRetEMpFil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UNIWS003  ºAutor  ³LEANDRO RIBEIRO     º Data ³  27/11/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função para gravação da tabela de Dados Adicionais - Loja  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fGrvSB0(_cCodPrd,_nValorPrd,_dData)

	Local _cProd  := PADR(Alltrim(_cCodPrd),TAMSX3("B0_COD")[1])
	Local _nValor := _nValorPrd

	DbSelectArea("SB0")
	SB0->(DbSetOrder(1))

	If SB0->(DbSeek(xFilial("SB0")+_cProd))
		RecLock('SB0',.F.) // LOCALIZOU O REGISTRO - ALTERA
		SB0->B0_FILIAL  := xFilial("SB0")
		SB0->B0_COD     := _cProd
		SB0->B0_PRV1    := _nValor
		SB0->B0_PRV2    := 0
		SB0->B0_PRV3    := 0
		SB0->B0_PRV4    := 0
		SB0->B0_PRV5    := 0
		SB0->B0_PRV6    := 0
		SB0->B0_PRV7    := 0
		SB0->B0_PRV8    := 0
		SB0->B0_PRV9    := 0
		SB0->B0_ECFLAG  := "2"
		SB0->B0_ECPRV   := 0
		SB0->B0_ECPROFU := 0
		SB0->B0_ECCOMP  := 0
		SB0->B0_ECLARGU := 0
		SB0->B0_DESCONT := 0
		SB0->B0_DTHRALT	:= DTOS(_dData)+Time()
		SB0->(MsUnlock())
	Else
		RecLock('SB0',.T.) // NÃO LOCALIZOU O REGISTRO - INCLUI
		SB0->B0_FILIAL  := xFilial("SB0")
		SB0->B0_COD     := _cProd
		SB0->B0_PRV1    := _nValor
		SB0->B0_PRV2    := 0
		SB0->B0_PRV3    := 0
		SB0->B0_PRV4    := 0
		SB0->B0_PRV5    := 0
		SB0->B0_PRV6    := 0
		SB0->B0_PRV7    := 0
		SB0->B0_PRV8    := 0
		SB0->B0_PRV9    := 0
		SB0->B0_ECFLAG  := "2"
		SB0->B0_ECPRV   := 0
		SB0->B0_ECPROFU := 0
		SB0->B0_ECCOMP  := 0
		SB0->B0_ECLARGU := 0
		SB0->B0_DESCONT := 0
		SB0->B0_DTHRALT	:= DTOS(_dData)+Time()
		SB0->(MsUnlock())
	EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UNIWS003  ºAutor  ³Microsiga           º Data ³  12/10/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function VerifSC0LJ(_cNum,_cFilRes)

	Local _aArea    := GetArea()
	Local _aAreaSL2 := SL2->(GetArea())
	Local _aAreaSC0 := SL0->(GetArea())
	Local _cQuery1  := ""
	Local _cTrab1   := GetNextAlias()
	Local _cNumRev  := ""

	Conout("VERIFICANDO A RELAÇÃO DOS ITENS")

	_cQuery1 := " SELECT L2_NUM, L2_PRODUTO, L2_QUANT, L2_RESERVA " + _cEnt
	_cQuery1 += " FROM "+RETSQLNAME("SL2")+" SL2" + _cEnt
	_cQuery1 += " WHERE" + _cEnt
	_cQuery1 += " L2_FILIAL = '"+xFilial("SL2")+"'" + _cEnt
	_cQuery1 += " AND L2_NUM = '"+_cNum+"'" + _cEnt
	_cQuery1 += " AND SL2.D_E_L_E_T_ = ' '" + _cEnt
	_cQuery1 := ChangeQuery(_cQuery1)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery1),_cTrab1,.T.,.T.)

	DbSelectArea(_cTrab1)
	If((_cTrab1)->(!Eof()))
		While (_cTrab1)->(!Eof())
			If(Empty((_cTrab1)->L2_RESERVA))
				//PONTERA NA SL2
				Conout("PONTERANDO NA SL2")
				DbSelectArea("SL2")
				DbSetOrder(1)
				If(DbSeek(xFilial("SL2")+PADR((_cTrab1)->L2_NUM,TAMSX3("L2_NUM")[1])))
					Conout("ENCONTROU REGISTRO - ITEM")
				Else
					Conout("NÃO ENCONTROU REGISTRO - ITEM")
				EndIf

				//PONTERA NA SB1
				Conout("PONTERANDO NA SB1")
				DbSelectArea("SB1")
				DbSetOrder(1)
				If(DbSeek(xFilial("SB1")+PADR((_cTrab1)->L2_PRODUTO,TAMSX3("B1_COD")[1])))
					Conout("ENCONTROU REGISTRO - PRODUTO")
				Else
					Conout("NÃO ENCONTROU REGISTRO - PRODUTO")
				EndIf

				Conout("INICIANDO A GRAVAÇÃO DA RESERVA")
				/*
			_cNumRev := FReserva()
			Reclock("SL2",.F.)
				SL2->L2_RESERVA := _cNumRev
				SL2->L2_LOJARES := cLojaReserva
				SL2->L2_FILRES  := SL2->L2_FILIAL
				MsUnlock()*/
			Else
				Conout("VERIFICANDO SE HOUVE GRAVAÇÃO NA SC0")
				DbSelectArea("SC0")
				DbSetOrder(1)
				If(DbSeek(xFilial("SC0")+PADR((_cTrab1)->L2_RESERVA,TAMSX3("C0_NUM")[1])+PADR((_cTrab1)->L2_PRODUTO,TAMSX3("B1_COD")[1])))
				Conout("LOCALIZOU A RESERVA")
			Else
				Conout("NÃO LOCALIZOU A RESERVA")
				Conout("INICIANDO A GRAVAÇÃO DA RESERVA")
				//PONTERA NA SL2
				Conout("PONTERANDO NA SL2")
				DbSelectArea("SL2")
				DbSetOrder(1)
				If(DbSeek(xFilial("SL2")+PADR((_cTrab1)->L2_NUM,TAMSX3("L2_NUM")[1])))
					Conout("ENCONTROU REGISTRO - ITEM")
				Else
					Conout("NÃO ENCONTROU REGISTRO - ITEM")
				EndIf

				//PONTERA NA SB1
				Conout("PONTERANDO NA SB1")
				DbSelectArea("SB1")
				DbSetOrder(1)
				If(DbSeek(xFilial("SB1")+PADR((_cTrab1)->L2_PRODUTO,TAMSX3("B1_COD")[1])))
					Conout("ENCONTROU REGISTRO - PRODUTO")
				Else
					Conout("NÃO ENCONTROU REGISTRO - PRODUTO")
				EndIf

				Conout("INICIANDO A GRAVAÇÃO DA RESERVA")
				/*
				_cNumRev := FReserva()

				Conout("SUBSTITUINDO A RESERVA ANTERIOR E INFORMANDO A NOVA RESERVA")
				Conout("NOVA NUMERAÇÃO DA RESERVA: "+_cNumRev)
				Conout("NUMERAÇÃO DA RESERVA ANTERIOR: "+SL2->L2_RESERVA)

				Reclock("SL2",.F.)
					SL2->L2_RESERVA := _cNumRev
					SL2->L2_LOJARES := cLojaReserva
					SL2->L2_FILRES  := SL2->L2_FILIAL
				MsUnlock()*/
			EndIf
			EndIf
			(_cTrab1)->(DbSkip())
		Enddo
	EndIf

	RestArea(_aAreaSC0)
	RestArea(_aAreaSL2)
	RestArea(_aArea)

Return()
