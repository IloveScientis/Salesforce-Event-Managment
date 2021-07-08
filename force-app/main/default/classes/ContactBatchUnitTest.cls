@isTest
public class ContactBatchUnitTest {
    @testSetup
    public static void setupData(){
        Account acc = TestUtility.prepareAccount('stevenduong');
        insert Acc;
        List<Contact> contactList = TestUtility.prepareContact(acc.Id, 'Steven', 'Duong', 200);
        insert contactList;
    }
    public static TestMethod void  ContactBatchTest(){
        Test.startTest();
        	Id Batch = Database.executeBatch( new ContactBatch(), 205);
        Test.stopTest();
    }
}