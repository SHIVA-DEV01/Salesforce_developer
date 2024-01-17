public class VfPageQuestion2Controller {
	public string selectedname{get; set;}
    Public List<Selectoption> getselectedfields(){
        	Integer i =0 ;
        	List<Selectoption> lstname = new List<selectoption>();
        	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(String str: gd.keySet()){
            if(i<1000){
               lstname.add(new selectoption(string.valueof(str),string.valueof(gd.get(str))));
            }
            	i=i+1;
        }
        System.debug(lstname);
            return lstname; 
    }
    
    
        public void ShowTable()  
    {  
       
    } 
}