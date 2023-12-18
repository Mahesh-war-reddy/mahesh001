public class handlerclass_2exp_practice {
    public static boolean run=true;
    public static void claname(list<contact> newlist_contacts){
        list<string>newlist_emailphone=new list<string>();
        for(contact newcon:newlist_contacts){
            if((newcon.Email !=null && newcon.Email !='') || (newcon.phone !=null && newcon.phone !='')){
                newlist_emailphone.add(newcon.phone); 
                newlist_emailphone.add(newcon.email);
                //test1 control+shift+/
                //hello this is test

            }
            
            
        }
        list<string>database_emailphone=new list<string>();
        list<contact>listdatabase_contacts=[select id ,name ,phone,email from contact where phone in:newlist_emailphone and email in:newlist_emailphone];
        if(listdatabase_contacts.size()>0){
            for(contact c:listdatabase_contacts){
                database_emailphone.add(c.phone);
                database_emailphone.add(c.email);
            }
            for(contact each_newcon:newlist_contacts){
                if(database_emailphone.contains(each_newcon.email)){
                    each_newcon.email.adderror('email already exixts');
                }
                
                if(database_emailphone.contains(each_newcon.phone)){
                    each_newcon.phone.adderror('phone already exixts');   
                }else{
                    database_emailphone.add(each_newcon.phone);
                    database_emailphone.add(each_newcon.email); 
                }
            }
        }
        
    }
    public static void updatingcasenumbertoparent_andcreateaccount(list<case> new_case){
        list<account>ac=new list<account>();
        
        for(case ch:new_case){ 
            account acc=new account();
            acc.Id=ch.AccountId;
            acc.Description=ch.CaseNumber;
            ac.add(acc);
        }
        list<account>newac=new list<account>();
        for(case ch:new_case){
            account acc=new account();
            acc.Name=ch.CaseNumber;
            acc.Description=ch.CaseNumber;
            newac.add(acc);
        }
        database.insert(newac,false);
        database.update (ac,false);
    }
    
    
    
    public static void countupdateofcontacttoaccount(list<contact> newconlist){
        if( FeatureManagement.checkPermission('Trigger_Exeption')){
            system.debug('trueeeeeeeeeee');
            return;
        }
        
        set<id>accids=new set<id>();
        for(contact each_con:newconlist){
            accids.add(each_con.accountid);  
        }
        list<account>updateaccount=new list<account>();
        map<id,account>acclist=new map<id,account>([select id ,name ,(select id,name from contacts) from account where id in:accids]);
        
        if(!acclist.isempty() ){
            for(account ac:acclist.values()){
                account acc=new account();
                acc.id=ac.id;
                acc.AnnualRevenue=acclist.get(ac.id).contacts.size();
                updateaccount.add(ac);
            } 
        }
        database.update(updateaccount,false); 
    }
    
    
    
    
    //*********************************************************************************************************
    public static void oppammountcount(list<opportunity>newopp){
        list<account>updatelistacc=new list<account>();
        set<id>accountid=new set<id>();
        for(opportunity opp:newopp){
            if(opp.accountid !=null && opp.accountid !=''){
                
                
                accountid.add(opp.accountid);
            }
        }
        updatelistacc=oppcount(accountid);
        database.update(updatelistacc,false);
    }
    
    public static void updateoppammountcount(list<opportunity>newopp ,map<id,opportunity> mapoldopp){
        set<id>accid=new set<id>();
        list<account>acctoupdate=new list<account>();
        for(opportunity op:newopp){
            if(op.Amount!= null && op.Amount !=mapoldopp.get(op.id).amount ){
                accid.add(op.AccountId);              
            }
        }
        acctoupdate=oppcount(accid);
        database.update(acctoupdate,false);
        
    }
    
    public static list<account> oppcount(set<id> ids){
        
        
        map<id,decimal>mapof_ammount=new map<id,decimal>();
        list<account>updateaccount=new list<account>();
        list<opportunity>list_opportunity=[select id ,amount from opportunity where accountid in:ids];
        
        for(opportunity op:list_opportunity ){
            decimal amount=0;
            if(mapof_ammount.containskey(op.AccountId)){
                amount=op.Amount+mapof_ammount.get(op.AccountId);
                mapof_ammount.put(op.AccountId,amount) ;
            }else{
                //mapof_ammount.put(op.AccountId,op.Amount) ;
                //amount=op.Amount;
                mapof_ammount.put(op.AccountId,op.Amount) ;
            }  
            
            
        }
        for(id i:mapof_ammount.keyset()){
            account acc=new account(id=i);
            acc.AnnualRevenue=mapof_ammount.get(i);
            updateaccount.add(acc);
        }
        return updateaccount;
        
    }
    public static void method1(list<opportunity> opp){
        set<id>setopp=new set<id>();
        for(opportunity op:opp){
            setopp.add(op.accountid);
        }
        
        map<id,account>mapacc=new map<id,account>([select id,(select id from opportunities) from account where createddate=today and id in:setopp]);
        
        for(opportunity op:opp){
            if(mapacc.get(op.accountid).opportunities.size()>5){
                op.adderror('already have 5 records today');
                
            }
        }
        
        
    }
    
    public static void opplineitemupdatein_account(list<opportunitylineitem>opplinenew){
        
        set<id>newopplids=new set<id>();
        for(opportunitylineitem opl:opplinenew){
            newopplids.add(opl.OpportunityId);
        }
        list<opportunity>opplist=[select id,accountid,(select id from opportunitylineitems) from opportunity where id in :newopplids ];
        map<id,decimal>oppcount=new map<id,decimal>();
        
        for(opportunity op:opplist){
            if(oppcount.get(op.AccountId)==null){
                oppcount.put(op.AccountId,op.opportunitylineitems.size());
            }else{
                oppcount.put(op.AccountId,oppcount.get(op.AccountId)+op.opportunitylineitems.size()) ; 
            }
            
            
        }

        list<account>acclist=new list<account>();
        for(id ids:oppcount.keyset()){
            account acc= new account(id=ids);
            //acc.id=ids;
            acc.Description=string.valueof(oppcount.get(ids));
            acclist.add(acc);
            
        }
        update  acclist;      
        
    }
    public static void methodz(){
        test1__mdt cumstummetadata=test1__mdt.getinstance('test22');
      /**  SIP_Shift_Timings__c shiftTimes=SIP_Shift_Timings__c.getinstance();
         Time shift1StartTime = parseTime(shiftTimes.Morning_Shift_Start_Time__c);
         public static time parseTime(String timeValue) {
        // Splitting the time value string by ":" delimiter
        String[] strTimeSplit = timeValue.split(':');
        // Creating a new instance of Time with the parsed hour and minute values
        // The seconds and milliseconds are set to 0
        Time timeChange = Time.newInstance(Integer.valueOf(strTimeSplit[0]) ,Integer.valueOf(strTimeSplit[1]) ,0 ,0);
        // Returning the parsed time
        return timeChange;
    } */
        system.debug('hi'+cumstummetadata.A_FIELD__c);
        
    }
    public static void accountid_in_acc(list<account>accnewlist){
        list<account>acc_list=new list<account>();
        set<id>accid=new set<id>();
        for(account acc:accnewlist){

            accid.add(acc.id);
            
           // acc_list.add(acc);
        }
        list<account>acc=[select id,Description from account where id in:accid];
        for(account acc_each:acc){
            acc_each.Description=acc_each.id;
            acc_list.add(acc_each);
        }
        update acc_list;
    }
    
    
    
    
}