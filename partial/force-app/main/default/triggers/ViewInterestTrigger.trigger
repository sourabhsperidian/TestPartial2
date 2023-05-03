trigger ViewInterestTrigger on View_Interest__c (before insert) {
	ViewInterestTriggerHandler.beforeInsert(trigger.new);
}