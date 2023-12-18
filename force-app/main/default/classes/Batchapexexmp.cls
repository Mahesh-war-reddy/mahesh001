global class Batchapexexmp implements Database.Batchable<SObject> , Database.stateful
{
    Global Decimal scount = 0.00;
     Global Database.QueryLocator start(Database.BatchableContext bcontext){
      //  string srchquery = 'Select id , name , phone , fax , annualrevenue from account';
        return Database.getQueryLocator([ Select id , name , phone , fax , annualrevenue from account where annualrevenue != null]);
    }
    Global void Execute(Database.BatchableContext bcontext , list<SObject> recordsToprocess){
          
        if(!recordsToprocess.isempty()){
            list<Account> Acp = new list<Account>();
            for(SObject tobeup : recordsToprocess){
                Account Acc = (Account)tobeup;
               scount += Acc.AnnualRevenue ;
             
        }
            System.debug(scount);
    }
    }
    Global void finish(Database.BatchableContext bcontext){      
         System.debug('the batch id is '+bcontext.getJobId());
        System.debug('the value is '+scount);

    }
}