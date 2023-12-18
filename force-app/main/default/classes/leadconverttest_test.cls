@isTest
private class leadconverttest_test {
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
               LeadSource='Web',
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
               LeadSource='Web',
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
        LeadConvertTest.RecordWrapper records = LeadConvertTest.leaddd(leadIdsToConvert, 'true');
        leadconverttest.mergeleads(); 
      //  LeadConvertTest.wrapperForDuplicateleads records2=LeadConvertTest.mergeDuplicateLeadtoContacts1(leadIdsToConvert,'true','true');
            //LeadConvertTest.mergeDuplicateLeadtoContacts1(leadIdsToConvert,'true','true');
        
        // Verify results
        System.assertEquals(0, records.accs.size(), 'Should only create one new account');
        System.assertEquals('TestCompany0', records.accs[0].Name, 'New account should have correct name');
        System.assertEquals(2, records.cons.size(), 'Should create two new contacts');
        System.assertEquals('TestFirstName0', records.cons[0].LastName, 'New contact should have correct last name');
        System.assertEquals('TestFirstName1', records.cons[1].LastName, 'New contact should have correct last name');
        System.assertEquals(2, records.opps.size(), 'Should create two new opportunities');
        System.assertEquals('TestLastName0opp' + Date.today(), records.opps[0].Name, 'New opportunity should have correct name');
        System.assertEquals('TestLastName1opp' + Date.today(), records.opps[1].Name, 'New opportunity should have correct name');
        System.assertEquals(0, records.leds.size(), 'Should not have any duplicate leads'); 
        
        // Verify lead statuses were updated
        List<Lead> updatedLeads = [SELECT Id, Status FROM Lead WHERE Id IN :leadIdsToConvert];
        System.assertEquals(2, updatedLeads.size(), 'Should have updated statuses for all converted leads');
        for (Lead lead : updatedLeads) {
            System.assertEquals('Closed - Converted', lead.Status, 'Lead should have updated status');
        }
    }
     @isTest
    static void testLeaddd2() {  
         List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'Testm'+i,
                Email = 'test'+i+'@test.com',
                Status = 'Working - Contacted',
               LeadSource='Web',
                AnnualRevenue=0,
                Rating='Hot',
                Industry='Banking',
                Description='h'
                
            ));
        }
          list<account>accountlist=new list<account>();
          account acclist=new account();
          acclist.name='Testm2';
          insert acclist;
    
          contact con3=new contact();
          con3.LastName='testm1';
          con3.Email='test3@test.com';
          con3.accountid=acclist.id;
          insert con3;
    
     insert testLeads; 
    List<String> leadIdsToConvert = new List<String>();
         for (Lead lead : testLeads) {
            leadIdsToConvert.add(lead.Id);
         }
         LeadConvertTest.wrapperForDuplicateleads records2=LeadConvertTest.mergeDuplicateLeadtoContacts1(leadIdsToConvert,'true','true');
    }  
}