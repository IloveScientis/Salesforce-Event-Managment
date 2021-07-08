public class TransactionLogHandler {
    public static void doExceptionHandler(System.Exception ex, String processName){
        Error_Log_update__c transactionLog = new Error_Log_update__c(
            Log_Details__c = ex.getStackTraceString() + '<br/> <strong> Message is </strong> ' + ex.getMessage() + '<br/> ' +ex.getCause() +
            '<br/> '+ ex.getTypeName() + '<br/> ' + ex.getTypeName(),
            Lod_DateTime__c = System.now(),
            Created_Date__c = System.now(),
            LastModifiedDate__c= System.now(),
            SystemModstamp__c=System.now(),                  
            Process_Name__c = processName            
        
        );
        insert transactionLog;
    }
    
    public static void doHandleExceptionWithError(String errors, String processName){
        Error_Log_update__c transactionLog = new Error_Log_update__c(
            Log_Details__c = errors,
            Lod_DateTime__c = System.now(),
            Created_Date__c = System.now(),
            LastModifiedDate__c= System.now(),
            SystemModstamp__c=System.now(),                  
            Process_Name__c = processName            
        
        );
        insert transactionLog;
    }
}