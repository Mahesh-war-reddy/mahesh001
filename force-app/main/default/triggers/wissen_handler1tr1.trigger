trigger wissen_handler1tr1 on Account (after insert) {
    wissen_triggerhandlertr1 th =new wissen_triggerhandlertr1();
    if(Trigger.isInsert && Trigger.isAfter){
th.afterInsert(Trigger.New);
}

}