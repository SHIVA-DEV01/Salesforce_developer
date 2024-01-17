public class brain31 {
    public static void createPassWithSection(){
        List<Passenger__c> passList = new List<Passenger__c>();
        List<Flight__c> flightList = new List<Flight__c>();
        List<Flight_Passenger__c> flyPassList = new List<Flight_Passenger__c>();
        for(Integer i=0;i<9;i++){
            Passenger__c passe = new Passenger__c();
            passe.Name = 'Passenger'+i;
            passe.D_O_B__c = date.parse('08/09/2022');
            passe.Age_Group__c = 'Adult';
            passList.add(passe);
        }
        insert passList;
        
        for(Integer i=0;i<3;i++){
            Flight__c fly = new Flight__c();
            fly.Capacity__c = 9*i;
            flightList.add(fly);
        }
        insert flightList;
        
        for(Flight__c fly : flightList){
            integer i = 0;
            for(Passenger__c pass: passList){
                Flight_Passenger__c flyPass = new Flight_Passenger__c();
                if(i<3){
                    flyPass.Flight__c = fly.Id;
                	flyPass.Passenger__c = pass.Id;
                	flyPass.Section__c = 'First Class';
                    flyPassList.add(flyPass);
                }
                else if(i<6){
                    flyPass.Flight__c = fly.Id;
                	flyPass.Passenger__c = pass.Id;
                	flyPass.Section__c = 'Business Class';
                    flyPassList.add(flyPass);
                }
                else{
                    flyPass.Flight__c = fly.Id;
                	flyPass.Passenger__c = pass.Id;
                	flyPass.Section__c = 'Economy Class';
                    flyPassList.add(flyPass);
                }
                i = i + 1;
                
            }
        }
        insert flyPassList;
    }
}