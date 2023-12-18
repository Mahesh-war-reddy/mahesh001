public class Sndeeptestclass {
    public static void m(){
        Lava_Dealers__c ld= new Lava_Dealers__c();
        ld.name='lava hyderabad';
        insert ld;
        Order_details__c od= new Order_details__c();
        od.Name='order1111';
        od.Lava_Dealer__c=ld.Id;
        od.Ammount__c=10;
        insert od;
        system.debug(od.lavadealerformulafield__c);
        system.debug(od);
        Order_details__c ood=[select id,Ammount__c,lavadealerformulafield__c from Order_details__c where id=:od.id ];
        system.debug(ood.lavadealerformulafield__c);
        
    }

}