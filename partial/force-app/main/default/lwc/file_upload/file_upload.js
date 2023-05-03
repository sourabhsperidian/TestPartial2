import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class file_Upload extends NavigationMixin(LightningElement) {

    keyIndex = 0;
	checkBoxFieldValue = false;
    @track itemList = [
        {
            id: 0
        }
    ];

    addRow() {
        ++this.keyIndex;
        var newItem = [{ id: this.keyIndex }];
        this.itemList = this.itemList.concat(newItem);
		console.log("item list>> ",+itemList);
		console.log("item new>> ",+newItem);
		

    }

    removeRow(event) {
        if (this.itemList.length >= 2) {
            this.itemList = this.itemList.filter(function (element) {
                return parseInt(element.id) !== parseInt(event.target.accessKey);
            });
        }
    }
	handleCheckboxChange(event){
		//this.checkBoxFieldValue = event.target.value;
		console.log('this.checkBoxFieldValue >> ',+this.checkBoxFieldValue);
		let i;
        let checkboxes = this.template.querySelectorAll('[data-id="checkbox"]')
		console.log('Check checkboxes',+checkboxes);

        for(i=0; i<checkboxes.length; i++) {
			console.log('Check box is checked');

          //  checkboxes[i].checked = event.target.checked;
			checkboxes[i].disabled = true;
        }
		/*if(event.target.checked){
			this.checkBoxFieldValue = true; 
			console.log('Check box is checked');
		}
		else{
			console.log('check box is unchecked');
		}*/
	}
    handleSubmit() {
				alert('Test');
        var isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isVal = isVal && element.reportValidity();
        });
        if (isVal) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                //element.submit();
            });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'File successfully created',
                    variant: 'success',
                }),
            );
            // Navigate to the Account home page
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Amazon_File__c',
                    actionName: 'home',
                },
            });
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: 'Please enter all the required fields',
                    variant: 'error',
                }),
            );
        }
    }

}