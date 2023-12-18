public class alphabets {
    string res,res2;
 public  void mmm(){
           for(integer i=0;i<=4; ){
             list<string>alph = new list<String>{'a','b','c','d','e'};
                   res=alph.get(i);
               if(i==0){
                   res2=res;
               }
               if(i>0) { res2+=res;  
                       }
              system.debug(res2);
               i++;
           }
 }
}