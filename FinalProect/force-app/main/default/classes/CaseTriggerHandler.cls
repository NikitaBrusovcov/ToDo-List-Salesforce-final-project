public with sharing class CaseTriggerHandler {
    
    public static void OnAfterInsert(List<Case> cases){
        CreateTaskToDoTriggerHelper.createTaskToDoFromEmailCase(cases);
    }
}
