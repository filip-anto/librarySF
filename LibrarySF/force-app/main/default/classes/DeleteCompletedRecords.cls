public class DeleteCompletedRecords implements Schedulable {
    public void execute(SchedulableContext ctx) {
        BatchDeleteCompletedLendings myBatchObject = new BatchDeleteCompletedLendings();
		Id batchId = Database.executeBatch(myBatchObject);
    }
}