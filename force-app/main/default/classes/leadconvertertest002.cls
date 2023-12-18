public class leadconvertertest002 {
    @AuraEnabled
    public static map<string,list<sobject>>leaddd(List<String>idtoconvert,string oppcreation){
     //   RecordWrapper records = new RecordWrapper();
        map<string,list<sobject>> allnewrec=new map<string,list<sobject>>();
        System.debug('listof lead id'+ idtoconvert);
        System.debug('listof lead id'+ oppcreation);
        list<lead> leadList = [select id,name,company,email,Status,lastname from lead where id IN:idtoconvert];
        system.debug('lead list==>'+leadList);
        //  List<Lead> leadList = [SELECT Company,email,lastname FROM Lead]; 
        list<contact>contactlist=[select name,email,accountid,account.name from contact];
        List<Account> accountList = [SELECT Name FROM Account];
        map<string,Account> newAccountList = new map<string,Account>();
        List<contact> newconlistList = new List<contact>();
        List<opportunity> newopportunitylist = new List<opportunity>();
        list<lead>listofacc_coverted_leads=new  list<lead>();
        
        list<lead>duplicateleads=new  list<lead>(); 
        list<lead>convertedconlist=new list<lead>(); //convertedconlist
        Map<String, Account> accountlistMap_name = new Map<String, Account>(); 
        Map<String, contact> contactlistMap_email = new Map<String, contact>(); 
        for(Account account : accountList) {
            accountlistMap_name.put(account.Name, account); 
        } 
        for(contact contact1 : contactlist) {
            contactlistMap_email.put(contact1.email, contact1); 
        }
        for(Lead lead : leadList) { 
            
            if (accountlistMap_name.containsKey(lead.Company)) { 
                System.debug( 'matches an account name'+lead.Company);
                if((contactlistMap_email.containsKey(lead.email)) && (contactlistMap_email.get(lead.email).account.name == lead.Company)){
                    duplicateleads.add(lead); 
                }else{
                    contact newcon= new contact();
                    newcon.lastname=lead.LastName;
                    newcon.AccountId=accountlistMap_name.get(lead.Company).id;
                    newconlistList.add(newcon);
                    convertedconlist.add(lead);
                    if(oppcreation=='true'){ // to create opportunity when user clicks true
                        opportunity newopp=new opportunity();
                        newopp.Name=lead.lastname+'opp'+system.today();
                        newopp.AccountId=accountlistMap_name.get(lead.Company).id;
                        newopp.CloseDate=system.today()+30;
                        newopp.StageName='Prospecting';
                        newopportunitylist.add(newopp);
                        
                    }
                }
            } else { 
                // Account newAccount= new Account();
                account newaccount=new account();
                newAccount.name=lead.Company;
                newAccountList.put(newAccount.name,newAccount); 
                system.debug('new account id'+newaccount.id);
                listofacc_coverted_leads.add(lead);
            }
        }
       // records.accs.addAll(newAccountList.values());
       allnewrec.put('Account',newAccountList.values());
        
        System.debug('convertedlist'+convertedconlist);
        database.insert (newAccountList.values(),false); //inserting accounts
        for(lead each_converted_acclead:listofacc_coverted_leads){ // this loop will take new created account records and pass ID to new con&opp
            contact newcon=new contact();
            newcon.LastName=each_converted_acclead.lastname;
            newcon.AccountId=newAccountList.get(each_converted_acclead.Company).id; // to get account id based on the lead company name
            newconlistList.add(newcon);
            convertedconlist.add(each_converted_acclead);
            if(oppcreation=='true'){ // only create opportunity when user clicks yes
                opportunity nopp=new opportunity();
                nopp.Name=each_converted_acclead.lastname+'opp'+system.today();
                nopp.AccountId=newAccountList.get(each_converted_acclead.Company).id;
                nopp.CloseDate=system.today()+30;
                nopp.StageName='Prospecting';
                
                //convertedconlist.add(lm);
                newopportunitylist.add(nopp);
                
                
            }
        }
        
       // records.cons.addAll(newconlistList); // giving the list to wrapper
       // records.opps.addAll(newopportunitylist);
       // records.leds.addAll(duplicateleads);
       allnewrec.put('Contacts',newconlistList);
        allnewrec.put('opportunity',newopportunitylist);
        allnewrec.put('Leads',duplicateleads);
        
        database.insert (newconlistList,false);
        
        // status update to convertedconlist;
        list<lead>updatedStatus_Leads=new list<lead>();
        for(lead updateLeadStatus_To_ConvertedLead:convertedconlist){
            updateLeadStatus_To_ConvertedLead.Status='Closed - Converted';
            updatedStatus_Leads.add(updateLeadStatus_To_ConvertedLead);
        }
        database.update(updatedStatus_Leads,false); //it will update lead status to closed converted
       // system.debug('return value'+records); 
        database.insert (newopportunitylist,false);
        system.debug('new accounts'+newAccountList.values());
        system.debug('new contacts'+newconlistList);
        system.debug('new opportunity'+newopportunitylist);
        system.debug('duplicate leads'+duplicateleads);
         system.debug(' all the created data'+allnewrec);
        return allnewrec;
    }
    //method used to get all duplicvate lead data along with merge status to merge or skip
    @AuraEnabled
    public static list<contact> mergedcontocts(list<lead>duplicateleadss,string mergestatus,string oppormergecre){
        map<string,lead>mapduplicateleads=new map<string,lead>();
        list<opportunity>mergerec_opportunity=new list<opportunity>();
        list<contact>updatedcontactlist=new list<contact>();
        //if mergrstatus is true then it will merge related lead with contact based on email match
        if(mergestatus=='true'){
            //this used to put email as a key for the perticular contacts
            for(lead ldd:duplicateleadss){
                ldd.Status='Closed - Converted';
                mapduplicateleads.put(ldd.email,ldd);
            }
            
            list<contact>conlist2=[select id ,lastname,email,phone,accountid from contact where email in:mapduplicateleads.keyset()];
            
            //based on each contact email ,it will get matching lead to merge and it will be added to updatedcontactlist .
            for(contact mergecon:conlist2){
                mergecon.email=mergecon.email !=null?mergecon.email:mapduplicateleads.get(mergecon.email).email;
                mergecon.phone=mergecon.phone !=null?mergecon.phone:mapduplicateleads.get(mergecon.email).phone;
                mergecon.MobilePhone=mergecon.MobilePhone !=null?mergecon.MobilePhone:mapduplicateleads.get(mergecon.email).MobilePhone;
                if(oppormergecre=='true'){
                    opportunity op=new opportunity();
                    op.Name=mergecon.lastname+'opp'+system.today();
                    op.AccountId=mergecon.accountid;
                    op.CloseDate=system.today()+30;
                    op.StageName='Prospecting';
                    mergerec_opportunity.add(op);
                }
                
                updatedcontactlist.add(mergecon);
            }
            //it will update the data which mean merge.
            database.update (updatedcontactlist,false);
        }
        //if merge status is skip then it will directly skip and delete leads without merge
        // delete duplicateleadss;
        
        database.update (mapduplicateleads.values(),false);
        system.debug('updated conmtacts'+updatedcontactlist);
        return updatedcontactlist; // updatedContactList
    }    
    
}