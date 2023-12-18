public class hiring_multiple_canedit {
    
        public Position1__c pos;
        public Applications__c del;
        public List<Applications__c> addapplicationList {get;set;}
        public List<Applications__c> delapplicationList {get;set;}
        public List<Applications__c> applicationList{get;set;}
        public Integer rowIndex {get;set;}
      
    public hiring_multiple_canedit(ApexPages.StandardController controller) {
                pos = (Position1__c)controller.getRecord();
                applicationList = [Select id,Name,Position__c,candidate__c from Applications__c];
                delapplicationList = new List<Applications__c>();
             }

        public void addRow() {
                addapplicationList = new List<Applications__c> ();
                applicationList.add(new Applications__c(Position__c = pos.Id));
        }

        public PageReference save() {
                upsert applicationList;
                delete delapplicationList;
                return (new ApexPages.StandardController(pos)).view();
        }
        public void deleteRow() {
                rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
                del = applicationList.remove(rowIndex);
                delapplicationList.add(del);
        }
}