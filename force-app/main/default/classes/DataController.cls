public with sharing class DataController {
    @AuraEnabled (cacheable=true)
    public static List<Account> retrieveAccounts(){
        return [SELECT Id, Name, Industry, Phone FROM Account limit 50];
    }
}