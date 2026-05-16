public class assignmentClass {
	@AuraEnabled(cacheable=true)
	Public static List<Account>getAccList(){
		return [select Name from Account  limit 50];
	}
}