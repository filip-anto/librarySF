@isTest
public class BatchDeleteTest {
    @isTest static  void createRecords(){
        Library__c a=TestSetup.createTestLibrary();
        Book__c b=TestSetup.createTestBook();
        User user1 = TestSetup.createTestUser();  
        Library_User_Accounts__c libr_us_acc=TestSetup.createTestLibraryUser(user1,a);
        List<Lending__c> totalLends = new List<Lending__c>();
        
        for (Integer i = 0; i < 7; i++) {
            totalLends.add(new Lending__c(
                Name=b.Name+' by '+user1.Name+' from '+i+a.Name,
                Book__c=b.Id,
                Lender_User__c=libr_us_acc.Id,
                Start_Date__c=date.parse('06/07/2032'),
                End_Date__c=date.parse('11/11/2032'),
                Status__c='Completed'
            ));
        }
        insert(totalLends);
        List<Lending__c> insertedLendings=[SELECT Id,Name from Lending__c];
        System.assertEquals(7,insertedLendings.size());
        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        Test.startTest();
        BatchDeleteCompletedLendings uca = new BatchDeleteCompletedLendings();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
    	List<Lending__c> insertedLendingsAfter=[SELECT Id,Name from Lending__c];
        System.assertEquals(0,insertedLendingsAfter.size());
    }    
}