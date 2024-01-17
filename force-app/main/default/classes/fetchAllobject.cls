public class fetchAllobject {

    public string selectedSobjName{get;set;}
    public string selectedFieldName{get;set;}
    
    public List<SelectOption> getSobject(){
        List<SelectOption> sobjList=new List<SelectOption>();
        sobjList.add(new SelectOption(' ','Select Sobject'));
        integer c=0;
        for(Schema.SObjectType stype:Schema.getGlobalDescribe().values()){
            String sobjName = String.valueOf(stype);
            sobjList.add(new SelectOption(sobjName,sobjName));
            c++;
            if(c==200){
                break;
            }
        }
        return sobjList;
    }
    public List<SelectOption> getFields(){
        if(selectedSobjName!=NULL){
            List<SelectOption> fList=new List<SelectOption>();
            SObjectType sobjType = Schema.getGlobalDescribe().get(selectedSobjName);
            for(Schema.SObjectField sbf:sobjType.getDescribe().fields.getMap().values()){
                String s=String.valueOf(sbf);
                fList.add(new SelectOption(s,s));
            }
            return fList;
        }
        else{
            return null;
        }
                
    }
    public string getDataType(){
        if(selectedSobjName!=NULL&&selectedFieldName!=NULL){
            SObjectType sobjType = Schema.getGlobalDescribe().get(selectedSobjName);
            Map<String,Schema.SObjectField> smp=sobjType.getDescribe().fields.getMap();
            String f=String.valueOf(smp.get(selectedFieldName).getDescribe().getType());
            return f;
        }
        else{
            return null;
        }
    }
    @AuraEnabled
    public static List<String> getAllSobject(){
        try {
            System.debug('In getAll');
            //List<Schema.SObjectType> stypeList=Schema.getGlobalDescribe().values();
            List<String> sObjList=new List<String>();
            for(Schema.SObjectType stype:Schema.getGlobalDescribe().values()){
                sObjList.add(String.valueOf(stype));
            }
            if(sObjList!=NULL){
                return sObjList;
            }
            else{
                return NULL;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<String> getAllField(string sobjname){
        try {
            
            SObjectType sobjType = Schema.getGlobalDescribe().get(sobjName);
            List<String> sobjFieldList=new List<String>();
            for(Schema.SObjectField s:sobjType.getDescribe().fields.getMap().values()){
                sobjFieldList.add(String.valueOf(s));
            }
            
            if(sobjFieldList!=NULL){
                return sobjFieldList;
            }
            else{
                return NULL;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string getFieldType(string sobjfield,string sobjName){
        try {
            SObjectType sobjType = Schema.getGlobalDescribe().get(sobjName);
            Map<String,Schema.SObjectField> smp=sobjType.getDescribe().fields.getMap();
            String dtype=String.valueOf(smp.get(sobjfield).getDescribe().getType());
            if(dtype!=NULL){
            return dtype;
            }
            else{
                return NULL;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    }