global class ScheduledDeletOldTaskBatch implements Schedulable {
   global void execute(SchedulableContext schedulableContext) {
      String status = 'Done';
      String databaseQuery = 'SELECT Id FROM Task_ToDo__c WHERE Status__c = \'' + status + '\'' + ' AND CreatedDate < LAST_N_DAYS:3';
      DeleteOldTasksToDoBatch deleteOldTasksToDoBatch = new DeleteOldTasksToDoBatch(databaseQuery); 
      Database.executebatch(deleteOldTasksToDoBatch);
   }
}