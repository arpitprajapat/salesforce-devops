public class CirtificationTracker {
    
    public static map<String , Date> Cirtification = new map<String,Date>();  
   // system.debug('--line 4---'+Cirtification);
    
    public static void StoreMethod(String Cirtificates ,Date dateofCir){
        Cirtification.put(Cirtificates ,  dateofCir);
        system.debug('--line 7---'+Cirtification);
        
    }
    public static integer TotalCirtification(){
        system.debug('---size---'+ Cirtification.size());
        return Cirtification.size();
        
    }
}