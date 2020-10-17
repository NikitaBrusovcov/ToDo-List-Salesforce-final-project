public with sharing class TaskToDoTriggerHandler {

    private boolean isExecuting = false;

    public TaskToDoTriggerHandler(){
    }

    public TaskToDoTriggerHandler(boolean isExecuting){
        this.isExecuting = isExecuting;
    }

    public void OnBeforeInsert(List<Task_ToDo__c>  newObjects){
        QueueAssignmentTriggerHelper.assignQueueToTaskToDo(newObjects);
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
