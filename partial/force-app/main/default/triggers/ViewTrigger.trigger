trigger ViewTrigger on Viewing__c (before insert) {
	ViewTriggerHandler.beforeInsert(trigger.new);
}