public class FUTUREAPEX {
 
    public void uerupdte(){
        user u = [Select id , username , isactive from user where isactive = false limit 1 ];
        if(u!=null){
            u.IsActive = true;
            update u;
          
        }
        acntupdte();
    }
    @future
    public static void acntupdte(){
        account a = [select id , name , fax , phone from account where phone = null limit 1];
        a.Phone = '9009';
        update a;
    }
}