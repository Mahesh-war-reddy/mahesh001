public class wissen_singleemail1 {
    public void singlemail() {
        string subject='Sample mail from salesforce';
        string body = 'welcome to the dell family';
       messaging.SingleEmailMessage email= new messaging.SingleEmailMessage();
        email.setSubject(subject);
        email.setPlainTextBody(body);
        email.setToAddresses( new String[] {'mr19043@gmail.com'} );
        messaging.Email[] emails = new messaging.Email[]{email};
         messaging.sendEmail(emails);

        
    }
    
}