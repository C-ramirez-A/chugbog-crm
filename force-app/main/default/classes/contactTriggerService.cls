public with sharing class contactTriggerService {
    public static void emailDefault(List<contact> newTrigger) {
        List<contact> listChecked = new List<contact>();
        for (contact con : newTrigger) {
           if (con.email.isBlank() || con.email==null) {
            OldTrigger.email='no-reply@example.com';
        } 
        }

    }
}