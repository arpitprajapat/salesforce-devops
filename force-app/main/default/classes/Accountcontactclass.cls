public class Accountcontactclass {
    
    public static void UpdateContactMethod(){
        
        list<Contact> conList = [select id, Email from contact limit 2];
        system.debug('conList '+conList);
        for(Contact con : conList ){
            system.debug('line 8'+con);
            con.Email = 'arpit@123.com';
            system.debug('line 11'+con);
        }
        Update conList;
        
    }
    
    
    public static void UpdateAccountMethod(){
        list<Account> accList = [select id, Email__c from Account limit 2];
        
        for(Account acc : accList){
            system.debug('line 18'+acc);
            acc.Email__c = 'arpit@gmail.com';
            system.debug('line 23'+acc);
            
            
        }
        Update accList;   
    }  
    public static void UpdateAkshay()
    {
        list<Account> account1 = [SELECT Id, Name FROM Account WHERE Name = 'Akshay'];
        
        for(Account acc : account1){
            system.debug('line 31'+acc);
            acc.Name = 'Test contact akshay';
            system.debug('line 33'+acc);
            Update account1;
        } 
    }
    public static void UpdateNullEmail()
    {
        list<Account> account2 = [SELECT Id, Name, Email__c FROM Account WHERE Email__c= null limit 3];
        
        for(account acc : account2){
            acc.Email__c = 'Indore@123.com';
            system.debug('line 43'+acc);
            update account2;
        }
    }
    public static void InsertAllRecordInAccount(){
        
        list<Account> accList = [select id ,Email__c,  Name from account limit 3];
        list<Contact> contList = [select id ,  Name from contact limit 3];
        
        list<Account> acc1 = new list<Account>();
        list<Contact> acc2 = new list<Contact>();

        acc1.addAll(accList);
        system.debug('line 58');
        acc2.addAll(contList);
        system.debug('line 60');
        insert acc2;
        insert acc1;
    }
}