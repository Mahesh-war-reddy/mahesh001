public class SendMailtoQueueMembers implements Schedulable {
     private Case newListCase;
    private Id caseId;
    
    public SendMailtoQueueMembers(Case newListCase, Id caseId) {
        // Represents a Case object (presumably a newly created case) that needs to be escalated.
        this.newListCase = newListCase;
      // Represents the Id of the case that needs to be escalated.
        this.caseId = caseId;
    }  
    public void execute(SchedulableContext sc) {
        // Retrieve an instance of the Custom Setting "EscalationTiming__c" by using getInstance() method
   /*     EscalationTiming__c escTimes = EscalationTiming__c.getInstance();
        system.debug('escTimes    '+ escTimes);
        // Get the value of the "BeforeCaseEscalationTime__c" field from the Custom Setting
        String escalationTimeValue = escTimes.BeforeCaseEscalationTime__c;
		system.debug('escalationTimeValue    '+ escalationTimeValue);
        // Split the escalationTimeValue by ':' to get hours and minutes separately
        List<String> timeComponents = escalationTimeValue.split(':');
        system.debug('timeComponents    '+ timeComponents);
        Integer hours = Integer.valueOf(timeComponents[0]);
        
        Integer minutes = Integer.valueOf(timeComponents[1]);

        // Output debug messages with the extracted hours and minutes for testing and troubleshooting purposes
        System.debug('Escalation Time - Hours: ' + hours);
        System.debug('Escalation Time - Minutes: ' + minutes);
         // Create a DateTime variable for the specified timing (using the current date)
       DateTime currentDateTime = DateTime.now();
        System.debug('currentDateTime     ' + currentDateTime);
        DateTime specifiedTime = DateTime.newInstance(
            currentDateTime.year(),
            currentDateTime.month(),
            currentDateTime.day(),
            hours,
            minutes,
            0
        );
        
		System.debug('specifiedTime     ' + specifiedTime); */
        // Create a Set to store the User Ids
        Set<Id> userIds = new Set<Id>();
        system.debug('userIds   ' + userIds);
        // Query the GroupMember records that have a Group Type of 'Queue'
        // Retrieve fields: Id, GroupId, Group.Name, UserOrGroupId, Group.Type
        // Store the query results in the "members" list
        List<GroupMember> members = [SELECT Id, GroupId, Group.Name, UserOrGroupId, Group.Type FROM GroupMember WHERE Group.Type = 'Queue'];
        system.debug('members   ' + members);
        // Check if there are any GroupMember records returned from the query
        if (members.size() > 0) {
            // Iterate over each GroupMember record in the "members" list
            for (GroupMember m : members) {
                // Add the User or Group Id from the GroupMember record to the "userIds" set
                userIds.add(m.UserOrGroupId);
                
                system.debug('userIds   ' + userIds);
            }
        }
        // Create a Set to store the email addresses
        Set<String> emails = new Set<String>();
        // Query the User records where the Id is present in the "userIds" set
        // Retrieve fields: Id, Email
        // Store the query results in the "users" list
        List<User> users = [SELECT Id, Email FROM User WHERE Id IN :userIds];
        system.debug('users   ' + users);
        // Iterate over each User record in the "users" list
        for (User u : users) {
            // Add the Email address from the User record to the "emails" set
            emails.add(u.Email);
            system.debug('emails   ' + emails);
        }
        // Output a debug message with the content of the "emails" set for testing and troubleshooting purposes
        System.debug('emails: ' + emails);
        // Convert the "emails" set to a list of email addresses
        List<String> emailAddresses = new List<String>(emails);
         System.debug('emailAddresses: ' + emailAddresses);
        // Create an empty list to store the email messages
        List<Messaging.SingleEmailMessage> msgEmails = new List<Messaging.SingleEmailMessage>();
         System.debug('msgEmails: ' + msgEmails);
        // Query Case records that have a status of 'New' and were created before or at the specified time threshold
        // Retrieve fields: Id, CaseNumber, Status, Subject, Owner.Name, Priority, Description, CreatedDate
        // Store the query results in the "cases" list
        List<Case> cases = [SELECT Id, CaseNumber, Status, Subject, Owner.Name, Priority, Description, CreatedDate FROM Case WHERE Status = 'New'];
        // Output a debug message with the content of the "cases" list for testing and troubleshooting purposes
        System.debug('cases: ' + cases);
        // Iterate over each Case record in the "cases" list
        for (Case c : cases) {
            // Create a new instance of SingleEmailMessage to compose an email message
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            // Set the recipient email addresses for the email message to the values in the "emailAddresses" list
            msg.setToAddresses(emailAddresses);
            System.debug('msg: ' + msg);
            // Compose the body of the email message
            String body = '<p>Dear Team,</p>';
            body += '<p>This is to inform you that Case ' + c.CaseNumber + ' needs your attention. The Case has been assigned to the ' + c.Owner.Name + ' owner, but it has not been resolved yet.</p>';
            body += '<p>Please review the details below and take appropriate action before the Case is escalated:</p>';
            body += '<p><li>Case Number: ' + c.CaseNumber + ' </li><br/><li> Subject: ' + c.Subject + '</li><br/><li> Description: ' + c.Description + '</li><br/><li>  Priority: ' + c.Priority + '</li><br/><li> Status: ' + c.Status + '</li> <br/> Please note that the Case is scheduled to be escalated in 2 hours. If you are unable to resolve the Case by then, please reassign it to an appropriate resource or escalate it to the next level of support.</p>';
            body += '<p>Thank you for your prompt attention to this matter. Please go through the below case details.</p>';
            body += '<p><a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + c.Id + '">View Case Details</a></p>';
            body += '<p>Thanks & Regards,</p>';
            body += '<p>Support Team</p>';
            // Set the HTML body of the email message using the composed body string
            msg.setHtmlBody(body);
            // Set the subject of the email message
            msg.setSubject('Case is going to be Escalate');
            // Set the sender display name for the email message
            msg.setSenderDisplayName('Salesforce Admin');
            // Add the email message to the "msgEmails" list
            msgEmails.add(msg);
            System.debug('msgEmails: ' + msgEmails);
        }
        // Try to execute the following code block
        try{
            // Check if the list of email messages is not empty
            if (!msgEmails.isEmpty()) {
                // Send the email messages using the Messaging.sendEmail() method
                Messaging.sendEmail(msgEmails);
            } else {
                // Output a debug message indicating that no new cases were found for escalation
                System.debug('No new cases found for escalation');
            }
        }
        // Catch any exceptions that occur during execution
        catch(Exception e){
            // Output a debug message with the error message from the caught exception
            System.debug('An error occurred while sending emails: ' + e.getMessage());
        }
        
    }
    // Define a public static method named "scheduleJob"
 /*   public static void scheduleJob() {
        SendMailtoQueueMembers job = new SendMailtoQueueMembers();
        String scheduleTime = '0 37 14 * * ?'; // schedule at midnight every day
        String jobName = 'Before Case Escalation Email Alert Job';
        String jobId = System.schedule(jobName, scheduleTime, job);
        System.debug('Scheduled job with ID: ' + jobId);
        System.debug('Scheduled Time: ' + scheduleTime);
    } */
}