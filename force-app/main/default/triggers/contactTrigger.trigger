trigger contactTrigger on Contact (before insert, before update) {

    if (trigger.isBefore) {
        if (trigger.isInsert) {
            contactTriggerHandler.ManageEmail(trigger.new);
        }        
        if (trigger.isUpdate) {
            contactTriggerHandler.ManageEmail(trigger.new);
        }
    }

}