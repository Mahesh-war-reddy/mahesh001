trigger test2 on Applications__c (after insert , after update) {
    list<Applications__c> apps=trigger.new;
test22.positionclosed(apps);
}