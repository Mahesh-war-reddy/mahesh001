@isTest
private class MassApprovalRejectReassignControlTest {
    
    @testSetup
    static void setup() {
        // Add test data, if needed
   
        account acc=new account();
        acc.name='Maheshwar reddy';
        insert acc;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting for approval');
        req.setObjectId(acc.Id);
        
        Id actorId = userinfo.getUserId(); // Replace with the User Id of the specific approver
        system.debug(actorId);
       // req.setNextApproverIds(new List<Id>{actorId});
        Approval.ProcessResult result = Approval.process(req);
        
         ProcessInstanceWorkItem proInst = [SELECT Id, ActorId FROM ProcessInstanceWorkItem limit 1];
            proInst.ActorId = actorId;
        update proInst;
        
    }
    
    @isTest
    static void testFetchPendingApprovalRecords() {
        list<string>fieldnames=new list<string>{'phone','isdeleted','fax'};
        
        // Test fetchPendingApprovalRecords method
        Test.startTest();
        //List<MassApprovalRejectReassignControl.MassApprovalWrapper> actualMAWs = MassApprovalRejectReassignControl.fetchPendingApprovalRecords();
        MassApprovalRejectReassignControl.getApprovalObjects();
        MassApprovalRejectReassignControl.getFields('Account');
        MassApprovalRejectReassignControl.allRecords();
        MassApprovalRejectReassignControl.fetchPendingApprovalRecords2();
        MassApprovalRejectReassignControl.fetchPendingApprovalRecords('account',fieldnames);
        Test.stopTest();
        
        // Add assert statements to verify the results
        
    }
    
    @isTest
    static void testMassApproveRecords() {
        // Test massApproveRecords method
        String selectedRows = '[{"PIWId":"123","status":"Pending","objectRecordId":"001xx000003D1KzAAK","name":"Test Record","objType":"Custom Object","createdBy":"Test User"}]';
        String comment = 'Test comment';
        Test.startTest();
        String actualMessage = MassApprovalRejectReassignControl.massApproveRecords(selectedRows, comment);
        Test.stopTest();
        // Add assert statements to verify the results
    }
    
    @isTest
    static void testMassRejectRecords() {
        // Test massRejectRecords method
        String selectedRows = '[{"PIWId":"123","status":"Pending","objectRecordId":"001xx000003D1KzAAK","name":"Test Record","objType":"Custom Object","createdBy":"Test User"}]';
        String comment = 'Test comment';
        Test.startTest();
        String actualMessage = MassApprovalRejectReassignControl.massRejectRecords(selectedRows, comment);
        Test.stopTest();
        // Add assert statements to verify the results
    }
    
    @isTest
    static void testUserlist() {
        // Test userlist method
        Test.startTest();
        List<User> actualUsers = MassApprovalRejectReassignControl.userlist();
        Test.stopTest();
        // Add assert statements to verify the results
    }
    
    @isTest
    static void testMassReassignRecords() {
        // test massReassignRecords method
        String recordId = '[]'; // set test data
        String userId = UserInfo.getUserId(); // set test data
        String comment = 'test comment'; // set test data
        Test.startTest();
        String result = MassApprovalRejectReassignControl.massReassignRecords(recordId, userId, comment);
        Test.stopTest();
        System.assertEquals('success', result);
    }
    
}