/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-18-2023
 * @last modified by  : abhishek.gupta@continuserve.com
**/
public with sharing class  OpportunityFileAttachmentHandler {
    public class FileWrapper{
        @AuraEnabled public Map<Id,List<Sobject>> opptVsContVersion {get;set;}
        @AuraEnabled public String downloadUrl {get;set;}
        @AuraEnabled public String baseUrl {get;set;}
        @AuraEnabled public Map<Id,Opportunity> mapOfOppt {get;set;}
    }
    
    @AuraEnabled
    public static FileWrapper getAllPorfileCitAttachmentReltdToOppt(){
        try{

            // Map<Id,Id> contDocIdvsOppId=new Map<Id,Id>();
            // Map<Id,List<Sobject>> mapOfOpptVsContVersion=new Map<Id,List<Sobject>>();
            // Map<Id,OpportunityLineItem> mapOfOpptLineItem=new Map<Id,OpportunityLineItem>([SELECT Id, Name, OpportunityId, Opportunity.Name, Opportunity.StageName FROM OpportunityLineItem]);
            
            // Map<Id,Opportunity> mapOfOppt=new Map<Id,Opportunity>();
            // if(!mapOfOpptLineItem.isEmpty() && mapOfOpptLineItem.size()>0){

            //     for(OpportunityLineItem lineItem:mapOfOpptLineItem.values()){
            //         if(!mapOfOppt.containsKey(lineItem.OpportunityId)){
            //             Opportunity op=new Opportunity();
            //             op.Id=lineItem.OpportunityId;
            //             op.StageName=lineItem.Opportunity.StageName;
            //             op.Name=lineItem.Opportunity.Name;
            //             mapOfOppt.put(lineItem.OpportunityId,op);
                        
            //         }
            //     }

                // if(!mapOfOppt.isEmpty() && mapOfOppt.size()>0){
                //     Map<Id,ContentDocumentLink> mapOfContDocLinks=new Map<Id,ContentDocumentLink>([Select Id,ContentDocumentId,LinkedEntityId from ContentDocumentLink where LinkedEntityId IN:mapOfOppt.keySet() AND ContentDocument.FileExtension LIKE '%xls%' AND (ContentDocument.Title LIKE '%Profile%' AND (ContentDocument.Title LIKE '%CIT%' OR ContentDocument.Title LIKE '%CVS%'))]);
                //         for(Id linkId:mapOfContDocLinks.keySet()){
                //         if(!contDocIdvsOppId.containsKey(mapOfContDocLinks.get(linkId).ContentDocumentId)){
                //             contDocIdvsOppId.put(mapOfContDocLinks.get(linkId).ContentDocumentId,mapOfContDocLinks.get(linkId).LinkedEntityId);
                //         }
                //     }
                    
                        
                        // if(contDocIdvsOppId.size()>0 && !contDocIdvsOppId.isEmpty()){
                        
                            Map<Id,ContentVersion> mapOfConDocVersion=new Map<Id,ContentVersion>([SELECT Id, FileType, FileExtension, ContentSize, ContentDocumentId, Title FROM ContentVersion]);
                    
                            // for(Id docVersnId:mapOfConDocVersion.keySet()){
                            //     if(contDocIdvsOppId.containsKey(mapOfConDocVersion.get(docVersnId).ContentDocumentId)){
                            //         if(!mapOfOpptVsContVersion.containsKey(contDocIdvsOppId.get(mapOfConDocVersion.get(docVersnId).ContentDocumentId))){
                            //             mapOfOpptVsContVersion.put(contDocIdvsOppId.get(mapOfConDocVersion.get(docVersnId).ContentDocumentId),new List<Sobject>{mapOfConDocVersion.get(docVersnId)});
                            //         }
                            //         else{
                            //             List<Sobject> tempList=mapOfOpptVsContVersion.get(contDocIdvsOppId.get(mapOfConDocVersion.get(docVersnId).ContentDocumentId));
                            //             tempList.add(mapOfConDocVersion.get(docVersnId));
                            //             mapOfOpptVsContVersion.put(contDocIdvsOppId.get(mapOfConDocVersion.get(docVersnId).ContentDocumentId),tempList);
                                        
                            //         }
                                    
                            //     }
                            // }
                            
                           /*Base url for downloading a file*/
                            String redirectUrl=System.URL.getSalesforceBaseUrl().toExternalForm()+'/sfc/servlet.shepherd/version/download/';
                             
                            
                            /*Generating download URL using Content Version Ids*/
                            for(Id cvId:mapOfConDocVersion.keySet()){
                                redirectUrl=redirectUrl+'/'+cvId;
                                
                            }
                            FileWrapper fw=new FileWrapper();
                            fw.opptVsContVersion=null;
                            fw.downloadUrl=redirectUrl;
                            fw.baseUrl=System.URL.getSalesforceBaseUrl().toExternalForm();
                            fw.mapOfOppt=null;
                                return fw;
                            // }
                        
                // }
                // return null;
            // }
        // return null;
    }
        catch(Exception ex){
            System.debug('Error Message:'+ex.getMessage());
            System.debug('Error Line:'+ex.getLineNumber());
            throw new AuraHandledException(ex.getMessage());
        }
        
    }
     
    
    

}