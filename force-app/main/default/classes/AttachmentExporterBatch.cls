public class AttachmentExporterBatch implements Database.Batchable<SObject> {
    private String objectname;
    private String startdate;
    private String enddate;
    private String filter;

    public AttachmentExporterBatch(String objectname, String startdate, String enddate, String filter) {
        this.objectname = objectname;
        this.startdate = startdate;
        this.enddate = enddate;
        this.filter = filter;
    }

    public Database.QueryLocator start(Database.BatchableContext context) {
        List<Attachment> attachmentlist = New List<Attachment>() ;
        Datetime stdt = (Date)JSON.deserialize('"' + this.startdate + '"', Date.class);
        Datetime enddt =(Date)JSON.deserialize('"' + this.enddate + '"', Date.class);
        String querydata = 'SELECT Id, Name, Body, ContentType, ParentId FROM Attachment ';
        if(filter == 'CUSTOM_DATE'){
            return Database.getQueryLocator(querydata += 'WHERE Parent.Type =: this.objectname and Createddate >=: stdt and Createddate <=: enddt limit 49999');
        }else if(filter == 'ALL'){
            return Database.getQueryLocator(querydata += 'WHERE Parent.Type =: this.objectname limit 49999');
        }else{
            return Database.getQueryLocator(querydata += 'WHERE Parent.Type =: this.objectname and Createddate = '+this.filter+' limit 49999');
        }
    }

    public void execute(Database.BatchableContext context, List<Attachment> scope) {
        // Process records in the scope based on your logic.
        // You can use objectname, startdate, enddate, and filter here.
        System.debug(scope);
    }

    public void finish(Database.BatchableContext context) {
        // Perform any cleanup or finalization tasks here.
    }
}