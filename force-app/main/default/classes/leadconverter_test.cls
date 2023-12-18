@isTest
public class leadconverter_test {
    

    @isTest
    static void testLeaddd() {      
        
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i ,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
               //LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            ));
        }
         for (Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i ,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
               // LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            ));
        }
        
        
   lead l =new lead();
        l.company='Testm1';
        l.Email='test1@test.com';
        l.status='Working - Contacted';
        l.FirstName='k';
        l.LastName='j';
        l.Fax='99';
         testLeads.add(l); 
        list<account>accountlist=new list<account>();
          account acclist=new account();
          acclist.name='Testm2';
          insert acclist;
    
          contact con3=new contact();
          con3.LastName='testm1';
          con3.Email='test3@test.com';
          con3.accountid=acclist.id;
          insert con3;
          insert testLeads; // 2 lead records
        List<String> leadIdsToConvert = new List<String>();
         for (Lead lead : testLeads) {
            leadIdsToConvert.add(lead.Id);
         }
        
        // Call the method being tested
        Leadconverter.RecordWrapper records = Leadconverter.leaddd(leadIdsToConvert, 'true');
       // Leadconverter.mergeleads(); 
      //  LeadConvertTest.wrapperForDuplicateleads records2=LeadConvertTest.mergeDuplicateLeadtoContacts1(leadIdsToConvert,'true','true');
            //LeadConvertTest.mergeDuplicateLeadtoContacts1(leadIdsToConvert,'true','true');
        
       System.assertEquals(1, [SELECT COUNT() FROM Lead limit 1]);
    }
     @isTest
    static void testLeaddd2() {  
         List<Lead> testLeads1 = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            testLeads1.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
                phone='99',
              // LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            ));
        }
          list<account>accountlist=new list<account>();
        for(Integer i = 0; i < 5; i++){
           accountlist.add(new account(
                name='Testm'+i
           )); 
        }
        insert accountlist;
         list<contact>conlist=new list<contact>();
        for(integer i=0; i<5; i++){
            conlist.add(new contact(
                lastname='testm'+i,
                email='test'+i+'@test.com',
                accountid=accountlist.get(i).id,
                Fax='65',
                Phone='9'
                
            ));
        }
        insert conlist;
          
    
     insert testLeads1; 
    List<String> leadIdsToConvert1 = new List<String>();
         for (Lead lead : testLeads1) {
            leadIdsToConvert1.add(lead.Id);
         }
         //Leadconverter.wrapperForDuplicateleads records2=
             Leadconverter.mergeDuplicateLeadtoContacts1(testLeads1,'true','true');
        
        System.assertEquals(1, [SELECT COUNT() FROM Account limit 1]);
    }  
    @istest
    private static void testmethod3(){
          List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
                phone='99',
              // LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            )); 
        } 
        insert testLeads;
        list<string>listleadid= new list<string>();
        for(lead el:testLeads){
         listleadid.add(el.id);   
        }
        DataController.getLeadsWithOffset('1','1');
        DataController.getLeadList('s');
        DataController.selectedLEad(listleadid);
        DataController.totalLeads();
        DataController.getLeadStatus('All'); 
            
        DataController.getLeadStatus('notall');
        DataController.totalLeads2('All');
        DataController.totalLeads2('NotAll');
        DataController.duplicateStatus(testLeads);
        
        DataController.mergeleads();
        
        System.assertEquals(1, [SELECT COUNT() FROM Lead limit 1]);
    }
     @istest
    private static void testmethod4(){
          List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
                phone='99',
              // LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            )); 
        } 
        for (Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i ,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
               // LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            ));
        }
        
        insert testLeads;
         DataController.mergeleads();
        
        System.assertEquals(1, [SELECT COUNT() FROM Lead limit 1]);
    }
}