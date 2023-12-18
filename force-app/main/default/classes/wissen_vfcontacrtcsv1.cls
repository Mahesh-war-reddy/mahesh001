public class wissen_vfcontacrtcsv1 {
    public List<Contact> lstContact {set;get;}

public wissen_vfcontacrtcsv1(){
// Here I added limit 10, you can add filter criteria which you want
lstContact = [Select Id, Name, Email, Phone From Contact Limit 10];
}

}