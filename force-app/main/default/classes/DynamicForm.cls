public with sharing class DynamicForm {
    @AuraEnabled
    public static list<UserListWrapper> getFieldSet() {

            list<UserListWrapper> wrapperList = new list<UserListWrapper>();
           try {
            System.debug('in try');
            // String ObjName = 'Opportunity';
            Map<String, String> dataTypeVsLabelMap = new Map<String, String>();
            Map<String, String> apiVs_dataTypeVsLabelMap = new Map<String, String>();
            List<String> pickListValuesList= new List<String>();
            String fieldSetName = 'BBDEC__Form';
            String objectName = 'Opportunity';
            String fieldName ='StageName';

            Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();
            Schema.SObjectType sObjectTypeObj = globalDescribeMap.get(objectName);
            Schema.DescribeSObjectResult describeSObjectResultObj = sObjectTypeObj.getDescribe();
            Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get(fieldSetName);  
 
            List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();

            
            // Schema.DescribeFieldResult fieldResult = test.getDescribe();
            // List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            // for( Schema.PicklistEntry pickListVal : ple){
            //     pickListValuesList.add(pickListVal.getLabel());
            // }     
            // System.debug('PicklistEntry::::>>>>>'+ pickListValuesList);




            // Map<String,Schema.SObjectField> fields = describeSObjectResultObj.fields.getMap() ;
            // Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
            // List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            // for( Schema.PicklistEntry pickListVal : ple){

            //     System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            //     UserListWrapper Wrapper = new UserListWrapper();
            //     wrapper.pickListValue = String.valueOf(pickListVal.getValue());
            //     wrapperList.add(Wrapper);

            // }


            List<String> fieldsApiNames = new List<String>();
            List<String> pickList = new List<String>();
            System.debug('fieldM:::>>>'+fieldSetMemberList);
            if(!fieldSetMemberList.isEmpty() && fieldSetMemberList.size()>0){
                for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
                {
                    fieldsApiNames.add(fieldSetMemberObj.getFieldPath());
                    dataTypeVsLabelMap.put(fieldSetMemberObj.getFieldPath(),fieldSetMemberObj.getLabel());
                    apiVs_dataTypeVsLabelMap.put(fieldSetMemberObj.getFieldPath(), String.valueOf(fieldSetMemberObj.getType()));
                    
                }
                integer ids = 1; 
                System.debug('Fields Api Name :::>>>'+ fieldsApiNames);
                System.debug('Api vs Label Map :::>>>'+ dataTypeVsLabelMap);
                System.debug('api Vs dataType Vs LabelMap ::::>>>>'+ apiVs_dataTypeVsLabelMap);
                for(String Key : fieldsApiNames){
                    UserListWrapper Wrapper = new UserListWrapper();
                    Wrapper.dataType = dataTypeVsLabelMap.get(key);
                    Wrapper.fieldApi = apiVs_dataTypeVsLabelMap.get(key);
                    Wrapper.Label = key;
                    Wrapper.id = String.ValueOf(ids);
                    ids = ids + 1;
                    wrapperList.add(Wrapper);
                    if(apiVs_dataTypeVsLabelMap.get(key) == 'PICKLIST'){
                        pickList.add(key);
                    }
                    System.debug('Key:::>>>>'+ wrapperList);
                }

                List<String> temp = new List<String>();
                if(pickList.size()>0 && !pickList.isEmpty()){
                    for(String pick : pickList){
                        UserListWrapper Wrapper = new UserListWrapper();
                        Map<String,Schema.SObjectField> fields = describeSObjectResultObj.fields.getMap() ;
                        Schema.DescribeFieldResult fieldResult = fields.get(pick).getDescribe();
                        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                        for( Schema.PicklistEntry pickListVal : ple){
            
                            System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
                            temp.add(String.valueOf(pickListVal.getValue()));
                            
                            // wrapper.pickListValue = String.valueOf(pickListVal.getValue());
                            
            
                        }
                        wrapper.pickListValue = temp;
                        wrapperList.add(Wrapper);
                    }
                }
                
                return wrapperList;

            }
            return null;
            }   catch (Exception e) {
            
                System.debug('Error :::::::>>>>'+ e.getMessage());
                return null;
           }
            

    }

    public class UserListWrapper{
        @AuraEnabled
        public String dataType{get;set;}
        @AuraEnabled
        public String label{get;set;}
        @AuraEnabled
        public String fieldApi{get;set;}
        @AuraEnabled
        public List<String> pickListValue{get;set;}
        @AuraEnabled
        public string id{get;set;}
    }
}