trigger Updating_contactromacc1 on Account (after update) {
    contact c= new contact();
      for(account ac:trigger.new) {
          c=[select phone from contact where accountid = :ac.id];
         
          c.Phone=ac.phone; 
          }
          update c;

}