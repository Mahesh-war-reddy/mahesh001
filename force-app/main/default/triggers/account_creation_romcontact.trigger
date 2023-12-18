trigger account_creation_romcontact on Contact (after insert,after update) {
    list<Account> acc = new List<Account>();
for(Contact con : Trigger.New) {
if(con.AccountId == null ) {
Account acc1 = new Account();
acc1.Name = con.LastName;
acc1.Phone = con.Phone;
acc.add(acc1);
}
}

insert acc;
}