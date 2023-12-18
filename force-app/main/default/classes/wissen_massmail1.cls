public class wissen_massmail1 {
    public void massEmail() {
String subject = 'Congratulations';
String body = ' Welcome to lava family';
//create master list to store emails that we will send
List<Messaging.SingleEmailMessage> masterlistmails = new list<Messaging.SingleEmailMessage>();
for(Lava_Dealers__c p : [select id,EMAIL__c from Lava_Dealers__c]) {
Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
//set list of people to recieve mails
list<String> sendTo = new list<String>();
sendTo.add(p.EMAIL__c);
email.setToAddresses(sendTo);
email.setSenderDisplayName('Mahesh');

//set the parameters of the email
email.setSubject(Subject);
email.setPlainTextBody(body);
//adding mail addresses to the list
masterlistmails.add(email);
}
//sends mass emails
Messaging.sendEmail(masterlistmails);

}
}