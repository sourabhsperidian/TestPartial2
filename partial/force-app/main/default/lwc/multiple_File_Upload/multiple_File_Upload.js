import { LightningElement, wire } from 'lwc';
	import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
	import TYPE_FIELD from '@salesforce/schema/Account.Type';
	import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
	import ACCOUNT_OBJECT from '@salesforce/schema/Account';
	import updateAccts from '@salesforce/apex/DynamicRowsController.updateAccts';
	import { ShowToastEvent } from 'lightning/platformShowToastEvent';
	export default class DynamicRows extends LightningElement {

		accounts;
		error;
		typeOptions;
		industryOptions;

		connectedCallback() {

			this.accounts = [ {
				'Name' : null,				
				'Is_Primary__c' : false,				
				'Description' : null
			} ];

		}

		@wire( getObjectInfo, { objectApiName: ACCOUNT_OBJECT } )
		objectInfo;

		@wire( getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD } )
		getIndustryValues( { error, data } ) {

			if ( data ) {
								
				this.industryOptions = data.values.map( objPL => {
					return {
						label: `${objPL.label}`,
						value: `${objPL.value}`
					};
				});
							} else if ( error ) {

				console.error( JSON.stringify( error ) );

			}

		}

		@wire( getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: TYPE_FIELD } )
		getTypeValues( { error, data } ) {

			if ( data ) {
								
				this.typeOptions = data.values.map( objPL => {
					return {
						label: `${objPL.label}`,
						value: `${objPL.value}`
					};
				});

			} else if ( error ) {

				console.error( JSON.stringify( error ) );

			}

		}

		addRow() {

			let newEntry = {
				'Name' : null,
				'Is_Primary__c' : false,				
				'Description' : null
			};

			if ( this.accounts ) {

				this.accounts = [this.accounts, newEntry ];

			} else {

				this.accounts = [ newEntry ];

			}

		}

		deleteRow( event ) {

			let strIndex = event.target.dataset.recordId;
			let tempAccounts = this.accounts;
			tempAccounts.splice( strIndex, 1 );
			console.log( 'Temp Accounts are ' + JSON.stringify( tempAccounts ) );
			this.accounts = JSON.parse( JSON.stringify( tempAccounts ) );

		}

		handleChange( event ) {

			let recs =  this.accounts;
			let value = event.target.value;
			let label = event.target.label;
			let name;

			switch( label ) {

				case 'File Name':
					name = 'Name';
					break;

				case 'Is Primary':
					name = 'Is_Primary__c';
					break;
			
				case 'Description':
					name = 'Description';
					break;

			}

			console.log( label + ' – ' + value );
			let strIndex = event.target.dataset.recordId;
			console.log( 'Index is ' + strIndex );
			let rec = recs[ strIndex ];
			rec[ name ] = value;
			recs[ strIndex ] = rec;
			console.log( 'Temp Records are ' + JSON.stringify( recs ) );
			this.accounts = JSON.parse( JSON.stringify( this.accounts ) );

		}

		saveAccounts() {

			console.log( 'Temp Records are ' + JSON.stringify( this.accounts ) );

			updateAccts( { listAccts : this.accounts } )
			.then( result => {

				console.log( 'Result ' + JSON.stringify( result ) );
				let message;
				let variant;

				if ( result === 'Successful' ) {

					message = 'Successfully Processed!';
					variant = 'success';

				} else {

					message = 'Some error occured. Please reach out to your Salesforce Admin for help!';
					variant = 'error';
					
				}

				const toastEvent = new ShowToastEvent( {

					title: 'Record creation',
					message: message,
					variant: variant

				} );
				this.dispatchEvent( toastEvent );

			} )
			.catch( error => {

				console.log( 'Error ' + JSON.stringify( error ) );
				
			} );

		}

	}