public class UpdateNumberTriggerHandler {
    
    public static void UpdateAccountNumberField(List<Account> newAccList){
        
    system.debug('--line 5--'+newAccList);
        
    for(Account acc : newAccList){
        if(acc.Industry != null){
            acc.AccountNumber = '12345';
        }
        else{
              acc.AccountNumber = '6789';
    	    }
	    }

	}
}