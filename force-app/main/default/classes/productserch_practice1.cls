public with sharing class productserch_practice1 {
    @AuraEnabled(cacheable=true)
    public static list<product2> serchproduct(string productserchkey){
        string serchkey='%'+productserchkey+'%';
        list<product2>productlist=[select Name ,Productcode,id from product2 where name like:serchkey];
        System.debug(productlist);
        return productlist;

    }

}