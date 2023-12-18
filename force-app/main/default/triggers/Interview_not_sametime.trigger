trigger Interview_not_sametime on Interview__c (before insert) 
{
    list<Interview__c> intr=trigger.new;
    interviewnotsame.intrtime(intr);
}