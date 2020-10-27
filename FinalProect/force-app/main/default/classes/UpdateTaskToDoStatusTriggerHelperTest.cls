@IsTest
private class UpdateTaskToDoStatusTriggerHelperTest {
    
    @IsTest
    static void updatingTaskToDoStatusTest() {
        Task_ToDo__c taskTodo = new Task_ToDo__c(Name = 'Test Task');
        Test.startTest();
        insert taskTodo;
        Test.startTest();
        system.assertEquals('Created', taskTodo.Status__c);

    }
}
