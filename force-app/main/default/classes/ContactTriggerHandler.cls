public class ContactTriggerHandler {
    
    public static void handleBeforeInsert(list<Contact> newRecords){
        
        for(Contact conRec : newRecords){
            
            if(conRec.AccountId == NULL){
                conRec.addError('Parent Information is mandatory for contact creation');
            }
        }
        
    }

}