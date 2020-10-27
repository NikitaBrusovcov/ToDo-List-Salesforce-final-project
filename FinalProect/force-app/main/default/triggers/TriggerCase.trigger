trigger TriggerCase on Case (before insert, after insert, before update, after update, before delete, after delete) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        CaseTriggerHandler.OnAfterInsert(Trigger.new);
    }
  
}