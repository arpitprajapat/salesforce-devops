public class changeRecordClass {
	@AuraEnabled()
	Public static List<Account>getAccountlist(){
		System.debug('---line 4-----');
		return [select id ,Name from Account  limit 10];
	}
}