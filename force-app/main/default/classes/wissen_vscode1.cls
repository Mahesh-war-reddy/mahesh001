public class wissen_vscode1 {
    @AuraEnabled(cacheable=true)
public static Account callApex(){

account acc = [Select Name,Id From Account limit 1];
System.debug(acc);
return acc;
}

}