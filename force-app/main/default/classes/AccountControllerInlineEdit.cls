public with sharing class AccountControllerInlineEdit {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, Phone FROM Account LIMIT 10];
    }
    @AuraEnabled
    public static void updateAccounts(List<Account> accountsToUpdate) {
        update accountsToUpdate;
    }
}