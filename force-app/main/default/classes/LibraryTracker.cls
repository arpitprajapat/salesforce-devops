public class LibraryTracker {
   
    public static list<string> allBook = new list<string>();
    
    public static map<String , String> BookIssue = new map<String , String>();  
    
    public static void HaveAllBooks(string BookName){
        allBook.add(BookName);
        system.debug('---allBook---'+allBook);
    }
    public static void StoreMethod(String BookName , String User){
        BookIssue.put(BookName , User );
        
        List<String> remaining = new List<String>();  
        
        for(string eachBook : allBook){     // list of allBook
            system.debug('--IncludeBook---'+eachBook);
            
            if(eachBook != BookName){
                remaining.add(eachBook);
                system.debug('---remainsbook---'+remaining);
            }
        }
        allBook = remaining;  // Assign in list
        
        system.debug('----allBook----'+allBook);         
    }
    public static map<string,string> UserBorrowed(){
        system.debug('-BookIssue--'+BookIssue);
        return BookIssue;
    }    
    public static list<string> BookRepostry(){ 
          system.debug('-allBook line 33 --'+allBook);
        return allBook;       
    }
    
}