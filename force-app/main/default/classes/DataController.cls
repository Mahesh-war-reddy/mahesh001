public with sharing class DataController {
    
    
    
    @AuraEnabled
    
    public static List<Lead> getLeadsWithOffset(String pageSize, String pageNumber){ 
        
        Integer ps = Integer.valueOf(pageSize);
        
        Integer pn = Integer.valueOf(pageNumber)-1;
        
        List<Lead> led = [SELECT id,name,Company,Email,Status FROM  Lead where status ='Working - Contacted' WITH SECURITY_ENFORCED 
                          LIMIT :Integer.valueOf(ps) OFFSET :(ps*pn)];
        
        return led;
        
    }
    @AuraEnabled
    public static list<Lead> getLeadList(string searchKey) {
        string searchKeyword = '%' + searchKey + '%';
        system.debug(searchKeyword);
        // create Lead list to store search result 
        list<Lead> LeadListRecord = new list<Lead>(); 
        
        // query Lead records
        // 
        
        for(Lead leadObj : [Select id,name,Company,Email,Status
                            From Lead 
                            WHERE name LIKE : searchKeyword or company LIKE : searchKeyword or Email LIKE : searchKeyword WITH SECURITY_ENFORCED]){
                                LeadListRecord.add(leadObj);
                            }
        
        if(LeadListRecord.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
        }
        
        return LeadListRecord;
    }
    
    @AuraEnabled
    public static List<Lead> selectedLEad(string[] prName ){
        system.debug('wb'+prName);
        
        List<Lead> nn = [select id,name,Company,Email,Status from Lead where id in:prName WITH SECURITY_ENFORCED];
        //List<Lead> nn = new list <Lead>();
       // for (id a : prName){ 
          //  Lead aaa= [select id,name,Company,Email,Status from Lead where id =:a ];
           // nn.add(aaa);
       // }
        Integer size = nn.size();
        system.debug('selected list'+size);
        
        system.debug(nn);
        return nn;
    }
    
    @AuraEnabled
    public static list<lead> totalLeads(){
        list<lead> total = [select id,name,status from lead where status = 'Working - Contacted' WITH SECURITY_ENFORCED];
        System.debug('total' +total);
       
        return total;
    }

    @AuraEnabled
    public static list<lead> totalLeads2(string statusKey){
        if(statusKey=='ALL'){
        list <lead> selectedLead = [select id,name ,company,Email,Status from Lead WITH SECURITY_ENFORCED ];
            return selectedLead;
        }
        else{
        list<lead> total = [select id,name,status from lead where status =: statusKey WITH SECURITY_ENFORCED];
        System.debug('total' +total);
        
        return total;
        }
    }

    @AuraEnabled
    public static list<lead> getLeadStatus (string statusKey){
        System.debug('Lead Status' +statusKey);
         
        
       if(statusKey=='ALL'){
            list <lead> selectedLead = [select id,name ,company,Email,Status from Lead  WITH SECURITY_ENFORCED];
            return selectedLead;
        }else{
             list <lead> selectedLead = [select id,name ,company,Email,Status from Lead where status =:statusKey WITH SECURITY_ENFORCED ];

        return selectedLead;
        }
    }


    //  @AuraEnabled
    // public static List<Lead> duplicateLead(string[] prName ){
    //     system.debug('wbssss'+prName);
        
    //     list <account> accList=[select id,name from account];
        
    //     List<Lead> nn = new list <Lead>();
      
    //   list<Lead> aaa= [select id,name,Company,Email,Status from Lead where id =:prName ];
    //     for(lead a :aaa){
            
    //         for(account c:accList){
    //             if(a.company==c.name){
    //                 nn.add(a);
    //             }
    //         }
    //     }
    //          system.debug('Final List'+nn);
        
       
    //     return nn;
    // }
    

    @AuraEnabled
    public static list <Lead> duplicateStatus(list<lead> duplicateStatusId ){
        
        system.debug('iddd'+ duplicateStatusId);
        list<id>leadidssss=new list<id>();
        for(lead l5:duplicateStatusId){
            leadidssss.add(l5.id);
        }
        List<Lead> duplicateStatusLead = [SELECT ID, Status FROM LEAD WHERE ID =: leadidssss WITH SECURITY_ENFORCED ];
        List<Lead>emptyList=new List<Lead>();
        for(Lead dsl:duplicateStatusLead){
            dsl.status ='Duplicate - Not Converted';
            emptyList.add(dsl);
        }
        
        if(Schema.sObjectType.lead.isUpdateable()) {
            // return null;
            if(!emptyList.isempty()){
              database.update(emptyList,false);  
                return emptyList;
            }
           // database.update(emptyList,false);
            return null;
       //return emptyList;
        }
        else{
            //database.update(emptyList,false);
            return null;
        }
        //system.debug('emptyList'+ emptyList);
       // return emptyList;
    }

   
    @AuraEnabled
       public static void mergeleads(){ 
        list<lead>listofleads=[select id,lastname,email,phone,MobilePhone,fax,company,LeadSource,Website,Rating,Industry,AnnualRevenue,Description,Status from lead where status='Working - Contacted' WITH SECURITY_ENFORCED];
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
           if(Schema.sObjectType.lead.isUpdateable() ) {
        database.update(duplicatedmergedleads,false);
         database.update(masterlead.values(),false);
           }
    }  
}