public class Wissen_soql1 {
    //output using limit
    public static void method1() {
        list<Dell_entity_orders__c>dell_q1=[select id,Name, Order_ID__c , Profit__c from Dell_entity_orders__c limit 5];
        system.debug(dell_q1);
    }
    //output using where and !=
    public static void method2() {
     list<Dell_entity_orders__c>dell_q2=[select id,Name, Order_ID__c , Profit__c from Dell_entity_orders__c where Profit__c !=0]; 
        system.debug(dell_q2);
        FOR(Dell_entity_orders__c E:dell_q2) {
           SYSTEM.DEBUG(e);
        }
    }
    //output using orderby
  public static void method3() {
        list<Dell_entity_orders__c>dell_q3=[select id,Name, Order_ID__c , Profit__c from Dell_entity_orders__c  order by Name limit 5];
        system.debug(dell_q3);

}
    //output from chield to parent
     public static void method4() {
        list<Dell_entity_orders__c>dell_q4=[select Customer_Info__r.Country__c from Dell_entity_orders__c ];
         for(Dell_entity_orders__c ee:dell_q4) {
         system.debug(ee.Customer_Info__r.Country__c);
         }
}
    //calling chield from parent obj
    public static void method5(){
list<Customer_Info__c> dell_q5 = [Select  Name, (Select  Profit__c from Dell_entity_orders__r) from Customer_Info__c];
        for(Customer_Info__c ds:dell_q5) {
           system.debug(ds); 
        }

}
     public static void method6(){
         //using IN
    Dell_entity_orders__c[] del = new List<Dell_entity_orders__c>();
del=[select Name,Profit__c from Dell_entity_orders__c where Name IN ('mrFY21 Q2')];
system.debug(del);
     
//Using Not in
Dell_entity_orders__c[] del1 = new List<Dell_entity_orders__c>();
del1=[select Name,Profit__c from Dell_entity_orders__c where Name NOT IN('mrFY21 Q2')];
system.debug(del1);
     } 
 //like name starts with
 public static void method7(){
Dell_entity_orders__c[] del3 = new List<Dell_entity_orders__c>();
del3=[SELECT Name, Profit__c FROM Dell_entity_orders__c WHERE Name Like 'mr%' ];
system.debug(del3);  
     //name  between
Dell_entity_orders__c[] del4 = new List<Dell_entity_orders__c>();
del4=[SELECT Name, Profit__c FROM Dell_entity_orders__c WHERE Name Like '%mahesh%' ];
system.debug(del4);
}
}