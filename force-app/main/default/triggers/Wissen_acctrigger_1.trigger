trigger Wissen_acctrigger_1 on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
system.enqueueJob(new wissen_queabletrigger_concre1(Trigger.new)); 
}

}