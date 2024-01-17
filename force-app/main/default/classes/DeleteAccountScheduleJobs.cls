public class DeleteAccountScheduleJobs {
        public static void jobDelete(){
        crontrigger con=[select id,cronjobdetail.name from crontrigger where cronjobdetail.name='Batch Schedule'];
        system.abortJob(con.id);
    }
}