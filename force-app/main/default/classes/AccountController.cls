public class AccountController {
	@AuraEnabled(cacheable=true)
	Public static List<Account>getAccList(){
		return [ select id , Name from Account limit 10];
	}
}