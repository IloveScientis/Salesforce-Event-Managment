trigger AccountTrigger on Account (before delete) {
    if(Trigger.isBefore && Trigger.isdelete){
        AccountTriggerHandler.handleBeforeDelete(Trigger.old, Trigger.OldMap);
    }
}