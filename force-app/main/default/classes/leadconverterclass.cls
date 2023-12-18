public class leadconverterclass {
    @AuraEnabled(cacheable=true)
    public static List<Lead> getLead( String searchKey, String sortBy, String sortDirection){
        String query = 'SELECT id,name,email,phone,Status, Company, LeadSource FROM Lead ';
        system.debug('query---'+query);
        if ( searchKey != null && searchKey != '' ) {
            String key = '%' + searchKey + '%';
            query += ' WHERE Name LIKE :key';
        }
        if ( sortBy != null && sortDirection != null ) {
            query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
        query = query + ' LIMIT 2000';
        return Database.query( query );
    }
    
}