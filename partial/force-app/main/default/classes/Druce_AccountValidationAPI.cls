@RestResource(urlMapping='/accounts/*')
global class Druce_AccountValidationAPI {

    @HttpGet
    global Static List<Account> getAccount(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String strJSON;
        string jsonString = req.requestBody.tostring();
        system.debug('jsonString : '+jsonString);
        Map<String, object> m = (Map<String, object>) JSON.deserializeUntyped(jsonString);
        String email = m.get('email').tostring();
        String mobile_num = m.get('mobile_num').tostring();
        System.debug(email + ' '+ mobile_num);
        List<Account> acc = [select Id,name,PersonEmail,PersonMobilePhone,Phone from account where (PersonEmail =: email OR PersonMobilePhone =: mobile_num OR Phone =: mobile_num)];
   			return acc;
    }
}