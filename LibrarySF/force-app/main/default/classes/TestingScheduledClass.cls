@IsTest
public class TestingScheduledClass {
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        String CRON_EXP = '0 0 0 ? * MON *';
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
        List<Lending__c> x=[SELECT ID FROM Lending__c where Status__c='Completed'];
        System.assertEquals(7,x.size());
        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new DeleteCompletedRecords());
        // Verify the scheduled job has not run yet.
               
        // Stopping the test will run the job synchronously
        Test.stopTest();
        // Now that the scheduled job has executed,
        // check that our tasks were created
        List<Lending__c> x2=[SELECT ID FROM Lending__c];
        System.debug(x2);
    }
}