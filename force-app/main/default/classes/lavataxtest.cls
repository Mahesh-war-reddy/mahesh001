@istest
public class lavataxtest {
    @istest public static void lavataxt() {
        Order_details__c od=new Order_details__c();
        od.Name='test12';
        od.Ammount__c=2000;
        od.Lava_Dealer__c='a075g0000037M8CAAU';
        insert od;
        Order_details__c qod=[select Ammount__c from Order_details__c where Name='test12'];
        system.assertEquals(2400, qod.Ammount__c);
    }

}