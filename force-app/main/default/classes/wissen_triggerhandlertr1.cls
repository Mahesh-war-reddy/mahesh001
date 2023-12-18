public class wissen_triggerhandlertr1 {
   
List<Contact> ContactList1 = New List<Contact>();
Public void afterInsert(List<Account> newAcc){
for(Account ac:newAcc){
ContactList1.add(new Contact(LastName = ac.Name,AccountId = ac.Id));
}
insert ContactList1;
}
}