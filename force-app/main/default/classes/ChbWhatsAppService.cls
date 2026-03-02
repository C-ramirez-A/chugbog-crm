public with sharing class ChbWhatsAppService {
    @AuraEnabled
    public static Alumno__c sendWhatsAppToAlumno(Id alumnId, String messageBody){
        if (alumnId==null || String.isBlank(messageBody)) {
            System.debug('alumno o mensaje no encontrado');
            return null;
        }
        List<Alumno__c> alumns=[SELECT  Id, Name, CelularWhatsApp__c FROM Alumno__c WHERE Id =:alumnId LIMIT 1];
        if (alumns.isEmpty()){
            System.debug('alumno no encontrado');
            return null;
        }
        Alumno__c alumn= alumns[0];
        if (String.isBlank(alumn.CelularWhatsApp__c)) {
            System.debug('celular no encontrado');
            return null;
        }
        else {
        System.debug('mensaje enviado'+ messageBody);
        Map<String,Object> payload= new Map<String,Object>();
        payload.put('to',alumn.CelularWhatsApp__c);
        payload.put('message',messageBody);
        payload.put('originSystem','ChugBogCRM');
        String jsonBody=JSON.serialize(payload);
        System.debug('payload Generado '+ jsonBody);

        Http http = new Http();
        HttpRequest req= new HttpRequest();
        req.setEndpoint('callout:Chb_Httpbin/post');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);

        try {
            HttpResponse res= http.send(req);
            Integer StatusCode = res.getStatusCode();
            String status= res.getStatus();
            String body= res.getBody();
            System.debug('🌍 Respuesta del endpoint httpbin:');
            System.debug('Status code: ' + statusCode + ' (' + status + ')');
            System.debug('Body: ' + body);
        } catch(Exception e){
             System.debug('❌ Error realizando el callout: ' + e.getMessage());
        }
        return alumn;
        }
       
    }
}