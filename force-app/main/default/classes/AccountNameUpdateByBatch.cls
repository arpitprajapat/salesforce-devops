global class AccountNameUpdateByBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name FROM Account WHERE Name = \'Account Updated By Batch Account Updated By Batchsalesforce developer\'';
        System.debug('---- Running query: ' + query);
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        if (scope.isEmpty()) {
            System.debug('No matching accounts found.');
            return;
        }

        for (Account acc : scope) {
            acc.Name = ' update by batch class'; 
            System.debug('Updated Account Name to: ' + acc.Name + ' for Id: ' + acc.Id);
        }

        update scope;
        System.debug('Updated ' + scope.size() + ' Account record(s).');
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch job finished.');
    }
}