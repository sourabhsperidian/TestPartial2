trigger Amazon_Files on Amazon_Files__c (after insert, after update) {
    Integer count = 0;
    for (Amazon_Files__c obj : Trigger.new) {
        if (obj.Status__c == 'Submitted') {
            count++;
        }
    }
    System.debug('Number of records with Submit Status "Submitted": ' + count);
    Id unitid = Trigger.new[0].Unit__c;
    Unit__c idd = new Unit__c(Id = unitid);
    idd.CountAmazonFiles__c=count;
    update idd;
}