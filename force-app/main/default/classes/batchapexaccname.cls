Global class batchapexaccname implements Database.Batchable<sObject> {
    global database.QueryLocator start(Database.BatchableContext bc){
        //string ac=;
        return database.getQueryLocator('select id,Name from account');
    }
    global void execute(database.BatchableContext bc,list<account> ac){
        list<account>nacc=new list<account>();
        for(account ac1:ac){
            ac1.name=ac1.name+'reddy';
            nacc.add(ac1);
        }
        try{
        update nacc;
            system.debug('jjjjjjjjjjjjjjkjdcnhkdnhckjd'+nacc);
        }catch(exception e){
            system.debug(e);
        }
            
    }
    global void finish(database.BatchableContext bc){
        
    }

}