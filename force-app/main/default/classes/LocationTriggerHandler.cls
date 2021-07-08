public class LocationTriggerHandler {
    @future(callout=true)
    public static void verifyAddress(string recordsId){
        //
        String baseURL = 'https://us-street.api.smartystreets.com/street-address?auth-id=31cfc85c-d4ca-2f88-d843-6062f5cf8960&auth-token=CJUBPN45JGsDSKmCLZeP&';
       Location__c location=[SELECT Id, City__c,Verified__c, Country__c, Postal_Code__c, State__c, Street__c, Name FROM Location__c where Id =: recordsId];  
       baseURL+=
           'street='+EncodingUtil.urlEncode(location.Street__c, 'UTF-8')+
           '&city='+EncodingUtil.urlEncode(location.City__c,'UTF-8')+
           '&state='+EncodingUtil.urlEncode(location.State__c,'UTF-8')+
           '&zipcode='+EncodingUtil.urlEncode(location.Postal_Code__c,'UTF-8')+
           '&match=invalid';
       System.debug('BaseURL '+baseURL);
       HttpRequest httprequest = new HttpRequest();
       httprequest.setMethod('GET');       
       httprequest.setEndpoint(baseURL);
       //httprequest.setHeader('Content-Type', 'application/json');
        
       Http http = new Http();
       
       HttpResponse response = new HttpResponse();
        try{
            response = http.send(httprequest);
            if(response.getStatusCode()==200 && response.getStatus()=='OK'){
                String responseBody=response.getBody();
                System.debug(responseBody);
                if(!String.isBlank(responseBody)&& responseBody.length()>2){
                    location.Verified__c=true;
                }else{
                    location.Verified__c=false;
                }
                update location;   
            }else{
                TransactionLogHandler.doHandleExceptionWithError(response.getBody(), 'LocationTriggerHandler');
            }
        }catch(System.CalloutException ex){
            TransactionLogHandler.doExceptionHandler(ex, 'LocationTriggerHandler');
        }
    }
}