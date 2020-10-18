public with sharing class SubtaskToDoTriggerHandler {
    
    public static void OnAfterInsert(List<SubTask__c> subTasks){
        UpdateTaskToDoStatusTriggerHelper.updatingTaskToDoStatus(subTasks);
    }
   
    public static void OnAfterUpdate(List<SubTask__c> subTasks){
        UpdateTaskToDoStatusTriggerHelper.updatingTaskToDoStatus(subTasks);
    }
}