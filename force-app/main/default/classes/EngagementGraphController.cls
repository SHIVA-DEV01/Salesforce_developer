public with sharing class EngagementGraphController {
    @AuraEnabled(cacheable=true)
    // public static List<Map<String,Integer>> getObject(Id recId, Integer filter, Id ownerValue, integer LastMonths , date startDate , date endDate){
    public static getDataWrapper getObject(String startDate , String endDate){
        try {
            // Schema.SObjectType objectName = recId.getsobjecttype();
            // if(String.valueOf(objectName) == 'Account') {
                // getDataWrapper accountWrapper = new getDataWrapper();
                // List<Map<String,Integer>> accountWrapper = new List<Map<String,Integer>>();
                // accountWrapper = getAccountDetailes(recId, filter, ownerValue,LastMonths);
                getDataWrapper accountWrapper = getAccountDetailes(startDate,endDate);
                // return accountWrapper;
                return accountWrapper;
            // }
            // if(String.valueOf(objectName) == 'Opportunity') {
            //     getOpportunityDetailes(recId, filter, ownerValue);
            // }
            // if(String.valueOf(objectName) == 'Lead') {
            //     getLeadDetailes(recId, filter, ownerValue);
            // }
        } catch(Exception ex){
            System.debug('An Error ' + ex.getMessage() + 'In line No. ' + ex.getLineNumber());
        }
        return null;
    }
    // public static List<Map<String,Integer>> getAccountDetailes(Id recId, Integer filter, Id ownerValue ,integer LastMonths, date startDate , date endDate) {
    public static getDataWrapper getAccountDetailes(String startDate , String endDate) {

        Date startDateNew = Date.ValueOf(startDate);
        Date endDateNew = Date.ValueOf(endDate);

        Date currentDate = date.today();

        getDataWrapper get = new getDataWrapper();

        Integer startYear = startDateNew.year();
        Integer startMonth = startDateNew.month();
        Integer startDays = startDateNew.day();

        Map<Integer, Integer> startMap = new Map<Integer,Integer>();
        Map<Integer, Integer> endMap = new Map<Integer,Integer>();

        Integer endYear = endDateNew.year();
        Integer endMonth = endDateNew.month();
        Integer endDays = endDateNew.day();

        Map<Integer,Integer> monthsVSdays = new Map<Integer,Integer>();

        Map<String, List<String>> strDate = new Map<String, List<String>>();

        List<String> dateStr = new List<String>();


    //     if(startYear == endYear){
    //         startMap.put(startMonth,startDays);
    //         endMap.put(endMonth,endDays);
    //         Integer monthsBW = endMonth - startMonth;
    //         monthsBW = monthsBW + 1;
    //         System.debug('monthBw'+monthsBW);
            
    //         for(Integer i = 1; i<=monthsBW;i++){
    //             if(endMonth >= startMonth){
    //                 integer temp = date.daysInMonth(startYear , startMonth);
    //                 monthsVSdays.put(startMonth, temp);
    //                 startMonth = startMonth + 1;

    //             }
    //         }

    //         System.debug('::::>>>>'+ monthsVSdays);
            
        

        

    //     for(Integer key : monthsVSdays.keySet()){
    //         List<String> strdays = new List<String>();
    //         Datetime dt = Date.newInstance(endYear,key,01);
    //         System.debug('DateTime:::>>>'+ dt);
    //         if(startMonth != endMonth){
    //             if(startMap.get(key) > 1){

    //             for(Integer i=startMap.get(key) ; i <= monthsVSdays.get(key);i++){
    //                 System.debug('In Loop'+monthsVSdays.get(key));
                    
    //                 String str = String.Valueof(startYear) + '-' + String.ValueOf(dt.format('MMM')) +'-'+ i;
    //                 strdays.add(str);
    //             }

    //         }else if(endMap.get(key) > 1){

    //             for(Integer i=1 ; i <= endMap.get(key);i++){
    //                 System.debug('In Loop'+monthsVSdays.get(key));
                    
    //                 String str = String.Valueof(startYear) + '-' + String.ValueOf(dt.format('MMM')) +'-'+ i;
    //                 strdays.add(str);
    //             }

    //         }
    //         else{
    //             for(Integer i=1 ; i <= monthsVSdays.get(key);i++){
    //                 System.debug('In Loop'+monthsVSdays.get(key));
                    
    //                 String str = String.Valueof(startYear) + '-' + String.ValueOf(dt.format('MMM')) +'-'+ i;
    //                 strdays.add(str);
    //             }
    //         }
    //         }
    //         else{
    //             for(Integer i=startDays ; i <= endDays;i++){
    //                 System.debug('In Loop'+monthsVSdays.get(key));
                    
    //                 String str = String.Valueof(startYear) + '-' + String.ValueOf(dt.format('MMM')) +'-'+ i;
    //                 strdays.add(str);
    //             }
    //         }
            
            
    //         strDate.put(String.ValueOf(dt.format('MMM')),strdays);
    //     }
    //     System.debug('Map'+strDate);

    //     System.debug('StartDateNew'+startDateNew);
    //     System.debug('day'+ date.daysInMonth(startYear , startMonth));
    //     System.debug('startYear'+startYear);
    //     System.debug('startMonth'+startMonth);
    //     System.debug('startDays'+startDays);
    //     System.debug('EndDateNew'+endDateNew);
        
    //     get.monthAllValueWrapper = strDate;
    // }
    // else{
            Integer numberMonthsStart = (Date.valueOf(startDate)).monthsBetween(currentDate);
            Integer numberMonthsDue = (Date.valueOf(endDate)).monthsBetween(currentDate);
            startMap.put(startMonth,startDays);
            endMap.put(endMonth,endDays);

            List<date> dateList = new List<date>();

            for(Integer i = numberMonthsStart ; i>=numberMonthsDue ; i--){
                date newDate = date.today().addmonths(-i);
                System.debug('newDate :::>>>'+ newDate);
                dateList.add(newDate);
                
            }

            for(Date dt : dateList){
               Integer month = dt.month();
               Integer Year = dt.year();
               Integer temp1 = date.daysInMonth(Year , month);
               Datetime elseDt = Date.newInstance(Year,month,01);
               if((startMonth != endMonth && startYear == endYear) || (startMonth == endMonth && startYear != endYear) || (startMonth != endMonth && startYear != endYear)){
                if(dt.year() == startYear && dt.month() == startMonth){
                    for(Integer i=startDays ; i<=temp1 ; i++){
                        String str = String.Valueof(Year) + '-' + String.ValueOf(elseDt.format('MMM')) +'-'+ i;
                        dateStr.add(str);
                    }
                }else if(dt.year() == endYear && dt.month() == endMonth){
                    for(Integer i=1 ; i<=endDays ; i++){
                        String str = String.Valueof(Year) + '-' + String.ValueOf(elseDt.format('MMM')) +'-'+ i;
                        dateStr.add(str);
                    }
                }else{
                    for(Integer i=1 ; i<=temp1 ; i++){
                        String str = String.Valueof(Year) + '-' + String.ValueOf(elseDt.format('MMM')) +'-'+ i;
                        dateStr.add(str);
                    }
                }
               }else{
                for(Integer i=startDays ; i <= endDays;i++){
                                    // System.debug('In Loop'+monthsVSdays.get(key));
                                    
                                    String str = String.Valueof(startYear) + '-' + String.ValueOf(elseDt.format('MMM')) +'-'+ i;
                                    dateStr.add(str);
                                }
               }
               

            }
            get.monthAllValueWrapper = dateStr;
    // }


        return get;



        // try {
            // List<String> day31List = new List<String>{'Jan', 'Mar', 'May', 'Jul', 'Aug', 'Oct', 'Dec'};
            // List<String> day30List = new List<String>{'Apr', 'Jun', 'Sep', 'Nov'};
            // List<String> dayfebList = new List<String>{'Feb'};
            // List<Task> taskList = new List<Task>();
            // taskList = [SELECT Subject, TaskSubtype, AccountId, CreatedDate, OwnerId FROM Task WHERE Status =: 'Completed' AND AccountId =: recId AND CALENDAR_YEAR(CreatedDate) =: filter AND OwnerId =: ownerValue];

       		// System.debug('TaskList::>>>> '+taskList);
        
            // List<Event> eventList = new List<Event>();
            // eventList = [SELECT Subject, CreatedDate, OwnerId FROM Event WHERE AccountId =: recId AND CALENDAR_YEAR(CreatedDate) =: filter AND OwnerId =: ownerValue];
        
        	// System.debug('EventList:::>>> '+eventList);
            // List<Date> LastMonth1List = new List<Date>();
            // List<Date> FirstOfLastMonthList = new List<Date>();
            // List<integer> numberOfDaysList = new List<integer>();
            // List<String> lastMonthList = new List<String>();
            // Map<String,Integer> dateVsList = new Map<String, Integer>();

            // if(LastMonths == 6){
            //     for(integer i =1 ; i<=6 ; i++){
            //        date LastMonth1 = date.today().addmonths(-i);
            //        Datetime lastMonthDate = System.today().addMonths(-i);
            //        String lastMonth = lastMonthDate.format('MMM');

            //        LastMonth1List.add(LastMonth1);
            //        lastMonthList.add(lastMonth);



                //    System.debug('Months:::>>> '+ L)



            //     }
            //     System.debug('Months:::>>> '+ lastMonthList);
            //     for(date dt: LastMonth1List){
            //         date FirstOfLastMonth = date.newInstance(dt.year(), dt.month(), 1);
            //         FirstOfLastMonthList.add(FirstOfLastMonth);
            //     }
            //     System.debug('Monthsssss:::>>> '+ FirstOfLastMonthList);
            //     for(date dt1: FirstOfLastMonthList){
            //         integer numberOfDays = Date.daysInMonth(dt1.year(), dt1.month());
            //         numberOfDaysList.add(numberOfDays);
            //     }
            //     System.debug('Number of days '+ numberOfDaysList);
            // }




            //  LastMonth1 = date.today().addmonths(-1);
            //  FirstOfLastMonth = date.newInstance(Lastmonth1.year(), lastmonth1.month(), 1);
            //  numberOfDays = Date.daysInMonth(FirstOfLastMonth.year(), FirstOfLastMonth.month());

            
            // Datetime lastMonthDate = System.today().addMonths(-1);
            // String lastMonth = lastMonthDate.format('MMM');
            // Integer yearValue = lastMonthDate.year();




            // integer j = 0;
            // List<Map<String,Integer>> accountWrapper = new List<Map<String,Integer>>();
            // for(integer noOfDays : numberOfDaysList){
                
            //     if(j<numberOfDaysList.size()){
            //         for(integer i=1; i<=noOfDays; i++) {
            //     String dateValue = String.valueOf(filter) + '-' + lastMonthList[j] + '-' + String.valueOf(i);
            //     dateVsList.put(dateValue, 0);
            //     System.debug('dateVsList in loop:::>>'+dateVsList);
                
            //     }
                
            //     j = j + 1;



                // accountWrapper.add(dateVsList);
                
                

            // }
            // }
            // accountWrapper.add(dateVsList);







            
        	// System.debug('dateVsList:::>>'+dateVsList);






        //     Map<String, Integer> dayVsEmailCount = new Map<String,Integer>();
        //     Map<String, Integer> dayVsVoiceDrop = new Map<String, Integer>();
        //     Map<String, Integer> dayVsOutgoingCall = new Map<String, Integer>();
        //     Map<String, Integer> dayVsIncomingCall = new Map<String, Integer>();
        //     Map<String, Integer> dayVsMissedCall = new Map<String, Integer>();
        //     for(Task taskInfo : taskList) {
        //         DateTime dt = taskInfo.CreatedDate;
        //         Integer year = dt.year();
        //         String month = dt.format('MMM');
        //         Integer day = dt.day();
        //         String dateValue = String.valueOf(year) + '-' + month + '-' + String.valueOf(day);
        //         if(taskInfo.TaskSubtype == 'Email') {
        //             if(dayVsEmailCount != null) {
        //                 dayVsEmailCount.put(dateValue, dayVsEmailCount.get(dateValue) + 1);
        //             }
        //             else {
        //                 dayVsEmailCount.put(dateValue, 1);
        //             }
        //         }
        //         else if(taskInfo.TaskSubtype == 'Call') {
        //             if(taskInfo.tdc_cti__Disposition__c   != 'Left VM') {
        //                 if(dayVsVoiceDrop != null){
        //                     dayVsVoiceDrop.put(dateValue, dayVsVoiceDrop.get(dateValue) + 1);
        //                 }else{
        //                     dayVsVoiceDrop.put(dateValue, 1);
        //                 }
        //             }
        //             if(taskInfo.Subject.contains('Outgoing')){
        //                 if(dayVsOutgoingCall != null){
        //                     dayVsOutgoingCall.put(dateValue, dayVsOutgoingCall.get(dateValue) + 1);
        //                 }else{
        //                     dayVsOutgoingCall.put(dateValue, 1);
        //                 }
        //             }
        //             else if(taskInfo.Subject != null){
        //                 if(dayVsIncomingCall.containsKey(dateValue)){
        //                     dayVsIncomingCall.put(dateValue, dayVsIncomingCall.get(dateValue) + 1);
        //                 }else{
        //                     dayVsIncomingCall.put(dateValue, 1);
        //                 }
        //             }
        //             else if(taskInfo.Subject != null){
        //                 if(dayVsMissedCall.containsKey(dateValue)){
        //                     dayVsMissedCall.put(dateValue, dayVsMissedCall.get(dateValue) + 1);
        //                 }else{
        //                     dayVsMissedCall.put(dateValue, 1);
        //                 }
        //             }
        //         }
        //     }
        //     Map<String, List<Integer>> dateVsEngagement = new Map<String, List<Integer>>();
        //     for(String dateVsListKey : dateVsList.keySet()) {
        //         if(dayVsEmailCount.containsKey(dateVsListKey)) {
        //             dateVsEngagement.put(dateVsListKey, new List<Integer>{dayVsEmailCount.get(dateVsListKey)});
        //         }
        //         else {
        //             dateVsEngagement.put(dateVsListKey, new List<Integer>{dateVsList.get(dateVsListKey)});
        //         }
        //         if(dayVsVoiceDrop.containsKey(dateVsListKey)) {
        //             List<Integer> countList = new List<Integer>();
        //             countList.addAll(dateVsEngagement.get(dateVsListKey));
        //             countList.add(dayVsVoiceDrop.get(dateVsListKey));
        //             dateVsEngagement.put(dateVsListKey, countList);
        //         }
        //         else {
        //             dateVsEngagement.put(dateVsListKey, new List<Integer>{dateVsEngagement.get(dateVsListKey)[0], 0});
        //         }
        //         if(dayVsOutgoingCall.containsKey(dateVsListKey)) {
        //             List<Integer> countList = new List<Integer>();
        //             countList.addAll(dateVsEngagement.get(dateVsListKey));
        //             countList.add(dayVsOutgoingCall.get(dateVsListKey));
        //             dateVsEngagement.put(dateVsListKey, countList);
        //         }
        //         else {
        //             dateVsEngagement.put(dateVsListKey, new List<Integer>{dateVsEngagement.get(dateVsListKey)[0], dateVsEngagement.get(dateVsListKey)[1], 0});
        //         }
        //         if(dayVsIncomingCall.containsKey(dateVsListKey)) {
        //             List<Integer> countList = new List<Integer>();
        //             countList.addAll(dateVsEngagement.get(dateVsListKey));
        //             countList.add(dayVsIncomingCall.get(dateVsListKey));
        //             dateVsEngagement.put(dateVsListKey, countList);
        //         }
        //         else {
        //             dateVsEngagement.put(dateVsListKey, new List<Integer>{dateVsEngagement.get(dateVsListKey)[0], dateVsEngagement.get(dateVsListKey)[1], dateVsEngagement.get(dateVsListKey)[2], 0});
        //         }
        //         if(dayVsMissedCall.containsKey(dateVsListKey)) {
        //             List<Integer> countList = new List<Integer>();
        //             countList.addAll(dateVsEngagement.get(dateVsListKey));
        //             countList.add(dayVsMissedCall.get(dateVsListKey));
        //             dateVsEngagement.put(dateVsListKey, countList);
        //         }
        //         else {
        //             dateVsEngagement.put(dateVsListKey, new List<Integer>{dateVsEngagement.get(dateVsListKey)[0], dateVsEngagement.get(dateVsListKey)[1], dateVsEngagement.get(dateVsListKey)[2], dateVsEngagement.get(dateVsListKey)[3], 0});
        //         }
        //     }
        //     getDataWrapper getValues = new getDataWrapper();
        //     getValues.monthAllValueWrapper = dateVsEngagement;
        //     return getValues;
        // }
        // catch(Exception ex){
        //     System.debug('An Error ' + ex.getMessage() + 'In line No. ' + ex.getLineNumber());
        //     getDataWrapper value = new getDataWrapper();
        //     value.error = 'An Error ' + ex.getMessage() + 'In line No. ' + ex.getLineNumber();
        //     return value;
        // }
        // return null;
    }

    // public static getWrapper getOpportunityDetailes(Id recId, Integer filter, Id ownerValue) {
    //     try {
            
    //     }
    //     catch(Exception ex){
    //         System.debug('An Error ' + ex.getMessage() + 'In line No. ' + ex.getLineNumber());
    //     }
    // }

    // public static getWrapper getLeadDetailes(Id recId, Integer filter, Id ownerValue) {
    //     try {
            
    //     }
    //     catch(Exception ex){
    //         System.debug('An Error ' + ex.getMessage() + 'In line No. ' + ex.getLineNumber());
    //     }
    // }

    public class getDataWrapper {
        // @AuraEnabled
        // public  Map<String, List<String>> monthAllValueWrapper;
        @AuraEnabled
        public List<String> monthAllValueWrapper;
        @AuraEnabled
        public List<Map<String,Integer>> test;
        @AuraEnabled
        public  String error;
    }
}