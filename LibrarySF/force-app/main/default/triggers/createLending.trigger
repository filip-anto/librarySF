trigger createLending on Lending__c (after insert, after delete) {
    List<Library_User_Accounts__c> luas= new List <Library_User_Accounts__c>();
    Set<Id> usersWithAlteredLendings=new Set<Id>();
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            for (Lending__c lending:Trigger.new){
                usersWithAlteredLendings.add(lending.Lender_User__c);
                Book__c bookToUpdate=[Select Id,Name,Available_Copies__c from Book__c WHERE Id=:lending.Book__c];
                bookToUpdate.Available_Copies__c=--bookToUpdate.Available_Copies__c;
                update(bookToUpdate);           
            }
        }
    }
    if (Trigger.isDelete) {
        if (Trigger.isAfter) {
            for (Lending__c lending:Trigger.old){
                usersWithAlteredLendings.add(lending.Lender_User__c);
                Book__c bookToUpdate=[Select Id,Name,Available_Copies__c from Book__c WHERE Id=:lending.Book__c];
                bookToUpdate.Available_Copies__c=++bookToUpdate.Available_Copies__c;
                update(bookToUpdate);
            }
        }
    }
    
    for (Id userToUpdate:usersWithAlteredLendings) {
    	List<Lending__c> booksOfUser=([Select Id,Book__r.Genre__c from Lending__c where Lender_User__c=:userToUpdate]);    
        List<String> totalNumbers=new List<String>();
        List<String> genres;
        for (Lending__c book:booksOfUser){
            genres=book.Book__r.Genre__c.split(';');
            for (String genre:genres){
                totalNumbers.add(genre);
            }
        }
        
        
        
        
        
        
        Map<String, Integer> genreCounts = new Map<String, Integer>();
        for(String word:totalNumbers) {
            Integer genreCount = genreCounts.get(word);
            if(genreCount == null) {
                genreCount = 0;
            }
            genreCounts.put(word, genreCount+1);
        }
        
        List<Integer> i_values = genreCounts.values();
        i_values.sort();
        if(i_values.size()-1<0){
            Library_User_Accounts__c lua= [SELECT Favorite_Genre__c from Library_User_Accounts__c where Id=:userToUpdate];
                lua.Favorite_Genre__c='';
               update(lua);
        }else{
        Integer i_max_value = i_values[(i_values.size()-1)];
        
        for(String s : genreCounts.keySet()){
            Integer tally = genreCounts.get(s);
            
            if(tally == i_max_value){
                System.debug(' Id is ' + s + ' value is ' + tally);
                Library_User_Accounts__c lua= [SELECT Favorite_Genre__c from Library_User_Accounts__c where Id=:userToUpdate];
                lua.Favorite_Genre__c=s;
               update(lua);
              }  
            }
        }
      //  update(luas)      
    
    }
}