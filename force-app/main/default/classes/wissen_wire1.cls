public class wissen_wire1 {

     @AuraEnabled(cacheable=true)
    public static String getInputMessage() {
        return 'Input Message from Apex Class';
    }
}