public class DeleteAccountCountScheduleJobs {
    Public static void accountCountDeleteJob(){
        List<cronTrigger> cron = [Select id , cronjobdetail.Name from cronTrigger where cronjobdetail.name Like 'Account Count%'];
        for(cronTrigger job : cron){
            System.abortJob(job.Id);
        }
    }
}