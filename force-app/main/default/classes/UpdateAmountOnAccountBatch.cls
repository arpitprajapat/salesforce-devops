public class UpdateAmountOnAccountBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc)    {
        String query = 'SELECT Id, Name FROM Account WHERE Id IN (\'001IR00001riWn3YAE\',\'001IR00001phbf2YAA\')';
        
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,List<Account> acclist)
        // public void execute(Database.BatchableContext Bc, List<Account> acclist)
    {
        set<Id> setOfAcc = new set<Id>();
        for(Account acc : acclist){
            system.debug('---- line 13 acc ----'+acc);
            setOfAcc.add(acc.Id);
        }
        map<id,decimal> Map1 = new map <id,decimal>();
        
        
        for(Contact con : [select id ,Amount__c, LastName ,AccountId FROM Contact where AccountId IN : acclist])
        {
            system.debug('---- line 20 ----'+con);
            
            // con1 -> Amount,LastName,AccountId -> 100,con1,XYZ
            // con2 -> Amount,LastName,AccountId -> 200,con1,ABC
            // con3 -> Amount,LastName,AccountId -> 300,con1,XYZ
            
            if(Map1.containsKey(con.AccountId)){ 			// MAP -> XYZ 
                decimal getAmount = Map1.get(con.AccountId);
                getAmount = getAmount + con.Amount__c;
                system.debug('----getAmount---'+getAmount);
                Map1.put(con.AccountId,getAmount);
                system.debug('---Map1---'+Map1);  // xyz -> 100        // 400 , 900
            }
            else{
                Map1.put(con.AccountId,con.Amount__c);   // MAP 
                // XYZ -> 100
                system.debug('----map1 -----'+Map1);			// ABC  -> 200
            }
    }
        list<Account> newlist = new list<Account>();
        for(Account acc : acclist){
            acc.Amount__c = Map1.get(acc.Id);
            newlist.add(acc);
            system.debug('--acclist line 43---'+newlist);   // 400 , 900
        }
             update newlist;
  }
    public void finish(Database.BatchableContext bc){
        
   }
}