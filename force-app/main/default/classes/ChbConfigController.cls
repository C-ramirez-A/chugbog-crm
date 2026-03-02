public with sharing class ChbConfigController {
    @AuraEnabled(cacheable=true)
    public static string getInitialMessage() {
        Chb_UI_Settings__mdt initialMessage= [SELECT Mensaje_Inicial__c FROM Chb_UI_Settings__mdt WHERE DeveloperName = 'Default' LIMIT 1];
        
        if (initialMessage != null) {
            return initialMessage.Mensaje_Inicial__c;
        }
        else {
            return 'Ingresa Un Documento de Identidad';
        }


    }
}