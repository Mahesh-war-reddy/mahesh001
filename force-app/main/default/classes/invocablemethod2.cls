public class invocablemethod2 {
     @invocablemethod(label='creatcon1' description='invocable method call')
    public static void deletcon(list<string>ids)  {
        list<contact>cl=[select id from contact where accountid=:ids ];
        delete cl;
    }

}