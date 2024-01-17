public with sharing class OpportunityForm {
    @AuraEnabled
    public static String createOpportunity(Map<String,String> farMap) {
        if(farMap.get('name') != null && farMap.get('close_Date') != null && farMap.get('stage_Name') != null && !String.isBlank(farMap.get('name')) && !String.isBlank(farMap.get('close_Date')) && !String.isBlank(farMap.get('stage_Name'))){
            // && !isBlank(farMap.get('name')) && !isBlank(farMap.get('close_Date')) && !isBlank(farMap.get('stage_Name'))
            date dt = date.valueOf(farMap.get('close_Date'));
            Opportunity opp = new Opportunity();
            opp.Name = farMap.get('name');
            opp.CloseDate = dt;
            opp.StageName = farMap.get('stage_Name');
            if(farMap.get('accountId') != null && !String.isBlank(farMap.get('accountId'))){
                opp.AccountId = farMap.get('accountId');
            }
            insert opp;
            return opp.id;
        }
        else{
            system.debug('In else part');
            return null ;
        }
        
        
    }


    @auraEnabled
    public static string createNewOppSaveLater(List<String> proList, String priceBookId, String name, String close_Date, String stage_Name, String account_Id, String quantity, String unitPrice){
        if(name != null && !String.isBlank(name) && close_Date != null && !String.isBlank(close_Date) && stage_Name != null && !String.isBlank(stage_Name)){
            date dt = date.valueOf(close_Date);
            Opportunity opp = new Opportunity();
            opp.Name = name;
            opp.CloseDate = dt;
            opp.StageName = stage_Name;
            if(account_Id != null && !String.isBlank(account_Id)){
                opp.AccountId = account_Id;

            }
            insert opp;
            return createNewPriceBokEntry(proList,priceBookId,opp.id,quantity,unitPrice);

            
    }
    return null;
}

    @AuraEnabled
    public static void createPriceBook(String priceName){
        try{
        if(priceName != null && !String.isBlank(priceName)){
        pricebook2 priceBook = new pricebook2();
        priceBook.Name =  priceName;
        insert priceBook;
        // System.debug('In create Price Book'+priceBook.Name+priceBook.id);
        // createPriceBookEntry(proList);
        }
    }catch(Exception ex){
        System.debug('Exception :::>>'+ex);
    }
        
    }

    @AuraEnabled
    public static void createPriceBookEntry(List<String> proList){
        Pricebook2 standardPriceBook = [SELECT Id From Pricebook2 Where isStandard = true Limit 1];
        List<Pricebookentry> priceBElist = new List<Pricebookentry>();
        for(String pro : prolist){
            Pricebookentry standardPriceBookEntry = new Pricebookentry();
            standardPriceBookEntry.Pricebook2Id = standardPriceBook.Id;
            standardPriceBookEntry.Product2Id = pro;
            standardPriceBookEntry.UnitPrice = 100;
                //UseStandardPrice = false;
            standardPriceBookEntry.IsActive = true;
            priceBElist.add(standardPriceBookEntry);
            
        }
        System.debug('PriceBookEntryList'+priceBElist);
        insert priceBElist;

    }

    @AuraEnabled
    public static string createNewPriceBokEntry(List<String> proList, String priceBookId, String oppId, String quantity, String unitPrice){
        try {
            if(proList.size()>0){
            List<Pricebookentry> priceBENList = new List<Pricebookentry>();
        for(String pro: proList){
            Pricebookentry priceBEN= new Pricebookentry();
            priceBEN.Pricebook2Id = priceBookId;
            priceBEN.UnitPrice=100;
            priceBEN.Product2Id =pro;
            // priceBEN.UseStandardPrice = True;
            priceBEN.IsActive = true;
            priceBENList.add(priceBEN);
            System.debug('Inside create new price book::::>>>'+priceBENList);
        }
        insert priceBENList;

        System.debug('In create new price book::::>>>'+priceBENList);

       
        return createOLI(priceBENList,oppId,quantity,unitPrice);
        }
        return null;
        } catch (Exception ex) {
            System.debug(ex);
            return null;
        }
        

    }

    @AuraEnabled
    public static string createOLI(List<Pricebookentry> priceBENList, String oppId, String quantity, String unitPrice){
        
        if(oppId != null){
            list<opportunityLineItem> oLIList = new list<opportunityLineItem>();
            for(Pricebookentry p : priceBENList){
                opportunityLineItem oLI = new opportunityLineItem();
                oLI.OpportunityId = oppId;
                oLI.PricebookEntryId = p.id;
                // oLI.UseStandardPrice=false;
                // oLI.isActive=true;
                oLI.Quantity = Integer.Valueof(quantity);
                oLI.UnitPrice = Integer.Valueof(unitPrice);
                oLIList.add(oLI);
            }
            Insert oLIList;
            System.debug('In createOLI:::>>>'+oLIList);
            return 'Success';
        }
        return null;
    }

    @AuraEnabled
    public static list<UserListWrapper> getProduct(){
        List<UserListWrapper> wrapperList = new List<UserListWrapper>();
        List<Product2> proList = [SELECT Id,Name FROM Product2];
        System.debug('Products:::>>>>'+proList);
        for (Product2 pro : proList) {
            UserListWrapper wrapper = new UserListWrapper();
            wrapper.value = pro.id;
            wrapper.label = pro.name;
            wrapperList.add(wrapper);
        }

        return wrapperList;
    }

    @AuraEnabled
    public static ProductWrapper createNewProduct(String productName){
        Product2 pro = new Product2();
        pro.Name = productName;
        insert pro;
        ProductWrapper wrapper = new ProductWrapper();
        wrapper.label = pro.Name;
        wrapper.value = pro.id;

        return wrapper;
    }

    public class UserListWrapper{
        @AuraEnabled
        public String label{get;set;}
        @AuraEnabled
        public String value{get;set;}
}
    public class ProductWrapper{
        @AuraEnabled
        public String label{get;set;}
        @AuraEnabled
        public String value{get;set;}
    }
}