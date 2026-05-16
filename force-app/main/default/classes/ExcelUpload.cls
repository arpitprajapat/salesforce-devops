public with sharing class ExcelUpload {

    @AuraEnabled
    public static void ExcelUpload(String contactData, String recordId) {

        System.debug('[ExcelUpload] Method called');
        System.debug('[ExcelUpload] recordId received: ' + recordId);
        System.debug('[ExcelUpload] Raw contactData: ' + contactData);

        // Query AccountId from the current Contact record
        String accountId = null;
        try {
            Contact currentContact = [
                SELECT Id, AccountId
                FROM Contact
                WHERE Id = :recordId
                LIMIT 1
            ];
            System.debug('[ExcelUpload] currentContact Id: ' + currentContact.Id);
            System.debug('[ExcelUpload] currentContact AccountId: ' + currentContact.AccountId);
            System.debug('[ExcelUpload] currentContact full record: ' + currentContact);

            accountId = currentContact.AccountId;
            System.debug('[ExcelUpload] AccountId fetched from Contact: ' + accountId);
        } catch (Exception e) {
            System.debug('[ExcelUpload] Failed to fetch Contact: ' + e.getMessage());
        }

        if (String.isBlank(accountId)) {
            System.debug('[ExcelUpload] AccountId is blank on Contact record - skipping insert');
            return;
        }

        List<Object> rawList;
        try {
            rawList = (List<Object>) JSON.deserializeUntyped(contactData);
            System.debug('[ExcelUpload] JSON deserialized. Record count: ' + rawList.size());
        } catch (Exception e) {
            System.debug('[ExcelUpload] JSON deserialization failed: ' + e.getMessage());
            return;
        }

        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < rawList.size(); i++) {
            Map<String, Object> row = (Map<String, Object>) rawList.get(i);

            System.debug('[ExcelUpload] Processing row ' + (i + 1) + ': ' + row);

            Contact c   = new Contact();
            c.AccountId = accountId;
            c.FirstName = (String) row.get('FirstName');
            c.LastName  = String.isNotBlank((String) row.get('LastName'))
                          ? (String) row.get('LastName') : 'Unknown';
            c.Email     = (String) row.get('Email');
            c.Phone     = (String) row.get('Phone');

            System.debug('[ExcelUpload] Contact mapped - AccountId: ' + c.AccountId + ' | Name: ' + c.FirstName + ' ' + c.LastName + ' | Email: ' + c.Email + ' | Phone: ' + c.Phone);

            contacts.add(c);
        }

        System.debug('[ExcelUpload] Total contacts to insert: ' + contacts.size());

        if (!contacts.isEmpty()) {
            try {
                System.debug('[ExcelUpload] Inserting into Contact object...');
                insert contacts;
                System.debug('[ExcelUpload] Insert successful. Count: ' + contacts.size());

                for (Contact c : contacts) {
                    System.debug('[ExcelUpload] Contact saved - Id: ' + c.Id + ' | Name: ' + c.FirstName + ' ' + c.LastName);
                }

            } catch (DmlException e) {
                System.debug('[ExcelUpload] DML Insert failed: ' + e.getMessage());
            }
        } else {
            System.debug('[ExcelUpload] No contacts to insert - empty list');
        }

        System.debug('[ExcelUpload] Method completed successfully');
    }
}