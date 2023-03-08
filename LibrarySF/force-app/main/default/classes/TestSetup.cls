@isTest
public class TestSetup {
    public static Library__c createTestLibrary(){
        Library__c libraryToAdd= new Library__c(Name='Test Library',Street__c='Test City123',Phone__c='1234567890',City__c='Test');
        insert(libraryToAdd);
        return (libraryToAdd);
    }
    
    public static Book__c createTestBook(){
        Book__c bookToAdd=new Book__c(Code__c='1234567890',Total_Number_of_copies__c=100,Genre__c='Mystery',Available_Copies__c=100, Name='Animal Farm',Library__c=[SELECT Id,Name from Library__c WHERE Name='Test Library'].Id);
        insert(bookToAdd);
        return(bookToAdd);
    }
    public static User createTestUser(){
        User user1 = new User(Username = System.now().millisecond() + 'test12345@test.com',Alias = 'test123',Email = 'test12345@test.com',EmailEncodingKey = 'UTF-8',ProfileId='00e680000011qttAAA',LastName = 'McTesty',CommunityNickname = 'test12345',TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey = 'en_US',LanguageLocaleKey = 'en_US');
        insert(user1);
        return(user1);
    }
    public static List<Lending__c> createTestLendings(User user1, Library__c a, Book__c b,Library_User_Accounts__c libr_us_acc){
        List<Lending__c> totalLends = new List<Lending__c>();
        for (Integer i = 0; i < 3; i++) {
            totalLends.add(new Lending__c(
                Name=b.Name+' by '+user1.Name+' from '+i+a.Name,
                Book__c=b.Id,
                Lender_User__c=libr_us_acc.Id,
                Start_Date__c=date.parse('06/07/2032'),
                End_Date__c=date.parse('11/11/2032')
            ));
        }
        return totalLends;
    }
    
    public static Library_User_Accounts__c createTestLibraryUser(User user1, Library__c a){
    Library_User_Accounts__c libr_us_acc=new Library_User_Accounts__c(Gender__c='Male',Library_Of_Registration__c=a.Id,Registered_User__c=user1.Id,Name='Library Test User');
        insert (libr_us_acc);
    return (libr_us_acc);
    }
    
    
    
}