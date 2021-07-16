public with sharing class eventDetailController {
    @AuraEnabled
   public static List<EventSpeakers__c> getSpeaker(String eventId){
       List<EventSpeakers__c> speakerList =[
            select Id, Name, Speaker__c,Event__c,
            Speaker__r.Name, Speaker__r.Email__c,
            Speaker__r.Phone__c, Speaker__r.Company__c
            from EventSpeakers__c
            where Event__c =: eventId
            WITH SECURITY_ENFORCED

       ];
       return speakerList;
   }

   @AuraEnabled
   public static Event__c getLocationDetail(String eventId){
       Event__c eventRecord = [
           select Id, Name__c,Location__c,
           Location__r.Name,Location__r.City__c, Location__r.Country__c,
           Location__r.Land_Mark__c,Location__r.Postal_Code__c,Location__r.State__c,Location__r.Street__c
           from Event__c
           where Id =: eventId
           WITH SECURITY_ENFORCED
       ];
       return eventRecord;
   }

   @AuraEnabled
   public static List<Event_Attendee__c> getEventAttendee(String eventId){
       List<Event_Attendee__c> eventAttendeeList= [
        //    select 
        //    Id, Name,
        //    Attendee__r.Name,
        //    Attendee__r.Email__c,
        //    Attendee__r.Company_Name__c,
        //    Attendee__r.Location__r.Name
        //    from 
        //     Event_Attendee__c 
        //    where Id =: eventId
        //    WITH SECURITY_ENFORCED
        SELECT
        Id,
        Name,
        Attendee__c,
        Attendee__r.Name,
        Attendee__r.Email__c,
        Attendee__r.Company_Name__c,
        Attendee__r.Location__c,
        Attendee__r.Location__r.Name
      FROM Event_Attendee__c
      WHERE Event__c = :eventId
      WITH SECURITY_ENFORCED
       ];
       return eventAttendeeList;
   }
}
