trigger adarshreq2 on Contact (before insert) {
    for(contact c:trigger.new){
        c.FirstName=c.FirstName.capitalize();
        c.LastName=c.LastName.capitalize();
        
    }

}