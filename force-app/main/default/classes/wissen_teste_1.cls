public class wissen_teste_1 { 
  public static void gst(Dell_entity_orders__c[] dell) {
for(Dell_entity_orders__c d : dell) {
d.sell_price__c *= 0.8;
}

}
}