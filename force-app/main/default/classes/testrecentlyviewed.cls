public class testrecentlyviewed {
    public static void t(){
        list<customrecentlyviewed__c> e=new list<customrecentlyviewed__c>();
        for(recentlyviewed r:[select name from recentlyviewed  ]){
            customrecentlyviewed__c c=new customrecentlyviewed__c();
            c.Name=r.name;
           e.add(c);
        }
      //  list<string> ma=list<string>(){'Biotechnology','Banking'};
        list<string> a= new list<string>{'a'};
        insert e;
        system.debug('ffffffff:'+e);
    }
    public  string tt(string k){
       string h=k;
        if(k=='jan'||h=='feb'||h=='dec'){
            return 'winter';
           // string h=k;
        }else if(h=='march'||h=='apr'||h=='may'){
            return 'summer'; 
        }else if(h=='jun'||h=='jul'||h=='aug'||h=='sep'){
            return 'rainy';
        }else{
            return  'rainyjhbjhb';
                }
    }
}