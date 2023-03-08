global class BatchDeleteCompletedLendings implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('HIII');
        return Database.getQueryLocator(
            'SELECT Id, Name FROM Lending__c WHERE Status__c = \'Completed\''
        );
    }
       
    public void execute(Database.BatchableContext bc, List<Lending__c> scope){
        String bodyContent=JSON.serialize(scope);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.mocky.io/v2/5bcef5d53300009000c246d3 ');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(bodyContent);
        HttpResponse response = http.send(request);
        List<Lending__c> c=[SELECT Id FROM Lending__c];
        delete(c);
        
        if(response.getStatusCode() != 201) {
            System.debug('The statusss code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        
        } else {
            System.debug('ok');
        }
        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Execution failed successfully');
    }
}