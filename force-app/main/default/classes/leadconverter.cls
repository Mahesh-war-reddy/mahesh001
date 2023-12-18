/**
@Description         :Class helps to covert Multiple Lead to Account ,contact ,Opportunities based on the user requirement and duplicates found
@Author              : Maheshwar Reddy Nevoori
@Last Modified By    : Mahesh51620war Reddy Nevoori
@Last Modified On    : 05/12/2023
@Modification Log    :
Ver               Date                  Author                      LastModification
1.0           03/12/2023         Maheshwar  Reddy                   Initial Version
**/



public with sharing class leadconverter {
    
    
    //this wrapper method used to srore data of new created Accounts,Contacts,Opportunity
    public class RecordWrapper {
        @AuraEnabled public List<Account> accs =new List<Account>();
        @AuraEnabled public List<Contact> cons=new List<Contact>();
        @AuraEnabled public List<Opportunity> opps=new List<Opportunity>();
        @AuraEnabled public List<Lead> leds=new List<Lead>();
        
    /*    public RecordWrapper() {
            accs=new List<Account>();
            cons=new List<Contact>();
            opps=new List<Opportunity>();
            leds=new List<Lead>();
        } */
    }
    
    @AuraEnabled
    public static RecordWrapper leaddd(List<String> idtoconvert,string oppcreation){
        RecordWrapper records = new RecordWrapper();
        //bellow 3 collection(leadList,contactlist,accountList) used to get the data from Data base.
        list<lead> leadList = [select id,name,company,email,Status,lastname,title,fax,Mobilephone,Description,LeadSource,phone from lead where id IN:idtoconvert WITH SECURITY_ENFORCED];
        system.debug('lead list==>'+leadList);
        list<string>leademail=new list<string>();
        list<string>leadcompanyname=new list<string>();
        for(lead eachemaillead:leadList){
            leademail.add(eachemaillead.email);
            leadcompanyname.add(eachemaillead.Company);
        }
        list<contact>contactlist=[select name,email,accountid,account.name,title,LeadSource,phone,mobilephone,fax,Description from contact where email in:leademail WITH SECURITY_ENFORCED]; 
        List<Account> accountList = [SELECT Name FROM Account where name in:leadcompanyname WITH SECURITY_ENFORCED];
        
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
        }
        System.debug( 'list contacts'+contactlistMap_email);
        
        for(Lead lead : leadList) {
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
                    newcon.Title=lead.Title;
                    newcon.LeadSource=lead.LeadSource;
                    newcon.phone=lead.Phone;
                    newcon.MobilePhone=lead.MobilePhone;
                    newcon.Fax=lead.Fax;
                    newcon.Description=lead.Description;
                    
                    //newconlistList.add(newcon);
                    newconlistList.put(newcon.email+lead.Company,newcon);
                    convertedconlist.add(lead);
                    
                    if(oppcreation=='true'){ // to create opportunity when user clicks true
                        opportunity newopp=new opportunity();
                        Date dat = System.Today();
                        newopp.Name=lead.lastname+'opp'+dat.format(); 
                        newopp.AccountId=accountlistMap_name.get(lead.Company).id;
                        newopp.CloseDate=system.today()+30;
                        newopp.StageName='Prospecting';
                        newopp.LeadSource=lead.LeadSource;
                        newopportunitylist.add(newopp);
                    }
                    
                }
            } else { 
                // Account newAccount= new Account();
                
                account newAccount=new account();
                newAccount.name=lead.Company;
                newAccountList.put(newAccount.name,newAccount); 
               
                listofacc_coverted_leads.add(lead);
            }
            
        }
        
        
        
        System.debug('convertedlist'+convertedconlist);
        if(Schema.sObjectType.account.IsCreateable()){
            
        
        database.insert (newAccountList.values(),false); //inserting accounts
        }
        records.accs.addAll(newAccountList.values());
        
        for(lead each_converted_acclead:listofacc_coverted_leads){ // this loop will take new created account records and pass ID to new con&opp
            if(newconlistList.containskey(each_converted_acclead.email+each_converted_acclead.company)){
                duplicateleads.add(each_converted_acclead);   
            }else{
                contact newcon=new contact();
                newcon.LastName=each_converted_acclead.lastname;
                newcon.Email=each_converted_acclead.Email;
                newcon.AccountId=newAccountList.get(each_converted_acclead.Company).id; // to get account id based on the lead company name
                newcon.Title=each_converted_acclead.Title;     
                newcon.LeadSource=each_converted_acclead.LeadSource;       
                newcon.phone=each_converted_acclead.Phone;      
                newcon.MobilePhone=each_converted_acclead.MobilePhone;        
                newcon.Fax=each_converted_acclead.Fax;      
                newcon.Description=each_converted_acclead.Description;       
                
                //newconlistList.add(newcon);
                newconlistList.put(newcon.email+each_converted_acclead.company,newcon);
                convertedconlist.add(each_converted_acclead);
                
                if(oppcreation=='true'){ // only create opportunity when user clicks yes
                    opportunity nopp=new opportunity();
                    Date dat = System.Today();
                    nopp.Name=each_converted_acclead.lastname+'opp'+dat.format();
                    nopp.AccountId=newAccountList.get(each_converted_acclead.Company).id;
                    nopp.CloseDate=system.today()+30;
                    nopp.StageName='Prospecting';
                    nopp.LeadSource=each_converted_acclead.LeadSource;
                    //convertedconlist.add(lm);
                    newopportunitylist.add(nopp);
                    
                }  
            }
        }
        
        records.cons.addAll(newconlistList.values()); // giving the list to wrapper
        records.opps.addAll(newopportunitylist);
        records.leds.addAll(duplicateleads);
        if(Schema.sObjectType.contact.IsCreateable()){
            
        
        database.insert (newconlistList.values(),false); //inserting contact
        }
        //database.insert (newconlistList.values(),false);
        
        // status update to convertedconlist;
        list<lead>updatedStatus_Leads=new list<lead>();
        for(lead updateLeadStatus_To_ConvertedLead:convertedconlist){
            updateLeadStatus_To_ConvertedLead.Status='Closed - Converted';
            updatedStatus_Leads.add(updateLeadStatus_To_ConvertedLead);
        }
        if(Schema.sObjectType.lead.isUpdateable() ) {
        database.update(updatedStatus_Leads,false); //it will update lead status to closed converted
        }
        system.debug('return value'+records); 
        if(Schema.sObjectType.opportunity.isCreateable() ) {
        database.insert (newopportunitylist,false);
        }
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
    public static wrapperForDuplicateleads mergeDuplicateLeadtoContacts1(list<Lead>duplicateleadids,string mergestatus,string opportunityCreationStatus){
        wrapperForDuplicateleads records2 = new wrapperForDuplicateleads();
        list<opportunity>mergerec_opportunity=new list<opportunity>();
        list<contact>updatedcontactlist=new list<contact>();
        list<lead>leadtobeUpdated=new list<lead>();
        List<string>leadmail=new list<string>();
        Map<string,contact>updatedcontact2=new  Map<string,contact>(); 
        
        map<string,contact>mapcon=new map<string,contact>();
        system.debug('duplicateleadids'+duplicateleadids);
        
        for(lead eachDuplicateLead:duplicateleadids){ 
            eachDuplicateLead.Status='Closed - Converted';
            leadtobeUpdated.add(eachDuplicateLead);
            leadmail.add(eachDuplicateLead.email);
        } 
        if(mergestatus=='true'){
            list<contact>conlist2=[select id ,lastname,email,Phone,AccountId,account.name,LeadSource,fax,MobilePhone,title,Description from contact where email in:leadmail and accountid !=null WITH SECURITY_ENFORCED];
            if(conlist2.size()>0)
                for(contact c:conlist2){
                    mapcon.put(c.email+c.account.name,c); 
                }
            system.debug('print map'+mapcon);
            for(lead eachleadtoBeUpdated:leadtobeUpdated){
                contact contacttobeMergedFromDuplicateLead; //it will store contact which to be updated by duplicate lead
                system.debug('eachleadtoBeUpdated'+eachleadtoBeUpdated);
                if(updatedcontact2.containsKey(eachleadtoBeUpdated.Email+eachleadtoBeUpdated.Company)){
                    contacttobeMergedFromDuplicateLead=updatedcontact2.get(eachleadtoBeUpdated.email+eachleadtoBeUpdated.Company);
                }else{
                    contacttobeMergedFromDuplicateLead=mapcon.get(eachleadtoBeUpdated.Email+eachleadtoBeUpdated.Company);
                    system.debug('contacttobeMergedFromDuplicateLead'+contacttobeMergedFromDuplicateLead); 
                }
                //system.debug('contacttobeMergedFromDuplicateLead'+contacttobeMergedFromDuplicateLead); //
                contacttobeMergedFromDuplicateLead.phone=contacttobeMergedFromDuplicateLead.phone !=null?contacttobeMergedFromDuplicateLead.phone:eachleadtoBeUpdated.Phone;
                contacttobeMergedFromDuplicateLead.fax=contacttobeMergedFromDuplicateLead.fax !=null?contacttobeMergedFromDuplicateLead.fax:eachleadtoBeUpdated.fax;
                contacttobeMergedFromDuplicateLead.MobilePhone=contacttobeMergedFromDuplicateLead.MobilePhone !=null?contacttobeMergedFromDuplicateLead.MobilePhone:eachleadtoBeUpdated.MobilePhone;
                contacttobeMergedFromDuplicateLead.LeadSource=contacttobeMergedFromDuplicateLead.LeadSource !=null?contacttobeMergedFromDuplicateLead.LeadSource:eachleadtoBeUpdated.LeadSource;
                contacttobeMergedFromDuplicateLead.title = contacttobeMergedFromDuplicateLead.title != null?contacttobeMergedFromDuplicateLead.title:eachleadtoBeUpdated.title;
                contacttobeMergedFromDuplicateLead.Description = contacttobeMergedFromDuplicateLead.Description != null?contacttobeMergedFromDuplicateLead.Description:eachleadtoBeUpdated.Description; 
                if(opportunityCreationStatus=='true'){
                    opportunity op=new opportunity();
                    Date dat = System.Today();
                    op.Name=eachleadtoBeUpdated.lastname+'opp'+dat.format();
                    op.AccountId=contacttobeMergedFromDuplicateLead.AccountId;
                    op.CloseDate=system.today()+30;
                    op.StageName='Prospecting';
                    mergerec_opportunity.add(op);
                }
                updatedcontact2.put(contacttobeMergedFromDuplicateLead.email+contacttobeMergedFromDuplicateLead.account.name,contacttobeMergedFromDuplicateLead);
            }
            if(Schema.sObjectType.contact.isUpdateable() ) {
            database.update(updatedcontact2.values(),false);
            }
            if(mergerec_opportunity!=null){
                 if(Schema.sObjectType.opportunity.isCreateable() ) {
                database.insert(mergerec_opportunity,false);
                 }
                system.debug('oppcreation'+mergerec_opportunity);
            }
        }
        //if merge status is skip then it will directly skip and delete leads without merge
        // delete duplicateleadss;
         if(Schema.sObjectType.lead.isUpdateable() ) {
        database.update (leadtobeUpdated,false);
         }
        system.debug('updated contacts'+updatedcontact2);
        system.debug('updated leads'+leadtobeUpdated);
        // return updatedcontactlist; // updatedContactList
        records2.mergrcon.addAll(updatedcontact2.values()); 
        records2.mergeopp.addAll(mergerec_opportunity); 
        return records2;
    }    
}