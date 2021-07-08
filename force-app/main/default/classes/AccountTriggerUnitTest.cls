@isTest
public class AccountTriggerUnitTest {
    public static testMethod void AccountTriggerTest(){
        Account acc = new Account(Name ='Test Account');
        insert acc;
        List<Opportunity> op = new List<Opportunity>();
        
        for(Integer i=0;i<10;i++){
            Opportunity o = new Opportunity(
            	Name = 'Opportunity Test '+ String.valueOf(i),
                CloseDate = System.today().addMonths(12),
                StageName ='Close Won',
                AccountId = acc.Id
            );
            op.add(o);
        }
        insert op;
        Test.startTest();
        try{
            
        }catch(System.Exception ex){
            
        }
        Test.stopTest();
    }
}