@isTest
public class EventAttendeeTriggerTest {
	@testSetup
    public static void setUpData(){
        Event_Organizer__c org = new Event_Organizer__c(
            Name='Binh Ngo',
            Email__c='testsalesforce123567@gmail.com',        
            Phone__c='1221222222'       
        );
        insert org;
        
        Attendee__c attendee = new Attendee__c(
            Name='Duong Minh Thao', 
            Email__c='testsalesforce123678@gmail.com', 
            Phone__c='1112222112', 
            Company_Name__c ='NA'       
        );
        insert attendee;
        
        Event__c event = new Event__c(      
            Event_Organizer__c = org.id, 
            Start_DateTime__c=System.now(), 
            End_Date_Time__c=System.now().addDays(3),            
            Event_Type__c='Virtual', 
            Frequency__c='Daily', 
            Live__c=true, 
            Max_Seats__c=100, 
            Name__c='MAX FIT', 
            Recurring__c=true       
           
        );
        insert event;
        Event_Attendee__c eatte = new Event_Attendee__c(
        	Event__c = event.Id,
            Attendee__c = attendee.Id
        );
        
        insert eatte;
    }
    
    @isTest
    public static void EventAttendeeTest(){
        Test.startTest();
        
        Test.StopTest();
    }
}