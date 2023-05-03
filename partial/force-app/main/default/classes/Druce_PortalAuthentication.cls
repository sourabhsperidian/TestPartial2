public class Druce_PortalAuthentication {

    public static String getToken(){
        
        Credentials__mdt authcred = Credentials__mdt.getInstance('Portal_User');
        String email = authcred.username__c;
        String password = authcred.password__c;

        HttpRequest reque = new HttpRequest();
        reque.setEndpoint('https://dxsfapi.speridian.com/api/v1/auth/signin');
        reque.setMethod('POST');
        reque.setHeader('Content-Type', 'application/json');
        reque.setBody('{"email":"'+ email +'",' +
                      '"password":"' + password +'"}');
        Http httpgettoken = new Http();
        HTTPResponse resp = httpgettoken.send(reque);
        Map<String, Object> responsbody = (Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
        system.debug(responsbody);
       // Map<String, Object> datastruct = (Map<String, Object>)responsbody.get('response');
        //Map<String, Object> tokenstruct = (Map<String, Object>)datastruct.get('token');
        Object securityToken = (Object)responsbody.get('response');
//        string newstr = securityToken.tostring();
	    string accessToken = securityToken.tostring();
       // string tok = newstr.substring(newstr.indexOf('accessToken'),newstr.length()-1);
       // string accessToken= tok.substring(tok.indexof('=')+1,tok.length());
        system.debug(accessToken);
        return accessToken;
    }
}