import { LightningElement } from 'lwc';
import documentUploadRender from './documentUploadRender.html';
import LightningDatatable from 'lightning/datatable';


export default class FileUploadDataTable extends LightningDatatable   {
    static customTypes = {   //it show that we are creating custom type
        fileUpload: {  // type of custom element
            template: documentUploadRender, // Which html will render
            typeAttributes: ['acceptedFileFormats','fileUploaded']  // attribute of that type
        }
    };
}