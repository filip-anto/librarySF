trigger createBookInstances on Book__c (after insert) {
System.debug(Trigger.new);
}