public class wissen_dml2p {
    public static void method21() {
        list<Dell_entity_orders__c> dell_in= new list<Dell_entity_orders__c>();
        for(integer i=1;i<=10;i++) {
           
            Dell_entity_orders__c d=new Dell_entity_orders__c();
            d.Name='Mahesh DML' +i;
            dell_in.add(d);
             insert dell_in;
        }
        system.debug(dell_in);
        //insert dell_in;
        }
        
    }