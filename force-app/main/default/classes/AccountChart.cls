public with sharing class AccountChart {
    @AuraEnabled
    public static List<ContentVersion> getAccountOppCon(Id recordId) {
		system.debug('recordId'+recordId);
        List<ContentDocumentLink> conDocLink =  [Select id,ContentDocument.Id,ContentDocument.FileType from ContentDocumentLink where LinkedEntityId =: recordId ];
        Set<Id> setId = New Set<Id>();
        if(!conDocLink.isEmpty() && conDocLink != null){
            for (ContentDocumentLink variable : conDocLink) {
            setId.add(variable.ContentDocument.Id);
            }
        }
        
        List<ContentVersion> con = [Select VersionDataUrl from ContentVersion where ContentDocumentId In:setId];
        return con;
    }
}