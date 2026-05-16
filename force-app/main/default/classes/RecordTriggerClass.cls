public class RecordTriggerClass {
    
    public class FlowInput {
        @InvocableVariable(required=true)
        public Id headerId;
        
        @InvocableVariable(required=false)
        public Ticket__c ticket;
    }
    @InvocableMethod(label='Create Header' description='Call Apex from Record-Triggered Flow')
    public static void invokeMyFlow(List<FlowInput> inputs) {
        System.debug('-----line 10 ----');
        
        for (FlowInput Flow : inputs) {
            System.debug('---Flow---' + Flow);
            system.debug('---inputs--'+inputs);
            
            Map<String, Object> newMap = new Map<String, Object>();
            newMap.put('recordId', Flow.headerId);
            System.debug('----newMap----' + newMap);
            
            Ticket__c tic = Flow.ticket;  
            System.debug('----Ticket-----' + tic);
            
            if (tic != null) {
                newMap.put('ticketId', tic.Id);
                newMap.put('ticketName', tic.Name);
                newMap.put('ticketStatus', tic.Status__c);
            }
            System.debug('----headerId-----' + Flow.headerId);
        }
    }
}