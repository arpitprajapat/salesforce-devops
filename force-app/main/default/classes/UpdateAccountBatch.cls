global class UpdateAccountBatch implements Database.batchable<Sobject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id, Name FROM Account WHERE Id IN (\'001IR00001riWn3YAE\', \'001IR00001phbf2YAA\', \'001IR00001phbf0YAA\')';
        
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Account> scope)
    {
        set<Id> setOfAccId = new set<Id>();
        for(Account a : scope)
        {
            setOfAccId.add(a.Id);
        }
        
        map<id , Integer> map1 = new map<id, Integer>{};
            
            for(contact con :[select Id ,Amount__c,LastName,  Account.Name ,AccountId FROM Contact where AccountId In:setOfAccId]){
                system.debug('-----'+con.LastName);
                
                Decimal DecimalToInteger = con.Amount__c;       // convert
                Integer ConvertInteger = DecimalToInteger.intValue();
                System.debug('Convert Decimal to Integer: ' + ConvertInteger);
                
                map1.put(con.AccountId, ConvertInteger);  // we are putting accout id and contact amount field
                System.debug('map1'+map1);
                
                integer getAmount = map1.get(con.AccountId); // getting amount of contact
                system.debug('getAmount'+getAmount);
                
                getAmount += getAmount;  				
                System.debug('Sum of contact '+getAmount);
                
            }   
        Update scope;
        system.debug('-scope---'+scope);
        system.debug('-scopesize---'+scope.size());
    }
    
    global void finish(Database.BatchableContext BC) {
    }   
}