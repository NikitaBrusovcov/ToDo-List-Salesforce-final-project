public with sharing class TaskToDoController {

    @AuraEnabled(cacheable=true)
    public static List <Task_ToDo__c> fetchTaskToDoList() {
        return [ SELECT Id, My_Task__c, Name, Status__c, Deadline_Date__c, Finish_Date__c, Start_Date__c, Description__c,
        (SELECT Id,Name,Done__c FROM Subtasks_ToDo__r)
                  FROM Task_ToDo__c];
    }
}
