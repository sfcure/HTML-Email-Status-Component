/*
Author: Naval Sharma
Website: https://sfcure.com
GitHub: https://github.com/sfcure/html-email-status-component
License: BSD 3-Clause License
*/

/**
* Test class for HTMLEmailStatusController class
* Test method for verifying functionality of controller
* Need to set SeeAllData = True as EmailStatus object records are
* not available in the queries. 
* Artile - https://help.salesforce.com/articleView?id=000247964&language=en_US&type=1
**/

@isTest(SeeAllData = True) 
private class HTMLEmailStatusControllerTest {
    

    @isTest
    private static void test_getEmailStatuses_method_with_no_records() {
        
        // Create a contact record
        Contact con = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@test.com' 
        );
        
        insert con;
        
        List<Map<String, Object>> relatedHTMLEmailStatus = null;
        
        Test.startTest();
        
        relatedHTMLEmailStatus = HTMLEmailStatusController.getEmailStatuses( 'Contact', con.Id );
        
        System.assertEquals(0, relatedHTMLEmailStatus.size() );
        
        Test.stopTest();
        
        
    }    
    
    @isTest
    private static void test_getEmailStatuses_method_with_records() {
        
        // Create a contact record
        Contact con = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@test.com' 
        );
        
        insert con;
        
        // Send an email to contact
        EmailTemplate et = [SELECT Id FROM EmailTemplate LIMIT 1];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setTargetObjectId( con.Id );
        mail.setTemplateId( et.Id );
        mail.setSaveAsActivity( true );
        mail.setTreatTargetObjectAsRecipient( true );
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        Integer invocations = Limits.getEmailInvocations();
        system.assertEquals( 1, invocations, 'An email should be sent' );
        
        List<Map<String, Object>> relatedHTMLEmailStatus = null;
        
        Test.startTest();
        
        HTMLEmailStatusController.doNotApplyRecordId = true;
        
        relatedHTMLEmailStatus = HTMLEmailStatusController.getEmailStatuses( 'Contact', con.Id );
        
        System.assertEquals( true, relatedHTMLEmailStatus.size() > 0 );
        
        Test.stopTest();
        
        
    }    
}