public class LeadTriggerHandler {
    
    public static void HandleactiviesAfterInsert(List<Lead> leadRecords){
        List<Task> TasklistToInsert = new List<Task>();
         for(SObject obj : Trigger.New){ 
           Lead leadRec = (Lead)obj; 
        // for (Lead leadRec : Trigger.new){
            Task TaskRecord = new Task();
            TaskRecord.Priority ='High';
            TaskRecord.OwnerId = leadRec.OwnerId;
            TaskRecord.Description = 'Follow up with the new lead';
            TaskRecord.Status = 'Not started';
              TaskRecord.Subject = 'Follow Up';
            TaskRecord.WhoId = leadRec.Id;
            TasklistToInsert.add(TaskRecord);
        }
        if(!TasklistToInsert.isEmpty()){
            insert TasklistToInsert;
        }
    }
}