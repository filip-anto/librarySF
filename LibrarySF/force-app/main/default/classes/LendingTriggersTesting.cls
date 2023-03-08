@isTest
private class LendingTriggersTesting {
    @isTest static void checkAvailableBooksAfterInsertion() {
        Library__c a=TestSetup.createTestLibrary();
        Book__c b=TestSetup.createTestBook();
        User user1 = TestSetup.createTestUser();
        Library_User_Accounts__c libr_us_acc=TestSetup.createTestLibraryUser(user1,a);
        List<Lending__c> totalLends = TestSetup.createTestLendings(user1,a,b,libr_us_acc);    
        Test.startTest();
        insert(totalLends);
        Test.stopTest();
        Book__c q=[SELECT Available_Copies__c from Book__c WHERE Library__c=:a.Id LIMIT 1];
        Assert.AreEqual(97,q.Available_Copies__c);
    } 
    
    @isTest static void checkAvailableBooksAfterDeletion() {
   		Library__c a=TestSetup.createTestLibrary();
        Book__c b=TestSetup.createTestBook();
        User user1 = TestSetup.createTestUser();
        Library_User_Accounts__c libr_us_acc=TestSetup.createTestLibraryUser(user1,a);
        List<Lending__c> totalLends = TestSetup.createTestLendings(user1,a,b,libr_us_acc); 
        insert(totalLends);
        Lending__c lend=[SELECT Id from Lending__c LIMIT 1];
        Test.startTest();
		delete(lend);
		Test.stopTest();
		Book__c q2=[SELECT Available_Copies__c from Book__c WHERE Library__c=:a.Id];
		Assert.AreEqual(98,q2.Available_Copies__c);
    }
}