public with sharing class ChbAttendanceController { 
    @AuraEnabled(cacheable=false)
    public static Alumno__c getAlumnosByCC(String CC) {
        if (String.isBlank(CC)) {
            return null;
        }
       List<Alumno__c> alumns= [ SELECT Id, Name, N_mero_de_identidad__c, Estado__c FROM Alumno__c WHERE N_mero_de_identidad__c = :CC LIMIT 1];
        if(alumns.isEmpty()){
            return null;
        }
        return alumns[0];
    }

    @AuraEnabled
    public static void markAttendance(Id alumnId){
        Asistencia__c Asist= new Asistencia__c(
                    Alumno__c = alumnId,
                    Name= 'Asistencia ' + Date.today(),
                    Fecha__c = Date.today(),
                    HoraEntrada__c = System.now().time(),
                    MetodoRegistro__c= 'Manual' );
       
    insert Asist;
    }
}