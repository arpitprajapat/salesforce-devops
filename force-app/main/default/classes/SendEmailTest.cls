@isTest
public class SendEmailTest {
    @isTest
    static void testSendHtmlEmail() {
        Test.startTest();
        SendEmail.sendHtmlEmail();
    }
    
  /*  @isTest
    static void TestCatch(){
        
        try{
            SendEmail.SingleEmailMessage(null);
            system.assertEquals(false);
        }
        catch(Exception e){
        //   system.assertEquals();
        }
    }*/
}