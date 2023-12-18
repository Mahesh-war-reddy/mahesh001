trigger rshniderb1 on Opportunity (After update) {
    for( opportunity op1:trigger.old){
        for(opportunity op2:trigger.new){
            if(op1.StageName !='Negotiation/Review') {
                if(op2.StageName == 'Closed Won' || op2.StageName=='Closed Lost '  ) {
                    op2.adderror('format should be good');
                    
                    }
               
                }
             else if(op2.Description ==null && op2.StageName=='Closed Lost'){
                    op2.adderror('Description cannont be empty');
                }
            }
        }
    }