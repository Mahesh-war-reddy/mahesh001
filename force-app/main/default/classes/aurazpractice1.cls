public class aurazpractice1 {
    @auraEnabled
    public static list<Lava_Dealers__c> mt1(string input){
        string input2='%'+input+'%';
        return [select id,name from Lava_Dealers__c where name like:input2];
    }
}