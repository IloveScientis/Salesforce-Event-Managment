public class DeleteEventBatch implements Database.Batchable<Sobject>{
    
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String query='SELECT Id,Name, End_Date_Time__c, Live__c FROM Event__c where Live__c =true AND DAY_ONLY(ConvertTimeZone( End_Date_Time__c)) < LAST_N_MONTHS:2';
        return Database.getQueryLocator(query);
        
    }
    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList){
        if(!eventList.isEmpty()){
            List<Database.DeleteResult> deleteResult = Database.delete(eventList);
            for(Database.DeleteResult dr : deleteResult){
                if(!dr.isSuccess()){
                    List<Database.Error> errors = dr.getErrors();
                    String errorInString = String.join(errors, ',');
                   TransactionLogHandler.doHandleExceptionWithError(errorInString, 'DeleteEventBatch');
                }
            }
        }
    }
    public void finish(Database.BatchableContext batchContext){
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              List<String> toAddress = new List<String>();
              toAddress.add('stevenduong1983tx@gmail.com');
              mail.setToAddresses(toAddress);
              mail.setSenderDisplayName('FIT MONSTER');
              mail.setSubject('DeleteEventBatch');                        
             
              mail.setHtmlBody('The records have been procecessed');        	 
              Messaging.sendEmail(new List<Messaging.Email>{mail});
             
    }

}