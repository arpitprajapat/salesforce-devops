@isTest
public class ToDoListTest {
    @isTest
    public static void UpdateWorkItemTest(){
        
        Integer workItemId = 5;
        String newStatus = 'pending';
        
        ToDoList.UpdateWorkItem(workItemId,newStatus);
    } 
    @isTest
    public static void TotalToDoList1Test(){
        
        ToDoList.TotalToDoList1();
        
    }
    
    @isTest
    public static void AddCallMethodTest(){

        
    }
    
}