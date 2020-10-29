public with sharing class TaskToDoController {

    @AuraEnabled(cacheable=true)
    public static Integer TotalRecords(){
        return [SELECT count() FROM Task_ToDo__c];
    }

    @AuraEnabled(cacheable=true)
    public static List<Task_ToDo__c> getTaskToDoList(Integer v_Offset, Integer v_pagesize){ 
        return [ SELECT Id, My_Task__c, Name, Status__c, Deadline_Date__c, Finish_Date__c, Start_Date__c, Description__c,
        (SELECT Id,Name,Done__c FROM Subtasks_ToDo__r)
                  FROM Task_ToDo__c LIMIT :v_pagesize OFFSET :v_Offset];

    }

    @AuraEnabled(cacheable=true)
    public static Integer getNext(Integer v_Offset, Integer v_pagesize){
        v_Offset += v_pagesize;
        return v_Offset;
    }

    @AuraEnabled(cacheable=true)
    public static Integer getPrevious(Integer v_Offset, Integer v_pagesize){
        v_Offset -= v_pagesize;
        return v_Offset;
    }
}
