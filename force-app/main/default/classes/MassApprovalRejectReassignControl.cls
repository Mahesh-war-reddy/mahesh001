/**
@Description         :Class helps to deal Multiple Approval Request to reassign,Approve,Reject based on the user Action.
@Author              : Maheshwar Reddy Nevoori && RaviChandra Kopperla
@Last Modified By    : Maheshwar Reddy Nevoori
@Last Modified On    : 26/10/2023
@Modification Log    :
Ver              Date               			 Author                        								 LastModification
1.0           6/09/2023         RaviChandra Kopperla  and Maheshwar Reddy Nevoori                  Initial Version
**/




public class MassApprovalRejectReassignControl { 
    @AuraEnabled(cacheable=true)
    public static List<String> getApprovalObjects() {
        set<String> approvalObjects = new set<String>();
        id iii=UserInfo.getUserId();
        system.debug('userinfo'+UserInfo.getUserId());
        // Query to fetch all objects with active approval processes
        List<ProcessInstanceWorkitem> processInstances = [SELECT ProcessInstance.TargetObjectId,ProcessInstance.TargetObject.Type
                                                  FROM ProcessInstanceWorkitem
                                                  WHERE ProcessInstance.Status = 'Pending' AND ActorId =: UserInfo.getUserId()];
        system.debug('userinfo'+processInstances);
        // Populate the approvalObjects list with unique object names
        for (ProcessInstanceWorkitem processInstance : processInstances) {
            approvalObjects.add(processInstance.ProcessInstance.TargetObject.Type);
        }
        List<String> approvalObjects2 = new List<String>(approvalObjects);
                
        return approvalObjects2;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> getFields(string objectName) {
        SObjectType accountType = Schema.getGlobalDescribe().get(objectName);
        list<Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap().values();
        List<String> fields = new List<String>();
        for(Schema.SObjectField flds : mfields){
            if(string.valueof(flds) != 'Name')
                fields.add(string.valueof(flds));
        }
        return fields;
    }
    
    @AuraEnabled( cacheable = true )
    public static List <ProcessInstanceStep> allRecords() { 
        
        List<ProcessInstanceStep> pis = [select id, StepStatus,comments,
                                       ProcessInstanceId, ProcessInstance.TargetObject.Type, Actor.Name,
                                       ProcessInstance.TargetObject.Name, ProcessInstance.TargetObjectId 
                                       from ProcessInstanceStep 
                                       where StepStatus != 'Started' 
                                       AND ActorId =: UserInfo.getUserId()];
        return pis;
    } 
    
    @AuraEnabled( cacheable = true )
    public static List < MassApprovalWrapper > fetchPendingApprovalRecords2() {
        
        List < MassApprovalWrapper > listMAWs = new List < MassApprovalWrapper >();
        Set < Id > setRecordIds = new Set < Id >();
        List < ProcessInstanceWorkitem > listPIWs = [
            SELECT Id, Actor.Name, ProcessInstance.Status, ProcessInstance.TargetObjectId,
            ProcessInstance.TargetObject.Name,ProcessInstance.SubmittedBy.Name, ProcessInstance.TargetObject.Type, ProcessInstance.CreatedBy.Name,ProcessInstance.CreatedDate
            FROM ProcessInstanceWorkitem
            WHERE ActorId =: UserInfo.getUserId() 
        ];
        Map<Id, String> stepsMap = new Map<Id, String>();
        Map<String, String> labelsMap = new Map<String, String>();
        for(ProcessInstanceStep pis : [select id, StepStatus,comments,ProcessInstance.TargetObject.Type,
                                       ProcessInstanceId from ProcessInstanceStep 
                                       where stepstatus = 'Started' 
                                       AND ActorId =: UserInfo.getUserId() ]){
                                           string obj = string.valueof(pis.ProcessInstance.TargetObject.Type);
                                           string objLabel = (String)Schema.getGlobalDescribe().get(obj).getDescribe().getLabel();
                                           labelsMap.put(pis.ProcessInstance.TargetObject.Type, objLabel);
                                           stepsMap.put(pis.ProcessInstanceId,pis.comments);
                                       }
        for ( ProcessInstanceWorkitem objPIW : listPIWs ) {
            
            MassApprovalWrapper objMAW = new MassApprovalWrapper();
            objMAW.PIWId = objPIW.Id;
            objMAW.submittedBy = objPIW.ProcessInstance.SubmittedBy.Name;
            objMAW.approverName = objPIW.Actor.Name;
            objMAW.status = objPIW.ProcessInstance.Status;
            objMAW.objectRecordId = objPIW.ProcessInstance.TargetObjectId;
            objMAW.objType = labelsMap.get(objPIW.ProcessInstance.TargetObject.Type);
            objMAW.createdBy=objPIW.ProcessInstance.CreatedBy.Name;
            objMAW.createdDate = objPIW.ProcessInstance.CreatedDate;
            objMAW.subComment = stepsMap.get(objPIW.ProcessInstanceId) != null ? stepsMap.get(objPIW.ProcessInstanceId) : ' ';
            objMAW.name = objPIW.ProcessInstance.TargetObject.Name;
            listMAWs.add( objMAW );
            
        }
        system.debug('listMAWs'+listMAWs);
        return listMAWs;
    }
    
    @AuraEnabled( cacheable = true )
    public static List <MassApprovalWrapper> fetchPendingApprovalRecords(String objectName, List<string> fields) {
        System.debug('object name'+objectName);
        system.debug('fields are'+fields);
        
        system.debug('fields....'+fields);
        String fieldList = String.join(fields, ',');
        List < MassApprovalWrapper > listMAWs = new List < MassApprovalWrapper >();
        Set < Id > setRecordIds = new Set < Id >();
        
        List < ProcessInstanceWorkitem > listPIWs = [
            SELECT Id, Actor.Name, ProcessInstance.Status, ProcessInstance.TargetObjectId,
            ProcessInstance.TargetObject.Name,ProcessInstance.SubmittedBy.Name, ProcessInstance.TargetObject.Type, ProcessInstance.CreatedBy.Name,ProcessInstance.CreatedDate
            FROM ProcessInstanceWorkitem
            WHERE ProcessInstance.TargetObject.Type=:objectName AND
            ActorId =: UserInfo.getUserId()
        ];
        set<id> ids = new set<id>();
        for(ProcessInstanceWorkitem piw : listPIWs){
            ids.add(piw.ProcessInstance.TargetObjectId);
        }
        system.debug('select id, Name, '+fieldList+' from '+objectName+' where id IN: ids');
        List<sObject> sobj = Database.query(string.escapeSingleQuotes('select id, Name, '+fieldList+' from '+objectName+' where id IN: ids WITH SECURITY_ENFORCED' ));
        Map<Id, sObject> sobjMap = new Map<Id, sObject>();
        Map<Id, String> stepsMap = new Map<Id, String>();
        
        for(sObject obj : sobj){
            sobjMap.put(obj.Id, obj);
        }
        //Map<Id,Account> sobjMap = new Map<Id, sObject>(Database.query('select id,Description,Name from '+objectName+' where id IN: '+ids));
        //list<ProcessInstanceStep> pisList = [select id, StepStatus,comments,ProcessInstanceId from ProcessInstanceStep where stepstatus = 'Started' AND ActorId =: UserInfo.getUserId()];
        for(ProcessInstanceStep pis : [select id, StepStatus,comments,
                                       ProcessInstanceId from ProcessInstanceStep 
                                       where stepstatus = 'Started' 
                                       AND ActorId =: UserInfo.getUserId() WITH SECURITY_ENFORCED]){
                                           stepsMap.put(pis.ProcessInstanceId,pis.comments);
                                       }
        for ( ProcessInstanceWorkitem objPIW : listPIWs ) {
            
            MassApprovalWrapper objMAW = new MassApprovalWrapper();
            objMAW.PIWId = objPIW.Id;
            objMAW.submittedBy = objPIW.ProcessInstance.SubmittedBy.Name;
            objMAW.approverName = objPIW.Actor.Name;
            objMAW.status = objPIW.ProcessInstance.Status;
            objMAW.objectRecordId = objPIW.ProcessInstance.TargetObjectId;
            objMAW.objType = (String)Schema.getGlobalDescribe().get(objPIW.ProcessInstance.TargetObject.Type).getDescribe().getLabel();
            objMAW.createdBy=objPIW.ProcessInstance.CreatedBy.Name;
            objMAW.createdDate = objPIW.ProcessInstance.CreatedDate;
            objMAW.subComment = stepsMap.get(objPIW.ProcessInstanceId) != null ? stepsMap.get(objPIW.ProcessInstanceId) : ' ';
            
            sObject sobj2 = sobjMap.get(objPIW.ProcessInstance.TargetObjectId);
            string sValues = JSON.serialize(sobj2);
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(sValues);
            objMAW.name = string.valueof(results.get('Name'));
            if(fields.size()>0){
             objMAW.field0 = string.valueof(results.get(fields[0])) != null ? string.valueof(results.get(fields[0])) : ' ';
            }
            if(fields.size()>1){
           objMAW.field1 = string.valueof(results.get(fields[1])) != null ? string.valueof(results.get(fields[1])) : ' ';

            }
            if(fields.size()>2){
              objMAW.field2 = string.valueof(results.get(fields[2])) != null ? string.valueof(results.get(fields[2])) : ' ';

            }
            if(fields.size()>3){
               objMAW.field3 = string.valueof(results.get(fields[3])) != null ? string.valueof(results.get(fields[3])) : ' ';

            }
            listMAWs.add( objMAW );
            
        }
        system.debug('listMAWs'+listMAWs);
        return listMAWs;
        
    }
    //massRejectRecords
    
    @AuraEnabled
    public static String massApproveRecords( String selectedRows,String comment ) {
        
        System.debug( 'Selected Rows' + selectedRows );
        String message = 'success';
        Set < Id > recordIdsToApprove = new Set < Id >();
        List < MassApprovalWrapper > listMAWs = ( List < MassApprovalWrapper > )JSON.deserialize( selectedRows, List < MassApprovalWrapper >.class );
        List < Approval.ProcessWorkitemRequest > approvalRequests = new List < Approval.ProcessWorkitemRequest >();
        
        for ( MassApprovalWrapper objMAW : listMAWs ) {
            
            //recordIdsToApprove.add( objMAW.PIWId );
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments( comment );
            req.setAction( 'Approve' );
            req.setWorkitemId( objMAW.PIWId );
            approvalRequests.add( req );
            
        }               
        
        try {
            
            Approval.process( approvalRequests );
            
        } catch ( Exception e ) {
            
            message = 'error';
            System.debug( 'Error is' + e.getMessage() );
            
        }
        
        return message;
        
    }
    
    @AuraEnabled
    public static String massRejectRecords( String selectedRows,String comment ) {
        
        System.debug( 'Selected Rows' + selectedRows );
        String message = 'success';
        Set < Id > recordIdsToApprove = new Set < Id >();
        List < MassApprovalWrapper > listMAWs = ( List < MassApprovalWrapper > )JSON.deserialize( selectedRows, List < MassApprovalWrapper >.class );
        List < Approval.ProcessWorkitemRequest > approvalRequests = new List < Approval.ProcessWorkitemRequest >();
        
        for ( MassApprovalWrapper objMAW : listMAWs ) {
            
            //recordIdsToApprove.add( objMAW.PIWId );
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments( comment );
            req.setAction( 'Reject' );
            req.setWorkitemId( objMAW.PIWId );
            approvalRequests.add( req );
            
        }               
        
        try {
            
            Approval.process( approvalRequests );
            
        } catch ( Exception e ) {
            
            message = 'error';
            System.debug( 'Error is' + e.getMessage() );
            
        }
        
        return message;
        
    }
    
    
    public class MassApprovalWrapper {
        @AuraEnabled
        public String submittedBy;
        @AuraEnabled
        public String approverName;
        @AuraEnabled
        public String PIWId;
        @AuraEnabled
        public String status;
        @AuraEnabled
        public String objectRecordId;
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String subComment;
        
        @AuraEnabled
        public String objType;
        @AuraEnabled
        public String createdBy;
        @AuraEnabled
        public Datetime createdDate;
        @AuraEnabled
        public String field0;
        @AuraEnabled
        public String field1;
        @AuraEnabled
        public String field2;
        @AuraEnabled
        public String field3;
        
    }
    
    @AuraEnabled(cacheable=true)
    public static list<user> userlist(){
        list<user> a = [SELECT Name FROM User];
        return a;
    }
    @AuraEnabled
    public static string massReassignRecords(String recordId, String userId, String comment)  
    { 
        system.debug('recordId'+recordId);
        system.debug('userId'+userId);
        system.debug('userId'+comment);
        String message = 'success';
        Set <Id> recordIdsToApprove = new Set <Id>();
        List < MassApprovalWrapper > listMAWs = ( List < MassApprovalWrapper > )JSON.deserialize( recordId, List < MassApprovalWrapper >.class );
        List <ProcessInstanceWorkItem> approvalRequests = new List <ProcessInstanceWorkItem>();
        
        system.debug('listMAWs'+listMAWs);
        for ( MassApprovalWrapper objMAW : listMAWs ) {
            
            
            ProcessInstanceWorkItem proInst = [SELECT Id, ActorId FROM ProcessInstanceWorkItem WHERE Id =:objMAW.PIWId WITH SECURITY_ENFORCED ];
            proInst.ActorId = userId;
            // proInst.co(comment);
            system.debug('proInst'+proInst);
            approvalRequests.add(proInst);
        }   
        
        if(Schema.sObjectType.ProcessInstanceWorkItem.isUpdateable() ) {
        database.update (approvalRequests,false);
         }
       // update approvalRequests;
        return message;
        
    }
}