trigger UnitPreferenceTrigger on Unit_Preference__c (after Insert) {
    Druce_UnitPreferenceHandler.afterInsert(Trigger.new);
}