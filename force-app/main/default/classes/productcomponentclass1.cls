public class productcomponentclass1 {
    @AuraEnabled(cacheable=true)
    public static list<product2> product_serch_result(string serchvalue){
        string serchvalue01='%'+serchvalue+'%';
        list<product2>productlist=[select id,Name from product2 where name like:'%'+serchvalue+'%'];
        return productlist;

    }

}