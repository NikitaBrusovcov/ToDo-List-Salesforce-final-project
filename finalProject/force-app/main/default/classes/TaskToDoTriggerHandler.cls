public with sharing class TaskToDoTriggerHandler {

    private boolean isExecuting = false;

    public TaskToDoTriggerHandler(){
    }

    public TaskToDoTriggerHandler(boolean isExecuting){
        this.isExecuting = isExecuting;
    }

    public void OnBeforeInsert(List<Task_ToDo__c>  newObjects){
        List<RecordType> taskRecordTypes = [SELECT Id,Name FROM RecordType WHERE sobjecttype = 'Task_ToDo__c'];
    
        for(Task_ToDo__c taskRecordName:newObjects){
            for(RecordType taskRecType:taskRecordTypes){
               
                if(taskRecordName.recordtypeid == taskRecType.id){
                    List<QueueSobject> queueObj = new List<QueueSobject>();
                    if(taskRecType.name == 'DeveloperTaskToDo'){
                        queueObj=[SELECT Id,queueId FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c'AND queue.Name = 'DeveloperQueue' LIMIT 1];
                    }
                    if(taskRecType.name == 'MarcetingTaskToDO'){
                        queueObj=[SELECT Id,queueId FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c'AND queue.Name = 'MarcetingQueue' LIMIT 1];
                    }
            
                    taskRecordName.ownerid=queueObj[0].queueid;
                }
             }
        }
    }

    public void OnAfterInsert(List<Task_ToDo__c> newObjects){
       
    }

    public void OnBeforeUpdate(List<Task_ToDo__c>  oldObjects,List<Task_ToDo__c> updatedObjects, Map<Id,Task_ToDo__c> ObjectMap){
      
    }

    public void OnAfterUpdate(List<Task_ToDo__c>  oldObjects, List<Task_ToDo__c>  updatedObjects, Map<Id,Task_ToDo__c>  ObjectMap){
     
    }

    public void OnBeforeDelete(List<Task_ToDo__c>  ObjectsToDelete, Map<Id,Task_ToDo__c> ObjectMap){
      
    }

    public void OnAfterDelete(List<Task_ToDo__c>  deletedObjects,  Map<Id,Task_ToDo__c> ObjectMap){
  
    }

    public void OnUndelete(List<Task_ToDo__c>  restoredObjects){
     
    }

    public boolean IsTriggerContext{
        get{ return isExecuting;}
    }
}
