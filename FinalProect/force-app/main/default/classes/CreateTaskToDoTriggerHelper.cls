public with sharing class CreateTaskToDoTriggerHelper {
    public static void createTaskToDoFromEmailCase(List<Case> cases) {
        List<Task_ToDo__c> newTasksToDo = new List<Task_ToDo__c>();
        for (Case oneCase : cases){
            if (oneCase.Origin == 'Email'){
                Task_ToDo__c newTaskToDoFromCase = new Task_ToDo__c(Name = oneCase.Subject, Description__c = oneCase.Description);
                newTasksToDo.add(newTaskToDoFromCase);
            }
        }
        insert newTasksToDo;
    }
}
