public class TriggerHandler {
    
    public static void handleOpportunities(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        
        Opportunity oldOpp;
        Set<Id> accIds = new Set<Id>();
        
        if (!newList.isEmpty()) {
            
            for (Opportunity newOpp : newList) {
                
                if (oldMap != null && oldMap.containsKey(newOpp.Id)) {
                    oldOpp = oldMap.get(newOpp.Id);
                    
                    if (oldOpp.AccountId != newOpp.AccountId) {
                        accIds.add(oldOpp.AccountId);
                        accIds.add(newOpp.AccountId);
                    } else if (oldOpp.Amount != newOpp.Amount) {
                        accIds.add(newOpp.AccountId);
                    }
                } else {
                    accIds.add(newOpp.AccountId);
                }
            }
        }
        
        if (!accIds.isEmpty()) {
            List<Opportunity> oppList = [
                SELECT Id, AccountId, Amount, Name 
                FROM Opportunity 
                WHERE AccountId IN :accIds AND Amount != null
            ];
            
            Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
            if (!oppList.isEmpty()) {
                for (Opportunity opp : oppList) {
                    if (!oppMap.containsKey(opp.AccountId) || (oppMap.get(opp.AccountId).Amount < opp.Amount)) {
                        oppMap.put(opp.AccountId, opp);
                    }
                }
            }
            
            Account acc = new Account();
            
        }
    }
}