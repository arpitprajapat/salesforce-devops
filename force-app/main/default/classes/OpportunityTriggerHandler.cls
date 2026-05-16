public class OpportunityTriggerHandler {
    
    // whenever an opportunity is closed won create a task for the opportunity owner to 
    // split the revenue among the team with high priority.
    
    public static void handlerActivitiesBeforeUpdate(List<Opportunity> newRecords , List<Opportunity> oldRecords){
        
        for(Opportunity NewOpp : newRecords){
            for(Opportunity OldOpp : oldRecords){
                
                if(NewOpp.Id == OldOpp.Id && NewOpp.StageName != OldOpp.StageName){
                    system.debug('StageName has been modified.' + OldOpp.StageName+' to ' + NewOpp.StageName);
                    system.debug('--NewOpp.Id--'+NewOpp.Id);
                    system.debug('--NewOpp.Id--'+OldOpp.Id);
                    NewOpp.Amount = NewOpp.Probability * NewOpp.ExpectedRevenue;
                }
                
            }
        }
    }
    public static void handlerActivitiesAfterUpdate(List<Opportunity> newRecords){
        //system.debug('--line 8----');
        List<Task> taskListToInsert = New List<Task>();
        //  system.debug('--line 10-- ');
        for(Opportunity opp : newRecords){
            //  system.debug('--line 12---');
            if(opp.StageName == 'Closed Won'){
                system.debug('--line 14--');
                //Create a related record Task Recordss
                
                Task taskRecord = new Task();
                system.debug('--line 18--');
                taskRecord.Priority = 'High';
                system.debug('--line 20--');
                taskRecord.OwnerId = opp.OwnerId;
                system.debug('--line 22--');
                taskRecord.Description = 'Please split the revenue amongst the team members';
                system.debug('--line 24--');
                taskRecord.Status = 'Not Started';
                system.debug('--line 26--');
                taskRecord.Subject = 'Split Revenue';
                system.debug('--line 28--');
                taskRecord.WhatId = opp.Id;
                system.debug('--line 30--');
                taskListToInsert.add(taskRecord);
            }
        }
        if (taskListToInsert.isEmpty())
            insert taskListToInsert;
    }
}