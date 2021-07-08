public class AccountTriggerHandler {
    public static void handleBeforeDelete(List<Account> oldAccountList, Map<Id,Account> oldAccountMap){
        Set<Id> accountIdSet = OldAccountMap.keySet();
        List<Opportunity> oppList =[Select Id, Name, StageName, AccountId from Opportunity where AccountId IN: accountIdSet and IsWon=: true];
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        
        for(Opportunity op: oppList){
            if(!oppMap.containsKey(op.AccountId)){
                oppMap.put(op.AccountId,op);
            }
        }
        
        for (Account acc: oldAccountList){
            if(oppMap.containskey(acc.Id)){
                acc.addError('You can not delete the Account that has won opportunity. Please contact your administrator');
            }
        }
    }
}