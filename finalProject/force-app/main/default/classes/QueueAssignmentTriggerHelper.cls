public with sharing class QueueAssignmentTriggerHelper {
    public QueueAssignmentTriggerHelper() {

    }

    public static void assignQueueToTaskToDo(List<Task_ToDo__c>  newObjects){
        List<RecordType> taskRecordTypes = [SELECT Id,Name FROM RecordType WHERE sobjecttype = 'Task_ToDo__c'];

        List<QueueSobject> developerQueue = [SELECT Id,queueId FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c'AND queue.Name = 'DeveloperQueue' LIMIT 1];
        List<QueueSobject> marcetingQueue = [SELECT Id,queueId FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c'AND queue.Name = 'MarcetingQueue' LIMIT 1];
    
        for(Task_ToDo__c taskRecordName:newObjects){
            for(RecordType taskRecType:taskRecordTypes){
                if(taskRecordName.recordtypeid == taskRecType.id && taskRecordName.My_Task__c==false){
                    if(taskRecType.name == 'DeveloperTaskToDo' ){
                        taskRecordName.ownerid=developerQueue[0].queueid;
                    }
                    if(taskRecType.name == 'MarcetingTaskToDo' ){
                        taskRecordName.ownerid=marcetingQueue[0].queueid;
                    }
                }
             }
        }
    }
}
