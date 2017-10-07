/*
Author: Naval Sharma
Website: https://sfcure.com
GitHub: https://github.com/sfcure/html-email-status-component
License: BSD 3-Clause License
*/

public with sharing class HTMLEmailStatusController {
    
    /**
    * Queries EmailStatuses in the sub-query
    * on the given object name where the Id equals passed recordId.
    *
    * Example:
    *   Calling getEmailStatuses( 'Contact', '0039000001om22A' )
    *   returns EmailStatuses associated with the passed recordId.
    */
    
    @TestVisible
    private static Boolean doNotApplyRecordId = false;
    
    @AuraEnabled
    public static List<Map<String, Object>> getEmailStatuses(String objectName, String recordId){
        
        // Get list of all the EmailStatus records 
        // associated with the passed recordId
        
        System.debug( ' Querying ' + objectName + ' with id = ' + recordId );
        
        // Build SOQL query
        String query = 'SELECT';
                query += ' ( SELECT';
                query += ' Id,'; 
                query += ' TaskId,'; 
                query += ' Task.Subject,'; 
                query += ' CreatedDate,'; 
                query += ' FirstOpenDate,'; 
                query += ' LastOpenDate,'; 
                query += ' TimesOpened,'; 
                query += ' EmailTemplateName'; 
                query += ' FROM'; 
                query += ' EmailStatuses'; 
                query += ' ) ';
                
            query += ' FROM';
            query +=  ' ' + objectName;
            
            if( !doNotApplyRecordId )  // Added to bypass the test because of platform limitations
                query += ' WHERE Id = \'' + recordId + '\'';
        
        System.debug( ' Constructed Query ' + query );
        
        List<Map<String, Object>> emailStatuses = new List<Map<String, Object>>();
        
        // Query records
        for( sObject s : Database.query( query ) ) {
            
            if( s.getSObjects( 'EmailStatuses' ) != null ) {
            
                for( EmailStatus es : (List<EmailStatus>) s.getSObjects( 'EmailStatuses' ) ) {
                     
                    emailStatuses.add( new Map<String, Object> {
                        'Id' => es.Id,
                        'TaskId' => es.Task.Id,
                        'Subject' => es.Task.Subject,
                        'CreatedDate' => es.CreatedDate,
                        'CreatedDateTimestamp' => es.CreatedDate != null ? es.CreatedDate.getTime() : null,
                        'FirstOpenDate' => es.FirstOpenDate,
                        'FirstOpenDateTimestamp' => es.FirstOpenDate != null ? es.FirstOpenDate.getTime() : null,
                        'LastOpenDate' => es.LastOpenDate,
                        'LastOpenDateTimestamp' => es.LastOpenDate != null ? es.LastOpenDate.getTime() : null,
                        'TimesOpened' => es.TimesOpened
                    });
                    
                }
            }
        }
        
        return emailStatuses;
        
    }
    
}