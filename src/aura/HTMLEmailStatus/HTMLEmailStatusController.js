/*
Author: Naval Sharma
Website: https://sfcure.com
GitHub: https://github.com/sfcure/html-email-status-component
License: BSD 3-Clause License
*/

({
	doInit : function(component, event, helper) {
		
		var objectName = component.get( 'v.sObjectName' );
        var recordId = component.get( 'v.recordId' );
		
        helper.getEmailStatusesAsync( component, objectName, recordId )
            .then( $A.getCallback( function( emailStatuses ) { 
            	
                component.set( 'v.fetchedEmailStatuses', emailStatuses );
                
            })).catch( $A.getCallback( function( err ) {
            	console.log(err);
				var toastEvent = $A.get( 'e.force:showToast' );
                toastEvent.setParams({
                	'title' : 'Problem occured while initializing component',
                   'message' : err,
                   'type' : 'error',
                   'mode': 'sticky'
                }).fire();

        	}));
	},
    
    handleLinkClick : function( component, event, helper ) {
        
    	var clickedTaskId = event.target.getAttribute( 'data-taskId' );

        helper.navigateToRecord( clickedTaskId );   
    },
    
    handleMenuSelect : function( component, event, helper ) {
    	
        var selectedMenuItemValue = event.getParam( 'value' );    
        
        if(selectedMenuItemValue.startsWith( 'edit' )) {
            
            var recordId = selectedMenuItemValue.split( ':' )[1];
            var editRecordEvent = $A.get("e.force:editRecord");
            editRecordEvent.setParams({
                 "recordId": recordId
            });
            editRecordEvent.fire();
        }
    }
})