trigger delll_entity_manufacture on Dell_entity_orders__c (before insert ,before update,before delete) {
    if(trigger.isinsert || trigger.isupdate){
for(Dell_entity_orders__c d: trigger.new){
if(d.Manufacturing_cost__c == null){
d.Manufacturing_cost__c = 200.0;
system.debug(d);
}
}

}
    if(trigger.isdelete){
for (Dell_entity_orders__c d0: Trigger.old) {
if (d0.Name!= 'mahesh') {
d0.addError('You can\'t delete this record!');


}
}
}
    if(trigger.isinsert || trigger.isupdate){
for(Dell_entity_orders__c d1: trigger.new){
if(d1.sell_price__c == null){
d1.sell_price__c.addError('this field  is Mandatory');
}
}

}
    if(trigger.IsUpdate){
for(Dell_entity_orders__c each5 : trigger.New){
if(each5.Profit__c != trigger.OldMap.get(each5.Id).Profit__c){
each5.Profit__c.addError('You cannot upadte profit.');

}

}
}
/*for(Dell_entity_orders__c d6 : trigger.New) {
                for(Dell_entity_orders__c d7 : trigger.old) {
                    if(d6.Id == d7.Id && d6.Profit__c != d7.Profit__c) {
                        d6.Profit__c.addError('You cannot update profit field.');
                    }
                }
            } */

}