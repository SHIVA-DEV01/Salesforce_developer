public class ContentDownloadHandlerFactoryImpl implements Sfc.ContentDownloadHandlerFactory {
    public Sfc.ContentDownloadHandler getContentDownloadHandler( List<ID> listIds, Sfc.ContentDownloadContext context ) {
    
        Sfc.ContentDownloadHandler contentDownloadHandler = new Sfc.ContentDownloadHandler();
        
        /* To Prevent downloading it from Mobile */
        if ( context == Sfc.ContentDownloadContext.MOBILE ) {
        
            contentDownloadHandler.isDownloadAllowed = false;
            contentDownloadHandler.downloadErrorMessage = 'Downloading a file from a mobile device is not allowed.';
            return contentDownloadHandler;
        
        }
    
        contentDownloadHandler.isDownloadAllowed = true;
        return contentDownloadHandler;
    
    }
}