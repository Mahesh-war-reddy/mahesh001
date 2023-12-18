public class leadconverttest {
      public static void mergeleads(){
      // public c= mergewith;
       // string c=mergewit;
        list<lead>listofleads=[select id,lastname,email,phone,fax,company from lead where status='Working - Contacted' ];
        map<string,lead>masterlead=new map<string,lead>();
        map<id,lead>mergelead=new map<id,lead>();
        list<lead>duplicatedmergedleads=new list<lead>();
        for(lead eachlead:listofleads){
            if(masterlead.containskey(eachlead.email+eachlead.company)){
              mergelead.put(eachlead.id,eachlead);
            }else{
              masterlead.put(eachlead.Email+eachlead.company,eachlead);  
            }
        }
        for(lead l:mergelead.values()){
            lead ll=masterlead.get(l.email+l.Company);
            ll.phone=ll.phone !=null?ll.phone:l.Phone;
            ll.fax=ll.fax !=null?ll.fax:l.fax;
            ll.MobilePhone = ll.MobilePhone != null?ll.MobilePhone:l.MobilePhone;
               ll.LeadSource = ll.LeadSource != null?ll.LeadSource:l.LeadSource;
            ll.Website = ll.Website != null?ll.Website:l.Website;
            ll.Rating = ll.Rating != null?ll.Rating:l.Rating;
            ll.Industry = ll.Industry != null?ll.Industry:l.Industry;
            ll.AnnualRevenue = ll.AnnualRevenue != null?ll.AnnualRevenue:l.AnnualRevenue;
            ll.Description = ll.Description != null?ll.Description:l.Description;
            l.Status='Closed - Not Converted';
            l.Description='lead was merged with the master record with id='+ll.id+''+'name is'+ll.LastName+''+'withe the compony '+ll.Company;
            duplicatedmergedleads.add(l);
            masterlead.put(l.email+l.Company,ll);
        }
        database.update(duplicatedmergedleads,false);
         database.update(masterlead.values(),false);
        system.debug('duplicate list'+duplicatedmergedleads);
    }  
 
    //this wrapper method used to srore data of new created Accounts,Contacts,Opportunity
    public class RecordWrapper {
        @AuraEnabled public List<Account> accs;
        @AuraEnabled public List<Contact> cons;
        @AuraEnabled public List<Opportunity> opps;
        @AuraEnabled public List<Lead> leds;
        
        public RecordWrapper() {
            accs=new List<Account>();
            cons=new List<Contact>();
            opps=new List<Opportunity>();
            leds=new List<Lead>();
        }
    }
    
    @AuraEnabled
    public static RecordWrapper leaddd(List<String> idtoconvert,string oppcreation){
        RecordWrapper records = new RecordWrapper();
        //bellow 3 collection(leadList,contactlist,accountList) used to get the data from Data base.
        list<lead> leadList = [select id,name,company,email,Status,lastname from lead where id IN:idtoconvert];
        system.debug('lead list==>'+leadList);
          list<string>leademail=new list<string>();
        list<string>leadcompanyname=new list<string>();
        for(lead eachemaillead:leadList){
            leademail.add(eachemaillead.email);
            leadcompanyname.add(eachemaillead.Company);
        }
        list<contact>contactlist=[select name,email,accountid,account.name from contact where email in:leademail]; 
        List<Account> accountList = [SELECT Name FROM Account where name in:leadcompanyname];
        
        //bellow 4 collection used to capture newly created opportunity,contacts,accounts also duplicate leads.
        map<string,Account> newAccountList = new map<string,Account>();
       // List<contact> newconlistList = new List<contact>();
       map<string,contact>newconlistList=new map<string,contact>();
        List<opportunity> newopportunitylist = new List<opportunity>();
        list<lead>duplicateleads=new  list<lead>(); 
        
        
        //used to store newly creted account leads 
        list<lead>listofacc_coverted_leads=new  list<lead>();
        //map<string
        
        list<lead>convertedconlist=new list<lead>(); //convertedconlist
        Map<String, Account> accountlistMap_name = new Map<String, Account>(); 
        Map<String, contact> contactlistMap_email = new Map<String, contact>(); 
        
        
        for(Account account : accountList) {
            accountlistMap_name.put(account.Name, account); 
        } 
        
        for(contact contact1 : contactlist) {
            contactlistMap_email.put(contact1.email+contact1.account.name, contact1);
            // matching_Contact_email.add(contact1.email);
        }
        
        System.debug( 'list contacts'+contactlistMap_email);
        
        for(Lead lead : leadList) { //we have to work on cache memory records
            if (accountlistMap_name.containsKey(lead.Company) ) { 
                if(contactlistMap_email.containskey(lead.email+lead.company) || newconlistList.containskey(lead.email+lead.company)){
                    duplicateleads.add(lead); 
                    system.debug('dupleads'+duplicateleads);
                }else{
                    system.debug('company name name'+lead.Company);
                    contact newcon= new contact();
                    newcon.lastname=lead.LastName;
                    newcon.AccountId=accountlistMap_name.get(lead.Company).id;
                    newcon.Email=lead.email;
                    //newconlistList.add(newcon);
                  newconlistList.put(newcon.email+lead.Company,newcon);
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
                
                account newAccount=new account();
                newAccount.name=lead.Company;
                newAccountList.put(newAccount.name,newAccount); 
                system.debug('new account id'+newAccount.id);
                listofacc_coverted_leads.add(lead);
            }
            
        }
        
        
        
        System.debug('convertedlist'+convertedconlist);
        database.insert (newAccountList.values(),false); //inserting accounts
        records.accs.addAll(newAccountList.values());
        for(lead each_converted_acclead:listofacc_coverted_leads){ // this loop will take new created account records and pass ID to new con&opp
            if(newconlistList.containskey(each_converted_acclead.email+each_converted_acclead.company)){
              duplicateleads.add(each_converted_acclead);   
            }else{
            contact newcon=new contact();
            newcon.LastName=each_converted_acclead.lastname;
            newcon.Email=each_converted_acclead.Email;
            newcon.AccountId=newAccountList.get(each_converted_acclead.Company).id; // to get account id based on the lead company name
            //newconlistList.add(newcon);
            newconlistList.put(newcon.email+each_converted_acclead.company,newcon);
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
        }
        
        records.cons.addAll(newconlistList.values()); // giving the list to wrapper
        records.opps.addAll(newopportunitylist);
        records.leds.addAll(duplicateleads);
        database.insert (newconlistList.values(),false);
        
        // status update to convertedconlist;
        list<lead>updatedStatus_Leads=new list<lead>();
        for(lead updateLeadStatus_To_ConvertedLead:convertedconlist){
            updateLeadStatus_To_ConvertedLead.Status='Closed - Converted';
            updatedStatus_Leads.add(updateLeadStatus_To_ConvertedLead);
        }
        database.update(updatedStatus_Leads,false); //it will update lead status to closed converted
        system.debug('return value'+records); 
        database.insert (newopportunitylist,false);
        system.debug('new accounts'+newAccountList.values());
        system.debug('new contacts'+newconlistList);
        system.debug('new opportunity'+newopportunitylist);
        system.debug('duplicate leads'+duplicateleads);
        return records;
    }
    //method used to get all duplicvate lead data along with merge status to merge or skip
  
    public class wrapperForDuplicateleads {
        @AuraEnabled public list<contact> mergrcon;
        @AuraEnabled  public list<opportunity> mergeopp;
        
        public wrapperForDuplicateleads(){
            mergrcon=new list<contact>();
            mergeopp=new list<opportunity>();
        }
    }
     @AuraEnabled
    public static wrapperForDuplicateleads mergeDuplicateLeadtoContacts1(list<string>duplicateleadids,string mergestatus,string opportunityCreationStatus){
        wrapperForDuplicateleads records2 = new wrapperForDuplicateleads();
        list<opportunity>mergerec_opportunity=new list<opportunity>();
        list<contact>updatedcontactlist=new list<contact>();
        list<lead>leadtobeUpdated=new list<lead>();
        Map<string,contact>updatedcontact2=new  Map<string,contact>(); 
        
        map<string,contact>mapcon=new map<string,contact>();
        
        for(lead ldd:[select id,lastname,email,fax,phone,LeadSource,MobilePhone,company from lead where id in:duplicateleadids]){ 
            ldd.Status='Closed - Converted';
            leadtobeUpdated.add(ldd);
        }
        if(mergestatus=='true'){
            list<contact>conlist2=[select id ,lastname,email,phone,AccountId,account.name,LeadSource,fax,MobilePhone from contact where AccountId!=null];
            if(conlist2.size()>0)
                for(contact c:conlist2){
                    mapcon.put(c.email+c.account.name,c); 
                }
            for(lead lf:leadtobeUpdated){
                contact cupp;
                if(updatedcontact2.containsKey(lf.Email+lf.Company)){
                    cupp=updatedcontact2.get(lf.Email+lf.Company);
                }else{
                    cupp=mapcon.get(lf.Email+lf.Company);
                }
                cupp.phone=cupp.phone !=null?cupp.phone:lf.phone;
                cupp.fax=cupp.fax !=null?cupp.fax:lf.fax;
                cupp.MobilePhone=cupp.MobilePhone !=null?cupp.MobilePhone:lf.MobilePhone;
                cupp.LeadSource=cupp.LeadSource !=null?cupp.LeadSource:lf.LeadSource;
                if(opportunityCreationStatus=='true'){
                    opportunity op=new opportunity();
                    op.Name=lf.lastname+'opp'+system.today();
                    op.AccountId=cupp.AccountId;
                    op.CloseDate=system.today()+30;
                    op.StageName='Prospecting';
                    mergerec_opportunity.add(op);
                }
                updatedcontact2.put(cupp.email+cupp.account.name,cupp);
            }
            database.update(updatedcontact2.values(),false);
            if(mergerec_opportunity!=null){
            database.insert(mergerec_opportunity,false);
            system.debug('oppcreation'+mergerec_opportunity);
            }
        }
        //if merge status is skip then it will directly skip and delete leads without merge
        // delete duplicateleadss;
        database.update (leadtobeUpdated,false);
        system.debug('updated contacts'+updatedcontact2);
        system.debug('updated leads'+leadtobeUpdated);
       // return updatedcontactlist; // updatedContactList
         records2.mergrcon.addAll(updatedcontact2.values()); 
        records2.mergeopp.addAll(mergerec_opportunity); 
        return records2;
    }    
}