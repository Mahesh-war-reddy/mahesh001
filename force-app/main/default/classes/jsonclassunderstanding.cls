public class jsonclassunderstanding {
    public class InvoiceStatement {
        Long invoiceNumber;
        Datetime statementDate;
        Decimal totalPrice;
        public InvoiceStatement(Long i, Datetime dt, Decimal price)
        {
            invoiceNumber = i;
            statementDate = dt;
            totalPrice = price;
        }
    }
    public static void SerializeRoundtrip() {
        Datetime dt = Datetime.now(); 
        // Create a few invoices.
        InvoiceStatement inv1 = new InvoiceStatement(1,Datetime.valueOf(dt),1000);
        InvoiceStatement inv2 = new InvoiceStatement(2,Datetime.valueOf(dt),500);
        // Add the invoices to a list.
        List<InvoiceStatement> invoices = new List<InvoiceStatement>();
        invoices.add(inv1);
        invoices.add(inv2);
        // Serialize the list of InvoiceStatement objects.
        String JSONString = JSON.serialize(invoices);
        System.debug('Serialized list of invoices into JSON format: ' + JSONString);
        // Deserialize the list of invoices from the JSON string.
        List<InvoiceStatement> deserializedInvoices = 
            (List<InvoiceStatement>)JSON.deserialize(JSONString, List<InvoiceStatement>.class);
        Map<string,object> obj  = (Map<String, Object>)JSON.deserializeUntyped(JSON.serializePretty(invoices));
        System.debug('Deserialized list of invoices into JSON format: ' + obj);
        System.assertEquals(invoices.size(), deserializedInvoices.size());
        Integer i=0;
        for (InvoiceStatement deserializedInvoice :deserializedInvoices) {
            system.debug('Deserialized:' + deserializedInvoice.invoiceNumber + ',' 
                         + deserializedInvoice.statementDate.formatGmt('MM/dd/yyyy  HH:mm:ss.SSS')
                         + ', ' + deserializedInvoice.totalPrice); 
            system.debug('Original:' + invoices[i].invoiceNumber + ',' 
                         + invoices[i].statementDate.formatGmt('MM/dd/yyyy  HH:mm:ss.SSS') 
                         + ', ' + invoices[i].totalPrice); 
            i++;
        }
    }
    public static void deserialize(){
        
        String jsonInput = '{\n' +
            ' "description" :"An appliance",\n' +
            ' "accessories" : [ "powerCord", ' + 
            '{ "right":"door handle1", ' + 
            '"left":"door handle2" } ],\n' +
            ' "dimensions" : ' + 
            '{ "height" : 5.5 , ' + 
            '"width" : 3.0 , ' + 
            '"depth" : 2.2 },\n' +
            ' "type" : null,\n' +
            ' "inventory" : 2000,\n' +
            ' "price" : 1023.45,\n' +
            ' "isShipped" : true,\n' +
            ' "modelNumber" : "123"\n' +
            '}';
        Map<String, Object> m = 
            (Map<String, Object>)
            JSON.deserializeUntyped(jsonInput);
        System.debug(
            'An appliance'+ m.get('description'));
        List<Object> a = 
            (List<Object>)m.get('accessories');
        System.debug('powerCord'+ a[0]);        
        Map<String, Object> a2 = 
            (Map<String, Object>)a[1];
        System.debug(
            'door handle1'+ a2.get('right'));
        System.debug(
            'door handle2'+ a2.get('left'));
        Map<String, Object> dim = 
            (Map<String, Object>)m.get('dimensions');
        System.debug('5.5...'+ dim.get('height'));
        System.debug(
            '3.0..'+ dim.get('width'));
        System.debug(
            '2.2..'+ dim.get('depth'));
        System.debug('null...'+ m.get('type'));
        System.debug(
            '2000...'+ m.get('inventory'));
        System.debug(
            '1023.45...'+ m.get('price'));
        System.debug(
            'true..'+ m.get('isShipped'));
        System.debug(
            '123'+ m.get('modelNumber'));
    }
    
}