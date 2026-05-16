public class CheckHighestLowetMarks {
    
    public static integer MarksMethod(map<String , integer> MapOfSubject){
        // public static Integer Marks (Map<String, Integer> MapStrINT){
        Integer  HighestMarks = 0;
        Integer lowestMarks = 100;
        
        for(String Subject : MapOfSubject.keyset()){   // All subject
            system.debug('--Marks--'+Subject);
            
            integer GetMarks = MapOfSubject.get(Subject); // All marks
            system.debug('_____GetMarks_____' +GetMarks);
            
            if(HighestMarks  < GetMarks){
                HighestMarks = GetMarks;
                
            } if( lowestMarks > GetMarks ){
                lowestMarks = GetMarks;
                
            }
        }
        
        system.debug('--HighestMarks--'+HighestMarks);
        
        system.debug('--lowestMarks--'+lowestMarks);                
        
        return lowestMarks;
        
    }
}