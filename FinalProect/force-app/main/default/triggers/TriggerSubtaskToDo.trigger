trigger TriggerSubtaskToDo on SubTask__c (before insert, after insert, before update, after update, before delete, after delete) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        SubtaskToDoTriggerHandler.OnAfterInsert(Trigger.new);
    }

    if(Trigger.isUpdate && Trigger.isAfter){
        SubtaskToDoTriggerHandler.OnAfterUpdate(Trigger.new);
    }
    
    if(Trigger.isDelete && Trigger.isAfter){
       SubtaskToDoTriggerHandler.OnAfterDelete(Trigger.old);
    }
  
}