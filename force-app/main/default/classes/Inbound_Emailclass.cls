global class Inbound_Emailclass implements Messaging.InboundEmailHandler {
global Messaging.InboundEmailResult handleInboundEmail(
Messaging.InboundEmail email,
Messaging.InboundEnvelope envelope){
Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
String plainTextBody = email.plainTextBody;
system.debug(plainTextBody);
Account ACC = new Account();
Acc.Name = plainTextBody.substringBetween('<Name>','</Name>');
Acc.AccountNumber = plainTextBody.substringBetween('<AccNum>','</AccNum>');
Database.SaveResult insertAccountRecord = Database.insert(Acc);
return result;
}
}