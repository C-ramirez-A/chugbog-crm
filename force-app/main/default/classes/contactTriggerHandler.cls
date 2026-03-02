public with sharing class contactTriggerHandler {
    public static void ManageEmail(List<Contact> newTrigger) {
        contactTriggerService.emailDefault(newTrigger);
    }
}