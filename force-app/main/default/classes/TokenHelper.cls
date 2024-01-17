public with sharing class TokenHelper {
 
    private static final String CREDENTIALNAME_TOKEN = 'token';
    private static final String CREDENTIALNAME_EXPIRES = 'expires';
 
    public static Boolean checkTokenValidity(String externalCredName){
 
        ConnectApi.ExternalCredential externalCred = ConnectApi.NamedCredentials.getExternalCredential(externalCredName);
 		System.debug('externalCred >>> '+ externalCred);
        if(externalCred != null && !externalCred.principals.isEmpty()){
 
            ConnectApi.Credential cred = ConnectApi.NamedCredentials.getCredential(externalCredName, externalCred.principals[0].principalName, ConnectApi.CredentialPrincipalType.NamedPrincipal);
			System.debug('cred >>>> '+ cred.credentials);
            if(cred != null && cred.credentials.containsKey(CREDENTIALNAME_TOKEN) && cred.credentials.containsKey(CREDENTIALNAME_EXPIRES)){
 
                ConnectApi.CredentialValue expires = cred.credentials.get(CREDENTIALNAME_EXPIRES);
 				System.debug('expires >>> '+ expires);
                return (expires.value != null && Datetime.valueOf(expires.value) > Datetime.now());
            }
        }
 
        return false;
    }
     
 
    public static void updateToken(String externalCredName, String newToken, Datetime expires){
 
        ConnectApi.ExternalCredential externalCred = ConnectApi.NamedCredentials.getExternalCredential(externalCredName);
 
        if(externalCred != null && !externalCred.principals.isEmpty()){
 
            ConnectApi.Credential cred = ConnectApi.NamedCredentials.getCredential(externalCredName, externalCred.principals[0].principalName, ConnectApi.CredentialPrincipalType.NamedPrincipal);
 
            if(cred != null){
 
                Boolean mappingExistsAlready = true;
 
                Map<String, Object> input = convertCredToInput(cred);
 
                if(((Map<String, Map<String, Object>>)input.get('credentials')).keySet().isEmpty()){
                    mappingExistsAlready = false;
                }
 
                ((Map<String, Map<String, Object>>)input.get('credentials')).put(CREDENTIALNAME_TOKEN, new Map<String, Object>{
                        'encrypted' => true,
                        'value' => newToken
                });
 
                ((Map<String, Map<String, Object>>)input.get('credentials')).put(CREDENTIALNAME_EXPIRES, new Map<String, Object>{
                        'encrypted' => false,
                        'value' => String.valueOf(expires)
                });
 
                //ConnectAPI conAPI = new ConnectAPI();
 
                //HttpResponse resp = conAPI.updateNamedCredential(input, mappingExistsAlready);           
            }   
        }
    }
 
 
 
    public static Map<String, Object> convertCredToInput(ConnectApi.Credential cred){
 
        Map<String, Object> input = new Map<String, Object>();
        input.put('authenticationProtocol', String.valueOf(cred.authenticationProtocol));
        input.put('externalCredential', String.valueOf(cred.externalCredential));
        input.put('principalName', String.valueOf(cred.principalName));
        input.put('principalType', String.valueOf(cred.principalType));
 
        Map<String, Map<String, Object>> credentials = new Map<String, Map<String, Object>>();
 
        for(String credKey : cred.credentials.keySet()){
             
            ConnectApi.CredentialValue credValue = cred.credentials.get(credKey);
 
            credentials.put(credKey, new Map<String, Object>{
                'value' => credValue.value,
                'encrypted' => credValue.encrypted
            });
 
        }
 
        input.put('credentials', credentials);
 
        return input;
    }
}