public class Updateclass {
    
    public static void UpdateMethod(){
        
        List<String> lstAccountName = new List<String>{};
            for(Account  acc : [select Id,Name from Account limit 5]){
                lstAccountName.add(acc.Name);   		
                system.debug('line 8'+lstAccountName);
            }     
        
        List<Contact> conList = [select id,Name,Account.Email__c, Account.Name,Account.Id from contact where Account.Name In : lstAccountName];
        system.debug('-line 11-'+conList.size());
        
        
        list<Account> accList = [SELECT Name,Email__c , (SELECT FirstName, Email , LastName FROM Contacts ) FROM Account Limit 5];
        list<Contact> conlist1 = new list<Contact>();
        for(Account acc : accList){
             system.debug('line 15'+acc.Name);
            system.debug('line Contacts'+acc.Contacts);
            for(Contact con : acc.Contacts)
            {
                system.debug('line 21'+con);
				con.Email = acc.Email__c;
                conlist1.add(con);
            }			
        }
        update conlist1;
     
        
        
       /* for(Contact con : conList){
            con.Phone = '98989898';
            con.Email = 'sf@gmail.com';
            system.debug('line 18'+con); 
        }
        update conList;*/
    }
}