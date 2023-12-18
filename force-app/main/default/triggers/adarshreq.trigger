trigger adarshreq on Account (after update) {
    for(account acc11:trigger.old){
    for(account acc10:trigger.new){
     
        if(acc11.Industry=='Agriculture'){
            if(acc10.Industry=='Education'){
                Task t=new task();
                t.WhatId=acc11.id;
                t.Status='Completed';
                 t.Subject = 'Test Task';
                t.Priority = 'Normal';
                t.OwnerId=acc10.OwnerId;     //capitalize() 
                    insert t;
                    
                
            }
            
        }
        }
    }
}