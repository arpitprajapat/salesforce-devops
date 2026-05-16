public class BatchClass implements Database.Batchable<sObject>{
    
    public static Database.QueryLocator start(Database.BatchableContext context){
        
        //   string strquery = 'SELECT Id,Prior_status__c,Name,Country__c, Status__c FROM Ticket__c Where Status__c = 'A'';
        //system.debug('---strquery----'+strquery);
        
        return Database.getQueryLocator([SELECT Id,Prior_status__c,Name,Country__c, Status__c FROM Ticket__c Where Status__c = 'A']);
    }
    public void execute(Database.BatchableContext context, List<Ticket__c> Scope){
        
        list<Ticket__c> lstTicket = new list<Ticket__c>();
        for(Ticket__c Tic : Scope){
            system.debug('----Tic-----'+Tic);
            
            Tic.Prior_status__c = Tic.Status__c;
            Tic.Status__c = 'C';
            lstTicket.add(Tic);
            
            system.debug('----Tic.Status__c-----'+Tic.Status__c);
        }
        update lstTicket;
    }
    public void finish(Database.BatchableContext context){
        
        system.debug('----Finish------');
    }
}