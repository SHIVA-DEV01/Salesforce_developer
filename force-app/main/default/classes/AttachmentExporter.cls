public with sharing class AttachmentExporter {
    @AuraEnabled
     public static List<AttachmentWrapper> getAttachments(String objectname,String startdate, String enddate , String filter) {
         System.debug(startdate);
         System.debug(enddate);
        List<AttachmentWrapper> wrapperList = New List<AttachmentWrapper>();
        List<Attachment> attachmentlist = New List<Attachment>() ;
        Datetime stdt = (Date)JSON.deserialize('"' + startdate + '"', Date.class);

         Datetime enddt =(Date)JSON.deserialize('"' + enddate + '"', Date.class);

         System.debug('stdt :::: '+ filter);
         System.debug('enddt :::: '+ enddt);
        String querydata = 'SELECT Id, Name, Body, ContentType, ParentId FROM Attachment ';
        if(filter == 'CUSTOM_DATE'){
            attachmentlist = Database.query(querydata += 'WHERE Parent.Type =: objectname and Createddate >=: stdt and Createddate <=: enddt limit 49999');
        }else if(filter == 'ALL'){
            attachmentlist = Database.query(querydata += 'WHERE Parent.Type =: objectname limit 49999');
        }else{
            attachmentlist = Database.query(querydata += 'WHERE Parent.Type =: objectname and Createddate = '+filter+' limit 49999');
        }
         
         System.debug(attachmentlist);
        if(attachmentlist.size() > 49998){
            AttachmentWrapper wrapper = New AttachmentWrapper();
            wrapper.isDataExceeded = true;
            wrapperList.add(wrapper);
            return wrapperList;
        }
        for (Attachment variable : attachmentlist) {
            String[] strlist = new String[]{};
            AttachmentWrapper wrapper = New AttachmentWrapper();
            if(!String.isEmpty(variable.ContentType)){
            strlist = variable.ContentType.split('/');
            }
            wrapper.name = variable.Name;
            if(strlist.size()>1){
                wrapper.extension = strlist[1];
            }
            wrapper.ParentId = variable.ParentId;
            wrapper.body = EncodingUtil.base64Encode(variable.Body);
            wrapper.isDataExceeded = false;
            wrapperList.add(wrapper);
        }

        return wrapperList;
    }
     @AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        List<String> objectNames = new List<String>();
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        
        for (String objName : globalDescribe.keySet()) {
            objectNames.add(objName);
        }
        objectNames.sort();
        return objectNames;
    }
    public class AttachmentWrapper{
        @AuraEnabled
        public string name;
        @AuraEnabled
        public Id parentId;
        @AuraEnabled
        public string body;
        @AuraEnabled
        public string extension;
        @AuraEnabled
        public Boolean isDataExceeded;
    }
}