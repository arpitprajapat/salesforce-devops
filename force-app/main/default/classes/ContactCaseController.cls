public with sharing class ContactCaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCasesByContactId(Id contactId) {
        return [
            SELECT Id, CaseNumber, Subject, Status FROM Case WHERE ContactId = :contactId
        ];
    }
}