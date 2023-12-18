public class hr_aurarest1 {
@AuraEnabled
public static list<Openings__c> createAccount() {
    list<Openings__c> op=[select Name from Openings__c ];
return op;
}

}