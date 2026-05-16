public class BatchForOpportunity implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    public static Database.QueryLocator start(Database.BatchableContext context){
        string query = 'select Id ,  name , stageName from Opportunity where StageName = \'Perception Analysis\' and CloseDate < Last_N_Days:7';
        system.debug('---query----'+query);
        system.debug('start method callled');
        
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext context, List<Opportunity> Scope){
        for(opportunity opp : scope){
            system.debug('----opp----'+opp);
            system.debug('-------opp.Name------'+opp.Name); 
        }
    }
    public void finish(Database.BatchableContext context){
        system.debug('finish method called.');
    }
}