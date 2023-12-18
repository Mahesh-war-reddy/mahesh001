trigger taxtesttt on Paymenttest__c (before insert) {
    for(Paymenttest__c tax:trigger.new) {
        if(tax.Tax_applied__c==true) {
           tax.Ammount__c=tax.Ammount__c*1.2; 
        }
    }
}