public class DemoTest implements Database.batchable<Sobject>{  
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id , Name FROM Account');
    }
    
    public void execute(Database.BatchableContext bc,List<Account>subListFromStartMethod){
        for(Account acc: subListFromStartMethod){
            acc.Name = 'Account Updated By Batch ' +acc.Name;
        }
            Update subListFromStartMethod;
            }
            
            public void  finish(Database.BatchableContext bc){
                System.debug('Batch Completed');	
            }     
   }