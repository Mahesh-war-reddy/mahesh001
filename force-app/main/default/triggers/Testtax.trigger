trigger Testtax on Lava_Dealers__c (before insert) {
    for(Lava_Dealers__c tax:trigger.new) {
        if(tax.Country__c =='India') {
            tax.Actuall_ammount__c=tax.Actuall_ammount__c*1.2;
            tax.Tax_Status__c='	Tax applied';
        } else if(tax.Country__c =='Usa') {
            tax.Actuall_ammount__c=tax.Actuall_ammount__c*1.3;
            tax.Tax_Status__c='	Tax applied';
        } else {
            tax.Actuall_ammount__c= tax.Actuall_ammount__c;
            tax.Tax_Status__c='Tax Not applied';
        }
    }

}