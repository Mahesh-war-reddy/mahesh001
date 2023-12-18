public class mahesh {
//variable ----->its a  container to hold
////method----.>logic
////class ----->structure
integer num1=56;
    integer num2=85;
        integer num3=88;
    integer result;
    
    public void greater()
    {
        if(num1>num2 && num1>num3) {
          result=num1;  
        } else if(num2>num1 && num2>num3) {
            result =num2;
            
        } else {
            result=num3;
        }
      System.debug(result);
    }
     public void smaller()
    {
        if(num1<num2 && num1<num3) {
          result=num1;  
        } else if(num2<num1 && num2<num3) {
            result =num2;
            
        } else {
            result=num3;
        }
            System.debug(result);
    }
    
    
}