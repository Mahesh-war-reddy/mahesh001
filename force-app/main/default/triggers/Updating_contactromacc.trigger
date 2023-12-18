trigger Updating_contactromacc on Account (after update) {
    set<id> accids=new set<id>();
    list<contact>cont=new list<contact>();
  
    for(account ac:trigger.new) {
     
        if(ac.Phone!=null) {
          accids.add(ac.Id) ;
        }
          List<contact> a  = [Select Phone from contact where AccountId IN:accids];
    for(contact b:a) {
        b.Phone=ac.Phone;
        cont.add(b);
    }
}

    update cont;
}