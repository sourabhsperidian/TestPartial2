import { LightningElement,track,wire,api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
// import { loadStyle } from "lightning/platformResourceLoader";
// import modal from "@salesforce/resourceUrl/FileUploadCSS";
import NAME_FIELD from '@salesforce/schema/Amazon_Files__c.Name';
import EPC from '@salesforce/schema/Amazon_Files__c.EPC__c';
import FLOOR_PLAN from '@salesforce/schema/Amazon_Files__c.Floor_Plan__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Amazon_Files__c.Description__c';
import IS_PRIMARY from '@salesforce/schema/Amazon_Files__c.Is_Primary__c';
import deletefile from '@salesforce/apex/AmazonFilesController.deletefile';
import getAmazoneFiles from '@salesforce/apex/AmazonFilesController.getAmazoneFiles';
import createemptyfile from '@salesforce/apex/AmazonFilesController.createemptyfile';
import submitdoc from '@salesforce/apex/AWSIntegration.UploadDocuments'



const actions = [
    
    { label: 'Delete', name: 'delete' }
 ];
const columnList = [
    { label: 'File Name', fieldName: NAME_FIELD.fieldApiName,editable: true },
    { label: 'Description', fieldName: DESCRIPTION_FIELD.fieldApiName,editable: true },
    { label: 'EPC',type: 'boolean', fieldName: EPC.fieldApiName,editable: false },
    { label: 'Floor Plan',type: 'boolean', fieldName: FLOOR_PLAN.fieldApiName,editable: false },
    { label: 'Primary Image',type: 'boolean', fieldName: IS_PRIMARY.fieldApiName,editable: false },
    { label: 'Documents Upload', type: 'fileUpload', fieldName: 'Id', typeAttributes: { acceptedFileFormats: '.jpg,.jpeg,.pdf,.png,.csv,.mpeg,.mp4,.txt,.mp3,.xlsx',fileUploaded:{fieldName: 'IsDocumentComplete__c'} } },
    {
        type: 'action',
        typeAttributes: {
            rowActions: actions,
            menuAlignment: 'right'
        }
    }
];


export default class RealestateDocumentUpload extends LightningElement {
    saveDraftValues = [];
    @track data = [];
    accounts;
    datanew;
    datacopy;
    @api recordId
    @track Submitenable = false;
    @track FileNameVal;
    @track DescriptionVal;
    @track EPCVal = false;
    @track FloorPlanVal = false;
    @track IsPrimaryVal = false;
    @track columns = columnList;
    @track showLoadingSpinner = false;
    refreshTable;
    @api objectApiName;

   // 
  
//New Record Code: Monika start

showForm = false
    disableSubmit(){
    let len = this.data.length;
        if(len>0)
    return true;
    else return false;
}
    newRecord () {
        this.showForm = true
    }

    closeDialog () {
        this.showForm = false
        this.FileNameVal = null;
        this.EPCVal = false;
        this.FloorPlanVal = false;
        this.IsPrimaryVal = false;
    }

    handleFileChange(event){
        this.FileNameVal = event.target.value;
        console.log('FileNameVal:'+this.FileNameVal);    
    } 
    handleEPCChange(event){
        this.EPCVal = event.target.checked;  
        console.log('EPCVal:'+this.EPCVal); 
    } 
    handleFPlanChange(event){
        this.FloorPlanVal = event.target.checked;  
        console.log('FloorPlanVal:'+this.FloorPlanVal); 
    } 
    handlePrimaryChange(event){
       this.IsPrimaryVal = event.target.checked;
       console.log('IsPrimaryVal:'+this.IsPrimaryVal);
    }

//New Record Code: Monika end
   connectedCallback() {
  //  loadStyle(this, modal);
       getAmazoneFiles({ unitId: this.recordId, objectName: this.objectApiName}).then(res => { 
            console.log('res:'+res);
            this.data = res; 
            this.accounts=res;
          //  disableSubmit();
        }
        ).catch(err => console.error('err:'+err));

        console.log('columns => ', columnList);
        console.log('data1'+this.data);
        console.log('data'+JSON.stringify(this.data));
    }
    handleUploadFinished(event) {
        event.stopPropagation();
        console.log('data => ', JSON.stringify(event.detail.data));
    }

    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        console.log('event.detail.draftValues'+JSON.stringify(event.detail.draftValues));
        //event.detail.draftValues.Id
        const recordInputs = this.saveDraftValues.slice().map(draft => {           
            const fields = Object.assign({}, draft);
            return { fields };
        });
        //recordInputs.fields[0].id.value = event.detail.row.Id;
        console.log('rcdinp'+JSON.stringify(recordInputs));
    
        // Updateing the records using the UiRecordAPi
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {  
            this.ShowToast('Success', 'Records Updated Successfully!', 'success', 'dismissable');
           this.saveDraftValues = []; 
        }).catch(error => {
            this.ShowToast('Error', 'An Error Occured!!', 'error', 'dismissable');
        }).finally(() => {
            this.saveDraftValues = [];
        });
      //  console.log('df',event.detail.draftVlaues[0].keys);
      for(let n=0;n<this.saveDraftValues.length;n++){
      let nme=event.detail.draftValues[n].Name; //Monika commented to debug issue
      let dec= event.detail.draftValues[n].Description__c;
      let primary= event.detail.draftValues[n].Is_Primary__c;
      let epc= event.detail.draftValues[n].EPC;
      let floorplan= event.detail.draftValues[n].FLOOR_PLAN;
        for(let m=0;m<this.data.length;m++){
       
        if(this.data[m].Id==event.detail.draftValues[n].Id){
            if(nme!=undefined){
                //nme!=null||nme!=''||
                this.data[m].Name= event.detail.draftValues[n].Name;
                console.log('Name'+JSON.stringify(this.data[m].Name));}                    
                      if(dec!=undefined){
                        this.data[m].Description__c= event.detail.draftValues[n].Description__c;}
                     //   console.log('Description__c'+JSON.stringify(this.data[m].Description__c));}
                        if(primary!=undefined){
                            this.data[m].Is_Primary__c= event.detail.draftValues[n].Is_Primary__c;}
                     //       console.log('Is_Primary__c'+JSON.stringify(this.data[m].Is_Primary__c));}
                            if(epc!=undefined){
                                this.data[m].EPC= event.detail.draftValues[n].Is_Primary__c;}
                       //         console.log('EPC'+JSON.stringify(this.data[m].EPC));}
                                if(floorplan!=undefined){
                                    this.data[m].FLOOR_PLAN= event.detail.draftValues[n].FLOOR_PLAN;}
                         //           console.log('Is_Primary__c'+JSON.stringify(this.data[m].Is_Primary__c));}
        }
                          
    }
}//Monika commented to debug issue
    console.log('data2'+JSON.stringify(this.data));
        return this.refresh();

      }
     
  
 
    ShowToast(title, message, variant, mode){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant,
                mode: mode
            });
            this.dispatchEvent(evt);
    }
 
    // This function is used to refresh the table once data updated
   async refresh() {
      //  await refreshApex(this.data);
    }
    handleClick()
    {
        console.log('FileNameVal:'+this.FileNameVal);
        let FVal;
        let FValtr = this.FileNameVal;
        let epc = this.EPCVal;
        let pri = this.IsPrimaryVal;
        let Floor = this.FloorPlanVal;
      //  console.log('DescriptionVal:'+this.DescriptionVal);
      console.log('EPC:'+this.EPCVal);
      console.log('IsPrimary:'+this.IsPrimaryVal);
      console.log('FloorPlan:'+this.FloorPlanVal);
        FVal = FValtr.trim();
         if(FVal != undefined && FVal!= '   ' && FVal!= '' && FVal!=null && FVal!=' ')
         {
            if((epc== true & pri == false & Floor== false) || (pri== true & epc == false & Floor== false)|| (Floor== true & pri == false & epc== false)|| (epc== false & pri == false & Floor== false))
            {
        createemptyfile({ unitId: this.recordId, objectName: this.objectApiName, FileNameVal: this.FileNameVal, DescriptionVal: this.DescriptionVal, isPrimary: this.IsPrimaryVal, EPC: this.EPCVal, FloorPlan: this.FloorPlanVal}).then(res1 => { 
            console.log('res:'+res1);
            console.log('objectName:'+this.objectApiName);
          //  res1[0].Name=''; removed by Monika
                    if(res1 == null){
                    //   this.showForm = false;
                    this.FileNameVal = null;
                    this.IsPrimaryVal  = false;
                    this.EPCVal = false;
                    alert('Error occured! Check if Primary/EPC image already existing!');                   
                        
                    }
                    else{
                    this.data = res1; 
                    this.accounts=res1;
                    this.FileNameVal = null;
                    this.EPCVal = false;
                    this.FloorPlanVal = false;
                    this.IsPrimaryVal = false;
                        }
                                            }
                                            ).catch(err => console.error('err:'+err));
                                            this.showForm = false
            }   
            else {
            alert('Only one Image can be Primary/EPC/Floor Plan!');
                }
           //     disableSubmit();

        }

    else{
                alert('Please enter required field!');
        }
            this.EPCVal = false;
            this.FloorPlanVal = false;
            this.IsPrimaryVal = false;
        return this.refresh();
    }
    updateRecordView(recordId) {
        updateRecord({fields: { Id: recordId }});
    }

    handleRowActions(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
       // this.recordId = row.Id;
        console.log('rowId'+row.Id);
        switch (actionName) {
          /*  case 'view':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        actionName: 'view'
                    }
                });
                break;
            case 'edit':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        objectApiName: 'Account',
                        actionName: 'edit'
                    }
                });
                break;*/
            case 'delete':
                this.delfiles(row);
               return refreshApex(this.row);
                break;
        }
       // eval("$A. get('e. force:refreshView'). fire());
    }

    delfiles(currentRow) {
        this.showLoadingSpinner = true;
        deletefile({ objfiles: currentRow }).then(result => {
            window.console.log('result^^' + result);
            this.showLoadingSpinner = false;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success!!',
                message: currentRow.Name + ' file deleted.',
                variant: 'success'
            }));
            this.updateRecordView(currentRow.Id);
          //code to remove row
         
            
        }).catch(error => {
            window.console.log('Error ====> ' + error);
            this.showLoadingSpinner = false;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!',
                message: JSON.stringify(error),
                variant: 'error'
            }));
        });
            let rowid=currentRow.Id;
            this.data = this.data.filter((row) => row.Id !== currentRow.Id);
            return refreshApex(this.refreshTable);

          // console.log('lngth'+this.template.querySelector('[data-row-key-value="0015g00000nGfc7AAC"]').length);
    }
    handleSubmit(){
        console.log('reached');
        console.log('Data value' +this.data);
        let lenData = this.data.length;
        console.log('lenData' +lenData);
        if(lenData > 0){
        submitdoc({amf:this.data, objectName: this.objectApiName}).then(result => {
            console.log('result^^' + result);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Sent for Upload!',
                message: 'Document Submitted for upload on Web',
                variant: 'info'
            }));
            this.data=[];
            return refreshApex(this.refreshTable);
            
        }).catch(error => {
            window.console.log('Error ====> ' + error);
           
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!',
                message: 'Error found! please Resubmit'+JSON.stringify(error),
                variant: 'error'
            }));
            getAmazoneFiles({ unitId: this.recordId, objectName: this.objectApiName}).then(res => { 
                console.log('res:'+res);
                this.data = res; 
                this.accounts=res;
            }
            ).catch(err => console.error('err:'+err));
            
        });

        console.log('done');
        let nullifydata=[];
        this.data= nullifydata;
        this.data=[];
             
    }
    else alert('No file is added for Submit!');
}

}