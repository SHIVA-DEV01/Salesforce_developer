public with sharing class AttachmentController {
    @AuraEnabled(cacheable=true)
    public static List<Attachment> getAttachments() {
        return [SELECT Id, Name, BodyLength FROM Attachment];
    }
}