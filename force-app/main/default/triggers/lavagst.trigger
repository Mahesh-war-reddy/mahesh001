trigger lavagst on Order_details__c (before insert) {
    for(Order_details__c o:trigger.new) {
        o.Ammount__c=o.Ammount__c*1.2;
        
    }

}