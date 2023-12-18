public class practice_06_10 {
    public  Dell_entity_orders__c metod1(){
        Dell_entity_orders__c dellr =new Dell_entity_orders__c();
        dellr.name='Mahesh11';
        system.debug(dellr);
        insert dellr;
        delete dellr;
        undelete dellr;
        return dellr;
    }
 private integer a=30;
    private integer b=40;
    private integer c=50;
    private integer result;
    public void greater(){
        if(a>b&&a>c) {
            result=a;
        } else if(b>a&&b>c) {
            result=b;
        } else {
            result=c;
        }
        system.debug(result);
    }
    
}