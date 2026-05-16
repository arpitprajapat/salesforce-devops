@isTest
public class BatchForOpportunityTest{
    
    @isTest
    public static void BatchTest(){
        Opportunity opp1 = new Opportunity(                                                                                                                                                                                                                                                           
            Name  = 'Test',
            StageName = 'Perception Analysis',
            CloseDate = System.today().addDays(-3)
        );
        insert opp1;  
        
        Test.startTest();
        BatchForOpportunity opp2 = new BatchForOpportunity();
        Id jobId = Database.executeBatch(opp2, 1);
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }  
    @isTest
    public static void executeTests(){
        
        list<Opportunity> Opp1 = new list<Opportunity>();
        Opportunity opp3 = new Opportunity(
            Name = 'Test1',
            StageName = 'Perception Analysis',
            CloseDate = system.today().addDays(-3)
            
        );
        insert opp3;

            Test.startTest();
        //    Database.executeBatch(New Opportunity() , 1);
            Test.stopTest();
        }
    }