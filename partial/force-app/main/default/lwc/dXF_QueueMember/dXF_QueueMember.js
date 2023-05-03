import { LightningElement,track,wire,api } from 'lwc';
import Objects_Type from "@salesforce/apex/DXF_QueueMemeberHandler.getQueues";

export default class DXF_QueueMember extends LightningElement {
		
		
	queueColumns = [
        { label: 'Member Id', fieldName: 'Id' },
        { label: 'User Id or Group Id', fieldName: 'UserOrGroupId' }
    ];
		
	@track TypeOptions;
  @wire(Objects_Type, {})
	WiredObjects_Type({ error, data }) {
			if (data) {
					try{
							let options = [];
							for (var key in data) {
									options.push({ label: data[key].groupId, value: data[key].groupName  });
							}
							this.TypeOptions = options;
					}
					catch (error) {
          	console.error('check error here', error);
          }
			}else if(error){
					console.error('check error here', error);
			}
	}
		handleTypeChange(event){
        var Picklist_Value = event.target.value;
				
				onChangeQueue({ 
             a_First_Name : Picklist_Value
         })
         .then(result => {
             const event = new ShowToastEvent({
                 title: 'Error',
                 message: 'New Contact '+ this.a_First_Name_Ref +' '+ this.a_Last_Name_Ref +' created.',
                 variant: 'success'
             });
             this.dispatchEvent(event);
         })
         .catch(error => {
             const event = new ShowToastEvent({
                 title : 'Error',
                 message : 'Please Contact System Admin',
                 variant : 'error'
             });
             this.dispatchEvent(event);
         });        
    }
}