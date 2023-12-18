trigger account_trigger_forall on account (after insert) {
if(trigger.isinsert && trigger.isafter){
    handlerclass_2exp_practice.accountid_in_acc(trigger.new);
}
}