public with sharing class UpdateTaskToDoStatusTriggerHelper {
    
    public static void updatingTaskToDoStatus(List<SubTask__c> subTasks){
        Set<Id> taskToDoIds = new Set<Id>();
        for (SubTask__c subtask : subTasks){
            taskToDoIds.add(subtask.Task_ToDo__c);
        }
        
        Task_ToDo__c[] tasksToDo = [SELECT Id, Status__c, (SELECT Id, Done__c FROM Subtasks_ToDo__r) FROM Task_ToDo__c WHERE Id IN : taskToDoIds];
        
        Integer countOfDoneSubtasks = 0;
        for (Task_ToDo__c taskToDo : tasksToDo){
            countOfDoneSubtasks = 0;
            for (SubTask__c subtaskOfTask : taskToDo.Subtasks_ToDo__r){
                if(subtaskOfTask.Done__c){
                    countOfDoneSubtasks++;
                }
            }
            ChangeStatus(taskToDo, countOfDoneSubtasks);
        }
        upsert tasksToDo;
    }
    
    
    private static void ChangeStatus(Task_ToDo__c taskToDo, Integer countOfDoneSubtasks){
        if (countOfDoneSubtasks == 0){
            taskToDo.Status__c = 'Created';
            taskToDo.Finish_Date__c = null;
        }
        else if(countOfDoneSubtasks ==taskToDo.Subtasks_ToDo__r.size()){
            taskToDo.Status__c = 'Done';
            taskToDo.Finish_Date__c = DateTime.now();
        }
        else{
            taskToDo.Status__c = 'In Progress';
            taskToDo.Finish_Date__c = null;
        }
    }
}