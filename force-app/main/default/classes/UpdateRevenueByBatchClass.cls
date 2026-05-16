public class UpdateRevenueByBatchClass implements Database.Batchable<sObject>{
    
    public static Database.QueryLocator start(Database.BatchableContext context){
        String query = 'SELECT Id, Name, AnnualRevenue FROM Account WHERE Id = \'001IR000020nqmgYAA\'';
        system.debug('---query----'+query);
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext context, List<Account> Scope){
        
        list<Account> accList = new list<Account>();
        system.debug('------accList----'+accList);
        for(Account acc : scope){
            system.debug('---acc-----'+acc);
            
            if(acc.AnnualRevenue != Null){
                
                acc.AnnualRevenue += 50;
            }else
            {
                acc.AnnualRevenue = 50;
            }
            accList.add(acc);
            system.debug('------accList---'+accList);
            
        }
        if(!accList.isEmpty()) {
            update accList;
        }
        
    }
    public void finish(Database.BatchableContext context){
        system.debug('finish method called.');
    }
}