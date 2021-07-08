@isTest
public class VerifyPhoneNumbersUnitTest {
	@testSetup
    public static void setUpData(){
        Account acc = TestUtility.prepareAccount('verify Account');
        insert acc;
        
		Contact con = TestUtility.prepareContact(acc.Id, 'FirstName', 'LastName', 'emailVerify@gmail.com');
        insert con;
        Contact con1 = TestUtility.prepareContactForVerifyNum(acc.Id, 'FirstName', 'LastName', '3125961002');
        insert con1;
       
        
    }
    
    public static testMethod void doFutureTest(){
        Contact con = [Select Id,Name from Contact where Email ='emailVerify@gmail.com'];
        Test.startTest();
        	//Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbers());
        	Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbersMock());
        	VerifyPhoneNumbers.doFuture(con.Id);
        Test.stopTest();
    }
    
    public static testMethod void sobjectAsParamTest(){
        Contact con = [Select Id,Name from Contact where Email ='emailVerify@gmail.com'];
        Test.startTest();
        	//Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbers());
        	Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbersMock());
        	VerifyPhoneNumbers.sobjectAsParam(JSON.serialize(con));
        Test.stopTest();
    }
    
    public static testMethod void ErrorMockTest(){
        Contact con = [Select Id,Name, Phone from Contact where Email ='emailVerify@gmail.com'];
        Test.startTest();
        	//Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbers());
        	Test.setMock(HttpCalloutMock.class, new VerifyPhoneNumbersErrorMock());
        	VerifyPhoneNumbers.vefiryNum(con,'Phone');
        Test.stopTest();        
    }
}