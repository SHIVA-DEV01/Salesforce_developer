public class Scripting_3_Part_2 {
    public static void diffBetweenDay(){
        DateTime startDate = DateTime.newInstance(2016, 01, 02, 06, 07, 55);
		DateTime endDate = DateTime.newInstance(2016, 02, 05, 07, 08, 55);
 
		Decimal days = Integer.valueOf(endDate.day() - startDate.day());
        Decimal months = Integer.valueOf(endDate.month() - startDate.month());
        Decimal years = Integer.valueOf(endDate.year() - startDate.year());
        Decimal hours = Integer.valueOf(endDate.hour() - startDate.hour());
        Decimal minutes = Integer.valueOf(endDate.minute() - startDate.minute());
        Decimal seconds = Integer.valueOf(endDate.second() - startDate.second());
		System.debug('DD/MM/YY H:M:S ------> ' + days +'/'+months+'/'+years+' '+hours+':'+minutes+':'+seconds);
        
    }
}