trigger test3 on Applications__c (before insert, before update) {
    list<Applications__c> appa=trigger.new;
test33.extendoffer(appa);
}