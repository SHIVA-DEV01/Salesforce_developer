public class ChatGPTController {

    private static String CHAT_GPT_KEY = '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'; 
    private static final String ENDPOINT ='https://api.openai.com/v1/chat/completions';

    @AuraEnabled
    public static String getQueryData(String searchString){
        try{
            String seachQueryEscaped = (searchString).trim();
            Http http = new Http();
            String reqBody = '{"model": "gpt-3.5-turbo","messages": [{"role": "user", "content":  "'+ seachQueryEscaped +'"}]}';
            System.debug('Query '+seachQueryEscaped+' '+reqBody);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes(CHAT_GPT_KEY).trim());
            //Setting timeout to max 120 second to get whole response from Chat GPT Open API
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            // Set the body as a JSON object
            request.setBody(reqBody);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }
            return response.getBody();
        }catch(Exception ex){
            System.debug('Exception in Catch of Server-Side Controller '+ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }


}