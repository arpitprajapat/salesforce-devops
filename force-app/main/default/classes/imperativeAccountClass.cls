public class imperativeAccountClass {
	@AuraEnabled()
	Public static List<Account>getAccountlist(){
		System.debug('--------');
		return [select id ,Name from Account  limit 10];
	}
}