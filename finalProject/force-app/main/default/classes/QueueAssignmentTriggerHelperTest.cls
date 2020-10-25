@isTest
public with sharing class QueueAssignmentTriggerHelperTest {
    static void insertTask(String recordTypeName,String taskName){
        List<Task_ToDo__c> taskToInsert = new List<Task_ToDo__c>();

        RecordType developerRecordType = null;

        List<RecordType> taskRecordTypes = [SELECT Id,Name FROM RecordType WHERE sobjecttype = 'Task_ToDo__c'];
    
        for(RecordType recType:taskRecordTypes){
            if(recType.Name == recordTypeName){
                developerRecordType=recType;
            }
        }

        for(Integer i = 0; i<5; i++){
            Task_ToDo__c task = new Task_ToDo__c();
            task.Name=taskName + ' ' + i;
            task.recordtypeid=developerRecordType.id;
            taskToInsert.add(task);
        }

        insert taskToInsert;
    }

    static void insertMyTask(String recordTypeName,String taskName){
        List<Task_ToDo__c> taskToInsert = new List<Task_ToDo__c>();

        RecordType developerRecordType = null;

        List<RecordType> taskRecordTypes = [SELECT Id,Name FROM RecordType WHERE sobjecttype = 'Task_ToDo__c'];
    
        for(RecordType recType:taskRecordTypes){
            if(recType.Name == recordTypeName){
                developerRecordType=recType;
            }
        }

        for(Integer i = 0; i<5; i++){
            Task_ToDo__c task = new Task_ToDo__c();
            task.Name=taskName + ' ' + i;
            task.recordtypeid=developerRecordType.id;
            task.My_Task__c = true;
            taskToInsert.add(task);
        }

        insert taskToInsert;
    }

    @IsTest
    static void runAddingDeveloperTaskToDoCase() {
        insertTask('DeveloperTaskToDo','Developer Test Name');

        List<Task_ToDo__c> insertedDeveloperTasks = [SELECT Id,ownerid FROM Task_ToDo__c WHERE Name LIKE 'Developer Test Name%'];
       
        System.assertEquals(insertedDeveloperTasks.size(), 5);
        
        List<Id> queueIds   = new List<Id>();
        for(Task_ToDo__c newTask:insertedDeveloperTasks){
            queueIds.add(newTask.ownerid);
        }

        List<QueueSobject> developerQueue = [SELECT Id,queueId,queue.Name FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c' AND queue.Name = 'DeveloperQueue' LIMIT 1];
        for(Id queueId:queueIds){
            System.assert(queueId == developerQueue[0].queueId);
        }
    }

    @IsTest
    static void runAddingMarcetingTaskToDoCase() {
        insertTask('MarcetingTaskToDo','Marceting Test Name');

        List<Task_ToDo__c> insertedMarcetingTasks = [SELECT Id,ownerid FROM Task_ToDo__c WHERE Name LIKE 'Marceting Test Name%'];
       
        System.assertEquals(insertedMarcetingTasks.size(), 5);
        
        List<Id> queueIds = new List<Id>();
        for(Task_ToDo__c newTask:insertedMarcetingTasks){
            queueIds.add(newTask.ownerid);
        }

        List<QueueSobject> marcetingQueue = [SELECT Id,queueId,queue.Name FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c' AND queue.Name = 'MarcetingQueue' LIMIT 1];
        for(Id queueId:queueIds){
            System.assert(queueId == marcetingQueue[0].queueId);
        }
    }

    @IsTest
    static void runAddingMyMarcetingTaskCase() {
        insertMyTask('MarcetingTaskToDo','Marceting Test Name');

        List<Task_ToDo__c> insertedMarcetingTasks = [SELECT Id,ownerid FROM Task_ToDo__c WHERE Name LIKE 'Marceting Test Name%'];
       
        System.assertEquals(insertedMarcetingTasks.size(), 5);
        
        List<Id> queueIds = new List<Id>();
        for(Task_ToDo__c newTask:insertedMarcetingTasks){
            queueIds.add(newTask.ownerid);
        }

        List<QueueSobject> marcetingQueue = [SELECT Id,queueId,queue.Name FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c' AND queue.Name = 'MarcetingQueue' LIMIT 1];
        for(Id queueId:queueIds){
            System.assert(queueId != marcetingQueue[0].queueId);
        }
    }

    @IsTest
    static void runAddingMyDeveloperTaskCase() {
        insertMyTask('DeveloperTaskToDo','Developer Test Name');

        List<Task_ToDo__c> insertedDeveloperTasks = [SELECT Id,ownerid FROM Task_ToDo__c WHERE Name LIKE 'Developer Test Name%'];
       
        System.assertEquals(insertedDeveloperTasks.size(), 5);
        
        List<Id> queueIds   = new List<Id>();
        for(Task_ToDo__c newTask:insertedDeveloperTasks){
            queueIds.add(newTask.ownerid);
        }

        List<QueueSobject> developerQueue = [SELECT Id,queueId,queue.Name FROM QueueSobject WHERE SobjectType = 'Task_ToDo__c' AND queue.Name = 'DeveloperQueue' LIMIT 1];
        for(Id queueId:queueIds){
            System.assert(queueId != developerQueue[0].queueId);
        }
    }

}
