@isTest
public class DeleteBatchTest {
	@testSetup
    public static void setupData(){
        Event_Organizer__c org = new Event_Organizer__c(
            Name='Binh Ngo',
            Email__c='testsalesforce123567@gmail.com',        
            Phone__c='1221222222'       
        );
        insert org;        
        
        List<Event__c> eventList = new List<Event__c>();
        for(Integer i=0;i<= 200;i++){
            Event__c event = new Event__c(      
            Event_Organizer__c = org.id, 
            Start_DateTime__c=System.now().addMonths(-4), 
            End_Date_Time__c=System.now().addDays(3).addMonths(-4),            
            Event_Type__c='Virtual', 
            Frequency__c='Daily', 
            Live__c=true, 
            Max_Seats__c=100, 
            Name__c='MAX FIT '+i, 
            Recurring__c=true       
           
        );
            eventList.add(event);            
        }                
        insert eventList;
        
           /*Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Amit Singh',
            Phone__c = '9807654321',
            Email__c = 'sfdcpanther@gmail.com.dev1',
            Alternative_Phone__c  = '9807654321',
            Alternative_Email__c ='sfdcpanther@gmail.com.dev1'
        );
        insert org;
        List<Event__c> eventList = new List<Event__c>();
        for(Integer i=0; i<=200; i++){
            Event__c event = new Event__c(
                Name__c = 'MAX FIT Campaign #'+i+1,
                Event_Organizer__c  = org.Id,
                Event_Type__c = 'Virtual',
                Frequency__c  = 'Weekly',
                Max_Seats__c  = 199,
                Recurring__c = true,
                Live__c = true,
                Start_DateTime__c = System.now().addMonths(-4),
                End_Date_Time__c  = System.now().addDays(3).addMonths(-4)
            );
            eventList.add(event);
        }
        insert eventList;*/
    }
    
    public testMethod static void sendDeleteBatch(){
        
        Test.startTest();
        String jobId = Database.executeBatch(new DeleteEventBatch(), 250);
        Test.stopTest();
    }
}