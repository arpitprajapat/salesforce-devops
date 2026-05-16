public class ToDoList {
    
    public static list<workItem> BlankToDoList1 = new list<workItem>(); // create list
    
    public static void AddCallMethod( workItem  ToDoItem1){   // method passing 
        BlankToDoList1.add(ToDoItem1);				// adding item
        
        system.debug('---- line 8 ----'+BlankToDoList1);
        system.debug('---- line 9 ----'+ToDoItem1);
    }
    public static list<ToDoList.workItem>getToDoList1(){  // getlist 
        return BlankToDoList1;
        
    }
    public static void UpdateWorkItem(Integer workItemId , String newStatus){
        for(ToDoList.workItem  workItem : BlankToDoList1 ){
            system.debug('---- BlankToDoList1 line 17 ----'+BlankToDoList1); 
            system.debug('---- line 16 ----'+workItem);
            if( workItem.toDoId == workItemId ){
                
                workItem.toDoStatus = newStatus;  // update 'Completed'
                system.debug('-workItem-'+workItem);
                // workItem.toDoDescription = Description;
            }
        }
        system.debug('----line 24----'+BlankToDoList1); // update list
        
    }
    public static integer TotalToDoList1(){
        system.debug('-------- size line 26 ---------------'+BlankToDoList1.size());
        return BlankToDoList1.size();
    }
    public class  workItem {
        
        public Integer toDoId;
        public String toDoName;
        public String toDoDescription;
        public  String toDoStatus;
        
    }
}