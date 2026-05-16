public class Apexclass {
    
    public static void demoMethod(){
        string s = 'salesforce';
        primitiveMethod(s);
        
        system.debug('salesforce : '+s);
    }
    
    public static void primitiveMethod(string myString){
        system.debug('line 10--:'+myString);
        // query account 10
        
        List<Account> account = [select id,phone from Account LIMIT 10];
        
        for(Account acc : account) {
            
            acc.phone = '8605405655';
            system.debug('update phone : '+acc);
            
        }
        
        update account;
        
        // update phone;
        // phone update
        // dml
        // 
    }
    
    
    // insrt
    public void insertAccount(){
        List<Account> account = new List<Account>();
        account acc = new Account(Name ='akshay');
        account.add(acc);
        insert Account;
        // updateAccount();
        
    }
    
    public void updateAccount(){
        
        List<Account> account = [select Name,Phone from Account limit 10];
        for(Account acc : account){
            system.debug('account:'+acc);
            acc.phone = '1234567890';
            system.debug('line 48 : '+acc);
            
            update acc;
            
        }
        
    }
    
    public void deleteAccount(){
        
    }
    
    public void insertAccountAndContact(){
        list<account> lstaccount = new list<account>();
        
        account acc = new Account(Name ='akshay');
        
        lstaccount.add(acc);
        
        insert lstaccount;
        
        system.debug('insert account'+lstaccount);
        
        contact con = new contact();
        con.lastname ='AAA';
        con.AccountId = lstaccount[0].id;
        insert con;
        system.debug('insert con'+con);
    }
    
    
    public static void  updateAccountAndContact(){
        list<account> acclist = new list<account>(); // []
        
        for(Integer i= 0 ; i<=2 ; i++){ // 151 
            account acc = new account();
            //acc.Email ='khusi@123';
            acc.Name ='Akshay';
            acc.Phone ='75666';
            acclist.add(acc); //[acc -> name Phone,acc-> name,Phone]
       //     system.debug('size of list '+acclist.size());
         //   system.debug('line 76 '+acc);
           
        }
        insert acclist;
        
        for(Account lstAcc :  acclist){
            system.debug('line 95');
            for(Integer i= 0 ; i<=10 ; i++){
                system.debug('line 96');
                
                contact con = new contact();
                con.lastname = 'Tcs';
                con.AccountId = lstAcc.id;
                insert con;
                system.debug('line 81'+con);
            }
        }
        
    }
}