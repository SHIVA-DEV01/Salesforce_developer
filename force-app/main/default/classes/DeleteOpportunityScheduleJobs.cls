public class DeleteOpportunityScheduleJobs {
    public static void opportunityJobsDelete(){
        List<cronTrigger> cronTri = [Select id from cronTrigger where cronjobdetail.Name = 'Create Opportunity Schedule 1' OR cronjobdetail.Name = 'Create Opportunity Schedule'];
        for(cronTrigger job : cronTri){
        system.abortJob(job.id);
        }
    }
}