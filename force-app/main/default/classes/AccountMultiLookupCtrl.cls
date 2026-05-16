// public class AccountMultiLookupCtrl {

//     @AuraEnabled(cacheable=true)
//     public static List<AccountResult> searchAccounts(String searchKey) {
//         if (String.isBlank(searchKey)) {
//             return new List<AccountResult>();
//         }

//         List<Account> accts = [
//             SELECT Id, Name
//             FROM Account
//             WHERE Name LIKE :( '%' + searchKey + '%' )
//             ORDER BY Name
//         ];
//         system.debug('------accts----'+accts);
//         List<AccountResult> results = new List<AccountResult>();
//         for (Account a : accts) {
//             AccountResult ar = new AccountResult();
//             ar.recordId = a.Id;
//             ar.title = a.Name;
//             results.add(ar);
//         }
//         return results;
//     }

//     public class AccountResult {
//         @AuraEnabled public Id recordId;
//         @AuraEnabled public String title;
//     }
// }


public class AccountMultiLookupCtrl {

    @AuraEnabled(cacheable=true)
    public static List<AccountResult> searchAccounts(String searchKey) {
        if (String.isBlank(searchKey)) {
            return new List<AccountResult>();
        }

        List<Account> accts = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE :( '%' + searchKey + '%' )
            ORDER BY Name
        ];
        system.debug('------accts----'+accts);
        List<AccountResult> results = new List<AccountResult>();
        for (Account a : accts) {
            AccountResult ar = new AccountResult();
            ar.recordId = a.Id;
            ar.title = a.Name;
            results.add(ar);
        }
        return results;
    }

    @AuraEnabled
    public static String saveSelectedAccounts(Id parentId, List<Id> accountIds) {
        System.debug('Parent Account: ' + parentId);
        System.debug('Selected Accounts: ' + accountIds);
        
        return ' SUCCESS: ' + accountIds.size() + ' accounts logged for Account ' + parentId;
    }

    public class AccountResult {
        @AuraEnabled public Id recordId;
        @AuraEnabled public String title;
    }
}