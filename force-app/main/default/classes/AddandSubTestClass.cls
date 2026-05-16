@isTest
public class AddandSubTestClass {
    
    @isTest
    public static void Testadd(){
        Integer result = AddandSub.addition(10,4);
        system.assertEquals(14,result);
    }
    
    @isTest
    public static void TestSubtract(){
        Integer result = AddandSub.Subtract(10,4);
        system.assertEquals(6,result);
    }
}