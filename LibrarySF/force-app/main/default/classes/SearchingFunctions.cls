public with sharing class SearchingFunctions {
    @AuraEnabled(cacheable=true scope='global')
    public static Library__c[] getAllLibraries(){
        return ([select id,Name from Library__c]);
    }
    @AuraEnabled(cacheable=true scope='global')
    public static Book__c[] getAllBooks(Id libraryId){
        return ([select id,Name,Available_Copies__c,Total_Number_of_copies__c,Library__c from Book__c where Library__c=:libraryId]);
        //return ([select id,Name,Available_Copies__c,Total_Number_of_copies__c,Library__c from Book__c]);
        //return ([select id,Name,Available_Copies__c,Total_Number_of_copies__c,Library__c from Book__c]);
    }
   /* public static Book__c[] getAllBooks(){
        return ([select id,Name,Available_Copies__c,Total_Number_of_copies__c,Library__c from Book__c]);
    }
    */
    @AuraEnabled(cacheable=true scope='global')
    public static Library_User_Accounts__c[] getAllUsers(Id libraryId){
        return ([select id,name,Library_Of_Registration__c,Gender__c  from Library_User_Accounts__c where Library_Of_Registration__c=:libraryId]);
    }

    @AuraEnabled(cacheable=true scope='global')
    public static Result searchables(String searchValue,Id libraryId){
        List<List<SObject>> quer = [
            //FIND :searchValue
            FIND '1984'
            IN ALL FIELDS 
            RETURNING Book__c(Name,Available_Copies__c,Total_Number_of_copies__c,Library__c),
            Library_User_Accounts__c(id,Name,Gender__c)
        ];
        Result res = new Result();
        res.books = (Book__c[]) quer[0];
        res.users =(Library_User_Accounts__c[]) quer[1];
        return res;  
    }
    
    public class Result {
        @AuraEnabled public List<Book__c> books;
        @AuraEnabled public List<Library_User_Accounts__c> users;
    }

}