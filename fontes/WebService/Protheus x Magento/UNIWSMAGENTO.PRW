
/*/{Protheus.doc} UNIWSMAGENTO

@project Integração Protheus x Magento
@description Client de WS gerado pelo Protheus para uso do WS de Integração do Magento
@wsdl PRODUÇÃO: 		https://www.unicaarcondicionado.com.br/index.php/api/v2_soap?wsdl=1
	  HOMOLOGAÇÃO:		https://unicario.com.br/homologacao/index.php/api/v2_soap/?wsdl
	  NOVA HOMOLOGAÇÃO:	https://www.qualitebrasil.com.br/index.php/api/v2_soap/?wsdl
@author Rafael Rezende
@since 15/03/2019
@version 1.0

@return

@see www.thebestconsulting.com.br/
/*/


#Include "TOTVS.ch"
#INCLUDE "apwebsrv.ch"

/* ===============================================================================
WSDL Location    https://www.qualitebrasil.com.br/index.php/api/v2_soap/?wsdl
Gerado em        07/15/19 10:06:52
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
Alterações neste arquivo podem causar funcionamento incorreto
e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _NJNTJFM ; Return  // "dummy" function - Internal Use

/* -------------------------------------------------------------------------------
WSDL Service WSMagentoService
------------------------------------------------------------------------------- */

WSCLIENT WSMagentoService

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD endSession
	WSMETHOD login
	WSMETHOD startSession
	WSMETHOD resources
	WSMETHOD globalFaults
	WSMETHOD resourceFaults
	WSMETHOD storeList
	WSMETHOD storeInfo
	WSMETHOD magentoInfo
	WSMETHOD directoryCountryList
	WSMETHOD directoryRegionList
	WSMETHOD customerCustomerList
	WSMETHOD customerCustomerCreate
	WSMETHOD customerCustomerInfo
	WSMETHOD customerCustomerUpdate
	WSMETHOD customerCustomerDelete
	WSMETHOD customerGroupList
	WSMETHOD customerAddressList
	WSMETHOD customerAddressCreate
	WSMETHOD customerAddressInfo
	WSMETHOD customerAddressUpdate
	WSMETHOD customerAddressDelete
	WSMETHOD catalogCategoryCurrentStore
	WSMETHOD catalogCategoryTree
	WSMETHOD catalogCategoryLevel
	WSMETHOD catalogCategoryInfo
	WSMETHOD catalogCategoryCreate
	WSMETHOD catalogCategoryUpdate
	WSMETHOD catalogCategoryMove
	WSMETHOD catalogCategoryDelete
	WSMETHOD catalogCategoryAssignedProducts
	WSMETHOD catalogCategoryAssignProduct
	WSMETHOD catalogCategoryUpdateProduct
	WSMETHOD catalogCategoryRemoveProduct
	WSMETHOD catalogCategoryAttributeCurrentStore
	WSMETHOD catalogCategoryAttributeList
	WSMETHOD catalogCategoryAttributeOptions
	WSMETHOD catalogProductCurrentStore
	WSMETHOD catalogProductList
	WSMETHOD catalogProductInfo
	WSMETHOD catalogProductCreate
	WSMETHOD catalogProductUpdate
	WSMETHOD catalogProductMultiUpdate
	WSMETHOD catalogProductSetSpecialPrice
	WSMETHOD catalogProductGetSpecialPrice
	WSMETHOD catalogProductDelete
	WSMETHOD catalogProductAttributeCurrentStore
	WSMETHOD catalogProductListOfAdditionalAttributes
	WSMETHOD catalogProductAttributeList
	WSMETHOD catalogProductAttributeOptions
	WSMETHOD catalogProductAttributeSetCreate
	WSMETHOD catalogProductAttributeSetRemove
	WSMETHOD catalogProductAttributeSetList
	WSMETHOD catalogProductAttributeSetAttributeAdd
	WSMETHOD catalogProductAttributeSetAttributeRemove
	WSMETHOD catalogProductAttributeSetGroupAdd
	WSMETHOD catalogProductAttributeSetGroupRename
	WSMETHOD catalogProductAttributeSetGroupRemove
	WSMETHOD catalogProductAttributeTypes
	WSMETHOD catalogProductAttributeCreate
	WSMETHOD catalogProductAttributeRemove
	WSMETHOD catalogProductAttributeInfo
	WSMETHOD catalogProductAttributeUpdate
	WSMETHOD catalogProductAttributeAddOption
	WSMETHOD catalogProductAttributeRemoveOption
	WSMETHOD catalogProductTypeList
	WSMETHOD catalogProductAttributeTierPriceInfo
	WSMETHOD catalogProductAttributeTierPriceUpdate
	WSMETHOD catalogProductAttributeMediaCurrentStore
	WSMETHOD catalogProductAttributeMediaList
	WSMETHOD catalogProductAttributeMediaInfo
	WSMETHOD catalogProductAttributeMediaTypes
	WSMETHOD catalogProductAttributeMediaCreate
	WSMETHOD catalogProductAttributeMediaUpdate
	WSMETHOD catalogProductAttributeMediaRemove
	WSMETHOD catalogProductLinkList
	WSMETHOD catalogProductLinkAssign
	WSMETHOD catalogProductLinkUpdate
	WSMETHOD catalogProductLinkRemove
	WSMETHOD catalogProductLinkTypes
	WSMETHOD catalogProductLinkAttributes
	WSMETHOD catalogProductCustomOptionAdd
	WSMETHOD catalogProductCustomOptionUpdate
	WSMETHOD catalogProductCustomOptionTypes
	WSMETHOD catalogProductCustomOptionInfo
	WSMETHOD catalogProductCustomOptionList
	WSMETHOD catalogProductCustomOptionRemove
	WSMETHOD catalogProductCustomOptionValueInfo
	WSMETHOD catalogProductCustomOptionValueList
	WSMETHOD catalogProductCustomOptionValueAdd
	WSMETHOD catalogProductCustomOptionValueUpdate
	WSMETHOD catalogProductCustomOptionValueRemove
	WSMETHOD salesOrderList
	WSMETHOD salesOrderInfo
	WSMETHOD salesOrderAddComment
	WSMETHOD salesOrderHold
	WSMETHOD salesOrderUnhold
	WSMETHOD salesOrderCancel
	WSMETHOD salesOrderShipmentList
	WSMETHOD salesOrderShipmentInfo
	WSMETHOD salesOrderShipmentCreate
	WSMETHOD salesOrderShipmentAddComment
	WSMETHOD salesOrderShipmentAddTrack
	WSMETHOD salesOrderShipmentSendInfo
	WSMETHOD salesOrderShipmentRemoveTrack
	WSMETHOD salesOrderShipmentGetCarriers
	WSMETHOD salesOrderInvoiceList
	WSMETHOD salesOrderInvoiceInfo
	WSMETHOD salesOrderInvoiceCreate
	WSMETHOD salesOrderInvoiceAddComment
	WSMETHOD salesOrderInvoiceCapture
	WSMETHOD salesOrderInvoiceVoid
	WSMETHOD salesOrderInvoiceCancel
	WSMETHOD salesOrderCreditmemoList
	WSMETHOD salesOrderCreditmemoInfo
	WSMETHOD salesOrderCreditmemoCreate
	WSMETHOD salesOrderCreditmemoAddComment
	WSMETHOD salesOrderCreditmemoCancel
	WSMETHOD catalogInventoryStockItemList
	WSMETHOD catalogInventoryStockItemUpdate
	WSMETHOD catalogInventoryStockItemMultiUpdate
	WSMETHOD shoppingCartCreate
	WSMETHOD shoppingCartInfo
	WSMETHOD shoppingCartOrder
	WSMETHOD shoppingCartTotals
	WSMETHOD shoppingCartLicense
	WSMETHOD shoppingCartProductAdd
	WSMETHOD shoppingCartProductUpdate
	WSMETHOD shoppingCartProductRemove
	WSMETHOD shoppingCartProductList
	WSMETHOD shoppingCartProductMoveToCustomerQuote
	WSMETHOD shoppingCartCustomerSet
	WSMETHOD shoppingCartCustomerAddresses
	WSMETHOD shoppingCartShippingMethod
	WSMETHOD shoppingCartShippingList
	WSMETHOD shoppingCartPaymentMethod
	WSMETHOD shoppingCartPaymentList
	WSMETHOD shoppingCartCouponAdd
	WSMETHOD shoppingCartCouponRemove
	WSMETHOD catalogProductTagList
	WSMETHOD catalogProductTagInfo
	WSMETHOD catalogProductTagAdd
	WSMETHOD catalogProductTagUpdate
	WSMETHOD catalogProductTagRemove
	WSMETHOD giftMessageSetForQuote
	WSMETHOD giftMessageSetForQuoteItem
	WSMETHOD giftMessageSetForQuoteProduct
	WSMETHOD catalogProductDownloadableLinkAdd
	WSMETHOD catalogProductDownloadableLinkList
	WSMETHOD catalogProductDownloadableLinkRemove
	WSMETHOD plpList
	WSMETHOD integratorOrderListShipments
	WSMETHOD integratorOrderEstimateShipping
	WSMETHOD integratorOrderEstimateShippingPerItem
	WSMETHOD integratorOrderInfo
	WSMETHOD integratorOrderInvoice
	WSMETHOD integratorOrderCreate
	WSMETHOD integratorOrderUpdate
	WSMETHOD integratorOrderListStatus
	WSMETHOD integratorOrderPaymentMethods
	WSMETHOD integratorOrderShippingMethods
	WSMETHOD integratorProductListCreated
	WSMETHOD integratorProductItems
	WSMETHOD integratorProductItemsPaged
	WSMETHOD integratorProductUrls
	WSMETHOD integratorProductListUpdated
	WSMETHOD integratorProductListDeleted
	WSMETHOD integratorProductImportCsv
	WSMETHOD integratorProductListCreatedCount
	WSMETHOD integratorProductListUpdatedCount
	WSMETHOD integratorProductListDeletedCount
	WSMETHOD integratorProductConfirmListCreatedReceived
	WSMETHOD integratorProductConfirmListUpdatedReceived
	WSMETHOD integratorProductConfirmListDeletedReceived

	WSDATA   _URL                      AS String
	WSDATA   _CERT                     AS String
	WSDATA   _PRIVKEY                  AS String
	WSDATA   _PASSPHRASE               AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   csessionId                AS string
	WSDATA   lendSessionReturn         AS boolean
	WSDATA   cusername                 AS string
	WSDATA   capiKey                   AS string
	WSDATA   cloginReturn              AS string
	WSDATA   cstartSessionReturn       AS string
	WSDATA   oWSresourcesReturn        AS MagentoService_ArrayOfApis
	WSDATA   oWSglobalFaultsReturn     AS MagentoService_ArrayOfExistsFaltures
	WSDATA   cresourceName             AS string
	WSDATA   oWSresourceFaultsReturn   AS MagentoService_ArrayOfExistsFaltures
	WSDATA   oWSstoreListstores        AS MagentoService_storeEntityArray
	WSDATA   cstoreId                  AS string
	WSDATA   oWSstoreInfoinfo          AS MagentoService_storeEntity
	WSDATA   oWSmagentoInfoinfo        AS MagentoService_magentoInfoEntity
	WSDATA   oWSdirectoryCountryListcountries AS MagentoService_directoryCountryEntityArray
	WSDATA   ccountry                  AS string
	WSDATA   oWSdirectoryRegionListcountries AS MagentoService_directoryRegionEntityArray
	WSDATA   oWScustomerCustomerListfilters AS MagentoService_filters
	WSDATA   oWScustomerCustomerListstoreView AS MagentoService_customerCustomerEntityArray
	WSDATA   oWScustomerCustomerCreatecustomerData AS MagentoService_customerCustomerEntityToCreate
	WSDATA   nresult                   AS int
	WSDATA   ncustomerId               AS int
	WSDATA   oWScustomerCustomerInfoattributes AS MagentoService_ArrayOfString
	WSDATA   oWScustomerCustomerInfocustomerInfo AS MagentoService_customerCustomerEntity
	WSDATA   oWScustomerCustomerUpdatecustomerData AS MagentoService_customerCustomerEntityToCreate
	WSDATA   oWScustomerGroupListresult AS MagentoService_customerGroupEntityArray
	WSDATA   oWScustomerAddressListresult AS MagentoService_customerAddressEntityArray
	WSDATA   oWScustomerAddressCreateaddressData AS MagentoService_customerAddressEntityCreate
	WSDATA   naddressId                AS int
	WSDATA   oWScustomerAddressInfoinfo AS MagentoService_customerAddressEntityItem
	WSDATA   oWScustomerAddressUpdateaddressData AS MagentoService_customerAddressEntityCreate
	WSDATA   linfo                     AS boolean
	WSDATA   cstoreView                AS string
	WSDATA   cparentId                 AS string
	WSDATA   oWScatalogCategoryTreetree AS MagentoService_catalogCategoryTree
	WSDATA   cwebsite                  AS string
	WSDATA   cparentCategory           AS string
	WSDATA   oWScatalogCategoryLeveltree AS MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren
	WSDATA   ncategoryId               AS int
	WSDATA   oWScatalogCategoryInfoattributes AS MagentoService_ArrayOfString
	WSDATA   oWScatalogCategoryInfoinfo AS MagentoService_catalogCategoryInfo
	WSDATA   oWScatalogCategoryCreatecategoryData AS MagentoService_catalogCategoryEntityCreate
	WSDATA   nattribute_id             AS int
	WSDATA   oWScatalogCategoryUpdatecategoryData AS MagentoService_catalogCategoryEntityCreate
	WSDATA   lid                       AS boolean
	WSDATA   cafterId                  AS string
	WSDATA   oWScatalogCategoryAssignedProductsresult AS MagentoService_catalogAssignedProductArray
	WSDATA   cproduct                  AS string
	WSDATA   cidentifierType           AS string
	WSDATA   oWScatalogCategoryAttributeListresult AS MagentoService_catalogAttributeEntityArray
	WSDATA   cattributeId              AS string
	WSDATA   oWScatalogCategoryAttributeOptionsresult AS MagentoService_catalogAttributeOptionEntityArray
	WSDATA   oWScatalogProductListfilters AS MagentoService_filters
	WSDATA   oWScatalogProductListstoreView AS MagentoService_catalogProductEntityArray
	WSDATA   cproductId                AS string
	WSDATA   oWScatalogProductInfoattributes AS MagentoService_catalogProductRequestAttributes
	WSDATA   oWScatalogProductInfoinfo AS MagentoService_catalogProductReturnEntity
	WSDATA   oWScatalogProductCreateproductData AS MagentoService_catalogProductCreateEntity
	WSDATA   oWScatalogProductUpdateproductData AS MagentoService_catalogProductCreateEntity
	WSDATA   oWScatalogProductMultiUpdateproductIds AS MagentoService_ArrayOfString
	WSDATA   oWScatalogProductMultiUpdateproductData AS MagentoService_catalogProductCreateEntityArray
	WSDATA   cstore                    AS string
	WSDATA   cspecialPrice             AS string
	WSDATA   cfromDate                 AS string
	WSDATA   ctoDate                   AS string
	WSDATA   oWScatalogProductGetSpecialPriceresult AS MagentoService_catalogProductSpecialPriceReturnEntity
	WSDATA   cproductType              AS string
	WSDATA   cattributeSetId           AS string
	WSDATA   oWScatalogProductListOfAdditionalAttributesresult AS MagentoService_catalogAttributeEntityArray
	WSDATA   nsetId                    AS int
	WSDATA   oWScatalogProductAttributeListresult AS MagentoService_catalogAttributeEntityArray
	WSDATA   oWScatalogProductAttributeOptionsresult AS MagentoService_catalogAttributeOptionEntityArray
	WSDATA   cattributeSetName         AS string
	WSDATA   cskeletonSetId            AS string
	WSDATA   cforceProductsRemove      AS string
	WSDATA   lisRemoved                AS boolean
	WSDATA   oWScatalogProductAttributeSetListresult AS MagentoService_catalogProductAttributeSetEntityArray
	WSDATA   cattributeGroupId         AS string
	WSDATA   csortOrder                AS string
	WSDATA   lisAdded                  AS boolean
	WSDATA   cgroupName                AS string
	WSDATA   cgroupId                  AS string
	WSDATA   oWScatalogProductAttributeTypesresult AS MagentoService_catalogAttributeOptionEntityArray
	WSDATA   oWScatalogProductAttributeCreatedata AS MagentoService_catalogProductAttributeEntityToCreate
	WSDATA   cattribute                AS string
	WSDATA   oWScatalogProductAttributeInforesult AS MagentoService_catalogProductAttributeEntity
	WSDATA   oWScatalogProductAttributeUpdatedata AS MagentoService_catalogProductAttributeEntityToUpdate
	WSDATA   oWScatalogProductAttributeAddOptiondata AS MagentoService_catalogProductAttributeOptionEntityToAdd
	WSDATA   coptionId                 AS string
	WSDATA   oWScatalogProductTypeListresult AS MagentoService_catalogProductTypeEntityArray
	WSDATA   oWScatalogProductAttributeTierPriceInforesult AS MagentoService_catalogProductTierPriceEntityArray
	WSDATA   oWScatalogProductAttributeTierPriceUpdatetier_price AS MagentoService_catalogProductTierPriceEntityArray
	WSDATA   oWScatalogProductAttributeMediaListresult AS MagentoService_catalogProductImageEntityArray
	WSDATA   cfile                     AS string
	WSDATA   oWScatalogProductAttributeMediaInforesult AS MagentoService_catalogProductImageEntity
	WSDATA   oWScatalogProductAttributeMediaTypesresult AS MagentoService_catalogProductAttributeMediaTypeEntityArray
	WSDATA   oWScatalogProductAttributeMediaCreatedata AS MagentoService_catalogProductAttributeMediaCreateEntity
	WSDATA   oWScatalogProductAttributeMediaUpdatedata AS MagentoService_catalogProductAttributeMediaCreateEntity
	WSDATA   oWScatalogProductLinkListresult AS MagentoService_catalogProductLinkEntityArray
	WSDATA   clinkedProduct            AS string
	WSDATA   oWScatalogProductLinkAssigndata AS MagentoService_catalogProductLinkEntity
	WSDATA   oWScatalogProductLinkUpdatedata AS MagentoService_catalogProductLinkEntity
	WSDATA   oWScatalogProductLinkTypesresult AS MagentoService_ArrayOfString
	WSDATA   oWScatalogProductLinkAttributesresult AS MagentoService_catalogProductLinkAttributeEntityArray
	WSDATA   oWScatalogProductCustomOptionAdddata AS MagentoService_catalogProductCustomOptionToAdd
	WSDATA   oWScatalogProductCustomOptionUpdatedata AS MagentoService_catalogProductCustomOptionToUpdate
	WSDATA   oWScatalogProductCustomOptionTypesresult AS MagentoService_catalogProductCustomOptionTypesArray
	WSDATA   oWScatalogProductCustomOptionInforesult AS MagentoService_catalogProductCustomOptionInfoEntity
	WSDATA   oWScatalogProductCustomOptionListresult AS MagentoService_catalogProductCustomOptionListArray
	WSDATA   cvalueId                  AS string
	WSDATA   oWScatalogProductCustomOptionValueInforesult AS MagentoService_catalogProductCustomOptionValueInfoEntity
	WSDATA   oWScatalogProductCustomOptionValueListresult AS MagentoService_catalogProductCustomOptionValueListArray
	WSDATA   oWScatalogProductCustomOptionValueAdddata AS MagentoService_catalogProductCustomOptionValueAddArray
	WSDATA   oWScatalogProductCustomOptionValueUpdatedata AS MagentoService_catalogProductCustomOptionValueUpdateEntity
	WSDATA   oWSsalesOrderListfilters  AS MagentoService_filters
	WSDATA   oWSsalesOrderListresult   AS MagentoService_salesOrderListEntityArray
	WSDATA   corderIncrementId         AS string
	WSDATA   oWSsalesOrderInforesult   AS MagentoService_salesOrderEntity
	WSDATA   ccomment                  AS string
	WSDATA   cnotify                   AS string
	//By Rafael Rezende - 15/07/2019
	WSDATA 	 cstatus					As string
	WSDATA 	 lresult					As boolean
	WSDATA   nEmail						As int
	WSDATA   ctitle                     As string

	WSDATA   ctype   					As string
	WSDATA   cset						As string
	WSDATA   csku	 					As string
	// Fim
	WSDATA   oWSsalesOrderShipmentListfilters AS MagentoService_filters
	WSDATA   oWSsalesOrderShipmentListresult AS MagentoService_salesOrderShipmentEntityArray
	WSDATA   cshipmentIncrementId      AS string
	WSDATA   oWSsalesOrderShipmentInforesult AS MagentoService_salesOrderShipmentEntity
	WSDATA   oWSsalesOrderShipmentCreateitemsQty AS MagentoService_orderItemIdQtyArray
	WSDATA   nincludeComment           AS int
	WSDATA   cincludeInEmail           AS string
	WSDATA   ccarrier                  AS string
	WSDATA   ctrackNumber              AS string
	WSDATA   ctrackId                  AS string
	WSDATA   oWSsalesOrderShipmentGetCarriersresult AS MagentoService_associativeArray
	WSDATA   oWSsalesOrderInvoiceListfilters AS MagentoService_filters
	WSDATA   oWSsalesOrderInvoiceListresult AS MagentoService_salesOrderInvoiceEntityArray
	WSDATA   cinvoiceIncrementId       AS string
	WSDATA   oWSsalesOrderInvoiceInforesult AS MagentoService_salesOrderInvoiceEntity
	WSDATA   oWSsalesOrderInvoiceCreateitemsQty AS MagentoService_orderItemIdQtyArray
	WSDATA   oWSsalesOrderCreditmemoListfilters AS MagentoService_filters
	WSDATA   oWSsalesOrderCreditmemoListresult AS MagentoService_salesOrderCreditmemoEntityArray
	WSDATA   ccreditmemoIncrementId    AS string
	WSDATA   oWSsalesOrderCreditmemoInforesult AS MagentoService_salesOrderCreditmemoEntity
	WSDATA   oWSsalesOrderCreditmemoCreatecreditmemoData AS MagentoService_salesOrderCreditmemoData
	WSDATA   nnotifyCustomer           AS int
	WSDATA   crefundToStoreCreditAmount AS string
	WSDATA   oWScatalogInventoryStockItemListproducts AS MagentoService_ArrayOfString
	WSDATA   oWScatalogInventoryStockItemListresult AS MagentoService_catalogInventoryStockItemEntityArray
	WSDATA   oWScatalogInventoryStockItemUpdatedata AS MagentoService_catalogInventoryStockItemUpdateEntity
	WSDATA   oWScatalogInventoryStockItemMultiUpdateproductIds AS MagentoService_ArrayOfString
	WSDATA   oWScatalogInventoryStockItemMultiUpdateproductData AS MagentoService_catalogInventoryStockItemUpdateEntityArray
	WSDATA   nquoteId                  AS int
	WSDATA   oWSshoppingCartInforesult AS MagentoService_shoppingCartInfoEntity
	WSDATA   oWSshoppingCartOrderlicenses AS MagentoService_ArrayOfString
	WSDATA   oWSshoppingCartTotalsresult AS MagentoService_shoppingCartTotalsEntityArray
	WSDATA   oWSshoppingCartLicenseresult AS MagentoService_shoppingCartLicenseEntityArray
	WSDATA   oWSshoppingCartProductAddproducts AS MagentoService_shoppingCartProductEntityArray
	WSDATA   oWSshoppingCartProductUpdateproducts AS MagentoService_shoppingCartProductEntityArray
	WSDATA   oWSshoppingCartProductRemoveproducts AS MagentoService_shoppingCartProductEntityArray
	WSDATA   oWSshoppingCartProductListresult AS MagentoService_shoppingCartProductResponseEntityArray
	WSDATA   oWSshoppingCartProductMoveToCustomerQuoteproducts AS MagentoService_shoppingCartProductEntityArray
	WSDATA   oWSshoppingCartCustomerSetcustomer AS MagentoService_shoppingCartCustomerEntity
	WSDATA   oWSshoppingCartCustomerAddressescustomer AS MagentoService_shoppingCartCustomerAddressEntityArray
	WSDATA   cmethod                   AS string
	WSDATA   oWSshoppingCartShippingListresult AS MagentoService_shoppingCartShippingMethodEntityArray
	WSDATA   oWSshoppingCartPaymentMethodmethod AS MagentoService_shoppingCartPaymentMethodEntity
	WSDATA   oWSshoppingCartPaymentListresult AS MagentoService_shoppingCartPaymentMethodResponseEntityArray
	WSDATA   ccouponCode               AS string
	WSDATA   oWScatalogProductTagListresult AS MagentoService_catalogProductTagListEntityArray
	WSDATA   ctagId                    AS string
	WSDATA   oWScatalogProductTagInforesult AS MagentoService_catalogProductTagInfoEntity
	WSDATA   oWScatalogProductTagAdddata AS MagentoService_catalogProductTagAddEntity
	WSDATA   oWScatalogProductTagAddresult AS MagentoService_associativeArray
	WSDATA   oWScatalogProductTagUpdatedata AS MagentoService_catalogProductTagUpdateEntity
	WSDATA   oWSgiftMessageSetForQuotegiftMessage AS MagentoService_giftMessageEntity
	WSDATA   oWSgiftMessageSetForQuoteresult AS MagentoService_giftMessageResponse
	WSDATA   cquoteItemId              AS string
	WSDATA   oWSgiftMessageSetForQuoteItemgiftMessage AS MagentoService_giftMessageEntity
	WSDATA   oWSgiftMessageSetForQuoteItemresult AS MagentoService_giftMessageResponse
	WSDATA   oWSgiftMessageSetForQuoteProductproductsAndMessages AS MagentoService_giftMessageAssociativeProductsEntityArray
	WSDATA   oWSgiftMessageSetForQuoteProductresult AS MagentoService_giftMessageResponseArray
	WSDATA   oWScatalogProductDownloadableLinkAddresource AS MagentoService_catalogProductDownloadableLinkAddEntity
	WSDATA   cresourceType             AS string
	WSDATA   nrespons                  AS int
	WSDATA   oWScatalogProductDownloadableLinkListrespons AS MagentoService_catalogProductDownloadableLinkInfoEntity
	WSDATA   clinkId                   AS string
	WSDATA   oWSplpListplps            AS MagentoService_plpArray
	WSDATA   oWSintegratorOrderListShipmentssalesOrderShipmentListfilters AS MagentoService_filters
	WSDATA   oWSintegratorOrderListShipmentssalesOrderShipmentListresult AS MagentoService_salesOrderShipmentEntityArray
	WSDATA   oWSintegratorOrderEstimateShippingitems AS MagentoService_integratorEstimateShippingItemEntityArray
	WSDATA   oWSintegratorOrderEstimateShippingrates AS MagentoService_integratorEstimateShippingResponseItemEntityArray
	WSDATA   oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems AS MagentoService_integratorEstimateShippingItemEntityArray
	WSDATA   oWSintegratorOrderEstimateShippingPerItemrates AS MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray
	WSDATA   oWSintegratorOrderInforesult AS MagentoService_integratorOrderEntity
	WSDATA   cskyhubCode               AS string
	WSDATA   oWSintegratorOrderInvoiceerrors AS MagentoService_ArrayOfString
	WSDATA   cstoreCode                AS string
	WSDATA   oWSintegratorOrderCreateorder AS MagentoService_integratorCreateOrderEntity
	WSDATA   oWSintegratorOrderCreateerrors AS MagentoService_ArrayOfString
	WSDATA   oWSintegratorOrderUpdateorder AS MagentoService_integratorUpdateOrderEntity
	WSDATA   oWSintegratorOrderUpdateerrors AS MagentoService_ArrayOfString
	WSDATA   oWSintegratorOrderListStatusresult AS MagentoService_integratorListStatusEntityArray
	WSDATA   oWSintegratorOrderPaymentMethodspaymentMethods AS MagentoService_associativeArray
	WSDATA   oWSintegratorOrderShippingMethodsshippingMethods AS MagentoService_associativeArray
	WSDATA   ccurPage                  AS string
	WSDATA   cpageSize                 AS string
	WSDATA   oWSintegratorProductListCreatedresult AS MagentoService_integratorProductReturnEntityArray
	WSDATA   cupdatedFrom              AS string
	WSDATA   cattributeSet             AS string
	WSDATA   oWSintegratorProductItemsresult AS MagentoService_integratorProductReturnEntityArray
	WSDATA   cgetVariationPrices       AS string
	WSDATA   oWSintegratorProductItemsPagedintegratorProductItemsresult AS MagentoService_integratorProductReturnEntityArray
	WSDATA   oWSintegratorProductUrlsskus AS MagentoService_ArrayOfString
	WSDATA   oWSintegratorProductUrlsurls AS MagentoService_associativeArray
	WSDATA   oWSintegratorProductListUpdatedintegratorProductListCreatedresult AS MagentoService_integratorProductReturnEntityArray
	WSDATA   oWSintegratorProductListDeleteddeletedSkus AS MagentoService_ArrayOfString
	WSDATA   ccsv                      AS string
	WSDATA   lshouldIndex              AS boolean
	WSDATA   oWSintegratorProductImportCsverrors AS MagentoService_ArrayOfString
	WSDATA   ccount                    AS string
	WSDATA   oWSintegratorProductConfirmListCreatedReceivedreceivedSkus AS MagentoService_ArrayOfString
	WSDATA   oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus AS MagentoService_ArrayOfString
	WSDATA   oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus AS MagentoService_ArrayOfString

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSMagentoService
	::Init()
	If !FindFunction("XMLCHILDEX")
		UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20190114 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
	EndIf
Return Self

WSMETHOD INIT WSCLIENT WSMagentoService
	::oWSresourcesReturn := MagentoService_ARRAYOFAPIS():New()
	::oWSglobalFaultsReturn := MagentoService_ARRAYOFEXISTSFALTURES():New()
	::oWSresourceFaultsReturn := MagentoService_ARRAYOFEXISTSFALTURES():New()
	::oWSstoreListstores := MagentoService_STOREENTITYARRAY():New()
	::oWSstoreInfoinfo   := MagentoService_STOREENTITY():New()
	::oWSmagentoInfoinfo := MagentoService_MAGENTOINFOENTITY():New()
	::oWSdirectoryCountryListcountries := MagentoService_DIRECTORYCOUNTRYENTITYARRAY():New()
	::oWSdirectoryRegionListcountries := MagentoService_DIRECTORYREGIONENTITYARRAY():New()
	::oWScustomerCustomerListfilters := MagentoService_FILTERS():New()
	::oWScustomerCustomerListstoreView := MagentoService_CUSTOMERCUSTOMERENTITYARRAY():New()
	::oWScustomerCustomerCreatecustomerData := MagentoService_CUSTOMERCUSTOMERENTITYTOCREATE():New()
	::oWScustomerCustomerInfoattributes := MagentoService_ARRAYOFSTRING():New()
	::oWScustomerCustomerInfocustomerInfo := MagentoService_CUSTOMERCUSTOMERENTITY():New()
	::oWScustomerCustomerUpdatecustomerData := MagentoService_CUSTOMERCUSTOMERENTITYTOCREATE():New()
	::oWScustomerGroupListresult := MagentoService_CUSTOMERGROUPENTITYARRAY():New()
	::oWScustomerAddressListresult := MagentoService_CUSTOMERADDRESSENTITYARRAY():New()
	::oWScustomerAddressCreateaddressData := MagentoService_CUSTOMERADDRESSENTITYCREATE():New()
	::oWScustomerAddressInfoinfo := MagentoService_CUSTOMERADDRESSENTITYITEM():New()
	::oWScustomerAddressUpdateaddressData := MagentoService_CUSTOMERADDRESSENTITYCREATE():New()
	::oWScatalogCategoryTreetree := MagentoService_CATALOGCATEGORYTREE():New()
	::oWScatalogCategoryLeveltree := MagentoService_ARRAYOFCATALOGCATEGORYENTITIESNOCHILDREN():New()
	::oWScatalogCategoryInfoattributes := MagentoService_ARRAYOFSTRING():New()
	::oWScatalogCategoryInfoinfo := MagentoService_CATALOGCATEGORYINFO():New()
	::oWScatalogCategoryCreatecategoryData := MagentoService_CATALOGCATEGORYENTITYCREATE():New()
	::oWScatalogCategoryUpdatecategoryData := MagentoService_CATALOGCATEGORYENTITYCREATE():New()
	::oWScatalogCategoryAssignedProductsresult := MagentoService_CATALOGASSIGNEDPRODUCTARRAY():New()
	::oWScatalogCategoryAttributeListresult := MagentoService_CATALOGATTRIBUTEENTITYARRAY():New()
	::oWScatalogCategoryAttributeOptionsresult := MagentoService_CATALOGATTRIBUTEOPTIONENTITYARRAY():New()
	::oWScatalogProductListfilters := MagentoService_FILTERS():New()
	::oWScatalogProductListstoreView := MagentoService_CATALOGPRODUCTENTITYARRAY():New()
	::oWScatalogProductInfoattributes := MagentoService_CATALOGPRODUCTREQUESTATTRIBUTES():New()
	::oWScatalogProductInfoinfo := MagentoService_CATALOGPRODUCTRETURNENTITY():New()
	::oWScatalogProductCreateproductData := MagentoService_CATALOGPRODUCTCREATEENTITY():New()
	::oWScatalogProductUpdateproductData := MagentoService_CATALOGPRODUCTCREATEENTITY():New()
	::oWScatalogProductMultiUpdateproductIds := MagentoService_ARRAYOFSTRING():New()
	::oWScatalogProductMultiUpdateproductData := MagentoService_CATALOGPRODUCTCREATEENTITYARRAY():New()
	::oWScatalogProductGetSpecialPriceresult := MagentoService_CATALOGPRODUCTSPECIALPRICERETURNENTITY():New()
	::oWScatalogProductListOfAdditionalAttributesresult := MagentoService_CATALOGATTRIBUTEENTITYARRAY():New()
	::oWScatalogProductAttributeListresult := MagentoService_CATALOGATTRIBUTEENTITYARRAY():New()
	::oWScatalogProductAttributeOptionsresult := MagentoService_CATALOGATTRIBUTEOPTIONENTITYARRAY():New()
	::oWScatalogProductAttributeSetListresult := MagentoService_CATALOGPRODUCTATTRIBUTESETENTITYARRAY():New()
	::oWScatalogProductAttributeTypesresult := MagentoService_CATALOGATTRIBUTEOPTIONENTITYARRAY():New()
	::oWScatalogProductAttributeCreatedata := MagentoService_CATALOGPRODUCTATTRIBUTEENTITYTOCREATE():New()
	::oWScatalogProductAttributeInforesult := MagentoService_CATALOGPRODUCTATTRIBUTEENTITY():New()
	::oWScatalogProductAttributeUpdatedata := MagentoService_CATALOGPRODUCTATTRIBUTEENTITYTOUPDATE():New()
	::oWScatalogProductAttributeAddOptiondata := MagentoService_CATALOGPRODUCTATTRIBUTEOPTIONENTITYTOADD():New()
	::oWScatalogProductTypeListresult := MagentoService_CATALOGPRODUCTTYPEENTITYARRAY():New()
	::oWScatalogProductAttributeTierPriceInforesult := MagentoService_CATALOGPRODUCTTIERPRICEENTITYARRAY():New()
	::oWScatalogProductAttributeTierPriceUpdatetier_price := MagentoService_CATALOGPRODUCTTIERPRICEENTITYARRAY():New()
	::oWScatalogProductAttributeMediaListresult := MagentoService_CATALOGPRODUCTIMAGEENTITYARRAY():New()
	::oWScatalogProductAttributeMediaInforesult := MagentoService_CATALOGPRODUCTIMAGEENTITY():New()
	::oWScatalogProductAttributeMediaTypesresult := MagentoService_CATALOGPRODUCTATTRIBUTEMEDIATYPEENTITYARRAY():New()
	::oWScatalogProductAttributeMediaCreatedata := MagentoService_CATALOGPRODUCTATTRIBUTEMEDIACREATEENTITY():New()
	::oWScatalogProductAttributeMediaUpdatedata := MagentoService_CATALOGPRODUCTATTRIBUTEMEDIACREATEENTITY():New()
	::oWScatalogProductLinkListresult := MagentoService_CATALOGPRODUCTLINKENTITYARRAY():New()
	::oWScatalogProductLinkAssigndata := MagentoService_CATALOGPRODUCTLINKENTITY():New()
	::oWScatalogProductLinkUpdatedata := MagentoService_CATALOGPRODUCTLINKENTITY():New()
	::oWScatalogProductLinkTypesresult := MagentoService_ARRAYOFSTRING():New()
	::oWScatalogProductLinkAttributesresult := MagentoService_CATALOGPRODUCTLINKATTRIBUTEENTITYARRAY():New()
	::oWScatalogProductCustomOptionAdddata := MagentoService_CATALOGPRODUCTCUSTOMOPTIONTOADD():New()
	::oWScatalogProductCustomOptionUpdatedata := MagentoService_CATALOGPRODUCTCUSTOMOPTIONTOUPDATE():New()
	::oWScatalogProductCustomOptionTypesresult := MagentoService_CATALOGPRODUCTCUSTOMOPTIONTYPESARRAY():New()
	::oWScatalogProductCustomOptionInforesult := MagentoService_CATALOGPRODUCTCUSTOMOPTIONINFOENTITY():New()
	::oWScatalogProductCustomOptionListresult := MagentoService_CATALOGPRODUCTCUSTOMOPTIONLISTARRAY():New()
	::oWScatalogProductCustomOptionValueInforesult := MagentoService_CATALOGPRODUCTCUSTOMOPTIONVALUEINFOENTITY():New()
	::oWScatalogProductCustomOptionValueListresult := MagentoService_CATALOGPRODUCTCUSTOMOPTIONVALUELISTARRAY():New()
	::oWScatalogProductCustomOptionValueAdddata := MagentoService_CATALOGPRODUCTCUSTOMOPTIONVALUEADDARRAY():New()
	::oWScatalogProductCustomOptionValueUpdatedata := MagentoService_CATALOGPRODUCTCUSTOMOPTIONVALUEUPDATEENTITY():New()
	::oWSsalesOrderListfilters := MagentoService_FILTERS():New()
	::oWSsalesOrderListresult := MagentoService_SALESORDERLISTENTITYARRAY():New()
	::oWSsalesOrderInforesult := MagentoService_SALESORDERENTITY():New()
	::oWSsalesOrderShipmentListfilters := MagentoService_FILTERS():New()
	::oWSsalesOrderShipmentListresult := MagentoService_SALESORDERSHIPMENTENTITYARRAY():New()
	::oWSsalesOrderShipmentInforesult := MagentoService_SALESORDERSHIPMENTENTITY():New()
	::oWSsalesOrderShipmentCreateitemsQty := MagentoService_ORDERITEMIDQTYARRAY():New()
	::oWSsalesOrderShipmentGetCarriersresult := MagentoService_ASSOCIATIVEARRAY():New()
	::oWSsalesOrderInvoiceListfilters := MagentoService_FILTERS():New()
	::oWSsalesOrderInvoiceListresult := MagentoService_SALESORDERINVOICEENTITYARRAY():New()
	::oWSsalesOrderInvoiceInforesult := MagentoService_SALESORDERINVOICEENTITY():New()
	::oWSsalesOrderInvoiceCreateitemsQty := MagentoService_ORDERITEMIDQTYARRAY():New()
	::oWSsalesOrderCreditmemoListfilters := MagentoService_FILTERS():New()
	::oWSsalesOrderCreditmemoListresult := MagentoService_SALESORDERCREDITMEMOENTITYARRAY():New()
	::oWSsalesOrderCreditmemoInforesult := MagentoService_SALESORDERCREDITMEMOENTITY():New()
	::oWSsalesOrderCreditmemoCreatecreditmemoData := MagentoService_SALESORDERCREDITMEMODATA():New()
	::oWScatalogInventoryStockItemListproducts := MagentoService_ARRAYOFSTRING():New()
	::oWScatalogInventoryStockItemListresult := MagentoService_CATALOGINVENTORYSTOCKITEMENTITYARRAY():New()
	::oWScatalogInventoryStockItemUpdatedata := MagentoService_CATALOGINVENTORYSTOCKITEMUPDATEENTITY():New()
	::oWScatalogInventoryStockItemMultiUpdateproductIds := MagentoService_ARRAYOFSTRING():New()
	::oWScatalogInventoryStockItemMultiUpdateproductData := MagentoService_CATALOGINVENTORYSTOCKITEMUPDATEENTITYARRAY():New()
	::oWSshoppingCartInforesult := MagentoService_SHOPPINGCARTINFOENTITY():New()
	::oWSshoppingCartOrderlicenses := MagentoService_ARRAYOFSTRING():New()
	::oWSshoppingCartTotalsresult := MagentoService_SHOPPINGCARTTOTALSENTITYARRAY():New()
	::oWSshoppingCartLicenseresult := MagentoService_SHOPPINGCARTLICENSEENTITYARRAY():New()
	::oWSshoppingCartProductAddproducts := MagentoService_SHOPPINGCARTPRODUCTENTITYARRAY():New()
	::oWSshoppingCartProductUpdateproducts := MagentoService_SHOPPINGCARTPRODUCTENTITYARRAY():New()
	::oWSshoppingCartProductRemoveproducts := MagentoService_SHOPPINGCARTPRODUCTENTITYARRAY():New()
	::oWSshoppingCartProductListresult := MagentoService_SHOPPINGCARTPRODUCTRESPONSEENTITYARRAY():New()
	::oWSshoppingCartProductMoveToCustomerQuoteproducts := MagentoService_SHOPPINGCARTPRODUCTENTITYARRAY():New()
	::oWSshoppingCartCustomerSetcustomer := MagentoService_SHOPPINGCARTCUSTOMERENTITY():New()
	::oWSshoppingCartCustomerAddressescustomer := MagentoService_SHOPPINGCARTCUSTOMERADDRESSENTITYARRAY():New()
	::oWSshoppingCartShippingListresult := MagentoService_SHOPPINGCARTSHIPPINGMETHODENTITYARRAY():New()
	::oWSshoppingCartPaymentMethodmethod := MagentoService_SHOPPINGCARTPAYMENTMETHODENTITY():New()
	::oWSshoppingCartPaymentListresult := MagentoService_SHOPPINGCARTPAYMENTMETHODRESPONSEENTITYARRAY():New()
	::oWScatalogProductTagListresult := MagentoService_CATALOGPRODUCTTAGLISTENTITYARRAY():New()
	::oWScatalogProductTagInforesult := MagentoService_CATALOGPRODUCTTAGINFOENTITY():New()
	::oWScatalogProductTagAdddata := MagentoService_CATALOGPRODUCTTAGADDENTITY():New()
	::oWScatalogProductTagAddresult := MagentoService_ASSOCIATIVEARRAY():New()
	::oWScatalogProductTagUpdatedata := MagentoService_CATALOGPRODUCTTAGUPDATEENTITY():New()
	::oWSgiftMessageSetForQuotegiftMessage := MagentoService_GIFTMESSAGEENTITY():New()
	::oWSgiftMessageSetForQuoteresult := MagentoService_GIFTMESSAGERESPONSE():New()
	::oWSgiftMessageSetForQuoteItemgiftMessage := MagentoService_GIFTMESSAGEENTITY():New()
	::oWSgiftMessageSetForQuoteItemresult := MagentoService_GIFTMESSAGERESPONSE():New()
	::oWSgiftMessageSetForQuoteProductproductsAndMessages := MagentoService_GIFTMESSAGEASSOCIATIVEPRODUCTSENTITYARRAY():New()
	::oWSgiftMessageSetForQuoteProductresult := MagentoService_GIFTMESSAGERESPONSEARRAY():New()
	::oWScatalogProductDownloadableLinkAddresource := MagentoService_CATALOGPRODUCTDOWNLOADABLELINKADDENTITY():New()
	::oWScatalogProductDownloadableLinkListrespons := MagentoService_CATALOGPRODUCTDOWNLOADABLELINKINFOENTITY():New()
	::oWSplpListplps     := MagentoService_PLPARRAY():New()
	::oWSintegratorOrderListShipmentssalesOrderShipmentListfilters := MagentoService_FILTERS():New()
	::oWSintegratorOrderListShipmentssalesOrderShipmentListresult := MagentoService_SALESORDERSHIPMENTENTITYARRAY():New()
	::oWSintegratorOrderEstimateShippingitems := MagentoService_INTEGRATORESTIMATESHIPPINGITEMENTITYARRAY():New()
	::oWSintegratorOrderEstimateShippingrates := MagentoService_INTEGRATORESTIMATESHIPPINGRESPONSEITEMENTITYARRAY():New()
	::oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems := MagentoService_INTEGRATORESTIMATESHIPPINGITEMENTITYARRAY():New()
	::oWSintegratorOrderEstimateShippingPerItemrates := MagentoService_INTEGRATORESTIMATESHIPPINGPERITEMRESPONSEITEMENTITYARRAY():New()
	::oWSintegratorOrderInforesult := MagentoService_INTEGRATORORDERENTITY():New()
	::oWSintegratorOrderInvoiceerrors := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorOrderCreateorder := MagentoService_INTEGRATORCREATEORDERENTITY():New()
	::oWSintegratorOrderCreateerrors := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorOrderUpdateorder := MagentoService_INTEGRATORUPDATEORDERENTITY():New()
	::oWSintegratorOrderUpdateerrors := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorOrderListStatusresult := MagentoService_INTEGRATORLISTSTATUSENTITYARRAY():New()
	::oWSintegratorOrderPaymentMethodspaymentMethods := MagentoService_ASSOCIATIVEARRAY():New()
	::oWSintegratorOrderShippingMethodsshippingMethods := MagentoService_ASSOCIATIVEARRAY():New()
	::oWSintegratorProductListCreatedresult := MagentoService_INTEGRATORPRODUCTRETURNENTITYARRAY():New()
	::oWSintegratorProductItemsresult := MagentoService_INTEGRATORPRODUCTRETURNENTITYARRAY():New()
	::oWSintegratorProductItemsPagedintegratorProductItemsresult := MagentoService_INTEGRATORPRODUCTRETURNENTITYARRAY():New()
	::oWSintegratorProductUrlsskus := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorProductUrlsurls := MagentoService_ASSOCIATIVEARRAY():New()
	::oWSintegratorProductListUpdatedintegratorProductListCreatedresult := MagentoService_INTEGRATORPRODUCTRETURNENTITYARRAY():New()
	::oWSintegratorProductListDeleteddeletedSkus := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorProductImportCsverrors := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorProductConfirmListCreatedReceivedreceivedSkus := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus := MagentoService_ARRAYOFSTRING():New()
	::oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus := MagentoService_ARRAYOFSTRING():New()
Return

WSMETHOD RESET WSCLIENT WSMagentoService
	::csessionId         := NIL
	::lendSessionReturn  := NIL
	::cusername          := NIL
	::capiKey            := NIL
	::cloginReturn       := NIL
	::cstartSessionReturn := NIL
	::oWSresourcesReturn := NIL
	::oWSglobalFaultsReturn := NIL
	::cresourceName      := NIL
	::oWSresourceFaultsReturn := NIL
	::oWSstoreListstores := NIL
	::cstoreId           := NIL
	::oWSstoreInfoinfo   := NIL
	::oWSmagentoInfoinfo := NIL
	::oWSdirectoryCountryListcountries := NIL
	::ccountry           := NIL
	::oWSdirectoryRegionListcountries := NIL
	::oWScustomerCustomerListfilters := NIL
	::oWScustomerCustomerListstoreView := NIL
	::oWScustomerCustomerCreatecustomerData := NIL
	::nresult            := NIL
	::ncustomerId        := NIL
	::oWScustomerCustomerInfoattributes := NIL
	::oWScustomerCustomerInfocustomerInfo := NIL
	::oWScustomerCustomerUpdatecustomerData := NIL
	::oWScustomerGroupListresult := NIL
	::oWScustomerAddressListresult := NIL
	::oWScustomerAddressCreateaddressData := NIL
	::naddressId         := NIL
	::oWScustomerAddressInfoinfo := NIL
	::oWScustomerAddressUpdateaddressData := NIL
	::linfo              := NIL
	::cstoreView         := NIL
	::cparentId          := NIL
	::oWScatalogCategoryTreetree := NIL
	::cwebsite           := NIL
	::cparentCategory    := NIL
	::oWScatalogCategoryLeveltree := NIL
	::ncategoryId        := NIL
	::oWScatalogCategoryInfoattributes := NIL
	::oWScatalogCategoryInfoinfo := NIL
	::oWScatalogCategoryCreatecategoryData := NIL
	::nattribute_id      := NIL
	::oWScatalogCategoryUpdatecategoryData := NIL
	::lid                := NIL
	::cafterId           := NIL
	::oWScatalogCategoryAssignedProductsresult := NIL
	::cproduct           := NIL
	::cidentifierType    := NIL
	::oWScatalogCategoryAttributeListresult := NIL
	::cattributeId       := NIL
	::oWScatalogCategoryAttributeOptionsresult := NIL
	::oWScatalogProductListfilters := NIL
	::oWScatalogProductListstoreView := NIL
	::cproductId         := NIL
	::oWScatalogProductInfoattributes := NIL
	::oWScatalogProductInfoinfo := NIL
	::oWScatalogProductCreateproductData := NIL
	::oWScatalogProductUpdateproductData := NIL
	::oWScatalogProductMultiUpdateproductIds := NIL
	::oWScatalogProductMultiUpdateproductData := NIL
	::cstore             := NIL
	::cspecialPrice      := NIL
	::cfromDate          := NIL
	::ctoDate            := NIL
	::oWScatalogProductGetSpecialPriceresult := NIL
	::cproductType       := NIL
	::cattributeSetId    := NIL
	::oWScatalogProductListOfAdditionalAttributesresult := NIL
	::nsetId             := NIL
	::oWScatalogProductAttributeListresult := NIL
	::oWScatalogProductAttributeOptionsresult := NIL
	::cattributeSetName  := NIL
	::cskeletonSetId     := NIL
	::cforceProductsRemove := NIL
	::lisRemoved         := NIL
	::oWScatalogProductAttributeSetListresult := NIL
	::cattributeGroupId  := NIL
	::csortOrder         := NIL
	::lisAdded           := NIL
	::cgroupName         := NIL
	::cgroupId           := NIL
	::oWScatalogProductAttributeTypesresult := NIL
	::oWScatalogProductAttributeCreatedata := NIL
	::cattribute         := NIL
	::oWScatalogProductAttributeInforesult := NIL
	::oWScatalogProductAttributeUpdatedata := NIL
	::oWScatalogProductAttributeAddOptiondata := NIL
	::coptionId          := NIL
	::oWScatalogProductTypeListresult := NIL
	::oWScatalogProductAttributeTierPriceInforesult := NIL
	::oWScatalogProductAttributeTierPriceUpdatetier_price := NIL
	::oWScatalogProductAttributeMediaListresult := NIL
	::cfile              := NIL
	::oWScatalogProductAttributeMediaInforesult := NIL
	::oWScatalogProductAttributeMediaTypesresult := NIL
	::oWScatalogProductAttributeMediaCreatedata := NIL
	::oWScatalogProductAttributeMediaUpdatedata := NIL
	::oWScatalogProductLinkListresult := NIL
	::clinkedProduct     := NIL
	::oWScatalogProductLinkAssigndata := NIL
	::oWScatalogProductLinkUpdatedata := NIL
	::oWScatalogProductLinkTypesresult := NIL
	::oWScatalogProductLinkAttributesresult := NIL
	::oWScatalogProductCustomOptionAdddata := NIL
	::oWScatalogProductCustomOptionUpdatedata := NIL
	::oWScatalogProductCustomOptionTypesresult := NIL
	::oWScatalogProductCustomOptionInforesult := NIL
	::oWScatalogProductCustomOptionListresult := NIL
	::cvalueId           := NIL
	::oWScatalogProductCustomOptionValueInforesult := NIL
	::oWScatalogProductCustomOptionValueListresult := NIL
	::oWScatalogProductCustomOptionValueAdddata := NIL
	::oWScatalogProductCustomOptionValueUpdatedata := NIL
	::oWSsalesOrderListfilters := NIL
	::oWSsalesOrderListresult := NIL
	::corderIncrementId  := NIL
	::oWSsalesOrderInforesult := NIL
	::ccomment           := NIL
	//By Rafael Rezende - 15/07/2019

	::lresult			 := NIL
	::nEmail			 := NIL
	::cstatus			 := NIL
	::ctitle			 := NIL

	::ctype				 := NIL
	::cset				 := NIL
	::csku	 			 := NIL

	// Fim
	::cnotify            := NIL
	::oWSsalesOrderShipmentListfilters := NIL
	::oWSsalesOrderShipmentListresult := NIL
	::cshipmentIncrementId := NIL
	::oWSsalesOrderShipmentInforesult := NIL
	::oWSsalesOrderShipmentCreateitemsQty := NIL
	::nincludeComment    := NIL
	::cincludeInEmail    := NIL
	::ccarrier           := NIL
	::ctrackNumber       := NIL
	::ctrackId           := NIL
	::oWSsalesOrderShipmentGetCarriersresult := NIL
	::oWSsalesOrderInvoiceListfilters := NIL
	::oWSsalesOrderInvoiceListresult := NIL
	::cinvoiceIncrementId := NIL
	::oWSsalesOrderInvoiceInforesult := NIL
	::oWSsalesOrderInvoiceCreateitemsQty := NIL
	::oWSsalesOrderCreditmemoListfilters := NIL
	::oWSsalesOrderCreditmemoListresult := NIL
	::ccreditmemoIncrementId := NIL
	::oWSsalesOrderCreditmemoInforesult := NIL
	::oWSsalesOrderCreditmemoCreatecreditmemoData := NIL
	::nnotifyCustomer    := NIL
	::crefundToStoreCreditAmount := NIL
	::oWScatalogInventoryStockItemListproducts := NIL
	::oWScatalogInventoryStockItemListresult := NIL
	::oWScatalogInventoryStockItemUpdatedata := NIL
	::oWScatalogInventoryStockItemMultiUpdateproductIds := NIL
	::oWScatalogInventoryStockItemMultiUpdateproductData := NIL
	::nquoteId           := NIL
	::oWSshoppingCartInforesult := NIL
	::oWSshoppingCartOrderlicenses := NIL
	::oWSshoppingCartTotalsresult := NIL
	::oWSshoppingCartLicenseresult := NIL
	::oWSshoppingCartProductAddproducts := NIL
	::oWSshoppingCartProductUpdateproducts := NIL
	::oWSshoppingCartProductRemoveproducts := NIL
	::oWSshoppingCartProductListresult := NIL
	::oWSshoppingCartProductMoveToCustomerQuoteproducts := NIL
	::oWSshoppingCartCustomerSetcustomer := NIL
	::oWSshoppingCartCustomerAddressescustomer := NIL
	::cmethod            := NIL
	::oWSshoppingCartShippingListresult := NIL
	::oWSshoppingCartPaymentMethodmethod := NIL
	::oWSshoppingCartPaymentListresult := NIL
	::ccouponCode        := NIL
	::oWScatalogProductTagListresult := NIL
	::ctagId             := NIL
	::oWScatalogProductTagInforesult := NIL
	::oWScatalogProductTagAdddata := NIL
	::oWScatalogProductTagAddresult := NIL
	::oWScatalogProductTagUpdatedata := NIL
	::oWSgiftMessageSetForQuotegiftMessage := NIL
	::oWSgiftMessageSetForQuoteresult := NIL
	::cquoteItemId       := NIL
	::oWSgiftMessageSetForQuoteItemgiftMessage := NIL
	::oWSgiftMessageSetForQuoteItemresult := NIL
	::oWSgiftMessageSetForQuoteProductproductsAndMessages := NIL
	::oWSgiftMessageSetForQuoteProductresult := NIL
	::oWScatalogProductDownloadableLinkAddresource := NIL
	::cresourceType      := NIL
	::nrespons           := NIL
	::oWScatalogProductDownloadableLinkListrespons := NIL
	::clinkId            := NIL
	::oWSplpListplps     := NIL
	::oWSintegratorOrderListShipmentssalesOrderShipmentListfilters := NIL
	::oWSintegratorOrderListShipmentssalesOrderShipmentListresult := NIL
	::oWSintegratorOrderEstimateShippingitems := NIL
	::oWSintegratorOrderEstimateShippingrates := NIL
	::oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems := NIL
	::oWSintegratorOrderEstimateShippingPerItemrates := NIL
	::oWSintegratorOrderInforesult := NIL
	::cskyhubCode        := NIL
	::oWSintegratorOrderInvoiceerrors := NIL
	::cstoreCode         := NIL
	::oWSintegratorOrderCreateorder := NIL
	::oWSintegratorOrderCreateerrors := NIL
	::oWSintegratorOrderUpdateorder := NIL
	::oWSintegratorOrderUpdateerrors := NIL
	::oWSintegratorOrderListStatusresult := NIL
	::oWSintegratorOrderPaymentMethodspaymentMethods := NIL
	::oWSintegratorOrderShippingMethodsshippingMethods := NIL
	::ccurPage           := NIL
	::cpageSize          := NIL
	::oWSintegratorProductListCreatedresult := NIL
	::cupdatedFrom       := NIL
	::cattributeSet      := NIL
	::oWSintegratorProductItemsresult := NIL
	::cgetVariationPrices := NIL
	::oWSintegratorProductItemsPagedintegratorProductItemsresult := NIL
	::oWSintegratorProductUrlsskus := NIL
	::oWSintegratorProductUrlsurls := NIL
	::oWSintegratorProductListUpdatedintegratorProductListCreatedresult := NIL
	::oWSintegratorProductListDeleteddeletedSkus := NIL
	::ccsv               := NIL
	::lshouldIndex       := NIL
	::oWSintegratorProductImportCsverrors := NIL
	::ccount             := NIL
	::oWSintegratorProductConfirmListCreatedReceivedreceivedSkus := NIL
	::oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus := NIL
	::oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSMagentoService
	Local oClone := WSMagentoService():New()
	oClone:_URL          := ::_URL
	oClone:_CERT         := ::_CERT
	oClone:_PRIVKEY      := ::_PRIVKEY
	oClone:_PASSPHRASE   := ::_PASSPHRASE
	oClone:csessionId    := ::csessionId
	oClone:lendSessionReturn := ::lendSessionReturn
	oClone:cusername     := ::cusername
	oClone:capiKey       := ::capiKey
	oClone:cloginReturn  := ::cloginReturn
	oClone:cstartSessionReturn := ::cstartSessionReturn
	oClone:oWSresourcesReturn :=  IIF(::oWSresourcesReturn = NIL , NIL ,::oWSresourcesReturn:Clone() )
	oClone:oWSglobalFaultsReturn :=  IIF(::oWSglobalFaultsReturn = NIL , NIL ,::oWSglobalFaultsReturn:Clone() )
	oClone:cresourceName := ::cresourceName
	oClone:oWSresourceFaultsReturn :=  IIF(::oWSresourceFaultsReturn = NIL , NIL ,::oWSresourceFaultsReturn:Clone() )
	oClone:oWSstoreListstores :=  IIF(::oWSstoreListstores = NIL , NIL ,::oWSstoreListstores:Clone() )
	oClone:cstoreId      := ::cstoreId
	oClone:oWSstoreInfoinfo :=  IIF(::oWSstoreInfoinfo = NIL , NIL ,::oWSstoreInfoinfo:Clone() )
	oClone:oWSmagentoInfoinfo :=  IIF(::oWSmagentoInfoinfo = NIL , NIL ,::oWSmagentoInfoinfo:Clone() )
	oClone:oWSdirectoryCountryListcountries :=  IIF(::oWSdirectoryCountryListcountries = NIL , NIL ,::oWSdirectoryCountryListcountries:Clone() )
	oClone:ccountry      := ::ccountry
	oClone:oWSdirectoryRegionListcountries :=  IIF(::oWSdirectoryRegionListcountries = NIL , NIL ,::oWSdirectoryRegionListcountries:Clone() )
	oClone:oWScustomerCustomerListfilters :=  IIF(::oWScustomerCustomerListfilters = NIL , NIL ,::oWScustomerCustomerListfilters:Clone() )
	oClone:oWScustomerCustomerListstoreView :=  IIF(::oWScustomerCustomerListstoreView = NIL , NIL ,::oWScustomerCustomerListstoreView:Clone() )
	oClone:oWScustomerCustomerCreatecustomerData :=  IIF(::oWScustomerCustomerCreatecustomerData = NIL , NIL ,::oWScustomerCustomerCreatecustomerData:Clone() )
	oClone:nresult       := ::nresult
	oClone:ncustomerId   := ::ncustomerId
	oClone:oWScustomerCustomerInfoattributes :=  IIF(::oWScustomerCustomerInfoattributes = NIL , NIL ,::oWScustomerCustomerInfoattributes:Clone() )
	oClone:oWScustomerCustomerInfocustomerInfo :=  IIF(::oWScustomerCustomerInfocustomerInfo = NIL , NIL ,::oWScustomerCustomerInfocustomerInfo:Clone() )
	oClone:oWScustomerCustomerUpdatecustomerData :=  IIF(::oWScustomerCustomerUpdatecustomerData = NIL , NIL ,::oWScustomerCustomerUpdatecustomerData:Clone() )
	oClone:oWScustomerGroupListresult :=  IIF(::oWScustomerGroupListresult = NIL , NIL ,::oWScustomerGroupListresult:Clone() )
	oClone:oWScustomerAddressListresult :=  IIF(::oWScustomerAddressListresult = NIL , NIL ,::oWScustomerAddressListresult:Clone() )
	oClone:oWScustomerAddressCreateaddressData :=  IIF(::oWScustomerAddressCreateaddressData = NIL , NIL ,::oWScustomerAddressCreateaddressData:Clone() )
	oClone:naddressId    := ::naddressId
	oClone:oWScustomerAddressInfoinfo :=  IIF(::oWScustomerAddressInfoinfo = NIL , NIL ,::oWScustomerAddressInfoinfo:Clone() )
	oClone:oWScustomerAddressUpdateaddressData :=  IIF(::oWScustomerAddressUpdateaddressData = NIL , NIL ,::oWScustomerAddressUpdateaddressData:Clone() )
	oClone:linfo         := ::linfo
	oClone:cstoreView    := ::cstoreView
	oClone:cparentId     := ::cparentId
	oClone:oWScatalogCategoryTreetree :=  IIF(::oWScatalogCategoryTreetree = NIL , NIL ,::oWScatalogCategoryTreetree:Clone() )
	oClone:cwebsite      := ::cwebsite
	oClone:cparentCategory := ::cparentCategory
	oClone:oWScatalogCategoryLeveltree :=  IIF(::oWScatalogCategoryLeveltree = NIL , NIL ,::oWScatalogCategoryLeveltree:Clone() )
	oClone:ncategoryId   := ::ncategoryId
	oClone:oWScatalogCategoryInfoattributes :=  IIF(::oWScatalogCategoryInfoattributes = NIL , NIL ,::oWScatalogCategoryInfoattributes:Clone() )
	oClone:oWScatalogCategoryInfoinfo :=  IIF(::oWScatalogCategoryInfoinfo = NIL , NIL ,::oWScatalogCategoryInfoinfo:Clone() )
	oClone:oWScatalogCategoryCreatecategoryData :=  IIF(::oWScatalogCategoryCreatecategoryData = NIL , NIL ,::oWScatalogCategoryCreatecategoryData:Clone() )
	oClone:nattribute_id := ::nattribute_id
	oClone:oWScatalogCategoryUpdatecategoryData :=  IIF(::oWScatalogCategoryUpdatecategoryData = NIL , NIL ,::oWScatalogCategoryUpdatecategoryData:Clone() )
	oClone:lid           := ::lid
	oClone:cafterId      := ::cafterId
	oClone:oWScatalogCategoryAssignedProductsresult :=  IIF(::oWScatalogCategoryAssignedProductsresult = NIL , NIL ,::oWScatalogCategoryAssignedProductsresult:Clone() )
	oClone:cproduct      := ::cproduct
	oClone:cidentifierType := ::cidentifierType
	oClone:oWScatalogCategoryAttributeListresult :=  IIF(::oWScatalogCategoryAttributeListresult = NIL , NIL ,::oWScatalogCategoryAttributeListresult:Clone() )
	oClone:cattributeId  := ::cattributeId
	oClone:oWScatalogCategoryAttributeOptionsresult :=  IIF(::oWScatalogCategoryAttributeOptionsresult = NIL , NIL ,::oWScatalogCategoryAttributeOptionsresult:Clone() )
	oClone:oWScatalogProductListfilters :=  IIF(::oWScatalogProductListfilters = NIL , NIL ,::oWScatalogProductListfilters:Clone() )
	oClone:oWScatalogProductListstoreView :=  IIF(::oWScatalogProductListstoreView = NIL , NIL ,::oWScatalogProductListstoreView:Clone() )
	oClone:cproductId    := ::cproductId
	oClone:oWScatalogProductInfoattributes :=  IIF(::oWScatalogProductInfoattributes = NIL , NIL ,::oWScatalogProductInfoattributes:Clone() )
	oClone:oWScatalogProductInfoinfo :=  IIF(::oWScatalogProductInfoinfo = NIL , NIL ,::oWScatalogProductInfoinfo:Clone() )
	oClone:oWScatalogProductCreateproductData :=  IIF(::oWScatalogProductCreateproductData = NIL , NIL ,::oWScatalogProductCreateproductData:Clone() )
	oClone:oWScatalogProductUpdateproductData :=  IIF(::oWScatalogProductUpdateproductData = NIL , NIL ,::oWScatalogProductUpdateproductData:Clone() )
	oClone:oWScatalogProductMultiUpdateproductIds :=  IIF(::oWScatalogProductMultiUpdateproductIds = NIL , NIL ,::oWScatalogProductMultiUpdateproductIds:Clone() )
	oClone:oWScatalogProductMultiUpdateproductData :=  IIF(::oWScatalogProductMultiUpdateproductData = NIL , NIL ,::oWScatalogProductMultiUpdateproductData:Clone() )
	oClone:cstore        := ::cstore
	oClone:cspecialPrice := ::cspecialPrice
	oClone:cfromDate     := ::cfromDate
	oClone:ctoDate       := ::ctoDate
	oClone:oWScatalogProductGetSpecialPriceresult :=  IIF(::oWScatalogProductGetSpecialPriceresult = NIL , NIL ,::oWScatalogProductGetSpecialPriceresult:Clone() )
	oClone:cproductType  := ::cproductType
	oClone:cattributeSetId := ::cattributeSetId
	oClone:oWScatalogProductListOfAdditionalAttributesresult :=  IIF(::oWScatalogProductListOfAdditionalAttributesresult = NIL , NIL ,::oWScatalogProductListOfAdditionalAttributesresult:Clone() )
	oClone:nsetId        := ::nsetId
	oClone:oWScatalogProductAttributeListresult :=  IIF(::oWScatalogProductAttributeListresult = NIL , NIL ,::oWScatalogProductAttributeListresult:Clone() )
	oClone:oWScatalogProductAttributeOptionsresult :=  IIF(::oWScatalogProductAttributeOptionsresult = NIL , NIL ,::oWScatalogProductAttributeOptionsresult:Clone() )
	oClone:cattributeSetName := ::cattributeSetName
	oClone:cskeletonSetId := ::cskeletonSetId
	oClone:cforceProductsRemove := ::cforceProductsRemove
	oClone:lisRemoved    := ::lisRemoved
	oClone:oWScatalogProductAttributeSetListresult :=  IIF(::oWScatalogProductAttributeSetListresult = NIL , NIL ,::oWScatalogProductAttributeSetListresult:Clone() )
	oClone:cattributeGroupId := ::cattributeGroupId
	oClone:csortOrder    := ::csortOrder
	oClone:lisAdded      := ::lisAdded
	oClone:cgroupName    := ::cgroupName
	oClone:cgroupId      := ::cgroupId
	oClone:oWScatalogProductAttributeTypesresult :=  IIF(::oWScatalogProductAttributeTypesresult = NIL , NIL ,::oWScatalogProductAttributeTypesresult:Clone() )
	oClone:oWScatalogProductAttributeCreatedata :=  IIF(::oWScatalogProductAttributeCreatedata = NIL , NIL ,::oWScatalogProductAttributeCreatedata:Clone() )
	oClone:cattribute    := ::cattribute
	oClone:oWScatalogProductAttributeInforesult :=  IIF(::oWScatalogProductAttributeInforesult = NIL , NIL ,::oWScatalogProductAttributeInforesult:Clone() )
	oClone:oWScatalogProductAttributeUpdatedata :=  IIF(::oWScatalogProductAttributeUpdatedata = NIL , NIL ,::oWScatalogProductAttributeUpdatedata:Clone() )
	oClone:oWScatalogProductAttributeAddOptiondata :=  IIF(::oWScatalogProductAttributeAddOptiondata = NIL , NIL ,::oWScatalogProductAttributeAddOptiondata:Clone() )
	oClone:coptionId     := ::coptionId
	oClone:oWScatalogProductTypeListresult :=  IIF(::oWScatalogProductTypeListresult = NIL , NIL ,::oWScatalogProductTypeListresult:Clone() )
	oClone:oWScatalogProductAttributeTierPriceInforesult :=  IIF(::oWScatalogProductAttributeTierPriceInforesult = NIL , NIL ,::oWScatalogProductAttributeTierPriceInforesult:Clone() )
	oClone:oWScatalogProductAttributeTierPriceUpdatetier_price :=  IIF(::oWScatalogProductAttributeTierPriceUpdatetier_price = NIL , NIL ,::oWScatalogProductAttributeTierPriceUpdatetier_price:Clone() )
	oClone:oWScatalogProductAttributeMediaListresult :=  IIF(::oWScatalogProductAttributeMediaListresult = NIL , NIL ,::oWScatalogProductAttributeMediaListresult:Clone() )
	oClone:cfile         := ::cfile
	oClone:oWScatalogProductAttributeMediaInforesult :=  IIF(::oWScatalogProductAttributeMediaInforesult = NIL , NIL ,::oWScatalogProductAttributeMediaInforesult:Clone() )
	oClone:oWScatalogProductAttributeMediaTypesresult :=  IIF(::oWScatalogProductAttributeMediaTypesresult = NIL , NIL ,::oWScatalogProductAttributeMediaTypesresult:Clone() )
	oClone:oWScatalogProductAttributeMediaCreatedata :=  IIF(::oWScatalogProductAttributeMediaCreatedata = NIL , NIL ,::oWScatalogProductAttributeMediaCreatedata:Clone() )
	oClone:oWScatalogProductAttributeMediaUpdatedata :=  IIF(::oWScatalogProductAttributeMediaUpdatedata = NIL , NIL ,::oWScatalogProductAttributeMediaUpdatedata:Clone() )
	oClone:oWScatalogProductLinkListresult :=  IIF(::oWScatalogProductLinkListresult = NIL , NIL ,::oWScatalogProductLinkListresult:Clone() )
	oClone:clinkedProduct := ::clinkedProduct
	oClone:oWScatalogProductLinkAssigndata :=  IIF(::oWScatalogProductLinkAssigndata = NIL , NIL ,::oWScatalogProductLinkAssigndata:Clone() )
	oClone:oWScatalogProductLinkUpdatedata :=  IIF(::oWScatalogProductLinkUpdatedata = NIL , NIL ,::oWScatalogProductLinkUpdatedata:Clone() )
	oClone:oWScatalogProductLinkTypesresult :=  IIF(::oWScatalogProductLinkTypesresult = NIL , NIL ,::oWScatalogProductLinkTypesresult:Clone() )
	oClone:oWScatalogProductLinkAttributesresult :=  IIF(::oWScatalogProductLinkAttributesresult = NIL , NIL ,::oWScatalogProductLinkAttributesresult:Clone() )
	oClone:oWScatalogProductCustomOptionAdddata :=  IIF(::oWScatalogProductCustomOptionAdddata = NIL , NIL ,::oWScatalogProductCustomOptionAdddata:Clone() )
	oClone:oWScatalogProductCustomOptionUpdatedata :=  IIF(::oWScatalogProductCustomOptionUpdatedata = NIL , NIL ,::oWScatalogProductCustomOptionUpdatedata:Clone() )
	oClone:oWScatalogProductCustomOptionTypesresult :=  IIF(::oWScatalogProductCustomOptionTypesresult = NIL , NIL ,::oWScatalogProductCustomOptionTypesresult:Clone() )
	oClone:oWScatalogProductCustomOptionInforesult :=  IIF(::oWScatalogProductCustomOptionInforesult = NIL , NIL ,::oWScatalogProductCustomOptionInforesult:Clone() )
	oClone:oWScatalogProductCustomOptionListresult :=  IIF(::oWScatalogProductCustomOptionListresult = NIL , NIL ,::oWScatalogProductCustomOptionListresult:Clone() )
	oClone:cvalueId      := ::cvalueId
	oClone:oWScatalogProductCustomOptionValueInforesult :=  IIF(::oWScatalogProductCustomOptionValueInforesult = NIL , NIL ,::oWScatalogProductCustomOptionValueInforesult:Clone() )
	oClone:oWScatalogProductCustomOptionValueListresult :=  IIF(::oWScatalogProductCustomOptionValueListresult = NIL , NIL ,::oWScatalogProductCustomOptionValueListresult:Clone() )
	oClone:oWScatalogProductCustomOptionValueAdddata :=  IIF(::oWScatalogProductCustomOptionValueAdddata = NIL , NIL ,::oWScatalogProductCustomOptionValueAdddata:Clone() )
	oClone:oWScatalogProductCustomOptionValueUpdatedata :=  IIF(::oWScatalogProductCustomOptionValueUpdatedata = NIL , NIL ,::oWScatalogProductCustomOptionValueUpdatedata:Clone() )
	oClone:oWSsalesOrderListfilters :=  IIF(::oWSsalesOrderListfilters = NIL , NIL ,::oWSsalesOrderListfilters:Clone() )
	oClone:oWSsalesOrderListresult :=  IIF(::oWSsalesOrderListresult = NIL , NIL ,::oWSsalesOrderListresult:Clone() )
	oClone:corderIncrementId := ::corderIncrementId
	oClone:oWSsalesOrderInforesult :=  IIF(::oWSsalesOrderInforesult = NIL , NIL ,::oWSsalesOrderInforesult:Clone() )
	oClone:ccomment      := ::ccomment
	//By Rafael Rezende - 15/07/2019
	oClone:nEmail		 := ::nEmail
	oClone:cstatus		 := ::cstatus
	oClone:ctitle		 := ::ctitle
	oClone:lresult		 := ::lresult

	oClone:ctype		 := ::ctype
	oClone:cset			 := ::cset
	oClone:csku	 		 := ::csku

	// Fim
	oClone:cnotify       := ::cnotify
	oClone:oWSsalesOrderShipmentListfilters :=  IIF(::oWSsalesOrderShipmentListfilters = NIL , NIL ,::oWSsalesOrderShipmentListfilters:Clone() )
	oClone:oWSsalesOrderShipmentListresult :=  IIF(::oWSsalesOrderShipmentListresult = NIL , NIL ,::oWSsalesOrderShipmentListresult:Clone() )
	oClone:cshipmentIncrementId := ::cshipmentIncrementId
	oClone:oWSsalesOrderShipmentInforesult :=  IIF(::oWSsalesOrderShipmentInforesult = NIL , NIL ,::oWSsalesOrderShipmentInforesult:Clone() )
	oClone:oWSsalesOrderShipmentCreateitemsQty :=  IIF(::oWSsalesOrderShipmentCreateitemsQty = NIL , NIL ,::oWSsalesOrderShipmentCreateitemsQty:Clone() )
	oClone:nincludeComment := ::nincludeComment
	oClone:cincludeInEmail := ::cincludeInEmail
	oClone:ccarrier      := ::ccarrier
	oClone:ctrackNumber  := ::ctrackNumber
	oClone:ctrackId      := ::ctrackId
	oClone:oWSsalesOrderShipmentGetCarriersresult :=  IIF(::oWSsalesOrderShipmentGetCarriersresult = NIL , NIL ,::oWSsalesOrderShipmentGetCarriersresult:Clone() )
	oClone:oWSsalesOrderInvoiceListfilters :=  IIF(::oWSsalesOrderInvoiceListfilters = NIL , NIL ,::oWSsalesOrderInvoiceListfilters:Clone() )
	oClone:oWSsalesOrderInvoiceListresult :=  IIF(::oWSsalesOrderInvoiceListresult = NIL , NIL ,::oWSsalesOrderInvoiceListresult:Clone() )
	oClone:cinvoiceIncrementId := ::cinvoiceIncrementId
	oClone:oWSsalesOrderInvoiceInforesult :=  IIF(::oWSsalesOrderInvoiceInforesult = NIL , NIL ,::oWSsalesOrderInvoiceInforesult:Clone() )
	oClone:oWSsalesOrderInvoiceCreateitemsQty :=  IIF(::oWSsalesOrderInvoiceCreateitemsQty = NIL , NIL ,::oWSsalesOrderInvoiceCreateitemsQty:Clone() )
	oClone:oWSsalesOrderCreditmemoListfilters :=  IIF(::oWSsalesOrderCreditmemoListfilters = NIL , NIL ,::oWSsalesOrderCreditmemoListfilters:Clone() )
	oClone:oWSsalesOrderCreditmemoListresult :=  IIF(::oWSsalesOrderCreditmemoListresult = NIL , NIL ,::oWSsalesOrderCreditmemoListresult:Clone() )
	oClone:ccreditmemoIncrementId := ::ccreditmemoIncrementId
	oClone:oWSsalesOrderCreditmemoInforesult :=  IIF(::oWSsalesOrderCreditmemoInforesult = NIL , NIL ,::oWSsalesOrderCreditmemoInforesult:Clone() )
	oClone:oWSsalesOrderCreditmemoCreatecreditmemoData :=  IIF(::oWSsalesOrderCreditmemoCreatecreditmemoData = NIL , NIL ,::oWSsalesOrderCreditmemoCreatecreditmemoData:Clone() )
	oClone:nnotifyCustomer := ::nnotifyCustomer
	oClone:crefundToStoreCreditAmount := ::crefundToStoreCreditAmount
	oClone:oWScatalogInventoryStockItemListproducts :=  IIF(::oWScatalogInventoryStockItemListproducts = NIL , NIL ,::oWScatalogInventoryStockItemListproducts:Clone() )
	oClone:oWScatalogInventoryStockItemListresult :=  IIF(::oWScatalogInventoryStockItemListresult = NIL , NIL ,::oWScatalogInventoryStockItemListresult:Clone() )
	oClone:oWScatalogInventoryStockItemUpdatedata :=  IIF(::oWScatalogInventoryStockItemUpdatedata = NIL , NIL ,::oWScatalogInventoryStockItemUpdatedata:Clone() )
	oClone:oWScatalogInventoryStockItemMultiUpdateproductIds :=  IIF(::oWScatalogInventoryStockItemMultiUpdateproductIds = NIL , NIL ,::oWScatalogInventoryStockItemMultiUpdateproductIds:Clone() )
	oClone:oWScatalogInventoryStockItemMultiUpdateproductData :=  IIF(::oWScatalogInventoryStockItemMultiUpdateproductData = NIL , NIL ,::oWScatalogInventoryStockItemMultiUpdateproductData:Clone() )
	oClone:nquoteId      := ::nquoteId
	oClone:oWSshoppingCartInforesult :=  IIF(::oWSshoppingCartInforesult = NIL , NIL ,::oWSshoppingCartInforesult:Clone() )
	oClone:oWSshoppingCartOrderlicenses :=  IIF(::oWSshoppingCartOrderlicenses = NIL , NIL ,::oWSshoppingCartOrderlicenses:Clone() )
	oClone:oWSshoppingCartTotalsresult :=  IIF(::oWSshoppingCartTotalsresult = NIL , NIL ,::oWSshoppingCartTotalsresult:Clone() )
	oClone:oWSshoppingCartLicenseresult :=  IIF(::oWSshoppingCartLicenseresult = NIL , NIL ,::oWSshoppingCartLicenseresult:Clone() )
	oClone:oWSshoppingCartProductAddproducts :=  IIF(::oWSshoppingCartProductAddproducts = NIL , NIL ,::oWSshoppingCartProductAddproducts:Clone() )
	oClone:oWSshoppingCartProductUpdateproducts :=  IIF(::oWSshoppingCartProductUpdateproducts = NIL , NIL ,::oWSshoppingCartProductUpdateproducts:Clone() )
	oClone:oWSshoppingCartProductRemoveproducts :=  IIF(::oWSshoppingCartProductRemoveproducts = NIL , NIL ,::oWSshoppingCartProductRemoveproducts:Clone() )
	oClone:oWSshoppingCartProductListresult :=  IIF(::oWSshoppingCartProductListresult = NIL , NIL ,::oWSshoppingCartProductListresult:Clone() )
	oClone:oWSshoppingCartProductMoveToCustomerQuoteproducts :=  IIF(::oWSshoppingCartProductMoveToCustomerQuoteproducts = NIL , NIL ,::oWSshoppingCartProductMoveToCustomerQuoteproducts:Clone() )
	oClone:oWSshoppingCartCustomerSetcustomer :=  IIF(::oWSshoppingCartCustomerSetcustomer = NIL , NIL ,::oWSshoppingCartCustomerSetcustomer:Clone() )
	oClone:oWSshoppingCartCustomerAddressescustomer :=  IIF(::oWSshoppingCartCustomerAddressescustomer = NIL , NIL ,::oWSshoppingCartCustomerAddressescustomer:Clone() )
	oClone:cmethod       := ::cmethod
	oClone:oWSshoppingCartShippingListresult :=  IIF(::oWSshoppingCartShippingListresult = NIL , NIL ,::oWSshoppingCartShippingListresult:Clone() )
	oClone:oWSshoppingCartPaymentMethodmethod :=  IIF(::oWSshoppingCartPaymentMethodmethod = NIL , NIL ,::oWSshoppingCartPaymentMethodmethod:Clone() )
	oClone:oWSshoppingCartPaymentListresult :=  IIF(::oWSshoppingCartPaymentListresult = NIL , NIL ,::oWSshoppingCartPaymentListresult:Clone() )
	oClone:ccouponCode   := ::ccouponCode
	oClone:oWScatalogProductTagListresult :=  IIF(::oWScatalogProductTagListresult = NIL , NIL ,::oWScatalogProductTagListresult:Clone() )
	oClone:ctagId        := ::ctagId
	oClone:oWScatalogProductTagInforesult :=  IIF(::oWScatalogProductTagInforesult = NIL , NIL ,::oWScatalogProductTagInforesult:Clone() )
	oClone:oWScatalogProductTagAdddata :=  IIF(::oWScatalogProductTagAdddata = NIL , NIL ,::oWScatalogProductTagAdddata:Clone() )
	oClone:oWScatalogProductTagAddresult :=  IIF(::oWScatalogProductTagAddresult = NIL , NIL ,::oWScatalogProductTagAddresult:Clone() )
	oClone:oWScatalogProductTagUpdatedata :=  IIF(::oWScatalogProductTagUpdatedata = NIL , NIL ,::oWScatalogProductTagUpdatedata:Clone() )
	oClone:oWSgiftMessageSetForQuotegiftMessage :=  IIF(::oWSgiftMessageSetForQuotegiftMessage = NIL , NIL ,::oWSgiftMessageSetForQuotegiftMessage:Clone() )
	oClone:oWSgiftMessageSetForQuoteresult :=  IIF(::oWSgiftMessageSetForQuoteresult = NIL , NIL ,::oWSgiftMessageSetForQuoteresult:Clone() )
	oClone:cquoteItemId  := ::cquoteItemId
	oClone:oWSgiftMessageSetForQuoteItemgiftMessage :=  IIF(::oWSgiftMessageSetForQuoteItemgiftMessage = NIL , NIL ,::oWSgiftMessageSetForQuoteItemgiftMessage:Clone() )
	oClone:oWSgiftMessageSetForQuoteItemresult :=  IIF(::oWSgiftMessageSetForQuoteItemresult = NIL , NIL ,::oWSgiftMessageSetForQuoteItemresult:Clone() )
	oClone:oWSgiftMessageSetForQuoteProductproductsAndMessages :=  IIF(::oWSgiftMessageSetForQuoteProductproductsAndMessages = NIL , NIL ,::oWSgiftMessageSetForQuoteProductproductsAndMessages:Clone() )
	oClone:oWSgiftMessageSetForQuoteProductresult :=  IIF(::oWSgiftMessageSetForQuoteProductresult = NIL , NIL ,::oWSgiftMessageSetForQuoteProductresult:Clone() )
	oClone:oWScatalogProductDownloadableLinkAddresource :=  IIF(::oWScatalogProductDownloadableLinkAddresource = NIL , NIL ,::oWScatalogProductDownloadableLinkAddresource:Clone() )
	oClone:cresourceType := ::cresourceType
	oClone:nrespons      := ::nrespons
	oClone:oWScatalogProductDownloadableLinkListrespons :=  IIF(::oWScatalogProductDownloadableLinkListrespons = NIL , NIL ,::oWScatalogProductDownloadableLinkListrespons:Clone() )
	oClone:clinkId       := ::clinkId
	oClone:oWSplpListplps :=  IIF(::oWSplpListplps = NIL , NIL ,::oWSplpListplps:Clone() )
	oClone:oWSintegratorOrderListShipmentssalesOrderShipmentListfilters :=  IIF(::oWSintegratorOrderListShipmentssalesOrderShipmentListfilters = NIL , NIL ,::oWSintegratorOrderListShipmentssalesOrderShipmentListfilters:Clone() )
	oClone:oWSintegratorOrderListShipmentssalesOrderShipmentListresult :=  IIF(::oWSintegratorOrderListShipmentssalesOrderShipmentListresult = NIL , NIL ,::oWSintegratorOrderListShipmentssalesOrderShipmentListresult:Clone() )
	oClone:oWSintegratorOrderEstimateShippingitems :=  IIF(::oWSintegratorOrderEstimateShippingitems = NIL , NIL ,::oWSintegratorOrderEstimateShippingitems:Clone() )
	oClone:oWSintegratorOrderEstimateShippingrates :=  IIF(::oWSintegratorOrderEstimateShippingrates = NIL , NIL ,::oWSintegratorOrderEstimateShippingrates:Clone() )
	oClone:oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems :=  IIF(::oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems = NIL , NIL ,::oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems:Clone() )
	oClone:oWSintegratorOrderEstimateShippingPerItemrates :=  IIF(::oWSintegratorOrderEstimateShippingPerItemrates = NIL , NIL ,::oWSintegratorOrderEstimateShippingPerItemrates:Clone() )
	oClone:oWSintegratorOrderInforesult :=  IIF(::oWSintegratorOrderInforesult = NIL , NIL ,::oWSintegratorOrderInforesult:Clone() )
	oClone:cskyhubCode   := ::cskyhubCode
	oClone:oWSintegratorOrderInvoiceerrors :=  IIF(::oWSintegratorOrderInvoiceerrors = NIL , NIL ,::oWSintegratorOrderInvoiceerrors:Clone() )
	oClone:cstoreCode    := ::cstoreCode
	oClone:oWSintegratorOrderCreateorder :=  IIF(::oWSintegratorOrderCreateorder = NIL , NIL ,::oWSintegratorOrderCreateorder:Clone() )
	oClone:oWSintegratorOrderCreateerrors :=  IIF(::oWSintegratorOrderCreateerrors = NIL , NIL ,::oWSintegratorOrderCreateerrors:Clone() )
	oClone:oWSintegratorOrderUpdateorder :=  IIF(::oWSintegratorOrderUpdateorder = NIL , NIL ,::oWSintegratorOrderUpdateorder:Clone() )
	oClone:oWSintegratorOrderUpdateerrors :=  IIF(::oWSintegratorOrderUpdateerrors = NIL , NIL ,::oWSintegratorOrderUpdateerrors:Clone() )
	oClone:oWSintegratorOrderListStatusresult :=  IIF(::oWSintegratorOrderListStatusresult = NIL , NIL ,::oWSintegratorOrderListStatusresult:Clone() )
	oClone:oWSintegratorOrderPaymentMethodspaymentMethods :=  IIF(::oWSintegratorOrderPaymentMethodspaymentMethods = NIL , NIL ,::oWSintegratorOrderPaymentMethodspaymentMethods:Clone() )
	oClone:oWSintegratorOrderShippingMethodsshippingMethods :=  IIF(::oWSintegratorOrderShippingMethodsshippingMethods = NIL , NIL ,::oWSintegratorOrderShippingMethodsshippingMethods:Clone() )
	oClone:ccurPage      := ::ccurPage
	oClone:cpageSize     := ::cpageSize
	oClone:oWSintegratorProductListCreatedresult :=  IIF(::oWSintegratorProductListCreatedresult = NIL , NIL ,::oWSintegratorProductListCreatedresult:Clone() )
	oClone:cupdatedFrom  := ::cupdatedFrom
	oClone:cattributeSet := ::cattributeSet
	oClone:oWSintegratorProductItemsresult :=  IIF(::oWSintegratorProductItemsresult = NIL , NIL ,::oWSintegratorProductItemsresult:Clone() )
	oClone:cgetVariationPrices := ::cgetVariationPrices
	oClone:oWSintegratorProductItemsPagedintegratorProductItemsresult :=  IIF(::oWSintegratorProductItemsPagedintegratorProductItemsresult = NIL , NIL ,::oWSintegratorProductItemsPagedintegratorProductItemsresult:Clone() )
	oClone:oWSintegratorProductUrlsskus :=  IIF(::oWSintegratorProductUrlsskus = NIL , NIL ,::oWSintegratorProductUrlsskus:Clone() )
	oClone:oWSintegratorProductUrlsurls :=  IIF(::oWSintegratorProductUrlsurls = NIL , NIL ,::oWSintegratorProductUrlsurls:Clone() )
	oClone:oWSintegratorProductListUpdatedintegratorProductListCreatedresult :=  IIF(::oWSintegratorProductListUpdatedintegratorProductListCreatedresult = NIL , NIL ,::oWSintegratorProductListUpdatedintegratorProductListCreatedresult:Clone() )
	oClone:oWSintegratorProductListDeleteddeletedSkus :=  IIF(::oWSintegratorProductListDeleteddeletedSkus = NIL , NIL ,::oWSintegratorProductListDeleteddeletedSkus:Clone() )
	oClone:ccsv          := ::ccsv
	oClone:lshouldIndex  := ::lshouldIndex
	oClone:oWSintegratorProductImportCsverrors :=  IIF(::oWSintegratorProductImportCsverrors = NIL , NIL ,::oWSintegratorProductImportCsverrors:Clone() )
	oClone:ccount        := ::ccount
	oClone:oWSintegratorProductConfirmListCreatedReceivedreceivedSkus :=  IIF(::oWSintegratorProductConfirmListCreatedReceivedreceivedSkus = NIL , NIL ,::oWSintegratorProductConfirmListCreatedReceivedreceivedSkus:Clone() )
	oClone:oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus :=  IIF(::oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus = NIL , NIL ,::oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus:Clone() )
	oClone:oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus :=  IIF(::oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus = NIL , NIL ,::oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus:Clone() )
Return oClone

// WSDL Method endSession of Service WSMagentoService

WSMETHOD endSession WSSEND csessionId WSRECEIVE lendSessionReturn WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:endSession xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:endSession>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lendSessionReturn  :=  WSAdvValue( oXmlRet,"_ENDSESSIONRETURN","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method login of Service WSMagentoService

WSMETHOD login WSSEND cusername,capiKey WSRECEIVE cloginReturn WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:login xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("username", ::cusername, cusername , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("apiKey", ::capiKey, capiKey , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:login>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::cloginReturn       :=  WSAdvValue( oXmlRet,"_LOGINRETURN","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method startSession of Service WSMagentoService

WSMETHOD startSession WSSEND NULLPARAM WSRECEIVE cstartSessionReturn WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:startSession xmlns:q1="urn:Magento">'
	cSoap += "</q1:startSession>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::cstartSessionReturn :=  WSAdvValue( oXmlRet,"_STARTSESSIONRETURN","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method resources of Service WSMagentoService

WSMETHOD resources WSSEND csessionId WSRECEIVE oWSresourcesReturn WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:resources xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:resources>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSresourcesReturn:SoapRecv( WSAdvValue( oXmlRet,"_RESOURCESRETURN","ArrayOfApis",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method globalFaults of Service WSMagentoService

WSMETHOD globalFaults WSSEND csessionId WSRECEIVE oWSglobalFaultsReturn WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:globalFaults xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:globalFaults>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSglobalFaultsReturn:SoapRecv( WSAdvValue( oXmlRet,"_GLOBALFAULTSRETURN","ArrayOfExistsFaltures",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method resourceFaults of Service WSMagentoService

WSMETHOD resourceFaults WSSEND cresourceName,csessionId WSRECEIVE oWSresourceFaultsReturn WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:resourceFaults xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("resourceName", ::cresourceName, cresourceName , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:resourceFaults>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSresourceFaultsReturn:SoapRecv( WSAdvValue( oXmlRet,"_RESOURCEFAULTSRETURN","ArrayOfExistsFaltures",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method storeList of Service WSMagentoService

WSMETHOD storeList WSSEND csessionId WSRECEIVE oWSstoreListstores WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:storeList xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:storeList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSstoreListstores:SoapRecv( WSAdvValue( oXmlRet,"_STORES","storeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method storeInfo of Service WSMagentoService

WSMETHOD storeInfo WSSEND csessionId,cstoreId WSRECEIVE oWSstoreInfoinfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:storeInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:storeInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSstoreInfoinfo:SoapRecv( WSAdvValue( oXmlRet,"_INFO","storeEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method magentoInfo of Service WSMagentoService

WSMETHOD magentoInfo WSSEND csessionId WSRECEIVE oWSmagentoInfoinfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:magentoInfo xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:magentoInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSmagentoInfoinfo:SoapRecv( WSAdvValue( oXmlRet,"_INFO","magentoInfoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method directoryCountryList of Service WSMagentoService

WSMETHOD directoryCountryList WSSEND csessionId WSRECEIVE oWSdirectoryCountryListcountries WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:directoryCountryList xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:directoryCountryList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSdirectoryCountryListcountries:SoapRecv( WSAdvValue( oXmlRet,"_COUNTRIES","directoryCountryEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method directoryRegionList of Service WSMagentoService

WSMETHOD directoryRegionList WSSEND csessionId,ccountry WSRECEIVE oWSdirectoryRegionListcountries WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:directoryRegionList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("country", ::ccountry, ccountry , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:directoryRegionList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWSdirectoryRegionListcountries:SoapRecv( WSAdvValue( oXmlRet,"_COUNTRIES","directoryRegionEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerCustomerList of Service WSMagentoService

WSMETHOD customerCustomerList WSSEND csessionId,oWScustomerCustomerListfilters WSRECEIVE oWScustomerCustomerListstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerCustomerList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("filters", ::oWScustomerCustomerListfilters, oWScustomerCustomerListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerCustomerList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScustomerCustomerListstoreView:SoapRecv( WSAdvValue( oXmlRet,"_STOREVIEW","customerCustomerEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerCustomerCreate of Service WSMagentoService

WSMETHOD customerCustomerCreate WSSEND csessionId,oWScustomerCustomerCreatecustomerData WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerCustomerCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerData", ::oWScustomerCustomerCreatecustomerData, oWScustomerCustomerCreatecustomerData , "customerCustomerEntityToCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerCustomerCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerCustomerInfo of Service WSMagentoService

WSMETHOD customerCustomerInfo WSSEND csessionId,ncustomerId,oWScustomerCustomerInfoattributes WSRECEIVE oWScustomerCustomerInfocustomerInfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerCustomerInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerId", ::ncustomerId, ncustomerId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributes", ::oWScustomerCustomerInfoattributes, oWScustomerCustomerInfoattributes , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerCustomerInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScustomerCustomerInfocustomerInfo:SoapRecv( WSAdvValue( oXmlRet,"_CUSTOMERINFO","customerCustomerEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerCustomerUpdate of Service WSMagentoService

WSMETHOD customerCustomerUpdate WSSEND csessionId,ncustomerId,oWScustomerCustomerUpdatecustomerData WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerCustomerUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerId", ::ncustomerId, ncustomerId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerData", ::oWScustomerCustomerUpdatecustomerData, oWScustomerCustomerUpdatecustomerData , "customerCustomerEntityToCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerCustomerUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerCustomerDelete of Service WSMagentoService

WSMETHOD customerCustomerDelete WSSEND csessionId,ncustomerId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerCustomerDelete xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerId", ::ncustomerId, ncustomerId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerCustomerDelete>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerGroupList of Service WSMagentoService

WSMETHOD customerGroupList WSSEND csessionId WSRECEIVE oWScustomerGroupListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerGroupList xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerGroupList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScustomerGroupListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","customerGroupEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerAddressList of Service WSMagentoService

WSMETHOD customerAddressList WSSEND csessionId,ncustomerId WSRECEIVE oWScustomerAddressListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerAddressList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerId", ::ncustomerId, ncustomerId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerAddressList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScustomerAddressListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","customerAddressEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerAddressCreate of Service WSMagentoService

WSMETHOD customerAddressCreate WSSEND csessionId,ncustomerId,oWScustomerAddressCreateaddressData WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerAddressCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customerId", ::ncustomerId, ncustomerId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("addressData", ::oWScustomerAddressCreateaddressData, oWScustomerAddressCreateaddressData , "customerAddressEntityCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerAddressCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerAddressInfo of Service WSMagentoService

WSMETHOD customerAddressInfo WSSEND csessionId,naddressId WSRECEIVE oWScustomerAddressInfoinfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerAddressInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("addressId", ::naddressId, naddressId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerAddressInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScustomerAddressInfoinfo:SoapRecv( WSAdvValue( oXmlRet,"_INFO","customerAddressEntityItem",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerAddressUpdate of Service WSMagentoService

WSMETHOD customerAddressUpdate WSSEND csessionId,naddressId,oWScustomerAddressUpdateaddressData WSRECEIVE linfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerAddressUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("addressId", ::naddressId, naddressId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("addressData", ::oWScustomerAddressUpdateaddressData, oWScustomerAddressUpdateaddressData , "customerAddressEntityCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerAddressUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::linfo              :=  WSAdvValue( oXmlRet,"_INFO","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method customerAddressDelete of Service WSMagentoService

WSMETHOD customerAddressDelete WSSEND csessionId,naddressId WSRECEIVE linfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:customerAddressDelete xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("addressId", ::naddressId, naddressId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:customerAddressDelete>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::linfo              :=  WSAdvValue( oXmlRet,"_INFO","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryCurrentStore of Service WSMagentoService

WSMETHOD catalogCategoryCurrentStore WSSEND csessionId,cstoreView WSRECEIVE nstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryCurrentStore xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryCurrentStore>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nstoreView         :=  WSAdvValue( oXmlRet,"_STOREVIEW","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryTree of Service WSMagentoService

WSMETHOD catalogCategoryTree WSSEND csessionId,cparentId,cstoreView WSRECEIVE oWScatalogCategoryTreetree WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryTree xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("parentId", ::cparentId, cparentId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryTree>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogCategoryTreetree:SoapRecv( WSAdvValue( oXmlRet,"_TREE","catalogCategoryTree",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryLevel of Service WSMagentoService

WSMETHOD catalogCategoryLevel WSSEND csessionId,cwebsite,cstoreView,cparentCategory WSRECEIVE oWScatalogCategoryLeveltree WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryLevel xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("website", ::cwebsite, cwebsite , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("parentCategory", ::cparentCategory, cparentCategory , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryLevel>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogCategoryLeveltree:SoapRecv( WSAdvValue( oXmlRet,"_TREE","ArrayOfCatalogCategoryEntitiesNoChildren",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryInfo of Service WSMagentoService

WSMETHOD catalogCategoryInfo WSSEND csessionId,ncategoryId,cstoreView,oWScatalogCategoryInfoattributes WSRECEIVE oWScatalogCategoryInfoinfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributes", ::oWScatalogCategoryInfoattributes, oWScatalogCategoryInfoattributes , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogCategoryInfoinfo:SoapRecv( WSAdvValue( oXmlRet,"_INFO","catalogCategoryInfo",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryCreate of Service WSMagentoService

WSMETHOD catalogCategoryCreate WSSEND csessionId,nparentId,oWScatalogCategoryCreatecategoryData,cstoreView WSRECEIVE nattribute_id WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("parentId", ::nparentId, nparentId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryData", ::oWScatalogCategoryCreatecategoryData, oWScatalogCategoryCreatecategoryData , "catalogCategoryEntityCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nattribute_id      :=  WSAdvValue( oXmlRet,"_ATTRIBUTE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryUpdate of Service WSMagentoService

WSMETHOD catalogCategoryUpdate WSSEND csessionId,ncategoryId,oWScatalogCategoryUpdatecategoryData,cstoreView WSRECEIVE lid WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryData", ::oWScatalogCategoryUpdatecategoryData, oWScatalogCategoryUpdatecategoryData , "catalogCategoryEntityCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lid                :=  WSAdvValue( oXmlRet,"_ID","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryMove of Service WSMagentoService

WSMETHOD catalogCategoryMove WSSEND csessionId,ncategoryId,nparentId,cafterId WSRECEIVE lid WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryMove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("parentId", ::nparentId, nparentId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("afterId", ::cafterId, cafterId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryMove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lid                :=  WSAdvValue( oXmlRet,"_ID","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryDelete of Service WSMagentoService

WSMETHOD catalogCategoryDelete WSSEND csessionId,ncategoryId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryDelete xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryDelete>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryAssignedProducts of Service WSMagentoService

WSMETHOD catalogCategoryAssignedProducts WSSEND csessionId,ncategoryId WSRECEIVE oWScatalogCategoryAssignedProductsresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryAssignedProducts xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryAssignedProducts>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogCategoryAssignedProductsresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAssignedProductArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryAssignProduct of Service WSMagentoService

WSMETHOD catalogCategoryAssignProduct WSSEND csessionId,ncategoryId,cproduct,cposition,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryAssignProduct xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("position", ::cposition, cposition , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryAssignProduct>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryUpdateProduct of Service WSMagentoService

WSMETHOD catalogCategoryUpdateProduct WSSEND csessionId,ncategoryId,cproduct,cposition,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryUpdateProduct xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("position", ::cposition, cposition , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryUpdateProduct>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryRemoveProduct of Service WSMagentoService

WSMETHOD catalogCategoryRemoveProduct WSSEND csessionId,ncategoryId,cproduct,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryRemoveProduct xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryRemoveProduct>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryAttributeCurrentStore of Service WSMagentoService

WSMETHOD catalogCategoryAttributeCurrentStore WSSEND csessionId,cstoreView WSRECEIVE nstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryAttributeCurrentStore xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryAttributeCurrentStore>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nstoreView         :=  WSAdvValue( oXmlRet,"_STOREVIEW","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryAttributeList of Service WSMagentoService

WSMETHOD catalogCategoryAttributeList WSSEND csessionId WSRECEIVE oWScatalogCategoryAttributeListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryAttributeList xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryAttributeList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogCategoryAttributeListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAttributeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogCategoryAttributeOptions of Service WSMagentoService

WSMETHOD catalogCategoryAttributeOptions WSSEND csessionId,cattributeId,cstoreView WSRECEIVE oWScatalogCategoryAttributeOptionsresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogCategoryAttributeOptions xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeId", ::cattributeId, cattributeId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogCategoryAttributeOptions>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogCategoryAttributeOptionsresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAttributeOptionEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCurrentStore of Service WSMagentoService

WSMETHOD catalogProductCurrentStore WSSEND csessionId,cstoreView WSRECEIVE nstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCurrentStore xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCurrentStore>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nstoreView         :=  WSAdvValue( oXmlRet,"_STOREVIEW","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductList of Service WSMagentoService

WSMETHOD catalogProductList WSSEND csessionId,oWScatalogProductListfilters,cstoreView WSRECEIVE oWScatalogProductListstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("filters", ::oWScatalogProductListfilters, oWScatalogProductListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductListstoreView:SoapRecv( WSAdvValue( oXmlRet,"_STOREVIEW","catalogProductEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductInfo of Service WSMagentoService

WSMETHOD catalogProductInfo WSSEND csessionId,cproductId,cstoreView,oWScatalogProductInfoattributes,cidentifierType WSRECEIVE oWScatalogProductInfoinfo WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productId", ::cproductId, cproductId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributes", ::oWScatalogProductInfoattributes, oWScatalogProductInfoattributes , "catalogProductRequestAttributes", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductInfoinfo:SoapRecv( WSAdvValue( oXmlRet,"_INFO","catalogProductReturnEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCreate of Service WSMagentoService

WSMETHOD catalogProductCreate WSSEND csessionId,ctype,cset,csku,oWScatalogProductCreateproductData,cstoreView WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ctype , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("set", ::cset, cset , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sku", ::csku, csku , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productData", ::oWScatalogProductCreateproductData, oWScatalogProductCreateproductData , "catalogProductCreateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductUpdate of Service WSMagentoService

WSMETHOD catalogProductUpdate WSSEND csessionId,cproduct,oWScatalogProductUpdateproductData,cstoreView,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productData", ::oWScatalogProductUpdateproductData, oWScatalogProductUpdateproductData , "catalogProductCreateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductMultiUpdate of Service WSMagentoService

WSMETHOD catalogProductMultiUpdate WSSEND csessionId,oWScatalogProductMultiUpdateproductIds,oWScatalogProductMultiUpdateproductData,cstore,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductMultiUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productIds", ::oWScatalogProductMultiUpdateproductIds, oWScatalogProductMultiUpdateproductIds , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productData", ::oWScatalogProductMultiUpdateproductData, oWScatalogProductMultiUpdateproductData , "catalogProductCreateEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductMultiUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductSetSpecialPrice of Service WSMagentoService

WSMETHOD catalogProductSetSpecialPrice WSSEND csessionId,cproduct,cspecialPrice,cfromDate,ctoDate,cstoreView,cidentifierType WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductSetSpecialPrice xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("specialPrice", ::cspecialPrice, cspecialPrice , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("fromDate", ::cfromDate, cfromDate , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("toDate", ::ctoDate, ctoDate , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductSetSpecialPrice>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductGetSpecialPrice of Service WSMagentoService

WSMETHOD catalogProductGetSpecialPrice WSSEND csessionId,cproduct,cstoreView,cidentifierType WSRECEIVE oWScatalogProductGetSpecialPriceresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductGetSpecialPrice xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductGetSpecialPrice>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductGetSpecialPriceresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductSpecialPriceReturnEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductDelete of Service WSMagentoService

WSMETHOD catalogProductDelete WSSEND csessionId,cproduct,cidentifierType WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductDelete xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductDelete>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeCurrentStore of Service WSMagentoService

WSMETHOD catalogProductAttributeCurrentStore WSSEND csessionId,cstoreView WSRECEIVE nstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeCurrentStore xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeCurrentStore>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nstoreView         :=  WSAdvValue( oXmlRet,"_STOREVIEW","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductListOfAdditionalAttributes of Service WSMagentoService

WSMETHOD catalogProductListOfAdditionalAttributes WSSEND csessionId,cproductType,cattributeSetId WSRECEIVE oWScatalogProductListOfAdditionalAttributesresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductListOfAdditionalAttributes xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productType", ::cproductType, cproductType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSetId", ::cattributeSetId, cattributeSetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductListOfAdditionalAttributes>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductListOfAdditionalAttributesresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAttributeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeList of Service WSMagentoService

WSMETHOD catalogProductAttributeList WSSEND csessionId,nsetId WSRECEIVE oWScatalogProductAttributeListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("setId", ::nsetId, nsetId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAttributeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeOptions of Service WSMagentoService

WSMETHOD catalogProductAttributeOptions WSSEND csessionId,cattributeId,cstoreView WSRECEIVE oWScatalogProductAttributeOptionsresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeOptions xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeId", ::cattributeId, cattributeId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeOptions>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeOptionsresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAttributeOptionEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetCreate of Service WSMagentoService

WSMETHOD catalogProductAttributeSetCreate WSSEND csessionId,cattributeSetName,cskeletonSetId WSRECEIVE nsetId WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSetName", ::cattributeSetName, cattributeSetName , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("skeletonSetId", ::cskeletonSetId, cskeletonSetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nsetId             :=  WSAdvValue( oXmlRet,"_SETID","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetRemove of Service WSMagentoService

WSMETHOD catalogProductAttributeSetRemove WSSEND csessionId,cattributeSetId,cforceProductsRemove WSRECEIVE lisRemoved WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSetId", ::cattributeSetId, cattributeSetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("forceProductsRemove", ::cforceProductsRemove, cforceProductsRemove , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lisRemoved         :=  WSAdvValue( oXmlRet,"_ISREMOVED","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetList of Service WSMagentoService

WSMETHOD catalogProductAttributeSetList WSSEND csessionId WSRECEIVE oWScatalogProductAttributeSetListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetList xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeSetListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductAttributeSetEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetAttributeAdd of Service WSMagentoService

WSMETHOD catalogProductAttributeSetAttributeAdd WSSEND csessionId,cattributeId,cattributeSetId,cattributeGroupId,csortOrder WSRECEIVE lisAdded WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetAttributeAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeId", ::cattributeId, cattributeId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSetId", ::cattributeSetId, cattributeSetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeGroupId", ::cattributeGroupId, cattributeGroupId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sortOrder", ::csortOrder, csortOrder , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetAttributeAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lisAdded           :=  WSAdvValue( oXmlRet,"_ISADDED","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetAttributeRemove of Service WSMagentoService

WSMETHOD catalogProductAttributeSetAttributeRemove WSSEND csessionId,cattributeId,cattributeSetId WSRECEIVE lisRemoved WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetAttributeRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeId", ::cattributeId, cattributeId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSetId", ::cattributeSetId, cattributeSetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetAttributeRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lisRemoved         :=  WSAdvValue( oXmlRet,"_ISREMOVED","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetGroupAdd of Service WSMagentoService

WSMETHOD catalogProductAttributeSetGroupAdd WSSEND csessionId,cattributeSetId,cgroupName WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetGroupAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSetId", ::cattributeSetId, cattributeSetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("groupName", ::cgroupName, cgroupName , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetGroupAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetGroupRename of Service WSMagentoService

WSMETHOD catalogProductAttributeSetGroupRename WSSEND csessionId,cgroupId,cgroupName WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetGroupRename xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("groupId", ::cgroupId, cgroupId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("groupName", ::cgroupName, cgroupName , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetGroupRename>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeSetGroupRemove of Service WSMagentoService

WSMETHOD catalogProductAttributeSetGroupRemove WSSEND csessionId,cattributeGroupId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeSetGroupRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeGroupId", ::cattributeGroupId, cattributeGroupId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeSetGroupRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeTypes of Service WSMagentoService

WSMETHOD catalogProductAttributeTypes WSSEND csessionId WSRECEIVE oWScatalogProductAttributeTypesresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeTypes xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeTypes>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeTypesresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogAttributeOptionEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeCreate of Service WSMagentoService

WSMETHOD catalogProductAttributeCreate WSSEND csessionId,oWScatalogProductAttributeCreatedata WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductAttributeCreatedata, oWScatalogProductAttributeCreatedata , "catalogProductAttributeEntityToCreate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeRemove of Service WSMagentoService

WSMETHOD catalogProductAttributeRemove WSSEND csessionId,cattribute WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attribute", ::cattribute, cattribute , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeInfo of Service WSMagentoService

WSMETHOD catalogProductAttributeInfo WSSEND csessionId,cattribute WSRECEIVE oWScatalogProductAttributeInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attribute", ::cattribute, cattribute , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductAttributeEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeUpdate of Service WSMagentoService

WSMETHOD catalogProductAttributeUpdate WSSEND csessionId,cattribute,oWScatalogProductAttributeUpdatedata WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attribute", ::cattribute, cattribute , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductAttributeUpdatedata, oWScatalogProductAttributeUpdatedata , "catalogProductAttributeEntityToUpdate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeAddOption of Service WSMagentoService

WSMETHOD catalogProductAttributeAddOption WSSEND csessionId,cattribute,oWScatalogProductAttributeAddOptiondata WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeAddOption xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attribute", ::cattribute, cattribute , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductAttributeAddOptiondata, oWScatalogProductAttributeAddOptiondata , "catalogProductAttributeOptionEntityToAdd", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeAddOption>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeRemoveOption of Service WSMagentoService

WSMETHOD catalogProductAttributeRemoveOption WSSEND csessionId,cattribute,coptionId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeRemoveOption xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attribute", ::cattribute, cattribute , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("optionId", ::coptionId, coptionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeRemoveOption>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductTypeList of Service WSMagentoService

WSMETHOD catalogProductTypeList WSSEND csessionId WSRECEIVE oWScatalogProductTypeListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductTypeList xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductTypeList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductTypeListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductTypeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeTierPriceInfo of Service WSMagentoService

WSMETHOD catalogProductAttributeTierPriceInfo WSSEND csessionId,cproduct,cidentifierType WSRECEIVE oWScatalogProductAttributeTierPriceInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeTierPriceInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeTierPriceInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeTierPriceInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductTierPriceEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeTierPriceUpdate of Service WSMagentoService

WSMETHOD catalogProductAttributeTierPriceUpdate WSSEND csessionId,cproduct,oWScatalogProductAttributeTierPriceUpdatetier_price,cidentifierType WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeTierPriceUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("tier_price", ::oWScatalogProductAttributeTierPriceUpdatetier_price, oWScatalogProductAttributeTierPriceUpdatetier_price , "catalogProductTierPriceEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeTierPriceUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento )
	//_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaCurrentStore of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaCurrentStore WSSEND csessionId,cstoreView WSRECEIVE nstoreView WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaCurrentStore xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaCurrentStore>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::nstoreView         :=  WSAdvValue( oXmlRet,"_STOREVIEW","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaList of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaList WSSEND csessionId,cproduct,cstoreView,cidentifierType WSRECEIVE oWScatalogProductAttributeMediaListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeMediaListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductImageEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaInfo of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaInfo WSSEND csessionId,cproduct,cfile,cstoreView,cidentifierType WSRECEIVE oWScatalogProductAttributeMediaInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("file", ::cfile, cfile , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeMediaInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductImageEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaTypes of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaTypes WSSEND csessionId,csetId WSRECEIVE oWScatalogProductAttributeMediaTypesresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaTypes xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("setId", ::csetId, csetId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaTypes>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductAttributeMediaTypesresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductAttributeMediaTypeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaCreate of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaCreate WSSEND csessionId,cproduct,oWScatalogProductAttributeMediaCreatedata,cstoreView,cidentifierType WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductAttributeMediaCreatedata, oWScatalogProductAttributeMediaCreatedata , "catalogProductAttributeMediaCreateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaUpdate of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaUpdate WSSEND csessionId,cproduct,cfile,oWScatalogProductAttributeMediaUpdatedata,cstoreView,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("file", ::cfile, cfile , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductAttributeMediaUpdatedata, oWScatalogProductAttributeMediaUpdatedata , "catalogProductAttributeMediaCreateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeView", ::cstoreView, cstoreView , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductAttributeMediaRemove of Service WSMagentoService

WSMETHOD catalogProductAttributeMediaRemove WSSEND csessionId,cproduct,cfile,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductAttributeMediaRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("file", ::cfile, cfile , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductAttributeMediaRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductLinkList of Service WSMagentoService

WSMETHOD catalogProductLinkList WSSEND csessionId,ctype,cproduct,cidentifierType WSRECEIVE oWScatalogProductLinkListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductLinkList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ctype , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductLinkList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductLinkListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductLinkEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductLinkAssign of Service WSMagentoService

WSMETHOD catalogProductLinkAssign WSSEND csessionId,ctype,cproduct,clinkedProduct,oWScatalogProductLinkAssigndata,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductLinkAssign xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ctype , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("linkedProduct", ::clinkedProduct, clinkedProduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductLinkAssigndata, oWScatalogProductLinkAssigndata , "catalogProductLinkEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductLinkAssign>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductLinkUpdate of Service WSMagentoService

WSMETHOD catalogProductLinkUpdate WSSEND csessionId,ctype,cproduct,clinkedProduct,oWScatalogProductLinkUpdatedata,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductLinkUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ctype , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("linkedProduct", ::clinkedProduct, clinkedProduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductLinkUpdatedata, oWScatalogProductLinkUpdatedata , "catalogProductLinkEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductLinkUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductLinkRemove of Service WSMagentoService

WSMETHOD catalogProductLinkRemove WSSEND csessionId,ctype,cproduct,clinkedProduct,cidentifierType WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductLinkRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ctype , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("linkedProduct", ::clinkedProduct, clinkedProduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductLinkRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductLinkTypes of Service WSMagentoService

WSMETHOD catalogProductLinkTypes WSSEND csessionId WSRECEIVE oWScatalogProductLinkTypesresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductLinkTypes xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductLinkTypes>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductLinkTypesresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductLinkAttributes of Service WSMagentoService

WSMETHOD catalogProductLinkAttributes WSSEND csessionId,ctype WSRECEIVE oWScatalogProductLinkAttributesresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductLinkAttributes xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ctype , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductLinkAttributes>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductLinkAttributesresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductLinkAttributeEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionAdd of Service WSMagentoService

WSMETHOD catalogProductCustomOptionAdd WSSEND csessionId,cproductId,oWScatalogProductCustomOptionAdddata,cstore WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productId", ::cproductId, cproductId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductCustomOptionAdddata, oWScatalogProductCustomOptionAdddata , "catalogProductCustomOptionToAdd", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionUpdate of Service WSMagentoService

WSMETHOD catalogProductCustomOptionUpdate WSSEND csessionId,coptionId,oWScatalogProductCustomOptionUpdatedata,cstore WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("optionId", ::coptionId, coptionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductCustomOptionUpdatedata, oWScatalogProductCustomOptionUpdatedata , "catalogProductCustomOptionToUpdate", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionTypes of Service WSMagentoService

WSMETHOD catalogProductCustomOptionTypes WSSEND csessionId WSRECEIVE oWScatalogProductCustomOptionTypesresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionTypes xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionTypes>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductCustomOptionTypesresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductCustomOptionTypesArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionInfo of Service WSMagentoService

WSMETHOD catalogProductCustomOptionInfo WSSEND csessionId,coptionId,cstore WSRECEIVE oWScatalogProductCustomOptionInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("optionId", ::coptionId, coptionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductCustomOptionInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductCustomOptionInfoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionList of Service WSMagentoService

WSMETHOD catalogProductCustomOptionList WSSEND csessionId,cproductId,cstore WSRECEIVE oWScatalogProductCustomOptionListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productId", ::cproductId, cproductId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductCustomOptionListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductCustomOptionListArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionRemove of Service WSMagentoService

WSMETHOD catalogProductCustomOptionRemove WSSEND csessionId,coptionId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("optionId", ::coptionId, coptionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionValueInfo of Service WSMagentoService

WSMETHOD catalogProductCustomOptionValueInfo WSSEND csessionId,cvalueId,cstore WSRECEIVE oWScatalogProductCustomOptionValueInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionValueInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("valueId", ::cvalueId, cvalueId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionValueInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductCustomOptionValueInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductCustomOptionValueInfoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionValueList of Service WSMagentoService

WSMETHOD catalogProductCustomOptionValueList WSSEND csessionId,coptionId,cstore WSRECEIVE oWScatalogProductCustomOptionValueListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionValueList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("optionId", ::coptionId, coptionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionValueList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductCustomOptionValueListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductCustomOptionValueListArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionValueAdd of Service WSMagentoService

WSMETHOD catalogProductCustomOptionValueAdd WSSEND csessionId,coptionId,oWScatalogProductCustomOptionValueAdddata,cstore WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionValueAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("optionId", ::coptionId, coptionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductCustomOptionValueAdddata, oWScatalogProductCustomOptionValueAdddata , "catalogProductCustomOptionValueAddArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionValueAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionValueUpdate of Service WSMagentoService

WSMETHOD catalogProductCustomOptionValueUpdate WSSEND csessionId,cvalueId,oWScatalogProductCustomOptionValueUpdatedata,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionValueUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("valueId", ::cvalueId, cvalueId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductCustomOptionValueUpdatedata, oWScatalogProductCustomOptionValueUpdatedata , "catalogProductCustomOptionValueUpdateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionValueUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductCustomOptionValueRemove of Service WSMagentoService

WSMETHOD catalogProductCustomOptionValueRemove WSSEND csessionId,cvalueId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductCustomOptionValueRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("valueId", ::cvalueId, cvalueId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductCustomOptionValueRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderList of Service WSMagentoService

WSMETHOD salesOrderList WSSEND csessionId,oWSsalesOrderListfilters WSRECEIVE oWSsalesOrderListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("filters", ::oWSsalesOrderListfilters, oWSsalesOrderListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderListEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInfo of Service WSMagentoService

WSMETHOD salesOrderInfo WSSEND csessionId,corderIncrementId WSRECEIVE oWSsalesOrderInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderAddComment of Service WSMagentoService

WSMETHOD salesOrderAddComment WSSEND csessionId,corderIncrementId,cstatus,ccomment,cnotify WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderAddComment xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("status", ::cstatus, cstatus , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("notify", ::cnotify, cnotify , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderAddComment>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderHold of Service WSMagentoService

WSMETHOD salesOrderHold WSSEND csessionId,corderIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderHold xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderHold>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderUnhold of Service WSMagentoService

WSMETHOD salesOrderUnhold WSSEND csessionId,corderIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderUnhold xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderUnhold>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderCancel of Service WSMagentoService

WSMETHOD salesOrderCancel WSSEND csessionId,corderIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderCancel xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderCancel>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentList of Service WSMagentoService

WSMETHOD salesOrderShipmentList WSSEND csessionId,oWSsalesOrderShipmentListfilters WSRECEIVE oWSsalesOrderShipmentListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("filters", ::oWSsalesOrderShipmentListfilters, oWSsalesOrderShipmentListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderShipmentListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderShipmentEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentInfo of Service WSMagentoService

WSMETHOD salesOrderShipmentInfo WSSEND csessionId,cshipmentIncrementId WSRECEIVE oWSsalesOrderShipmentInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipmentIncrementId", ::cshipmentIncrementId, cshipmentIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderShipmentInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderShipmentEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentCreate of Service WSMagentoService

WSMETHOD salesOrderShipmentCreate WSSEND csessionId,corderIncrementId,oWSsalesOrderShipmentCreateitemsQty,ccomment,nemail,nincludeComment WSRECEIVE cshipmentIncrementId WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("itemsQty", ::oWSsalesOrderShipmentCreateitemsQty, oWSsalesOrderShipmentCreateitemsQty , "orderItemIdQtyArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("email", ::nemail, nemail , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("includeComment", ::nincludeComment, nincludeComment , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cshipmentIncrementId :=  WSAdvValue( oXmlRet,"_SHIPMENTINCREMENTID","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentAddComment of Service WSMagentoService

WSMETHOD salesOrderShipmentAddComment WSSEND csessionId,cshipmentIncrementId,ccomment,cemail,cincludeInEmail WSRECEIVE lshipmentIncrementId WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentAddComment xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipmentIncrementId", ::cshipmentIncrementId, cshipmentIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("email", ::cemail, cemail , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("includeInEmail", ::cincludeInEmail, cincludeInEmail , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentAddComment>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lshipmentIncrementId :=  WSAdvValue( oXmlRet,"_SHIPMENTINCREMENTID","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentAddTrack of Service WSMagentoService

WSMETHOD salesOrderShipmentAddTrack WSSEND csessionId,cshipmentIncrementId,ccarrier,ctitle,ctrackNumber WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentAddTrack xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipmentIncrementId", ::cshipmentIncrementId, cshipmentIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("carrier", ::ccarrier, ccarrier , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("title", ::ctitle, ctitle , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("trackNumber", ::ctrackNumber, ctrackNumber , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentAddTrack>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentSendInfo of Service WSMagentoService

WSMETHOD salesOrderShipmentSendInfo WSSEND csessionId,cshipmentIncrementId,ccomment WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentSendInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipmentIncrementId", ::cshipmentIncrementId, cshipmentIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentSendInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentRemoveTrack of Service WSMagentoService

WSMETHOD salesOrderShipmentRemoveTrack WSSEND csessionId,cshipmentIncrementId,ctrackId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentRemoveTrack xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipmentIncrementId", ::cshipmentIncrementId, cshipmentIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("trackId", ::ctrackId, ctrackId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentRemoveTrack>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderShipmentGetCarriers of Service WSMagentoService

WSMETHOD salesOrderShipmentGetCarriers WSSEND csessionId,corderIncrementId WSRECEIVE oWSsalesOrderShipmentGetCarriersresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderShipmentGetCarriers xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderShipmentGetCarriers>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderShipmentGetCarriersresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","associativeArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceList of Service WSMagentoService

WSMETHOD salesOrderInvoiceList WSSEND csessionId,oWSsalesOrderInvoiceListfilters WSRECEIVE oWSsalesOrderInvoiceListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("filters", ::oWSsalesOrderInvoiceListfilters, oWSsalesOrderInvoiceListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderInvoiceListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderInvoiceEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceInfo of Service WSMagentoService

WSMETHOD salesOrderInvoiceInfo WSSEND csessionId,cinvoiceIncrementId WSRECEIVE oWSsalesOrderInvoiceInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("invoiceIncrementId", ::cinvoiceIncrementId, cinvoiceIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderInvoiceInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderInvoiceEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceCreate of Service WSMagentoService

WSMETHOD salesOrderInvoiceCreate WSSEND csessionId,cinvoiceIncrementId,oWSsalesOrderInvoiceCreateitemsQty,ccomment,cemail,cincludeComment WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("invoiceIncrementId", ::cinvoiceIncrementId, cinvoiceIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("itemsQty", ::oWSsalesOrderInvoiceCreateitemsQty, oWSsalesOrderInvoiceCreateitemsQty , "orderItemIdQtyArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("email", ::cemail, cemail , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("includeComment", ::cincludeComment, cincludeComment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceAddComment of Service WSMagentoService

WSMETHOD salesOrderInvoiceAddComment WSSEND csessionId,cinvoiceIncrementId,ccomment,cemail,cincludeComment WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceAddComment xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("invoiceIncrementId", ::cinvoiceIncrementId, cinvoiceIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("email", ::cemail, cemail , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("includeComment", ::cincludeComment, cincludeComment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceAddComment>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceCapture of Service WSMagentoService

WSMETHOD salesOrderInvoiceCapture WSSEND csessionId,cinvoiceIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceCapture xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("invoiceIncrementId", ::cinvoiceIncrementId, cinvoiceIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceCapture>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceVoid of Service WSMagentoService

WSMETHOD salesOrderInvoiceVoid WSSEND csessionId,cinvoiceIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceVoid xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("invoiceIncrementId", ::cinvoiceIncrementId, cinvoiceIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceVoid>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderInvoiceCancel of Service WSMagentoService

WSMETHOD salesOrderInvoiceCancel WSSEND csessionId,cinvoiceIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderInvoiceCancel xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("invoiceIncrementId", ::cinvoiceIncrementId, cinvoiceIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderInvoiceCancel>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderCreditmemoList of Service WSMagentoService

WSMETHOD salesOrderCreditmemoList WSSEND csessionId,oWSsalesOrderCreditmemoListfilters WSRECEIVE oWSsalesOrderCreditmemoListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderCreditmemoList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("filters", ::oWSsalesOrderCreditmemoListfilters, oWSsalesOrderCreditmemoListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderCreditmemoList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderCreditmemoListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderCreditmemoEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderCreditmemoInfo of Service WSMagentoService

WSMETHOD salesOrderCreditmemoInfo WSSEND csessionId,ccreditmemoIncrementId WSRECEIVE oWSsalesOrderCreditmemoInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderCreditmemoInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("creditmemoIncrementId", ::ccreditmemoIncrementId, ccreditmemoIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderCreditmemoInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSsalesOrderCreditmemoInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","salesOrderCreditmemoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderCreditmemoCreate of Service WSMagentoService

WSMETHOD salesOrderCreditmemoCreate WSSEND csessionId,corderIncrementId,oWSsalesOrderCreditmemoCreatecreditmemoData,ccomment,nnotifyCustomer,nincludeComment,crefundToStoreCreditAmount WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderCreditmemoCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("creditmemoData", ::oWSsalesOrderCreditmemoCreatecreditmemoData, oWSsalesOrderCreditmemoCreatecreditmemoData , "salesOrderCreditmemoData", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("notifyCustomer", ::nnotifyCustomer, nnotifyCustomer , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("includeComment", ::nincludeComment, nincludeComment , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("refundToStoreCreditAmount", ::crefundToStoreCreditAmount, crefundToStoreCreditAmount , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderCreditmemoCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderCreditmemoAddComment of Service WSMagentoService

WSMETHOD salesOrderCreditmemoAddComment WSSEND csessionId,ccreditmemoIncrementId,ccomment,nnotifyCustomer,nincludeComment WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderCreditmemoAddComment xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("creditmemoIncrementId", ::ccreditmemoIncrementId, ccreditmemoIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("comment", ::ccomment, ccomment , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("notifyCustomer", ::nnotifyCustomer, nnotifyCustomer , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("includeComment", ::nincludeComment, nincludeComment , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderCreditmemoAddComment>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method salesOrderCreditmemoCancel of Service WSMagentoService

WSMETHOD salesOrderCreditmemoCancel WSSEND csessionId,ccreditmemoIncrementId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:salesOrderCreditmemoCancel xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("creditmemoIncrementId", ::ccreditmemoIncrementId, ccreditmemoIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:salesOrderCreditmemoCancel>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogInventoryStockItemList of Service WSMagentoService

WSMETHOD catalogInventoryStockItemList WSSEND csessionId,oWScatalogInventoryStockItemListproducts WSRECEIVE oWScatalogInventoryStockItemListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogInventoryStockItemList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("products", ::oWScatalogInventoryStockItemListproducts, oWScatalogInventoryStockItemListproducts , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogInventoryStockItemList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogInventoryStockItemListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogInventoryStockItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogInventoryStockItemUpdate of Service WSMagentoService

WSMETHOD catalogInventoryStockItemUpdate WSSEND csessionId,cproduct,oWScatalogInventoryStockItemUpdatedata WSRECEIVE nresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogInventoryStockItemUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product", ::cproduct, cproduct , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogInventoryStockItemUpdatedata, oWScatalogInventoryStockItemUpdatedata , "catalogInventoryStockItemUpdateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogInventoryStockItemUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::nresult            :=  WSAdvValue( oXmlRet,"_RESULT","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogInventoryStockItemMultiUpdate of Service WSMagentoService

WSMETHOD catalogInventoryStockItemMultiUpdate WSSEND csessionId,oWScatalogInventoryStockItemMultiUpdateproductIds,oWScatalogInventoryStockItemMultiUpdateproductData WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogInventoryStockItemMultiUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productIds", ::oWScatalogInventoryStockItemMultiUpdateproductIds, oWScatalogInventoryStockItemMultiUpdateproductIds , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productData", ::oWScatalogInventoryStockItemMultiUpdateproductData, oWScatalogInventoryStockItemMultiUpdateproductData , "catalogInventoryStockItemUpdateEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogInventoryStockItemMultiUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartCreate of Service WSMagentoService

WSMETHOD shoppingCartCreate WSSEND csessionId,cstoreId WSRECEIVE nquoteId WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::nquoteId           :=  WSAdvValue( oXmlRet,"_QUOTEID","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartInfo of Service WSMagentoService

WSMETHOD shoppingCartInfo WSSEND csessionId,nquoteId,cstoreId WSRECEIVE oWSshoppingCartInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSshoppingCartInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","shoppingCartInfoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartOrder of Service WSMagentoService

WSMETHOD shoppingCartOrder WSSEND csessionId,nquoteId,cstoreId,oWSshoppingCartOrderlicenses WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartOrder xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("licenses", ::oWSshoppingCartOrderlicenses, oWSshoppingCartOrderlicenses , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartOrder>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartTotals of Service WSMagentoService

WSMETHOD shoppingCartTotals WSSEND csessionId,nquoteId,cstoreId WSRECEIVE oWSshoppingCartTotalsresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartTotals xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartTotals>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSshoppingCartTotalsresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","shoppingCartTotalsEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartLicense of Service WSMagentoService

WSMETHOD shoppingCartLicense WSSEND csessionId,nquoteId,cstoreId WSRECEIVE oWSshoppingCartLicenseresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartLicense xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartLicense>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSshoppingCartLicenseresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","shoppingCartLicenseEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartProductAdd of Service WSMagentoService

WSMETHOD shoppingCartProductAdd WSSEND csessionId,nquoteId,oWSshoppingCartProductAddproducts,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartProductAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("products", ::oWSshoppingCartProductAddproducts, oWSshoppingCartProductAddproducts , "shoppingCartProductEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartProductAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartProductUpdate of Service WSMagentoService

WSMETHOD shoppingCartProductUpdate WSSEND csessionId,nquoteId,oWSshoppingCartProductUpdateproducts,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartProductUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("products", ::oWSshoppingCartProductUpdateproducts, oWSshoppingCartProductUpdateproducts , "shoppingCartProductEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartProductUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartProductRemove of Service WSMagentoService

WSMETHOD shoppingCartProductRemove WSSEND csessionId,nquoteId,oWSshoppingCartProductRemoveproducts,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartProductRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("products", ::oWSshoppingCartProductRemoveproducts, oWSshoppingCartProductRemoveproducts , "shoppingCartProductEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartProductRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartProductList of Service WSMagentoService

WSMETHOD shoppingCartProductList WSSEND csessionId,nquoteId,cstoreId WSRECEIVE oWSshoppingCartProductListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartProductList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartProductList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSshoppingCartProductListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","shoppingCartProductResponseEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartProductMoveToCustomerQuote of Service WSMagentoService

WSMETHOD shoppingCartProductMoveToCustomerQuote WSSEND csessionId,nquoteId,oWSshoppingCartProductMoveToCustomerQuoteproducts,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartProductMoveToCustomerQuote xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("products", ::oWSshoppingCartProductMoveToCustomerQuoteproducts, oWSshoppingCartProductMoveToCustomerQuoteproducts , "shoppingCartProductEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartProductMoveToCustomerQuote>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartCustomerSet of Service WSMagentoService

WSMETHOD shoppingCartCustomerSet WSSEND csessionId,nquoteId,oWSshoppingCartCustomerSetcustomer,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartCustomerSet xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer", ::oWSshoppingCartCustomerSetcustomer, oWSshoppingCartCustomerSetcustomer , "shoppingCartCustomerEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartCustomerSet>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartCustomerAddresses of Service WSMagentoService

WSMETHOD shoppingCartCustomerAddresses WSSEND csessionId,nquoteId,oWSshoppingCartCustomerAddressescustomer,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartCustomerAddresses xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer", ::oWSshoppingCartCustomerAddressescustomer, oWSshoppingCartCustomerAddressescustomer , "shoppingCartCustomerAddressEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartCustomerAddresses>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartShippingMethod of Service WSMagentoService

WSMETHOD shoppingCartShippingMethod WSSEND csessionId,nquoteId,cmethod,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartShippingMethod xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("method", ::cmethod, cmethod , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartShippingMethod>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartShippingList of Service WSMagentoService

WSMETHOD shoppingCartShippingList WSSEND csessionId,nquoteId,cstoreId WSRECEIVE oWSshoppingCartShippingListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartShippingList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartShippingList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSshoppingCartShippingListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","shoppingCartShippingMethodEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartPaymentMethod of Service WSMagentoService

WSMETHOD shoppingCartPaymentMethod WSSEND csessionId,nquoteId,oWSshoppingCartPaymentMethodmethod,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartPaymentMethod xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("method", ::oWSshoppingCartPaymentMethodmethod, oWSshoppingCartPaymentMethodmethod , "shoppingCartPaymentMethodEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartPaymentMethod>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartPaymentList of Service WSMagentoService

WSMETHOD shoppingCartPaymentList WSSEND csessionId,nquoteId,cstore WSRECEIVE oWSshoppingCartPaymentListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartPaymentList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartPaymentList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSshoppingCartPaymentListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","shoppingCartPaymentMethodResponseEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartCouponAdd of Service WSMagentoService

WSMETHOD shoppingCartCouponAdd WSSEND csessionId,nquoteId,ccouponCode,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartCouponAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("couponCode", ::ccouponCode, ccouponCode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartCouponAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method shoppingCartCouponRemove of Service WSMagentoService

WSMETHOD shoppingCartCouponRemove WSSEND csessionId,nquoteId,cstoreId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:shoppingCartCouponRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::nquoteId, nquoteId , "int", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:shoppingCartCouponRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductTagList of Service WSMagentoService

WSMETHOD catalogProductTagList WSSEND csessionId,cproductId,cstore WSRECEIVE oWScatalogProductTagListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductTagList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productId", ::cproductId, cproductId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductTagList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductTagListresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductTagListEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductTagInfo of Service WSMagentoService

WSMETHOD catalogProductTagInfo WSSEND csessionId,ctagId,cstore WSRECEIVE oWScatalogProductTagInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductTagInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("tagId", ::ctagId, ctagId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductTagInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductTagInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","catalogProductTagInfoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductTagAdd of Service WSMagentoService

WSMETHOD catalogProductTagAdd WSSEND csessionId,oWScatalogProductTagAdddata WSRECEIVE oWScatalogProductTagAddresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductTagAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductTagAdddata, oWScatalogProductTagAdddata , "catalogProductTagAddEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductTagAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductTagAddresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","associativeArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductTagUpdate of Service WSMagentoService

WSMETHOD catalogProductTagUpdate WSSEND csessionId,ctagId,oWScatalogProductTagUpdatedata,cstore WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductTagUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("tagId", ::ctagId, ctagId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("data", ::oWScatalogProductTagUpdatedata, oWScatalogProductTagUpdatedata , "catalogProductTagUpdateEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductTagUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductTagRemove of Service WSMagentoService

WSMETHOD catalogProductTagRemove WSSEND csessionId,ctagId WSRECEIVE lresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductTagRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("tagId", ::ctagId, ctagId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductTagRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lresult            :=  WSAdvValue( oXmlRet,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method giftMessageSetForQuote of Service WSMagentoService

WSMETHOD giftMessageSetForQuote WSSEND csessionId,cquoteId,oWSgiftMessageSetForQuotegiftMessage,cstoreId WSRECEIVE oWSgiftMessageSetForQuoteresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:giftMessageSetForQuote xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::cquoteId, cquoteId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("giftMessage", ::oWSgiftMessageSetForQuotegiftMessage, oWSgiftMessageSetForQuotegiftMessage , "giftMessageEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:giftMessageSetForQuote>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSgiftMessageSetForQuoteresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","giftMessageResponse",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method giftMessageSetForQuoteItem of Service WSMagentoService

WSMETHOD giftMessageSetForQuoteItem WSSEND csessionId,cquoteItemId,oWSgiftMessageSetForQuoteItemgiftMessage,cstoreId WSRECEIVE oWSgiftMessageSetForQuoteItemresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:giftMessageSetForQuoteItem xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteItemId", ::cquoteItemId, cquoteItemId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("giftMessage", ::oWSgiftMessageSetForQuoteItemgiftMessage, oWSgiftMessageSetForQuoteItemgiftMessage , "giftMessageEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:giftMessageSetForQuoteItem>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSgiftMessageSetForQuoteItemresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","giftMessageResponse",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method giftMessageSetForQuoteProduct of Service WSMagentoService

WSMETHOD giftMessageSetForQuoteProduct WSSEND csessionId,cquoteId,oWSgiftMessageSetForQuoteProductproductsAndMessages,cstoreId WSRECEIVE oWSgiftMessageSetForQuoteProductresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:giftMessageSetForQuoteProduct xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("quoteId", ::cquoteId, cquoteId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productsAndMessages", ::oWSgiftMessageSetForQuoteProductproductsAndMessages, oWSgiftMessageSetForQuoteProductproductsAndMessages , "giftMessageAssociativeProductsEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeId", ::cstoreId, cstoreId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:giftMessageSetForQuoteProduct>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSgiftMessageSetForQuoteProductresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","giftMessageResponseArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductDownloadableLinkAdd of Service WSMagentoService

WSMETHOD catalogProductDownloadableLinkAdd WSSEND csessionId,cproductId,oWScatalogProductDownloadableLinkAddresource,cresourceType,cstore,cidentifierType WSRECEIVE nrespons WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductDownloadableLinkAdd xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productId", ::cproductId, cproductId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("resource", ::oWScatalogProductDownloadableLinkAddresource, oWScatalogProductDownloadableLinkAddresource , "catalogProductDownloadableLinkAddEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("resourceType", ::cresourceType, cresourceType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductDownloadableLinkAdd>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::nrespons           :=  WSAdvValue( oXmlRet,"_RESPONS","int",NIL,NIL,NIL,"N",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductDownloadableLinkList of Service WSMagentoService

WSMETHOD catalogProductDownloadableLinkList WSSEND csessionId,cproductId,cstore,cidentifierType WSRECEIVE oWScatalogProductDownloadableLinkListrespons WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductDownloadableLinkList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("productId", ::cproductId, cproductId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, cstore , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("identifierType", ::cidentifierType, cidentifierType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductDownloadableLinkList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWScatalogProductDownloadableLinkListrespons:SoapRecv( WSAdvValue( oXmlRet,"_RESPONS","catalogProductDownloadableLinkInfoEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method catalogProductDownloadableLinkRemove of Service WSMagentoService

WSMETHOD catalogProductDownloadableLinkRemove WSSEND csessionId,clinkId,cresourceType WSRECEIVE lrespons WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:catalogProductDownloadableLinkRemove xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("linkId", ::clinkId, clinkId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("resourceType", ::cresourceType, cresourceType , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:catalogProductDownloadableLinkRemove>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::lrespons           :=  WSAdvValue( oXmlRet,"_RESPONS","boolean",NIL,NIL,NIL,"L",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method plpList of Service WSMagentoService

WSMETHOD plpList WSSEND csessionId,dfromDate,dtoDate WSRECEIVE oWSplpListplps WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:plpList xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("fromDate", ::dfromDate, dfromDate , "date", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("toDate", ::dtoDate, dtoDate , "date", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:plpList>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		"https://www.qualitebrasil.com.br/index.php/api/v2_soap/")

	::Init()
	::oWSplpListplps:SoapRecv( WSAdvValue( oXmlRet,"_PLPS","plpArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderListShipments of Service WSMagentoService

WSMETHOD integratorOrderListShipments WSSEND csessionId,oWSintegratorOrderListShipmentssalesOrderShipmentListfilters WSRECEIVE oWSintegratorOrderListShipmentssalesOrderShipmentListresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderListShipments xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("salesOrderShipmentListfilters", ::oWSintegratorOrderListShipmentssalesOrderShipmentListfilters, oWSintegratorOrderListShipmentssalesOrderShipmentListfilters , "filters", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderListShipments>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderListShipmentssalesOrderShipmentListresult:SoapRecv( WSAdvValue( oXmlRet,"_SALESORDERSHIPMENTLISTRESULT","salesOrderShipmentEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderEstimateShipping of Service WSMagentoService

WSMETHOD integratorOrderEstimateShipping WSSEND csessionId,cpostcode,oWSintegratorOrderEstimateShippingitems WSRECEIVE oWSintegratorOrderEstimateShippingrates WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderEstimateShipping xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("postcode", ::cpostcode, cpostcode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("items", ::oWSintegratorOrderEstimateShippingitems, oWSintegratorOrderEstimateShippingitems , "integratorEstimateShippingItemEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderEstimateShipping>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderEstimateShippingrates:SoapRecv( WSAdvValue( oXmlRet,"_RATES","integratorEstimateShippingResponseItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderEstimateShippingPerItem of Service WSMagentoService

WSMETHOD integratorOrderEstimateShippingPerItem WSSEND csessionId,cpostcode,oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems WSRECEIVE oWSintegratorOrderEstimateShippingPerItemrates WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderEstimateShippingPerItem xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("postcode", ::cpostcode, cpostcode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("integratorOrderEstimateShippingitems", ::oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems, oWSintegratorOrderEstimateShippingPerItemintegratorOrderEstimateShippingitems , "integratorEstimateShippingItemEntityArray", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderEstimateShippingPerItem>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderEstimateShippingPerItemrates:SoapRecv( WSAdvValue( oXmlRet,"_RATES","integratorEstimateShippingPerItemResponseItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderInfo of Service WSMagentoService

WSMETHOD integratorOrderInfo WSSEND csessionId,corderIncrementId WSRECEIVE oWSintegratorOrderInforesult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderInfo xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("orderIncrementId", ::corderIncrementId, corderIncrementId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderInfo>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderInforesult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","integratorOrderEntity",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderInvoice of Service WSMagentoService

WSMETHOD integratorOrderInvoice WSSEND csessionId,cskyhubCode,cstatus WSRECEIVE oWSintegratorOrderInvoiceerrors WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderInvoice xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("skyhubCode", ::cskyhubCode, cskyhubCode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("status", ::cstatus, cstatus , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderInvoice>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderInvoiceerrors:SoapRecv( WSAdvValue( oXmlRet,"_ERRORS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderCreate of Service WSMagentoService

WSMETHOD integratorOrderCreate WSSEND csessionId,cstoreCode,oWSintegratorOrderCreateorder WSRECEIVE oWSintegratorOrderCreateerrors WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderCreate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeCode", ::cstoreCode, cstoreCode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("order", ::oWSintegratorOrderCreateorder, oWSintegratorOrderCreateorder , "integratorCreateOrderEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderCreate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderCreateerrors:SoapRecv( WSAdvValue( oXmlRet,"_ERRORS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderUpdate of Service WSMagentoService

WSMETHOD integratorOrderUpdate WSSEND csessionId,oWSintegratorOrderUpdateorder WSRECEIVE oWSintegratorOrderUpdateerrors WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderUpdate xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("order", ::oWSintegratorOrderUpdateorder, oWSintegratorOrderUpdateorder , "integratorUpdateOrderEntity", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderUpdate>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderUpdateerrors:SoapRecv( WSAdvValue( oXmlRet,"_ERRORS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderListStatus of Service WSMagentoService

WSMETHOD integratorOrderListStatus WSSEND csessionId WSRECEIVE oWSintegratorOrderListStatusresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderListStatus xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderListStatus>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderListStatusresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","integratorListStatusEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderPaymentMethods of Service WSMagentoService

WSMETHOD integratorOrderPaymentMethods WSSEND csessionId WSRECEIVE oWSintegratorOrderPaymentMethodspaymentMethods WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderPaymentMethods xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderPaymentMethods>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderPaymentMethodspaymentMethods:SoapRecv( WSAdvValue( oXmlRet,"_PAYMENTMETHODS","associativeArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorOrderShippingMethods of Service WSMagentoService

WSMETHOD integratorOrderShippingMethods WSSEND csessionId WSRECEIVE oWSintegratorOrderShippingMethodsshippingMethods WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorOrderShippingMethods xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorOrderShippingMethods>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorOrderShippingMethodsshippingMethods:SoapRecv( WSAdvValue( oXmlRet,"_SHIPPINGMETHODS","associativeArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductListCreated of Service WSMagentoService

WSMETHOD integratorProductListCreated WSSEND csessionId,ccurPage,cpageSize WSRECEIVE oWSintegratorProductListCreatedresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductListCreated xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("curPage", ::ccurPage, ccurPage , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("pageSize", ::cpageSize, cpageSize , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductListCreated>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductListCreatedresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","integratorProductReturnEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductItems of Service WSMagentoService

WSMETHOD integratorProductItems WSSEND csessionId,cstoreCode,cupdatedFrom,cattributeSet WSRECEIVE oWSintegratorProductItemsresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductItems xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeCode", ::cstoreCode, cstoreCode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("updatedFrom", ::cupdatedFrom, cupdatedFrom , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSet", ::cattributeSet, cattributeSet , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductItems>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductItemsresult:SoapRecv( WSAdvValue( oXmlRet,"_RESULT","integratorProductReturnEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductItemsPaged of Service WSMagentoService

WSMETHOD integratorProductItemsPaged WSSEND csessionId,cstoreCode,ccurPage,cpageSize,cupdatedFrom,cattributeSet,cgetVariationPrices WSRECEIVE oWSintegratorProductItemsPagedintegratorProductItemsresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductItemsPaged xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("storeCode", ::cstoreCode, cstoreCode , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("curPage", ::ccurPage, ccurPage , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("pageSize", ::cpageSize, cpageSize , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("updatedFrom", ::cupdatedFrom, cupdatedFrom , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("attributeSet", ::cattributeSet, cattributeSet , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("getVariationPrices", ::cgetVariationPrices, cgetVariationPrices , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductItemsPaged>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductItemsPagedintegratorProductItemsresult:SoapRecv( WSAdvValue( oXmlRet,"_INTEGRATORPRODUCTITEMSRESULT","integratorProductReturnEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductUrls of Service WSMagentoService

WSMETHOD integratorProductUrls WSSEND csessionId,oWSintegratorProductUrlsskus WSRECEIVE oWSintegratorProductUrlsurls WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductUrls xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("skus", ::oWSintegratorProductUrlsskus, oWSintegratorProductUrlsskus , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductUrls>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductUrlsurls:SoapRecv( WSAdvValue( oXmlRet,"_URLS","associativeArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductListUpdated of Service WSMagentoService

WSMETHOD integratorProductListUpdated WSSEND csessionId,ccurPage,cpageSize WSRECEIVE oWSintegratorProductListUpdatedintegratorProductListCreatedresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductListUpdated xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("curPage", ::ccurPage, ccurPage , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("pageSize", ::cpageSize, cpageSize , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductListUpdated>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductListUpdatedintegratorProductListCreatedresult:SoapRecv( WSAdvValue( oXmlRet,"_INTEGRATORPRODUCTLISTCREATEDRESULT","integratorProductReturnEntityArray",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductListDeleted of Service WSMagentoService

WSMETHOD integratorProductListDeleted WSSEND csessionId,ccurPage,cpageSize WSRECEIVE oWSintegratorProductListDeleteddeletedSkus WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductListDeleted xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("curPage", ::ccurPage, ccurPage , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("pageSize", ::cpageSize, cpageSize , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductListDeleted>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductListDeleteddeletedSkus:SoapRecv( WSAdvValue( oXmlRet,"_DELETEDSKUS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductImportCsv of Service WSMagentoService

WSMETHOD integratorProductImportCsv WSSEND csessionId,ccsv,lshouldIndex WSRECEIVE oWSintegratorProductImportCsverrors WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductImportCsv xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("csv", ::ccsv, ccsv , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shouldIndex", ::lshouldIndex, lshouldIndex , "boolean", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductImportCsv>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::oWSintegratorProductImportCsverrors:SoapRecv( WSAdvValue( oXmlRet,"_ERRORS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL) )

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductListCreatedCount of Service WSMagentoService

WSMETHOD integratorProductListCreatedCount WSSEND csessionId WSRECEIVE ccount WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductListCreatedCount xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductListCreatedCount>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::ccount             :=  WSAdvValue( oXmlRet,"_COUNT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductListUpdatedCount of Service WSMagentoService

WSMETHOD integratorProductListUpdatedCount WSSEND csessionId WSRECEIVE ccount WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductListUpdatedCount xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductListUpdatedCount>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::ccount             :=  WSAdvValue( oXmlRet,"_COUNT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductListDeletedCount of Service WSMagentoService

WSMETHOD integratorProductListDeletedCount WSSEND csessionId WSRECEIVE ccount WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductListDeletedCount xmlns:q1="http://www.w3.org/2001/XMLSchema">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductListDeletedCount>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::ccount             :=  WSAdvValue( oXmlRet,"_COUNT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductConfirmListCreatedReceived of Service WSMagentoService

WSMETHOD integratorProductConfirmListCreatedReceived WSSEND csessionId,oWSintegratorProductConfirmListCreatedReceivedreceivedSkus WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductConfirmListCreatedReceived xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("receivedSkus", ::oWSintegratorProductConfirmListCreatedReceivedreceivedSkus, oWSintegratorProductConfirmListCreatedReceivedreceivedSkus , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductConfirmListCreatedReceived>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductConfirmListUpdatedReceived of Service WSMagentoService

WSMETHOD integratorProductConfirmListUpdatedReceived WSSEND csessionId,oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductConfirmListUpdatedReceived xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("integratorProductConfirmListCreatedReceivedreceivedSkus", ::oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus, oWSintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductConfirmListUpdatedReceived>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.

// WSDL Method integratorProductConfirmListDeletedReceived of Service WSMagentoService

WSMETHOD integratorProductConfirmListDeletedReceived WSSEND csessionId,oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus WSRECEIVE cresult WSCLIENT WSMagentoService
	Local cSoap := "" , oXmlRet

	BEGIN WSMETHOD

	cSoap += '<q1:integratorProductConfirmListDeletedReceived xmlns:q1="urn:Magento">'
	cSoap += WSSoapValue("sessionId", ::csessionId, csessionId , "string", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("integratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus", ::oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus, oWSintegratorProductConfirmListDeletedReceivedintegratorProductConfirmListUpdatedReceivedintegratorProductConfirmListCreatedReceivedreceivedSkus , "ArrayOfString", .T. , .T. , 0 , NIL, .F.,.F.)
	cSoap += "</q1:integratorProductConfirmListDeletedReceived>"

	oXmlRet := SvcSoapCall(Self,cSoap,;
		"urn:Action",;
		"RPCX","urn:Magento",,,;
		_c_WsLnkMagento)

	::Init()
	::cresult            :=  WSAdvValue( oXmlRet,"_RESULT","string",NIL,NIL,NIL,"S",NIL,NIL)

	END WSMETHOD

	oXmlRet := NIL
Return .T.


// WSDL Data Structure ArrayOfApis

WSSTRUCT MagentoService_ArrayOfApis
	WSDATA   oWSapiEntity              AS MagentoService_apiEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_ArrayOfApis
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_ArrayOfApis
	::oWSapiEntity         := {} // Array Of  MagentoService_APIENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_ArrayOfApis
	Local oClone := MagentoService_ArrayOfApis():NEW()
	oClone:oWSapiEntity := NIL
	If ::oWSapiEntity <> NIL
		oClone:oWSapiEntity := {}
		aEval( ::oWSapiEntity , { |x| aadd( oClone:oWSapiEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_ArrayOfApis
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSapiEntity , MagentoService_apiEntity():New() )
			::oWSapiEntity[len(::oWSapiEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure apiEntity

WSSTRUCT MagentoService_apiEntity
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   oWSaliases                AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSmethods                AS MagentoService_ArrayOfApiMethods OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_apiEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_apiEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_apiEntity
	Local oClone := MagentoService_apiEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:cname                := ::cname
	oClone:oWSaliases           := IIF(::oWSaliases = NIL , NIL , ::oWSaliases:Clone() )
	oClone:oWSmethods           := IIF(::oWSmethods = NIL , NIL , ::oWSmethods:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_apiEntity
	Local oNode3
	Local oNode4
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode3 :=  WSAdvValue( oResponse,"_ALIASES","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWSaliases := MagentoService_ArrayOfString():New()
		::oWSaliases:SoapRecv(oNode3)
	EndIf
	oNode4 :=  WSAdvValue( oResponse,"_METHODS","ArrayOfApiMethods",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSmethods := MagentoService_ArrayOfApiMethods():New()
		::oWSmethods:SoapRecv(oNode4)
	EndIf
Return

// WSDL Data Structure ArrayOfExistsFaltures

WSSTRUCT MagentoService_ArrayOfExistsFaltures
	WSDATA   oWSexistsFaltureEntity    AS MagentoService_existsFaltureEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_ArrayOfExistsFaltures
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_ArrayOfExistsFaltures
	::oWSexistsFaltureEntity := {} // Array Of  MagentoService_EXISTSFALTUREENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_ArrayOfExistsFaltures
	Local oClone := MagentoService_ArrayOfExistsFaltures():NEW()
	oClone:oWSexistsFaltureEntity := NIL
	If ::oWSexistsFaltureEntity <> NIL
		oClone:oWSexistsFaltureEntity := {}
		aEval( ::oWSexistsFaltureEntity , { |x| aadd( oClone:oWSexistsFaltureEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_ArrayOfExistsFaltures
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSexistsFaltureEntity , MagentoService_existsFaltureEntity():New() )
			::oWSexistsFaltureEntity[len(::oWSexistsFaltureEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure existsFaltureEntity

WSSTRUCT MagentoService_existsFaltureEntity
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   cmessage                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_existsFaltureEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_existsFaltureEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_existsFaltureEntity
	Local oClone := MagentoService_existsFaltureEntity():NEW()
	oClone:ccode                := ::ccode
	oClone:cmessage             := ::cmessage
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_existsFaltureEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmessage           :=  WSAdvValue( oResponse,"_MESSAGE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure storeEntityArray

WSSTRUCT MagentoService_storeEntityArray
	WSDATA   oWSstoreEntity            AS MagentoService_storeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_storeEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_storeEntityArray
	::oWSstoreEntity       := {} // Array Of  MagentoService_STOREENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_storeEntityArray
	Local oClone := MagentoService_storeEntityArray():NEW()
	oClone:oWSstoreEntity := NIL
	If ::oWSstoreEntity <> NIL
		oClone:oWSstoreEntity := {}
		aEval( ::oWSstoreEntity , { |x| aadd( oClone:oWSstoreEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_storeEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSstoreEntity , MagentoService_storeEntity():New() )
			::oWSstoreEntity[len(::oWSstoreEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure storeEntity

WSSTRUCT MagentoService_storeEntity
	WSDATA   nstore_id                 AS int OPTIONAL
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   nwebsite_id               AS int OPTIONAL
	WSDATA   ngroup_id                 AS int OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   nsort_order               AS int OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_storeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_storeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_storeEntity
	Local oClone := MagentoService_storeEntity():NEW()
	oClone:nstore_id            := ::nstore_id
	oClone:ccode                := ::ccode
	oClone:nwebsite_id          := ::nwebsite_id
	oClone:ngroup_id            := ::ngroup_id
	oClone:cname                := ::cname
	oClone:nsort_order          := ::nsort_order
	oClone:nis_active           := ::nis_active
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_storeEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::nstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nwebsite_id        :=  WSAdvValue( oResponse,"_WEBSITE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ngroup_id          :=  WSAdvValue( oResponse,"_GROUP_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nsort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","int",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure magentoInfoEntity

WSSTRUCT MagentoService_magentoInfoEntity
	WSDATA   cmagento_version          AS string OPTIONAL
	WSDATA   cmagento_edition          AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_magentoInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_magentoInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_magentoInfoEntity
	Local oClone := MagentoService_magentoInfoEntity():NEW()
	oClone:cmagento_version     := ::cmagento_version
	oClone:cmagento_edition     := ::cmagento_edition
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_magentoInfoEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cmagento_version   :=  WSAdvValue( oResponse,"_MAGENTO_VERSION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmagento_edition   :=  WSAdvValue( oResponse,"_MAGENTO_EDITION","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure directoryCountryEntityArray

WSSTRUCT MagentoService_directoryCountryEntityArray
	WSDATA   oWSdirectoryCountryEntity AS MagentoService_directoryCountryEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_directoryCountryEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_directoryCountryEntityArray
	::oWSdirectoryCountryEntity := {} // Array Of  MagentoService_DIRECTORYCOUNTRYENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_directoryCountryEntityArray
	Local oClone := MagentoService_directoryCountryEntityArray():NEW()
	oClone:oWSdirectoryCountryEntity := NIL
	If ::oWSdirectoryCountryEntity <> NIL
		oClone:oWSdirectoryCountryEntity := {}
		aEval( ::oWSdirectoryCountryEntity , { |x| aadd( oClone:oWSdirectoryCountryEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_directoryCountryEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSdirectoryCountryEntity , MagentoService_directoryCountryEntity():New() )
			::oWSdirectoryCountryEntity[len(::oWSdirectoryCountryEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure directoryCountryEntity

WSSTRUCT MagentoService_directoryCountryEntity
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   ciso2_code                AS string OPTIONAL
	WSDATA   ciso3_code                AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_directoryCountryEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_directoryCountryEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_directoryCountryEntity
	Local oClone := MagentoService_directoryCountryEntity():NEW()
	oClone:ccountry_id          := ::ccountry_id
	oClone:ciso2_code           := ::ciso2_code
	oClone:ciso3_code           := ::ciso3_code
	oClone:cname                := ::cname
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_directoryCountryEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccountry_id        :=  WSAdvValue( oResponse,"_COUNTRY_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ciso2_code         :=  WSAdvValue( oResponse,"_ISO2_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ciso3_code         :=  WSAdvValue( oResponse,"_ISO3_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure directoryRegionEntityArray

WSSTRUCT MagentoService_directoryRegionEntityArray
	WSDATA   oWSdirectoryRegionEntity  AS MagentoService_directoryRegionEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_directoryRegionEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_directoryRegionEntityArray
	::oWSdirectoryRegionEntity := {} // Array Of  MagentoService_DIRECTORYREGIONENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_directoryRegionEntityArray
	Local oClone := MagentoService_directoryRegionEntityArray():NEW()
	oClone:oWSdirectoryRegionEntity := NIL
	If ::oWSdirectoryRegionEntity <> NIL
		oClone:oWSdirectoryRegionEntity := {}
		aEval( ::oWSdirectoryRegionEntity , { |x| aadd( oClone:oWSdirectoryRegionEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_directoryRegionEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSdirectoryRegionEntity , MagentoService_directoryRegionEntity():New() )
			::oWSdirectoryRegionEntity[len(::oWSdirectoryRegionEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure directoryRegionEntity

WSSTRUCT MagentoService_directoryRegionEntity
	WSDATA   cregion_id                AS string OPTIONAL
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_directoryRegionEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_directoryRegionEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_directoryRegionEntity
	Local oClone := MagentoService_directoryRegionEntity():NEW()
	oClone:cregion_id           := ::cregion_id
	oClone:ccode                := ::ccode
	oClone:cname                := ::cname
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_directoryRegionEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cregion_id         :=  WSAdvValue( oResponse,"_REGION_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure filters

WSSTRUCT MagentoService_filters
	WSDATA   oWSfilter                 AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWScomplex_filter         AS MagentoService_complexFilterArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_filters
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_filters
Return

WSMETHOD CLONE WSCLIENT MagentoService_filters
	Local oClone := MagentoService_filters():NEW()
	oClone:oWSfilter            := IIF(::oWSfilter = NIL , NIL , ::oWSfilter:Clone() )
	oClone:oWScomplex_filter    := IIF(::oWScomplex_filter = NIL , NIL , ::oWScomplex_filter:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_filters
	Local cSoap := ""
	cSoap += WSSoapValue("filter", ::oWSfilter, ::oWSfilter , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("complex_filter", ::oWScomplex_filter, ::oWScomplex_filter , "complexFilterArray", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure associativeArray

WSSTRUCT MagentoService_associativeArray
	WSDATA   oWSassociativeEntity      AS MagentoService_associativeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_associativeArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_associativeArray
	::oWSassociativeEntity := {} // Array Of  MagentoService_ASSOCIATIVEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_associativeArray
	Local oClone := MagentoService_associativeArray():NEW()
	oClone:oWSassociativeEntity := NIL
	If ::oWSassociativeEntity <> NIL
		oClone:oWSassociativeEntity := {}
		aEval( ::oWSassociativeEntity , { |x| aadd( oClone:oWSassociativeEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_associativeArray
	Local cSoap := ""
	aEval( ::oWSassociativeEntity , {|x| cSoap := cSoap  +  WSSoapValue("associativeEntity", x , x , "associativeEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_associativeArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSassociativeEntity , MagentoService_associativeEntity():New() )
			::oWSassociativeEntity[len(::oWSassociativeEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure complexFilterArray

WSSTRUCT MagentoService_complexFilterArray
	WSDATA   oWScomplexFilter          AS MagentoService_complexFilter OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_complexFilterArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_complexFilterArray
	::oWScomplexFilter     := {} // Array Of  MagentoService_COMPLEXFILTER():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_complexFilterArray
	Local oClone := MagentoService_complexFilterArray():NEW()
	oClone:oWScomplexFilter := NIL
	If ::oWScomplexFilter <> NIL
		oClone:oWScomplexFilter := {}
		aEval( ::oWScomplexFilter , { |x| aadd( oClone:oWScomplexFilter , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_complexFilterArray
	Local cSoap := ""
	aEval( ::oWScomplexFilter , {|x| cSoap := cSoap  +  WSSoapValue("complexFilter", x , x , "complexFilter", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure customerCustomerEntityArray

WSSTRUCT MagentoService_customerCustomerEntityArray
	WSDATA   oWScustomerCustomerEntity AS MagentoService_customerCustomerEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerCustomerEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerCustomerEntityArray
	::oWScustomerCustomerEntity := {} // Array Of  MagentoService_CUSTOMERCUSTOMERENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerCustomerEntityArray
	Local oClone := MagentoService_customerCustomerEntityArray():NEW()
	oClone:oWScustomerCustomerEntity := NIL
	If ::oWScustomerCustomerEntity <> NIL
		oClone:oWScustomerCustomerEntity := {}
		aEval( ::oWScustomerCustomerEntity , { |x| aadd( oClone:oWScustomerCustomerEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_customerCustomerEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScustomerCustomerEntity , MagentoService_customerCustomerEntity():New() )
			::oWScustomerCustomerEntity[len(::oWScustomerCustomerEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure customerCustomerEntity

WSSTRUCT MagentoService_customerCustomerEntity
	WSDATA   ncustomer_id              AS int OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   nstore_id                 AS int OPTIONAL
	WSDATA   nwebsite_id               AS int OPTIONAL
	WSDATA   ccreated_in               AS string OPTIONAL
	WSDATA   cemail                    AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   cmiddlename               AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   ngroup_id                 AS int OPTIONAL
	WSDATA   cprefix                   AS string OPTIONAL
	WSDATA   csuffix                   AS string OPTIONAL
	WSDATA   cdob                      AS string OPTIONAL
	WSDATA   ctaxvat                   AS string OPTIONAL
	WSDATA   lconfirmation             AS boolean OPTIONAL
	WSDATA   cpassword_hash            AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerCustomerEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerCustomerEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerCustomerEntity
	Local oClone := MagentoService_customerCustomerEntity():NEW()
	oClone:ncustomer_id         := ::ncustomer_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cincrement_id        := ::cincrement_id
	oClone:nstore_id            := ::nstore_id
	oClone:nwebsite_id          := ::nwebsite_id
	oClone:ccreated_in          := ::ccreated_in
	oClone:cemail               := ::cemail
	oClone:cfirstname           := ::cfirstname
	oClone:cmiddlename          := ::cmiddlename
	oClone:clastname            := ::clastname
	oClone:ngroup_id            := ::ngroup_id
	oClone:cprefix              := ::cprefix
	oClone:csuffix              := ::csuffix
	oClone:cdob                 := ::cdob
	oClone:ctaxvat              := ::ctaxvat
	oClone:lconfirmation        := ::lconfirmation
	oClone:cpassword_hash       := ::cpassword_hash
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_customerCustomerEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ncustomer_id       :=  WSAdvValue( oResponse,"_CUSTOMER_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nwebsite_id        :=  WSAdvValue( oResponse,"_WEBSITE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccreated_in        :=  WSAdvValue( oResponse,"_CREATED_IN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cemail             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfirstname         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmiddlename        :=  WSAdvValue( oResponse,"_MIDDLENAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clastname          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ngroup_id          :=  WSAdvValue( oResponse,"_GROUP_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cprefix            :=  WSAdvValue( oResponse,"_PREFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csuffix            :=  WSAdvValue( oResponse,"_SUFFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdob               :=  WSAdvValue( oResponse,"_DOB","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctaxvat            :=  WSAdvValue( oResponse,"_TAXVAT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::lconfirmation      :=  WSAdvValue( oResponse,"_CONFIRMATION","boolean",NIL,NIL,NIL,"L",NIL,NIL)
	::cpassword_hash     :=  WSAdvValue( oResponse,"_PASSWORD_HASH","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure customerCustomerEntityToCreate

WSSTRUCT MagentoService_customerCustomerEntityToCreate
	WSDATA   ncustomer_id              AS int OPTIONAL
	WSDATA   cemail                    AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   cmiddlename               AS string OPTIONAL
	WSDATA   cpassword                 AS string OPTIONAL
	WSDATA   nwebsite_id               AS int OPTIONAL
	WSDATA   nstore_id                 AS int OPTIONAL
	WSDATA   ngroup_id                 AS int OPTIONAL
	WSDATA   cprefix                   AS string OPTIONAL
	WSDATA   csuffix                   AS string OPTIONAL
	WSDATA   cdob                      AS string OPTIONAL
	WSDATA   ctaxvat                   AS string OPTIONAL
	WSDATA   ngender                   AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerCustomerEntityToCreate
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerCustomerEntityToCreate
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerCustomerEntityToCreate
	Local oClone := MagentoService_customerCustomerEntityToCreate():NEW()
	oClone:ncustomer_id         := ::ncustomer_id
	oClone:cemail               := ::cemail
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:cmiddlename          := ::cmiddlename
	oClone:cpassword            := ::cpassword
	oClone:nwebsite_id          := ::nwebsite_id
	oClone:nstore_id            := ::nstore_id
	oClone:ngroup_id            := ::ngroup_id
	oClone:cprefix              := ::cprefix
	oClone:csuffix              := ::csuffix
	oClone:cdob                 := ::cdob
	oClone:ctaxvat              := ::ctaxvat
	oClone:ngender              := ::ngender
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_customerCustomerEntityToCreate
	Local cSoap := ""
	cSoap += WSSoapValue("customer_id", ::ncustomer_id, ::ncustomer_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("email", ::cemail, ::cemail , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("firstname", ::cfirstname, ::cfirstname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("lastname", ::clastname, ::clastname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("middlename", ::cmiddlename, ::cmiddlename , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("password", ::cpassword, ::cpassword , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("website_id", ::nwebsite_id, ::nwebsite_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store_id", ::nstore_id, ::nstore_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("group_id", ::ngroup_id, ::ngroup_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("prefix", ::cprefix, ::cprefix , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("suffix", ::csuffix, ::csuffix , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("dob", ::cdob, ::cdob , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("taxvat", ::ctaxvat, ::ctaxvat , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("gender", ::ngender, ::ngender , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure ArrayOfString

WSSTRUCT MagentoService_ArrayOfString
	WSDATA   cstring                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_ArrayOfString
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_ArrayOfString
	::cstring              := {} // Array Of  ""
Return

WSMETHOD CLONE WSCLIENT MagentoService_ArrayOfString
	Local oClone := MagentoService_ArrayOfString():NEW()
	oClone:cstring              := IIf(::cstring <> NIL , aClone(::cstring) , NIL )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_ArrayOfString
	Local cSoap := ""
	aEval( ::cstring , {|x| cSoap := cSoap  +  WSSoapValue("string", x , x , "string", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_ArrayOfString
	Local oNodes1 :=  WSAdvValue( oResponse,"_STRING","string",{},NIL,.T.,"S",NIL,"a")
	::Init()
	If oResponse = NIL ; Return ; Endif
	aEval(oNodes1 , { |x| aadd(::cstring ,  x:TEXT  ) } )
Return

// WSDL Data Structure customerGroupEntityArray

WSSTRUCT MagentoService_customerGroupEntityArray
	WSDATA   oWScustomerGroupEntity    AS MagentoService_customerGroupEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerGroupEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerGroupEntityArray
	::oWScustomerGroupEntity := {} // Array Of  MagentoService_CUSTOMERGROUPENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerGroupEntityArray
	Local oClone := MagentoService_customerGroupEntityArray():NEW()
	oClone:oWScustomerGroupEntity := NIL
	If ::oWScustomerGroupEntity <> NIL
		oClone:oWScustomerGroupEntity := {}
		aEval( ::oWScustomerGroupEntity , { |x| aadd( oClone:oWScustomerGroupEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_customerGroupEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScustomerGroupEntity , MagentoService_customerGroupEntity():New() )
			::oWScustomerGroupEntity[len(::oWScustomerGroupEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure customerGroupEntity

WSSTRUCT MagentoService_customerGroupEntity
	WSDATA   ncustomer_group_id        AS int OPTIONAL
	WSDATA   ccustomer_group_code      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerGroupEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerGroupEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerGroupEntity
	Local oClone := MagentoService_customerGroupEntity():NEW()
	oClone:ncustomer_group_id   := ::ncustomer_group_id
	oClone:ccustomer_group_code := ::ccustomer_group_code
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_customerGroupEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ncustomer_group_id :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccustomer_group_code :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure customerAddressEntityArray

WSSTRUCT MagentoService_customerAddressEntityArray
	WSDATA   oWScustomerAddressEntityItem AS MagentoService_customerAddressEntityItem OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerAddressEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerAddressEntityArray
	::oWScustomerAddressEntityItem := {} // Array Of  MagentoService_CUSTOMERADDRESSENTITYITEM():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerAddressEntityArray
	Local oClone := MagentoService_customerAddressEntityArray():NEW()
	oClone:oWScustomerAddressEntityItem := NIL
	If ::oWScustomerAddressEntityItem <> NIL
		oClone:oWScustomerAddressEntityItem := {}
		aEval( ::oWScustomerAddressEntityItem , { |x| aadd( oClone:oWScustomerAddressEntityItem , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_customerAddressEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScustomerAddressEntityItem , MagentoService_customerAddressEntityItem():New() )
			::oWScustomerAddressEntityItem[len(::oWScustomerAddressEntityItem)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure customerAddressEntityItem

WSSTRUCT MagentoService_customerAddressEntityItem
	WSDATA   ncustomer_address_id      AS int OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   cmiddlename               AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   cprefix                   AS string OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   nregion_id                AS int OPTIONAL
	WSDATA   cstreet                   AS string OPTIONAL
	WSDATA   csuffix                   AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   lis_default_billing       AS boolean OPTIONAL
	WSDATA   lis_default_shipping      AS boolean OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerAddressEntityItem
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerAddressEntityItem
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerAddressEntityItem
	Local oClone := MagentoService_customerAddressEntityItem():NEW()
	oClone:ncustomer_address_id := ::ncustomer_address_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cincrement_id        := ::cincrement_id
	oClone:ccity                := ::ccity
	oClone:ccompany             := ::ccompany
	oClone:ccountry_id          := ::ccountry_id
	oClone:cfax                 := ::cfax
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:cmiddlename          := ::cmiddlename
	oClone:cpostcode            := ::cpostcode
	oClone:cprefix              := ::cprefix
	oClone:cregion              := ::cregion
	oClone:nregion_id           := ::nregion_id
	oClone:cstreet              := ::cstreet
	oClone:csuffix              := ::csuffix
	oClone:ctelephone           := ::ctelephone
	oClone:lis_default_billing  := ::lis_default_billing
	oClone:lis_default_shipping := ::lis_default_shipping
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_customerAddressEntityItem
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ncustomer_address_id :=  WSAdvValue( oResponse,"_CUSTOMER_ADDRESS_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccompany           :=  WSAdvValue( oResponse,"_COMPANY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccountry_id        :=  WSAdvValue( oResponse,"_COUNTRY_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfax               :=  WSAdvValue( oResponse,"_FAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfirstname         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clastname          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmiddlename        :=  WSAdvValue( oResponse,"_MIDDLENAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpostcode          :=  WSAdvValue( oResponse,"_POSTCODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprefix            :=  WSAdvValue( oResponse,"_PREFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion            :=  WSAdvValue( oResponse,"_REGION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nregion_id         :=  WSAdvValue( oResponse,"_REGION_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cstreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csuffix            :=  WSAdvValue( oResponse,"_SUFFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctelephone         :=  WSAdvValue( oResponse,"_TELEPHONE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::lis_default_billing :=  WSAdvValue( oResponse,"_IS_DEFAULT_BILLING","boolean",NIL,NIL,NIL,"L",NIL,NIL)
	::lis_default_shipping :=  WSAdvValue( oResponse,"_IS_DEFAULT_SHIPPING","boolean",NIL,NIL,NIL,"L",NIL,NIL)
Return

// WSDL Data Structure customerAddressEntityCreate

WSSTRUCT MagentoService_customerAddressEntityCreate
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   cmiddlename               AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   cprefix                   AS string OPTIONAL
	WSDATA   nregion_id                AS int OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   oWSstreet                 AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   csuffix                   AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   lis_default_billing       AS boolean OPTIONAL
	WSDATA   lis_default_shipping      AS boolean OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_customerAddressEntityCreate
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_customerAddressEntityCreate
Return

WSMETHOD CLONE WSCLIENT MagentoService_customerAddressEntityCreate
	Local oClone := MagentoService_customerAddressEntityCreate():NEW()
	oClone:ccity                := ::ccity
	oClone:ccompany             := ::ccompany
	oClone:ccountry_id          := ::ccountry_id
	oClone:cfax                 := ::cfax
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:cmiddlename          := ::cmiddlename
	oClone:cpostcode            := ::cpostcode
	oClone:cprefix              := ::cprefix
	oClone:nregion_id           := ::nregion_id
	oClone:cregion              := ::cregion
	oClone:oWSstreet            := IIF(::oWSstreet = NIL , NIL , ::oWSstreet:Clone() )
	oClone:csuffix              := ::csuffix
	oClone:ctelephone           := ::ctelephone
	oClone:lis_default_billing  := ::lis_default_billing
	oClone:lis_default_shipping := ::lis_default_shipping
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_customerAddressEntityCreate
	Local cSoap := ""
	cSoap += WSSoapValue("city", ::ccity, ::ccity , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("company", ::ccompany, ::ccompany , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("country_id", ::ccountry_id, ::ccountry_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("fax", ::cfax, ::cfax , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("firstname", ::cfirstname, ::cfirstname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("lastname", ::clastname, ::clastname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("middlename", ::cmiddlename, ::cmiddlename , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("postcode", ::cpostcode, ::cpostcode , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("prefix", ::cprefix, ::cprefix , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("region_id", ::nregion_id, ::nregion_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("region", ::cregion, ::cregion , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("street", ::oWSstreet, ::oWSstreet , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("suffix", ::csuffix, ::csuffix , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("telephone", ::ctelephone, ::ctelephone , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_default_billing", ::lis_default_billing, ::lis_default_billing , "boolean", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_default_shipping", ::lis_default_shipping, ::lis_default_shipping , "boolean", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogCategoryTree

WSSTRUCT MagentoService_catalogCategoryTree
	WSDATA   ncategory_id              AS int OPTIONAL
	WSDATA   nparent_id                AS int OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   nposition                 AS int OPTIONAL
	WSDATA   nlevel                    AS int OPTIONAL
	WSDATA   oWSchildren               AS MagentoService_ArrayOfCatalogCategoryEntities OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogCategoryTree
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogCategoryTree
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogCategoryTree
	Local oClone := MagentoService_catalogCategoryTree():NEW()
	oClone:ncategory_id         := ::ncategory_id
	oClone:nparent_id           := ::nparent_id
	oClone:cname                := ::cname
	oClone:nposition            := ::nposition
	oClone:nlevel               := ::nlevel
	oClone:oWSchildren          := IIF(::oWSchildren = NIL , NIL , ::oWSchildren:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogCategoryTree
	Local oNode6
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ncategory_id       :=  WSAdvValue( oResponse,"_CATEGORY_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nposition          :=  WSAdvValue( oResponse,"_POSITION","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nlevel             :=  WSAdvValue( oResponse,"_LEVEL","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode6 :=  WSAdvValue( oResponse,"_CHILDREN","ArrayOfCatalogCategoryEntities",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode6 != NIL
		::oWSchildren := MagentoService_ArrayOfCatalogCategoryEntities():New()
		::oWSchildren:SoapRecv(oNode6)
	EndIf
Return

// WSDL Data Structure ArrayOfCatalogCategoryEntities

WSSTRUCT MagentoService_ArrayOfCatalogCategoryEntities
	WSDATA   oWScatalogCategoryEntity  AS MagentoService_catalogCategoryEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_ArrayOfCatalogCategoryEntities
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_ArrayOfCatalogCategoryEntities
	::oWScatalogCategoryEntity := {} // Array Of  MagentoService_CATALOGCATEGORYENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_ArrayOfCatalogCategoryEntities
	Local oClone := MagentoService_ArrayOfCatalogCategoryEntities():NEW()
	oClone:oWScatalogCategoryEntity := NIL
	If ::oWScatalogCategoryEntity <> NIL
		oClone:oWScatalogCategoryEntity := {}
		aEval( ::oWScatalogCategoryEntity , { |x| aadd( oClone:oWScatalogCategoryEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_ArrayOfCatalogCategoryEntities
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogCategoryEntity , MagentoService_catalogCategoryEntity():New() )
			::oWScatalogCategoryEntity[len(::oWScatalogCategoryEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfCatalogCategoryEntitiesNoChildren

WSSTRUCT MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren
	WSDATA   oWScatalogCategoryEntityNoChildren AS MagentoService_catalogCategoryEntityNoChildren OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren
	::oWScatalogCategoryEntityNoChildren := {} // Array Of  MagentoService_CATALOGCATEGORYENTITYNOCHILDREN():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren
	Local oClone := MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren():NEW()
	oClone:oWScatalogCategoryEntityNoChildren := NIL
	If ::oWScatalogCategoryEntityNoChildren <> NIL
		oClone:oWScatalogCategoryEntityNoChildren := {}
		aEval( ::oWScatalogCategoryEntityNoChildren , { |x| aadd( oClone:oWScatalogCategoryEntityNoChildren , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_ArrayOfCatalogCategoryEntitiesNoChildren
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogCategoryEntityNoChildren , MagentoService_catalogCategoryEntityNoChildren():New() )
			::oWScatalogCategoryEntityNoChildren[len(::oWScatalogCategoryEntityNoChildren)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogCategoryEntityNoChildren

WSSTRUCT MagentoService_catalogCategoryEntityNoChildren
	WSDATA   ncategory_id              AS int OPTIONAL
	WSDATA   nparent_id                AS int OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSDATA   nposition                 AS int OPTIONAL
	WSDATA   nlevel                    AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogCategoryEntityNoChildren
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogCategoryEntityNoChildren
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogCategoryEntityNoChildren
	Local oClone := MagentoService_catalogCategoryEntityNoChildren():NEW()
	oClone:ncategory_id         := ::ncategory_id
	oClone:nparent_id           := ::nparent_id
	oClone:cname                := ::cname
	oClone:nis_active           := ::nis_active
	oClone:nposition            := ::nposition
	oClone:nlevel               := ::nlevel
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogCategoryEntityNoChildren
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ncategory_id       :=  WSAdvValue( oResponse,"_CATEGORY_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nposition          :=  WSAdvValue( oResponse,"_POSITION","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nlevel             :=  WSAdvValue( oResponse,"_LEVEL","int",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure catalogCategoryInfo

WSSTRUCT MagentoService_catalogCategoryInfo
	WSDATA   ccategory_id              AS string OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSDATA   cposition                 AS string OPTIONAL
	WSDATA   clevel                    AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   call_children             AS string OPTIONAL
	WSDATA   cchildren                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   curl_key                  AS string OPTIONAL
	WSDATA   cdescription              AS string OPTIONAL
	WSDATA   cmeta_title               AS string OPTIONAL
	WSDATA   cmeta_keywords            AS string OPTIONAL
	WSDATA   cmeta_description         AS string OPTIONAL
	WSDATA   cpath                     AS string OPTIONAL
	WSDATA   curl_path                 AS string OPTIONAL
	WSDATA   nchildren_count           AS int OPTIONAL
	WSDATA   cdisplay_mode             AS string OPTIONAL
	WSDATA   nis_anchor                AS int OPTIONAL
	WSDATA   oWSavailable_sort_by      AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   ccustom_design            AS string OPTIONAL
	WSDATA   ccustom_design_apply      AS string OPTIONAL
	WSDATA   ccustom_design_from       AS string OPTIONAL
	WSDATA   ccustom_design_to         AS string OPTIONAL
	WSDATA   cpage_layout              AS string OPTIONAL
	WSDATA   ccustom_layout_update     AS string OPTIONAL
	WSDATA   cdefault_sort_by          AS string OPTIONAL
	WSDATA   nlanding_page             AS int OPTIONAL
	WSDATA   ninclude_in_menu          AS int OPTIONAL
	WSDATA   ncustom_use_parent_settings AS int OPTIONAL
	WSDATA   ncustom_apply_to_products AS int OPTIONAL
	WSDATA   cfilter_price_range       AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogCategoryInfo
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogCategoryInfo
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogCategoryInfo
	Local oClone := MagentoService_catalogCategoryInfo():NEW()
	oClone:ccategory_id         := ::ccategory_id
	oClone:nis_active           := ::nis_active
	oClone:cposition            := ::cposition
	oClone:clevel               := ::clevel
	oClone:cparent_id           := ::cparent_id
	oClone:call_children        := ::call_children
	oClone:cchildren            := ::cchildren
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cname                := ::cname
	oClone:curl_key             := ::curl_key
	oClone:cdescription         := ::cdescription
	oClone:cmeta_title          := ::cmeta_title
	oClone:cmeta_keywords       := ::cmeta_keywords
	oClone:cmeta_description    := ::cmeta_description
	oClone:cpath                := ::cpath
	oClone:curl_path            := ::curl_path
	oClone:nchildren_count      := ::nchildren_count
	oClone:cdisplay_mode        := ::cdisplay_mode
	oClone:nis_anchor           := ::nis_anchor
	oClone:oWSavailable_sort_by := IIF(::oWSavailable_sort_by = NIL , NIL , ::oWSavailable_sort_by:Clone() )
	oClone:ccustom_design       := ::ccustom_design
	oClone:ccustom_design_apply := ::ccustom_design_apply
	oClone:ccustom_design_from  := ::ccustom_design_from
	oClone:ccustom_design_to    := ::ccustom_design_to
	oClone:cpage_layout         := ::cpage_layout
	oClone:ccustom_layout_update := ::ccustom_layout_update
	oClone:cdefault_sort_by     := ::cdefault_sort_by
	oClone:nlanding_page        := ::nlanding_page
	oClone:ninclude_in_menu     := ::ninclude_in_menu
	oClone:ncustom_use_parent_settings := ::ncustom_use_parent_settings
	oClone:ncustom_apply_to_products := ::ncustom_apply_to_products
	oClone:cfilter_price_range  := ::cfilter_price_range
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogCategoryInfo
	Local oNode21
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccategory_id       :=  WSAdvValue( oResponse,"_CATEGORY_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cposition          :=  WSAdvValue( oResponse,"_POSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clevel             :=  WSAdvValue( oResponse,"_LEVEL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::call_children      :=  WSAdvValue( oResponse,"_ALL_CHILDREN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cchildren          :=  WSAdvValue( oResponse,"_CHILDREN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::curl_key           :=  WSAdvValue( oResponse,"_URL_KEY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmeta_title        :=  WSAdvValue( oResponse,"_META_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmeta_keywords     :=  WSAdvValue( oResponse,"_META_KEYWORDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmeta_description  :=  WSAdvValue( oResponse,"_META_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpath              :=  WSAdvValue( oResponse,"_PATH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::curl_path          :=  WSAdvValue( oResponse,"_URL_PATH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nchildren_count    :=  WSAdvValue( oResponse,"_CHILDREN_COUNT","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cdisplay_mode      :=  WSAdvValue( oResponse,"_DISPLAY_MODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_anchor         :=  WSAdvValue( oResponse,"_IS_ANCHOR","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode21 :=  WSAdvValue( oResponse,"_AVAILABLE_SORT_BY","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode21 != NIL
		::oWSavailable_sort_by := MagentoService_ArrayOfString():New()
		::oWSavailable_sort_by:SoapRecv(oNode21)
	EndIf
	::ccustom_design     :=  WSAdvValue( oResponse,"_CUSTOM_DESIGN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustom_design_apply :=  WSAdvValue( oResponse,"_CUSTOM_DESIGN_APPLY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustom_design_from :=  WSAdvValue( oResponse,"_CUSTOM_DESIGN_FROM","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustom_design_to  :=  WSAdvValue( oResponse,"_CUSTOM_DESIGN_TO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpage_layout       :=  WSAdvValue( oResponse,"_PAGE_LAYOUT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustom_layout_update :=  WSAdvValue( oResponse,"_CUSTOM_LAYOUT_UPDATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdefault_sort_by   :=  WSAdvValue( oResponse,"_DEFAULT_SORT_BY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nlanding_page      :=  WSAdvValue( oResponse,"_LANDING_PAGE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ninclude_in_menu   :=  WSAdvValue( oResponse,"_INCLUDE_IN_MENU","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ncustom_use_parent_settings :=  WSAdvValue( oResponse,"_CUSTOM_USE_PARENT_SETTINGS","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ncustom_apply_to_products :=  WSAdvValue( oResponse,"_CUSTOM_APPLY_TO_PRODUCTS","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cfilter_price_range :=  WSAdvValue( oResponse,"_FILTER_PRICE_RANGE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogCategoryEntityCreate

WSSTRUCT MagentoService_catalogCategoryEntityCreate
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSDATA   nposition                 AS int OPTIONAL
	WSDATA   oWSavailable_sort_by      AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   ccustom_design            AS string OPTIONAL
	WSDATA   ncustom_design_apply      AS int OPTIONAL
	WSDATA   ccustom_design_from       AS string OPTIONAL
	WSDATA   ccustom_design_to         AS string OPTIONAL
	WSDATA   ccustom_layout_update     AS string OPTIONAL
	WSDATA   cdefault_sort_by          AS string OPTIONAL
	WSDATA   cdescription              AS string OPTIONAL
	WSDATA   cdisplay_mode             AS string OPTIONAL
	WSDATA   nis_anchor                AS int OPTIONAL
	WSDATA   nlanding_page             AS int OPTIONAL
	WSDATA   cmeta_description         AS string OPTIONAL
	WSDATA   cmeta_keywords            AS string OPTIONAL
	WSDATA   cmeta_title               AS string OPTIONAL
	WSDATA   cpage_layout              AS string OPTIONAL
	WSDATA   curl_key                  AS string OPTIONAL
	WSDATA   ninclude_in_menu          AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogCategoryEntityCreate
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogCategoryEntityCreate
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogCategoryEntityCreate
	Local oClone := MagentoService_catalogCategoryEntityCreate():NEW()
	oClone:cname                := ::cname
	oClone:nis_active           := ::nis_active
	oClone:nposition            := ::nposition
	oClone:oWSavailable_sort_by := IIF(::oWSavailable_sort_by = NIL , NIL , ::oWSavailable_sort_by:Clone() )
	oClone:ccustom_design       := ::ccustom_design
	oClone:ncustom_design_apply := ::ncustom_design_apply
	oClone:ccustom_design_from  := ::ccustom_design_from
	oClone:ccustom_design_to    := ::ccustom_design_to
	oClone:ccustom_layout_update := ::ccustom_layout_update
	oClone:cdefault_sort_by     := ::cdefault_sort_by
	oClone:cdescription         := ::cdescription
	oClone:cdisplay_mode        := ::cdisplay_mode
	oClone:nis_anchor           := ::nis_anchor
	oClone:nlanding_page        := ::nlanding_page
	oClone:cmeta_description    := ::cmeta_description
	oClone:cmeta_keywords       := ::cmeta_keywords
	oClone:cmeta_title          := ::cmeta_title
	oClone:cpage_layout         := ::cpage_layout
	oClone:curl_key             := ::curl_key
	oClone:ninclude_in_menu     := ::ninclude_in_menu
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogCategoryEntityCreate
	Local cSoap := ""
	cSoap += WSSoapValue("name", ::cname, ::cname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_active", ::nis_active, ::nis_active , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("position", ::nposition, ::nposition , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("available_sort_by", ::oWSavailable_sort_by, ::oWSavailable_sort_by , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_design", ::ccustom_design, ::ccustom_design , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_design_apply", ::ncustom_design_apply, ::ncustom_design_apply , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_design_from", ::ccustom_design_from, ::ccustom_design_from , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_design_to", ::ccustom_design_to, ::ccustom_design_to , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_layout_update", ::ccustom_layout_update, ::ccustom_layout_update , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("default_sort_by", ::cdefault_sort_by, ::cdefault_sort_by , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("description", ::cdescription, ::cdescription , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("display_mode", ::cdisplay_mode, ::cdisplay_mode , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_anchor", ::nis_anchor, ::nis_anchor , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("landing_page", ::nlanding_page, ::nlanding_page , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("meta_description", ::cmeta_description, ::cmeta_description , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("meta_keywords", ::cmeta_keywords, ::cmeta_keywords , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("meta_title", ::cmeta_title, ::cmeta_title , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("page_layout", ::cpage_layout, ::cpage_layout , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("url_key", ::curl_key, ::curl_key , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("include_in_menu", ::ninclude_in_menu, ::ninclude_in_menu , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogAssignedProductArray

WSSTRUCT MagentoService_catalogAssignedProductArray
	WSDATA   oWScatalogAssignedProduct AS MagentoService_catalogAssignedProduct OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogAssignedProductArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogAssignedProductArray
	::oWScatalogAssignedProduct := {} // Array Of  MagentoService_CATALOGASSIGNEDPRODUCT():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogAssignedProductArray
	Local oClone := MagentoService_catalogAssignedProductArray():NEW()
	oClone:oWScatalogAssignedProduct := NIL
	If ::oWScatalogAssignedProduct <> NIL
		oClone:oWScatalogAssignedProduct := {}
		aEval( ::oWScatalogAssignedProduct , { |x| aadd( oClone:oWScatalogAssignedProduct , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogAssignedProductArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogAssignedProduct , MagentoService_catalogAssignedProduct():New() )
			::oWScatalogAssignedProduct[len(::oWScatalogAssignedProduct)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogAssignedProduct

WSSTRUCT MagentoService_catalogAssignedProduct
	WSDATA   nproduct_id               AS int OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   nset                      AS int OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   nposition                 AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogAssignedProduct
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogAssignedProduct
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogAssignedProduct
	Local oClone := MagentoService_catalogAssignedProduct():NEW()
	oClone:nproduct_id          := ::nproduct_id
	oClone:ctype                := ::ctype
	oClone:nset                 := ::nset
	oClone:csku                 := ::csku
	oClone:nposition            := ::nposition
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogAssignedProduct
	::Init()
	If oResponse = NIL ; Return ; Endif
	::nproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nset               :=  WSAdvValue( oResponse,"_SET","int",NIL,NIL,NIL,"N",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nposition          :=  WSAdvValue( oResponse,"_POSITION","int",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure catalogAttributeEntityArray

WSSTRUCT MagentoService_catalogAttributeEntityArray
	WSDATA   oWScatalogAttributeEntity AS MagentoService_catalogAttributeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogAttributeEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogAttributeEntityArray
	::oWScatalogAttributeEntity := {} // Array Of  MagentoService_CATALOGATTRIBUTEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogAttributeEntityArray
	Local oClone := MagentoService_catalogAttributeEntityArray():NEW()
	oClone:oWScatalogAttributeEntity := NIL
	If ::oWScatalogAttributeEntity <> NIL
		oClone:oWScatalogAttributeEntity := {}
		aEval( ::oWScatalogAttributeEntity , { |x| aadd( oClone:oWScatalogAttributeEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogAttributeEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogAttributeEntity , MagentoService_catalogAttributeEntity():New() )
			::oWScatalogAttributeEntity[len(::oWScatalogAttributeEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogAttributeEntity

WSSTRUCT MagentoService_catalogAttributeEntity
	WSDATA   nattribute_id             AS int OPTIONAL
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   crequired                 AS string OPTIONAL
	WSDATA   cscope                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogAttributeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogAttributeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogAttributeEntity
	Local oClone := MagentoService_catalogAttributeEntity():NEW()
	oClone:nattribute_id        := ::nattribute_id
	oClone:ccode                := ::ccode
	oClone:ctype                := ::ctype
	oClone:crequired            := ::crequired
	oClone:cscope               := ::cscope
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogAttributeEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::nattribute_id      :=  WSAdvValue( oResponse,"_ATTRIBUTE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crequired          :=  WSAdvValue( oResponse,"_REQUIRED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cscope             :=  WSAdvValue( oResponse,"_SCOPE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogAttributeOptionEntityArray

WSSTRUCT MagentoService_catalogAttributeOptionEntityArray
	WSDATA   oWScatalogAttributeOptionEntity AS MagentoService_catalogAttributeOptionEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogAttributeOptionEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogAttributeOptionEntityArray
	::oWScatalogAttributeOptionEntity := {} // Array Of  MagentoService_CATALOGATTRIBUTEOPTIONENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogAttributeOptionEntityArray
	Local oClone := MagentoService_catalogAttributeOptionEntityArray():NEW()
	oClone:oWScatalogAttributeOptionEntity := NIL
	If ::oWScatalogAttributeOptionEntity <> NIL
		oClone:oWScatalogAttributeOptionEntity := {}
		aEval( ::oWScatalogAttributeOptionEntity , { |x| aadd( oClone:oWScatalogAttributeOptionEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogAttributeOptionEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogAttributeOptionEntity , MagentoService_catalogAttributeOptionEntity():New() )
			::oWScatalogAttributeOptionEntity[len(::oWScatalogAttributeOptionEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogAttributeOptionEntity

WSSTRUCT MagentoService_catalogAttributeOptionEntity
	WSDATA   clabel                    AS string OPTIONAL
	WSDATA   cvalue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogAttributeOptionEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogAttributeOptionEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogAttributeOptionEntity
	Local oClone := MagentoService_catalogAttributeOptionEntity():NEW()
	oClone:clabel               := ::clabel
	oClone:cvalue               := ::cvalue
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogAttributeOptionEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::clabel             :=  WSAdvValue( oResponse,"_LABEL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cvalue             :=  WSAdvValue( oResponse,"_VALUE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductEntityArray

WSSTRUCT MagentoService_catalogProductEntityArray
	WSDATA   oWScatalogProductEntity   AS MagentoService_catalogProductEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductEntityArray
	::oWScatalogProductEntity := {} // Array Of  MagentoService_CATALOGPRODUCTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductEntityArray
	Local oClone := MagentoService_catalogProductEntityArray():NEW()
	oClone:oWScatalogProductEntity := NIL
	If ::oWScatalogProductEntity <> NIL
		oClone:oWScatalogProductEntity := {}
		aEval( ::oWScatalogProductEntity , { |x| aadd( oClone:oWScatalogProductEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductEntity , MagentoService_catalogProductEntity():New() )
			::oWScatalogProductEntity[len(::oWScatalogProductEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductEntity

WSSTRUCT MagentoService_catalogProductEntity
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   cset                      AS string OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   oWScategory_ids           AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSwebsite_ids            AS MagentoService_ArrayOfString OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductEntity
	Local oClone := MagentoService_catalogProductEntity():NEW()
	oClone:cproduct_id          := ::cproduct_id
	oClone:csku                 := ::csku
	oClone:cname                := ::cname
	oClone:cset                 := ::cset
	oClone:ctype                := ::ctype
	oClone:oWScategory_ids      := IIF(::oWScategory_ids = NIL , NIL , ::oWScategory_ids:Clone() )
	oClone:oWSwebsite_ids       := IIF(::oWSwebsite_ids = NIL , NIL , ::oWSwebsite_ids:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductEntity
	Local oNode6
	Local oNode7
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cset               :=  WSAdvValue( oResponse,"_SET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode6 :=  WSAdvValue( oResponse,"_CATEGORY_IDS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode6 != NIL
		::oWScategory_ids := MagentoService_ArrayOfString():New()
		::oWScategory_ids:SoapRecv(oNode6)
	EndIf
	oNode7 :=  WSAdvValue( oResponse,"_WEBSITE_IDS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode7 != NIL
		::oWSwebsite_ids := MagentoService_ArrayOfString():New()
		::oWSwebsite_ids:SoapRecv(oNode7)
	EndIf
Return

// WSDL Data Structure catalogProductRequestAttributes

WSSTRUCT MagentoService_catalogProductRequestAttributes
	WSDATA   oWSattributes             AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSadditional_attributes  AS MagentoService_ArrayOfString OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductRequestAttributes
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductRequestAttributes
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductRequestAttributes
	Local oClone := MagentoService_catalogProductRequestAttributes():NEW()
	oClone:oWSattributes        := IIF(::oWSattributes = NIL , NIL , ::oWSattributes:Clone() )
	oClone:oWSadditional_attributes := IIF(::oWSadditional_attributes = NIL , NIL , ::oWSadditional_attributes:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductRequestAttributes
	Local cSoap := ""
	cSoap += WSSoapValue("attributes", ::oWSattributes, ::oWSattributes , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("additional_attributes", ::oWSadditional_attributes, ::oWSadditional_attributes , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductReturnEntity

WSSTRUCT MagentoService_catalogProductReturnEntity
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cset                      AS string OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   oWScategories             AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSwebsites               AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   ctype_id                  AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   cdescription              AS string OPTIONAL
	WSDATA   cshort_description        AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   curl_key                  AS string OPTIONAL
	WSDATA   curl_path                 AS string OPTIONAL
	WSDATA   cvisibility               AS string OPTIONAL
	WSDATA   oWScategory_ids           AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSwebsite_ids            AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   chas_options              AS string OPTIONAL
	WSDATA   cgift_message_available   AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cspecial_price            AS string OPTIONAL
	WSDATA   cspecial_from_date        AS string OPTIONAL
	WSDATA   cspecial_to_date          AS string OPTIONAL
	WSDATA   ctax_class_id             AS string OPTIONAL
	WSDATA   oWStier_price             AS MagentoService_catalogProductTierPriceEntityArray OPTIONAL
	WSDATA   cmeta_title               AS string OPTIONAL
	WSDATA   cmeta_keyword             AS string OPTIONAL
	WSDATA   cmeta_description         AS string OPTIONAL
	WSDATA   ccustom_design            AS string OPTIONAL
	WSDATA   ccustom_layout_update     AS string OPTIONAL
	WSDATA   coptions_container        AS string OPTIONAL
	WSDATA   oWSadditional_attributes  AS MagentoService_associativeArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductReturnEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductReturnEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductReturnEntity
	Local oClone := MagentoService_catalogProductReturnEntity():NEW()
	oClone:cproduct_id          := ::cproduct_id
	oClone:csku                 := ::csku
	oClone:cset                 := ::cset
	oClone:ctype                := ::ctype
	oClone:oWScategories        := IIF(::oWScategories = NIL , NIL , ::oWScategories:Clone() )
	oClone:oWSwebsites          := IIF(::oWSwebsites = NIL , NIL , ::oWSwebsites:Clone() )
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:ctype_id             := ::ctype_id
	oClone:cname                := ::cname
	oClone:cdescription         := ::cdescription
	oClone:cshort_description   := ::cshort_description
	oClone:cweight              := ::cweight
	oClone:cstatus              := ::cstatus
	oClone:curl_key             := ::curl_key
	oClone:curl_path            := ::curl_path
	oClone:cvisibility          := ::cvisibility
	oClone:oWScategory_ids      := IIF(::oWScategory_ids = NIL , NIL , ::oWScategory_ids:Clone() )
	oClone:oWSwebsite_ids       := IIF(::oWSwebsite_ids = NIL , NIL , ::oWSwebsite_ids:Clone() )
	oClone:chas_options         := ::chas_options
	oClone:cgift_message_available := ::cgift_message_available
	oClone:cprice               := ::cprice
	oClone:cspecial_price       := ::cspecial_price
	oClone:cspecial_from_date   := ::cspecial_from_date
	oClone:cspecial_to_date     := ::cspecial_to_date
	oClone:ctax_class_id        := ::ctax_class_id
	oClone:oWStier_price        := IIF(::oWStier_price = NIL , NIL , ::oWStier_price:Clone() )
	oClone:cmeta_title          := ::cmeta_title
	oClone:cmeta_keyword        := ::cmeta_keyword
	oClone:cmeta_description    := ::cmeta_description
	oClone:ccustom_design       := ::ccustom_design
	oClone:ccustom_layout_update := ::ccustom_layout_update
	oClone:coptions_container   := ::coptions_container
	oClone:oWSadditional_attributes := IIF(::oWSadditional_attributes = NIL , NIL , ::oWSadditional_attributes:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductReturnEntity
	Local oNode5
	Local oNode6
	Local oNode18
	Local oNode19
	Local oNode27
	Local oNode34
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cset               :=  WSAdvValue( oResponse,"_SET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode5 :=  WSAdvValue( oResponse,"_CATEGORIES","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode5 != NIL
		::oWScategories := MagentoService_ArrayOfString():New()
		::oWScategories:SoapRecv(oNode5)
	EndIf
	oNode6 :=  WSAdvValue( oResponse,"_WEBSITES","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode6 != NIL
		::oWSwebsites := MagentoService_ArrayOfString():New()
		::oWSwebsites:SoapRecv(oNode6)
	EndIf
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctype_id           :=  WSAdvValue( oResponse,"_TYPE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshort_description :=  WSAdvValue( oResponse,"_SHORT_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::curl_key           :=  WSAdvValue( oResponse,"_URL_KEY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::curl_path          :=  WSAdvValue( oResponse,"_URL_PATH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cvisibility        :=  WSAdvValue( oResponse,"_VISIBILITY","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode18 :=  WSAdvValue( oResponse,"_CATEGORY_IDS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode18 != NIL
		::oWScategory_ids := MagentoService_ArrayOfString():New()
		::oWScategory_ids:SoapRecv(oNode18)
	EndIf
	oNode19 :=  WSAdvValue( oResponse,"_WEBSITE_IDS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode19 != NIL
		::oWSwebsite_ids := MagentoService_ArrayOfString():New()
		::oWSwebsite_ids:SoapRecv(oNode19)
	EndIf
	::chas_options       :=  WSAdvValue( oResponse,"_HAS_OPTIONS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_available :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_AVAILABLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cspecial_price     :=  WSAdvValue( oResponse,"_SPECIAL_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cspecial_from_date :=  WSAdvValue( oResponse,"_SPECIAL_FROM_DATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cspecial_to_date   :=  WSAdvValue( oResponse,"_SPECIAL_TO_DATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_class_id      :=  WSAdvValue( oResponse,"_TAX_CLASS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode27 :=  WSAdvValue( oResponse,"_TIER_PRICE","catalogProductTierPriceEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode27 != NIL
		::oWStier_price := MagentoService_catalogProductTierPriceEntityArray():New()
		::oWStier_price:SoapRecv(oNode27)
	EndIf
	::cmeta_title        :=  WSAdvValue( oResponse,"_META_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmeta_keyword      :=  WSAdvValue( oResponse,"_META_KEYWORD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmeta_description  :=  WSAdvValue( oResponse,"_META_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustom_design     :=  WSAdvValue( oResponse,"_CUSTOM_DESIGN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustom_layout_update :=  WSAdvValue( oResponse,"_CUSTOM_LAYOUT_UPDATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::coptions_container :=  WSAdvValue( oResponse,"_OPTIONS_CONTAINER","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode34 :=  WSAdvValue( oResponse,"_ADDITIONAL_ATTRIBUTES","associativeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode34 != NIL
		::oWSadditional_attributes := MagentoService_associativeArray():New()
		::oWSadditional_attributes:SoapRecv(oNode34)
	EndIf
Return

// WSDL Data Structure catalogProductTierPriceEntityArray

WSSTRUCT MagentoService_catalogProductTierPriceEntityArray
	WSDATA   oWScatalogProductTierPriceEntity AS MagentoService_catalogProductTierPriceEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTierPriceEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTierPriceEntityArray
	::oWScatalogProductTierPriceEntity := {} // Array Of  MagentoService_CATALOGPRODUCTTIERPRICEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTierPriceEntityArray
	Local oClone := MagentoService_catalogProductTierPriceEntityArray():NEW()
	oClone:oWScatalogProductTierPriceEntity := NIL
	If ::oWScatalogProductTierPriceEntity <> NIL
		oClone:oWScatalogProductTierPriceEntity := {}
		aEval( ::oWScatalogProductTierPriceEntity , { |x| aadd( oClone:oWScatalogProductTierPriceEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductTierPriceEntityArray
	Local cSoap := ""
	aEval( ::oWScatalogProductTierPriceEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogProductTierPriceEntity", x , x , "catalogProductTierPriceEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTierPriceEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductTierPriceEntity , MagentoService_catalogProductTierPriceEntity():New() )
			::oWScatalogProductTierPriceEntity[len(::oWScatalogProductTierPriceEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductCreateEntity

WSSTRUCT MagentoService_catalogProductCreateEntity
	WSDATA   oWScategories             AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSwebsites               AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   cdescription              AS string OPTIONAL
	WSDATA   cshort_description        AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   curl_key                  AS string OPTIONAL
	WSDATA   curl_path                 AS string OPTIONAL
	WSDATA   cvisibility               AS string OPTIONAL
	WSDATA   oWScategory_ids           AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   oWSwebsite_ids            AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   chas_options              AS string OPTIONAL
	WSDATA   cgift_message_available   AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cspecial_price            AS string OPTIONAL
	WSDATA   cspecial_from_date        AS string OPTIONAL
	WSDATA   cspecial_to_date          AS string OPTIONAL
	WSDATA   ctax_class_id             AS string OPTIONAL
	WSDATA   oWStier_price             AS MagentoService_catalogProductTierPriceEntityArray OPTIONAL
	WSDATA   cmeta_title               AS string OPTIONAL
	WSDATA   cmeta_keyword             AS string OPTIONAL
	WSDATA   cmeta_description         AS string OPTIONAL
	WSDATA   ccustom_design            AS string OPTIONAL
	WSDATA   ccustom_layout_update     AS string OPTIONAL
	WSDATA   coptions_container        AS string OPTIONAL
	WSDATA   oWSadditional_attributes  AS MagentoService_catalogProductAdditionalAttributesEntity OPTIONAL
	WSDATA   oWSstock_data             AS MagentoService_catalogInventoryStockItemUpdateEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCreateEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCreateEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCreateEntity
	Local oClone := MagentoService_catalogProductCreateEntity():NEW()
	oClone:oWScategories        := IIF(::oWScategories = NIL , NIL , ::oWScategories:Clone() )
	oClone:oWSwebsites          := IIF(::oWSwebsites = NIL , NIL , ::oWSwebsites:Clone() )
	oClone:cname                := ::cname
	oClone:cdescription         := ::cdescription
	oClone:cshort_description   := ::cshort_description
	oClone:cweight              := ::cweight
	oClone:cstatus              := ::cstatus
	oClone:curl_key             := ::curl_key
	oClone:curl_path            := ::curl_path
	oClone:cvisibility          := ::cvisibility
	oClone:oWScategory_ids      := IIF(::oWScategory_ids = NIL , NIL , ::oWScategory_ids:Clone() )
	oClone:oWSwebsite_ids       := IIF(::oWSwebsite_ids = NIL , NIL , ::oWSwebsite_ids:Clone() )
	oClone:chas_options         := ::chas_options
	oClone:cgift_message_available := ::cgift_message_available
	oClone:cprice               := ::cprice
	oClone:cspecial_price       := ::cspecial_price
	oClone:cspecial_from_date   := ::cspecial_from_date
	oClone:cspecial_to_date     := ::cspecial_to_date
	oClone:ctax_class_id        := ::ctax_class_id
	oClone:oWStier_price        := IIF(::oWStier_price = NIL , NIL , ::oWStier_price:Clone() )
	oClone:cmeta_title          := ::cmeta_title
	oClone:cmeta_keyword        := ::cmeta_keyword
	oClone:cmeta_description    := ::cmeta_description
	oClone:ccustom_design       := ::ccustom_design
	oClone:ccustom_layout_update := ::ccustom_layout_update
	oClone:coptions_container   := ::coptions_container
	oClone:oWSadditional_attributes := IIF(::oWSadditional_attributes = NIL , NIL , ::oWSadditional_attributes:Clone() )
	oClone:oWSstock_data        := IIF(::oWSstock_data = NIL , NIL , ::oWSstock_data:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCreateEntity
	Local cSoap := ""
	cSoap += WSSoapValue("categories", ::oWScategories, ::oWScategories , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("websites", ::oWSwebsites, ::oWSwebsites , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("name", ::cname, ::cname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("description", ::cdescription, ::cdescription , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("short_description", ::cshort_description, ::cshort_description , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("weight", ::cweight, ::cweight , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("status", ::cstatus, ::cstatus , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("url_key", ::curl_key, ::curl_key , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("url_path", ::curl_path, ::curl_path , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("visibility", ::cvisibility, ::cvisibility , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("category_ids", ::oWScategory_ids, ::oWScategory_ids , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("website_ids", ::oWSwebsite_ids, ::oWSwebsite_ids , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("has_options", ::chas_options, ::chas_options , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("gift_message_available", ::cgift_message_available, ::cgift_message_available , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price", ::cprice, ::cprice , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("special_price", ::cspecial_price, ::cspecial_price , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("special_from_date", ::cspecial_from_date, ::cspecial_from_date , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("special_to_date", ::cspecial_to_date, ::cspecial_to_date , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("tax_class_id", ::ctax_class_id, ::ctax_class_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("tier_price", ::oWStier_price, ::oWStier_price , "catalogProductTierPriceEntityArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("meta_title", ::cmeta_title, ::cmeta_title , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("meta_keyword", ::cmeta_keyword, ::cmeta_keyword , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("meta_description", ::cmeta_description, ::cmeta_description , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_design", ::ccustom_design, ::ccustom_design , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("custom_layout_update", ::ccustom_layout_update, ::ccustom_layout_update , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("options_container", ::coptions_container, ::coptions_container , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("additional_attributes", ::oWSadditional_attributes, ::oWSadditional_attributes , "catalogProductAdditionalAttributesEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("stock_data", ::oWSstock_data, ::oWSstock_data , "catalogInventoryStockItemUpdateEntity", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogInventoryStockItemUpdateEntity

WSSTRUCT MagentoService_catalogInventoryStockItemUpdateEntity
	WSDATA   cqty                      AS string OPTIONAL
	WSDATA   nis_in_stock              AS int OPTIONAL
	WSDATA   nmanage_stock             AS int OPTIONAL
	WSDATA   nuse_config_manage_stock  AS int OPTIONAL
	WSDATA   nmin_qty                  AS int OPTIONAL
	WSDATA   nuse_config_min_qty       AS int OPTIONAL
	WSDATA   nmin_sale_qty             AS int OPTIONAL
	WSDATA   nuse_config_min_sale_qty  AS int OPTIONAL
	WSDATA   nmax_sale_qty             AS int OPTIONAL
	WSDATA   nuse_config_max_sale_qty  AS int OPTIONAL
	WSDATA   nis_qty_decimal           AS int OPTIONAL
	WSDATA   nbackorders               AS int OPTIONAL
	WSDATA   nuse_config_backorders    AS int OPTIONAL
	WSDATA   nnotify_stock_qty         AS int OPTIONAL
	WSDATA   nuse_config_notify_stock_qty AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntity
	Local oClone := MagentoService_catalogInventoryStockItemUpdateEntity():NEW()
	oClone:cqty                 := ::cqty
	oClone:nis_in_stock         := ::nis_in_stock
	oClone:nmanage_stock        := ::nmanage_stock
	oClone:nuse_config_manage_stock := ::nuse_config_manage_stock
	oClone:nmin_qty             := ::nmin_qty
	oClone:nuse_config_min_qty  := ::nuse_config_min_qty
	oClone:nmin_sale_qty        := ::nmin_sale_qty
	oClone:nuse_config_min_sale_qty := ::nuse_config_min_sale_qty
	oClone:nmax_sale_qty        := ::nmax_sale_qty
	oClone:nuse_config_max_sale_qty := ::nuse_config_max_sale_qty
	oClone:nis_qty_decimal      := ::nis_qty_decimal
	oClone:nbackorders          := ::nbackorders
	oClone:nuse_config_backorders := ::nuse_config_backorders
	oClone:nnotify_stock_qty    := ::nnotify_stock_qty
	oClone:nuse_config_notify_stock_qty := ::nuse_config_notify_stock_qty
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntity
	Local cSoap := ""
	cSoap += WSSoapValue("qty", ::cqty, ::cqty , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_in_stock", ::nis_in_stock, ::nis_in_stock , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("manage_stock", ::nmanage_stock, ::nmanage_stock , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("use_config_manage_stock", ::nuse_config_manage_stock, ::nuse_config_manage_stock , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("min_qty", ::nmin_qty, ::nmin_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("use_config_min_qty", ::nuse_config_min_qty, ::nuse_config_min_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("min_sale_qty", ::nmin_sale_qty, ::nmin_sale_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("use_config_min_sale_qty", ::nuse_config_min_sale_qty, ::nuse_config_min_sale_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("max_sale_qty", ::nmax_sale_qty, ::nmax_sale_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("use_config_max_sale_qty", ::nuse_config_max_sale_qty, ::nuse_config_max_sale_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_qty_decimal", ::nis_qty_decimal, ::nis_qty_decimal , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("backorders", ::nbackorders, ::nbackorders , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("use_config_backorders", ::nuse_config_backorders, ::nuse_config_backorders , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("notify_stock_qty", ::nnotify_stock_qty, ::nnotify_stock_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("use_config_notify_stock_qty", ::nuse_config_notify_stock_qty, ::nuse_config_notify_stock_qty , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductCreateEntityArray

WSSTRUCT MagentoService_catalogProductCreateEntityArray
	WSDATA   oWScatalogProductCreateEntity AS MagentoService_catalogProductCreateEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCreateEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCreateEntityArray
	::oWScatalogProductCreateEntity := {} // Array Of  MagentoService_CATALOGPRODUCTCREATEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCreateEntityArray
	Local oClone := MagentoService_catalogProductCreateEntityArray():NEW()
	oClone:oWScatalogProductCreateEntity := NIL
	If ::oWScatalogProductCreateEntity <> NIL
		oClone:oWScatalogProductCreateEntity := {}
		aEval( ::oWScatalogProductCreateEntity , { |x| aadd( oClone:oWScatalogProductCreateEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCreateEntityArray
	Local cSoap := ""
	aEval( ::oWScatalogProductCreateEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogProductCreateEntity", x , x , "catalogProductCreateEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure catalogProductSpecialPriceReturnEntity

WSSTRUCT MagentoService_catalogProductSpecialPriceReturnEntity
	WSDATA   cspecial_price            AS string
	WSDATA   cspecial_from_date        AS string
	WSDATA   cspecial_to_date          AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductSpecialPriceReturnEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductSpecialPriceReturnEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductSpecialPriceReturnEntity
	Local oClone := MagentoService_catalogProductSpecialPriceReturnEntity():NEW()
	oClone:cspecial_price       := ::cspecial_price
	oClone:cspecial_from_date   := ::cspecial_from_date
	oClone:cspecial_to_date     := ::cspecial_to_date
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductSpecialPriceReturnEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cspecial_price     :=  WSAdvValue( oResponse,"_SPECIAL_PRICE","string",NIL,"Property cspecial_price as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cspecial_from_date :=  WSAdvValue( oResponse,"_SPECIAL_FROM_DATE","string",NIL,"Property cspecial_from_date as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cspecial_to_date   :=  WSAdvValue( oResponse,"_SPECIAL_TO_DATE","string",NIL,"Property cspecial_to_date as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductAttributeSetEntityArray

WSSTRUCT MagentoService_catalogProductAttributeSetEntityArray
	WSDATA   oWScatalogProductAttributeSetEntity AS MagentoService_catalogProductAttributeSetEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeSetEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeSetEntityArray
	::oWScatalogProductAttributeSetEntity := {} // Array Of  MagentoService_CATALOGPRODUCTATTRIBUTESETENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeSetEntityArray
	Local oClone := MagentoService_catalogProductAttributeSetEntityArray():NEW()
	oClone:oWScatalogProductAttributeSetEntity := NIL
	If ::oWScatalogProductAttributeSetEntity <> NIL
		oClone:oWScatalogProductAttributeSetEntity := {}
		aEval( ::oWScatalogProductAttributeSetEntity , { |x| aadd( oClone:oWScatalogProductAttributeSetEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeSetEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductAttributeSetEntity , MagentoService_catalogProductAttributeSetEntity():New() )
			::oWScatalogProductAttributeSetEntity[len(::oWScatalogProductAttributeSetEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductAttributeSetEntity

WSSTRUCT MagentoService_catalogProductAttributeSetEntity
	WSDATA   nset_id                   AS int OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeSetEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeSetEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeSetEntity
	Local oClone := MagentoService_catalogProductAttributeSetEntity():NEW()
	oClone:nset_id              := ::nset_id
	oClone:cname                := ::cname
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeSetEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::nset_id            :=  WSAdvValue( oResponse,"_SET_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductAttributeEntityToCreate

WSSTRUCT MagentoService_catalogProductAttributeEntityToCreate
	WSDATA   cattribute_code           AS string
	WSDATA   cfrontend_input           AS string
	WSDATA   cscope                    AS string OPTIONAL
	WSDATA   cdefault_value            AS string OPTIONAL
	WSDATA   nis_unique                AS int OPTIONAL
	WSDATA   nis_required              AS int OPTIONAL
	WSDATA   oWSapply_to               AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   nis_configurable          AS int OPTIONAL
	WSDATA   nis_searchable            AS int OPTIONAL
	WSDATA   nis_visible_in_advanced_search AS int OPTIONAL
	WSDATA   nis_comparable            AS int OPTIONAL
	WSDATA   nis_used_for_promo_rules  AS int OPTIONAL
	WSDATA   nis_visible_on_front      AS int OPTIONAL
	WSDATA   nused_in_product_listing  AS int OPTIONAL
	WSDATA   oWSadditional_fields      AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSfrontend_label         AS MagentoService_catalogProductAttributeFrontendLabelArray
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeEntityToCreate
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeEntityToCreate
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeEntityToCreate
	Local oClone := MagentoService_catalogProductAttributeEntityToCreate():NEW()
	oClone:cattribute_code      := ::cattribute_code
	oClone:cfrontend_input      := ::cfrontend_input
	oClone:cscope               := ::cscope
	oClone:cdefault_value       := ::cdefault_value
	oClone:nis_unique           := ::nis_unique
	oClone:nis_required         := ::nis_required
	oClone:oWSapply_to          := IIF(::oWSapply_to = NIL , NIL , ::oWSapply_to:Clone() )
	oClone:nis_configurable     := ::nis_configurable
	oClone:nis_searchable       := ::nis_searchable
	oClone:nis_visible_in_advanced_search := ::nis_visible_in_advanced_search
	oClone:nis_comparable       := ::nis_comparable
	oClone:nis_used_for_promo_rules := ::nis_used_for_promo_rules
	oClone:nis_visible_on_front := ::nis_visible_on_front
	oClone:nused_in_product_listing := ::nused_in_product_listing
	oClone:oWSadditional_fields := IIF(::oWSadditional_fields = NIL , NIL , ::oWSadditional_fields:Clone() )
	oClone:oWSfrontend_label    := IIF(::oWSfrontend_label = NIL , NIL , ::oWSfrontend_label:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeEntityToCreate
	Local cSoap := ""
	cSoap += WSSoapValue("attribute_code", ::cattribute_code, ::cattribute_code , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("frontend_input", ::cfrontend_input, ::cfrontend_input , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("scope", ::cscope, ::cscope , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("default_value", ::cdefault_value, ::cdefault_value , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_unique", ::nis_unique, ::nis_unique , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_required", ::nis_required, ::nis_required , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("apply_to", ::oWSapply_to, ::oWSapply_to , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_configurable", ::nis_configurable, ::nis_configurable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_searchable", ::nis_searchable, ::nis_searchable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_visible_in_advanced_search", ::nis_visible_in_advanced_search, ::nis_visible_in_advanced_search , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_comparable", ::nis_comparable, ::nis_comparable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_used_for_promo_rules", ::nis_used_for_promo_rules, ::nis_used_for_promo_rules , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_visible_on_front", ::nis_visible_on_front, ::nis_visible_on_front , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("used_in_product_listing", ::nused_in_product_listing, ::nused_in_product_listing , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("additional_fields", ::oWSadditional_fields, ::oWSadditional_fields , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("frontend_label", ::oWSfrontend_label, ::oWSfrontend_label , "catalogProductAttributeFrontendLabelArray", .T. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductAttributeFrontendLabelArray

WSSTRUCT MagentoService_catalogProductAttributeFrontendLabelArray
	WSDATA   oWScatalogProductAttributeFrontendLabelEntity AS MagentoService_catalogProductAttributeFrontendLabelEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeFrontendLabelArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeFrontendLabelArray
	::oWScatalogProductAttributeFrontendLabelEntity := {} // Array Of  MagentoService_CATALOGPRODUCTATTRIBUTEFRONTENDLABELENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeFrontendLabelArray
	Local oClone := MagentoService_catalogProductAttributeFrontendLabelArray():NEW()
	oClone:oWScatalogProductAttributeFrontendLabelEntity := NIL
	If ::oWScatalogProductAttributeFrontendLabelEntity <> NIL
		oClone:oWScatalogProductAttributeFrontendLabelEntity := {}
		aEval( ::oWScatalogProductAttributeFrontendLabelEntity , { |x| aadd( oClone:oWScatalogProductAttributeFrontendLabelEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeFrontendLabelArray
	Local cSoap := ""
	aEval( ::oWScatalogProductAttributeFrontendLabelEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogProductAttributeFrontendLabelEntity", x , x , "catalogProductAttributeFrontendLabelEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeFrontendLabelArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductAttributeFrontendLabelEntity , MagentoService_catalogProductAttributeFrontendLabelEntity():New() )
			::oWScatalogProductAttributeFrontendLabelEntity[len(::oWScatalogProductAttributeFrontendLabelEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductAttributeEntity

WSSTRUCT MagentoService_catalogProductAttributeEntity
	WSDATA   cattribute_id             AS string
	WSDATA   cattribute_code           AS string
	WSDATA   cfrontend_input           AS string
	WSDATA   cscope                    AS string OPTIONAL
	WSDATA   cdefault_value            AS string OPTIONAL
	WSDATA   nis_unique                AS int OPTIONAL
	WSDATA   nis_required              AS int OPTIONAL
	WSDATA   oWSapply_to               AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   nis_configurable          AS int OPTIONAL
	WSDATA   nis_searchable            AS int OPTIONAL
	WSDATA   nis_visible_in_advanced_search AS int OPTIONAL
	WSDATA   nis_comparable            AS int OPTIONAL
	WSDATA   nis_used_for_promo_rules  AS int OPTIONAL
	WSDATA   nis_visible_on_front      AS int OPTIONAL
	WSDATA   nused_in_product_listing  AS int OPTIONAL
	WSDATA   oWSadditional_fields      AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSoptions                AS MagentoService_catalogAttributeOptionEntityArray OPTIONAL
	WSDATA   oWSfrontend_label         AS MagentoService_catalogProductAttributeFrontendLabelArray
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeEntity
	Local oClone := MagentoService_catalogProductAttributeEntity():NEW()
	oClone:cattribute_id        := ::cattribute_id
	oClone:cattribute_code      := ::cattribute_code
	oClone:cfrontend_input      := ::cfrontend_input
	oClone:cscope               := ::cscope
	oClone:cdefault_value       := ::cdefault_value
	oClone:nis_unique           := ::nis_unique
	oClone:nis_required         := ::nis_required
	oClone:oWSapply_to          := IIF(::oWSapply_to = NIL , NIL , ::oWSapply_to:Clone() )
	oClone:nis_configurable     := ::nis_configurable
	oClone:nis_searchable       := ::nis_searchable
	oClone:nis_visible_in_advanced_search := ::nis_visible_in_advanced_search
	oClone:nis_comparable       := ::nis_comparable
	oClone:nis_used_for_promo_rules := ::nis_used_for_promo_rules
	oClone:nis_visible_on_front := ::nis_visible_on_front
	oClone:nused_in_product_listing := ::nused_in_product_listing
	oClone:oWSadditional_fields := IIF(::oWSadditional_fields = NIL , NIL , ::oWSadditional_fields:Clone() )
	oClone:oWSoptions           := IIF(::oWSoptions = NIL , NIL , ::oWSoptions:Clone() )
	oClone:oWSfrontend_label    := IIF(::oWSfrontend_label = NIL , NIL , ::oWSfrontend_label:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeEntity
	Local oNode8
	Local oNode16
	Local oNode17
	Local oNode18
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cattribute_id      :=  WSAdvValue( oResponse,"_ATTRIBUTE_ID","string",NIL,"Property cattribute_id as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cattribute_code    :=  WSAdvValue( oResponse,"_ATTRIBUTE_CODE","string",NIL,"Property cattribute_code as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cfrontend_input    :=  WSAdvValue( oResponse,"_FRONTEND_INPUT","string",NIL,"Property cfrontend_input as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cscope             :=  WSAdvValue( oResponse,"_SCOPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdefault_value     :=  WSAdvValue( oResponse,"_DEFAULT_VALUE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_unique         :=  WSAdvValue( oResponse,"_IS_UNIQUE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_required       :=  WSAdvValue( oResponse,"_IS_REQUIRED","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode8 :=  WSAdvValue( oResponse,"_APPLY_TO","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode8 != NIL
		::oWSapply_to := MagentoService_ArrayOfString():New()
		::oWSapply_to:SoapRecv(oNode8)
	EndIf
	::nis_configurable   :=  WSAdvValue( oResponse,"_IS_CONFIGURABLE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_searchable     :=  WSAdvValue( oResponse,"_IS_SEARCHABLE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_visible_in_advanced_search :=  WSAdvValue( oResponse,"_IS_VISIBLE_IN_ADVANCED_SEARCH","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_comparable     :=  WSAdvValue( oResponse,"_IS_COMPARABLE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_used_for_promo_rules :=  WSAdvValue( oResponse,"_IS_USED_FOR_PROMO_RULES","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_visible_on_front :=  WSAdvValue( oResponse,"_IS_VISIBLE_ON_FRONT","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nused_in_product_listing :=  WSAdvValue( oResponse,"_USED_IN_PRODUCT_LISTING","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode16 :=  WSAdvValue( oResponse,"_ADDITIONAL_FIELDS","associativeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode16 != NIL
		::oWSadditional_fields := MagentoService_associativeArray():New()
		::oWSadditional_fields:SoapRecv(oNode16)
	EndIf
	oNode17 :=  WSAdvValue( oResponse,"_OPTIONS","catalogAttributeOptionEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode17 != NIL
		::oWSoptions := MagentoService_catalogAttributeOptionEntityArray():New()
		::oWSoptions:SoapRecv(oNode17)
	EndIf
	oNode18 :=  WSAdvValue( oResponse,"_FRONTEND_LABEL","catalogProductAttributeFrontendLabelArray",NIL,"Property oWSfrontend_label as typens:catalogProductAttributeFrontendLabelArray on SOAP Response not found.",NIL,"O",NIL,NIL)
	If oNode18 != NIL
		::oWSfrontend_label := MagentoService_catalogProductAttributeFrontendLabelArray():New()
		::oWSfrontend_label:SoapRecv(oNode18)
	EndIf
Return

// WSDL Data Structure catalogProductAttributeEntityToUpdate

WSSTRUCT MagentoService_catalogProductAttributeEntityToUpdate
	WSDATA   cscope                    AS string OPTIONAL
	WSDATA   cdefault_value            AS string OPTIONAL
	WSDATA   nis_unique                AS int OPTIONAL
	WSDATA   nis_required              AS int OPTIONAL
	WSDATA   oWSapply_to               AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   nis_configurable          AS int OPTIONAL
	WSDATA   nis_searchable            AS int OPTIONAL
	WSDATA   nis_visible_in_advanced_search AS int OPTIONAL
	WSDATA   nis_comparable            AS int OPTIONAL
	WSDATA   nis_used_for_promo_rules  AS int OPTIONAL
	WSDATA   nis_visible_on_front      AS int OPTIONAL
	WSDATA   nused_in_product_listing  AS int OPTIONAL
	WSDATA   oWSadditional_fields      AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSfrontend_label         AS MagentoService_catalogProductAttributeFrontendLabelArray
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeEntityToUpdate
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeEntityToUpdate
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeEntityToUpdate
	Local oClone := MagentoService_catalogProductAttributeEntityToUpdate():NEW()
	oClone:cscope               := ::cscope
	oClone:cdefault_value       := ::cdefault_value
	oClone:nis_unique           := ::nis_unique
	oClone:nis_required         := ::nis_required
	oClone:oWSapply_to          := IIF(::oWSapply_to = NIL , NIL , ::oWSapply_to:Clone() )
	oClone:nis_configurable     := ::nis_configurable
	oClone:nis_searchable       := ::nis_searchable
	oClone:nis_visible_in_advanced_search := ::nis_visible_in_advanced_search
	oClone:nis_comparable       := ::nis_comparable
	oClone:nis_used_for_promo_rules := ::nis_used_for_promo_rules
	oClone:nis_visible_on_front := ::nis_visible_on_front
	oClone:nused_in_product_listing := ::nused_in_product_listing
	oClone:oWSadditional_fields := IIF(::oWSadditional_fields = NIL , NIL , ::oWSadditional_fields:Clone() )
	oClone:oWSfrontend_label    := IIF(::oWSfrontend_label = NIL , NIL , ::oWSfrontend_label:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeEntityToUpdate
	Local cSoap := ""
	cSoap += WSSoapValue("scope", ::cscope, ::cscope , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("default_value", ::cdefault_value, ::cdefault_value , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_unique", ::nis_unique, ::nis_unique , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_required", ::nis_required, ::nis_required , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("apply_to", ::oWSapply_to, ::oWSapply_to , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_configurable", ::nis_configurable, ::nis_configurable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_searchable", ::nis_searchable, ::nis_searchable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_visible_in_advanced_search", ::nis_visible_in_advanced_search, ::nis_visible_in_advanced_search , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_comparable", ::nis_comparable, ::nis_comparable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_used_for_promo_rules", ::nis_used_for_promo_rules, ::nis_used_for_promo_rules , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_visible_on_front", ::nis_visible_on_front, ::nis_visible_on_front , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("used_in_product_listing", ::nused_in_product_listing, ::nused_in_product_listing , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("additional_fields", ::oWSadditional_fields, ::oWSadditional_fields , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("frontend_label", ::oWSfrontend_label, ::oWSfrontend_label , "catalogProductAttributeFrontendLabelArray", .T. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductAttributeOptionEntityToAdd

WSSTRUCT MagentoService_catalogProductAttributeOptionEntityToAdd
	WSDATA   oWSlabel                  AS MagentoService_catalogProductAttributeOptionLabelArray OPTIONAL
	WSDATA   norder                    AS int OPTIONAL
	WSDATA   nis_default               AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeOptionEntityToAdd
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeOptionEntityToAdd
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeOptionEntityToAdd
	Local oClone := MagentoService_catalogProductAttributeOptionEntityToAdd():NEW()
	oClone:oWSlabel             := IIF(::oWSlabel = NIL , NIL , ::oWSlabel:Clone() )
	oClone:norder               := ::norder
	oClone:nis_default          := ::nis_default
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeOptionEntityToAdd
	Local cSoap := ""
	cSoap += WSSoapValue("label", ::oWSlabel, ::oWSlabel , "catalogProductAttributeOptionLabelArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("order", ::norder, ::norder , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_default", ::nis_default, ::nis_default , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductAttributeOptionLabelArray

WSSTRUCT MagentoService_catalogProductAttributeOptionLabelArray
	WSDATA   oWScatalogProductAttributeOptionLabelEntity AS MagentoService_catalogProductAttributeOptionLabelEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeOptionLabelArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeOptionLabelArray
	::oWScatalogProductAttributeOptionLabelEntity := {} // Array Of  MagentoService_CATALOGPRODUCTATTRIBUTEOPTIONLABELENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeOptionLabelArray
	Local oClone := MagentoService_catalogProductAttributeOptionLabelArray():NEW()
	oClone:oWScatalogProductAttributeOptionLabelEntity := NIL
	If ::oWScatalogProductAttributeOptionLabelEntity <> NIL
		oClone:oWScatalogProductAttributeOptionLabelEntity := {}
		aEval( ::oWScatalogProductAttributeOptionLabelEntity , { |x| aadd( oClone:oWScatalogProductAttributeOptionLabelEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeOptionLabelArray
	Local cSoap := ""
	aEval( ::oWScatalogProductAttributeOptionLabelEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogProductAttributeOptionLabelEntity", x , x , "catalogProductAttributeOptionLabelEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure catalogProductTypeEntityArray

WSSTRUCT MagentoService_catalogProductTypeEntityArray
	WSDATA   oWScatalogProductTypeEntity AS MagentoService_catalogProductTypeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTypeEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTypeEntityArray
	::oWScatalogProductTypeEntity := {} // Array Of  MagentoService_CATALOGPRODUCTTYPEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTypeEntityArray
	Local oClone := MagentoService_catalogProductTypeEntityArray():NEW()
	oClone:oWScatalogProductTypeEntity := NIL
	If ::oWScatalogProductTypeEntity <> NIL
		oClone:oWScatalogProductTypeEntity := {}
		aEval( ::oWScatalogProductTypeEntity , { |x| aadd( oClone:oWScatalogProductTypeEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTypeEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductTypeEntity , MagentoService_catalogProductTypeEntity():New() )
			::oWScatalogProductTypeEntity[len(::oWScatalogProductTypeEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductTypeEntity

WSSTRUCT MagentoService_catalogProductTypeEntity
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   clabel                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTypeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTypeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTypeEntity
	Local oClone := MagentoService_catalogProductTypeEntity():NEW()
	oClone:ctype                := ::ctype
	oClone:clabel               := ::clabel
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTypeEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clabel             :=  WSAdvValue( oResponse,"_LABEL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductTierPriceEntity

WSSTRUCT MagentoService_catalogProductTierPriceEntity
	WSDATA   ccustomer_group_id        AS string OPTIONAL
	WSDATA   cwebsite                  AS string OPTIONAL
	WSDATA   nqty                      AS int OPTIONAL
	WSDATA   nprice                    AS double OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTierPriceEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTierPriceEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTierPriceEntity
	Local oClone := MagentoService_catalogProductTierPriceEntity():NEW()
	oClone:ccustomer_group_id   := ::ccustomer_group_id
	oClone:cwebsite             := ::cwebsite
	oClone:nqty                 := ::nqty
	oClone:nprice               := ::nprice
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductTierPriceEntity
	Local cSoap := ""
	cSoap += WSSoapValue("customer_group_id", ::ccustomer_group_id, ::ccustomer_group_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("website", ::cwebsite, ::cwebsite , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("qty", ::nqty, ::nqty , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price", ::nprice, ::nprice , "double", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTierPriceEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccustomer_group_id :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cwebsite           :=  WSAdvValue( oResponse,"_WEBSITE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nqty               :=  WSAdvValue( oResponse,"_QTY","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nprice             :=  WSAdvValue( oResponse,"_PRICE","double",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure catalogProductImageEntityArray

WSSTRUCT MagentoService_catalogProductImageEntityArray
	WSDATA   oWScatalogProductImageEntity AS MagentoService_catalogProductImageEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductImageEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductImageEntityArray
	::oWScatalogProductImageEntity := {} // Array Of  MagentoService_CATALOGPRODUCTIMAGEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductImageEntityArray
	Local oClone := MagentoService_catalogProductImageEntityArray():NEW()
	oClone:oWScatalogProductImageEntity := NIL
	If ::oWScatalogProductImageEntity <> NIL
		oClone:oWScatalogProductImageEntity := {}
		aEval( ::oWScatalogProductImageEntity , { |x| aadd( oClone:oWScatalogProductImageEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductImageEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductImageEntity , MagentoService_catalogProductImageEntity():New() )
			::oWScatalogProductImageEntity[len(::oWScatalogProductImageEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductImageEntity

WSSTRUCT MagentoService_catalogProductImageEntity
	WSDATA   cfile                     AS string OPTIONAL
	WSDATA   clabel                    AS string OPTIONAL
	WSDATA   cposition                 AS string OPTIONAL
	WSDATA   cexclude                  AS string OPTIONAL
	WSDATA   curl                      AS string OPTIONAL
	WSDATA   oWStypes                  AS MagentoService_ArrayOfString OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductImageEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductImageEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductImageEntity
	Local oClone := MagentoService_catalogProductImageEntity():NEW()
	oClone:cfile                := ::cfile
	oClone:clabel               := ::clabel
	oClone:cposition            := ::cposition
	oClone:cexclude             := ::cexclude
	oClone:curl                 := ::curl
	oClone:oWStypes             := IIF(::oWStypes = NIL , NIL , ::oWStypes:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductImageEntity
	Local oNode6
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cfile              :=  WSAdvValue( oResponse,"_FILE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clabel             :=  WSAdvValue( oResponse,"_LABEL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cposition          :=  WSAdvValue( oResponse,"_POSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cexclude           :=  WSAdvValue( oResponse,"_EXCLUDE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::curl               :=  WSAdvValue( oResponse,"_URL","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode6 :=  WSAdvValue( oResponse,"_TYPES","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode6 != NIL
		::oWStypes := MagentoService_ArrayOfString():New()
		::oWStypes:SoapRecv(oNode6)
	EndIf
Return

// WSDL Data Structure catalogProductAttributeMediaTypeEntityArray

WSSTRUCT MagentoService_catalogProductAttributeMediaTypeEntityArray
	WSDATA   oWScatalogProductAttributeMediaTypeEntity AS MagentoService_catalogProductAttributeMediaTypeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntityArray
	::oWScatalogProductAttributeMediaTypeEntity := {} // Array Of  MagentoService_CATALOGPRODUCTATTRIBUTEMEDIATYPEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntityArray
	Local oClone := MagentoService_catalogProductAttributeMediaTypeEntityArray():NEW()
	oClone:oWScatalogProductAttributeMediaTypeEntity := NIL
	If ::oWScatalogProductAttributeMediaTypeEntity <> NIL
		oClone:oWScatalogProductAttributeMediaTypeEntity := {}
		aEval( ::oWScatalogProductAttributeMediaTypeEntity , { |x| aadd( oClone:oWScatalogProductAttributeMediaTypeEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductAttributeMediaTypeEntity , MagentoService_catalogProductAttributeMediaTypeEntity():New() )
			::oWScatalogProductAttributeMediaTypeEntity[len(::oWScatalogProductAttributeMediaTypeEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductAttributeMediaTypeEntity

WSSTRUCT MagentoService_catalogProductAttributeMediaTypeEntity
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   cscope                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntity
	Local oClone := MagentoService_catalogProductAttributeMediaTypeEntity():NEW()
	oClone:ccode                := ::ccode
	oClone:cscope               := ::cscope
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeMediaTypeEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cscope             :=  WSAdvValue( oResponse,"_SCOPE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductAttributeMediaCreateEntity

WSSTRUCT MagentoService_catalogProductAttributeMediaCreateEntity
	WSDATA   oWSfile                   AS MagentoService_catalogProductImageFileEntity OPTIONAL
	WSDATA   clabel                    AS string OPTIONAL
	WSDATA   cposition                 AS string OPTIONAL
	WSDATA   oWStypes                  AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   cexclude                  AS string OPTIONAL
	WSDATA   cremove                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeMediaCreateEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeMediaCreateEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeMediaCreateEntity
	Local oClone := MagentoService_catalogProductAttributeMediaCreateEntity():NEW()
	oClone:oWSfile              := IIF(::oWSfile = NIL , NIL , ::oWSfile:Clone() )
	oClone:clabel               := ::clabel
	oClone:cposition            := ::cposition
	oClone:oWStypes             := IIF(::oWStypes = NIL , NIL , ::oWStypes:Clone() )
	oClone:cexclude             := ::cexclude
	oClone:cremove              := ::cremove
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeMediaCreateEntity
	Local cSoap := ""
	cSoap += WSSoapValue("file", ::oWSfile, ::oWSfile , "catalogProductImageFileEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("label", ::clabel, ::clabel , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("position", ::cposition, ::cposition , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("types", ::oWStypes, ::oWStypes , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("exclude", ::cexclude, ::cexclude , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("remove", ::cremove, ::cremove , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductLinkEntityArray

WSSTRUCT MagentoService_catalogProductLinkEntityArray
	WSDATA   oWScatalogProductLinkEntity AS MagentoService_catalogProductLinkEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductLinkEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductLinkEntityArray
	::oWScatalogProductLinkEntity := {} // Array Of  MagentoService_CATALOGPRODUCTLINKENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductLinkEntityArray
	Local oClone := MagentoService_catalogProductLinkEntityArray():NEW()
	oClone:oWScatalogProductLinkEntity := NIL
	If ::oWScatalogProductLinkEntity <> NIL
		oClone:oWScatalogProductLinkEntity := {}
		aEval( ::oWScatalogProductLinkEntity , { |x| aadd( oClone:oWScatalogProductLinkEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductLinkEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductLinkEntity , MagentoService_catalogProductLinkEntity():New() )
			::oWScatalogProductLinkEntity[len(::oWScatalogProductLinkEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductLinkEntity

WSSTRUCT MagentoService_catalogProductLinkEntity
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   cset                      AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cposition                 AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductLinkEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductLinkEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductLinkEntity
	Local oClone := MagentoService_catalogProductLinkEntity():NEW()
	oClone:cproduct_id          := ::cproduct_id
	oClone:ctype                := ::ctype
	oClone:cset                 := ::cset
	oClone:csku                 := ::csku
	oClone:cposition            := ::cposition
	oClone:cqty                 := ::cqty
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductLinkEntity
	Local cSoap := ""
	cSoap += WSSoapValue("product_id", ::cproduct_id, ::cproduct_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ::ctype , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("set", ::cset, ::cset , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("position", ::cposition, ::cposition , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("qty", ::cqty, ::cqty , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductLinkEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cset               :=  WSAdvValue( oResponse,"_SET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cposition          :=  WSAdvValue( oResponse,"_POSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty               :=  WSAdvValue( oResponse,"_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductLinkAttributeEntityArray

WSSTRUCT MagentoService_catalogProductLinkAttributeEntityArray
	WSDATA   oWScatalogProductLinkAttributeEntity AS MagentoService_catalogProductLinkAttributeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductLinkAttributeEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductLinkAttributeEntityArray
	::oWScatalogProductLinkAttributeEntity := {} // Array Of  MagentoService_CATALOGPRODUCTLINKATTRIBUTEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductLinkAttributeEntityArray
	Local oClone := MagentoService_catalogProductLinkAttributeEntityArray():NEW()
	oClone:oWScatalogProductLinkAttributeEntity := NIL
	If ::oWScatalogProductLinkAttributeEntity <> NIL
		oClone:oWScatalogProductLinkAttributeEntity := {}
		aEval( ::oWScatalogProductLinkAttributeEntity , { |x| aadd( oClone:oWScatalogProductLinkAttributeEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductLinkAttributeEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductLinkAttributeEntity , MagentoService_catalogProductLinkAttributeEntity():New() )
			::oWScatalogProductLinkAttributeEntity[len(::oWScatalogProductLinkAttributeEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductLinkAttributeEntity

WSSTRUCT MagentoService_catalogProductLinkAttributeEntity
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductLinkAttributeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductLinkAttributeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductLinkAttributeEntity
	Local oClone := MagentoService_catalogProductLinkAttributeEntity():NEW()
	oClone:ccode                := ::ccode
	oClone:ctype                := ::ctype
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductLinkAttributeEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductCustomOptionToAdd

WSSTRUCT MagentoService_catalogProductCustomOptionToAdd
	WSDATA   ctitle                    AS string
	WSDATA   ctype                     AS string
	WSDATA   csort_order               AS string OPTIONAL
	WSDATA   nis_require               AS int OPTIONAL
	WSDATA   oWSadditional_fields      AS MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionToAdd
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionToAdd
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionToAdd
	Local oClone := MagentoService_catalogProductCustomOptionToAdd():NEW()
	oClone:ctitle               := ::ctitle
	oClone:ctype                := ::ctype
	oClone:csort_order          := ::csort_order
	oClone:nis_require          := ::nis_require
	oClone:oWSadditional_fields := IIF(::oWSadditional_fields = NIL , NIL , ::oWSadditional_fields:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionToAdd
	Local cSoap := ""
	cSoap += WSSoapValue("title", ::ctitle, ::ctitle , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ::ctype , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sort_order", ::csort_order, ::csort_order , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_require", ::nis_require, ::nis_require , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("additional_fields", ::oWSadditional_fields, ::oWSadditional_fields , "catalogProductCustomOptionAdditionalFieldsArray", .T. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductCustomOptionToUpdate

WSSTRUCT MagentoService_catalogProductCustomOptionToUpdate
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   csort_order               AS string OPTIONAL
	WSDATA   nis_require               AS int OPTIONAL
	WSDATA   oWSadditional_fields      AS MagentoService_catalogProductCustomOptionAdditionalFieldsArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionToUpdate
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionToUpdate
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionToUpdate
	Local oClone := MagentoService_catalogProductCustomOptionToUpdate():NEW()
	oClone:ctitle               := ::ctitle
	oClone:ctype                := ::ctype
	oClone:csort_order          := ::csort_order
	oClone:nis_require          := ::nis_require
	oClone:oWSadditional_fields := IIF(::oWSadditional_fields = NIL , NIL , ::oWSadditional_fields:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionToUpdate
	Local cSoap := ""
	cSoap += WSSoapValue("title", ::ctitle, ::ctitle , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ::ctype , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sort_order", ::csort_order, ::csort_order , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_require", ::nis_require, ::nis_require , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("additional_fields", ::oWSadditional_fields, ::oWSadditional_fields , "catalogProductCustomOptionAdditionalFieldsArray", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductCustomOptionTypesArray

WSSTRUCT MagentoService_catalogProductCustomOptionTypesArray
	WSDATA   oWScatalogProductCustomOptionTypesEntity AS MagentoService_catalogProductCustomOptionTypesEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionTypesArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionTypesArray
	::oWScatalogProductCustomOptionTypesEntity := {} // Array Of  MagentoService_CATALOGPRODUCTCUSTOMOPTIONTYPESENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionTypesArray
	Local oClone := MagentoService_catalogProductCustomOptionTypesArray():NEW()
	oClone:oWScatalogProductCustomOptionTypesEntity := NIL
	If ::oWScatalogProductCustomOptionTypesEntity <> NIL
		oClone:oWScatalogProductCustomOptionTypesEntity := {}
		aEval( ::oWScatalogProductCustomOptionTypesEntity , { |x| aadd( oClone:oWScatalogProductCustomOptionTypesEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionTypesArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductCustomOptionTypesEntity , MagentoService_catalogProductCustomOptionTypesEntity():New() )
			::oWScatalogProductCustomOptionTypesEntity[len(::oWScatalogProductCustomOptionTypesEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductCustomOptionTypesEntity

WSSTRUCT MagentoService_catalogProductCustomOptionTypesEntity
	WSDATA   clabel                    AS string OPTIONAL
	WSDATA   cvalue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionTypesEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionTypesEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionTypesEntity
	Local oClone := MagentoService_catalogProductCustomOptionTypesEntity():NEW()
	oClone:clabel               := ::clabel
	oClone:cvalue               := ::cvalue
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionTypesEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::clabel             :=  WSAdvValue( oResponse,"_LABEL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cvalue             :=  WSAdvValue( oResponse,"_VALUE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductCustomOptionInfoEntity

WSSTRUCT MagentoService_catalogProductCustomOptionInfoEntity
	WSDATA   ctitle                    AS string
	WSDATA   ctype                     AS string
	WSDATA   csort_order               AS string
	WSDATA   nis_require               AS int
	WSDATA   oWSadditional_fields      AS MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionInfoEntity
	Local oClone := MagentoService_catalogProductCustomOptionInfoEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:ctype                := ::ctype
	oClone:csort_order          := ::csort_order
	oClone:nis_require          := ::nis_require
	oClone:oWSadditional_fields := IIF(::oWSadditional_fields = NIL , NIL , ::oWSadditional_fields:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionInfoEntity
	Local oNode5
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,"Property ctitle as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,"Property ctype as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::csort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","string",NIL,"Property csort_order as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::nis_require        :=  WSAdvValue( oResponse,"_IS_REQUIRE","int",NIL,"Property nis_require as xsd:int on SOAP Response not found.",NIL,"N",NIL,NIL)
	oNode5 :=  WSAdvValue( oResponse,"_ADDITIONAL_FIELDS","catalogProductCustomOptionAdditionalFieldsArray",NIL,"Property oWSadditional_fields as typens:catalogProductCustomOptionAdditionalFieldsArray on SOAP Response not found.",NIL,"O",NIL,NIL)
	If oNode5 != NIL
		::oWSadditional_fields := MagentoService_catalogProductCustomOptionAdditionalFieldsArray():New()
		::oWSadditional_fields:SoapRecv(oNode5)
	EndIf
Return

// WSDL Data Structure catalogProductCustomOptionListArray

WSSTRUCT MagentoService_catalogProductCustomOptionListArray
	WSDATA   oWScatalogProductCustomOptionListEntity AS MagentoService_catalogProductCustomOptionListEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionListArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionListArray
	::oWScatalogProductCustomOptionListEntity := {} // Array Of  MagentoService_CATALOGPRODUCTCUSTOMOPTIONLISTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionListArray
	Local oClone := MagentoService_catalogProductCustomOptionListArray():NEW()
	oClone:oWScatalogProductCustomOptionListEntity := NIL
	If ::oWScatalogProductCustomOptionListEntity <> NIL
		oClone:oWScatalogProductCustomOptionListEntity := {}
		aEval( ::oWScatalogProductCustomOptionListEntity , { |x| aadd( oClone:oWScatalogProductCustomOptionListEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionListArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductCustomOptionListEntity , MagentoService_catalogProductCustomOptionListEntity():New() )
			::oWScatalogProductCustomOptionListEntity[len(::oWScatalogProductCustomOptionListEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductCustomOptionListEntity

WSSTRUCT MagentoService_catalogProductCustomOptionListEntity
	WSDATA   coption_id                AS string
	WSDATA   ctitle                    AS string
	WSDATA   ctype                     AS string
	WSDATA   csort_order               AS string
	WSDATA   nis_require               AS int
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionListEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionListEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionListEntity
	Local oClone := MagentoService_catalogProductCustomOptionListEntity():NEW()
	oClone:coption_id           := ::coption_id
	oClone:ctitle               := ::ctitle
	oClone:ctype                := ::ctype
	oClone:csort_order          := ::csort_order
	oClone:nis_require          := ::nis_require
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionListEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::coption_id         :=  WSAdvValue( oResponse,"_OPTION_ID","string",NIL,"Property coption_id as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,"Property ctitle as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::ctype              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,"Property ctype as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::csort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","string",NIL,"Property csort_order as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::nis_require        :=  WSAdvValue( oResponse,"_IS_REQUIRE","int",NIL,"Property nis_require as xsd:int on SOAP Response not found.",NIL,"N",NIL,NIL)
Return

// WSDL Data Structure catalogProductCustomOptionValueInfoEntity

WSSTRUCT MagentoService_catalogProductCustomOptionValueInfoEntity
	WSDATA   cvalue_id                 AS string
	WSDATA   coption_id                AS string
	WSDATA   csku                      AS string
	WSDATA   csort_order               AS string
	WSDATA   cdefault_price            AS string
	WSDATA   cdefault_price_type       AS string
	WSDATA   cstore_price              AS string
	WSDATA   cstore_price_type         AS string
	WSDATA   cprice                    AS string
	WSDATA   cprice_type               AS string
	WSDATA   cdefault_title            AS string
	WSDATA   cstore_title              AS string
	WSDATA   ctitle                    AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionValueInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionValueInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionValueInfoEntity
	Local oClone := MagentoService_catalogProductCustomOptionValueInfoEntity():NEW()
	oClone:cvalue_id            := ::cvalue_id
	oClone:coption_id           := ::coption_id
	oClone:csku                 := ::csku
	oClone:csort_order          := ::csort_order
	oClone:cdefault_price       := ::cdefault_price
	oClone:cdefault_price_type  := ::cdefault_price_type
	oClone:cstore_price         := ::cstore_price
	oClone:cstore_price_type    := ::cstore_price_type
	oClone:cprice               := ::cprice
	oClone:cprice_type          := ::cprice_type
	oClone:cdefault_title       := ::cdefault_title
	oClone:cstore_title         := ::cstore_title
	oClone:ctitle               := ::ctitle
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionValueInfoEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cvalue_id          :=  WSAdvValue( oResponse,"_VALUE_ID","string",NIL,"Property cvalue_id as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::coption_id         :=  WSAdvValue( oResponse,"_OPTION_ID","string",NIL,"Property coption_id as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,"Property csku as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::csort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","string",NIL,"Property csort_order as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cdefault_price     :=  WSAdvValue( oResponse,"_DEFAULT_PRICE","string",NIL,"Property cdefault_price as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cdefault_price_type :=  WSAdvValue( oResponse,"_DEFAULT_PRICE_TYPE","string",NIL,"Property cdefault_price_type as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cstore_price       :=  WSAdvValue( oResponse,"_STORE_PRICE","string",NIL,"Property cstore_price as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cstore_price_type  :=  WSAdvValue( oResponse,"_STORE_PRICE_TYPE","string",NIL,"Property cstore_price_type as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,"Property cprice as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cprice_type        :=  WSAdvValue( oResponse,"_PRICE_TYPE","string",NIL,"Property cprice_type as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cdefault_title     :=  WSAdvValue( oResponse,"_DEFAULT_TITLE","string",NIL,"Property cdefault_title as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cstore_title       :=  WSAdvValue( oResponse,"_STORE_TITLE","string",NIL,"Property cstore_title as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,"Property ctitle as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductCustomOptionValueListArray

WSSTRUCT MagentoService_catalogProductCustomOptionValueListArray
	WSDATA   oWScatalogProductCustomOptionValueListEntity AS MagentoService_catalogProductCustomOptionValueListEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionValueListArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionValueListArray
	::oWScatalogProductCustomOptionValueListEntity := {} // Array Of  MagentoService_CATALOGPRODUCTCUSTOMOPTIONVALUELISTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionValueListArray
	Local oClone := MagentoService_catalogProductCustomOptionValueListArray():NEW()
	oClone:oWScatalogProductCustomOptionValueListEntity := NIL
	If ::oWScatalogProductCustomOptionValueListEntity <> NIL
		oClone:oWScatalogProductCustomOptionValueListEntity := {}
		aEval( ::oWScatalogProductCustomOptionValueListEntity , { |x| aadd( oClone:oWScatalogProductCustomOptionValueListEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionValueListArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductCustomOptionValueListEntity , MagentoService_catalogProductCustomOptionValueListEntity():New() )
			::oWScatalogProductCustomOptionValueListEntity[len(::oWScatalogProductCustomOptionValueListEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductCustomOptionValueListEntity

WSSTRUCT MagentoService_catalogProductCustomOptionValueListEntity
	WSDATA   cvalue_id                 AS string
	WSDATA   ctitle                    AS string
	WSDATA   cprice                    AS string
	WSDATA   cprice_type               AS string
	WSDATA   csku                      AS string
	WSDATA   csort_order               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionValueListEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionValueListEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionValueListEntity
	Local oClone := MagentoService_catalogProductCustomOptionValueListEntity():NEW()
	oClone:cvalue_id            := ::cvalue_id
	oClone:ctitle               := ::ctitle
	oClone:cprice               := ::cprice
	oClone:cprice_type          := ::cprice_type
	oClone:csku                 := ::csku
	oClone:csort_order          := ::csort_order
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionValueListEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cvalue_id          :=  WSAdvValue( oResponse,"_VALUE_ID","string",NIL,"Property cvalue_id as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,"Property ctitle as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,"Property cprice as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cprice_type        :=  WSAdvValue( oResponse,"_PRICE_TYPE","string",NIL,"Property cprice_type as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,"Property csku as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::csort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","string",NIL,"Property csort_order as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductCustomOptionValueAddArray

WSSTRUCT MagentoService_catalogProductCustomOptionValueAddArray
	WSDATA   oWScatalogProductCustomOptionValueAddEntity AS MagentoService_catalogProductCustomOptionValueAddEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionValueAddArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionValueAddArray
	::oWScatalogProductCustomOptionValueAddEntity := {} // Array Of  MagentoService_CATALOGPRODUCTCUSTOMOPTIONVALUEADDENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionValueAddArray
	Local oClone := MagentoService_catalogProductCustomOptionValueAddArray():NEW()
	oClone:oWScatalogProductCustomOptionValueAddEntity := NIL
	If ::oWScatalogProductCustomOptionValueAddEntity <> NIL
		oClone:oWScatalogProductCustomOptionValueAddEntity := {}
		aEval( ::oWScatalogProductCustomOptionValueAddEntity , { |x| aadd( oClone:oWScatalogProductCustomOptionValueAddEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionValueAddArray
	Local cSoap := ""
	aEval( ::oWScatalogProductCustomOptionValueAddEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogProductCustomOptionValueAddEntity", x , x , "catalogProductCustomOptionValueAddEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure catalogProductCustomOptionValueAddEntity

WSSTRUCT MagentoService_catalogProductCustomOptionValueAddEntity
	WSDATA   ctitle                    AS string
	WSDATA   cprice                    AS string
	WSDATA   cprice_type               AS string
	WSDATA   csku                      AS string
	WSDATA   csort_order               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionValueAddEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionValueAddEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionValueAddEntity
	Local oClone := MagentoService_catalogProductCustomOptionValueAddEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:cprice               := ::cprice
	oClone:cprice_type          := ::cprice_type
	oClone:csku                 := ::csku
	oClone:csort_order          := ::csort_order
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionValueAddEntity
	Local cSoap := ""
	cSoap += WSSoapValue("title", ::ctitle, ::ctitle , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price", ::cprice, ::cprice , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price_type", ::cprice_type, ::cprice_type , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sort_order", ::csort_order, ::csort_order , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductCustomOptionValueUpdateEntity

WSSTRUCT MagentoService_catalogProductCustomOptionValueUpdateEntity
	WSDATA   ctitle                    AS string
	WSDATA   cprice                    AS string
	WSDATA   cprice_type               AS string
	WSDATA   csku                      AS string
	WSDATA   csort_order               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionValueUpdateEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionValueUpdateEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionValueUpdateEntity
	Local oClone := MagentoService_catalogProductCustomOptionValueUpdateEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:cprice               := ::cprice
	oClone:cprice_type          := ::cprice_type
	oClone:csku                 := ::csku
	oClone:csort_order          := ::csort_order
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionValueUpdateEntity
	Local cSoap := ""
	cSoap += WSSoapValue("title", ::ctitle, ::ctitle , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price", ::cprice, ::cprice , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price_type", ::cprice_type, ::cprice_type , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sort_order", ::csort_order, ::csort_order , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure salesOrderListEntityArray

WSSTRUCT MagentoService_salesOrderListEntityArray
	WSDATA   oWSsalesOrderListEntity   AS MagentoService_salesOrderListEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderListEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderListEntityArray
	::oWSsalesOrderListEntity := {} // Array Of  MagentoService_SALESORDERLISTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderListEntityArray
	Local oClone := MagentoService_salesOrderListEntityArray():NEW()
	oClone:oWSsalesOrderListEntity := NIL
	If ::oWSsalesOrderListEntity <> NIL
		oClone:oWSsalesOrderListEntity := {}
		aEval( ::oWSsalesOrderListEntity , { |x| aadd( oClone:oWSsalesOrderListEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderListEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderListEntity , MagentoService_salesOrderListEntity():New() )
			::oWSsalesOrderListEntity[len(::oWSsalesOrderListEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderListEntity

WSSTRUCT MagentoService_salesOrderListEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   ccustomer_id              AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   csubtotal                 AS string OPTIONAL
	WSDATA   cgrand_total              AS string OPTIONAL
	WSDATA   ctotal_paid               AS string OPTIONAL
	WSDATA   ctotal_refunded           AS string OPTIONAL
	WSDATA   ctotal_qty_ordered        AS string OPTIONAL
	WSDATA   ctotal_canceled           AS string OPTIONAL
	WSDATA   ctotal_invoiced           AS string OPTIONAL
	WSDATA   ctotal_online_refunded    AS string OPTIONAL
	WSDATA   ctotal_offline_refunded   AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cbase_shipping_amount     AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cbase_subtotal            AS string OPTIONAL
	WSDATA   cbase_grand_total         AS string OPTIONAL
	WSDATA   cbase_total_paid          AS string OPTIONAL
	WSDATA   cbase_total_refunded      AS string OPTIONAL
	WSDATA   cbase_total_qty_ordered   AS string OPTIONAL
	WSDATA   cbase_total_canceled      AS string OPTIONAL
	WSDATA   cbase_total_invoiced      AS string OPTIONAL
	WSDATA   cbase_total_online_refunded AS string OPTIONAL
	WSDATA   cbase_total_offline_refunded AS string OPTIONAL
	WSDATA   cbilling_address_id       AS string OPTIONAL
	WSDATA   cbilling_firstname        AS string OPTIONAL
	WSDATA   cbilling_lastname         AS string OPTIONAL
	WSDATA   cshipping_address_id      AS string OPTIONAL
	WSDATA   cshipping_firstname       AS string OPTIONAL
	WSDATA   cshipping_lastname        AS string OPTIONAL
	WSDATA   cbilling_name             AS string OPTIONAL
	WSDATA   cshipping_name            AS string OPTIONAL
	WSDATA   cstore_to_base_rate       AS string OPTIONAL
	WSDATA   cstore_to_order_rate      AS string OPTIONAL
	WSDATA   cbase_to_global_rate      AS string OPTIONAL
	WSDATA   cbase_to_order_rate       AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cstore_name               AS string OPTIONAL
	WSDATA   cremote_ip                AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   cstate                    AS string OPTIONAL
	WSDATA   capplied_rule_ids         AS string OPTIONAL
	WSDATA   cglobal_currency_code     AS string OPTIONAL
	WSDATA   cbase_currency_code       AS string OPTIONAL
	WSDATA   cstore_currency_code      AS string OPTIONAL
	WSDATA   corder_currency_code      AS string OPTIONAL
	WSDATA   cshipping_method          AS string OPTIONAL
	WSDATA   cshipping_description     AS string OPTIONAL
	WSDATA   ccustomer_email           AS string OPTIONAL
	WSDATA   ccustomer_firstname       AS string OPTIONAL
	WSDATA   ccustomer_lastname        AS string OPTIONAL
	WSDATA   ccustomer_taxvat          AS string OPTIONAL
	WSDATA   cquote_id                 AS string OPTIONAL
	WSDATA   cis_virtual               AS string OPTIONAL
	WSDATA   ccustomer_group_id        AS string OPTIONAL
	WSDATA   ccustomer_note_notify     AS string OPTIONAL
	WSDATA   ccustomer_is_guest        AS string OPTIONAL
	WSDATA   cemail_sent               AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   cgift_message_id          AS string OPTIONAL
	WSDATA   ccoupon_code              AS string OPTIONAL
	WSDATA   cprotect_code             AS string OPTIONAL
	WSDATA   cbase_discount_canceled   AS string OPTIONAL
	WSDATA   cbase_discount_invoiced   AS string OPTIONAL
	WSDATA   cbase_discount_refunded   AS string OPTIONAL
	WSDATA   cbase_shipping_canceled   AS string OPTIONAL
	WSDATA   cbase_shipping_invoiced   AS string OPTIONAL
	WSDATA   cbase_shipping_refunded   AS string OPTIONAL
	WSDATA   cbase_shipping_tax_amount AS string OPTIONAL
	WSDATA   cbase_shipping_tax_refunded AS string OPTIONAL
	WSDATA   cbase_subtotal_canceled   AS string OPTIONAL
	WSDATA   cbase_subtotal_invoiced   AS string OPTIONAL
	WSDATA   cbase_subtotal_refunded   AS string OPTIONAL
	WSDATA   cbase_tax_canceled        AS string OPTIONAL
	WSDATA   cbase_tax_invoiced        AS string OPTIONAL
	WSDATA   cbase_tax_refunded        AS string OPTIONAL
	WSDATA   cbase_total_invoiced_cost AS string OPTIONAL
	WSDATA   cdiscount_canceled        AS string OPTIONAL
	WSDATA   cdiscount_invoiced        AS string OPTIONAL
	WSDATA   cdiscount_refunded        AS string OPTIONAL
	WSDATA   cshipping_canceled        AS string OPTIONAL
	WSDATA   cshipping_invoiced        AS string OPTIONAL
	WSDATA   cshipping_refunded        AS string OPTIONAL
	WSDATA   cshipping_tax_amount      AS string OPTIONAL
	WSDATA   cshipping_tax_refunded    AS string OPTIONAL
	WSDATA   csubtotal_canceled        AS string OPTIONAL
	WSDATA   csubtotal_invoiced        AS string OPTIONAL
	WSDATA   csubtotal_refunded        AS string OPTIONAL
	WSDATA   ctax_canceled             AS string OPTIONAL
	WSDATA   ctax_invoiced             AS string OPTIONAL
	WSDATA   ctax_refunded             AS string OPTIONAL
	WSDATA   ccan_ship_partially       AS string OPTIONAL
	WSDATA   ccan_ship_partially_item  AS string OPTIONAL
	WSDATA   cedit_increment           AS string OPTIONAL
	WSDATA   cforced_do_shipment_with_invoice AS string OPTIONAL
	WSDATA   cpayment_authorization_expiration AS string OPTIONAL
	WSDATA   cpaypal_ipn_customer_notified AS string OPTIONAL
	WSDATA   cquote_address_id         AS string OPTIONAL
	WSDATA   cadjustment_negative      AS string OPTIONAL
	WSDATA   cadjustment_positive      AS string OPTIONAL
	WSDATA   cbase_adjustment_negative AS string OPTIONAL
	WSDATA   cbase_adjustment_positive AS string OPTIONAL
	WSDATA   cbase_shipping_discount_amount AS string OPTIONAL
	WSDATA   cbase_subtotal_incl_tax   AS string OPTIONAL
	WSDATA   cbase_total_due           AS string OPTIONAL
	WSDATA   cpayment_authorization_amount AS string OPTIONAL
	WSDATA   cshipping_discount_amount AS string OPTIONAL
	WSDATA   csubtotal_incl_tax        AS string OPTIONAL
	WSDATA   ctotal_due                AS string OPTIONAL
	WSDATA   ccustomer_dob             AS string OPTIONAL
	WSDATA   ccustomer_middlename      AS string OPTIONAL
	WSDATA   ccustomer_prefix          AS string OPTIONAL
	WSDATA   ccustomer_suffix          AS string OPTIONAL
	WSDATA   cdiscount_description     AS string OPTIONAL
	WSDATA   cext_customer_id          AS string OPTIONAL
	WSDATA   cext_order_id             AS string OPTIONAL
	WSDATA   chold_before_state        AS string OPTIONAL
	WSDATA   chold_before_status       AS string OPTIONAL
	WSDATA   coriginal_increment_id    AS string OPTIONAL
	WSDATA   crelation_child_id        AS string OPTIONAL
	WSDATA   crelation_child_real_id   AS string OPTIONAL
	WSDATA   crelation_parent_id       AS string OPTIONAL
	WSDATA   crelation_parent_real_id  AS string OPTIONAL
	WSDATA   cx_forwarded_for          AS string OPTIONAL
	WSDATA   ccustomer_note            AS string OPTIONAL
	WSDATA   ctotal_item_count         AS string OPTIONAL
	WSDATA   ccustomer_gender          AS string OPTIONAL
	WSDATA   chidden_tax_amount        AS string OPTIONAL
	WSDATA   cbase_hidden_tax_amount   AS string OPTIONAL
	WSDATA   cshipping_hidden_tax_amount AS string OPTIONAL
	WSDATA   cbase_shipping_hidden_tax_amount AS string OPTIONAL
	WSDATA   chidden_tax_invoiced      AS string OPTIONAL
	WSDATA   cbase_hidden_tax_invoiced AS string OPTIONAL
	WSDATA   chidden_tax_refunded      AS string OPTIONAL
	WSDATA   cbase_hidden_tax_refunded AS string OPTIONAL
	WSDATA   cshipping_incl_tax        AS string OPTIONAL
	WSDATA   cbase_shipping_incl_tax   AS string OPTIONAL
	WSDATA   cbase_customer_balance_amount AS string OPTIONAL
	WSDATA   ccustomer_balance_amount  AS string OPTIONAL
	WSDATA   cbase_customer_balance_invoiced AS string OPTIONAL
	WSDATA   ccustomer_balance_invoiced AS string OPTIONAL
	WSDATA   cbase_customer_balance_refunded AS string OPTIONAL
	WSDATA   ccustomer_balance_refunded AS string OPTIONAL
	WSDATA   cbase_customer_balance_total_refunded AS string OPTIONAL
	WSDATA   ccustomer_balance_total_refunded AS string OPTIONAL
	WSDATA   cgift_cards               AS string OPTIONAL
	WSDATA   cbase_gift_cards_amount   AS string OPTIONAL
	WSDATA   cgift_cards_amount        AS string OPTIONAL
	WSDATA   cbase_gift_cards_invoiced AS string OPTIONAL
	WSDATA   cgift_cards_invoiced      AS string OPTIONAL
	WSDATA   cbase_gift_cards_refunded AS string OPTIONAL
	WSDATA   cgift_cards_refunded      AS string OPTIONAL
	WSDATA   creward_points_balance    AS string OPTIONAL
	WSDATA   cbase_reward_currency_amount AS string OPTIONAL
	WSDATA   creward_currency_amount   AS string OPTIONAL
	WSDATA   cbase_reward_currency_amount_invoiced AS string OPTIONAL
	WSDATA   creward_currency_amount_invoiced AS string OPTIONAL
	WSDATA   cbase_reward_currency_amount_refunded AS string OPTIONAL
	WSDATA   creward_currency_amount_refunded AS string OPTIONAL
	WSDATA   creward_points_balance_refunded AS string OPTIONAL
	WSDATA   creward_points_balance_to_refund AS string OPTIONAL
	WSDATA   creward_salesrule_points  AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   caffiliate_id             AS string OPTIONAL
	WSDATA   caffiliate_name           AS string OPTIONAL
	WSDATA   lbseller_skyhub           AS boolean OPTIONAL
	WSDATA   cbseller_skyhub_code      AS string OPTIONAL
	WSDATA   cbseller_skyhub_channel   AS string OPTIONAL
	WSDATA   cbseller_skyhub_invoice_key AS string OPTIONAL
	WSDATA   cskyhub_code              AS string OPTIONAL
	WSDATA   cbseller_skyhub_interest  AS string OPTIONAL
	WSDATA   cskyhub_marketplace       AS string OPTIONAL
	WSDATA   chas_rt                   AS string OPTIONAL
	WSDATA   cpartner_id               AS string OPTIONAL
	WSDATA   cpartner_name             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderListEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderListEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderListEntity
	Local oClone := MagentoService_salesOrderListEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cstore_id            := ::cstore_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:ccustomer_id         := ::ccustomer_id
	oClone:ctax_amount          := ::ctax_amount
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:csubtotal            := ::csubtotal
	oClone:cgrand_total         := ::cgrand_total
	oClone:ctotal_paid          := ::ctotal_paid
	oClone:ctotal_refunded      := ::ctotal_refunded
	oClone:ctotal_qty_ordered   := ::ctotal_qty_ordered
	oClone:ctotal_canceled      := ::ctotal_canceled
	oClone:ctotal_invoiced      := ::ctotal_invoiced
	oClone:ctotal_online_refunded := ::ctotal_online_refunded
	oClone:ctotal_offline_refunded := ::ctotal_offline_refunded
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cbase_shipping_amount := ::cbase_shipping_amount
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cbase_subtotal       := ::cbase_subtotal
	oClone:cbase_grand_total    := ::cbase_grand_total
	oClone:cbase_total_paid     := ::cbase_total_paid
	oClone:cbase_total_refunded := ::cbase_total_refunded
	oClone:cbase_total_qty_ordered := ::cbase_total_qty_ordered
	oClone:cbase_total_canceled := ::cbase_total_canceled
	oClone:cbase_total_invoiced := ::cbase_total_invoiced
	oClone:cbase_total_online_refunded := ::cbase_total_online_refunded
	oClone:cbase_total_offline_refunded := ::cbase_total_offline_refunded
	oClone:cbilling_address_id  := ::cbilling_address_id
	oClone:cbilling_firstname   := ::cbilling_firstname
	oClone:cbilling_lastname    := ::cbilling_lastname
	oClone:cshipping_address_id := ::cshipping_address_id
	oClone:cshipping_firstname  := ::cshipping_firstname
	oClone:cshipping_lastname   := ::cshipping_lastname
	oClone:cbilling_name        := ::cbilling_name
	oClone:cshipping_name       := ::cshipping_name
	oClone:cstore_to_base_rate  := ::cstore_to_base_rate
	oClone:cstore_to_order_rate := ::cstore_to_order_rate
	oClone:cbase_to_global_rate := ::cbase_to_global_rate
	oClone:cbase_to_order_rate  := ::cbase_to_order_rate
	oClone:cweight              := ::cweight
	oClone:cstore_name          := ::cstore_name
	oClone:cremote_ip           := ::cremote_ip
	oClone:cstatus              := ::cstatus
	oClone:cstate               := ::cstate
	oClone:capplied_rule_ids    := ::capplied_rule_ids
	oClone:cglobal_currency_code := ::cglobal_currency_code
	oClone:cbase_currency_code  := ::cbase_currency_code
	oClone:cstore_currency_code := ::cstore_currency_code
	oClone:corder_currency_code := ::corder_currency_code
	oClone:cshipping_method     := ::cshipping_method
	oClone:cshipping_description := ::cshipping_description
	oClone:ccustomer_email      := ::ccustomer_email
	oClone:ccustomer_firstname  := ::ccustomer_firstname
	oClone:ccustomer_lastname   := ::ccustomer_lastname
	oClone:ccustomer_taxvat     := ::ccustomer_taxvat
	oClone:cquote_id            := ::cquote_id
	oClone:cis_virtual          := ::cis_virtual
	oClone:ccustomer_group_id   := ::ccustomer_group_id
	oClone:ccustomer_note_notify := ::ccustomer_note_notify
	oClone:ccustomer_is_guest   := ::ccustomer_is_guest
	oClone:cemail_sent          := ::cemail_sent
	oClone:corder_id            := ::corder_id
	oClone:cgift_message_id     := ::cgift_message_id
	oClone:ccoupon_code         := ::ccoupon_code
	oClone:cprotect_code        := ::cprotect_code
	oClone:cbase_discount_canceled := ::cbase_discount_canceled
	oClone:cbase_discount_invoiced := ::cbase_discount_invoiced
	oClone:cbase_discount_refunded := ::cbase_discount_refunded
	oClone:cbase_shipping_canceled := ::cbase_shipping_canceled
	oClone:cbase_shipping_invoiced := ::cbase_shipping_invoiced
	oClone:cbase_shipping_refunded := ::cbase_shipping_refunded
	oClone:cbase_shipping_tax_amount := ::cbase_shipping_tax_amount
	oClone:cbase_shipping_tax_refunded := ::cbase_shipping_tax_refunded
	oClone:cbase_subtotal_canceled := ::cbase_subtotal_canceled
	oClone:cbase_subtotal_invoiced := ::cbase_subtotal_invoiced
	oClone:cbase_subtotal_refunded := ::cbase_subtotal_refunded
	oClone:cbase_tax_canceled   := ::cbase_tax_canceled
	oClone:cbase_tax_invoiced   := ::cbase_tax_invoiced
	oClone:cbase_tax_refunded   := ::cbase_tax_refunded
	oClone:cbase_total_invoiced_cost := ::cbase_total_invoiced_cost
	oClone:cdiscount_canceled   := ::cdiscount_canceled
	oClone:cdiscount_invoiced   := ::cdiscount_invoiced
	oClone:cdiscount_refunded   := ::cdiscount_refunded
	oClone:cshipping_canceled   := ::cshipping_canceled
	oClone:cshipping_invoiced   := ::cshipping_invoiced
	oClone:cshipping_refunded   := ::cshipping_refunded
	oClone:cshipping_tax_amount := ::cshipping_tax_amount
	oClone:cshipping_tax_refunded := ::cshipping_tax_refunded
	oClone:csubtotal_canceled   := ::csubtotal_canceled
	oClone:csubtotal_invoiced   := ::csubtotal_invoiced
	oClone:csubtotal_refunded   := ::csubtotal_refunded
	oClone:ctax_canceled        := ::ctax_canceled
	oClone:ctax_invoiced        := ::ctax_invoiced
	oClone:ctax_refunded        := ::ctax_refunded
	oClone:ccan_ship_partially  := ::ccan_ship_partially
	oClone:ccan_ship_partially_item := ::ccan_ship_partially_item
	oClone:cedit_increment      := ::cedit_increment
	oClone:cforced_do_shipment_with_invoice := ::cforced_do_shipment_with_invoice
	oClone:cpayment_authorization_expiration := ::cpayment_authorization_expiration
	oClone:cpaypal_ipn_customer_notified := ::cpaypal_ipn_customer_notified
	oClone:cquote_address_id    := ::cquote_address_id
	oClone:cadjustment_negative := ::cadjustment_negative
	oClone:cadjustment_positive := ::cadjustment_positive
	oClone:cbase_adjustment_negative := ::cbase_adjustment_negative
	oClone:cbase_adjustment_positive := ::cbase_adjustment_positive
	oClone:cbase_shipping_discount_amount := ::cbase_shipping_discount_amount
	oClone:cbase_subtotal_incl_tax := ::cbase_subtotal_incl_tax
	oClone:cbase_total_due      := ::cbase_total_due
	oClone:cpayment_authorization_amount := ::cpayment_authorization_amount
	oClone:cshipping_discount_amount := ::cshipping_discount_amount
	oClone:csubtotal_incl_tax   := ::csubtotal_incl_tax
	oClone:ctotal_due           := ::ctotal_due
	oClone:ccustomer_dob        := ::ccustomer_dob
	oClone:ccustomer_middlename := ::ccustomer_middlename
	oClone:ccustomer_prefix     := ::ccustomer_prefix
	oClone:ccustomer_suffix     := ::ccustomer_suffix
	oClone:cdiscount_description := ::cdiscount_description
	oClone:cext_customer_id     := ::cext_customer_id
	oClone:cext_order_id        := ::cext_order_id
	oClone:chold_before_state   := ::chold_before_state
	oClone:chold_before_status  := ::chold_before_status
	oClone:coriginal_increment_id := ::coriginal_increment_id
	oClone:crelation_child_id   := ::crelation_child_id
	oClone:crelation_child_real_id := ::crelation_child_real_id
	oClone:crelation_parent_id  := ::crelation_parent_id
	oClone:crelation_parent_real_id := ::crelation_parent_real_id
	oClone:cx_forwarded_for     := ::cx_forwarded_for
	oClone:ccustomer_note       := ::ccustomer_note
	oClone:ctotal_item_count    := ::ctotal_item_count
	oClone:ccustomer_gender     := ::ccustomer_gender
	oClone:chidden_tax_amount   := ::chidden_tax_amount
	oClone:cbase_hidden_tax_amount := ::cbase_hidden_tax_amount
	oClone:cshipping_hidden_tax_amount := ::cshipping_hidden_tax_amount
	oClone:cbase_shipping_hidden_tax_amount := ::cbase_shipping_hidden_tax_amount
	oClone:chidden_tax_invoiced := ::chidden_tax_invoiced
	oClone:cbase_hidden_tax_invoiced := ::cbase_hidden_tax_invoiced
	oClone:chidden_tax_refunded := ::chidden_tax_refunded
	oClone:cbase_hidden_tax_refunded := ::cbase_hidden_tax_refunded
	oClone:cshipping_incl_tax   := ::cshipping_incl_tax
	oClone:cbase_shipping_incl_tax := ::cbase_shipping_incl_tax
	oClone:cbase_customer_balance_amount := ::cbase_customer_balance_amount
	oClone:ccustomer_balance_amount := ::ccustomer_balance_amount
	oClone:cbase_customer_balance_invoiced := ::cbase_customer_balance_invoiced
	oClone:ccustomer_balance_invoiced := ::ccustomer_balance_invoiced
	oClone:cbase_customer_balance_refunded := ::cbase_customer_balance_refunded
	oClone:ccustomer_balance_refunded := ::ccustomer_balance_refunded
	oClone:cbase_customer_balance_total_refunded := ::cbase_customer_balance_total_refunded
	oClone:ccustomer_balance_total_refunded := ::ccustomer_balance_total_refunded
	oClone:cgift_cards          := ::cgift_cards
	oClone:cbase_gift_cards_amount := ::cbase_gift_cards_amount
	oClone:cgift_cards_amount   := ::cgift_cards_amount
	oClone:cbase_gift_cards_invoiced := ::cbase_gift_cards_invoiced
	oClone:cgift_cards_invoiced := ::cgift_cards_invoiced
	oClone:cbase_gift_cards_refunded := ::cbase_gift_cards_refunded
	oClone:cgift_cards_refunded := ::cgift_cards_refunded
	oClone:creward_points_balance := ::creward_points_balance
	oClone:cbase_reward_currency_amount := ::cbase_reward_currency_amount
	oClone:creward_currency_amount := ::creward_currency_amount
	oClone:cbase_reward_currency_amount_invoiced := ::cbase_reward_currency_amount_invoiced
	oClone:creward_currency_amount_invoiced := ::creward_currency_amount_invoiced
	oClone:cbase_reward_currency_amount_refunded := ::cbase_reward_currency_amount_refunded
	oClone:creward_currency_amount_refunded := ::creward_currency_amount_refunded
	oClone:creward_points_balance_refunded := ::creward_points_balance_refunded
	oClone:creward_points_balance_to_refund := ::creward_points_balance_to_refund
	oClone:creward_salesrule_points := ::creward_salesrule_points
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:ctelephone           := ::ctelephone
	oClone:cpostcode            := ::cpostcode
	oClone:caffiliate_id        := ::caffiliate_id
	oClone:caffiliate_name      := ::caffiliate_name
	oClone:lbseller_skyhub      := ::lbseller_skyhub
	oClone:cbseller_skyhub_code := ::cbseller_skyhub_code
	oClone:cbseller_skyhub_channel := ::cbseller_skyhub_channel
	oClone:cbseller_skyhub_invoice_key := ::cbseller_skyhub_invoice_key
	oClone:cskyhub_code         := ::cskyhub_code
	oClone:cbseller_skyhub_interest := ::cbseller_skyhub_interest
	oClone:cskyhub_marketplace  := ::cskyhub_marketplace
	oClone:chas_rt              := ::chas_rt
	oClone:cpartner_id          := ::cpartner_id
	oClone:cpartner_name        := ::cpartner_name
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderListEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_id       :=  WSAdvValue( oResponse,"_CUSTOMER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_amount   :=  WSAdvValue( oResponse,"_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal          :=  WSAdvValue( oResponse,"_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgrand_total       :=  WSAdvValue( oResponse,"_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_paid        :=  WSAdvValue( oResponse,"_TOTAL_PAID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_refunded    :=  WSAdvValue( oResponse,"_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_qty_ordered :=  WSAdvValue( oResponse,"_TOTAL_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_canceled    :=  WSAdvValue( oResponse,"_TOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_invoiced    :=  WSAdvValue( oResponse,"_TOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_online_refunded :=  WSAdvValue( oResponse,"_TOTAL_ONLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_offline_refunded :=  WSAdvValue( oResponse,"_TOTAL_OFFLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal     :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_grand_total  :=  WSAdvValue( oResponse,"_BASE_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_paid   :=  WSAdvValue( oResponse,"_BASE_TOTAL_PAID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_qty_ordered :=  WSAdvValue( oResponse,"_BASE_TOTAL_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_canceled :=  WSAdvValue( oResponse,"_BASE_TOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_invoiced :=  WSAdvValue( oResponse,"_BASE_TOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_online_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_ONLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_offline_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_OFFLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_address_id :=  WSAdvValue( oResponse,"_BILLING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_firstname :=  WSAdvValue( oResponse,"_BILLING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_lastname  :=  WSAdvValue( oResponse,"_BILLING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_address_id :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_firstname :=  WSAdvValue( oResponse,"_SHIPPING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_lastname :=  WSAdvValue( oResponse,"_SHIPPING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_name      :=  WSAdvValue( oResponse,"_BILLING_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_name     :=  WSAdvValue( oResponse,"_SHIPPING_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_base_rate :=  WSAdvValue( oResponse,"_STORE_TO_BASE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_order_rate :=  WSAdvValue( oResponse,"_STORE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_global_rate :=  WSAdvValue( oResponse,"_BASE_TO_GLOBAL_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_order_rate :=  WSAdvValue( oResponse,"_BASE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_name        :=  WSAdvValue( oResponse,"_STORE_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cremote_ip         :=  WSAdvValue( oResponse,"_REMOTE_IP","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstate             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::capplied_rule_ids  :=  WSAdvValue( oResponse,"_APPLIED_RULE_IDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cglobal_currency_code :=  WSAdvValue( oResponse,"_GLOBAL_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_currency_code :=  WSAdvValue( oResponse,"_BASE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_currency_code :=  WSAdvValue( oResponse,"_STORE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_currency_code :=  WSAdvValue( oResponse,"_ORDER_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_method   :=  WSAdvValue( oResponse,"_SHIPPING_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_description :=  WSAdvValue( oResponse,"_SHIPPING_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_email    :=  WSAdvValue( oResponse,"_CUSTOMER_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_firstname :=  WSAdvValue( oResponse,"_CUSTOMER_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_lastname :=  WSAdvValue( oResponse,"_CUSTOMER_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_taxvat   :=  WSAdvValue( oResponse,"_CUSTOMER_TAXVAT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cquote_id          :=  WSAdvValue( oResponse,"_QUOTE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_virtual        :=  WSAdvValue( oResponse,"_IS_VIRTUAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_group_id :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_note_notify :=  WSAdvValue( oResponse,"_CUSTOMER_NOTE_NOTIFY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_is_guest :=  WSAdvValue( oResponse,"_CUSTOMER_IS_GUEST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cemail_sent        :=  WSAdvValue( oResponse,"_EMAIL_SENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_id   :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccoupon_code       :=  WSAdvValue( oResponse,"_COUPON_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprotect_code      :=  WSAdvValue( oResponse,"_PROTECT_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_canceled :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_invoiced :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_refunded :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_canceled :=  WSAdvValue( oResponse,"_BASE_SHIPPING_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_invoiced :=  WSAdvValue( oResponse,"_BASE_SHIPPING_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_refunded :=  WSAdvValue( oResponse,"_BASE_SHIPPING_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_tax_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_tax_refunded :=  WSAdvValue( oResponse,"_BASE_SHIPPING_TAX_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal_canceled :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal_invoiced :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal_refunded :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_canceled :=  WSAdvValue( oResponse,"_BASE_TAX_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_invoiced :=  WSAdvValue( oResponse,"_BASE_TAX_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_refunded :=  WSAdvValue( oResponse,"_BASE_TAX_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_invoiced_cost :=  WSAdvValue( oResponse,"_BASE_TOTAL_INVOICED_COST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_canceled :=  WSAdvValue( oResponse,"_DISCOUNT_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_invoiced :=  WSAdvValue( oResponse,"_DISCOUNT_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_refunded :=  WSAdvValue( oResponse,"_DISCOUNT_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_canceled :=  WSAdvValue( oResponse,"_SHIPPING_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_invoiced :=  WSAdvValue( oResponse,"_SHIPPING_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_refunded :=  WSAdvValue( oResponse,"_SHIPPING_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_tax_amount :=  WSAdvValue( oResponse,"_SHIPPING_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_tax_refunded :=  WSAdvValue( oResponse,"_SHIPPING_TAX_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal_canceled :=  WSAdvValue( oResponse,"_SUBTOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal_invoiced :=  WSAdvValue( oResponse,"_SUBTOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal_refunded :=  WSAdvValue( oResponse,"_SUBTOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_canceled      :=  WSAdvValue( oResponse,"_TAX_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_invoiced      :=  WSAdvValue( oResponse,"_TAX_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_refunded      :=  WSAdvValue( oResponse,"_TAX_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccan_ship_partially :=  WSAdvValue( oResponse,"_CAN_SHIP_PARTIALLY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccan_ship_partially_item :=  WSAdvValue( oResponse,"_CAN_SHIP_PARTIALLY_ITEM","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cedit_increment    :=  WSAdvValue( oResponse,"_EDIT_INCREMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cforced_do_shipment_with_invoice :=  WSAdvValue( oResponse,"_FORCED_DO_SHIPMENT_WITH_INVOICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpayment_authorization_expiration :=  WSAdvValue( oResponse,"_PAYMENT_AUTHORIZATION_EXPIRATION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpaypal_ipn_customer_notified :=  WSAdvValue( oResponse,"_PAYPAL_IPN_CUSTOMER_NOTIFIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cquote_address_id  :=  WSAdvValue( oResponse,"_QUOTE_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadjustment_negative :=  WSAdvValue( oResponse,"_ADJUSTMENT_NEGATIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadjustment_positive :=  WSAdvValue( oResponse,"_ADJUSTMENT_POSITIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_adjustment_negative :=  WSAdvValue( oResponse,"_BASE_ADJUSTMENT_NEGATIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_adjustment_positive :=  WSAdvValue( oResponse,"_BASE_ADJUSTMENT_POSITIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_discount_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal_incl_tax :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_due    :=  WSAdvValue( oResponse,"_BASE_TOTAL_DUE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpayment_authorization_amount :=  WSAdvValue( oResponse,"_PAYMENT_AUTHORIZATION_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_discount_amount :=  WSAdvValue( oResponse,"_SHIPPING_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal_incl_tax :=  WSAdvValue( oResponse,"_SUBTOTAL_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_due         :=  WSAdvValue( oResponse,"_TOTAL_DUE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_dob      :=  WSAdvValue( oResponse,"_CUSTOMER_DOB","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_middlename :=  WSAdvValue( oResponse,"_CUSTOMER_MIDDLENAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_prefix   :=  WSAdvValue( oResponse,"_CUSTOMER_PREFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_suffix   :=  WSAdvValue( oResponse,"_CUSTOMER_SUFFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_description :=  WSAdvValue( oResponse,"_DISCOUNT_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cext_customer_id   :=  WSAdvValue( oResponse,"_EXT_CUSTOMER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cext_order_id      :=  WSAdvValue( oResponse,"_EXT_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chold_before_state :=  WSAdvValue( oResponse,"_HOLD_BEFORE_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chold_before_status :=  WSAdvValue( oResponse,"_HOLD_BEFORE_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::coriginal_increment_id :=  WSAdvValue( oResponse,"_ORIGINAL_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crelation_child_id :=  WSAdvValue( oResponse,"_RELATION_CHILD_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crelation_child_real_id :=  WSAdvValue( oResponse,"_RELATION_CHILD_REAL_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crelation_parent_id :=  WSAdvValue( oResponse,"_RELATION_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crelation_parent_real_id :=  WSAdvValue( oResponse,"_RELATION_PARENT_REAL_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cx_forwarded_for   :=  WSAdvValue( oResponse,"_X_FORWARDED_FOR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_note     :=  WSAdvValue( oResponse,"_CUSTOMER_NOTE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_item_count  :=  WSAdvValue( oResponse,"_TOTAL_ITEM_COUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_gender   :=  WSAdvValue( oResponse,"_CUSTOMER_GENDER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chidden_tax_amount :=  WSAdvValue( oResponse,"_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_hidden_tax_amount :=  WSAdvValue( oResponse,"_BASE_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_hidden_tax_amount :=  WSAdvValue( oResponse,"_SHIPPING_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_hidden_tax_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chidden_tax_invoiced :=  WSAdvValue( oResponse,"_HIDDEN_TAX_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_hidden_tax_invoiced :=  WSAdvValue( oResponse,"_BASE_HIDDEN_TAX_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chidden_tax_refunded :=  WSAdvValue( oResponse,"_HIDDEN_TAX_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_hidden_tax_refunded :=  WSAdvValue( oResponse,"_BASE_HIDDEN_TAX_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_incl_tax :=  WSAdvValue( oResponse,"_SHIPPING_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_incl_tax :=  WSAdvValue( oResponse,"_BASE_SHIPPING_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_customer_balance_amount :=  WSAdvValue( oResponse,"_BASE_CUSTOMER_BALANCE_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_balance_amount :=  WSAdvValue( oResponse,"_CUSTOMER_BALANCE_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_customer_balance_invoiced :=  WSAdvValue( oResponse,"_BASE_CUSTOMER_BALANCE_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_balance_invoiced :=  WSAdvValue( oResponse,"_CUSTOMER_BALANCE_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_customer_balance_refunded :=  WSAdvValue( oResponse,"_BASE_CUSTOMER_BALANCE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_balance_refunded :=  WSAdvValue( oResponse,"_CUSTOMER_BALANCE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_customer_balance_total_refunded :=  WSAdvValue( oResponse,"_BASE_CUSTOMER_BALANCE_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_balance_total_refunded :=  WSAdvValue( oResponse,"_CUSTOMER_BALANCE_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards        :=  WSAdvValue( oResponse,"_GIFT_CARDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_gift_cards_amount :=  WSAdvValue( oResponse,"_BASE_GIFT_CARDS_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards_amount :=  WSAdvValue( oResponse,"_GIFT_CARDS_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_gift_cards_invoiced :=  WSAdvValue( oResponse,"_BASE_GIFT_CARDS_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards_invoiced :=  WSAdvValue( oResponse,"_GIFT_CARDS_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_gift_cards_refunded :=  WSAdvValue( oResponse,"_BASE_GIFT_CARDS_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards_refunded :=  WSAdvValue( oResponse,"_GIFT_CARDS_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_points_balance :=  WSAdvValue( oResponse,"_REWARD_POINTS_BALANCE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_reward_currency_amount :=  WSAdvValue( oResponse,"_BASE_REWARD_CURRENCY_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_currency_amount :=  WSAdvValue( oResponse,"_REWARD_CURRENCY_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_reward_currency_amount_invoiced :=  WSAdvValue( oResponse,"_BASE_REWARD_CURRENCY_AMOUNT_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_currency_amount_invoiced :=  WSAdvValue( oResponse,"_REWARD_CURRENCY_AMOUNT_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_reward_currency_amount_refunded :=  WSAdvValue( oResponse,"_BASE_REWARD_CURRENCY_AMOUNT_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_currency_amount_refunded :=  WSAdvValue( oResponse,"_REWARD_CURRENCY_AMOUNT_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_points_balance_refunded :=  WSAdvValue( oResponse,"_REWARD_POINTS_BALANCE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_points_balance_to_refund :=  WSAdvValue( oResponse,"_REWARD_POINTS_BALANCE_TO_REFUND","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_salesrule_points :=  WSAdvValue( oResponse,"_REWARD_SALESRULE_POINTS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfirstname         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clastname          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctelephone         :=  WSAdvValue( oResponse,"_TELEPHONE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpostcode          :=  WSAdvValue( oResponse,"_POSTCODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caffiliate_id      :=  WSAdvValue( oResponse,"_AFFILIATE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caffiliate_name    :=  WSAdvValue( oResponse,"_AFFILIATE_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::lbseller_skyhub    :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB","boolean",NIL,NIL,NIL,"L",NIL,NIL)
	::cbseller_skyhub_code :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_channel :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB_CHANNEL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_invoice_key :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB_INVOICE_KEY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cskyhub_code       :=  WSAdvValue( oResponse,"_SKYHUB_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_interest := WSAdvValue( oResponse,"_SKYHUB_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cskyhub_marketplace :=  WSAdvValue( oResponse,"_SKYHUB_MARKETPLACE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chas_rt            :=  WSAdvValue( oResponse,"_HAS_RT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpartner_id        :=  WSAdvValue( oResponse,"_PARTNER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpartner_name      :=  WSAdvValue( oResponse,"_PARTNER_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderEntity

WSSTRUCT MagentoService_salesOrderEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   ccustomer_id              AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   csubtotal                 AS string OPTIONAL
	WSDATA   cgrand_total              AS string OPTIONAL
	WSDATA   ctotal_paid               AS string OPTIONAL
	WSDATA   ctotal_refunded           AS string OPTIONAL
	WSDATA   ctotal_qty_ordered        AS string OPTIONAL
	WSDATA   ctotal_canceled           AS string OPTIONAL
	WSDATA   ctotal_invoiced           AS string OPTIONAL
	WSDATA   ctotal_online_refunded    AS string OPTIONAL
	WSDATA   ctotal_offline_refunded   AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cbase_shipping_amount     AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cbase_subtotal            AS string OPTIONAL
	WSDATA   cbase_grand_total         AS string OPTIONAL
	WSDATA   cbase_total_paid          AS string OPTIONAL
	WSDATA   cbase_total_refunded      AS string OPTIONAL
	WSDATA   cbase_total_qty_ordered   AS string OPTIONAL
	WSDATA   cbase_total_canceled      AS string OPTIONAL
	WSDATA   cbase_total_invoiced      AS string OPTIONAL
	WSDATA   cbase_total_online_refunded AS string OPTIONAL
	WSDATA   cbase_total_offline_refunded AS string OPTIONAL
	WSDATA   cbilling_address_id       AS string OPTIONAL
	WSDATA   cbilling_firstname        AS string OPTIONAL
	WSDATA   cbilling_lastname         AS string OPTIONAL
	WSDATA   cshipping_address_id      AS string OPTIONAL
	WSDATA   cshipping_firstname       AS string OPTIONAL
	WSDATA   cshipping_lastname        AS string OPTIONAL
	WSDATA   cbilling_name             AS string OPTIONAL
	WSDATA   cshipping_name            AS string OPTIONAL
	WSDATA   cstore_to_base_rate       AS string OPTIONAL
	WSDATA   cstore_to_order_rate      AS string OPTIONAL
	WSDATA   cbase_to_global_rate      AS string OPTIONAL
	WSDATA   cbase_to_order_rate       AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cstore_name               AS string OPTIONAL
	WSDATA   cremote_ip                AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   cstate                    AS string OPTIONAL
	WSDATA   capplied_rule_ids         AS string OPTIONAL
	WSDATA   cglobal_currency_code     AS string OPTIONAL
	WSDATA   cbase_currency_code       AS string OPTIONAL
	WSDATA   cstore_currency_code      AS string OPTIONAL
	WSDATA   corder_currency_code      AS string OPTIONAL
	WSDATA   cshipping_method          AS string OPTIONAL
	WSDATA   cshipping_description     AS string OPTIONAL
	WSDATA   ccustomer_email           AS string OPTIONAL
	WSDATA   ccustomer_firstname       AS string OPTIONAL
	WSDATA   ccustomer_lastname        AS string OPTIONAL
	WSDATA   ccustomer_taxvat          AS string OPTIONAL
	WSDATA   cquote_id                 AS string OPTIONAL
	WSDATA   cis_virtual               AS string OPTIONAL
	WSDATA   ccustomer_group_id        AS string OPTIONAL
	WSDATA   ccustomer_note_notify     AS string OPTIONAL
	WSDATA   ccustomer_is_guest        AS string OPTIONAL
	WSDATA   cemail_sent               AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   cgift_message_id          AS string OPTIONAL
	WSDATA   cgift_message             AS string OPTIONAL
	WSDATA   oWSshipping_address       AS MagentoService_salesOrderAddressEntity OPTIONAL
	WSDATA   oWSbilling_address        AS MagentoService_salesOrderAddressEntity OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_salesOrderItemEntityArray OPTIONAL
	WSDATA   oWSpayment                AS MagentoService_salesOrderPaymentEntity OPTIONAL
	WSDATA   oWSstatus_history         AS MagentoService_salesOrderStatusHistoryEntityArray OPTIONAL
	WSDATA   caffiliate_id             AS string OPTIONAL
	WSDATA   caffiliate_name           AS string OPTIONAL
	WSDATA   lbseller_skyhub           AS boolean OPTIONAL
	WSDATA   cbseller_skyhub_code      AS string OPTIONAL
	WSDATA   cbseller_skyhub_channel   AS string OPTIONAL
	WSDATA   cbseller_skyhub_invoice_key AS string OPTIONAL
	WSDATA   cskyhub_code              AS string OPTIONAL
	WSDATA   cbseller_skyhub_interest  AS string OPTIONAL
	WSDATA   cskyhub_marketplace       AS string OPTIONAL
	WSDATA   chas_rt                   AS string OPTIONAL
	WSDATA   cpartner_id               AS string OPTIONAL
	WSDATA   cpartner_name             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderEntity
	Local oClone := MagentoService_salesOrderEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:cstore_id            := ::cstore_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:ccustomer_id         := ::ccustomer_id
	oClone:ctax_amount          := ::ctax_amount
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:csubtotal            := ::csubtotal
	oClone:cgrand_total         := ::cgrand_total
	oClone:ctotal_paid          := ::ctotal_paid
	oClone:ctotal_refunded      := ::ctotal_refunded
	oClone:ctotal_qty_ordered   := ::ctotal_qty_ordered
	oClone:ctotal_canceled      := ::ctotal_canceled
	oClone:ctotal_invoiced      := ::ctotal_invoiced
	oClone:ctotal_online_refunded := ::ctotal_online_refunded
	oClone:ctotal_offline_refunded := ::ctotal_offline_refunded
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cbase_shipping_amount := ::cbase_shipping_amount
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cbase_subtotal       := ::cbase_subtotal
	oClone:cbase_grand_total    := ::cbase_grand_total
	oClone:cbase_total_paid     := ::cbase_total_paid
	oClone:cbase_total_refunded := ::cbase_total_refunded
	oClone:cbase_total_qty_ordered := ::cbase_total_qty_ordered
	oClone:cbase_total_canceled := ::cbase_total_canceled
	oClone:cbase_total_invoiced := ::cbase_total_invoiced
	oClone:cbase_total_online_refunded := ::cbase_total_online_refunded
	oClone:cbase_total_offline_refunded := ::cbase_total_offline_refunded
	oClone:cbilling_address_id  := ::cbilling_address_id
	oClone:cbilling_firstname   := ::cbilling_firstname
	oClone:cbilling_lastname    := ::cbilling_lastname
	oClone:cshipping_address_id := ::cshipping_address_id
	oClone:cshipping_firstname  := ::cshipping_firstname
	oClone:cshipping_lastname   := ::cshipping_lastname
	oClone:cbilling_name        := ::cbilling_name
	oClone:cshipping_name       := ::cshipping_name
	oClone:cstore_to_base_rate  := ::cstore_to_base_rate
	oClone:cstore_to_order_rate := ::cstore_to_order_rate
	oClone:cbase_to_global_rate := ::cbase_to_global_rate
	oClone:cbase_to_order_rate  := ::cbase_to_order_rate
	oClone:cweight              := ::cweight
	oClone:cstore_name          := ::cstore_name
	oClone:cremote_ip           := ::cremote_ip
	oClone:cstatus              := ::cstatus
	oClone:cstate               := ::cstate
	oClone:capplied_rule_ids    := ::capplied_rule_ids
	oClone:cglobal_currency_code := ::cglobal_currency_code
	oClone:cbase_currency_code  := ::cbase_currency_code
	oClone:cstore_currency_code := ::cstore_currency_code
	oClone:corder_currency_code := ::corder_currency_code
	oClone:cshipping_method     := ::cshipping_method
	oClone:cshipping_description := ::cshipping_description
	oClone:ccustomer_email      := ::ccustomer_email
	oClone:ccustomer_firstname  := ::ccustomer_firstname
	oClone:ccustomer_lastname   := ::ccustomer_lastname
	oClone:ccustomer_taxvat     := ::ccustomer_taxvat
	oClone:cquote_id            := ::cquote_id
	oClone:cis_virtual          := ::cis_virtual
	oClone:ccustomer_group_id   := ::ccustomer_group_id
	oClone:ccustomer_note_notify := ::ccustomer_note_notify
	oClone:ccustomer_is_guest   := ::ccustomer_is_guest
	oClone:cemail_sent          := ::cemail_sent
	oClone:corder_id            := ::corder_id
	oClone:cgift_message_id     := ::cgift_message_id
	oClone:cgift_message        := ::cgift_message
	oClone:oWSshipping_address  := IIF(::oWSshipping_address = NIL , NIL , ::oWSshipping_address:Clone() )
	oClone:oWSbilling_address   := IIF(::oWSbilling_address = NIL , NIL , ::oWSbilling_address:Clone() )
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:oWSpayment           := IIF(::oWSpayment = NIL , NIL , ::oWSpayment:Clone() )
	oClone:oWSstatus_history    := IIF(::oWSstatus_history = NIL , NIL , ::oWSstatus_history:Clone() )
	oClone:caffiliate_id        := ::caffiliate_id
	oClone:caffiliate_name      := ::caffiliate_name
	oClone:lbseller_skyhub      := ::lbseller_skyhub
	oClone:cbseller_skyhub_code := ::cbseller_skyhub_code
	oClone:cbseller_skyhub_channel := ::cbseller_skyhub_channel
	oClone:cbseller_skyhub_invoice_key := ::cbseller_skyhub_invoice_key
	oClone:cskyhub_code         := ::cskyhub_code
	oClone:cbseller_skyhub_interest := ::cbseller_skyhub_interest
	oClone:cskyhub_marketplace  := ::cskyhub_marketplace
	oClone:chas_rt              := ::chas_rt
	oClone:cpartner_id          := ::cpartner_id
	oClone:cpartner_name        := ::cpartner_name
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderEntity
	Local oNode69
	Local oNode70
	Local oNode71
	Local oNode72
	Local oNode73
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_id       :=  WSAdvValue( oResponse,"_CUSTOMER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_amount   :=  WSAdvValue( oResponse,"_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal          :=  WSAdvValue( oResponse,"_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgrand_total       :=  WSAdvValue( oResponse,"_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_paid        :=  WSAdvValue( oResponse,"_TOTAL_PAID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_refunded    :=  WSAdvValue( oResponse,"_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_qty_ordered :=  WSAdvValue( oResponse,"_TOTAL_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_canceled    :=  WSAdvValue( oResponse,"_TOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_invoiced    :=  WSAdvValue( oResponse,"_TOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_online_refunded :=  WSAdvValue( oResponse,"_TOTAL_ONLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_offline_refunded :=  WSAdvValue( oResponse,"_TOTAL_OFFLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal     :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_grand_total  :=  WSAdvValue( oResponse,"_BASE_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_paid   :=  WSAdvValue( oResponse,"_BASE_TOTAL_PAID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_qty_ordered :=  WSAdvValue( oResponse,"_BASE_TOTAL_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_canceled :=  WSAdvValue( oResponse,"_BASE_TOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_invoiced :=  WSAdvValue( oResponse,"_BASE_TOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_online_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_ONLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_offline_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_OFFLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_address_id :=  WSAdvValue( oResponse,"_BILLING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_firstname :=  WSAdvValue( oResponse,"_BILLING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_lastname  :=  WSAdvValue( oResponse,"_BILLING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_address_id :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_firstname :=  WSAdvValue( oResponse,"_SHIPPING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_lastname :=  WSAdvValue( oResponse,"_SHIPPING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_name      :=  WSAdvValue( oResponse,"_BILLING_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_name     :=  WSAdvValue( oResponse,"_SHIPPING_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_base_rate :=  WSAdvValue( oResponse,"_STORE_TO_BASE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_order_rate :=  WSAdvValue( oResponse,"_STORE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_global_rate :=  WSAdvValue( oResponse,"_BASE_TO_GLOBAL_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_order_rate :=  WSAdvValue( oResponse,"_BASE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_name        :=  WSAdvValue( oResponse,"_STORE_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cremote_ip         :=  WSAdvValue( oResponse,"_REMOTE_IP","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstate             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::capplied_rule_ids  :=  WSAdvValue( oResponse,"_APPLIED_RULE_IDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cglobal_currency_code :=  WSAdvValue( oResponse,"_GLOBAL_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_currency_code :=  WSAdvValue( oResponse,"_BASE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_currency_code :=  WSAdvValue( oResponse,"_STORE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_currency_code :=  WSAdvValue( oResponse,"_ORDER_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_method   :=  WSAdvValue( oResponse,"_SHIPPING_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_description :=  WSAdvValue( oResponse,"_SHIPPING_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_email    :=  WSAdvValue( oResponse,"_CUSTOMER_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_firstname :=  WSAdvValue( oResponse,"_CUSTOMER_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_lastname :=  WSAdvValue( oResponse,"_CUSTOMER_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_taxvat   :=  WSAdvValue( oResponse,"_CUSTOMER_TAXVAT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cquote_id          :=  WSAdvValue( oResponse,"_QUOTE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_virtual        :=  WSAdvValue( oResponse,"_IS_VIRTUAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_group_id :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_note_notify :=  WSAdvValue( oResponse,"_CUSTOMER_NOTE_NOTIFY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_is_guest :=  WSAdvValue( oResponse,"_CUSTOMER_IS_GUEST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cemail_sent        :=  WSAdvValue( oResponse,"_EMAIL_SENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_id   :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message      :=  WSAdvValue( oResponse,"_GIFT_MESSAGE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_interest := WSAdvValue( oResponse,"_BSELLER_SKYHUB_INTEREST","string",NIL,NIL,NIL,"S",NIL,NIL)

	oNode69 :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS","salesOrderAddressEntity",NIL,NIL,NIL,"O",NIL,NIL)

	If oNode69 != NIL
		::oWSshipping_address := MagentoService_salesOrderAddressEntity():New()
		::oWSshipping_address:SoapRecv(oNode69)
	EndIf
	oNode70 :=  WSAdvValue( oResponse,"_BILLING_ADDRESS","salesOrderAddressEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode70 != NIL
		::oWSbilling_address := MagentoService_salesOrderAddressEntity():New()
		::oWSbilling_address:SoapRecv(oNode70)
	EndIf
	oNode71 :=  WSAdvValue( oResponse,"_ITEMS","salesOrderItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode71 != NIL
		::oWSitems := MagentoService_salesOrderItemEntityArray():New()
		::oWSitems:SoapRecv(oNode71)
	EndIf
	oNode72 :=  WSAdvValue( oResponse,"_PAYMENT","salesOrderPaymentEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode72 != NIL
		::oWSpayment := MagentoService_salesOrderPaymentEntity():New()
		::oWSpayment:SoapRecv(oNode72)
	EndIf
	oNode73 :=  WSAdvValue( oResponse,"_STATUS_HISTORY","salesOrderStatusHistoryEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode73 != NIL
		::oWSstatus_history := MagentoService_salesOrderStatusHistoryEntityArray():New()
		::oWSstatus_history:SoapRecv(oNode73)
	EndIf
	::caffiliate_id      :=  WSAdvValue( oResponse,"_AFFILIATE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caffiliate_name    :=  WSAdvValue( oResponse,"_AFFILIATE_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::lbseller_skyhub    :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB","boolean",NIL,NIL,NIL,"L",NIL,NIL)
	::cbseller_skyhub_code :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_channel :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB_CHANNEL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_invoice_key :=  WSAdvValue( oResponse,"_BSELLER_SKYHUB_INVOICE_KEY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cskyhub_code       :=  WSAdvValue( oResponse,"_SKYHUB_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbseller_skyhub_interest := WSAdvValue( oResponse,"_BSELLER_SKYHUB_INTEREST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cskyhub_marketplace :=  WSAdvValue( oResponse,"_SKYHUB_MARKETPLACE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chas_rt            :=  WSAdvValue( oResponse,"_HAS_RT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpartner_id        :=  WSAdvValue( oResponse,"_PARTNER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpartner_name      :=  WSAdvValue( oResponse,"_PARTNER_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderAddressEntity

WSSTRUCT MagentoService_salesOrderAddressEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   caddress_type             AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   cstreet                   AS string OPTIONAL
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   cregion_id                AS string OPTIONAL
	WSDATA   caddress_id               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderAddressEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderAddressEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderAddressEntity
	Local oClone := MagentoService_salesOrderAddressEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:caddress_type        := ::caddress_type
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:ccompany             := ::ccompany
	oClone:cstreet              := ::cstreet
	oClone:ccity                := ::ccity
	oClone:cregion              := ::cregion
	oClone:cpostcode            := ::cpostcode
	oClone:ccountry_id          := ::ccountry_id
	oClone:ctelephone           := ::ctelephone
	oClone:cfax                 := ::cfax
	oClone:cregion_id           := ::cregion_id
	oClone:caddress_id          := ::caddress_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderAddressEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caddress_type      :=  WSAdvValue( oResponse,"_ADDRESS_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfirstname         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clastname          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccompany           :=  WSAdvValue( oResponse,"_COMPANY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion            :=  WSAdvValue( oResponse,"_REGION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpostcode          :=  WSAdvValue( oResponse,"_POSTCODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccountry_id        :=  WSAdvValue( oResponse,"_COUNTRY_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctelephone         :=  WSAdvValue( oResponse,"_TELEPHONE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfax               :=  WSAdvValue( oResponse,"_FAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion_id         :=  WSAdvValue( oResponse,"_REGION_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caddress_id        :=  WSAdvValue( oResponse,"_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderItemEntityArray

WSSTRUCT MagentoService_salesOrderItemEntityArray
	WSDATA   oWSsalesOrderItemEntity   AS MagentoService_salesOrderItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderItemEntityArray
	::oWSsalesOrderItemEntity := {} // Array Of  MagentoService_SALESORDERITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderItemEntityArray
	Local oClone := MagentoService_salesOrderItemEntityArray():NEW()
	oClone:oWSsalesOrderItemEntity := NIL
	If ::oWSsalesOrderItemEntity <> NIL
		oClone:oWSsalesOrderItemEntity := {}
		aEval( ::oWSsalesOrderItemEntity , { |x| aadd( oClone:oWSsalesOrderItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderItemEntity , MagentoService_salesOrderItemEntity():New() )
			::oWSsalesOrderItemEntity[len(::oWSsalesOrderItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderPaymentEntity

WSSTRUCT MagentoService_salesOrderPaymentEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   camount_ordered           AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cbase_amount_ordered      AS string OPTIONAL
	WSDATA   cbase_shipping_amount     AS string OPTIONAL
	WSDATA   cmethod                   AS string OPTIONAL
	WSDATA   cpo_number                AS string OPTIONAL
	WSDATA   ccc_type                  AS string OPTIONAL
	WSDATA   ccc_number_enc            AS string OPTIONAL
	WSDATA   ccc_last4                 AS string OPTIONAL
	WSDATA   ccc_owner                 AS string OPTIONAL
	WSDATA   ccc_exp_month             AS string OPTIONAL
	WSDATA   ccc_exp_year              AS string OPTIONAL
	WSDATA   ccc_ss_start_month        AS string OPTIONAL
	WSDATA   ccc_ss_start_year         AS string OPTIONAL
	WSDATA   cpayment_id               AS string OPTIONAL
	WSDATA   corder_key                AS string OPTIONAL
	WSDATA   cinstallments             AS string OPTIONAL
	WSDATA   ctwo_cc_type              AS string OPTIONAL
	WSDATA   ctwo_cc_installments      AS string OPTIONAL
	WSDATA   cadditional_information   AS string OPTIONAL
	WSDATA   ccc_trans_id			   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderPaymentEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderPaymentEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderPaymentEntity
	Local oClone := MagentoService_salesOrderPaymentEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:camount_ordered      := ::camount_ordered
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cbase_amount_ordered := ::cbase_amount_ordered
	oClone:cbase_shipping_amount := ::cbase_shipping_amount
	oClone:cmethod              := ::cmethod
	oClone:cpo_number           := ::cpo_number
	oClone:ccc_type             := ::ccc_type
	oClone:ccc_number_enc       := ::ccc_number_enc
	oClone:ccc_last4            := ::ccc_last4
	oClone:ccc_owner            := ::ccc_owner
	oClone:ccc_exp_month        := ::ccc_exp_month
	oClone:ccc_exp_year         := ::ccc_exp_year
	oClone:ccc_ss_start_month   := ::ccc_ss_start_month
	oClone:ccc_ss_start_year    := ::ccc_ss_start_year
	oClone:cpayment_id          := ::cpayment_id
	oClone:corder_key           := ::corder_key
	oClone:cinstallments        := ::cinstallments
	oClone:ctwo_cc_type         := ::ctwo_cc_type
	oClone:ctwo_cc_installments := ::ctwo_cc_installments
	oClone:cadditional_information := ::cadditional_information
	oClone:ccc_trans_id		  	   := ::ccc_trans_id

Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderPaymentEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::camount_ordered    :=  WSAdvValue( oResponse,"_AMOUNT_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_amount   :=  WSAdvValue( oResponse,"_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_amount_ordered :=  WSAdvValue( oResponse,"_BASE_AMOUNT_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmethod            :=  WSAdvValue( oResponse,"_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpo_number         :=  WSAdvValue( oResponse,"_PO_NUMBER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_type           :=  WSAdvValue( oResponse,"_CC_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_number_enc     :=  WSAdvValue( oResponse,"_CC_NUMBER_ENC","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_last4          :=  WSAdvValue( oResponse,"_CC_LAST4","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_owner          :=  WSAdvValue( oResponse,"_CC_OWNER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_exp_month      :=  WSAdvValue( oResponse,"_CC_EXP_MONTH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_exp_year       :=  WSAdvValue( oResponse,"_CC_EXP_YEAR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_ss_start_month :=  WSAdvValue( oResponse,"_CC_SS_START_MONTH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_ss_start_year  :=  WSAdvValue( oResponse,"_CC_SS_START_YEAR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpayment_id        :=  WSAdvValue( oResponse,"_PAYMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_key         :=  WSAdvValue( oResponse,"_ORDER_KEY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cinstallments      :=  WSAdvValue( oResponse,"_INSTALLMENTS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctwo_cc_type       :=  WSAdvValue( oResponse,"_TWO_CC_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctwo_cc_installments :=  WSAdvValue( oResponse,"_TWO_CC_INSTALLMENTS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadditional_information :=  WSAdvValue( oResponse,"_ADDITIONAL_INFORMATION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_trans_id :=  WSAdvValue( oResponse,"_CC_TRANS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)

Return

// WSDL Data Structure salesOrderStatusHistoryEntityArray

WSSTRUCT MagentoService_salesOrderStatusHistoryEntityArray
	WSDATA   oWSsalesOrderStatusHistoryEntity AS MagentoService_salesOrderStatusHistoryEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderStatusHistoryEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderStatusHistoryEntityArray
	::oWSsalesOrderStatusHistoryEntity := {} // Array Of  MagentoService_SALESORDERSTATUSHISTORYENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderStatusHistoryEntityArray
	Local oClone := MagentoService_salesOrderStatusHistoryEntityArray():NEW()
	oClone:oWSsalesOrderStatusHistoryEntity := NIL
	If ::oWSsalesOrderStatusHistoryEntity <> NIL
		oClone:oWSsalesOrderStatusHistoryEntity := {}
		aEval( ::oWSsalesOrderStatusHistoryEntity , { |x| aadd( oClone:oWSsalesOrderStatusHistoryEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderStatusHistoryEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderStatusHistoryEntity , MagentoService_salesOrderStatusHistoryEntity():New() )
			::oWSsalesOrderStatusHistoryEntity[len(::oWSsalesOrderStatusHistoryEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderShipmentEntityArray

WSSTRUCT MagentoService_salesOrderShipmentEntityArray
	WSDATA   oWSsalesOrderShipmentEntity AS MagentoService_salesOrderShipmentEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentEntityArray
	::oWSsalesOrderShipmentEntity := {} // Array Of  MagentoService_SALESORDERSHIPMENTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentEntityArray
	Local oClone := MagentoService_salesOrderShipmentEntityArray():NEW()
	oClone:oWSsalesOrderShipmentEntity := NIL
	If ::oWSsalesOrderShipmentEntity <> NIL
		oClone:oWSsalesOrderShipmentEntity := {}
		aEval( ::oWSsalesOrderShipmentEntity , { |x| aadd( oClone:oWSsalesOrderShipmentEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderShipmentEntity , MagentoService_salesOrderShipmentEntity():New() )
			::oWSsalesOrderShipmentEntity[len(::oWSsalesOrderShipmentEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderShipmentEntity

WSSTRUCT MagentoService_salesOrderShipmentEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   cshipping_address_id      AS string OPTIONAL
	WSDATA   cshipping_firstname       AS string OPTIONAL
	WSDATA   cshipping_lastname        AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   corder_increment_id       AS string OPTIONAL
	WSDATA   corder_created_at         AS string OPTIONAL
	WSDATA   ctotal_qty                AS string OPTIONAL
	WSDATA   cshipment_id              AS string OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_salesOrderShipmentItemEntityArray OPTIONAL
	WSDATA   oWStracks                 AS MagentoService_salesOrderShipmentTrackEntityArray OPTIONAL
	WSDATA   oWScomments               AS MagentoService_salesOrderShipmentCommentEntityArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentEntity
	Local oClone := MagentoService_salesOrderShipmentEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:cstore_id            := ::cstore_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:cshipping_address_id := ::cshipping_address_id
	oClone:cshipping_firstname  := ::cshipping_firstname
	oClone:cshipping_lastname   := ::cshipping_lastname
	oClone:corder_id            := ::corder_id
	oClone:corder_increment_id  := ::corder_increment_id
	oClone:corder_created_at    := ::corder_created_at
	oClone:ctotal_qty           := ::ctotal_qty
	oClone:cshipment_id         := ::cshipment_id
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:oWStracks            := IIF(::oWStracks = NIL , NIL , ::oWStracks:Clone() )
	oClone:oWScomments          := IIF(::oWScomments = NIL , NIL , ::oWScomments:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentEntity
	Local oNode15
	Local oNode16
	Local oNode17
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_address_id :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_firstname :=  WSAdvValue( oResponse,"_SHIPPING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_lastname :=  WSAdvValue( oResponse,"_SHIPPING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_increment_id :=  WSAdvValue( oResponse,"_ORDER_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_created_at  :=  WSAdvValue( oResponse,"_ORDER_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_qty         :=  WSAdvValue( oResponse,"_TOTAL_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipment_id       :=  WSAdvValue( oResponse,"_SHIPMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode15 :=  WSAdvValue( oResponse,"_ITEMS","salesOrderShipmentItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode15 != NIL
		::oWSitems := MagentoService_salesOrderShipmentItemEntityArray():New()
		::oWSitems:SoapRecv(oNode15)
	EndIf
	oNode16 :=  WSAdvValue( oResponse,"_TRACKS","salesOrderShipmentTrackEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode16 != NIL
		::oWStracks := MagentoService_salesOrderShipmentTrackEntityArray():New()
		::oWStracks:SoapRecv(oNode16)
	EndIf
	oNode17 :=  WSAdvValue( oResponse,"_COMMENTS","salesOrderShipmentCommentEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode17 != NIL
		::oWScomments := MagentoService_salesOrderShipmentCommentEntityArray():New()
		::oWScomments:SoapRecv(oNode17)
	EndIf
Return

// WSDL Data Structure salesOrderShipmentTrackEntityArray

WSSTRUCT MagentoService_salesOrderShipmentTrackEntityArray
	WSDATA   oWSsalesOrderShipmentTrackEntity AS MagentoService_salesOrderShipmentTrackEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentTrackEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentTrackEntityArray
	::oWSsalesOrderShipmentTrackEntity := {} // Array Of  MagentoService_SALESORDERSHIPMENTTRACKENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentTrackEntityArray
	Local oClone := MagentoService_salesOrderShipmentTrackEntityArray():NEW()
	oClone:oWSsalesOrderShipmentTrackEntity := NIL
	If ::oWSsalesOrderShipmentTrackEntity <> NIL
		oClone:oWSsalesOrderShipmentTrackEntity := {}
		aEval( ::oWSsalesOrderShipmentTrackEntity , { |x| aadd( oClone:oWSsalesOrderShipmentTrackEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentTrackEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderShipmentTrackEntity , MagentoService_salesOrderShipmentTrackEntity():New() )
			::oWSsalesOrderShipmentTrackEntity[len(::oWSsalesOrderShipmentTrackEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderShipmentCommentEntityArray

WSSTRUCT MagentoService_salesOrderShipmentCommentEntityArray
	WSDATA   oWSsalesOrderShipmentCommentEntity AS MagentoService_salesOrderShipmentCommentEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentCommentEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentCommentEntityArray
	::oWSsalesOrderShipmentCommentEntity := {} // Array Of  MagentoService_SALESORDERSHIPMENTCOMMENTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentCommentEntityArray
	Local oClone := MagentoService_salesOrderShipmentCommentEntityArray():NEW()
	oClone:oWSsalesOrderShipmentCommentEntity := NIL
	If ::oWSsalesOrderShipmentCommentEntity <> NIL
		oClone:oWSsalesOrderShipmentCommentEntity := {}
		aEval( ::oWSsalesOrderShipmentCommentEntity , { |x| aadd( oClone:oWSsalesOrderShipmentCommentEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentCommentEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderShipmentCommentEntity , MagentoService_salesOrderShipmentCommentEntity():New() )
			::oWSsalesOrderShipmentCommentEntity[len(::oWSsalesOrderShipmentCommentEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure orderItemIdQtyArray

WSSTRUCT MagentoService_orderItemIdQtyArray
	WSDATA   oWSorderItemIdQty         AS MagentoService_orderItemIdQty OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_orderItemIdQtyArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_orderItemIdQtyArray
	::oWSorderItemIdQty    := {} // Array Of  MagentoService_ORDERITEMIDQTY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_orderItemIdQtyArray
	Local oClone := MagentoService_orderItemIdQtyArray():NEW()
	oClone:oWSorderItemIdQty := NIL
	If ::oWSorderItemIdQty <> NIL
		oClone:oWSorderItemIdQty := {}
		aEval( ::oWSorderItemIdQty , { |x| aadd( oClone:oWSorderItemIdQty , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_orderItemIdQtyArray
	Local cSoap := ""
	aEval( ::oWSorderItemIdQty , {|x| cSoap := cSoap  +  WSSoapValue("orderItemIdQty", x , x , "orderItemIdQty", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure orderItemIdQty

WSSTRUCT MagentoService_orderItemIdQty
	WSDATA   norder_item_id            AS int OPTIONAL
	WSDATA   nqty                      AS double OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_orderItemIdQty
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_orderItemIdQty
Return

WSMETHOD CLONE WSCLIENT MagentoService_orderItemIdQty
	Local oClone := MagentoService_orderItemIdQty():NEW()
	oClone:norder_item_id       := ::norder_item_id
	oClone:nqty                 := ::nqty
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_orderItemIdQty
	Local cSoap := ""
	cSoap += WSSoapValue("order_item_id", ::norder_item_id, ::norder_item_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("qty", ::nqty, ::nqty , "double", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure associativeEntity

WSSTRUCT MagentoService_associativeEntity
	WSDATA   ckey                      AS string OPTIONAL
	WSDATA   cvalue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_associativeEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_associativeEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_associativeEntity
	Local oClone := MagentoService_associativeEntity():NEW()
	oClone:ckey                 := ::ckey
	oClone:cvalue               := ::cvalue
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_associativeEntity
	Local cSoap := ""
	cSoap += WSSoapValue("key", ::ckey, ::ckey , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("value", ::cvalue, ::cvalue , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_associativeEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ckey               :=  WSAdvValue( oResponse,"_KEY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cvalue             :=  WSAdvValue( oResponse,"_VALUE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderInvoiceEntityArray

WSSTRUCT MagentoService_salesOrderInvoiceEntityArray
	WSDATA   oWSsalesOrderInvoiceEntity AS MagentoService_salesOrderInvoiceEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderInvoiceEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderInvoiceEntityArray
	::oWSsalesOrderInvoiceEntity := {} // Array Of  MagentoService_SALESORDERINVOICEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderInvoiceEntityArray
	Local oClone := MagentoService_salesOrderInvoiceEntityArray():NEW()
	oClone:oWSsalesOrderInvoiceEntity := NIL
	If ::oWSsalesOrderInvoiceEntity <> NIL
		oClone:oWSsalesOrderInvoiceEntity := {}
		aEval( ::oWSsalesOrderInvoiceEntity , { |x| aadd( oClone:oWSsalesOrderInvoiceEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderInvoiceEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderInvoiceEntity , MagentoService_salesOrderInvoiceEntity():New() )
			::oWSsalesOrderInvoiceEntity[len(::oWSsalesOrderInvoiceEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderInvoiceEntity

WSSTRUCT MagentoService_salesOrderInvoiceEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   cglobal_currency_code     AS string OPTIONAL
	WSDATA   cbase_currency_code       AS string OPTIONAL
	WSDATA   cstore_currency_code      AS string OPTIONAL
	WSDATA   corder_currency_code      AS string OPTIONAL
	WSDATA   cstore_to_base_rate       AS string OPTIONAL
	WSDATA   cstore_to_order_rate      AS string OPTIONAL
	WSDATA   cbase_to_global_rate      AS string OPTIONAL
	WSDATA   cbase_to_order_rate       AS string OPTIONAL
	WSDATA   csubtotal                 AS string OPTIONAL
	WSDATA   cbase_subtotal            AS string OPTIONAL
	WSDATA   cbase_grand_total         AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cbase_shipping_amount     AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cbilling_address_id       AS string OPTIONAL
	WSDATA   cbilling_firstname        AS string OPTIONAL
	WSDATA   cbilling_lastname         AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   corder_increment_id       AS string OPTIONAL
	WSDATA   corder_created_at         AS string OPTIONAL
	WSDATA   cstate                    AS string OPTIONAL
	WSDATA   cgrand_total              AS string OPTIONAL
	WSDATA   cinvoice_id               AS string OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_salesOrderInvoiceItemEntityArray OPTIONAL
	WSDATA   oWScomments               AS MagentoService_salesOrderInvoiceCommentEntityArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderInvoiceEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderInvoiceEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderInvoiceEntity
	Local oClone := MagentoService_salesOrderInvoiceEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:cstore_id            := ::cstore_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:cglobal_currency_code := ::cglobal_currency_code
	oClone:cbase_currency_code  := ::cbase_currency_code
	oClone:cstore_currency_code := ::cstore_currency_code
	oClone:corder_currency_code := ::corder_currency_code
	oClone:cstore_to_base_rate  := ::cstore_to_base_rate
	oClone:cstore_to_order_rate := ::cstore_to_order_rate
	oClone:cbase_to_global_rate := ::cbase_to_global_rate
	oClone:cbase_to_order_rate  := ::cbase_to_order_rate
	oClone:csubtotal            := ::csubtotal
	oClone:cbase_subtotal       := ::cbase_subtotal
	oClone:cbase_grand_total    := ::cbase_grand_total
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cbase_shipping_amount := ::cbase_shipping_amount
	oClone:ctax_amount          := ::ctax_amount
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cbilling_address_id  := ::cbilling_address_id
	oClone:cbilling_firstname   := ::cbilling_firstname
	oClone:cbilling_lastname    := ::cbilling_lastname
	oClone:corder_id            := ::corder_id
	oClone:corder_increment_id  := ::corder_increment_id
	oClone:corder_created_at    := ::corder_created_at
	oClone:cstate               := ::cstate
	oClone:cgrand_total         := ::cgrand_total
	oClone:cinvoice_id          := ::cinvoice_id
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:oWScomments          := IIF(::oWScomments = NIL , NIL , ::oWScomments:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderInvoiceEntity
	Local oNode33
	Local oNode34
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cglobal_currency_code :=  WSAdvValue( oResponse,"_GLOBAL_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_currency_code :=  WSAdvValue( oResponse,"_BASE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_currency_code :=  WSAdvValue( oResponse,"_STORE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_currency_code :=  WSAdvValue( oResponse,"_ORDER_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_base_rate :=  WSAdvValue( oResponse,"_STORE_TO_BASE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_order_rate :=  WSAdvValue( oResponse,"_STORE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_global_rate :=  WSAdvValue( oResponse,"_BASE_TO_GLOBAL_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_order_rate :=  WSAdvValue( oResponse,"_BASE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal          :=  WSAdvValue( oResponse,"_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal     :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_grand_total  :=  WSAdvValue( oResponse,"_BASE_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_amount   :=  WSAdvValue( oResponse,"_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_address_id :=  WSAdvValue( oResponse,"_BILLING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_firstname :=  WSAdvValue( oResponse,"_BILLING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_lastname  :=  WSAdvValue( oResponse,"_BILLING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_increment_id :=  WSAdvValue( oResponse,"_ORDER_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_created_at  :=  WSAdvValue( oResponse,"_ORDER_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstate             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgrand_total       :=  WSAdvValue( oResponse,"_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cinvoice_id        :=  WSAdvValue( oResponse,"_INVOICE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode33 :=  WSAdvValue( oResponse,"_ITEMS","salesOrderInvoiceItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode33 != NIL
		::oWSitems := MagentoService_salesOrderInvoiceItemEntityArray():New()
		::oWSitems:SoapRecv(oNode33)
	EndIf
	oNode34 :=  WSAdvValue( oResponse,"_COMMENTS","salesOrderInvoiceCommentEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode34 != NIL
		::oWScomments := MagentoService_salesOrderInvoiceCommentEntityArray():New()
		::oWScomments:SoapRecv(oNode34)
	EndIf
Return

// WSDL Data Structure salesOrderCreditmemoEntityArray

WSSTRUCT MagentoService_salesOrderCreditmemoEntityArray
	WSDATA   oWSsalesOrderCreditmemoEntity AS MagentoService_salesOrderCreditmemoEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoEntityArray
	::oWSsalesOrderCreditmemoEntity := {} // Array Of  MagentoService_SALESORDERCREDITMEMOENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoEntityArray
	Local oClone := MagentoService_salesOrderCreditmemoEntityArray():NEW()
	oClone:oWSsalesOrderCreditmemoEntity := NIL
	If ::oWSsalesOrderCreditmemoEntity <> NIL
		oClone:oWSsalesOrderCreditmemoEntity := {}
		aEval( ::oWSsalesOrderCreditmemoEntity , { |x| aadd( oClone:oWSsalesOrderCreditmemoEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderCreditmemoEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderCreditmemoEntity , MagentoService_salesOrderCreditmemoEntity():New() )
			::oWSsalesOrderCreditmemoEntity[len(::oWSsalesOrderCreditmemoEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderCreditmemoEntity

WSSTRUCT MagentoService_salesOrderCreditmemoEntity
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   ctransaction_id           AS string OPTIONAL
	WSDATA   cglobal_currency_code     AS string OPTIONAL
	WSDATA   cbase_currency_code       AS string OPTIONAL
	WSDATA   corder_currency_code      AS string OPTIONAL
	WSDATA   cstore_currency_code      AS string OPTIONAL
	WSDATA   ccybersource_token        AS string OPTIONAL
	WSDATA   cinvoice_id               AS string OPTIONAL
	WSDATA   cbilling_address_id       AS string OPTIONAL
	WSDATA   cshipping_address_id      AS string OPTIONAL
	WSDATA   cstate                    AS string OPTIONAL
	WSDATA   ccreditmemo_status        AS string OPTIONAL
	WSDATA   cemail_sent               AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cshipping_tax_amount      AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cbase_adjustment_positive AS string OPTIONAL
	WSDATA   cbase_grand_total         AS string OPTIONAL
	WSDATA   cadjustment               AS string OPTIONAL
	WSDATA   csubtotal                 AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   cbase_subtotal            AS string OPTIONAL
	WSDATA   cbase_adjustment          AS string OPTIONAL
	WSDATA   cbase_to_global_rate      AS string OPTIONAL
	WSDATA   cstore_to_base_rate       AS string OPTIONAL
	WSDATA   cbase_shipping_amount     AS string OPTIONAL
	WSDATA   cadjustment_negative      AS string OPTIONAL
	WSDATA   csubtotal_incl_tax        AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cbase_subtotal_incl_tax   AS string OPTIONAL
	WSDATA   cbase_adjustment_negative AS string OPTIONAL
	WSDATA   cgrand_total              AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cbase_to_order_rate       AS string OPTIONAL
	WSDATA   cstore_to_order_rate      AS string OPTIONAL
	WSDATA   cbase_shipping_tax_amount AS string OPTIONAL
	WSDATA   cadjustment_positive      AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   chidden_tax_amount        AS string OPTIONAL
	WSDATA   cbase_hidden_tax_amount   AS string OPTIONAL
	WSDATA   cshipping_hidden_tax_amount AS string OPTIONAL
	WSDATA   cbase_shipping_hidden_tax_amnt AS string OPTIONAL
	WSDATA   cshipping_incl_tax        AS string OPTIONAL
	WSDATA   cbase_shipping_incl_tax   AS string OPTIONAL
	WSDATA   cbase_customer_balance_amount AS string OPTIONAL
	WSDATA   ccustomer_balance_amount  AS string OPTIONAL
	WSDATA   cbs_customer_bal_total_refunded AS string OPTIONAL
	WSDATA   ccustomer_bal_total_refunded AS string OPTIONAL
	WSDATA   cbase_gift_cards_amount   AS string OPTIONAL
	WSDATA   cgift_cards_amount        AS string OPTIONAL
	WSDATA   cgw_base_price            AS string OPTIONAL
	WSDATA   cgw_price                 AS string OPTIONAL
	WSDATA   cgw_items_base_price      AS string OPTIONAL
	WSDATA   cgw_items_price           AS string OPTIONAL
	WSDATA   cgw_card_base_price       AS string OPTIONAL
	WSDATA   cgw_card_price            AS string OPTIONAL
	WSDATA   cgw_base_tax_amount       AS string OPTIONAL
	WSDATA   cgw_tax_amount            AS string OPTIONAL
	WSDATA   cgw_items_base_tax_amount AS string OPTIONAL
	WSDATA   cgw_items_tax_amount      AS string OPTIONAL
	WSDATA   cgw_card_base_tax_amount  AS string OPTIONAL
	WSDATA   cgw_card_tax_amount       AS string OPTIONAL
	WSDATA   cbase_reward_currency_amount AS string OPTIONAL
	WSDATA   creward_currency_amount   AS string OPTIONAL
	WSDATA   creward_points_balance    AS string OPTIONAL
	WSDATA   creward_points_balance_refund AS string OPTIONAL
	WSDATA   ccreditmemo_id            AS string OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_salesOrderCreditmemoItemEntityArray OPTIONAL
	WSDATA   oWScomments               AS MagentoService_salesOrderCreditmemoCommentEntityArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoEntity
	Local oClone := MagentoService_salesOrderCreditmemoEntity():NEW()
	oClone:cupdated_at          := ::cupdated_at
	oClone:ccreated_at          := ::ccreated_at
	oClone:cincrement_id        := ::cincrement_id
	oClone:ctransaction_id      := ::ctransaction_id
	oClone:cglobal_currency_code := ::cglobal_currency_code
	oClone:cbase_currency_code  := ::cbase_currency_code
	oClone:corder_currency_code := ::corder_currency_code
	oClone:cstore_currency_code := ::cstore_currency_code
	oClone:ccybersource_token   := ::ccybersource_token
	oClone:cinvoice_id          := ::cinvoice_id
	oClone:cbilling_address_id  := ::cbilling_address_id
	oClone:cshipping_address_id := ::cshipping_address_id
	oClone:cstate               := ::cstate
	oClone:ccreditmemo_status   := ::ccreditmemo_status
	oClone:cemail_sent          := ::cemail_sent
	oClone:corder_id            := ::corder_id
	oClone:ctax_amount          := ::ctax_amount
	oClone:cshipping_tax_amount := ::cshipping_tax_amount
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cbase_adjustment_positive := ::cbase_adjustment_positive
	oClone:cbase_grand_total    := ::cbase_grand_total
	oClone:cadjustment          := ::cadjustment
	oClone:csubtotal            := ::csubtotal
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:cbase_subtotal       := ::cbase_subtotal
	oClone:cbase_adjustment     := ::cbase_adjustment
	oClone:cbase_to_global_rate := ::cbase_to_global_rate
	oClone:cstore_to_base_rate  := ::cstore_to_base_rate
	oClone:cbase_shipping_amount := ::cbase_shipping_amount
	oClone:cadjustment_negative := ::cadjustment_negative
	oClone:csubtotal_incl_tax   := ::csubtotal_incl_tax
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cbase_subtotal_incl_tax := ::cbase_subtotal_incl_tax
	oClone:cbase_adjustment_negative := ::cbase_adjustment_negative
	oClone:cgrand_total         := ::cgrand_total
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cbase_to_order_rate  := ::cbase_to_order_rate
	oClone:cstore_to_order_rate := ::cstore_to_order_rate
	oClone:cbase_shipping_tax_amount := ::cbase_shipping_tax_amount
	oClone:cadjustment_positive := ::cadjustment_positive
	oClone:cstore_id            := ::cstore_id
	oClone:chidden_tax_amount   := ::chidden_tax_amount
	oClone:cbase_hidden_tax_amount := ::cbase_hidden_tax_amount
	oClone:cshipping_hidden_tax_amount := ::cshipping_hidden_tax_amount
	oClone:cbase_shipping_hidden_tax_amnt := ::cbase_shipping_hidden_tax_amnt
	oClone:cshipping_incl_tax   := ::cshipping_incl_tax
	oClone:cbase_shipping_incl_tax := ::cbase_shipping_incl_tax
	oClone:cbase_customer_balance_amount := ::cbase_customer_balance_amount
	oClone:ccustomer_balance_amount := ::ccustomer_balance_amount
	oClone:cbs_customer_bal_total_refunded := ::cbs_customer_bal_total_refunded
	oClone:ccustomer_bal_total_refunded := ::ccustomer_bal_total_refunded
	oClone:cbase_gift_cards_amount := ::cbase_gift_cards_amount
	oClone:cgift_cards_amount   := ::cgift_cards_amount
	oClone:cgw_base_price       := ::cgw_base_price
	oClone:cgw_price            := ::cgw_price
	oClone:cgw_items_base_price := ::cgw_items_base_price
	oClone:cgw_items_price      := ::cgw_items_price
	oClone:cgw_card_base_price  := ::cgw_card_base_price
	oClone:cgw_card_price       := ::cgw_card_price
	oClone:cgw_base_tax_amount  := ::cgw_base_tax_amount
	oClone:cgw_tax_amount       := ::cgw_tax_amount
	oClone:cgw_items_base_tax_amount := ::cgw_items_base_tax_amount
	oClone:cgw_items_tax_amount := ::cgw_items_tax_amount
	oClone:cgw_card_base_tax_amount := ::cgw_card_base_tax_amount
	oClone:cgw_card_tax_amount  := ::cgw_card_tax_amount
	oClone:cbase_reward_currency_amount := ::cbase_reward_currency_amount
	oClone:creward_currency_amount := ::creward_currency_amount
	oClone:creward_points_balance := ::creward_points_balance
	oClone:creward_points_balance_refund := ::creward_points_balance_refund
	oClone:ccreditmemo_id       := ::ccreditmemo_id
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:oWScomments          := IIF(::oWScomments = NIL , NIL , ::oWScomments:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderCreditmemoEntity
	Local oNode71
	Local oNode72
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctransaction_id    :=  WSAdvValue( oResponse,"_TRANSACTION_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cglobal_currency_code :=  WSAdvValue( oResponse,"_GLOBAL_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_currency_code :=  WSAdvValue( oResponse,"_BASE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_currency_code :=  WSAdvValue( oResponse,"_ORDER_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_currency_code :=  WSAdvValue( oResponse,"_STORE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccybersource_token :=  WSAdvValue( oResponse,"_CYBERSOURCE_TOKEN","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cinvoice_id        :=  WSAdvValue( oResponse,"_INVOICE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_address_id :=  WSAdvValue( oResponse,"_BILLING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_address_id :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstate             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreditmemo_status :=  WSAdvValue( oResponse,"_CREDITMEMO_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cemail_sent        :=  WSAdvValue( oResponse,"_EMAIL_SENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_tax_amount :=  WSAdvValue( oResponse,"_SHIPPING_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_adjustment_positive :=  WSAdvValue( oResponse,"_BASE_ADJUSTMENT_POSITIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_grand_total  :=  WSAdvValue( oResponse,"_BASE_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadjustment        :=  WSAdvValue( oResponse,"_ADJUSTMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal          :=  WSAdvValue( oResponse,"_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal     :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_adjustment   :=  WSAdvValue( oResponse,"_BASE_ADJUSTMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_global_rate :=  WSAdvValue( oResponse,"_BASE_TO_GLOBAL_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_base_rate :=  WSAdvValue( oResponse,"_STORE_TO_BASE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadjustment_negative :=  WSAdvValue( oResponse,"_ADJUSTMENT_NEGATIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal_incl_tax :=  WSAdvValue( oResponse,"_SUBTOTAL_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_amount   :=  WSAdvValue( oResponse,"_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal_incl_tax :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_adjustment_negative :=  WSAdvValue( oResponse,"_BASE_ADJUSTMENT_NEGATIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgrand_total       :=  WSAdvValue( oResponse,"_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_order_rate :=  WSAdvValue( oResponse,"_BASE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_order_rate :=  WSAdvValue( oResponse,"_STORE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_tax_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadjustment_positive :=  WSAdvValue( oResponse,"_ADJUSTMENT_POSITIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chidden_tax_amount :=  WSAdvValue( oResponse,"_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_hidden_tax_amount :=  WSAdvValue( oResponse,"_BASE_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_hidden_tax_amount :=  WSAdvValue( oResponse,"_SHIPPING_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_hidden_tax_amnt :=  WSAdvValue( oResponse,"_BASE_SHIPPING_HIDDEN_TAX_AMNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_incl_tax :=  WSAdvValue( oResponse,"_SHIPPING_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_incl_tax :=  WSAdvValue( oResponse,"_BASE_SHIPPING_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_customer_balance_amount :=  WSAdvValue( oResponse,"_BASE_CUSTOMER_BALANCE_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_balance_amount :=  WSAdvValue( oResponse,"_CUSTOMER_BALANCE_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbs_customer_bal_total_refunded :=  WSAdvValue( oResponse,"_BS_CUSTOMER_BAL_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_bal_total_refunded :=  WSAdvValue( oResponse,"_CUSTOMER_BAL_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_gift_cards_amount :=  WSAdvValue( oResponse,"_BASE_GIFT_CARDS_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards_amount :=  WSAdvValue( oResponse,"_GIFT_CARDS_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_base_price     :=  WSAdvValue( oResponse,"_GW_BASE_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_price          :=  WSAdvValue( oResponse,"_GW_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_items_base_price :=  WSAdvValue( oResponse,"_GW_ITEMS_BASE_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_items_price    :=  WSAdvValue( oResponse,"_GW_ITEMS_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_card_base_price :=  WSAdvValue( oResponse,"_GW_CARD_BASE_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_card_price     :=  WSAdvValue( oResponse,"_GW_CARD_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_base_tax_amount :=  WSAdvValue( oResponse,"_GW_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_tax_amount     :=  WSAdvValue( oResponse,"_GW_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_items_base_tax_amount :=  WSAdvValue( oResponse,"_GW_ITEMS_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_items_tax_amount :=  WSAdvValue( oResponse,"_GW_ITEMS_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_card_base_tax_amount :=  WSAdvValue( oResponse,"_GW_CARD_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgw_card_tax_amount :=  WSAdvValue( oResponse,"_GW_CARD_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_reward_currency_amount :=  WSAdvValue( oResponse,"_BASE_REWARD_CURRENCY_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_currency_amount :=  WSAdvValue( oResponse,"_REWARD_CURRENCY_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_points_balance :=  WSAdvValue( oResponse,"_REWARD_POINTS_BALANCE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_points_balance_refund :=  WSAdvValue( oResponse,"_REWARD_POINTS_BALANCE_REFUND","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreditmemo_id     :=  WSAdvValue( oResponse,"_CREDITMEMO_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode71 :=  WSAdvValue( oResponse,"_ITEMS","salesOrderCreditmemoItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode71 != NIL
		::oWSitems := MagentoService_salesOrderCreditmemoItemEntityArray():New()
		::oWSitems:SoapRecv(oNode71)
	EndIf
	oNode72 :=  WSAdvValue( oResponse,"_COMMENTS","salesOrderCreditmemoCommentEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode72 != NIL
		::oWScomments := MagentoService_salesOrderCreditmemoCommentEntityArray():New()
		::oWScomments:SoapRecv(oNode72)
	EndIf
Return

// WSDL Data Structure salesOrderCreditmemoData

WSSTRUCT MagentoService_salesOrderCreditmemoData
	WSDATA   oWSqtys                   AS MagentoService_orderItemIdQtyArray OPTIONAL
	WSDATA   nshipping_amount          AS double OPTIONAL
	WSDATA   nadjustment_positive      AS double OPTIONAL
	WSDATA   nadjustment_negative      AS double OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoData
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoData
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoData
	Local oClone := MagentoService_salesOrderCreditmemoData():NEW()
	oClone:oWSqtys              := IIF(::oWSqtys = NIL , NIL , ::oWSqtys:Clone() )
	oClone:nshipping_amount     := ::nshipping_amount
	oClone:nadjustment_positive := ::nadjustment_positive
	oClone:nadjustment_negative := ::nadjustment_negative
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_salesOrderCreditmemoData
	Local cSoap := ""
	cSoap += WSSoapValue("qtys", ::oWSqtys, ::oWSqtys , "orderItemIdQtyArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipping_amount", ::nshipping_amount, ::nshipping_amount , "double", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("adjustment_positive", ::nadjustment_positive, ::nadjustment_positive , "double", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("adjustment_negative", ::nadjustment_negative, ::nadjustment_negative , "double", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogInventoryStockItemEntityArray

WSSTRUCT MagentoService_catalogInventoryStockItemEntityArray
	WSDATA   oWScatalogInventoryStockItemEntity AS MagentoService_catalogInventoryStockItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogInventoryStockItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogInventoryStockItemEntityArray
	::oWScatalogInventoryStockItemEntity := {} // Array Of  MagentoService_CATALOGINVENTORYSTOCKITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogInventoryStockItemEntityArray
	Local oClone := MagentoService_catalogInventoryStockItemEntityArray():NEW()
	oClone:oWScatalogInventoryStockItemEntity := NIL
	If ::oWScatalogInventoryStockItemEntity <> NIL
		oClone:oWScatalogInventoryStockItemEntity := {}
		aEval( ::oWScatalogInventoryStockItemEntity , { |x| aadd( oClone:oWScatalogInventoryStockItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogInventoryStockItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogInventoryStockItemEntity , MagentoService_catalogInventoryStockItemEntity():New() )
			::oWScatalogInventoryStockItemEntity[len(::oWScatalogInventoryStockItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogInventoryStockItemEntity

WSSTRUCT MagentoService_catalogInventoryStockItemEntity
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSDATA   cis_in_stock              AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogInventoryStockItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogInventoryStockItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogInventoryStockItemEntity
	Local oClone := MagentoService_catalogInventoryStockItemEntity():NEW()
	oClone:cproduct_id          := ::cproduct_id
	oClone:csku                 := ::csku
	oClone:cqty                 := ::cqty
	oClone:cis_in_stock         := ::cis_in_stock
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogInventoryStockItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty               :=  WSAdvValue( oResponse,"_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_in_stock       :=  WSAdvValue( oResponse,"_IS_IN_STOCK","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogInventoryStockItemUpdateEntityArray

WSSTRUCT MagentoService_catalogInventoryStockItemUpdateEntityArray
	WSDATA   oWScatalogInventoryStockItemUpdateEntity AS MagentoService_catalogInventoryStockItemUpdateEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntityArray
	::oWScatalogInventoryStockItemUpdateEntity := {} // Array Of  MagentoService_CATALOGINVENTORYSTOCKITEMUPDATEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntityArray
	Local oClone := MagentoService_catalogInventoryStockItemUpdateEntityArray():NEW()
	oClone:oWScatalogInventoryStockItemUpdateEntity := NIL
	If ::oWScatalogInventoryStockItemUpdateEntity <> NIL
		oClone:oWScatalogInventoryStockItemUpdateEntity := {}
		aEval( ::oWScatalogInventoryStockItemUpdateEntity , { |x| aadd( oClone:oWScatalogInventoryStockItemUpdateEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogInventoryStockItemUpdateEntityArray
	Local cSoap := ""
	aEval( ::oWScatalogInventoryStockItemUpdateEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogInventoryStockItemUpdateEntity", x , x , "catalogInventoryStockItemUpdateEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure shoppingCartInfoEntity

WSSTRUCT MagentoService_shoppingCartInfoEntity
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cconverted_at             AS string OPTIONAL
	WSDATA   nquote_id                 AS int OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSDATA   nis_virtual               AS int OPTIONAL
	WSDATA   nis_multi_shipping        AS int OPTIONAL
	WSDATA   nitems_count              AS double OPTIONAL
	WSDATA   nitems_qty                AS double OPTIONAL
	WSDATA   corig_order_id            AS string OPTIONAL
	WSDATA   cstore_to_base_rate       AS string OPTIONAL
	WSDATA   cstore_to_quote_rate      AS string OPTIONAL
	WSDATA   cbase_currency_code       AS string OPTIONAL
	WSDATA   cstore_currency_code      AS string OPTIONAL
	WSDATA   cquote_currency_code      AS string OPTIONAL
	WSDATA   cgrand_total              AS string OPTIONAL
	WSDATA   cbase_grand_total         AS string OPTIONAL
	WSDATA   ccheckout_method          AS string OPTIONAL
	WSDATA   ccustomer_id              AS string OPTIONAL
	WSDATA   ccustomer_tax_class_id    AS string OPTIONAL
	WSDATA   ncustomer_group_id        AS int OPTIONAL
	WSDATA   ccustomer_email           AS string OPTIONAL
	WSDATA   ccustomer_prefix          AS string OPTIONAL
	WSDATA   ccustomer_firstname       AS string OPTIONAL
	WSDATA   ccustomer_middlename      AS string OPTIONAL
	WSDATA   ccustomer_lastname        AS string OPTIONAL
	WSDATA   ccustomer_taxvat          AS string OPTIONAL
	WSDATA   ccustomer_suffix          AS string OPTIONAL
	WSDATA   ccustomer_note            AS string OPTIONAL
	WSDATA   ccustomer_note_notify     AS string OPTIONAL
	WSDATA   ccustomer_is_guest        AS string OPTIONAL
	WSDATA   capplied_rule_ids         AS string OPTIONAL
	WSDATA   creserved_order_id        AS string OPTIONAL
	WSDATA   cpassword_hash            AS string OPTIONAL
	WSDATA   ccoupon_code              AS string OPTIONAL
	WSDATA   cglobal_currency_code     AS string OPTIONAL
	WSDATA   nbase_to_global_rate      AS double OPTIONAL
	WSDATA   nbase_to_quote_rate       AS double OPTIONAL
	WSDATA   ccustomer_gender          AS string OPTIONAL
	WSDATA   nsubtotal                 AS double OPTIONAL
	WSDATA   nbase_subtotal            AS double OPTIONAL
	WSDATA   nsubtotal_with_discount   AS double OPTIONAL
	WSDATA   nbase_subtotal_with_discount AS double OPTIONAL
	WSDATA   cext_shipping_info        AS string OPTIONAL
	WSDATA   cgift_message_id          AS string OPTIONAL
	WSDATA   cgift_message             AS string OPTIONAL
	WSDATA   ncustomer_balance_amount_used AS double OPTIONAL
	WSDATA   nbase_customer_balance_amount_used AS double OPTIONAL
	WSDATA   cuse_customer_balance     AS string OPTIONAL
	WSDATA   cgift_cards_amount        AS string OPTIONAL
	WSDATA   cbase_gift_cards_amount   AS string OPTIONAL
	WSDATA   cgift_cards_amount_used   AS string OPTIONAL
	WSDATA   cuse_reward_points        AS string OPTIONAL
	WSDATA   creward_points_balance    AS string OPTIONAL
	WSDATA   cbase_reward_currency_amount AS string OPTIONAL
	WSDATA   creward_currency_amount   AS string OPTIONAL
	WSDATA   oWSshipping_address       AS MagentoService_shoppingCartAddressEntity OPTIONAL
	WSDATA   oWSbilling_address        AS MagentoService_shoppingCartAddressEntity OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_shoppingCartItemEntityArray OPTIONAL
	WSDATA   oWSpayment                AS MagentoService_shoppingCartPaymentEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartInfoEntity
	Local oClone := MagentoService_shoppingCartInfoEntity():NEW()
	oClone:cstore_id            := ::cstore_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cconverted_at        := ::cconverted_at
	oClone:nquote_id            := ::nquote_id
	oClone:nis_active           := ::nis_active
	oClone:nis_virtual          := ::nis_virtual
	oClone:nis_multi_shipping   := ::nis_multi_shipping
	oClone:nitems_count         := ::nitems_count
	oClone:nitems_qty           := ::nitems_qty
	oClone:corig_order_id       := ::corig_order_id
	oClone:cstore_to_base_rate  := ::cstore_to_base_rate
	oClone:cstore_to_quote_rate := ::cstore_to_quote_rate
	oClone:cbase_currency_code  := ::cbase_currency_code
	oClone:cstore_currency_code := ::cstore_currency_code
	oClone:cquote_currency_code := ::cquote_currency_code
	oClone:cgrand_total         := ::cgrand_total
	oClone:cbase_grand_total    := ::cbase_grand_total
	oClone:ccheckout_method     := ::ccheckout_method
	oClone:ccustomer_id         := ::ccustomer_id
	oClone:ccustomer_tax_class_id := ::ccustomer_tax_class_id
	oClone:ncustomer_group_id   := ::ncustomer_group_id
	oClone:ccustomer_email      := ::ccustomer_email
	oClone:ccustomer_prefix     := ::ccustomer_prefix
	oClone:ccustomer_firstname  := ::ccustomer_firstname
	oClone:ccustomer_middlename := ::ccustomer_middlename
	oClone:ccustomer_lastname   := ::ccustomer_lastname
	oClone:ccustomer_taxvat     := ::ccustomer_taxvat
	oClone:ccustomer_suffix     := ::ccustomer_suffix
	oClone:ccustomer_note       := ::ccustomer_note
	oClone:ccustomer_note_notify := ::ccustomer_note_notify
	oClone:ccustomer_is_guest   := ::ccustomer_is_guest
	oClone:capplied_rule_ids    := ::capplied_rule_ids
	oClone:creserved_order_id   := ::creserved_order_id
	oClone:cpassword_hash       := ::cpassword_hash
	oClone:ccoupon_code         := ::ccoupon_code
	oClone:cglobal_currency_code := ::cglobal_currency_code
	oClone:nbase_to_global_rate := ::nbase_to_global_rate
	oClone:nbase_to_quote_rate  := ::nbase_to_quote_rate
	oClone:ccustomer_gender     := ::ccustomer_gender
	oClone:nsubtotal            := ::nsubtotal
	oClone:nbase_subtotal       := ::nbase_subtotal
	oClone:nsubtotal_with_discount := ::nsubtotal_with_discount
	oClone:nbase_subtotal_with_discount := ::nbase_subtotal_with_discount
	oClone:cext_shipping_info   := ::cext_shipping_info
	oClone:cgift_message_id     := ::cgift_message_id
	oClone:cgift_message        := ::cgift_message
	oClone:ncustomer_balance_amount_used := ::ncustomer_balance_amount_used
	oClone:nbase_customer_balance_amount_used := ::nbase_customer_balance_amount_used
	oClone:cuse_customer_balance := ::cuse_customer_balance
	oClone:cgift_cards_amount   := ::cgift_cards_amount
	oClone:cbase_gift_cards_amount := ::cbase_gift_cards_amount
	oClone:cgift_cards_amount_used := ::cgift_cards_amount_used
	oClone:cuse_reward_points   := ::cuse_reward_points
	oClone:creward_points_balance := ::creward_points_balance
	oClone:cbase_reward_currency_amount := ::cbase_reward_currency_amount
	oClone:creward_currency_amount := ::creward_currency_amount
	oClone:oWSshipping_address  := IIF(::oWSshipping_address = NIL , NIL , ::oWSshipping_address:Clone() )
	oClone:oWSbilling_address   := IIF(::oWSbilling_address = NIL , NIL , ::oWSbilling_address:Clone() )
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:oWSpayment           := IIF(::oWSpayment = NIL , NIL , ::oWSpayment:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartInfoEntity
	Local oNode58
	Local oNode59
	Local oNode60
	Local oNode61
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cconverted_at      :=  WSAdvValue( oResponse,"_CONVERTED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nquote_id          :=  WSAdvValue( oResponse,"_QUOTE_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_virtual        :=  WSAdvValue( oResponse,"_IS_VIRTUAL","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_multi_shipping :=  WSAdvValue( oResponse,"_IS_MULTI_SHIPPING","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nitems_count       :=  WSAdvValue( oResponse,"_ITEMS_COUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nitems_qty         :=  WSAdvValue( oResponse,"_ITEMS_QTY","double",NIL,NIL,NIL,"N",NIL,NIL)
	::corig_order_id     :=  WSAdvValue( oResponse,"_ORIG_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_base_rate :=  WSAdvValue( oResponse,"_STORE_TO_BASE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_quote_rate :=  WSAdvValue( oResponse,"_STORE_TO_QUOTE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_currency_code :=  WSAdvValue( oResponse,"_BASE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_currency_code :=  WSAdvValue( oResponse,"_STORE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cquote_currency_code :=  WSAdvValue( oResponse,"_QUOTE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgrand_total       :=  WSAdvValue( oResponse,"_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_grand_total  :=  WSAdvValue( oResponse,"_BASE_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccheckout_method   :=  WSAdvValue( oResponse,"_CHECKOUT_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_id       :=  WSAdvValue( oResponse,"_CUSTOMER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_tax_class_id :=  WSAdvValue( oResponse,"_CUSTOMER_TAX_CLASS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ncustomer_group_id :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccustomer_email    :=  WSAdvValue( oResponse,"_CUSTOMER_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_prefix   :=  WSAdvValue( oResponse,"_CUSTOMER_PREFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_firstname :=  WSAdvValue( oResponse,"_CUSTOMER_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_middlename :=  WSAdvValue( oResponse,"_CUSTOMER_MIDDLENAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_lastname :=  WSAdvValue( oResponse,"_CUSTOMER_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_taxvat   :=  WSAdvValue( oResponse,"_CUSTOMER_TAXVAT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_suffix   :=  WSAdvValue( oResponse,"_CUSTOMER_SUFFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_note     :=  WSAdvValue( oResponse,"_CUSTOMER_NOTE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_note_notify :=  WSAdvValue( oResponse,"_CUSTOMER_NOTE_NOTIFY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_is_guest :=  WSAdvValue( oResponse,"_CUSTOMER_IS_GUEST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::capplied_rule_ids  :=  WSAdvValue( oResponse,"_APPLIED_RULE_IDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creserved_order_id :=  WSAdvValue( oResponse,"_RESERVED_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpassword_hash     :=  WSAdvValue( oResponse,"_PASSWORD_HASH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccoupon_code       :=  WSAdvValue( oResponse,"_COUPON_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cglobal_currency_code :=  WSAdvValue( oResponse,"_GLOBAL_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nbase_to_global_rate :=  WSAdvValue( oResponse,"_BASE_TO_GLOBAL_RATE","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_to_quote_rate :=  WSAdvValue( oResponse,"_BASE_TO_QUOTE_RATE","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ccustomer_gender   :=  WSAdvValue( oResponse,"_CUSTOMER_GENDER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nsubtotal          :=  WSAdvValue( oResponse,"_SUBTOTAL","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_subtotal     :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nsubtotal_with_discount :=  WSAdvValue( oResponse,"_SUBTOTAL_WITH_DISCOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_subtotal_with_discount :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL_WITH_DISCOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::cext_shipping_info :=  WSAdvValue( oResponse,"_EXT_SHIPPING_INFO","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_id   :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message      :=  WSAdvValue( oResponse,"_GIFT_MESSAGE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ncustomer_balance_amount_used :=  WSAdvValue( oResponse,"_CUSTOMER_BALANCE_AMOUNT_USED","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_customer_balance_amount_used :=  WSAdvValue( oResponse,"_BASE_CUSTOMER_BALANCE_AMOUNT_USED","double",NIL,NIL,NIL,"N",NIL,NIL)
	::cuse_customer_balance :=  WSAdvValue( oResponse,"_USE_CUSTOMER_BALANCE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards_amount :=  WSAdvValue( oResponse,"_GIFT_CARDS_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_gift_cards_amount :=  WSAdvValue( oResponse,"_BASE_GIFT_CARDS_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_cards_amount_used :=  WSAdvValue( oResponse,"_GIFT_CARDS_AMOUNT_USED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cuse_reward_points :=  WSAdvValue( oResponse,"_USE_REWARD_POINTS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_points_balance :=  WSAdvValue( oResponse,"_REWARD_POINTS_BALANCE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_reward_currency_amount :=  WSAdvValue( oResponse,"_BASE_REWARD_CURRENCY_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::creward_currency_amount :=  WSAdvValue( oResponse,"_REWARD_CURRENCY_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode58 :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS","shoppingCartAddressEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode58 != NIL
		::oWSshipping_address := MagentoService_shoppingCartAddressEntity():New()
		::oWSshipping_address:SoapRecv(oNode58)
	EndIf
	oNode59 :=  WSAdvValue( oResponse,"_BILLING_ADDRESS","shoppingCartAddressEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode59 != NIL
		::oWSbilling_address := MagentoService_shoppingCartAddressEntity():New()
		::oWSbilling_address:SoapRecv(oNode59)
	EndIf
	oNode60 :=  WSAdvValue( oResponse,"_ITEMS","shoppingCartItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode60 != NIL
		::oWSitems := MagentoService_shoppingCartItemEntityArray():New()
		::oWSitems:SoapRecv(oNode60)
	EndIf
	oNode61 :=  WSAdvValue( oResponse,"_PAYMENT","shoppingCartPaymentEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode61 != NIL
		::oWSpayment := MagentoService_shoppingCartPaymentEntity():New()
		::oWSpayment:SoapRecv(oNode61)
	EndIf
Return

// WSDL Data Structure shoppingCartTotalsEntityArray

WSSTRUCT MagentoService_shoppingCartTotalsEntityArray
	WSDATA   oWSshoppingCartTotalsEntity AS MagentoService_shoppingCartTotalsEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartTotalsEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartTotalsEntityArray
	::oWSshoppingCartTotalsEntity := {} // Array Of  MagentoService_SHOPPINGCARTTOTALSENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartTotalsEntityArray
	Local oClone := MagentoService_shoppingCartTotalsEntityArray():NEW()
	oClone:oWSshoppingCartTotalsEntity := NIL
	If ::oWSshoppingCartTotalsEntity <> NIL
		oClone:oWSshoppingCartTotalsEntity := {}
		aEval( ::oWSshoppingCartTotalsEntity , { |x| aadd( oClone:oWSshoppingCartTotalsEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartTotalsEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSshoppingCartTotalsEntity , MagentoService_shoppingCartTotalsEntity():New() )
			::oWSshoppingCartTotalsEntity[len(::oWSshoppingCartTotalsEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartTotalsEntity

WSSTRUCT MagentoService_shoppingCartTotalsEntity
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   namount                   AS double OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartTotalsEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartTotalsEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartTotalsEntity
	Local oClone := MagentoService_shoppingCartTotalsEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:namount              := ::namount
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartTotalsEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::namount            :=  WSAdvValue( oResponse,"_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure shoppingCartLicenseEntityArray

WSSTRUCT MagentoService_shoppingCartLicenseEntityArray
	WSDATA   oWSshoppingCartLicenseEntity AS MagentoService_shoppingCartLicenseEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartLicenseEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartLicenseEntityArray
	::oWSshoppingCartLicenseEntity := {} // Array Of  MagentoService_SHOPPINGCARTLICENSEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartLicenseEntityArray
	Local oClone := MagentoService_shoppingCartLicenseEntityArray():NEW()
	oClone:oWSshoppingCartLicenseEntity := NIL
	If ::oWSshoppingCartLicenseEntity <> NIL
		oClone:oWSshoppingCartLicenseEntity := {}
		aEval( ::oWSshoppingCartLicenseEntity , { |x| aadd( oClone:oWSshoppingCartLicenseEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartLicenseEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSshoppingCartLicenseEntity , MagentoService_shoppingCartLicenseEntity():New() )
			::oWSshoppingCartLicenseEntity[len(::oWSshoppingCartLicenseEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartLicenseEntity

WSSTRUCT MagentoService_shoppingCartLicenseEntity
	WSDATA   cagreement_id             AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   ccontent                  AS string OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSDATA   nis_html                  AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartLicenseEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartLicenseEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartLicenseEntity
	Local oClone := MagentoService_shoppingCartLicenseEntity():NEW()
	oClone:cagreement_id        := ::cagreement_id
	oClone:cname                := ::cname
	oClone:ccontent             := ::ccontent
	oClone:nis_active           := ::nis_active
	oClone:nis_html             := ::nis_html
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartLicenseEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cagreement_id      :=  WSAdvValue( oResponse,"_AGREEMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccontent           :=  WSAdvValue( oResponse,"_CONTENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_html           :=  WSAdvValue( oResponse,"_IS_HTML","int",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure shoppingCartProductEntityArray

WSSTRUCT MagentoService_shoppingCartProductEntityArray
	WSDATA   oWSshoppingCartProductEntity AS MagentoService_shoppingCartProductEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartProductEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartProductEntityArray
	::oWSshoppingCartProductEntity := {} // Array Of  MagentoService_SHOPPINGCARTPRODUCTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartProductEntityArray
	Local oClone := MagentoService_shoppingCartProductEntityArray():NEW()
	oClone:oWSshoppingCartProductEntity := NIL
	If ::oWSshoppingCartProductEntity <> NIL
		oClone:oWSshoppingCartProductEntity := {}
		aEval( ::oWSshoppingCartProductEntity , { |x| aadd( oClone:oWSshoppingCartProductEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_shoppingCartProductEntityArray
	Local cSoap := ""
	aEval( ::oWSshoppingCartProductEntity , {|x| cSoap := cSoap  +  WSSoapValue("shoppingCartProductEntity", x , x , "shoppingCartProductEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure shoppingCartProductEntity

WSSTRUCT MagentoService_shoppingCartProductEntity
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   nqty                      AS double OPTIONAL
	WSDATA   oWSoptions                AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSbundle_option          AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSbundle_option_qty      AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSlinks                  AS MagentoService_ArrayOfString OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartProductEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartProductEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartProductEntity
	Local oClone := MagentoService_shoppingCartProductEntity():NEW()
	oClone:cproduct_id          := ::cproduct_id
	oClone:csku                 := ::csku
	oClone:nqty                 := ::nqty
	oClone:oWSoptions           := IIF(::oWSoptions = NIL , NIL , ::oWSoptions:Clone() )
	oClone:oWSbundle_option     := IIF(::oWSbundle_option = NIL , NIL , ::oWSbundle_option:Clone() )
	oClone:oWSbundle_option_qty := IIF(::oWSbundle_option_qty = NIL , NIL , ::oWSbundle_option_qty:Clone() )
	oClone:oWSlinks             := IIF(::oWSlinks = NIL , NIL , ::oWSlinks:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_shoppingCartProductEntity
	Local cSoap := ""
	cSoap += WSSoapValue("product_id", ::cproduct_id, ::cproduct_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("qty", ::nqty, ::nqty , "double", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("options", ::oWSoptions, ::oWSoptions , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("bundle_option", ::oWSbundle_option, ::oWSbundle_option , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("bundle_option_qty", ::oWSbundle_option_qty, ::oWSbundle_option_qty , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("links", ::oWSlinks, ::oWSlinks , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure shoppingCartProductResponseEntityArray

WSSTRUCT MagentoService_shoppingCartProductResponseEntityArray
	WSDATA   oWScatalogProductEntity   AS MagentoService_catalogProductEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartProductResponseEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartProductResponseEntityArray
	::oWScatalogProductEntity := {} // Array Of  MagentoService_CATALOGPRODUCTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartProductResponseEntityArray
	Local oClone := MagentoService_shoppingCartProductResponseEntityArray():NEW()
	oClone:oWScatalogProductEntity := NIL
	If ::oWScatalogProductEntity <> NIL
		oClone:oWScatalogProductEntity := {}
		aEval( ::oWScatalogProductEntity , { |x| aadd( oClone:oWScatalogProductEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartProductResponseEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductEntity , MagentoService_catalogProductEntity():New() )
			::oWScatalogProductEntity[len(::oWScatalogProductEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartCustomerEntity

WSSTRUCT MagentoService_shoppingCartCustomerEntity
	WSDATA   cmode                     AS string OPTIONAL
	WSDATA   ncustomer_id              AS int OPTIONAL
	WSDATA   cemail                    AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   cpassword                 AS string OPTIONAL
	WSDATA   cconfirmation             AS string OPTIONAL
	WSDATA   nwebsite_id               AS int OPTIONAL
	WSDATA   nstore_id                 AS int OPTIONAL
	WSDATA   ngroup_id                 AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartCustomerEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartCustomerEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartCustomerEntity
	Local oClone := MagentoService_shoppingCartCustomerEntity():NEW()
	oClone:cmode                := ::cmode
	oClone:ncustomer_id         := ::ncustomer_id
	oClone:cemail               := ::cemail
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:cpassword            := ::cpassword
	oClone:cconfirmation        := ::cconfirmation
	oClone:nwebsite_id          := ::nwebsite_id
	oClone:nstore_id            := ::nstore_id
	oClone:ngroup_id            := ::ngroup_id
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_shoppingCartCustomerEntity
	Local cSoap := ""
	cSoap += WSSoapValue("mode", ::cmode, ::cmode , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_id", ::ncustomer_id, ::ncustomer_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("email", ::cemail, ::cemail , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("firstname", ::cfirstname, ::cfirstname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("lastname", ::clastname, ::clastname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("password", ::cpassword, ::cpassword , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("confirmation", ::cconfirmation, ::cconfirmation , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("website_id", ::nwebsite_id, ::nwebsite_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store_id", ::nstore_id, ::nstore_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("group_id", ::ngroup_id, ::ngroup_id , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure shoppingCartCustomerAddressEntityArray

WSSTRUCT MagentoService_shoppingCartCustomerAddressEntityArray
	WSDATA   oWSshoppingCartCustomerAddressEntity AS MagentoService_shoppingCartCustomerAddressEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartCustomerAddressEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartCustomerAddressEntityArray
	::oWSshoppingCartCustomerAddressEntity := {} // Array Of  MagentoService_SHOPPINGCARTCUSTOMERADDRESSENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartCustomerAddressEntityArray
	Local oClone := MagentoService_shoppingCartCustomerAddressEntityArray():NEW()
	oClone:oWSshoppingCartCustomerAddressEntity := NIL
	If ::oWSshoppingCartCustomerAddressEntity <> NIL
		oClone:oWSshoppingCartCustomerAddressEntity := {}
		aEval( ::oWSshoppingCartCustomerAddressEntity , { |x| aadd( oClone:oWSshoppingCartCustomerAddressEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_shoppingCartCustomerAddressEntityArray
	Local cSoap := ""
	aEval( ::oWSshoppingCartCustomerAddressEntity , {|x| cSoap := cSoap  +  WSSoapValue("shoppingCartCustomerAddressEntity", x , x , "shoppingCartCustomerAddressEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure shoppingCartCustomerAddressEntity

WSSTRUCT MagentoService_shoppingCartCustomerAddressEntity
	WSDATA   cmode                     AS string OPTIONAL
	WSDATA   caddress_id               AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   cstreet                   AS string OPTIONAL
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   cregion_id                AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   nis_default_billing       AS int OPTIONAL
	WSDATA   nis_default_shipping      AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartCustomerAddressEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartCustomerAddressEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartCustomerAddressEntity
	Local oClone := MagentoService_shoppingCartCustomerAddressEntity():NEW()
	oClone:cmode                := ::cmode
	oClone:caddress_id          := ::caddress_id
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:ccompany             := ::ccompany
	oClone:cstreet              := ::cstreet
	oClone:ccity                := ::ccity
	oClone:cregion              := ::cregion
	oClone:cregion_id           := ::cregion_id
	oClone:cpostcode            := ::cpostcode
	oClone:ccountry_id          := ::ccountry_id
	oClone:ctelephone           := ::ctelephone
	oClone:cfax                 := ::cfax
	oClone:nis_default_billing  := ::nis_default_billing
	oClone:nis_default_shipping := ::nis_default_shipping
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_shoppingCartCustomerAddressEntity
	Local cSoap := ""
	cSoap += WSSoapValue("mode", ::cmode, ::cmode , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("address_id", ::caddress_id, ::caddress_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("firstname", ::cfirstname, ::cfirstname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("lastname", ::clastname, ::clastname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("company", ::ccompany, ::ccompany , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("street", ::cstreet, ::cstreet , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("city", ::ccity, ::ccity , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("region", ::cregion, ::cregion , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("region_id", ::cregion_id, ::cregion_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("postcode", ::cpostcode, ::cpostcode , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("country_id", ::ccountry_id, ::ccountry_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("telephone", ::ctelephone, ::ctelephone , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("fax", ::cfax, ::cfax , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_default_billing", ::nis_default_billing, ::nis_default_billing , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_default_shipping", ::nis_default_shipping, ::nis_default_shipping , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure shoppingCartShippingMethodEntityArray

WSSTRUCT MagentoService_shoppingCartShippingMethodEntityArray
	WSDATA   oWSshoppingCartShippingMethodEntity AS MagentoService_shoppingCartShippingMethodEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartShippingMethodEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartShippingMethodEntityArray
	::oWSshoppingCartShippingMethodEntity := {} // Array Of  MagentoService_SHOPPINGCARTSHIPPINGMETHODENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartShippingMethodEntityArray
	Local oClone := MagentoService_shoppingCartShippingMethodEntityArray():NEW()
	oClone:oWSshoppingCartShippingMethodEntity := NIL
	If ::oWSshoppingCartShippingMethodEntity <> NIL
		oClone:oWSshoppingCartShippingMethodEntity := {}
		aEval( ::oWSshoppingCartShippingMethodEntity , { |x| aadd( oClone:oWSshoppingCartShippingMethodEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartShippingMethodEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSshoppingCartShippingMethodEntity , MagentoService_shoppingCartShippingMethodEntity():New() )
			::oWSshoppingCartShippingMethodEntity[len(::oWSshoppingCartShippingMethodEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartShippingMethodEntity

WSSTRUCT MagentoService_shoppingCartShippingMethodEntity
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   ccarrier                  AS string OPTIONAL
	WSDATA   ccarrier_title            AS string OPTIONAL
	WSDATA   cmethod                   AS string OPTIONAL
	WSDATA   cmethod_title             AS string OPTIONAL
	WSDATA   cmethod_description       AS string OPTIONAL
	WSDATA   nprice                    AS double OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartShippingMethodEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartShippingMethodEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartShippingMethodEntity
	Local oClone := MagentoService_shoppingCartShippingMethodEntity():NEW()
	oClone:ccode                := ::ccode
	oClone:ccarrier             := ::ccarrier
	oClone:ccarrier_title       := ::ccarrier_title
	oClone:cmethod              := ::cmethod
	oClone:cmethod_title        := ::cmethod_title
	oClone:cmethod_description  := ::cmethod_description
	oClone:nprice               := ::nprice
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartShippingMethodEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccarrier           :=  WSAdvValue( oResponse,"_CARRIER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccarrier_title     :=  WSAdvValue( oResponse,"_CARRIER_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmethod            :=  WSAdvValue( oResponse,"_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmethod_title      :=  WSAdvValue( oResponse,"_METHOD_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmethod_description :=  WSAdvValue( oResponse,"_METHOD_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nprice             :=  WSAdvValue( oResponse,"_PRICE","double",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure shoppingCartPaymentMethodEntity

WSSTRUCT MagentoService_shoppingCartPaymentMethodEntity
	WSDATA   cpo_number                AS string OPTIONAL
	WSDATA   cmethod                   AS string OPTIONAL
	WSDATA   ccc_cid                   AS string OPTIONAL
	WSDATA   ccc_owner                 AS string OPTIONAL
	WSDATA   ccc_number                AS string OPTIONAL
	WSDATA   ccc_type                  AS string OPTIONAL
	WSDATA   ccc_exp_year              AS string OPTIONAL
	WSDATA   ccc_exp_month             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartPaymentMethodEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartPaymentMethodEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartPaymentMethodEntity
	Local oClone := MagentoService_shoppingCartPaymentMethodEntity():NEW()
	oClone:cpo_number           := ::cpo_number
	oClone:cmethod              := ::cmethod
	oClone:ccc_cid              := ::ccc_cid
	oClone:ccc_owner            := ::ccc_owner
	oClone:ccc_number           := ::ccc_number
	oClone:ccc_type             := ::ccc_type
	oClone:ccc_exp_year         := ::ccc_exp_year
	oClone:ccc_exp_month        := ::ccc_exp_month
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_shoppingCartPaymentMethodEntity
	Local cSoap := ""
	cSoap += WSSoapValue("po_number", ::cpo_number, ::cpo_number , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("method", ::cmethod, ::cmethod , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("cc_cid", ::ccc_cid, ::ccc_cid , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("cc_owner", ::ccc_owner, ::ccc_owner , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("cc_number", ::ccc_number, ::ccc_number , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("cc_type", ::ccc_type, ::ccc_type , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("cc_exp_year", ::ccc_exp_year, ::ccc_exp_year , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("cc_exp_month", ::ccc_exp_month, ::ccc_exp_month , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure shoppingCartPaymentMethodResponseEntityArray

WSSTRUCT MagentoService_shoppingCartPaymentMethodResponseEntityArray
	WSDATA   oWSshoppingCartPaymentMethodResponseEntity AS MagentoService_shoppingCartPaymentMethodResponseEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntityArray
	::oWSshoppingCartPaymentMethodResponseEntity := {} // Array Of  MagentoService_SHOPPINGCARTPAYMENTMETHODRESPONSEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntityArray
	Local oClone := MagentoService_shoppingCartPaymentMethodResponseEntityArray():NEW()
	oClone:oWSshoppingCartPaymentMethodResponseEntity := NIL
	If ::oWSshoppingCartPaymentMethodResponseEntity <> NIL
		oClone:oWSshoppingCartPaymentMethodResponseEntity := {}
		aEval( ::oWSshoppingCartPaymentMethodResponseEntity , { |x| aadd( oClone:oWSshoppingCartPaymentMethodResponseEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSshoppingCartPaymentMethodResponseEntity , MagentoService_shoppingCartPaymentMethodResponseEntity():New() )
			::oWSshoppingCartPaymentMethodResponseEntity[len(::oWSshoppingCartPaymentMethodResponseEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartPaymentMethodResponseEntity

WSSTRUCT MagentoService_shoppingCartPaymentMethodResponseEntity
	WSDATA   ccode                     AS string OPTIONAL
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   oWScc_types               AS MagentoService_associativeArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntity
	Local oClone := MagentoService_shoppingCartPaymentMethodResponseEntity():NEW()
	oClone:ccode                := ::ccode
	oClone:ctitle               := ::ctitle
	oClone:oWScc_types          := IIF(::oWScc_types = NIL , NIL , ::oWScc_types:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartPaymentMethodResponseEntity
	Local oNode3
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ccode              :=  WSAdvValue( oResponse,"_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode3 :=  WSAdvValue( oResponse,"_CC_TYPES","associativeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWScc_types := MagentoService_associativeArray():New()
		::oWScc_types:SoapRecv(oNode3)
	EndIf
Return

// WSDL Data Structure catalogProductTagListEntityArray

WSSTRUCT MagentoService_catalogProductTagListEntityArray
	WSDATA   oWScatalogProductTagListEntity AS MagentoService_catalogProductTagListEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTagListEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTagListEntityArray
	::oWScatalogProductTagListEntity := {} // Array Of  MagentoService_CATALOGPRODUCTTAGLISTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTagListEntityArray
	Local oClone := MagentoService_catalogProductTagListEntityArray():NEW()
	oClone:oWScatalogProductTagListEntity := NIL
	If ::oWScatalogProductTagListEntity <> NIL
		oClone:oWScatalogProductTagListEntity := {}
		aEval( ::oWScatalogProductTagListEntity , { |x| aadd( oClone:oWScatalogProductTagListEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTagListEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductTagListEntity , MagentoService_catalogProductTagListEntity():New() )
			::oWScatalogProductTagListEntity[len(::oWScatalogProductTagListEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductTagListEntity

WSSTRUCT MagentoService_catalogProductTagListEntity
	WSDATA   ctag_id                   AS string
	WSDATA   cname                     AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTagListEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTagListEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTagListEntity
	Local oClone := MagentoService_catalogProductTagListEntity():NEW()
	oClone:ctag_id              := ::ctag_id
	oClone:cname                := ::cname
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTagListEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctag_id            :=  WSAdvValue( oResponse,"_TAG_ID","string",NIL,"Property ctag_id as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,"Property cname as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductTagInfoEntity

WSSTRUCT MagentoService_catalogProductTagInfoEntity
	WSDATA   cname                     AS string
	WSDATA   cstatus                   AS string
	WSDATA   cbase_popularity          AS string
	WSDATA   oWSproducts               AS MagentoService_associativeArray
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTagInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTagInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTagInfoEntity
	Local oClone := MagentoService_catalogProductTagInfoEntity():NEW()
	oClone:cname                := ::cname
	oClone:cstatus              := ::cstatus
	oClone:cbase_popularity     := ::cbase_popularity
	oClone:oWSproducts          := IIF(::oWSproducts = NIL , NIL , ::oWSproducts:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductTagInfoEntity
	Local oNode4
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,"Property cname as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,"Property cstatus as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	::cbase_popularity   :=  WSAdvValue( oResponse,"_BASE_POPULARITY","string",NIL,"Property cbase_popularity as xsd:string on SOAP Response not found.",NIL,"S",NIL,NIL)
	oNode4 :=  WSAdvValue( oResponse,"_PRODUCTS","associativeArray",NIL,"Property oWSproducts as typens:associativeArray on SOAP Response not found.",NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSproducts := MagentoService_associativeArray():New()
		::oWSproducts:SoapRecv(oNode4)
	EndIf
Return

// WSDL Data Structure catalogProductTagAddEntity

WSSTRUCT MagentoService_catalogProductTagAddEntity
	WSDATA   ctag                      AS string
	WSDATA   cproduct_id               AS string
	WSDATA   ccustomer_id              AS string
	WSDATA   cstore                    AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTagAddEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTagAddEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTagAddEntity
	Local oClone := MagentoService_catalogProductTagAddEntity():NEW()
	oClone:ctag                 := ::ctag
	oClone:cproduct_id          := ::cproduct_id
	oClone:ccustomer_id         := ::ccustomer_id
	oClone:cstore               := ::cstore
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductTagAddEntity
	Local cSoap := ""
	cSoap += WSSoapValue("tag", ::ctag, ::ctag , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("product_id", ::cproduct_id, ::cproduct_id , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_id", ::ccustomer_id, ::ccustomer_id , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("store", ::cstore, ::cstore , "string", .T. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductTagUpdateEntity

WSSTRUCT MagentoService_catalogProductTagUpdateEntity
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   cbase_popularity          AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductTagUpdateEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductTagUpdateEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductTagUpdateEntity
	Local oClone := MagentoService_catalogProductTagUpdateEntity():NEW()
	oClone:cname                := ::cname
	oClone:cstatus              := ::cstatus
	oClone:cbase_popularity     := ::cbase_popularity
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductTagUpdateEntity
	Local cSoap := ""
	cSoap += WSSoapValue("name", ::cname, ::cname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("status", ::cstatus, ::cstatus , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("base_popularity", ::cbase_popularity, ::cbase_popularity , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure giftMessageEntity

WSSTRUCT MagentoService_giftMessageEntity
	WSDATA   cfrom                     AS string OPTIONAL
	WSDATA   cto                       AS string OPTIONAL
	WSDATA   cmessage                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_giftMessageEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_giftMessageEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_giftMessageEntity
	Local oClone := MagentoService_giftMessageEntity():NEW()
	oClone:cfrom                := ::cfrom
	oClone:cto                  := ::cto
	oClone:cmessage             := ::cmessage
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_giftMessageEntity
	Local cSoap := ""
	cSoap += WSSoapValue("from", ::cfrom, ::cfrom , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("to", ::cto, ::cto , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("message", ::cmessage, ::cmessage , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure giftMessageResponse

WSSTRUCT MagentoService_giftMessageResponse
	WSDATA   centityId                 AS string OPTIONAL
	WSDATA   lresult                   AS boolean OPTIONAL
	WSDATA   cerror                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_giftMessageResponse
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_giftMessageResponse
Return

WSMETHOD CLONE WSCLIENT MagentoService_giftMessageResponse
	Local oClone := MagentoService_giftMessageResponse():NEW()
	oClone:centityId            := ::centityId
	oClone:lresult              := ::lresult
	oClone:cerror               := ::cerror
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_giftMessageResponse
	::Init()
	If oResponse = NIL ; Return ; Endif
	::centityId          :=  WSAdvValue( oResponse,"_ENTITYID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::lresult            :=  WSAdvValue( oResponse,"_RESULT","boolean",NIL,NIL,NIL,"L",NIL,NIL)
	::cerror             :=  WSAdvValue( oResponse,"_ERROR","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure giftMessageAssociativeProductsEntityArray

WSSTRUCT MagentoService_giftMessageAssociativeProductsEntityArray
	WSDATA   oWSgiftMessageAssociativeProductsEntity AS MagentoService_giftMessageAssociativeProductsEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_giftMessageAssociativeProductsEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_giftMessageAssociativeProductsEntityArray
	::oWSgiftMessageAssociativeProductsEntity := {} // Array Of  MagentoService_GIFTMESSAGEASSOCIATIVEPRODUCTSENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_giftMessageAssociativeProductsEntityArray
	Local oClone := MagentoService_giftMessageAssociativeProductsEntityArray():NEW()
	oClone:oWSgiftMessageAssociativeProductsEntity := NIL
	If ::oWSgiftMessageAssociativeProductsEntity <> NIL
		oClone:oWSgiftMessageAssociativeProductsEntity := {}
		aEval( ::oWSgiftMessageAssociativeProductsEntity , { |x| aadd( oClone:oWSgiftMessageAssociativeProductsEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_giftMessageAssociativeProductsEntityArray
	Local cSoap := ""
	aEval( ::oWSgiftMessageAssociativeProductsEntity , {|x| cSoap := cSoap  +  WSSoapValue("giftMessageAssociativeProductsEntity", x , x , "giftMessageAssociativeProductsEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure giftMessageAssociativeProductsEntity

WSSTRUCT MagentoService_giftMessageAssociativeProductsEntity
	WSDATA   oWSproduct                AS MagentoService_shoppingCartProductEntity OPTIONAL
	WSDATA   oWSmessage                AS MagentoService_giftMessageEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_giftMessageAssociativeProductsEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_giftMessageAssociativeProductsEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_giftMessageAssociativeProductsEntity
	Local oClone := MagentoService_giftMessageAssociativeProductsEntity():NEW()
	oClone:oWSproduct           := IIF(::oWSproduct = NIL , NIL , ::oWSproduct:Clone() )
	oClone:oWSmessage           := IIF(::oWSmessage = NIL , NIL , ::oWSmessage:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_giftMessageAssociativeProductsEntity
	Local cSoap := ""
	cSoap += WSSoapValue("product", ::oWSproduct, ::oWSproduct , "shoppingCartProductEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("message", ::oWSmessage, ::oWSmessage , "giftMessageEntity", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure giftMessageResponseArray

WSSTRUCT MagentoService_giftMessageResponseArray
	WSDATA   oWSgiftMessageResponse    AS MagentoService_giftMessageResponse OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_giftMessageResponseArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_giftMessageResponseArray
	::oWSgiftMessageResponse := {} // Array Of  MagentoService_GIFTMESSAGERESPONSE():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_giftMessageResponseArray
	Local oClone := MagentoService_giftMessageResponseArray():NEW()
	oClone:oWSgiftMessageResponse := NIL
	If ::oWSgiftMessageResponse <> NIL
		oClone:oWSgiftMessageResponse := {}
		aEval( ::oWSgiftMessageResponse , { |x| aadd( oClone:oWSgiftMessageResponse , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_giftMessageResponseArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSgiftMessageResponse , MagentoService_giftMessageResponse():New() )
			::oWSgiftMessageResponse[len(::oWSgiftMessageResponse)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductDownloadableLinkAddEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkAddEntity
	WSDATA   ctitle                    AS string
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   nis_unlimited             AS int OPTIONAL
	WSDATA   nnumber_of_downloads      AS int OPTIONAL
	WSDATA   nis_shareable             AS int OPTIONAL
	WSDATA   oWSsample                 AS MagentoService_catalogProductDownloadableLinkAddSampleEntity OPTIONAL
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   oWSfile                   AS MagentoService_catalogProductDownloadableLinkFileEntity OPTIONAL
	WSDATA   clink_url                 AS string OPTIONAL
	WSDATA   csample_url               AS string OPTIONAL
	WSDATA   nsort_order               AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkAddEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkAddEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkAddEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkAddEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:cprice               := ::cprice
	oClone:nis_unlimited        := ::nis_unlimited
	oClone:nnumber_of_downloads := ::nnumber_of_downloads
	oClone:nis_shareable        := ::nis_shareable
	oClone:oWSsample            := IIF(::oWSsample = NIL , NIL , ::oWSsample:Clone() )
	oClone:ctype                := ::ctype
	oClone:oWSfile              := IIF(::oWSfile = NIL , NIL , ::oWSfile:Clone() )
	oClone:clink_url            := ::clink_url
	oClone:csample_url          := ::csample_url
	oClone:nsort_order          := ::nsort_order
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductDownloadableLinkAddEntity
	Local cSoap := ""
	cSoap += WSSoapValue("title", ::ctitle, ::ctitle , "string", .T. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price", ::cprice, ::cprice , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_unlimited", ::nis_unlimited, ::nis_unlimited , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("number_of_downloads", ::nnumber_of_downloads, ::nnumber_of_downloads , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("is_shareable", ::nis_shareable, ::nis_shareable , "int", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sample", ::oWSsample, ::oWSsample , "catalogProductDownloadableLinkAddSampleEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("type", ::ctype, ::ctype , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("file", ::oWSfile, ::oWSfile , "catalogProductDownloadableLinkFileEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("link_url", ::clink_url, ::clink_url , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sample_url", ::csample_url, ::csample_url , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sort_order", ::nsort_order, ::nsort_order , "int", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductDownloadableLinkAddSampleEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkAddSampleEntity
	WSDATA   ctype                     AS string OPTIONAL
	WSDATA   oWSfile                   AS MagentoService_catalogProductDownloadableLinkFileEntity OPTIONAL
	WSDATA   curl                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkAddSampleEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkAddSampleEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkAddSampleEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkAddSampleEntity():NEW()
	oClone:ctype                := ::ctype
	oClone:oWSfile              := IIF(::oWSfile = NIL , NIL , ::oWSfile:Clone() )
	oClone:curl                 := ::curl
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductDownloadableLinkAddSampleEntity
	Local cSoap := ""
	cSoap += WSSoapValue("type", ::ctype, ::ctype , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("file", ::oWSfile, ::oWSfile , "catalogProductDownloadableLinkFileEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("url", ::curl, ::curl , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductDownloadableLinkInfoEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkInfoEntity
	WSDATA   oWSlinks                  AS MagentoService_catalogProductDownloadableLinkEntityArray OPTIONAL
	WSDATA   oWSsamples                AS MagentoService_catalogProductDownloadableLinkSampleEntityArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkInfoEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkInfoEntity():NEW()
	oClone:oWSlinks             := IIF(::oWSlinks = NIL , NIL , ::oWSlinks:Clone() )
	oClone:oWSsamples           := IIF(::oWSsamples = NIL , NIL , ::oWSsamples:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkInfoEntity
	Local oNode1
	Local oNode2
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_LINKS","catalogProductDownloadableLinkEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSlinks := MagentoService_catalogProductDownloadableLinkEntityArray():New()
		::oWSlinks:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_SAMPLES","catalogProductDownloadableLinkSampleEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode2 != NIL
		::oWSsamples := MagentoService_catalogProductDownloadableLinkSampleEntityArray():New()
		::oWSsamples:SoapRecv(oNode2)
	EndIf
Return

// WSDL Data Structure catalogProductDownloadableLinkEntityArray

WSSTRUCT MagentoService_catalogProductDownloadableLinkEntityArray
	WSDATA   oWScatalogProductDownloadableLinkEntity AS MagentoService_catalogProductDownloadableLinkEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkEntityArray
	::oWScatalogProductDownloadableLinkEntity := {} // Array Of  MagentoService_CATALOGPRODUCTDOWNLOADABLELINKENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkEntityArray
	Local oClone := MagentoService_catalogProductDownloadableLinkEntityArray():NEW()
	oClone:oWScatalogProductDownloadableLinkEntity := NIL
	If ::oWScatalogProductDownloadableLinkEntity <> NIL
		oClone:oWScatalogProductDownloadableLinkEntity := {}
		aEval( ::oWScatalogProductDownloadableLinkEntity , { |x| aadd( oClone:oWScatalogProductDownloadableLinkEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductDownloadableLinkEntity , MagentoService_catalogProductDownloadableLinkEntity():New() )
			::oWScatalogProductDownloadableLinkEntity[len(::oWScatalogProductDownloadableLinkEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure catalogProductDownloadableLinkSampleEntityArray

WSSTRUCT MagentoService_catalogProductDownloadableLinkSampleEntityArray
	WSDATA   oWScatalogProductDownloadableLinkSampleEntity AS MagentoService_catalogProductDownloadableLinkSampleEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntityArray
	::oWScatalogProductDownloadableLinkSampleEntity := {} // Array Of  MagentoService_CATALOGPRODUCTDOWNLOADABLELINKSAMPLEENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntityArray
	Local oClone := MagentoService_catalogProductDownloadableLinkSampleEntityArray():NEW()
	oClone:oWScatalogProductDownloadableLinkSampleEntity := NIL
	If ::oWScatalogProductDownloadableLinkSampleEntity <> NIL
		oClone:oWScatalogProductDownloadableLinkSampleEntity := {}
		aEval( ::oWScatalogProductDownloadableLinkSampleEntity , { |x| aadd( oClone:oWScatalogProductDownloadableLinkSampleEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductDownloadableLinkSampleEntity , MagentoService_catalogProductDownloadableLinkSampleEntity():New() )
			::oWScatalogProductDownloadableLinkSampleEntity[len(::oWScatalogProductDownloadableLinkSampleEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure plpArray

WSSTRUCT MagentoService_plpArray
	WSDATA   oWSplp                    AS MagentoService_plp OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_plpArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_plpArray
	::oWSplp               := {} // Array Of  MagentoService_PLP():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_plpArray
	Local oClone := MagentoService_plpArray():NEW()
	oClone:oWSplp := NIL
	If ::oWSplp <> NIL
		oClone:oWSplp := {}
		aEval( ::oWSplp , { |x| aadd( oClone:oWSplp , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_plpArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSplp , MagentoService_plp():New() )
			::oWSplp[len(::oWSplp)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure plp

WSSTRUCT MagentoService_plp
	WSDATA   cid                       AS string OPTIONAL
	WSDATA   cskyhub_code              AS string OPTIONAL
	WSDATA   dcreated_at               AS date OPTIONAL
	WSDATA   cjson                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_plp
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_plp
Return

WSMETHOD CLONE WSCLIENT MagentoService_plp
	Local oClone := MagentoService_plp():NEW()
	oClone:cid                  := ::cid
	oClone:cskyhub_code         := ::cskyhub_code
	oClone:dcreated_at          := ::dcreated_at
	oClone:cjson                := ::cjson
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_plp
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cid                :=  WSAdvValue( oResponse,"_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cskyhub_code       :=  WSAdvValue( oResponse,"_SKYHUB_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::dcreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","date",NIL,NIL,NIL,"D",NIL,NIL)
	::cjson              :=  WSAdvValue( oResponse,"_JSON","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorEstimateShippingItemEntityArray

WSSTRUCT MagentoService_integratorEstimateShippingItemEntityArray
	WSDATA   oWSintegratorEstimateShippingItemEntity AS MagentoService_integratorEstimateShippingItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorEstimateShippingItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorEstimateShippingItemEntityArray
	::oWSintegratorEstimateShippingItemEntity := {} // Array Of  MagentoService_INTEGRATORESTIMATESHIPPINGITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorEstimateShippingItemEntityArray
	Local oClone := MagentoService_integratorEstimateShippingItemEntityArray():NEW()
	oClone:oWSintegratorEstimateShippingItemEntity := NIL
	If ::oWSintegratorEstimateShippingItemEntity <> NIL
		oClone:oWSintegratorEstimateShippingItemEntity := {}
		aEval( ::oWSintegratorEstimateShippingItemEntity , { |x| aadd( oClone:oWSintegratorEstimateShippingItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorEstimateShippingItemEntityArray
	Local cSoap := ""
	aEval( ::oWSintegratorEstimateShippingItemEntity , {|x| cSoap := cSoap  +  WSSoapValue("integratorEstimateShippingItemEntity", x , x , "integratorEstimateShippingItemEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure integratorEstimateShippingItemEntity

WSSTRUCT MagentoService_integratorEstimateShippingItemEntity
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorEstimateShippingItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorEstimateShippingItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorEstimateShippingItemEntity
	Local oClone := MagentoService_integratorEstimateShippingItemEntity():NEW()
	oClone:csku                 := ::csku
	oClone:cqty                 := ::cqty
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorEstimateShippingItemEntity
	Local cSoap := ""
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("qty", ::cqty, ::cqty , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure integratorEstimateShippingResponseItemEntityArray

WSSTRUCT MagentoService_integratorEstimateShippingResponseItemEntityArray
	WSDATA   oWSintegratorEstimateShippingResponseItemEntity AS MagentoService_integratorEstimateShippingResponseItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntityArray
	::oWSintegratorEstimateShippingResponseItemEntity := {} // Array Of  MagentoService_INTEGRATORESTIMATESHIPPINGRESPONSEITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntityArray
	Local oClone := MagentoService_integratorEstimateShippingResponseItemEntityArray():NEW()
	oClone:oWSintegratorEstimateShippingResponseItemEntity := NIL
	If ::oWSintegratorEstimateShippingResponseItemEntity <> NIL
		oClone:oWSintegratorEstimateShippingResponseItemEntity := {}
		aEval( ::oWSintegratorEstimateShippingResponseItemEntity , { |x| aadd( oClone:oWSintegratorEstimateShippingResponseItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorEstimateShippingResponseItemEntity , MagentoService_integratorEstimateShippingResponseItemEntity():New() )
			::oWSintegratorEstimateShippingResponseItemEntity[len(::oWSintegratorEstimateShippingResponseItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorEstimateShippingResponseItemEntity

WSSTRUCT MagentoService_integratorEstimateShippingResponseItemEntity
	WSDATA   cid                       AS string OPTIONAL
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   cestimated_delivery       AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntity
	Local oClone := MagentoService_integratorEstimateShippingResponseItemEntity():NEW()
	oClone:cid                  := ::cid
	oClone:ctitle               := ::ctitle
	oClone:cestimated_delivery  := ::cestimated_delivery
	oClone:cprice               := ::cprice
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorEstimateShippingResponseItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cid                :=  WSAdvValue( oResponse,"_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cestimated_delivery :=  WSAdvValue( oResponse,"_ESTIMATED_DELIVERY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorEstimateShippingPerItemResponseItemEntityArray

WSSTRUCT MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray
	WSDATA   oWSintegratorEstimateShippingPerItemResponseItemEntity AS MagentoService_integratorEstimateShippingPerItemResponseItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray
	::oWSintegratorEstimateShippingPerItemResponseItemEntity := {} // Array Of  MagentoService_INTEGRATORESTIMATESHIPPINGPERITEMRESPONSEITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray
	Local oClone := MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray():NEW()
	oClone:oWSintegratorEstimateShippingPerItemResponseItemEntity := NIL
	If ::oWSintegratorEstimateShippingPerItemResponseItemEntity <> NIL
		oClone:oWSintegratorEstimateShippingPerItemResponseItemEntity := {}
		aEval( ::oWSintegratorEstimateShippingPerItemResponseItemEntity , { |x| aadd( oClone:oWSintegratorEstimateShippingPerItemResponseItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorEstimateShippingPerItemResponseItemEntity , MagentoService_integratorEstimateShippingPerItemResponseItemEntity():New() )
			::oWSintegratorEstimateShippingPerItemResponseItemEntity[len(::oWSintegratorEstimateShippingPerItemResponseItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorEstimateShippingPerItemResponseItemEntity

WSSTRUCT MagentoService_integratorEstimateShippingPerItemResponseItemEntity
	WSDATA   citem                     AS string OPTIONAL
	WSDATA   oWSshipping_info          AS MagentoService_integratorEstimateShippingResponseItemEntityArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntity
	Local oClone := MagentoService_integratorEstimateShippingPerItemResponseItemEntity():NEW()
	oClone:citem                := ::citem
	oClone:oWSshipping_info     := IIF(::oWSshipping_info = NIL , NIL , ::oWSshipping_info:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorEstimateShippingPerItemResponseItemEntity
	Local oNode2
	::Init()
	If oResponse = NIL ; Return ; Endif
	::citem              :=  WSAdvValue( oResponse,"_ITEM","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode2 :=  WSAdvValue( oResponse,"_SHIPPING_INFO","integratorEstimateShippingResponseItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode2 != NIL
		::oWSshipping_info := MagentoService_integratorEstimateShippingResponseItemEntityArray():New()
		::oWSshipping_info:SoapRecv(oNode2)
	EndIf
Return

// WSDL Data Structure integratorOrderEntity

WSSTRUCT MagentoService_integratorOrderEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   ccustomer_id              AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   csubtotal                 AS string OPTIONAL
	WSDATA   cgrand_total              AS string OPTIONAL
	WSDATA   ctotal_paid               AS string OPTIONAL
	WSDATA   ctotal_refunded           AS string OPTIONAL
	WSDATA   ctotal_qty_ordered        AS string OPTIONAL
	WSDATA   ctotal_canceled           AS string OPTIONAL
	WSDATA   ctotal_invoiced           AS string OPTIONAL
	WSDATA   ctotal_online_refunded    AS string OPTIONAL
	WSDATA   ctotal_offline_refunded   AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cbase_shipping_amount     AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cbase_subtotal            AS string OPTIONAL
	WSDATA   cbase_grand_total         AS string OPTIONAL
	WSDATA   cbase_total_paid          AS string OPTIONAL
	WSDATA   cbase_total_refunded      AS string OPTIONAL
	WSDATA   cbase_total_qty_ordered   AS string OPTIONAL
	WSDATA   cbase_total_canceled      AS string OPTIONAL
	WSDATA   cbase_total_invoiced      AS string OPTIONAL
	WSDATA   cbase_total_online_refunded AS string OPTIONAL
	WSDATA   cbase_total_offline_refunded AS string OPTIONAL
	WSDATA   cbilling_address_id       AS string OPTIONAL
	WSDATA   cbilling_firstname        AS string OPTIONAL
	WSDATA   cbilling_lastname         AS string OPTIONAL
	WSDATA   cshipping_address_id      AS string OPTIONAL
	WSDATA   cshipping_firstname       AS string OPTIONAL
	WSDATA   cshipping_lastname        AS string OPTIONAL
	WSDATA   cbilling_name             AS string OPTIONAL
	WSDATA   cshipping_name            AS string OPTIONAL
	WSDATA   cstore_to_base_rate       AS string OPTIONAL
	WSDATA   cstore_to_order_rate      AS string OPTIONAL
	WSDATA   cbase_to_global_rate      AS string OPTIONAL
	WSDATA   cbase_to_order_rate       AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cstore_name               AS string OPTIONAL
	WSDATA   cremote_ip                AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   cstate                    AS string OPTIONAL
	WSDATA   capplied_rule_ids         AS string OPTIONAL
	WSDATA   cglobal_currency_code     AS string OPTIONAL
	WSDATA   cbase_currency_code       AS string OPTIONAL
	WSDATA   cstore_currency_code      AS string OPTIONAL
	WSDATA   corder_currency_code      AS string OPTIONAL
	WSDATA   cshipping_method          AS string OPTIONAL
	WSDATA   cshipping_description     AS string OPTIONAL
	WSDATA   ccustomer_email           AS string OPTIONAL
	WSDATA   ccustomer_firstname       AS string OPTIONAL
	WSDATA   ccustomer_lastname        AS string OPTIONAL
	WSDATA   cquote_id                 AS string OPTIONAL
	WSDATA   cis_virtual               AS string OPTIONAL
	WSDATA   ccustomer_group_id        AS string OPTIONAL
	WSDATA   ccustomer_note_notify     AS string OPTIONAL
	WSDATA   ccustomer_is_guest        AS string OPTIONAL
	WSDATA   cemail_sent               AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   cgift_message_id          AS string OPTIONAL
	WSDATA   cgift_message             AS string OPTIONAL
	WSDATA   oWSshipping_address       AS MagentoService_salesOrderAddressEntity OPTIONAL
	WSDATA   oWSbilling_address        AS MagentoService_integratorOrderAddressEntity OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_salesOrderItemEntityArray OPTIONAL
	WSDATA   oWSpayment                AS MagentoService_salesOrderPaymentEntity OPTIONAL
	WSDATA   oWSstatus_history         AS MagentoService_salesOrderStatusHistoryEntityArray OPTIONAL
	WSDATA   ccustomer_dob             AS string OPTIONAL
	WSDATA   ccustomer_gender          AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorOrderEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorOrderEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorOrderEntity
	Local oClone := MagentoService_integratorOrderEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:cstore_id            := ::cstore_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:ccustomer_id         := ::ccustomer_id
	oClone:ctax_amount          := ::ctax_amount
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:csubtotal            := ::csubtotal
	oClone:cgrand_total         := ::cgrand_total
	oClone:ctotal_paid          := ::ctotal_paid
	oClone:ctotal_refunded      := ::ctotal_refunded
	oClone:ctotal_qty_ordered   := ::ctotal_qty_ordered
	oClone:ctotal_canceled      := ::ctotal_canceled
	oClone:ctotal_invoiced      := ::ctotal_invoiced
	oClone:ctotal_online_refunded := ::ctotal_online_refunded
	oClone:ctotal_offline_refunded := ::ctotal_offline_refunded
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cbase_shipping_amount := ::cbase_shipping_amount
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cbase_subtotal       := ::cbase_subtotal
	oClone:cbase_grand_total    := ::cbase_grand_total
	oClone:cbase_total_paid     := ::cbase_total_paid
	oClone:cbase_total_refunded := ::cbase_total_refunded
	oClone:cbase_total_qty_ordered := ::cbase_total_qty_ordered
	oClone:cbase_total_canceled := ::cbase_total_canceled
	oClone:cbase_total_invoiced := ::cbase_total_invoiced
	oClone:cbase_total_online_refunded := ::cbase_total_online_refunded
	oClone:cbase_total_offline_refunded := ::cbase_total_offline_refunded
	oClone:cbilling_address_id  := ::cbilling_address_id
	oClone:cbilling_firstname   := ::cbilling_firstname
	oClone:cbilling_lastname    := ::cbilling_lastname
	oClone:cshipping_address_id := ::cshipping_address_id
	oClone:cshipping_firstname  := ::cshipping_firstname
	oClone:cshipping_lastname   := ::cshipping_lastname
	oClone:cbilling_name        := ::cbilling_name
	oClone:cshipping_name       := ::cshipping_name
	oClone:cstore_to_base_rate  := ::cstore_to_base_rate
	oClone:cstore_to_order_rate := ::cstore_to_order_rate
	oClone:cbase_to_global_rate := ::cbase_to_global_rate
	oClone:cbase_to_order_rate  := ::cbase_to_order_rate
	oClone:cweight              := ::cweight
	oClone:cstore_name          := ::cstore_name
	oClone:cremote_ip           := ::cremote_ip
	oClone:cstatus              := ::cstatus
	oClone:cstate               := ::cstate
	oClone:capplied_rule_ids    := ::capplied_rule_ids
	oClone:cglobal_currency_code := ::cglobal_currency_code
	oClone:cbase_currency_code  := ::cbase_currency_code
	oClone:cstore_currency_code := ::cstore_currency_code
	oClone:corder_currency_code := ::corder_currency_code
	oClone:cshipping_method     := ::cshipping_method
	oClone:cshipping_description := ::cshipping_description
	oClone:ccustomer_email      := ::ccustomer_email
	oClone:ccustomer_firstname  := ::ccustomer_firstname
	oClone:ccustomer_lastname   := ::ccustomer_lastname
	oClone:cquote_id            := ::cquote_id
	oClone:cis_virtual          := ::cis_virtual
	oClone:ccustomer_group_id   := ::ccustomer_group_id
	oClone:ccustomer_note_notify := ::ccustomer_note_notify
	oClone:ccustomer_is_guest   := ::ccustomer_is_guest
	oClone:cemail_sent          := ::cemail_sent
	oClone:corder_id            := ::corder_id
	oClone:cgift_message_id     := ::cgift_message_id
	oClone:cgift_message        := ::cgift_message
	oClone:oWSshipping_address  := IIF(::oWSshipping_address = NIL , NIL , ::oWSshipping_address:Clone() )
	oClone:oWSbilling_address   := IIF(::oWSbilling_address = NIL , NIL , ::oWSbilling_address:Clone() )
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:oWSpayment           := IIF(::oWSpayment = NIL , NIL , ::oWSpayment:Clone() )
	oClone:oWSstatus_history    := IIF(::oWSstatus_history = NIL , NIL , ::oWSstatus_history:Clone() )
	oClone:ccustomer_dob        := ::ccustomer_dob
	oClone:ccustomer_gender     := ::ccustomer_gender
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorOrderEntity
	Local oNode68
	Local oNode69
	Local oNode70
	Local oNode71
	Local oNode72
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_id       :=  WSAdvValue( oResponse,"_CUSTOMER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_amount   :=  WSAdvValue( oResponse,"_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csubtotal          :=  WSAdvValue( oResponse,"_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgrand_total       :=  WSAdvValue( oResponse,"_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_paid        :=  WSAdvValue( oResponse,"_TOTAL_PAID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_refunded    :=  WSAdvValue( oResponse,"_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_qty_ordered :=  WSAdvValue( oResponse,"_TOTAL_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_canceled    :=  WSAdvValue( oResponse,"_TOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_invoiced    :=  WSAdvValue( oResponse,"_TOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_online_refunded :=  WSAdvValue( oResponse,"_TOTAL_ONLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctotal_offline_refunded :=  WSAdvValue( oResponse,"_TOTAL_OFFLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_shipping_amount :=  WSAdvValue( oResponse,"_BASE_SHIPPING_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_subtotal     :=  WSAdvValue( oResponse,"_BASE_SUBTOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_grand_total  :=  WSAdvValue( oResponse,"_BASE_GRAND_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_paid   :=  WSAdvValue( oResponse,"_BASE_TOTAL_PAID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_qty_ordered :=  WSAdvValue( oResponse,"_BASE_TOTAL_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_canceled :=  WSAdvValue( oResponse,"_BASE_TOTAL_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_invoiced :=  WSAdvValue( oResponse,"_BASE_TOTAL_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_online_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_ONLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_total_offline_refunded :=  WSAdvValue( oResponse,"_BASE_TOTAL_OFFLINE_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_address_id :=  WSAdvValue( oResponse,"_BILLING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_firstname :=  WSAdvValue( oResponse,"_BILLING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_lastname  :=  WSAdvValue( oResponse,"_BILLING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_address_id :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_firstname :=  WSAdvValue( oResponse,"_SHIPPING_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_lastname :=  WSAdvValue( oResponse,"_SHIPPING_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbilling_name      :=  WSAdvValue( oResponse,"_BILLING_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_name     :=  WSAdvValue( oResponse,"_SHIPPING_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_base_rate :=  WSAdvValue( oResponse,"_STORE_TO_BASE_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_to_order_rate :=  WSAdvValue( oResponse,"_STORE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_global_rate :=  WSAdvValue( oResponse,"_BASE_TO_GLOBAL_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_to_order_rate :=  WSAdvValue( oResponse,"_BASE_TO_ORDER_RATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_name        :=  WSAdvValue( oResponse,"_STORE_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cremote_ip         :=  WSAdvValue( oResponse,"_REMOTE_IP","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstate             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::capplied_rule_ids  :=  WSAdvValue( oResponse,"_APPLIED_RULE_IDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cglobal_currency_code :=  WSAdvValue( oResponse,"_GLOBAL_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_currency_code :=  WSAdvValue( oResponse,"_BASE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_currency_code :=  WSAdvValue( oResponse,"_STORE_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_currency_code :=  WSAdvValue( oResponse,"_ORDER_CURRENCY_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_method   :=  WSAdvValue( oResponse,"_SHIPPING_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_description :=  WSAdvValue( oResponse,"_SHIPPING_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_email    :=  WSAdvValue( oResponse,"_CUSTOMER_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_firstname :=  WSAdvValue( oResponse,"_CUSTOMER_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_lastname :=  WSAdvValue( oResponse,"_CUSTOMER_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cquote_id          :=  WSAdvValue( oResponse,"_QUOTE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_virtual        :=  WSAdvValue( oResponse,"_IS_VIRTUAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_group_id :=  WSAdvValue( oResponse,"_CUSTOMER_GROUP_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_note_notify :=  WSAdvValue( oResponse,"_CUSTOMER_NOTE_NOTIFY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_is_guest :=  WSAdvValue( oResponse,"_CUSTOMER_IS_GUEST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cemail_sent        :=  WSAdvValue( oResponse,"_EMAIL_SENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_id   :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message      :=  WSAdvValue( oResponse,"_GIFT_MESSAGE","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode68 :=  WSAdvValue( oResponse,"_SHIPPING_ADDRESS","salesOrderAddressEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode68 != NIL
		::oWSshipping_address := MagentoService_salesOrderAddressEntity():New()
		::oWSshipping_address:SoapRecv(oNode68)
	EndIf
	oNode69 :=  WSAdvValue( oResponse,"_BILLING_ADDRESS","integratorOrderAddressEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode69 != NIL
		::oWSbilling_address := MagentoService_integratorOrderAddressEntity():New()
		::oWSbilling_address:SoapRecv(oNode69)
	EndIf
	oNode70 :=  WSAdvValue( oResponse,"_ITEMS","salesOrderItemEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode70 != NIL
		::oWSitems := MagentoService_salesOrderItemEntityArray():New()
		::oWSitems:SoapRecv(oNode70)
	EndIf
	oNode71 :=  WSAdvValue( oResponse,"_PAYMENT","salesOrderPaymentEntity",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode71 != NIL
		::oWSpayment := MagentoService_salesOrderPaymentEntity():New()
		::oWSpayment:SoapRecv(oNode71)
	EndIf
	oNode72 :=  WSAdvValue( oResponse,"_STATUS_HISTORY","salesOrderStatusHistoryEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode72 != NIL
		::oWSstatus_history := MagentoService_salesOrderStatusHistoryEntityArray():New()
		::oWSstatus_history:SoapRecv(oNode72)
	EndIf
	::ccustomer_dob      :=  WSAdvValue( oResponse,"_CUSTOMER_DOB","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_gender   :=  WSAdvValue( oResponse,"_CUSTOMER_GENDER","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorCreateOrderEntity

WSSTRUCT MagentoService_integratorCreateOrderEntity
	WSDATA   cskyhub_code              AS string OPTIONAL
	WSDATA   cshipping_amount          AS string OPTIONAL
	WSDATA   cshipping_description     AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   ccustomer_email           AS string OPTIONAL
	WSDATA   ccustomer_firstname       AS string OPTIONAL
	WSDATA   ccustomer_lastname        AS string OPTIONAL
	WSDATA   oWSshipping_address       AS MagentoService_integratorCreateOrderAddressEntity OPTIONAL
	WSDATA   oWSbilling_address        AS MagentoService_integratorCreateOrderAddressEntity OPTIONAL
	WSDATA   oWSitems                  AS MagentoService_integratorCreateOrderItemEntityArray OPTIONAL
	WSDATA   ccustomer_dob             AS string OPTIONAL
	WSDATA   ccustomer_gender          AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorCreateOrderEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorCreateOrderEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorCreateOrderEntity
	Local oClone := MagentoService_integratorCreateOrderEntity():NEW()
	oClone:cskyhub_code         := ::cskyhub_code
	oClone:cshipping_amount     := ::cshipping_amount
	oClone:cshipping_description := ::cshipping_description
	oClone:cstatus              := ::cstatus
	oClone:ccustomer_email      := ::ccustomer_email
	oClone:ccustomer_firstname  := ::ccustomer_firstname
	oClone:ccustomer_lastname   := ::ccustomer_lastname
	oClone:oWSshipping_address  := IIF(::oWSshipping_address = NIL , NIL , ::oWSshipping_address:Clone() )
	oClone:oWSbilling_address   := IIF(::oWSbilling_address = NIL , NIL , ::oWSbilling_address:Clone() )
	oClone:oWSitems             := IIF(::oWSitems = NIL , NIL , ::oWSitems:Clone() )
	oClone:ccustomer_dob        := ::ccustomer_dob
	oClone:ccustomer_gender     := ::ccustomer_gender
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorCreateOrderEntity
	Local cSoap := ""
	cSoap += WSSoapValue("skyhub_code", ::cskyhub_code, ::cskyhub_code , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipping_amount", ::cshipping_amount, ::cshipping_amount , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipping_description", ::cshipping_description, ::cshipping_description , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("status", ::cstatus, ::cstatus , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_email", ::ccustomer_email, ::ccustomer_email , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_firstname", ::ccustomer_firstname, ::ccustomer_firstname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_lastname", ::ccustomer_lastname, ::ccustomer_lastname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipping_address", ::oWSshipping_address, ::oWSshipping_address , "integratorCreateOrderAddressEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("billing_address", ::oWSbilling_address, ::oWSbilling_address , "integratorCreateOrderAddressEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("items", ::oWSitems, ::oWSitems , "integratorCreateOrderItemEntityArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_dob", ::ccustomer_dob, ::ccustomer_dob , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_gender", ::ccustomer_gender, ::ccustomer_gender , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure integratorUpdateOrderEntity

WSSTRUCT MagentoService_integratorUpdateOrderEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cskyhub_code              AS string OPTIONAL
	WSDATA   ccustomer_email           AS string OPTIONAL
	WSDATA   oWSshipping_address       AS MagentoService_integratorCreateOrderAddressEntity OPTIONAL
	WSDATA   oWSbilling_address        AS MagentoService_integratorCreateOrderAddressEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorUpdateOrderEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorUpdateOrderEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorUpdateOrderEntity
	Local oClone := MagentoService_integratorUpdateOrderEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cskyhub_code         := ::cskyhub_code
	oClone:ccustomer_email      := ::ccustomer_email
	oClone:oWSshipping_address  := IIF(::oWSshipping_address = NIL , NIL , ::oWSshipping_address:Clone() )
	oClone:oWSbilling_address   := IIF(::oWSbilling_address = NIL , NIL , ::oWSbilling_address:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorUpdateOrderEntity
	Local cSoap := ""
	cSoap += WSSoapValue("increment_id", ::cincrement_id, ::cincrement_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("skyhub_code", ::cskyhub_code, ::cskyhub_code , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("customer_email", ::ccustomer_email, ::ccustomer_email , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("shipping_address", ::oWSshipping_address, ::oWSshipping_address , "integratorCreateOrderAddressEntity", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("billing_address", ::oWSbilling_address, ::oWSbilling_address , "integratorCreateOrderAddressEntity", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure integratorListStatusEntityArray

WSSTRUCT MagentoService_integratorListStatusEntityArray
	WSDATA   oWSintegratorStatusEntity AS MagentoService_integratorStatusEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorListStatusEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorListStatusEntityArray
	::oWSintegratorStatusEntity := {} // Array Of  MagentoService_INTEGRATORSTATUSENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorListStatusEntityArray
	Local oClone := MagentoService_integratorListStatusEntityArray():NEW()
	oClone:oWSintegratorStatusEntity := NIL
	If ::oWSintegratorStatusEntity <> NIL
		oClone:oWSintegratorStatusEntity := {}
		aEval( ::oWSintegratorStatusEntity , { |x| aadd( oClone:oWSintegratorStatusEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorListStatusEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorStatusEntity , MagentoService_integratorStatusEntity():New() )
			::oWSintegratorStatusEntity[len(::oWSintegratorStatusEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorStatusEntity

WSSTRUCT MagentoService_integratorStatusEntity
	WSDATA   cstate                    AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   cstatus_label             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorStatusEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorStatusEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorStatusEntity
	Local oClone := MagentoService_integratorStatusEntity():NEW()
	oClone:cstate               := ::cstate
	oClone:cstatus              := ::cstatus
	oClone:cstatus_label        := ::cstatus_label
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorStatusEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cstate             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus_label      :=  WSAdvValue( oResponse,"_STATUS_LABEL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorProductReturnEntityArray

WSSTRUCT MagentoService_integratorProductReturnEntityArray
	WSDATA   oWSintegratorProductReturnEntity AS MagentoService_integratorProductReturnEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorProductReturnEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorProductReturnEntityArray
	::oWSintegratorProductReturnEntity := {} // Array Of  MagentoService_INTEGRATORPRODUCTRETURNENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorProductReturnEntityArray
	Local oClone := MagentoService_integratorProductReturnEntityArray():NEW()
	oClone:oWSintegratorProductReturnEntity := NIL
	If ::oWSintegratorProductReturnEntity <> NIL
		oClone:oWSintegratorProductReturnEntity := {}
		aEval( ::oWSintegratorProductReturnEntity , { |x| aadd( oClone:oWSintegratorProductReturnEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorProductReturnEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorProductReturnEntity , MagentoService_integratorProductReturnEntity():New() )
			::oWSintegratorProductReturnEntity[len(::oWSintegratorProductReturnEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorProductReturnEntity

WSSTRUCT MagentoService_integratorProductReturnEntity
	WSDATA   oWSattributes             AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSmultiselect_attributes AS MagentoService_associativeArray OPTIONAL
	WSDATA   oWSconfigurable_attributes AS MagentoService_integratorConfigurableAttributeArray OPTIONAL
	WSDATA   oWSvariations             AS MagentoService_integratorConfigurableProductVariationArray OPTIONAL
	WSDATA   oWSbundle_components      AS MagentoService_integratorBundleProductComponentsArray OPTIONAL
	WSDATA   oWSimage_urls             AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   cfull_url                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorProductReturnEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorProductReturnEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorProductReturnEntity
	Local oClone := MagentoService_integratorProductReturnEntity():NEW()
	oClone:oWSattributes        := IIF(::oWSattributes = NIL , NIL , ::oWSattributes:Clone() )
	oClone:oWSmultiselect_attributes := IIF(::oWSmultiselect_attributes = NIL , NIL , ::oWSmultiselect_attributes:Clone() )
	oClone:oWSconfigurable_attributes := IIF(::oWSconfigurable_attributes = NIL , NIL , ::oWSconfigurable_attributes:Clone() )
	oClone:oWSvariations        := IIF(::oWSvariations = NIL , NIL , ::oWSvariations:Clone() )
	oClone:oWSbundle_components := IIF(::oWSbundle_components = NIL , NIL , ::oWSbundle_components:Clone() )
	oClone:oWSimage_urls        := IIF(::oWSimage_urls = NIL , NIL , ::oWSimage_urls:Clone() )
	oClone:cfull_url            := ::cfull_url
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorProductReturnEntity
	Local oNode1
	Local oNode2
	Local oNode3
	Local oNode4
	Local oNode5
	Local oNode6
	::Init()
	If oResponse = NIL ; Return ; Endif
	oNode1 :=  WSAdvValue( oResponse,"_ATTRIBUTES","associativeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode1 != NIL
		::oWSattributes := MagentoService_associativeArray():New()
		::oWSattributes:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_MULTISELECT_ATTRIBUTES","associativeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode2 != NIL
		::oWSmultiselect_attributes := MagentoService_associativeArray():New()
		::oWSmultiselect_attributes:SoapRecv(oNode2)
	EndIf
	oNode3 :=  WSAdvValue( oResponse,"_CONFIGURABLE_ATTRIBUTES","integratorConfigurableAttributeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode3 != NIL
		::oWSconfigurable_attributes := MagentoService_integratorConfigurableAttributeArray():New()
		::oWSconfigurable_attributes:SoapRecv(oNode3)
	EndIf
	oNode4 :=  WSAdvValue( oResponse,"_VARIATIONS","integratorConfigurableProductVariationArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSvariations := MagentoService_integratorConfigurableProductVariationArray():New()
		::oWSvariations:SoapRecv(oNode4)
	EndIf
	oNode5 :=  WSAdvValue( oResponse,"_BUNDLE_COMPONENTS","integratorBundleProductComponentsArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode5 != NIL
		::oWSbundle_components := MagentoService_integratorBundleProductComponentsArray():New()
		::oWSbundle_components:SoapRecv(oNode5)
	EndIf
	oNode6 :=  WSAdvValue( oResponse,"_IMAGE_URLS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode6 != NIL
		::oWSimage_urls := MagentoService_ArrayOfString():New()
		::oWSimage_urls:SoapRecv(oNode6)
	EndIf
	::cfull_url          :=  WSAdvValue( oResponse,"_FULL_URL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure ArrayOfApiMethods

WSSTRUCT MagentoService_ArrayOfApiMethods
	WSDATA   oWSapiMethodEntity        AS MagentoService_apiMethodEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_ArrayOfApiMethods
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_ArrayOfApiMethods
	::oWSapiMethodEntity   := {} // Array Of  MagentoService_APIMETHODENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_ArrayOfApiMethods
	Local oClone := MagentoService_ArrayOfApiMethods():NEW()
	oClone:oWSapiMethodEntity := NIL
	If ::oWSapiMethodEntity <> NIL
		oClone:oWSapiMethodEntity := {}
		aEval( ::oWSapiMethodEntity , { |x| aadd( oClone:oWSapiMethodEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_ArrayOfApiMethods
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSapiMethodEntity , MagentoService_apiMethodEntity():New() )
			::oWSapiMethodEntity[len(::oWSapiMethodEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure complexFilter

WSSTRUCT MagentoService_complexFilter
	WSDATA   ckey                      AS string OPTIONAL
	WSDATA   oWSvalue                  AS MagentoService_associativeEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_complexFilter
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_complexFilter
Return

WSMETHOD CLONE WSCLIENT MagentoService_complexFilter
	Local oClone := MagentoService_complexFilter():NEW()
	oClone:ckey                 := ::ckey
	oClone:oWSvalue             := IIF(::oWSvalue = NIL , NIL , ::oWSvalue:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_complexFilter
	Local cSoap := ""
	cSoap += WSSoapValue("key", ::ckey, ::ckey , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("value", ::oWSvalue, ::oWSvalue , "associativeEntity", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogCategoryEntity

WSSTRUCT MagentoService_catalogCategoryEntity
	WSDATA   ncategory_id              AS int OPTIONAL
	WSDATA   nparent_id                AS int OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   nis_active                AS int OPTIONAL
	WSDATA   nposition                 AS int OPTIONAL
	WSDATA   nlevel                    AS int OPTIONAL
	WSDATA   oWSchildren               AS MagentoService_ArrayOfCatalogCategoryEntities OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogCategoryEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogCategoryEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogCategoryEntity
	Local oClone := MagentoService_catalogCategoryEntity():NEW()
	oClone:ncategory_id         := ::ncategory_id
	oClone:nparent_id           := ::nparent_id
	oClone:cname                := ::cname
	oClone:nis_active           := ::nis_active
	oClone:nposition            := ::nposition
	oClone:nlevel               := ::nlevel
	oClone:oWSchildren          := IIF(::oWSchildren = NIL , NIL , ::oWSchildren:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogCategoryEntity
	Local oNode7
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ncategory_id       :=  WSAdvValue( oResponse,"_CATEGORY_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nposition          :=  WSAdvValue( oResponse,"_POSITION","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nlevel             :=  WSAdvValue( oResponse,"_LEVEL","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode7 :=  WSAdvValue( oResponse,"_CHILDREN","ArrayOfCatalogCategoryEntities",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode7 != NIL
		::oWSchildren := MagentoService_ArrayOfCatalogCategoryEntities():New()
		::oWSchildren:SoapRecv(oNode7)
	EndIf
Return

// WSDL Data Structure catalogProductAdditionalAttributesEntity

WSSTRUCT MagentoService_catalogProductAdditionalAttributesEntity
	WSDATA   oWSmulti_data             AS MagentoService_associativeMultiArray OPTIONAL
	WSDATA   oWSsingle_data            AS MagentoService_associativeArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAdditionalAttributesEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAdditionalAttributesEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAdditionalAttributesEntity
	Local oClone := MagentoService_catalogProductAdditionalAttributesEntity():NEW()
	oClone:oWSmulti_data        := IIF(::oWSmulti_data = NIL , NIL , ::oWSmulti_data:Clone() )
	oClone:oWSsingle_data       := IIF(::oWSsingle_data = NIL , NIL , ::oWSsingle_data:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAdditionalAttributesEntity
	Local cSoap := ""
	cSoap += WSSoapValue("multi_data", ::oWSmulti_data, ::oWSmulti_data , "associativeMultiArray", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("single_data", ::oWSsingle_data, ::oWSsingle_data , "associativeArray", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductAttributeFrontendLabelEntity

WSSTRUCT MagentoService_catalogProductAttributeFrontendLabelEntity
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   clabel                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeFrontendLabelEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeFrontendLabelEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeFrontendLabelEntity
	Local oClone := MagentoService_catalogProductAttributeFrontendLabelEntity():NEW()
	oClone:cstore_id            := ::cstore_id
	oClone:clabel               := ::clabel
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeFrontendLabelEntity
	Local cSoap := ""
	cSoap += WSSoapValue("store_id", ::cstore_id, ::cstore_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("label", ::clabel, ::clabel , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductAttributeFrontendLabelEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clabel             :=  WSAdvValue( oResponse,"_LABEL","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductAttributeOptionLabelEntity

WSSTRUCT MagentoService_catalogProductAttributeOptionLabelEntity
	WSDATA   oWSstore_id               AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   cvalue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductAttributeOptionLabelEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductAttributeOptionLabelEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductAttributeOptionLabelEntity
	Local oClone := MagentoService_catalogProductAttributeOptionLabelEntity():NEW()
	oClone:oWSstore_id          := IIF(::oWSstore_id = NIL , NIL , ::oWSstore_id:Clone() )
	oClone:cvalue               := ::cvalue
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductAttributeOptionLabelEntity
	Local cSoap := ""
	cSoap += WSSoapValue("store_id", ::oWSstore_id, ::oWSstore_id , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("value", ::cvalue, ::cvalue , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductImageFileEntity

WSSTRUCT MagentoService_catalogProductImageFileEntity
	WSDATA   ccontent                  AS string OPTIONAL
	WSDATA   cmime                     AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductImageFileEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductImageFileEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductImageFileEntity
	Local oClone := MagentoService_catalogProductImageFileEntity():NEW()
	oClone:ccontent             := ::ccontent
	oClone:cmime                := ::cmime
	oClone:cname                := ::cname
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductImageFileEntity
	Local cSoap := ""
	cSoap += WSSoapValue("content", ::ccontent, ::ccontent , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("mime", ::cmime, ::cmime , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("name", ::cname, ::cname , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductCustomOptionAdditionalFieldsArray

WSSTRUCT MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	WSDATA   oWScatalogProductCustomOptionAdditionalFieldsEntity AS MagentoService_catalogProductCustomOptionAdditionalFieldsEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	::oWScatalogProductCustomOptionAdditionalFieldsEntity := {} // Array Of  MagentoService_CATALOGPRODUCTCUSTOMOPTIONADDITIONALFIELDSENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	Local oClone := MagentoService_catalogProductCustomOptionAdditionalFieldsArray():NEW()
	oClone:oWScatalogProductCustomOptionAdditionalFieldsEntity := NIL
	If ::oWScatalogProductCustomOptionAdditionalFieldsEntity <> NIL
		oClone:oWScatalogProductCustomOptionAdditionalFieldsEntity := {}
		aEval( ::oWScatalogProductCustomOptionAdditionalFieldsEntity , { |x| aadd( oClone:oWScatalogProductCustomOptionAdditionalFieldsEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	Local cSoap := ""
	aEval( ::oWScatalogProductCustomOptionAdditionalFieldsEntity , {|x| cSoap := cSoap  +  WSSoapValue("catalogProductCustomOptionAdditionalFieldsEntity", x , x , "catalogProductCustomOptionAdditionalFieldsEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductCustomOptionAdditionalFieldsEntity , MagentoService_catalogProductCustomOptionAdditionalFieldsEntity():New() )
			::oWScatalogProductCustomOptionAdditionalFieldsEntity[len(::oWScatalogProductCustomOptionAdditionalFieldsEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderItemEntity

WSSTRUCT MagentoService_salesOrderItemEntity
	WSDATA   citem_id                  AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   cquote_item_id            AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   cproduct_type             AS string OPTIONAL
	WSDATA   cproduct_options          AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cis_virtual               AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   capplied_rule_ids         AS string OPTIONAL
	WSDATA   cfree_shipping            AS string OPTIONAL
	WSDATA   cis_qty_decimal           AS string OPTIONAL
	WSDATA   cno_discount              AS string OPTIONAL
	WSDATA   cqty_canceled             AS string OPTIONAL
	WSDATA   cqty_invoiced             AS string OPTIONAL
	WSDATA   cqty_ordered              AS string OPTIONAL
	WSDATA   cqty_refunded             AS string OPTIONAL
	WSDATA   cqty_shipped              AS string OPTIONAL
	WSDATA   ccost                     AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cbase_price               AS string OPTIONAL
	WSDATA   coriginal_price           AS string OPTIONAL
	WSDATA   cbase_original_price      AS string OPTIONAL
	WSDATA   ctax_percent              AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   ctax_invoiced             AS string OPTIONAL
	WSDATA   cbase_tax_invoiced        AS string OPTIONAL
	WSDATA   cdiscount_percent         AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cdiscount_invoiced        AS string OPTIONAL
	WSDATA   cbase_discount_invoiced   AS string OPTIONAL
	WSDATA   camount_refunded          AS string OPTIONAL
	WSDATA   cbase_amount_refunded     AS string OPTIONAL
	WSDATA   crow_total                AS string OPTIONAL
	WSDATA   cbase_row_total           AS string OPTIONAL
	WSDATA   crow_invoiced             AS string OPTIONAL
	WSDATA   cbase_row_invoiced        AS string OPTIONAL
	WSDATA   crow_weight               AS string OPTIONAL
	WSDATA   cgift_message_id          AS string OPTIONAL
	WSDATA   cgift_message             AS string OPTIONAL
	WSDATA   cgift_message_available   AS string OPTIONAL
	WSDATA   cbase_tax_before_discount AS string OPTIONAL
	WSDATA   ctax_before_discount      AS string OPTIONAL
	WSDATA   cweee_tax_applied         AS string OPTIONAL
	WSDATA   cweee_tax_applied_amount  AS string OPTIONAL
	WSDATA   cweee_tax_applied_row_amount AS string OPTIONAL
	WSDATA   cbase_weee_tax_applied_amount AS string OPTIONAL
	WSDATA   cbase_weee_tax_applied_row_amount AS string OPTIONAL
	WSDATA   cweee_tax_disposition     AS string OPTIONAL
	WSDATA   cweee_tax_row_disposition AS string OPTIONAL
	WSDATA   cbase_weee_tax_disposition AS string OPTIONAL
	WSDATA   cbase_weee_tax_row_disposition AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderItemEntity
	Local oClone := MagentoService_salesOrderItemEntity():NEW()
	oClone:citem_id             := ::citem_id
	oClone:corder_id            := ::corder_id
	oClone:cquote_item_id       := ::cquote_item_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cproduct_id          := ::cproduct_id
	oClone:cproduct_type        := ::cproduct_type
	oClone:cproduct_options     := ::cproduct_options
	oClone:cweight              := ::cweight
	oClone:cis_virtual          := ::cis_virtual
	oClone:csku                 := ::csku
	oClone:cname                := ::cname
	oClone:capplied_rule_ids    := ::capplied_rule_ids
	oClone:cfree_shipping       := ::cfree_shipping
	oClone:cis_qty_decimal      := ::cis_qty_decimal
	oClone:cno_discount         := ::cno_discount
	oClone:cqty_canceled        := ::cqty_canceled
	oClone:cqty_invoiced        := ::cqty_invoiced
	oClone:cqty_ordered         := ::cqty_ordered
	oClone:cqty_refunded        := ::cqty_refunded
	oClone:cqty_shipped         := ::cqty_shipped
	oClone:ccost                := ::ccost
	oClone:cprice               := ::cprice
	oClone:cbase_price          := ::cbase_price
	oClone:coriginal_price      := ::coriginal_price
	oClone:cbase_original_price := ::cbase_original_price
	oClone:ctax_percent         := ::ctax_percent
	oClone:ctax_amount          := ::ctax_amount
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:ctax_invoiced        := ::ctax_invoiced
	oClone:cbase_tax_invoiced   := ::cbase_tax_invoiced
	oClone:cdiscount_percent    := ::cdiscount_percent
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cdiscount_invoiced   := ::cdiscount_invoiced
	oClone:cbase_discount_invoiced := ::cbase_discount_invoiced
	oClone:camount_refunded     := ::camount_refunded
	oClone:cbase_amount_refunded := ::cbase_amount_refunded
	oClone:crow_total           := ::crow_total
	oClone:cbase_row_total      := ::cbase_row_total
	oClone:crow_invoiced        := ::crow_invoiced
	oClone:cbase_row_invoiced   := ::cbase_row_invoiced
	oClone:crow_weight          := ::crow_weight
	oClone:cgift_message_id     := ::cgift_message_id
	oClone:cgift_message        := ::cgift_message
	oClone:cgift_message_available := ::cgift_message_available
	oClone:cbase_tax_before_discount := ::cbase_tax_before_discount
	oClone:ctax_before_discount := ::ctax_before_discount
	oClone:cweee_tax_applied    := ::cweee_tax_applied
	oClone:cweee_tax_applied_amount := ::cweee_tax_applied_amount
	oClone:cweee_tax_applied_row_amount := ::cweee_tax_applied_row_amount
	oClone:cbase_weee_tax_applied_amount := ::cbase_weee_tax_applied_amount
	oClone:cbase_weee_tax_applied_row_amount := ::cbase_weee_tax_applied_row_amount
	oClone:cweee_tax_disposition := ::cweee_tax_disposition
	oClone:cweee_tax_row_disposition := ::cweee_tax_row_disposition
	oClone:cbase_weee_tax_disposition := ::cbase_weee_tax_disposition
	oClone:cbase_weee_tax_row_disposition := ::cbase_weee_tax_row_disposition
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::citem_id           :=  WSAdvValue( oResponse,"_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cquote_item_id     :=  WSAdvValue( oResponse,"_QUOTE_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_type      :=  WSAdvValue( oResponse,"_PRODUCT_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_options   :=  WSAdvValue( oResponse,"_PRODUCT_OPTIONS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_virtual        :=  WSAdvValue( oResponse,"_IS_VIRTUAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::capplied_rule_ids  :=  WSAdvValue( oResponse,"_APPLIED_RULE_IDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfree_shipping     :=  WSAdvValue( oResponse,"_FREE_SHIPPING","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_qty_decimal    :=  WSAdvValue( oResponse,"_IS_QTY_DECIMAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cno_discount       :=  WSAdvValue( oResponse,"_NO_DISCOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty_canceled      :=  WSAdvValue( oResponse,"_QTY_CANCELED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty_invoiced      :=  WSAdvValue( oResponse,"_QTY_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty_ordered       :=  WSAdvValue( oResponse,"_QTY_ORDERED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty_refunded      :=  WSAdvValue( oResponse,"_QTY_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty_shipped       :=  WSAdvValue( oResponse,"_QTY_SHIPPED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccost              :=  WSAdvValue( oResponse,"_COST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_price        :=  WSAdvValue( oResponse,"_BASE_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::coriginal_price    :=  WSAdvValue( oResponse,"_ORIGINAL_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_original_price :=  WSAdvValue( oResponse,"_BASE_ORIGINAL_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_percent       :=  WSAdvValue( oResponse,"_TAX_PERCENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_invoiced      :=  WSAdvValue( oResponse,"_TAX_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_invoiced :=  WSAdvValue( oResponse,"_BASE_TAX_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_percent  :=  WSAdvValue( oResponse,"_DISCOUNT_PERCENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_invoiced :=  WSAdvValue( oResponse,"_DISCOUNT_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_invoiced :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::camount_refunded   :=  WSAdvValue( oResponse,"_AMOUNT_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_amount_refunded :=  WSAdvValue( oResponse,"_BASE_AMOUNT_REFUNDED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crow_total         :=  WSAdvValue( oResponse,"_ROW_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_row_total    :=  WSAdvValue( oResponse,"_BASE_ROW_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crow_invoiced      :=  WSAdvValue( oResponse,"_ROW_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_row_invoiced :=  WSAdvValue( oResponse,"_BASE_ROW_INVOICED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crow_weight        :=  WSAdvValue( oResponse,"_ROW_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_id   :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message      :=  WSAdvValue( oResponse,"_GIFT_MESSAGE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_available :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_AVAILABLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_before_discount :=  WSAdvValue( oResponse,"_BASE_TAX_BEFORE_DISCOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_before_discount :=  WSAdvValue( oResponse,"_TAX_BEFORE_DISCOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied  :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_ROW_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_applied_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_ROW_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_row_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_ROW_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_row_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_ROW_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderStatusHistoryEntity

WSSTRUCT MagentoService_salesOrderStatusHistoryEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   cis_customer_notified     AS string OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSDATA   ccomment                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderStatusHistoryEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderStatusHistoryEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderStatusHistoryEntity
	Local oClone := MagentoService_salesOrderStatusHistoryEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:cis_customer_notified := ::cis_customer_notified
	oClone:cstatus              := ::cstatus
	oClone:ccomment             := ::ccomment
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderStatusHistoryEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_customer_notified :=  WSAdvValue( oResponse,"_IS_CUSTOMER_NOTIFIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment           :=  WSAdvValue( oResponse,"_COMMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderShipmentItemEntityArray

WSSTRUCT MagentoService_salesOrderShipmentItemEntityArray
	WSDATA   oWSsalesOrderShipmentItemEntity AS MagentoService_salesOrderShipmentItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentItemEntityArray
	::oWSsalesOrderShipmentItemEntity := {} // Array Of  MagentoService_SALESORDERSHIPMENTITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentItemEntityArray
	Local oClone := MagentoService_salesOrderShipmentItemEntityArray():NEW()
	oClone:oWSsalesOrderShipmentItemEntity := NIL
	If ::oWSsalesOrderShipmentItemEntity <> NIL
		oClone:oWSsalesOrderShipmentItemEntity := {}
		aEval( ::oWSsalesOrderShipmentItemEntity , { |x| aadd( oClone:oWSsalesOrderShipmentItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderShipmentItemEntity , MagentoService_salesOrderShipmentItemEntity():New() )
			::oWSsalesOrderShipmentItemEntity[len(::oWSsalesOrderShipmentItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderShipmentTrackEntity

WSSTRUCT MagentoService_salesOrderShipmentTrackEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   ccarrier_code             AS string OPTIONAL
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   cnumber                   AS string OPTIONAL
	WSDATA   corder_id                 AS string OPTIONAL
	WSDATA   ctrack_id                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentTrackEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentTrackEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentTrackEntity
	Local oClone := MagentoService_salesOrderShipmentTrackEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:ccarrier_code        := ::ccarrier_code
	oClone:ctitle               := ::ctitle
	oClone:cnumber              := ::cnumber
	oClone:corder_id            := ::corder_id
	oClone:ctrack_id            := ::ctrack_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentTrackEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccarrier_code      :=  WSAdvValue( oResponse,"_CARRIER_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cnumber            :=  WSAdvValue( oResponse,"_NUMBER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_id          :=  WSAdvValue( oResponse,"_ORDER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctrack_id          :=  WSAdvValue( oResponse,"_TRACK_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderShipmentCommentEntity

WSSTRUCT MagentoService_salesOrderShipmentCommentEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   ccomment                  AS string OPTIONAL
	WSDATA   cis_customer_notified     AS string OPTIONAL
	WSDATA   ccomment_id               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentCommentEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentCommentEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentCommentEntity
	Local oClone := MagentoService_salesOrderShipmentCommentEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:ccomment             := ::ccomment
	oClone:cis_customer_notified := ::cis_customer_notified
	oClone:ccomment_id          := ::ccomment_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentCommentEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment           :=  WSAdvValue( oResponse,"_COMMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_customer_notified :=  WSAdvValue( oResponse,"_IS_CUSTOMER_NOTIFIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment_id        :=  WSAdvValue( oResponse,"_COMMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderInvoiceItemEntityArray

WSSTRUCT MagentoService_salesOrderInvoiceItemEntityArray
	WSDATA   oWSsalesOrderInvoiceItemEntity AS MagentoService_salesOrderInvoiceItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderInvoiceItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderInvoiceItemEntityArray
	::oWSsalesOrderInvoiceItemEntity := {} // Array Of  MagentoService_SALESORDERINVOICEITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderInvoiceItemEntityArray
	Local oClone := MagentoService_salesOrderInvoiceItemEntityArray():NEW()
	oClone:oWSsalesOrderInvoiceItemEntity := NIL
	If ::oWSsalesOrderInvoiceItemEntity <> NIL
		oClone:oWSsalesOrderInvoiceItemEntity := {}
		aEval( ::oWSsalesOrderInvoiceItemEntity , { |x| aadd( oClone:oWSsalesOrderInvoiceItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderInvoiceItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderInvoiceItemEntity , MagentoService_salesOrderInvoiceItemEntity():New() )
			::oWSsalesOrderInvoiceItemEntity[len(::oWSsalesOrderInvoiceItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderInvoiceCommentEntityArray

WSSTRUCT MagentoService_salesOrderInvoiceCommentEntityArray
	WSDATA   oWSsalesOrderInvoiceCommentEntity AS MagentoService_salesOrderInvoiceCommentEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderInvoiceCommentEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderInvoiceCommentEntityArray
	::oWSsalesOrderInvoiceCommentEntity := {} // Array Of  MagentoService_SALESORDERINVOICECOMMENTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderInvoiceCommentEntityArray
	Local oClone := MagentoService_salesOrderInvoiceCommentEntityArray():NEW()
	oClone:oWSsalesOrderInvoiceCommentEntity := NIL
	If ::oWSsalesOrderInvoiceCommentEntity <> NIL
		oClone:oWSsalesOrderInvoiceCommentEntity := {}
		aEval( ::oWSsalesOrderInvoiceCommentEntity , { |x| aadd( oClone:oWSsalesOrderInvoiceCommentEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderInvoiceCommentEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderInvoiceCommentEntity , MagentoService_salesOrderInvoiceCommentEntity():New() )
			::oWSsalesOrderInvoiceCommentEntity[len(::oWSsalesOrderInvoiceCommentEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderCreditmemoItemEntityArray

WSSTRUCT MagentoService_salesOrderCreditmemoItemEntityArray
	WSDATA   oWSsalesOrderCreditmemoItemEntity AS MagentoService_salesOrderCreditmemoItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoItemEntityArray
	::oWSsalesOrderCreditmemoItemEntity := {} // Array Of  MagentoService_SALESORDERCREDITMEMOITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoItemEntityArray
	Local oClone := MagentoService_salesOrderCreditmemoItemEntityArray():NEW()
	oClone:oWSsalesOrderCreditmemoItemEntity := NIL
	If ::oWSsalesOrderCreditmemoItemEntity <> NIL
		oClone:oWSsalesOrderCreditmemoItemEntity := {}
		aEval( ::oWSsalesOrderCreditmemoItemEntity , { |x| aadd( oClone:oWSsalesOrderCreditmemoItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderCreditmemoItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderCreditmemoItemEntity , MagentoService_salesOrderCreditmemoItemEntity():New() )
			::oWSsalesOrderCreditmemoItemEntity[len(::oWSsalesOrderCreditmemoItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure salesOrderCreditmemoCommentEntityArray

WSSTRUCT MagentoService_salesOrderCreditmemoCommentEntityArray
	WSDATA   oWSsalesOrderCreditmemoCommentEntity AS MagentoService_salesOrderCreditmemoCommentEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoCommentEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoCommentEntityArray
	::oWSsalesOrderCreditmemoCommentEntity := {} // Array Of  MagentoService_SALESORDERCREDITMEMOCOMMENTENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoCommentEntityArray
	Local oClone := MagentoService_salesOrderCreditmemoCommentEntityArray():NEW()
	oClone:oWSsalesOrderCreditmemoCommentEntity := NIL
	If ::oWSsalesOrderCreditmemoCommentEntity <> NIL
		oClone:oWSsalesOrderCreditmemoCommentEntity := {}
		aEval( ::oWSsalesOrderCreditmemoCommentEntity , { |x| aadd( oClone:oWSsalesOrderCreditmemoCommentEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderCreditmemoCommentEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSsalesOrderCreditmemoCommentEntity , MagentoService_salesOrderCreditmemoCommentEntity():New() )
			::oWSsalesOrderCreditmemoCommentEntity[len(::oWSsalesOrderCreditmemoCommentEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartAddressEntity

WSSTRUCT MagentoService_shoppingCartAddressEntity
	WSDATA   caddress_id               AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   ccustomer_id              AS string OPTIONAL
	WSDATA   nsave_in_address_book     AS int OPTIONAL
	WSDATA   ccustomer_address_id      AS string OPTIONAL
	WSDATA   caddress_type             AS string OPTIONAL
	WSDATA   cemail                    AS string OPTIONAL
	WSDATA   cprefix                   AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   cmiddlename               AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   csuffix                   AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   cstreet                   AS string OPTIONAL
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   cregion_id                AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   nsame_as_billing          AS int OPTIONAL
	WSDATA   nfree_shipping            AS int OPTIONAL
	WSDATA   cshipping_method          AS string OPTIONAL
	WSDATA   cshipping_description     AS string OPTIONAL
	WSDATA   nweight                   AS double OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartAddressEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartAddressEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartAddressEntity
	Local oClone := MagentoService_shoppingCartAddressEntity():NEW()
	oClone:caddress_id          := ::caddress_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:ccustomer_id         := ::ccustomer_id
	oClone:nsave_in_address_book := ::nsave_in_address_book
	oClone:ccustomer_address_id := ::ccustomer_address_id
	oClone:caddress_type        := ::caddress_type
	oClone:cemail               := ::cemail
	oClone:cprefix              := ::cprefix
	oClone:cfirstname           := ::cfirstname
	oClone:cmiddlename          := ::cmiddlename
	oClone:clastname            := ::clastname
	oClone:csuffix              := ::csuffix
	oClone:ccompany             := ::ccompany
	oClone:cstreet              := ::cstreet
	oClone:ccity                := ::ccity
	oClone:cregion              := ::cregion
	oClone:cregion_id           := ::cregion_id
	oClone:cpostcode            := ::cpostcode
	oClone:ccountry_id          := ::ccountry_id
	oClone:ctelephone           := ::ctelephone
	oClone:cfax                 := ::cfax
	oClone:nsame_as_billing     := ::nsame_as_billing
	oClone:nfree_shipping       := ::nfree_shipping
	oClone:cshipping_method     := ::cshipping_method
	oClone:cshipping_description := ::cshipping_description
	oClone:nweight              := ::nweight
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartAddressEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::caddress_id        :=  WSAdvValue( oResponse,"_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccustomer_id       :=  WSAdvValue( oResponse,"_CUSTOMER_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nsave_in_address_book :=  WSAdvValue( oResponse,"_SAVE_IN_ADDRESS_BOOK","int",NIL,NIL,NIL,"N",NIL,NIL)
	::ccustomer_address_id :=  WSAdvValue( oResponse,"_CUSTOMER_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caddress_type      :=  WSAdvValue( oResponse,"_ADDRESS_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cemail             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprefix            :=  WSAdvValue( oResponse,"_PREFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfirstname         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmiddlename        :=  WSAdvValue( oResponse,"_MIDDLENAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clastname          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csuffix            :=  WSAdvValue( oResponse,"_SUFFIX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccompany           :=  WSAdvValue( oResponse,"_COMPANY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion            :=  WSAdvValue( oResponse,"_REGION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion_id         :=  WSAdvValue( oResponse,"_REGION_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpostcode          :=  WSAdvValue( oResponse,"_POSTCODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccountry_id        :=  WSAdvValue( oResponse,"_COUNTRY_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctelephone         :=  WSAdvValue( oResponse,"_TELEPHONE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfax               :=  WSAdvValue( oResponse,"_FAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nsame_as_billing   :=  WSAdvValue( oResponse,"_SAME_AS_BILLING","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nfree_shipping     :=  WSAdvValue( oResponse,"_FREE_SHIPPING","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cshipping_method   :=  WSAdvValue( oResponse,"_SHIPPING_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cshipping_description :=  WSAdvValue( oResponse,"_SHIPPING_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nweight            :=  WSAdvValue( oResponse,"_WEIGHT","double",NIL,NIL,NIL,"N",NIL,NIL)
Return

// WSDL Data Structure shoppingCartItemEntityArray

WSSTRUCT MagentoService_shoppingCartItemEntityArray
	WSDATA   oWSshoppingCartItemEntity AS MagentoService_shoppingCartItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartItemEntityArray
	::oWSshoppingCartItemEntity := {} // Array Of  MagentoService_SHOPPINGCARTITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartItemEntityArray
	Local oClone := MagentoService_shoppingCartItemEntityArray():NEW()
	oClone:oWSshoppingCartItemEntity := NIL
	If ::oWSshoppingCartItemEntity <> NIL
		oClone:oWSshoppingCartItemEntity := {}
		aEval( ::oWSshoppingCartItemEntity , { |x| aadd( oClone:oWSshoppingCartItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartItemEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSshoppingCartItemEntity , MagentoService_shoppingCartItemEntity():New() )
			::oWSshoppingCartItemEntity[len(::oWSshoppingCartItemEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure shoppingCartPaymentEntity

WSSTRUCT MagentoService_shoppingCartPaymentEntity
	WSDATA   cpayment_id               AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cmethod                   AS string OPTIONAL
	WSDATA   ccc_type                  AS string OPTIONAL
	WSDATA   ccc_number_enc            AS string OPTIONAL
	WSDATA   ccc_last4                 AS string OPTIONAL
	WSDATA   ccc_cid_enc               AS string OPTIONAL
	WSDATA   ccc_owner                 AS string OPTIONAL
	WSDATA   ccc_exp_month             AS string OPTIONAL
	WSDATA   ccc_exp_year              AS string OPTIONAL
	WSDATA   ccc_ss_owner              AS string OPTIONAL
	WSDATA   ccc_ss_start_month        AS string OPTIONAL
	WSDATA   ccc_ss_start_year         AS string OPTIONAL
	WSDATA   ccc_ss_issue              AS string OPTIONAL
	WSDATA   cpo_number                AS string OPTIONAL
	WSDATA   cadditional_data          AS string OPTIONAL
	WSDATA   cadditional_information   AS string OPTIONAL
	WSDATA   ccc_trans_id   		   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartPaymentEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartPaymentEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartPaymentEntity
	Local oClone := MagentoService_shoppingCartPaymentEntity():NEW()
	oClone:cpayment_id          := ::cpayment_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cmethod              := ::cmethod
	oClone:ccc_type             := ::ccc_type
	oClone:ccc_number_enc       := ::ccc_number_enc
	oClone:ccc_last4            := ::ccc_last4
	oClone:ccc_cid_enc          := ::ccc_cid_enc
	oClone:ccc_owner            := ::ccc_owner
	oClone:ccc_exp_month        := ::ccc_exp_month
	oClone:ccc_exp_year         := ::ccc_exp_year
	oClone:ccc_ss_owner         := ::ccc_ss_owner
	oClone:ccc_ss_start_month   := ::ccc_ss_start_month
	oClone:ccc_ss_start_year    := ::ccc_ss_start_year
	oClone:ccc_ss_issue         := ::ccc_ss_issue
	oClone:cpo_number              := ::cpo_number
	oClone:cadditional_data    	   := ::cadditional_data
	oClone:cadditional_information := ::cadditional_information
	oClone:ccc_trans_id		  	   := ::ccc_trans_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartPaymentEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cpayment_id        :=  WSAdvValue( oResponse,"_PAYMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmethod            :=  WSAdvValue( oResponse,"_METHOD","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_type           :=  WSAdvValue( oResponse,"_CC_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_number_enc     :=  WSAdvValue( oResponse,"_CC_NUMBER_ENC","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_last4          :=  WSAdvValue( oResponse,"_CC_LAST4","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_cid_enc        :=  WSAdvValue( oResponse,"_CC_CID_ENC","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_owner          :=  WSAdvValue( oResponse,"_CC_OWNER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_exp_month      :=  WSAdvValue( oResponse,"_CC_EXP_MONTH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_exp_year       :=  WSAdvValue( oResponse,"_CC_EXP_YEAR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_ss_owner       :=  WSAdvValue( oResponse,"_CC_SS_OWNER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_ss_start_month :=  WSAdvValue( oResponse,"_CC_SS_START_MONTH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_ss_start_year  :=  WSAdvValue( oResponse,"_CC_SS_START_YEAR","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_ss_issue       :=  WSAdvValue( oResponse,"_CC_SS_ISSUE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpo_number         :=  WSAdvValue( oResponse,"_PO_NUMBER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadditional_data   :=  WSAdvValue( oResponse,"_ADDITIONAL_DATA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadditional_information :=  WSAdvValue( oResponse,"_ADDITIONAL_INFORMATION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccc_trans_id :=  WSAdvValue( oResponse,"_CC_TRANS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)

Return

// WSDL Data Structure catalogProductDownloadableLinkFileEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkFileEntity
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   cbase64_content           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkFileEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkFileEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkFileEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkFileEntity():NEW()
	oClone:cname                := ::cname
	oClone:cbase64_content      := ::cbase64_content
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductDownloadableLinkFileEntity
	Local cSoap := ""
	cSoap += WSSoapValue("name", ::cname, ::cname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("base64_content", ::cbase64_content, ::cbase64_content , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductDownloadableLinkEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkEntity
	WSDATA   clink_id                  AS string OPTIONAL
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   nnumber_of_downloads      AS int OPTIONAL
	WSDATA   nis_unlimited             AS int OPTIONAL
	WSDATA   nis_shareable             AS int OPTIONAL
	WSDATA   clink_url                 AS string OPTIONAL
	WSDATA   clink_type                AS string OPTIONAL
	WSDATA   csample_file              AS string OPTIONAL
	WSDATA   csample_url               AS string OPTIONAL
	WSDATA   csample_type              AS string OPTIONAL
	WSDATA   nsort_order               AS int OPTIONAL
	WSDATA   oWSfile_save              AS MagentoService_catalogProductDownloadableLinkFileInfoEntityArray OPTIONAL
	WSDATA   oWSsample_file_save       AS MagentoService_catalogProductDownloadableLinkFileInfoEntityArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkEntity():NEW()
	oClone:clink_id             := ::clink_id
	oClone:ctitle               := ::ctitle
	oClone:cprice               := ::cprice
	oClone:nnumber_of_downloads := ::nnumber_of_downloads
	oClone:nis_unlimited        := ::nis_unlimited
	oClone:nis_shareable        := ::nis_shareable
	oClone:clink_url            := ::clink_url
	oClone:clink_type           := ::clink_type
	oClone:csample_file         := ::csample_file
	oClone:csample_url          := ::csample_url
	oClone:csample_type         := ::csample_type
	oClone:nsort_order          := ::nsort_order
	oClone:oWSfile_save         := IIF(::oWSfile_save = NIL , NIL , ::oWSfile_save:Clone() )
	oClone:oWSsample_file_save  := IIF(::oWSsample_file_save = NIL , NIL , ::oWSsample_file_save:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkEntity
	Local oNode13
	Local oNode14
	::Init()
	If oResponse = NIL ; Return ; Endif
	::clink_id           :=  WSAdvValue( oResponse,"_LINK_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nnumber_of_downloads :=  WSAdvValue( oResponse,"_NUMBER_OF_DOWNLOADS","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_unlimited      :=  WSAdvValue( oResponse,"_IS_UNLIMITED","int",NIL,NIL,NIL,"N",NIL,NIL)
	::nis_shareable      :=  WSAdvValue( oResponse,"_IS_SHAREABLE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::clink_url          :=  WSAdvValue( oResponse,"_LINK_URL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clink_type         :=  WSAdvValue( oResponse,"_LINK_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csample_file       :=  WSAdvValue( oResponse,"_SAMPLE_FILE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csample_url        :=  WSAdvValue( oResponse,"_SAMPLE_URL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csample_type       :=  WSAdvValue( oResponse,"_SAMPLE_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nsort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","int",NIL,NIL,NIL,"N",NIL,NIL)
	oNode13 :=  WSAdvValue( oResponse,"_FILE_SAVE","catalogProductDownloadableLinkFileInfoEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode13 != NIL
		::oWSfile_save := MagentoService_catalogProductDownloadableLinkFileInfoEntityArray():New()
		::oWSfile_save:SoapRecv(oNode13)
	EndIf
	oNode14 :=  WSAdvValue( oResponse,"_SAMPLE_FILE_SAVE","catalogProductDownloadableLinkFileInfoEntityArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode14 != NIL
		::oWSsample_file_save := MagentoService_catalogProductDownloadableLinkFileInfoEntityArray():New()
		::oWSsample_file_save:SoapRecv(oNode14)
	EndIf
Return

// WSDL Data Structure catalogProductDownloadableLinkSampleEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkSampleEntity
	WSDATA   csample_id                AS string OPTIONAL
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   csample_file              AS string OPTIONAL
	WSDATA   csample_url               AS string OPTIONAL
	WSDATA   csample_type              AS string OPTIONAL
	WSDATA   csort_order               AS string OPTIONAL
	WSDATA   cdefault_title            AS string OPTIONAL
	WSDATA   cstore_title              AS string OPTIONAL
	WSDATA   ctitle                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkSampleEntity():NEW()
	oClone:csample_id           := ::csample_id
	oClone:cproduct_id          := ::cproduct_id
	oClone:csample_file         := ::csample_file
	oClone:csample_url          := ::csample_url
	oClone:csample_type         := ::csample_type
	oClone:csort_order          := ::csort_order
	oClone:cdefault_title       := ::cdefault_title
	oClone:cstore_title         := ::cstore_title
	oClone:ctitle               := ::ctitle
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkSampleEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::csample_id         :=  WSAdvValue( oResponse,"_SAMPLE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csample_file       :=  WSAdvValue( oResponse,"_SAMPLE_FILE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csample_url        :=  WSAdvValue( oResponse,"_SAMPLE_URL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csample_type       :=  WSAdvValue( oResponse,"_SAMPLE_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdefault_title     :=  WSAdvValue( oResponse,"_DEFAULT_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_title       :=  WSAdvValue( oResponse,"_STORE_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorOrderAddressEntity

WSSTRUCT MagentoService_integratorOrderAddressEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   caddress_type             AS string OPTIONAL
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   cstreet                   AS string OPTIONAL
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   cregion_id                AS string OPTIONAL
	WSDATA   caddress_id               AS string OPTIONAL
	WSDATA   cvat_number               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorOrderAddressEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorOrderAddressEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorOrderAddressEntity
	Local oClone := MagentoService_integratorOrderAddressEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:caddress_type        := ::caddress_type
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:ccompany             := ::ccompany
	oClone:cstreet              := ::cstreet
	oClone:ccity                := ::ccity
	oClone:cregion              := ::cregion
	oClone:cpostcode            := ::cpostcode
	oClone:ccountry_id          := ::ccountry_id
	oClone:ctelephone           := ::ctelephone
	oClone:cfax                 := ::cfax
	oClone:cregion_id           := ::cregion_id
	oClone:caddress_id          := ::caddress_id
	oClone:cvat_number          := ::cvat_number
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorOrderAddressEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caddress_type      :=  WSAdvValue( oResponse,"_ADDRESS_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfirstname         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::clastname          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccompany           :=  WSAdvValue( oResponse,"_COMPANY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion            :=  WSAdvValue( oResponse,"_REGION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpostcode          :=  WSAdvValue( oResponse,"_POSTCODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccountry_id        :=  WSAdvValue( oResponse,"_COUNTRY_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctelephone         :=  WSAdvValue( oResponse,"_TELEPHONE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfax               :=  WSAdvValue( oResponse,"_FAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cregion_id         :=  WSAdvValue( oResponse,"_REGION_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::caddress_id        :=  WSAdvValue( oResponse,"_ADDRESS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cvat_number        :=  WSAdvValue( oResponse,"_VAT_NUMBER","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorCreateOrderAddressEntity

WSSTRUCT MagentoService_integratorCreateOrderAddressEntity
	WSDATA   cfirstname                AS string OPTIONAL
	WSDATA   clastname                 AS string OPTIONAL
	WSDATA   ccompany                  AS string OPTIONAL
	WSDATA   cstreet                   AS string OPTIONAL
	WSDATA   cneighborhood             AS string OPTIONAL
	WSDATA   cnumber                   AS string OPTIONAL
	WSDATA   ccomplement               AS string OPTIONAL
	WSDATA   ccity                     AS string OPTIONAL
	WSDATA   cregion                   AS string OPTIONAL
	WSDATA   cpostcode                 AS string OPTIONAL
	WSDATA   ccountry_id               AS string OPTIONAL
	WSDATA   ctelephone                AS string OPTIONAL
	WSDATA   csecondary_phone          AS string OPTIONAL
	WSDATA   cfax                      AS string OPTIONAL
	WSDATA   cvat_number               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorCreateOrderAddressEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorCreateOrderAddressEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorCreateOrderAddressEntity
	Local oClone := MagentoService_integratorCreateOrderAddressEntity():NEW()
	oClone:cfirstname           := ::cfirstname
	oClone:clastname            := ::clastname
	oClone:ccompany             := ::ccompany
	oClone:cstreet              := ::cstreet
	oClone:cneighborhood        := ::cneighborhood
	oClone:cnumber              := ::cnumber
	oClone:ccomplement          := ::ccomplement
	oClone:ccity                := ::ccity
	oClone:cregion              := ::cregion
	oClone:cpostcode            := ::cpostcode
	oClone:ccountry_id          := ::ccountry_id
	oClone:ctelephone           := ::ctelephone
	oClone:csecondary_phone     := ::csecondary_phone
	oClone:cfax                 := ::cfax
	oClone:cvat_number          := ::cvat_number
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorCreateOrderAddressEntity
	Local cSoap := ""
	cSoap += WSSoapValue("firstname", ::cfirstname, ::cfirstname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("lastname", ::clastname, ::clastname , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("company", ::ccompany, ::ccompany , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("street", ::cstreet, ::cstreet , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("neighborhood", ::cneighborhood, ::cneighborhood , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("number", ::cnumber, ::cnumber , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("complement", ::ccomplement, ::ccomplement , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("city", ::ccity, ::ccity , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("region", ::cregion, ::cregion , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("postcode", ::cpostcode, ::cpostcode , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("country_id", ::ccountry_id, ::ccountry_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("telephone", ::ctelephone, ::ctelephone , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("secondary_phone", ::csecondary_phone, ::csecondary_phone , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("fax", ::cfax, ::cfax , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("vat_number", ::cvat_number, ::cvat_number , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure integratorCreateOrderItemEntityArray

WSSTRUCT MagentoService_integratorCreateOrderItemEntityArray
	WSDATA   oWSintegratorCreateOrderItemEntity AS MagentoService_integratorCreateOrderItemEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorCreateOrderItemEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorCreateOrderItemEntityArray
	::oWSintegratorCreateOrderItemEntity := {} // Array Of  MagentoService_INTEGRATORCREATEORDERITEMENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorCreateOrderItemEntityArray
	Local oClone := MagentoService_integratorCreateOrderItemEntityArray():NEW()
	oClone:oWSintegratorCreateOrderItemEntity := NIL
	If ::oWSintegratorCreateOrderItemEntity <> NIL
		oClone:oWSintegratorCreateOrderItemEntity := {}
		aEval( ::oWSintegratorCreateOrderItemEntity , { |x| aadd( oClone:oWSintegratorCreateOrderItemEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorCreateOrderItemEntityArray
	Local cSoap := ""
	aEval( ::oWSintegratorCreateOrderItemEntity , {|x| cSoap := cSoap  +  WSSoapValue("integratorCreateOrderItemEntity", x , x , "integratorCreateOrderItemEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure integratorConfigurableAttributeArray

WSSTRUCT MagentoService_integratorConfigurableAttributeArray
	WSDATA   oWSintegratorConfigurableAttribute AS MagentoService_integratorConfigurableAttribute OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorConfigurableAttributeArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorConfigurableAttributeArray
	::oWSintegratorConfigurableAttribute := {} // Array Of  MagentoService_INTEGRATORCONFIGURABLEATTRIBUTE():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorConfigurableAttributeArray
	Local oClone := MagentoService_integratorConfigurableAttributeArray():NEW()
	oClone:oWSintegratorConfigurableAttribute := NIL
	If ::oWSintegratorConfigurableAttribute <> NIL
		oClone:oWSintegratorConfigurableAttribute := {}
		aEval( ::oWSintegratorConfigurableAttribute , { |x| aadd( oClone:oWSintegratorConfigurableAttribute , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorConfigurableAttributeArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorConfigurableAttribute , MagentoService_integratorConfigurableAttribute():New() )
			::oWSintegratorConfigurableAttribute[len(::oWSintegratorConfigurableAttribute)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorConfigurableProductVariationArray

WSSTRUCT MagentoService_integratorConfigurableProductVariationArray
	WSDATA   oWSintegratorConfigurableProductVariation AS MagentoService_integratorConfigurableProductVariation OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorConfigurableProductVariationArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorConfigurableProductVariationArray
	::oWSintegratorConfigurableProductVariation := {} // Array Of  MagentoService_INTEGRATORCONFIGURABLEPRODUCTVARIATION():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorConfigurableProductVariationArray
	Local oClone := MagentoService_integratorConfigurableProductVariationArray():NEW()
	oClone:oWSintegratorConfigurableProductVariation := NIL
	If ::oWSintegratorConfigurableProductVariation <> NIL
		oClone:oWSintegratorConfigurableProductVariation := {}
		aEval( ::oWSintegratorConfigurableProductVariation , { |x| aadd( oClone:oWSintegratorConfigurableProductVariation , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorConfigurableProductVariationArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorConfigurableProductVariation , MagentoService_integratorConfigurableProductVariation():New() )
			::oWSintegratorConfigurableProductVariation[len(::oWSintegratorConfigurableProductVariation)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorBundleProductComponentsArray

WSSTRUCT MagentoService_integratorBundleProductComponentsArray
	WSDATA   oWSintegratorBundleProductComponent AS MagentoService_integratorBundleProductComponent OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorBundleProductComponentsArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorBundleProductComponentsArray
	::oWSintegratorBundleProductComponent := {} // Array Of  MagentoService_INTEGRATORBUNDLEPRODUCTCOMPONENT():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorBundleProductComponentsArray
	Local oClone := MagentoService_integratorBundleProductComponentsArray():NEW()
	oClone:oWSintegratorBundleProductComponent := NIL
	If ::oWSintegratorBundleProductComponent <> NIL
		oClone:oWSintegratorBundleProductComponent := {}
		aEval( ::oWSintegratorBundleProductComponent , { |x| aadd( oClone:oWSintegratorBundleProductComponent , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorBundleProductComponentsArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWSintegratorBundleProductComponent , MagentoService_integratorBundleProductComponent():New() )
			::oWSintegratorBundleProductComponent[len(::oWSintegratorBundleProductComponent)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure apiMethodEntity

WSSTRUCT MagentoService_apiMethodEntity
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   cpath                     AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   oWSaliases                AS MagentoService_ArrayOfString OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_apiMethodEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_apiMethodEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_apiMethodEntity
	Local oClone := MagentoService_apiMethodEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:cpath                := ::cpath
	oClone:cname                := ::cname
	oClone:oWSaliases           := IIF(::oWSaliases = NIL , NIL , ::oWSaliases:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_apiMethodEntity
	Local oNode4
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cpath              :=  WSAdvValue( oResponse,"_PATH","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode4 :=  WSAdvValue( oResponse,"_ALIASES","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSaliases := MagentoService_ArrayOfString():New()
		::oWSaliases:SoapRecv(oNode4)
	EndIf
Return

// WSDL Data Structure associativeMultiArray

WSSTRUCT MagentoService_associativeMultiArray
	WSDATA   oWSassociativeMultiEntity AS MagentoService_associativeMultiEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_associativeMultiArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_associativeMultiArray
	::oWSassociativeMultiEntity := {} // Array Of  MagentoService_ASSOCIATIVEMULTIENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_associativeMultiArray
	Local oClone := MagentoService_associativeMultiArray():NEW()
	oClone:oWSassociativeMultiEntity := NIL
	If ::oWSassociativeMultiEntity <> NIL
		oClone:oWSassociativeMultiEntity := {}
		aEval( ::oWSassociativeMultiEntity , { |x| aadd( oClone:oWSassociativeMultiEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_associativeMultiArray
	Local cSoap := ""
	aEval( ::oWSassociativeMultiEntity , {|x| cSoap := cSoap  +  WSSoapValue("associativeMultiEntity", x , x , "associativeMultiEntity", .F. , .T., 0 , NIL, .F.,.F.)  } )
Return cSoap

// WSDL Data Structure catalogProductCustomOptionAdditionalFieldsEntity

WSSTRUCT MagentoService_catalogProductCustomOptionAdditionalFieldsEntity
	WSDATA   ctitle                    AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cprice_type               AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cmax_characters           AS string OPTIONAL
	WSDATA   csort_order               AS string OPTIONAL
	WSDATA   cfile_extension           AS string OPTIONAL
	WSDATA   cimage_size_x             AS string OPTIONAL
	WSDATA   cimage_size_y             AS string OPTIONAL
	WSDATA   cvalue_id                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsEntity
	Local oClone := MagentoService_catalogProductCustomOptionAdditionalFieldsEntity():NEW()
	oClone:ctitle               := ::ctitle
	oClone:cprice               := ::cprice
	oClone:cprice_type          := ::cprice_type
	oClone:csku                 := ::csku
	oClone:cmax_characters      := ::cmax_characters
	oClone:csort_order          := ::csort_order
	oClone:cfile_extension      := ::cfile_extension
	oClone:cimage_size_x        := ::cimage_size_x
	oClone:cimage_size_y        := ::cimage_size_y
	oClone:cvalue_id            := ::cvalue_id
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsEntity
	Local cSoap := ""
	cSoap += WSSoapValue("title", ::ctitle, ::ctitle , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price", ::cprice, ::cprice , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("price_type", ::cprice_type, ::cprice_type , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("max_characters", ::cmax_characters, ::cmax_characters , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("sort_order", ::csort_order, ::csort_order , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("file_extension", ::cfile_extension, ::cfile_extension , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("image_size_x", ::cimage_size_x, ::cimage_size_x , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("image_size_y", ::cimage_size_y, ::cimage_size_y , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("value_id", ::cvalue_id, ::cvalue_id , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductCustomOptionAdditionalFieldsEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::ctitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice_type        :=  WSAdvValue( oResponse,"_PRICE_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cmax_characters    :=  WSAdvValue( oResponse,"_MAX_CHARACTERS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csort_order        :=  WSAdvValue( oResponse,"_SORT_ORDER","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfile_extension    :=  WSAdvValue( oResponse,"_FILE_EXTENSION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cimage_size_x      :=  WSAdvValue( oResponse,"_IMAGE_SIZE_X","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cimage_size_y      :=  WSAdvValue( oResponse,"_IMAGE_SIZE_Y","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cvalue_id          :=  WSAdvValue( oResponse,"_VALUE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderShipmentItemEntity

WSSTRUCT MagentoService_salesOrderShipmentItemEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   corder_item_id            AS string OPTIONAL
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSDATA   citem_id                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderShipmentItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderShipmentItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderShipmentItemEntity
	Local oClone := MagentoService_salesOrderShipmentItemEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:csku                 := ::csku
	oClone:cname                := ::cname
	oClone:corder_item_id       := ::corder_item_id
	oClone:cproduct_id          := ::cproduct_id
	oClone:cweight              := ::cweight
	oClone:cprice               := ::cprice
	oClone:cqty                 := ::cqty
	oClone:citem_id             := ::citem_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderShipmentItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_item_id     :=  WSAdvValue( oResponse,"_ORDER_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty               :=  WSAdvValue( oResponse,"_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::citem_id           :=  WSAdvValue( oResponse,"_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderInvoiceItemEntity

WSSTRUCT MagentoService_salesOrderInvoiceItemEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   cweee_tax_applied         AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSDATA   ccost                     AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   crow_total                AS string OPTIONAL
	WSDATA   cbase_price               AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cbase_row_total           AS string OPTIONAL
	WSDATA   cbase_weee_tax_applied_amount AS string OPTIONAL
	WSDATA   cbase_weee_tax_applied_row_amount AS string OPTIONAL
	WSDATA   cweee_tax_applied_amount  AS string OPTIONAL
	WSDATA   cweee_tax_applied_row_amount AS string OPTIONAL
	WSDATA   cweee_tax_disposition     AS string OPTIONAL
	WSDATA   cweee_tax_row_disposition AS string OPTIONAL
	WSDATA   cbase_weee_tax_disposition AS string OPTIONAL
	WSDATA   cbase_weee_tax_row_disposition AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   corder_item_id            AS string OPTIONAL
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   citem_id                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderInvoiceItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderInvoiceItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderInvoiceItemEntity
	Local oClone := MagentoService_salesOrderInvoiceItemEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:cweee_tax_applied    := ::cweee_tax_applied
	oClone:cqty                 := ::cqty
	oClone:ccost                := ::ccost
	oClone:cprice               := ::cprice
	oClone:ctax_amount          := ::ctax_amount
	oClone:crow_total           := ::crow_total
	oClone:cbase_price          := ::cbase_price
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cbase_row_total      := ::cbase_row_total
	oClone:cbase_weee_tax_applied_amount := ::cbase_weee_tax_applied_amount
	oClone:cbase_weee_tax_applied_row_amount := ::cbase_weee_tax_applied_row_amount
	oClone:cweee_tax_applied_amount := ::cweee_tax_applied_amount
	oClone:cweee_tax_applied_row_amount := ::cweee_tax_applied_row_amount
	oClone:cweee_tax_disposition := ::cweee_tax_disposition
	oClone:cweee_tax_row_disposition := ::cweee_tax_row_disposition
	oClone:cbase_weee_tax_disposition := ::cbase_weee_tax_disposition
	oClone:cbase_weee_tax_row_disposition := ::cbase_weee_tax_row_disposition
	oClone:csku                 := ::csku
	oClone:cname                := ::cname
	oClone:corder_item_id       := ::corder_item_id
	oClone:cproduct_id          := ::cproduct_id
	oClone:citem_id             := ::citem_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderInvoiceItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied  :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty               :=  WSAdvValue( oResponse,"_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccost              :=  WSAdvValue( oResponse,"_COST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crow_total         :=  WSAdvValue( oResponse,"_ROW_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_price        :=  WSAdvValue( oResponse,"_BASE_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_row_total    :=  WSAdvValue( oResponse,"_BASE_ROW_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_applied_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_ROW_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_ROW_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_row_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_ROW_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_row_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_ROW_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_item_id     :=  WSAdvValue( oResponse,"_ORDER_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::citem_id           :=  WSAdvValue( oResponse,"_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderInvoiceCommentEntity

WSSTRUCT MagentoService_salesOrderInvoiceCommentEntity
	WSDATA   cincrement_id             AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cis_active                AS string OPTIONAL
	WSDATA   ccomment                  AS string OPTIONAL
	WSDATA   cis_customer_notified     AS string OPTIONAL
	WSDATA   ccomment_id               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderInvoiceCommentEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderInvoiceCommentEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderInvoiceCommentEntity
	Local oClone := MagentoService_salesOrderInvoiceCommentEntity():NEW()
	oClone:cincrement_id        := ::cincrement_id
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cis_active           := ::cis_active
	oClone:ccomment             := ::ccomment
	oClone:cis_customer_notified := ::cis_customer_notified
	oClone:ccomment_id          := ::ccomment_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderInvoiceCommentEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cincrement_id      :=  WSAdvValue( oResponse,"_INCREMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_active         :=  WSAdvValue( oResponse,"_IS_ACTIVE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment           :=  WSAdvValue( oResponse,"_COMMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_customer_notified :=  WSAdvValue( oResponse,"_IS_CUSTOMER_NOTIFIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment_id        :=  WSAdvValue( oResponse,"_COMMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderCreditmemoItemEntity

WSSTRUCT MagentoService_salesOrderCreditmemoItemEntity
	WSDATA   citem_id                  AS string OPTIONAL
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   cweee_tax_applied_row_amount AS string OPTIONAL
	WSDATA   cbase_price               AS string OPTIONAL
	WSDATA   cbase_weee_tax_row_disposition AS string OPTIONAL
	WSDATA   ctax_amount               AS string OPTIONAL
	WSDATA   cbase_weee_tax_applied_amount AS string OPTIONAL
	WSDATA   cweee_tax_row_disposition AS string OPTIONAL
	WSDATA   cbase_row_total           AS string OPTIONAL
	WSDATA   cdiscount_amount          AS string OPTIONAL
	WSDATA   crow_total                AS string OPTIONAL
	WSDATA   cweee_tax_applied_amount  AS string OPTIONAL
	WSDATA   cbase_discount_amount     AS string OPTIONAL
	WSDATA   cbase_weee_tax_disposition AS string OPTIONAL
	WSDATA   cprice_incl_tax           AS string OPTIONAL
	WSDATA   cbase_tax_amount          AS string OPTIONAL
	WSDATA   cweee_tax_disposition     AS string OPTIONAL
	WSDATA   cbase_price_incl_tax      AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSDATA   cbase_cost                AS string OPTIONAL
	WSDATA   cbase_weee_tax_applied_row_amount AS string OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cbase_row_total_incl_tax  AS string OPTIONAL
	WSDATA   crow_total_incl_tax       AS string OPTIONAL
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   corder_item_id            AS string OPTIONAL
	WSDATA   cadditional_data          AS string OPTIONAL
	WSDATA   cdescription              AS string OPTIONAL
	WSDATA   cweee_tax_applied         AS string OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   chidden_tax_amount        AS string OPTIONAL
	WSDATA   cbase_hidden_tax_amount   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoItemEntity
	Local oClone := MagentoService_salesOrderCreditmemoItemEntity():NEW()
	oClone:citem_id             := ::citem_id
	oClone:cparent_id           := ::cparent_id
	oClone:cweee_tax_applied_row_amount := ::cweee_tax_applied_row_amount
	oClone:cbase_price          := ::cbase_price
	oClone:cbase_weee_tax_row_disposition := ::cbase_weee_tax_row_disposition
	oClone:ctax_amount          := ::ctax_amount
	oClone:cbase_weee_tax_applied_amount := ::cbase_weee_tax_applied_amount
	oClone:cweee_tax_row_disposition := ::cweee_tax_row_disposition
	oClone:cbase_row_total      := ::cbase_row_total
	oClone:cdiscount_amount     := ::cdiscount_amount
	oClone:crow_total           := ::crow_total
	oClone:cweee_tax_applied_amount := ::cweee_tax_applied_amount
	oClone:cbase_discount_amount := ::cbase_discount_amount
	oClone:cbase_weee_tax_disposition := ::cbase_weee_tax_disposition
	oClone:cprice_incl_tax      := ::cprice_incl_tax
	oClone:cbase_tax_amount     := ::cbase_tax_amount
	oClone:cweee_tax_disposition := ::cweee_tax_disposition
	oClone:cbase_price_incl_tax := ::cbase_price_incl_tax
	oClone:cqty                 := ::cqty
	oClone:cbase_cost           := ::cbase_cost
	oClone:cbase_weee_tax_applied_row_amount := ::cbase_weee_tax_applied_row_amount
	oClone:cprice               := ::cprice
	oClone:cbase_row_total_incl_tax := ::cbase_row_total_incl_tax
	oClone:crow_total_incl_tax  := ::crow_total_incl_tax
	oClone:cproduct_id          := ::cproduct_id
	oClone:corder_item_id       := ::corder_item_id
	oClone:cadditional_data     := ::cadditional_data
	oClone:cdescription         := ::cdescription
	oClone:cweee_tax_applied    := ::cweee_tax_applied
	oClone:csku                 := ::csku
	oClone:cname                := ::cname
	oClone:chidden_tax_amount   := ::chidden_tax_amount
	oClone:cbase_hidden_tax_amount := ::cbase_hidden_tax_amount
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderCreditmemoItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::citem_id           :=  WSAdvValue( oResponse,"_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_ROW_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_price        :=  WSAdvValue( oResponse,"_BASE_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_row_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_ROW_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ctax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_applied_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_row_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_ROW_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_row_total    :=  WSAdvValue( oResponse,"_BASE_ROW_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crow_total         :=  WSAdvValue( oResponse,"_ROW_TOTAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice_incl_tax    :=  WSAdvValue( oResponse,"_PRICE_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_DISPOSITION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_price_incl_tax :=  WSAdvValue( oResponse,"_BASE_PRICE_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cqty               :=  WSAdvValue( oResponse,"_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_cost         :=  WSAdvValue( oResponse,"_BASE_COST","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_weee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_ROW_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_row_total_incl_tax :=  WSAdvValue( oResponse,"_BASE_ROW_TOTAL_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::crow_total_incl_tax :=  WSAdvValue( oResponse,"_ROW_TOTAL_INCL_TAX","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::corder_item_id     :=  WSAdvValue( oResponse,"_ORDER_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadditional_data   :=  WSAdvValue( oResponse,"_ADDITIONAL_DATA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweee_tax_applied  :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::chidden_tax_amount :=  WSAdvValue( oResponse,"_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cbase_hidden_tax_amount :=  WSAdvValue( oResponse,"_BASE_HIDDEN_TAX_AMOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure salesOrderCreditmemoCommentEntity

WSSTRUCT MagentoService_salesOrderCreditmemoCommentEntity
	WSDATA   cparent_id                AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   ccomment                  AS string OPTIONAL
	WSDATA   cis_customer_notified     AS string OPTIONAL
	WSDATA   ccomment_id               AS string OPTIONAL
	WSDATA   cis_visible_on_front      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_salesOrderCreditmemoCommentEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_salesOrderCreditmemoCommentEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_salesOrderCreditmemoCommentEntity
	Local oClone := MagentoService_salesOrderCreditmemoCommentEntity():NEW()
	oClone:cparent_id           := ::cparent_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:ccomment             := ::ccomment
	oClone:cis_customer_notified := ::cis_customer_notified
	oClone:ccomment_id          := ::ccomment_id
	oClone:cis_visible_on_front := ::cis_visible_on_front
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_salesOrderCreditmemoCommentEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cparent_id         :=  WSAdvValue( oResponse,"_PARENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment           :=  WSAdvValue( oResponse,"_COMMENT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_customer_notified :=  WSAdvValue( oResponse,"_IS_CUSTOMER_NOTIFIED","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccomment_id        :=  WSAdvValue( oResponse,"_COMMENT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_visible_on_front :=  WSAdvValue( oResponse,"_IS_VISIBLE_ON_FRONT","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure shoppingCartItemEntity

WSSTRUCT MagentoService_shoppingCartItemEntity
	WSDATA   citem_id                  AS string OPTIONAL
	WSDATA   ccreated_at               AS string OPTIONAL
	WSDATA   cupdated_at               AS string OPTIONAL
	WSDATA   cproduct_id               AS string OPTIONAL
	WSDATA   cstore_id                 AS string OPTIONAL
	WSDATA   cparent_item_id           AS string OPTIONAL
	WSDATA   nis_virtual               AS int OPTIONAL
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   cdescription              AS string OPTIONAL
	WSDATA   capplied_rule_ids         AS string OPTIONAL
	WSDATA   cadditional_data          AS string OPTIONAL
	WSDATA   cfree_shipping            AS string OPTIONAL
	WSDATA   cis_qty_decimal           AS string OPTIONAL
	WSDATA   cno_discount              AS string OPTIONAL
	WSDATA   nweight                   AS double OPTIONAL
	WSDATA   nqty                      AS double OPTIONAL
	WSDATA   nprice                    AS double OPTIONAL
	WSDATA   nbase_price               AS double OPTIONAL
	WSDATA   ncustom_price             AS double OPTIONAL
	WSDATA   ndiscount_percent         AS double OPTIONAL
	WSDATA   ndiscount_amount          AS double OPTIONAL
	WSDATA   nbase_discount_amount     AS double OPTIONAL
	WSDATA   ntax_percent              AS double OPTIONAL
	WSDATA   ntax_amount               AS double OPTIONAL
	WSDATA   nbase_tax_amount          AS double OPTIONAL
	WSDATA   nrow_total                AS double OPTIONAL
	WSDATA   nbase_row_total           AS double OPTIONAL
	WSDATA   nrow_total_with_discount  AS double OPTIONAL
	WSDATA   nrow_weight               AS double OPTIONAL
	WSDATA   cproduct_type             AS string OPTIONAL
	WSDATA   nbase_tax_before_discount AS double OPTIONAL
	WSDATA   ntax_before_discount      AS double OPTIONAL
	WSDATA   noriginal_custom_price    AS double OPTIONAL
	WSDATA   nbase_cost                AS double OPTIONAL
	WSDATA   nprice_incl_tax           AS double OPTIONAL
	WSDATA   nbase_price_incl_tax      AS double OPTIONAL
	WSDATA   nrow_total_incl_tax       AS double OPTIONAL
	WSDATA   nbase_row_total_incl_tax  AS double OPTIONAL
	WSDATA   cgift_message_id          AS string OPTIONAL
	WSDATA   cgift_message             AS string OPTIONAL
	WSDATA   cgift_message_available   AS string OPTIONAL
	WSDATA   nweee_tax_applied         AS double OPTIONAL
	WSDATA   nweee_tax_applied_amount  AS double OPTIONAL
	WSDATA   nweee_tax_applied_row_amount AS double OPTIONAL
	WSDATA   nbase_weee_tax_applied_amount AS double OPTIONAL
	WSDATA   nbase_weee_tax_applied_row_amount AS double OPTIONAL
	WSDATA   nweee_tax_disposition     AS double OPTIONAL
	WSDATA   nweee_tax_row_disposition AS double OPTIONAL
	WSDATA   nbase_weee_tax_disposition AS double OPTIONAL
	WSDATA   nbase_weee_tax_row_disposition AS double OPTIONAL
	WSDATA   ctax_class_id             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_shoppingCartItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_shoppingCartItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_shoppingCartItemEntity
	Local oClone := MagentoService_shoppingCartItemEntity():NEW()
	oClone:citem_id             := ::citem_id
	oClone:ccreated_at          := ::ccreated_at
	oClone:cupdated_at          := ::cupdated_at
	oClone:cproduct_id          := ::cproduct_id
	oClone:cstore_id            := ::cstore_id
	oClone:cparent_item_id      := ::cparent_item_id
	oClone:nis_virtual          := ::nis_virtual
	oClone:csku                 := ::csku
	oClone:cname                := ::cname
	oClone:cdescription         := ::cdescription
	oClone:capplied_rule_ids    := ::capplied_rule_ids
	oClone:cadditional_data     := ::cadditional_data
	oClone:cfree_shipping       := ::cfree_shipping
	oClone:cis_qty_decimal      := ::cis_qty_decimal
	oClone:cno_discount         := ::cno_discount
	oClone:nweight              := ::nweight
	oClone:nqty                 := ::nqty
	oClone:nprice               := ::nprice
	oClone:nbase_price          := ::nbase_price
	oClone:ncustom_price        := ::ncustom_price
	oClone:ndiscount_percent    := ::ndiscount_percent
	oClone:ndiscount_amount     := ::ndiscount_amount
	oClone:nbase_discount_amount := ::nbase_discount_amount
	oClone:ntax_percent         := ::ntax_percent
	oClone:ntax_amount          := ::ntax_amount
	oClone:nbase_tax_amount     := ::nbase_tax_amount
	oClone:nrow_total           := ::nrow_total
	oClone:nbase_row_total      := ::nbase_row_total
	oClone:nrow_total_with_discount := ::nrow_total_with_discount
	oClone:nrow_weight          := ::nrow_weight
	oClone:cproduct_type        := ::cproduct_type
	oClone:nbase_tax_before_discount := ::nbase_tax_before_discount
	oClone:ntax_before_discount := ::ntax_before_discount
	oClone:noriginal_custom_price := ::noriginal_custom_price
	oClone:nbase_cost           := ::nbase_cost
	oClone:nprice_incl_tax      := ::nprice_incl_tax
	oClone:nbase_price_incl_tax := ::nbase_price_incl_tax
	oClone:nrow_total_incl_tax  := ::nrow_total_incl_tax
	oClone:nbase_row_total_incl_tax := ::nbase_row_total_incl_tax
	oClone:cgift_message_id     := ::cgift_message_id
	oClone:cgift_message        := ::cgift_message
	oClone:cgift_message_available := ::cgift_message_available
	oClone:nweee_tax_applied    := ::nweee_tax_applied
	oClone:nweee_tax_applied_amount := ::nweee_tax_applied_amount
	oClone:nweee_tax_applied_row_amount := ::nweee_tax_applied_row_amount
	oClone:nbase_weee_tax_applied_amount := ::nbase_weee_tax_applied_amount
	oClone:nbase_weee_tax_applied_row_amount := ::nbase_weee_tax_applied_row_amount
	oClone:nweee_tax_disposition := ::nweee_tax_disposition
	oClone:nweee_tax_row_disposition := ::nweee_tax_row_disposition
	oClone:nbase_weee_tax_disposition := ::nbase_weee_tax_disposition
	oClone:nbase_weee_tax_row_disposition := ::nbase_weee_tax_row_disposition
	oClone:ctax_class_id        := ::ctax_class_id
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_shoppingCartItemEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::citem_id           :=  WSAdvValue( oResponse,"_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::ccreated_at        :=  WSAdvValue( oResponse,"_CREATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cupdated_at        :=  WSAdvValue( oResponse,"_UPDATED_AT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cproduct_id        :=  WSAdvValue( oResponse,"_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cstore_id          :=  WSAdvValue( oResponse,"_STORE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cparent_item_id    :=  WSAdvValue( oResponse,"_PARENT_ITEM_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nis_virtual        :=  WSAdvValue( oResponse,"_IS_VIRTUAL","int",NIL,NIL,NIL,"N",NIL,NIL)
	::csku               :=  WSAdvValue( oResponse,"_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cdescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,NIL)
	::capplied_rule_ids  :=  WSAdvValue( oResponse,"_APPLIED_RULE_IDS","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cadditional_data   :=  WSAdvValue( oResponse,"_ADDITIONAL_DATA","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cfree_shipping     :=  WSAdvValue( oResponse,"_FREE_SHIPPING","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cis_qty_decimal    :=  WSAdvValue( oResponse,"_IS_QTY_DECIMAL","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cno_discount       :=  WSAdvValue( oResponse,"_NO_DISCOUNT","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nweight            :=  WSAdvValue( oResponse,"_WEIGHT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nqty               :=  WSAdvValue( oResponse,"_QTY","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nprice             :=  WSAdvValue( oResponse,"_PRICE","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_price        :=  WSAdvValue( oResponse,"_BASE_PRICE","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ncustom_price      :=  WSAdvValue( oResponse,"_CUSTOM_PRICE","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ndiscount_percent  :=  WSAdvValue( oResponse,"_DISCOUNT_PERCENT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ndiscount_amount   :=  WSAdvValue( oResponse,"_DISCOUNT_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_discount_amount :=  WSAdvValue( oResponse,"_BASE_DISCOUNT_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ntax_percent       :=  WSAdvValue( oResponse,"_TAX_PERCENT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ntax_amount        :=  WSAdvValue( oResponse,"_TAX_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_tax_amount   :=  WSAdvValue( oResponse,"_BASE_TAX_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nrow_total         :=  WSAdvValue( oResponse,"_ROW_TOTAL","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_row_total    :=  WSAdvValue( oResponse,"_BASE_ROW_TOTAL","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nrow_total_with_discount :=  WSAdvValue( oResponse,"_ROW_TOTAL_WITH_DISCOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nrow_weight        :=  WSAdvValue( oResponse,"_ROW_WEIGHT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::cproduct_type      :=  WSAdvValue( oResponse,"_PRODUCT_TYPE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nbase_tax_before_discount :=  WSAdvValue( oResponse,"_BASE_TAX_BEFORE_DISCOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ntax_before_discount :=  WSAdvValue( oResponse,"_TAX_BEFORE_DISCOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::noriginal_custom_price :=  WSAdvValue( oResponse,"_ORIGINAL_CUSTOM_PRICE","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_cost         :=  WSAdvValue( oResponse,"_BASE_COST","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nprice_incl_tax    :=  WSAdvValue( oResponse,"_PRICE_INCL_TAX","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_price_incl_tax :=  WSAdvValue( oResponse,"_BASE_PRICE_INCL_TAX","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nrow_total_incl_tax :=  WSAdvValue( oResponse,"_ROW_TOTAL_INCL_TAX","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_row_total_incl_tax :=  WSAdvValue( oResponse,"_BASE_ROW_TOTAL_INCL_TAX","double",NIL,NIL,NIL,"N",NIL,NIL)
	::cgift_message_id   :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message      :=  WSAdvValue( oResponse,"_GIFT_MESSAGE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cgift_message_available :=  WSAdvValue( oResponse,"_GIFT_MESSAGE_AVAILABLE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nweee_tax_applied  :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nweee_tax_applied_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nweee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_WEEE_TAX_APPLIED_ROW_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_weee_tax_applied_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_weee_tax_applied_row_amount :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_APPLIED_ROW_AMOUNT","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nweee_tax_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_DISPOSITION","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nweee_tax_row_disposition :=  WSAdvValue( oResponse,"_WEEE_TAX_ROW_DISPOSITION","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_weee_tax_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_DISPOSITION","double",NIL,NIL,NIL,"N",NIL,NIL)
	::nbase_weee_tax_row_disposition :=  WSAdvValue( oResponse,"_BASE_WEEE_TAX_ROW_DISPOSITION","double",NIL,NIL,NIL,"N",NIL,NIL)
	::ctax_class_id      :=  WSAdvValue( oResponse,"_TAX_CLASS_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure catalogProductDownloadableLinkFileInfoEntityArray

WSSTRUCT MagentoService_catalogProductDownloadableLinkFileInfoEntityArray
	WSDATA   oWScatalogProductDownloadableLinkFileInfoEntity AS MagentoService_catalogProductDownloadableLinkFileInfoEntity OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntityArray
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntityArray
	::oWScatalogProductDownloadableLinkFileInfoEntity := {} // Array Of  MagentoService_CATALOGPRODUCTDOWNLOADABLELINKFILEINFOENTITY():New()
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntityArray
	Local oClone := MagentoService_catalogProductDownloadableLinkFileInfoEntityArray():NEW()
	oClone:oWScatalogProductDownloadableLinkFileInfoEntity := NIL
	If ::oWScatalogProductDownloadableLinkFileInfoEntity <> NIL
		oClone:oWScatalogProductDownloadableLinkFileInfoEntity := {}
		aEval( ::oWScatalogProductDownloadableLinkFileInfoEntity , { |x| aadd( oClone:oWScatalogProductDownloadableLinkFileInfoEntity , x:Clone() ) } )
	Endif
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntityArray
	Local nRElem1 , nTElem1
	Local aNodes1 := WSRPCGetNode(oResponse,.T.)
	::Init()
	If oResponse = NIL ; Return ; Endif
	nTElem1 := len(aNodes1)
	For nRElem1 := 1 to nTElem1
		If !WSIsNilNode( aNodes1[nRElem1] )
			aadd(::oWScatalogProductDownloadableLinkFileInfoEntity , MagentoService_catalogProductDownloadableLinkFileInfoEntity():New() )
			::oWScatalogProductDownloadableLinkFileInfoEntity[len(::oWScatalogProductDownloadableLinkFileInfoEntity)]:SoapRecv(aNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure integratorCreateOrderItemEntity

WSSTRUCT MagentoService_integratorCreateOrderItemEntity
	WSDATA   csku                      AS string OPTIONAL
	WSDATA   cqty                      AS string OPTIONAL
	WSDATA   coriginal_price           AS string OPTIONAL
	WSDATA   cspecial_price            AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorCreateOrderItemEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorCreateOrderItemEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorCreateOrderItemEntity
	Local oClone := MagentoService_integratorCreateOrderItemEntity():NEW()
	oClone:csku                 := ::csku
	oClone:cqty                 := ::cqty
	oClone:coriginal_price      := ::coriginal_price
	oClone:cspecial_price       := ::cspecial_price
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_integratorCreateOrderItemEntity
	Local cSoap := ""
	cSoap += WSSoapValue("sku", ::csku, ::csku , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("qty", ::cqty, ::cqty , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("original_price", ::coriginal_price, ::coriginal_price , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("special_price", ::cspecial_price, ::cspecial_price , "string", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure integratorConfigurableAttribute

WSSTRUCT MagentoService_integratorConfigurableAttribute
	WSDATA   cattribute_code           AS string OPTIONAL
	WSDATA   cattribute_name           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorConfigurableAttribute
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorConfigurableAttribute
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorConfigurableAttribute
	Local oClone := MagentoService_integratorConfigurableAttribute():NEW()
	oClone:cattribute_code      := ::cattribute_code
	oClone:cattribute_name      := ::cattribute_name
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorConfigurableAttribute
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cattribute_code    :=  WSAdvValue( oResponse,"_ATTRIBUTE_CODE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cattribute_name    :=  WSAdvValue( oResponse,"_ATTRIBUTE_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure integratorConfigurableProductVariation

WSSTRUCT MagentoService_integratorConfigurableProductVariation
	WSDATA   cassociated_product_sku   AS string OPTIONAL
	WSDATA   cassociated_product_id    AS string OPTIONAL
	WSDATA   cweight                   AS string OPTIONAL
	WSDATA   oWSimage_urls             AS MagentoService_ArrayOfString OPTIONAL
	WSDATA   cprice                    AS string OPTIONAL
	WSDATA   cspecial_price            AS string OPTIONAL
	WSDATA   oWSattributes             AS MagentoService_associativeArray OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorConfigurableProductVariation
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorConfigurableProductVariation
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorConfigurableProductVariation
	Local oClone := MagentoService_integratorConfigurableProductVariation():NEW()
	oClone:cassociated_product_sku := ::cassociated_product_sku
	oClone:cassociated_product_id := ::cassociated_product_id
	oClone:cweight              := ::cweight
	oClone:oWSimage_urls        := IIF(::oWSimage_urls = NIL , NIL , ::oWSimage_urls:Clone() )
	oClone:cprice               := ::cprice
	oClone:cspecial_price       := ::cspecial_price
	oClone:oWSattributes        := IIF(::oWSattributes = NIL , NIL , ::oWSattributes:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorConfigurableProductVariation
	Local oNode4
	Local oNode7
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cassociated_product_sku :=  WSAdvValue( oResponse,"_ASSOCIATED_PRODUCT_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cassociated_product_id :=  WSAdvValue( oResponse,"_ASSOCIATED_PRODUCT_ID","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cweight            :=  WSAdvValue( oResponse,"_WEIGHT","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode4 :=  WSAdvValue( oResponse,"_IMAGE_URLS","ArrayOfString",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode4 != NIL
		::oWSimage_urls := MagentoService_ArrayOfString():New()
		::oWSimage_urls:SoapRecv(oNode4)
	EndIf
	::cprice             :=  WSAdvValue( oResponse,"_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cspecial_price     :=  WSAdvValue( oResponse,"_SPECIAL_PRICE","string",NIL,NIL,NIL,"S",NIL,NIL)
	oNode7 :=  WSAdvValue( oResponse,"_ATTRIBUTES","associativeArray",NIL,NIL,NIL,"O",NIL,NIL)
	If oNode7 != NIL
		::oWSattributes := MagentoService_associativeArray():New()
		::oWSattributes:SoapRecv(oNode7)
	EndIf
Return

// WSDL Data Structure integratorBundleProductComponent

WSSTRUCT MagentoService_integratorBundleProductComponent
	WSDATA   cassociated_product_sku   AS string OPTIONAL
	WSDATA   cassociated_product_qty   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_integratorBundleProductComponent
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_integratorBundleProductComponent
Return

WSMETHOD CLONE WSCLIENT MagentoService_integratorBundleProductComponent
	Local oClone := MagentoService_integratorBundleProductComponent():NEW()
	oClone:cassociated_product_sku := ::cassociated_product_sku
	oClone:cassociated_product_qty := ::cassociated_product_qty
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_integratorBundleProductComponent
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cassociated_product_sku :=  WSAdvValue( oResponse,"_ASSOCIATED_PRODUCT_SKU","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cassociated_product_qty :=  WSAdvValue( oResponse,"_ASSOCIATED_PRODUCT_QTY","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

// WSDL Data Structure associativeMultiEntity

WSSTRUCT MagentoService_associativeMultiEntity
	WSDATA   ckey                      AS string OPTIONAL
	WSDATA   oWSvalue                  AS MagentoService_ArrayOfString OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_associativeMultiEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_associativeMultiEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_associativeMultiEntity
	Local oClone := MagentoService_associativeMultiEntity():NEW()
	oClone:ckey                 := ::ckey
	oClone:oWSvalue             := IIF(::oWSvalue = NIL , NIL , ::oWSvalue:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT MagentoService_associativeMultiEntity
	Local cSoap := ""
	cSoap += WSSoapValue("key", ::ckey, ::ckey , "string", .F. , .T., 0 , NIL, .F.,.F.)
	cSoap += WSSoapValue("value", ::oWSvalue, ::oWSvalue , "ArrayOfString", .F. , .T., 0 , NIL, .F.,.F.)
Return cSoap

// WSDL Data Structure catalogProductDownloadableLinkFileInfoEntity

WSSTRUCT MagentoService_catalogProductDownloadableLinkFileInfoEntity
	WSDATA   cfile                     AS string OPTIONAL
	WSDATA   cname                     AS string OPTIONAL
	WSDATA   nsize                     AS int OPTIONAL
	WSDATA   cstatus                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntity
	::Init()
Return Self

WSMETHOD INIT WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntity
Return

WSMETHOD CLONE WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntity
	Local oClone := MagentoService_catalogProductDownloadableLinkFileInfoEntity():NEW()
	oClone:cfile                := ::cfile
	oClone:cname                := ::cname
	oClone:nsize                := ::nsize
	oClone:cstatus              := ::cstatus
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT MagentoService_catalogProductDownloadableLinkFileInfoEntity
	::Init()
	If oResponse = NIL ; Return ; Endif
	::cfile              :=  WSAdvValue( oResponse,"_FILE","string",NIL,NIL,NIL,"S",NIL,NIL)
	::cname              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,NIL)
	::nsize              :=  WSAdvValue( oResponse,"_SIZE","int",NIL,NIL,NIL,"N",NIL,NIL)
	::cstatus            :=  WSAdvValue( oResponse,"_STATUS","string",NIL,NIL,NIL,"S",NIL,NIL)
Return

/*
*------------------------------------------------*
User Function U_UNIWSSoapCall( oSelf, cParamSoap )
*------------------------------------------------*

	If Type( "__c_Ws_Login_Magento" ) != "C"

		SvcSoapCall(	oSelf,cParamSoap,;
			"urn:Action",;
			"RPCX","urn:Magento",,,;
			_c_WsLnkMagento)

	Else

		cLinkMagento := _c_WsLnkMagento
		SvcSoapCall(	oSelf,cParamSoap,;
			"urn:Action",;
			"RPCX","urn:Magento",,,;
			cLinkMagento )

	EndIf

Return
*/
