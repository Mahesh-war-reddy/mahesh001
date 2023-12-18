public class constractor_2504_eg3con {
   public account acc {get;set;}
    public constractor_2504_eg3con () //if we  create intiallizer here so it store input data in ram
    {
        acc=new account();
    }
    
    public void creatac()
    {
        try{ 
            if(acc.phone <>''){
                insert acc;
                apexpages.message m= new apexpages.message(apexpages.severity.confirm,'account created'+acc.id); 
           apexpages.addmessage(m);
            } else {
                apexpages.message ph= new apexpages.message(apexpages.severity.confirm,'phone number compulsury'); 
           apexpages.addmessage(ph);
            }
            
            
        } catch(exception e) {
          apexpages.message err =new apexpages.message(apexpages.severity.ERROR,'accont creation failed'+e.getmessage());
              apexpages.addmessage(err);
        }
    }

}