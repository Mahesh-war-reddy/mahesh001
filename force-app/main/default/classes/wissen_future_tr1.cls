public class wissen_future_tr1 {
    public wissen_future_tr1()
{
acc();
acc1();
acc2();
}
   integer a=10;
    integer b=20;
public void acc()
{
    integer c =a+b;
System.debug(c);
}

@future
public static void acc1()
{
    integer d =20;
    integer e=2;
    integer d1=d/e;
System.debug(d1);
}
public void acc2()
{
    integer f=10;
    integer g=5;
    integer h=f*g;
System.debug(h);
}



}