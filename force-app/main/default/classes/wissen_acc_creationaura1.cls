public class wissen_acc_creationaura1 {
 @AuraEnabled
public static string createAccount(Account accObj) {
System.debug('account::'+accObj.Name);
insert accObj;
return accObj.id;
}

}