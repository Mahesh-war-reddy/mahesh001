public class zpractice1 {
    public static void query(){
       list<account>acc=[select id,name from account];
        system.debug(acc);
    }
     public static void query2(){
       list<account>acc=[select id,name from account];
         for(account a:acc){ 
        system.debug(a);
         }
     }
    public static void query3(){
        for(account aa:[select id,name from account]){
            system.debug(aa);
        }
    }
    public static void query4(){
        list<account>acc=[select id,name from account where AnnualRevenue >10];
        for(account ac:acc){
            system.debug(ac);
        }
        
    }
     public static void query5(){
        list<account>acc=[select id,name from account where AnnualRevenue >10 and industry='banking']; // we can use or
        for(account ac:acc){
            system.debug(ac);
        }
        
    }
    //order by :by defaylt it is asending
    public static void query6(){
        list<account>acc=[select id,name from account where AnnualRevenue >10 and industry='banking' order by name]; // we can use or
        for(account ac:acc){
            system.debug(ac);
        }
        
    }
    public static void query7(){
        list<account>acc=[select id,name ,annualrevenue from account where AnnualRevenue >10 or industry='banking' order by annualrevenue desc limit 5 offset 3]; // 
        for(account ac:acc){
            system.debug(ac);
        }
        
    }
    //dynamic
     public static void query8(integer lim){
         integer x=1;
        list<account>acc=[select id,name ,annualrevenue from account where annualrevenue > 1  order by annualrevenue desc limit :lim ]; // 
        for(account ac:acc){
            //integer x=1;
            system.debug(x +'annual revenue is'+ac.AnnualRevenue);
            x++;
        }
        
    }
    public static void query9(){
        for(account acc:[select name from account all rows]){
            system.debug(acc.name);
        }
    }
    public static void query10(){
        for(account acc:[select name from account where isdeleted=true all rows ]){
            system.debug(acc);
        }
    }
    public static void query11(){
        for(account acc:[select name from account for update]){
            system.debug(acc); //in like relationship
        }
    }
    public static void mpsp(){
        map<id,account> mapacc=new map<id,account>([select id,name from account]);
        set<id>mpid=mapacc.keySet();
        system.debug(mpid);
        system.debug(mapacc.values());
    }
    public static void query12(){
        // in statment
        list<account>sid=[select id from account where name='Mahesh'];
        for(account acc:[select name from account where id in:sid]){
            system.debug(acc.name);
        }
    }
    public static void query13(){
        list<string> ind=new list<string>{'banking','finance','energy'};
            list<account>acc=[select name from account where Industry in:ind];
        system.debug(acc);
        
    }
     public static void query14(){
      //_ mean only one value %mean unlimited
        list<account>sid=[select id,name from account where name like 'Mahesh'];
         list<account>sid1=[select id,name from account where name like '%kh'];
         list<account>sid2=[select id,name from account where name like 'k%'];
         list<account>sid3=[select id,name from account where name like '_he%']; 
         /* "%a%": :mahesh,ramesh,cat,bat,rat,fat etc.
			'_a%':catghi,batjjj,rat
                         '_a_':only return cat bat rat /
                                stringname+='%'; then retun stringname+reddy: maheshreddy. */
       system.debug(sid2);
        }
    public static void query15(){
        //we need to use prural name of chield.
        list<account>acc=[select name,(select lastname from contacts),(select name from opportunities) from account];
        //just use api name with __r
        list<Lava_Dealers__c>lava=[select name ,(select name from Order_details__r) from Lava_Dealers__c];
        //use api name
        list<contact>con=[select name ,account.name from contact];
        //use relationship field api name
        list<Order_details__c>order22=[select id, name,Lava_Dealer__r.Ammount_Paid__c from Order_details__c];
            
    }
    public static void query16(){
       // account acc=[select name from account limit 1];
        for(account acc:[select name from account limit 2]){
          system.debug(acc);  
        }
       
    }
    public static void query17(){
        for(ABC_Agents__c abc:[select name, Status__c from ABC_Agents__c where Status__c='Bad']){
            abc.Status__c='Good';
            update abc;
        }
        
    }
}