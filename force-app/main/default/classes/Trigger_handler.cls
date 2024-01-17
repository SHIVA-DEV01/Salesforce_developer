public class Trigger_handler {
    public static void employeeIsEqualContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(account acc : accList){
            Integer employeeNumber = acc.NumberOfEmployees;
            for(Integer i=0 ; i < employeeNumber ; i++){
                Contact con = new Contact();
                con.LastName = acc.Name + i;
                con.AccountId = acc.Id;
                conList.add(con);
            }
        }
        Insert conList;
        
    }
    
    
    
    public static void opportunityCloseDate(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.CloseDate < date.today()){
                opp.addError('Please insert the future closed Date');
            }
        }
    }
    
    
    
    
    public static void setupPriceBook(List<Product2> proList){
        List<PricebookEntry> priceBookEntryList = new List<PricebookEntry>();
        Pricebook2 priBook = [Select id from Pricebook2 where IsStandard = True];
        for(Product2 pro : proList){
            PricebookEntry pBE = new PricebookEntry();
            pBE.Pricebook2Id = priBook.Id;
            pBE.Product2Id = Pro.Id;
            pBE.UnitPrice = 1;
            pBE.IsActive = true;
            priceBookEntryList.add(pBE);
            
        }
        Insert priceBookEntryList;
    }
    
    
    
    
    public static void updateAccountName(List<Contact> conList){
        if(conlist.size()>0)
        {
        Account acc = [Select id,Name from Account where id =: conList[0].AccountId];
        acc.Name = acc.Name + ' ' + conList[0].LastName;
        Update acc;
    }
    }
    
    
    
    public static void deleteContact(List<Contact> conList){
        
        if(conList.size() != Null){
            Account acc = [Select id,Name from Account where id =: conList[0].AccountId];
            for(Contact con: conList){
            acc.Name = acc.Name.remove(con.LastName);
            Update acc;
            }
        }
    }
    
    
    public static void showAlertOpportunityClose(List<Opportunity> oppList){
        List<OpportunityLineItem> oppLineItem = [Select id, Name, OpportunityId from OpportunityLineItem where OpportunityId =: oppList[0].id];
        system.debug(oppLineItem.size());
        if((oppList[0].StageName == 'Closed Won' || oppList[0].StageName == 'Closed Lost') && oppLineItem.size()<=0){
            oppList[0].adderror('Can\'t be update with Close won or close lost with no opp line item');
        }
    }
    
    
    public static void contactAddInOpportunity(List<Opportunity> oppList){
        List<Contact> conList = [Select id,AccountId from Contact where AccountId =: oppList[0].AccountId];
        List<OpportunityContactRole> oppContactRoleList = new List<OpportunityContactRole>();
        for(Contact con : conList){
            OpportunityContactRole oppContactRole = new OpportunityContactRole();
            oppContactRole.OpportunityId = oppList[0].Id;
            oppContactRole.ContactId = con.Id;
            oppContactRoleList.add(oppContactRole);
        }
        Insert oppContactRoleList;
    }
    
    
    public static void updateCampaignIsCompleted(List<Campaign> camList ){
        if(camList[0].Status == 'Completed'){
        List<Opportunity> oppList = [Select Id, CampaignId, StageName,( Select Id from OpportunityLineItems ) from Opportunity where CampaignId =: camList[0].Id];
        List<Opportunity> opp1List = new List<Opportunity>();
            for(Opportunity opp : oppList){
                    
                    if(opp.OpportunityLineItems.isEmpty()){
                        
                        opp.StageName ='Closed Lost';
                    }
                    else{
                           opp.StageName = 'Closed Won';
                           
                    }
                    opp1List.add(opp); 
                }
            Update opp1List;
            
        }
    }
    
    
    public static void stopMoreThan2OppLineItem(List<OpportunityLineItem> oppLineItemList){
		List<Opportunity> oppList = [Select id,(Select id from OpportunityLineItems) from Opportunity where id =: oppLineItemList[0].OpportunityId];
        system.debug(oppLineItemList.size());
        for(Opportunity opp : oppList){
            system.debug(opp.OpportunityLineItems.size());
        if((opp.OpportunityLineItems.size()>1 || oppLineItemList.size()>2) || (opp.OpportunityLineItems.size()>=1 && oppLineItemList.size()>1)){
            oppLineItemList[0].adderror('Can\'t fill more than two records');
        }  
        }
    }
    
    
    public static void employeesGreaterThan100(List<Account> accList){
        Integer employeeNumber = Integer.valueOf(accList[0].NumberOfEmployees);
        if(employeeNumber > 100){
            List<Contact> conList = new List<Contact>();
            List<Case> caseList = new List<Case>();
            List<Opportunity> oppList = new List<Opportunity>();
            List<OpportunityContactRole> oppContactRoleList = new List<OpportunityContactRole>();
            Contact con = new Contact();
            con.LastName = 'Default Contact';
            con.AccountId = accList[0].Id;
            conList.add(con);
            Insert conList;
            Case cas = new Case();
            cas.ContactId = conList[0].Id;
            cas.AccountId = accList[0].Id;
            cas.Status = 'Working';
            cas.Origin = 'Email';
            caseList.add(cas);
            Insert caseList;
            Opportunity opp = new Opportunity();
            opp.AccountId = accList[0].Id;
            opp.StageName = 'Closed Won';
            opp.CloseDate = date.parse('9/9/2022');
            opp.Name = 'Default Opportunity';
            oppList.add(opp);
            Insert oppList;
            OpportunityContactRole oppContactRole = new OpportunityContactRole();
            oppContactRole.ContactId = conList[0].Id;
            oppContactRole.OpportunityId = oppList[0].Id;
            oppContactRoleList.add(oppContactRole);
            Insert oppContactRoleList;
        }
    }
    
    
    public static void createCaseWhenOpportunityTrigger(List<Opportunity> oppList){
        if(oppList[0].StageName == 'Closed Lost' && oppList.size() != Null){
            List<Contact> conList = [Select id, Name from Contact where AccountId =: oppList[0].AccountId];
            List<Case> caseList = new List<Case>();
            for(Contact con : conList){
                case cas = new case();
                cas.AccountId = oppList[0].AccountId;
                cas.ContactId = con.Id;
                cas.Status = 'Working';
                cas.Origin = 'Phone';
                caseList.add(cas);
                
            }
            Insert caseList;
        }
    }
    
    public static void noSameContactRegistered(List<Event_Participant__c> eventPartList){
        List<Event_Participant__c> eventPartList1 = [Select id,Event__c from Event_Participant__c where Contact__c =: eventPartList[0].Contact__c And Event__c =: eventPartList[0].Event__c];
        System.debug(eventPartList1.size());
        if(eventPartList1.size() != 0){
            eventPartList[0].adderror('A user is not allowed to create Two Event participant with same contact');
        }
    }
    
    public static void fillMailAddressWithItsShippingAddress(List<Contact> conList){
        if(conList.size()>0){
            List<Account> accList = [Select id from Account where id =: conList[0].AccountId];
            List<Account> accList1 = new List<Account>();
            for(Contact con : conList){
                for(Account acc : accList){
                    acc.ShippingCity = con.MailingCity;
                    acc.ShippingCountry = con.MailingCountry;
                    acc.ShippingPostalCode = con.MailingPostalCode;
                    acc.ShippingState = con.MailingState;
                    acc.ShippingStreet = con.MailingStreet;
                    accList1.add(acc);
                }
            }
            Upsert accList1;
        }
    }
    
    public static void stopCreatingAnyMorePlan(Plan__c pla){
        decimal total=0;
        list<Plan__c> hourList=[select Travel_Hours__c from Plan__c where Location__c=:pla.Location__c];
        
        if(!hourList.isempty()  && hourList!=null ){
            
            for(Plan__c p : hourList){
            total = total + p.Travel_Hours__c;
            }
    
        if(total+pla.Travel_Hours__c>100){
            pla.addError('can\'t add more than century hours');
        }
        }
             else if((total+pla.Travel_Hours__c)>100){
            pla.addError('can\'t add more than century hours');
             }
    }
    
    

    
     public static void leadToShowErrorMessage(Lead ld){
        date dt1=date.newInstance(2022, 07, 01);
    	date dt2=date.newInstance(2022, 07, 30);
        list<Aggregateresult>ldList=[SELECT Owner.Name,count(id)
 		FROM Lead WHERE createddate>=:dt1 AND createddate<=:dt2 group by Owner.Name having count(id)>20 limit 1 ];
        system.debug(ldList);
        if(ldList!=null && !ldList.isEmpty()){
            ld.adderror('cant authorise more than 20 leads to single user');
        }
    }
    
        public static void createACheckBox(Contact con){
        list<Contact> conList=[select id from Contact where AccountId=:con.AccountId];
        Account acc=[select Allow_Multiple__c from Account WHERE id=:con.AccountId LIMIT 1];
        if(conList.size()>0 && acc.Allow_Multiple__c==False){
            con.addError('can\'t add more than one contact' );
        }
    }
    
    public static void stopCreatingEventParticipantDay(Event_Participant__c eventParticipant){
       List<Event_Participant__c> eventPartList = [Select Event__r.Event_Date__c, Contact__c from Event_Participant__c where Contact__c =: eventParticipant.Contact__c];
       Event__c eventList = [Select id, Event_Date__c from Event__c where id =: eventParticipant.Event__c ];
        for(Event_Participant__c ep : eventPartList){
            if(ep.Event__r.Event_Date__c == eventList.Event_Date__c){
                eventParticipant.adderror('Can\'t Event Participant on same date on event');
            }
        }
    }
    
    public static void notAllowUserToAddaPriceBook(Opportunity opp){
        Account accList = [Select id, Working_In__c from Account where id=:opp.AccountId];
        System.debug(accList);
        List<PriceBook2> pbList = [Select id,Name from PriceBook2 where id =: opp.Pricebook2Id];
        System.debug(pbList);
        for(PriceBook2 pb: pbList){
            if(!accList.Working_In__c.contains(pb.Name)){
                System.debug(pb);
                opp.adderror('Not allow to select this PriceBook');
            }
        }
    }
    
    public static void countrySameAsUserCountry(List<Contact> conList){
        if(conList[0].AccountId != Null){
        User us=[SELECT Country FROM User WHERE id=:UserInfo.getUserId() Limit 1];
        Account acc=[select BillingCountry from Account where id=:conList[0].AccountId Limit 1];
        for(Contact con : conList){
            System.debug(con.AccountId);
            if(con.SAME_COUNTRY_AS_USER_COMPANY__c==true && con.MailingCountry!=us.Country && con.MailingCountry!=acc.BillingCountry && con.AccountId != null){
            con.addError('country in not same');
        }
        }

    }
    }
}