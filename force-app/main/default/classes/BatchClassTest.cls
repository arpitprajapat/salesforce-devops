@isTest
public class BatchClassTest {
    
    @isTest
    static void testBatchClass() {
        
        // STEP 1 - Insert Parent Record first
        Header__c parentHeader = new Header__c();
        parentHeader.Name = 'Test Header';  
        // add any required fields of Header__c object here
        insert parentHeader;
        
        // STEP 2 - Assign Parent Id to Ticket
        Ticket__c t = new Ticket__c();
        t.Status__c = 'A';
        t.Country__c = 'India';
        t.Header__c = parentHeader.Id; 
        insert t;
        
    }
}