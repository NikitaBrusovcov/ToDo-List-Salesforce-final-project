public class DeleteOldTasksToDoBatch implements Database.Batchable<SObject>{
    
    public String query = '';

    public DeleteOldTasksToDoBatch(String query) {
        this.query = query;
    }
    
    public Database.QueryLocator start(Database.BatchableContext batchableContext){
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext batchableContext, List<SObject> scope){
        delete scope;
    }

    public void finish(Database.BatchableContext batchableContext){
    }
}