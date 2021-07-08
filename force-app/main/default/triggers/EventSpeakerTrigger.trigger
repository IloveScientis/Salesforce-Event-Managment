trigger EventSpeakerTrigger on EventSpeakers__c (before insert, before update) {
	// Step 1 - Get the speaker id & event id 
	// Step 2 - SOQL on Event to get the Start Date and Put them into a Map
	// Step 3 - SOQL on Event - Spekaer to get the Related Speaker along with the Event Start Date
	// Step 4 - Check the Conditions and throw the Error
	//Step 1 Start
    Set<Id> eventIdSet = new Set<Id>();
    Set<Id> speakerIdSet= new Set<Id>();    
  
    for(EventSpeakers__c evt: Trigger.New){
        eventIdSet.add(evt.Event__c);
        speakerIdSet.add(evt.Speaker__c);        
    }
    Map<Id,DateTime> requestedEvent = new Map<Id,DateTime>();
    List<Event__c> eventList = [Select Id, 
                                Start_DateTime__c 
                                from Event__c 
                                where Id IN: eventIdSet];
    for(Event__c e:eventList){
        requestedEvent.put(e.Id,e.Start_DateTime__c);
    }
    
    List<EventSpeakers__c> speakersList = [Select Id, 
                                           Event__c , 
                                           Speaker__c, 
                                           Event__r.Start_DateTime__c 
                                           from EventSpeakers__c 
                                           where Speaker__c IN: speakerIdSet];
    for(EventSpeakers__c es:Trigger.New){
        DateTime bookingTime =requestedEvent.get(es.Event__c);
        for(Eventspeakers__c esl:speakersList){
            if(es.Speaker__c==esl.Speaker__c && esl.Event__r.Start_DateTime__c ==bookingTime){
                es.Speaker__c.addError('There is already existed booking time for this speaker');
                es.addError('There is already existed booking time for this speakers');
            }
        }
    }
}