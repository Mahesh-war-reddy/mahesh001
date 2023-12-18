public class rupom_lwcacc_creation1 {
    @AuraEnabled
    public static string creacc(string Name , string rat , string ind , string ph) {
        string result;
        Try {
            Account acc= new Account();
            acc.Name =Name;
            acc.Phone=ph;
            acc.Rating=rat;
            acc.Industry=ind;
            insert acc;
            result= 'account creation successfull' +acc.Id;
            
        }
        catch(Exception E) {
            Result = 'account reation failed' +E.getMessage();
        }
        return result;
    }

}