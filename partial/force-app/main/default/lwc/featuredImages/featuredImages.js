import { LightningElement, wire, api } from 'lwc';
import UNIT_ID from '@salesforce/schema/Unit__c.Id';
import UNIT_NAME from '@salesforce/schema/Unit__c.Name';
import IMG_URL from '@salesforce/schema/Unit__c.Featured_Image_Url__c';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getPrimaryImgURL from '@salesforce/apex/AmazonFilesController.getPrimaryImgURL';

const FIELDS = [
    UNIT_NAME,
    IMG_URL
];

export default class FeaturedImages extends LightningElement {

    @api recordId;
    @api objectApiName;
    
    userId = UNIT_ID.value;
    name;
    imageURL;

    connectedCallback() {

        getPrimaryImgURL({ unitId: this.recordId, objectName: this.objectApiName}).then(res => { 
            console.log('res:'+res);
            this.imageURL = res; 
        }
        ).catch(err => console.error('err:'+err));

       console.log( 'Id of the user is ' + this.recordId );
        console.log( 'Fields are ' + JSON.stringify( FIELDS ) );
        
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {

        if ( error ) {

            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading Account',
                    message,
                    variant: 'error',
                }),
            );

        } else if ( data ) {

            console.log( 'Data is ' + JSON.stringify( data ) );
            this.name = data.fields.Name.value;
         //   this.imageURL = data.fields.Featured_Image_Url__c.value;

        }

    }

}