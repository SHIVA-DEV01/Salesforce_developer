public without sharing class B2B_Grame_Product_Handler {
    @AuraEnabled
    public static WrapperObj getstoreId(){
        String activeNetworkId = Network.getNetworkId();
        Set<Id> productCategorySet = New Set<Id>();
        Set<Id> productIdSet = New Set<Id>();
        List<String> productIMG = New List<String>();
        String netName = [SELECT Id ,Name FROM Network WHERE Id =: activeNetworkId LIMIT 1].Name;
        WebStore store = [SELECT Id ,Name FROM WebStore WHERE Name =: netName];
        WebStoreCatalog storeCatalog = [SELECT id, SalesStore.Name, ProductCatalogId  FROM WebStoreCatalog WHERE SalesStoreId =: store.Id];
        List<ProductCategory> productCate = [SELECT Id, Name, Catalog.Name FROM ProductCategory WHERE Catalog.Id =: storeCatalog.ProductCatalogId];
        for (ProductCategory variable : productCate) {
            productCategorySet.add(variable.Id);
        }
        List<ProductCategoryProduct> ProdCatProd = [SELECT Id , ProductId FROM ProductCategoryProduct WHERE ProductCategoryId In: productCategorySet];
        for (ProductCategoryProduct variable : ProdCatProd) {
            productIdSet.add(variable.ProductId);
        }
        List<Product2> prodList = [SELECT Id, Name FROM Product2 WHERE Id IN: productIdSet];
        for(Product2 pro : prodList){
            productIMG.add(getProductImageURL(pro.Id, store.Id));
        }
        System.debug('Store Catalog >>>>>> '+ storeCatalog);
        WrapperObj wrapper = New WrapperObj();
        wrapper.web_Store_Catalog = storeCatalog;
        wrapper.product_Category = productCate;
        wrapper.product_Category_Product = ProdCatProd;
        wrapper.product = prodList;
        wrapper.productURL = productIMG;
        return wrapper;
    }
    @AuraEnabled
    public static String getProductImageURL(String productId, String storeId) {
        ConnectApi.ProductDetail productDetail;
        String productImageUrl = '/img/b2b/default-product-image.svg';

        try{
            productDetail = ConnectApi.CommerceCatalog.getProduct( storeId, productId, null, null, true, new List<String> {'productListImage'}, false, true, true);
            System.debug('productDetail:'+productDetail);
            for (ConnectApi.ProductMediaGroup mediaGroup : productDetail.mediaGroups) {
                List<ConnectApi.ProductMedia> productMedia = (List<ConnectApi.ProductMedia>) mediaGroup.mediaItems;
                
                if (!productMedia.isEmpty()) {
                    productImageUrl = String.valueOf(productMedia[0].url);
                }
                break;
            }
        } catch(Exception e) {}

        return productImageUrl;
    }

    public class WrapperObj{
        @AuraEnabled
        public WebStoreCatalog web_Store_Catalog;
        @AuraEnabled
        public List<ProductCategory> product_Category;
        @AuraEnabled
        public List<ProductCategoryProduct> product_Category_Product;
        @AuraEnabled
        public List<Product2> product;
        @AuraEnabled
        public List<String> productURL;
    }
}