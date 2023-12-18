public class eg1_0505_shedule implements schedulable {
    public void execute(schedulablecontext sa) {
        list<operation__c> ol= [select id,name from operation__c];
        for(operation__c eo:ol) {
            eo.name='liver transplantation';
            update eo;
                }
    }

}