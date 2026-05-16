public with sharing class ContactCaseControllerClass {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getCasesByContactIdApexMethod(Id contactId) {
        List<Map<String, Object>> results = new List<Map<String, Object>>();

        for (Case c : [
            SELECT Id, CaseNumber, ContactId, SuppliedName, SuppliedPhone, SuppliedEmail,
                   SuppliedCompany, Type, Reason, Status, Priority, Origin, Subject,
                   Product__c, EngineeringReqNumber__c, Description, Comments,
                   PotentialLiability__c, SLAViolation__c
            FROM Case
            WHERE ContactId = :contactId
        ]) {
            results.add(new Map<String, Object>{
                'Id' => c.Id,
                'caseUrl' => c.Id,
                'CaseNumber' => c.CaseNumber,
                'Status' => c.Status,
                'Origin' => c.Origin,
                'SuppliedName' => c.SuppliedName,
                'SuppliedPhone' => c.SuppliedPhone,
                'SuppliedEmail' => c.SuppliedEmail,
                'SuppliedCompany' => c.SuppliedCompany,
                'Type' => c.Type,
                'Reason' => c.Reason,
                'Product__c' => c.Product__c,
                'EngineeringReqNumber__c' => c.EngineeringReqNumber__c,
                'Subject' => c.Subject,
                'Description' => c.Description,
                'Comments' => c.Comments,
                'PotentialLiability__c' => c.PotentialLiability__c,
                'SLAViolation__c' => c.SLAViolation__c,
                'Comments' => c.Comments,
                'RecordType' => 'Case'
            });
        }

        for (Component__c comp : [
            SELECT Id, Name, Status__c, Priority__c, CompOrigin__c, Contact__c
            FROM Component__c
            WHERE Contact__c = :contactId
        ]) {
            results.add(new Map<String, Object>{
                'Id' => comp.Id,
                'caseUrl' => '/' + comp.Id,
                'CaseNumber' => comp.Name, 
                'Status' => comp.Status__c,
                'CompOrigin__c' => comp.CompOrigin__c,
                'Priority' => comp.Priority__c,
                'RecordType' => 'Component'
            });
        }

        return results;
    }
}