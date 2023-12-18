public class wissen_vfcaluculater1 {
    public decimal cal1{get;set;}
public decimal cal2{get;set;}
public decimal result{get;set;}
public string choice{get;set;}
 public void math(){
  if(choice == 'A'){
   Add();
 }else if(choice == 'S'){
   sub();
 }else if(choice == 'M'){
   mult();
 }else {
   div();
}
}
 public void Add(){
   result=cal1+cal2;
 }public void sub(){
   result=cal1-cal2;
 }public void mult(){
   result=cal1*cal2;
 }public void div(){
   result=cal1/cal2;
}
}