public class AccountTriggerHandler {
    public static void handleUpdateBeforeActivities(List<Account> newRecords, Map<Id, Account> oldMap){
        for(Account accRecord : newRecords){
            if(accRecord.Industry == 'Agriculture' && accRecord.Type == 'Prospect') {
                
                system.debug('----accRecord.Industry---'+accRecord.Industry);
                system.debug('----accRecord.Industry---'+accRecord.Type);
                if(oldMap.get(accRecord.Id).Ownership == 'Private' && accRecord.Ownership != oldMap.get(accRecord.Id).Ownership){
                    system.debug('----accRecord.Ownership---'+accRecord.Ownership); 
                    accRecord.addError('Ownership cannot be modified once set to Private');
                }
            }
        }
    }
    public static void handleUpdateAfterActivities(List<Account> newRecords, Map<Id, Account> oldMap){
        list<Account> addAccToUpdateChildern = new list<Account>();
        list<Id> addAccIdList = new list<Id>();

        for(Account acc : newRecords){
            if(acc.Website != oldMap.get(acc.Id).Website){
                addAccToUpdateChildern.add(acc);
                addAccIdList.add(acc.Id);
            }
        }
        if(addAccToUpdateChildern.size() > 0 ){
            List<Contact> conRecords = [Select Id , FirstName From Contact WHERE AccountId In : addAccIdList];
            for(Contact con : conRecords){
                con.Website__c	= 'Test';
            }
        }
    }
}