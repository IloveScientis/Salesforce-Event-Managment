@IsTest
public class TestUtility {
    
    public static Account prepareAccount( String Name ) {
        Account acc = new Account( 
            Name = Name, 
            Description = ' Account With Setup Method ', 
            Phone ='0918227448',
            Fax ='2345678901'
                    
        );
        /*
        Account acc1 = new Account( Name = 'Account New', Description = ' Account With Setup Method New');
        insert acc1;*/
        
        return acc;
    }
    
    public static List<Account> prepareAccount( String Name, Integer no ) {
    
        List<Account> accountList = new List<Account>();
        
        for ( Integer i=0; i < no; i++ ) {
            Account acc = new Account( 
                Name = Name+' '+String.valueOf(i), 
                Description = ' Account With Setup Method ',
                Phone ='0918227448'  
                  
            );
        }
        return accountList;
    }
    
    public static Contact prepareContact( String AccountId, String FirstName, String LastName, String Email ) {
        Contact con = new Contact( FirstName = FirstName, LastName = LastName , AccountId = AccountId,
                                   Email = Email );
        return con;
    }
    
    public static Contact prepareContactForVerifyNum(String AccountId , String FirstName, String LastName, String Phone){
        Contact con = new Contact(FirstName = FirstName, LastName = LastName, AccountId =AccountId, Phone= Phone);
        return con;
    }
    public static List<Contact> prepareContact( String AccountId, String FirstName, String LastName, Integer no ) {
    
        List<Contact> contactList = new List<Contact>();
        
        for (Integer i=0; i < no; i++) {
        
            Contact con = new Contact( FirstName = FirstName, LastName = LastName +' ' + String.valueOf(i) , AccountId = AccountId,
                                   Email = 'stevenduong_'+i+'@gmail.com' );
            contactList.add(con);
                                   
        }
        return contactList;
    }

}