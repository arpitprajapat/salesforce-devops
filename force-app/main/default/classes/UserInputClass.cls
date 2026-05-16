public class UserInputClass {

    @AuraEnabled(cacheable=true)
    public static List<Account> UserInput(String Name , String Email) {

       System.debug('----Name----'+Name);
       System.debug('----Email----'+Email);
        List<Account> lstAc = [SELECT Id, Name,Email__c FROM Account WHERE Name LIKE :('%' + Name + '%') And Email__c LIKE :('%' + Email + '%') ];
        System.debug('--lstAc---'+lstAc);
        return lstAc;
    }
}