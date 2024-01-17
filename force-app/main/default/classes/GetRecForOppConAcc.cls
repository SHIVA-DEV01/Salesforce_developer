public with sharing class GetRecForOppConAcc {
    @AuraEnabled
    public static DataTableResponse getRecord(){
        String accTableName = 	'Accounts_List';
        String conTableName = 'Contact_List';
        String oppTableName = 'Opportunity_List';

        List<DataTableColumns> lstConDataColumns = new List<DataTableColumns>();
        List<DataTableColumns> lstOppDataColumns = new List<DataTableColumns>();
        List<SObject> lstPicklistValue = new List<SObject>();
        List<SObject> lstConDataTableData = new List<SObject>();
        List<SObject> lstOppDataTableData = new List<SObject>();
        List<String> conColumnList =  new List<String>();
        List<String> confieldAPINameList = new List<String>();
        List<String> oppColumnList =  new List<String>();
        List<String> oppfieldAPINameList = new List<String>();

        BBDEC__Dynamic_Data_Table__mdt pickListValue = [SELECT Id, DeveloperName, Field_Value__c, Header_Value__c, Query__c, Table_Title__c FROM BBDEC__Dynamic_Data_Table__mdt WHERE DeveloperName =: accTableName];
        BBDEC__Dynamic_Data_Table__mdt conRelatedAcc = [SELECT Id, DeveloperName, Field_Value__c, Header_Value__c, Query__c, Table_Title__c FROM BBDEC__Dynamic_Data_Table__mdt WHERE DeveloperName =: conTableName];
        BBDEC__Dynamic_Data_Table__mdt oppRelatedAcc = [SELECT Id, DeveloperName, Field_Value__c, Header_Value__c, Query__c, Table_Title__c FROM BBDEC__Dynamic_Data_Table__mdt WHERE DeveloperName =: oppTableName];

        if(pickListValue.Query__c != null && pickListValue.Query__c != ''){
            for(SObject SObjectItem : Database.query(pickListValue.Query__c))
            {
                lstPicklistValue.add(SObjectItem);
            }
        }

        if(conRelatedAcc.Header_Value__c != null)
        {
            conColumnList = conRelatedAcc.Header_Value__c.split(',');
        }

        if(conRelatedAcc.Field_Value__c != null)
        {
            confieldAPINameList = conRelatedAcc.Field_Value__c.split(',');
        }

        for(integer i = 0; i < conColumnList.size(); i++)
        {

            DataTableColumns datacolumns = new DataTableColumns( conColumnList[i].trim() , 
                                                                confieldAPINameList[i].substringBefore(':').trim(), 
                                                                confieldAPINameList[i].substringAfter(':').trim());

            lstConDataColumns.add(datacolumns);
        }

        for(SObject SObjectItem : Database.query(conRelatedAcc.Query__c))
        {
            lstConDataTableData.add(SObjectItem);
        }

        if(oppRelatedAcc.Header_Value__c != null)
        {
            oppColumnList = oppRelatedAcc.Header_Value__c.split(',');
        }

        if(oppRelatedAcc.Field_Value__c != null)
        {
            oppfieldAPINameList = oppRelatedAcc.Field_Value__c.split(',');
        }
        
        for(integer i = 0; i < oppColumnList.size(); i++)
        {

            DataTableColumns datacolumns = new DataTableColumns( oppColumnList[i].trim() , 
                                                                oppfieldAPINameList[i].substringBefore(':').trim(), 
                                                                oppfieldAPINameList[i].substringAfter(':').trim());

            lstOppDataColumns.add(datacolumns);
        }

        for(SObject SObjectItem : Database.query(oppRelatedAcc.Query__c))
        {
            lstOppDataTableData.add(SObjectItem);
        }

        DataTableResponse finalWrapper   = new DataTableResponse();
        finalWrapper.conTableTitle          = conRelatedAcc.Table_Title__c;
        finalWrapper.lstConDataTableColumns = lstConDataColumns;
        finalWrapper.lstConDataTableData    = lstConDataTableData;
        finalWrapper.oppTableTitle          = oppRelatedAcc.Table_Title__c;
        finalWrapper.lstOppDataTableColumns = lstOppDataColumns;
        finalWrapper.lstOppDataTableData    = lstOppDataTableData;
        finalWrapper.lstPickListValueData = lstPicklistValue;
        return finalWrapper;
    }

    public class DataTableColumns {
        @AuraEnabled
        public String label;
        @AuraEnabled       
        public String fieldName;
        @AuraEnabled
        public String type;

        public DataTableColumns(String label, String fieldName, String type)
        {
            this.label     = label;
            this.fieldName = fieldName;
            this.type      = type;          
        }
    }
    
    public class DataTableResponse {
        @AuraEnabled
        public List<DataTableColumns> lstConDataTableColumns;
        @AuraEnabled
        public List<sObject> lstConDataTableData;
        @AuraEnabled
        public String conTableTitle;
        @AuraEnabled
        public List<DataTableColumns> lstOppDataTableColumns;
        @AuraEnabled
        public List<sObject> lstOppDataTableData;
        @AuraEnabled
        public String oppTableTitle;
        @AuraEnabled
        public List<sObject> lstPickListValueData;
    }
}