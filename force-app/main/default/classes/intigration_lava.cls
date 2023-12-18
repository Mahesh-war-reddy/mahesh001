public class intigration_lava {
    public string pincode{set;get;}
    public list<string> op{set;get;}
    public void res(){
        op=new list<string>();
       // string endpoint1='https://api.postalpincode.in/pincode/'+pincode;
        Http p=new Http();
        Httprequest request=new Httprequest();
        request.setEndpoint('https://api.postalpincode.in/pincode/'+pincode);
        request.setMethod('GET');
        
        Httpresponse response=new Httpresponse();
        response =p.send(request);
        string body=response.getBody();
        system.JSONParser jp=json.createParser(body);
        While(jp.nexttoken() !=null){
            if(jp.gettext()=='name'){
                jp.nextToken();
                op.add(jp.getText());
            }
            
            
        }
        
    }

}