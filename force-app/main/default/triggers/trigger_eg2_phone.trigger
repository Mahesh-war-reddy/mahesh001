trigger trigger_eg2_phone on Contact (before insert) {
list<contact> c= trigger.new;
    for(contact ec:c ) {
        if(ec.phone==null) {
            ec.phone='999999';
                
                } if(ec.email==null) {
                    ec.email='m@email.com';
                }
    }
}