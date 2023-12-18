trigger test1 on Review__c (before insert) {
    if(trigger.isinsert && trigger.isbefore) {
        list<Review__c> r=trigger.new ;
        test11.positionstatus(r);
    }

}