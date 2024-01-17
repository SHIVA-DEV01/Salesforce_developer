public class DocusignTestController {
    @AuraEnabled(cacheable=true)
    public static String generateSendingURL() {
        // Add your logic to construct the URL here
        // For example:
        String sitePrefix = URL.getSalesforceBaseUrl().toExternalForm();
        String url;
        
        if (sitePrefix == '/s/') {
            System.debug('Inside If >>>>>> '+ sitePrefix);
            //url = '/apex/dfsle__sending?sId=' + quoteId + '&sendingExperience=null&isEmbedded=false&templateId=a7HDh0000000bWqMAI&recordId=' + quoteId + '&title=Send for E-Sign';
        } else {
            System.debug('Inside else >>>>>>> '+ sitePrefix);
            //url = sitePrefix + '/apex/dfsle__sending?sId=' + quoteId + '&sendingExperience=null&isEmbedded=false&templateId=a7HDh0000000bWqMAI&recordId=' + quoteId + '&title=Send for E-Sign';
        }
        
        return url;
    }
}