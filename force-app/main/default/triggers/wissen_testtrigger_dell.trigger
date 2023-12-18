trigger wissen_testtrigger_dell on Dell_entity_orders__c (before insert) {
    Dell_entity_orders__c[] dell = Trigger.new;
wissen_teste_1.gst(dell);

}