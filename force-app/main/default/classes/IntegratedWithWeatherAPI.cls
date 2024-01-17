public with sharing class IntegratedWithWeatherAPI {
    @auraEnabled
    public static String getWeatherReport(String userLocation){
        HttpRequest httpReq = new HttpRequest();

        System.debug('latitude'+userLocation);
        String endpoint_URL = 'https://api.weatherapi.com/v1/forecast.json?q='+userLocation+'&days=7&aqi=Yes&alert=Yes';
        httpReq.setEndpoint(endpoint_URL);
        httpReq.setMethod('GET');
        httpReq.setHeader('key', 'a522508de26e45dcb2362823233105');

        Http http = new Http();

        try{
            HttpResponse response = http.send(httpReq);
            if(response.getStatusCode() == 200){
                String temp1 = String.valueOf(response.getBody());
                return String.valueOf(temp1);

            }
            return null;
        }catch(System.CalloutException ex){
            System.debug(' CalloutException Executed'+ ex.getStackTraceString());
           	System.debug(' CalloutException Executed'+ ex.getmessage());
            return null;
        }catch(System.Exception ex){
            System.debug(' System.Exception Executed'+ ex.getStackTraceString());
            return null;
        }
    }
}