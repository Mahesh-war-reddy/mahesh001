public class zpractice{
   //public integer english, telugu, hindi, maths, science;
    //public integer english=2;
    integer  total, avg;
    public static void ccc(){
       list<OrderItem> iii=[select Product2.name,Order.Name from OrderItem]; 
        system.debug(iii);
    }
  /*  public static void ccd(){
      list<Product2> ii=[select name,(select OrderId from OrderItems ) from Product2];   
        system.debug(ii); */
    
    public static void method111(){
       // integer a;
        string hi;
        for( integer a=1;a<10000; a++){
          hi+=a+':'+'Yes '+' '+'what '+'';
            
        }
        system.debug(hi);
    }
    public   void  method1(integer telugu, integer hindi,integer maths, integer science, integer english ,integer n) {
    //if we use static it wont take variables.shoulduse static variable  . 
        total = english + telugu+hindi+maths+science+n;
        avg=total/5;
        if (telugu>=40 && hindi>=40 &&english >=40 && maths >=40 && science >=40) {
            system.debug('congratualtions you are passed');
            system.debug('your total marks are'+total);
            if(avg>=80){
              system.debug('Grade A');  
            } else if(avg>=60){
              system.debug('Grade B');
            } else {
              system.debug('Grade c');  
            }
        } else {
            system.debug('you are failed ,pay jntuh fee again');
            if(telugu<40){
                system.debug('You failed in telugu');
                //list<integer> a=(english, telugu, hindi, maths, science);
            }
        }
        //return avg;
    }
    public void month(integer month){
        switch on month{
            when 1,2,3,4{
                system.debug('winter');
                    } when 5,6,7,8 {
                      system.debug('summer');  
                    } when 9,10,11,12 {
                        system.debug('rain');
                    }
        }
       
    }
    
    public void table(integer tablenum, integer nummax) {
        integer counter=1;
            while( counter<=nummax){
               integer ans= tablenum*counter;
                system.debug(tablenum+'*'+counter+'='+ans);
                counter++;
            }
        } 
   
    public  void acc(string name){
        account acc1=new account();
        acc1.Name=name;
         insert acc1;
    }
      //insert acc1;  
    public static  void paymentinsert(){
        list<Paymenttest__c> paymentlist=new list<Paymenttest__c>();
        for(integer counter=1;counter<=10;counter++){
            Paymenttest__c p1= new Paymenttest__c();
            p1.Name='payment'+counter;
            p1.Ammount__c=2000;
            p1.Tax_applied__c=true;
            if(counter <9){
                p1.Email__c='mr19043@gmailll.com';
            }
            paymentlist.add(p1);
        }
        if(paymentlist !=null){
            database.SaveResult[] result=database.insert(paymentlist, false);
            for(database.SaveResult res:result) {
                if(res.isSuccess()) {
                    system.debug('record inserted successfullu and ID='+res.getId());
                } else {
                    database.error[] errors=res.getErrors();
                    for(database.error err:errors){
                    system.debug(err.getmessage()+err.getstatuscode()+err.getfields());    
                    }
                   
                }
            }
        }
    }
    public static void accc(){
        account acc11=new account();
        acc11.Name='kkkkkh';
            insert acc11;
        system.debug(acc11.id);
        contact con11=new contact();
          con11.LastName=acc11.Name;
          con11.AccountId=acc11.Id;
        insert con11;
    } 
    //sub program
    //chaining
    public static void acccreation1(string name2){
        account acc12=new account();
        acc12.Name=name2;
        insert acc12;
        system.debug(acc12.Id);
        concreatin(acc12);
    }
    public static void concreatin(account ac){
        contact con1=new contact();
        con1.LastName=ac.Name;
        con1.AccountId=ac.Id;
        insert con1;
        
}
    //functions
    public  static integer sum(integer x,integer y){
        return (x+y); 
        
    }
    public static integer len1( string y){
        return y.length();
    }
    public static void acc3(string name){
        account acc=new account();
        acc.Name=name;
        insert acc;
        id coid=con(acc);
        system.debug(coid);
    }
    public static id con(account ac ){
        contact con=new contact();
        con.LastName=ac.Name;
        con.AccountId=ac.Id;
        insert con;
        return con.id;
    }
    public static void lst(){
    list<string> lstname=new list<string>();
        lstname.add('mahesh');
		lstname.add(0,'vinod');
        list<string>lstname2=new list<string>{'mahesh1','mahesh2','0apple','venkat'};
        lstname.addall(lstname2);
      integer size=  lstname.size();
        system.debug(lstname );
        system.debug(size );
        system.debug(lstname.size());
        boolean s=lstname.isempty();
        system.debug(s);
        system.debug(lstname.isempty()); 
        system.debug(lstname.get(0));
        system.debug(lstname.contains('mahesh'));
        system.debug(lstname.indexof('mahesh1'));
        system.debug(lstname.indexof('kk')); // it will return -1;
        string str= 'Maheshwar';
        string newstr=str.substring(0,5);
        system.debug(newstr); 
        
        system.debug(lstname.remove(1));
        system.debug(lstname);
        lstname.sort();
        lstname.set(1,'z');
        system.debug(lstname);
        list<string>backupcopy=lstname.clone();
        system.debug(backupcopy);
        backupcopy.clear();
        system.debug(backupcopy);
    }
    public static void seet(){
        set<string>stname =new set<string>();
        stname.add('mahesh');
       // stname.add(1,'mahesh'); we cant use add by index in set
       // system.debug(stname.indexof('mahesh')); we cannot debug using indexof
    }
    public static void mappp(){
        map<string,string>maptest=new map<string,string>();
      /*  maptest.add('red','apple'); // we cannot use add function
        maptest.add('orange','orange fruit');*/
        maptest.put('red','apple');
        maptest.put('orange','orange fruit');
        map<string,string>maptest2=new map<string,string>();
        maptest2.put('green','papaya');
        maptest.putall(maptest2);
        system.debug(maptest);
        maptest.put('orange','venkat');
        system.debug(maptest);
        maptest.putall(maptest2);
        system.debug(maptest);
        system.debug(maptest.get('red')); // will return value.
        system.debug(maptest.remove('green')); // it will remove key and value.
        system.debug('key values only'+maptest.keyset());
        system.debug('only values'+maptest.values());
        maptest.clear();
        integer s=maptest.size();
        system.debug(s);
         system.debug(maptest.size()); // best way
    }
      public static void method(){
        list<contact> con=[select id , accountid, name from contact];
        map<id,set<id>> map1= new map<id,set<id>>();
        for(contact c:con){
            if(!map1.containsKey(c.accountid)){
                map1.put(c.accountid,new set<id>{c.id}) ;
                    }else{
                        map1.get(c.accountid).add(c.id) ;
                    }
            }
        }
    
    public static void method1(){
        list<contact> con=[select id ,accountid, name from contact ];
        map<id, list<contact>> map2=new map<id, list<contact>>();
        for(contact c:con){
            if(map2.containskey(c.accountid)){
                map2.get(c.accountid).add(c);
            }else{
                //list<contact> conlist=new list<contact>();
                //conlist.add(c);
               // map2.get(c.accountid).add(conlist);
                map2.put(c.accountid,new list<contact>{c});
            }
        }
        
    }
}