import { LightningElement,track,api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';

import ID_FIELD from '@salesforce/schema/SubTask__c.Id';
import DONE__C_FIELD from '@salesforce/schema/SubTask__c.Done__c';

export default class SubTaskList extends LightningElement {
    @track showAddSubTaskWindow = false;
    @track showEditSubTaskWindow = false;
    @track showNegativeButton;
    @track showPositiveButton = true;
    @track positiveButtonLabel = 'Close';
    @api task;
    error;

    closeSubTaskEditWindow() {
        this.showEditSubTaskWindow = false;
        this.dispatchEvent(new CustomEvent('refreshalert'));
    }

    showSubTaskEditWindow() {
      this.showEditSubTaskWindow = true;
    }

    closeSubTaskAddWindow() {
        this.showAddSubTaskWindow = false;
        this.dispatchEvent(new CustomEvent('refreshalert'));
    }

    showSubTaskAddWindow() {
      this.showAddSubTaskWindow = true;
    }

    
    updateSubTaskStatus(event) {
        let status = event.target.dataset.done;
        if(status == 'true'){
            status = false;
        } else{
            status = true;
        }
       
        const fields = {};
        fields[ID_FIELD.fieldApiName] = event.target.dataset.recordid;
        fields[DONE__C_FIELD.fieldApiName] = status;

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Subtask status updated',
                        variant: 'success'
                    })
                );
                this.dispatchEvent(new CustomEvent('refreshalert'));
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating status of record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    deleteSubTask(event){
        const recordId = event.target.dataset.recordid;
        console.log(recordId);
        deleteRecord(recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'SubTask deleted',
                        variant: 'success'
                    })
                );  
                this.dispatchEvent(new CustomEvent('refreshalert'));
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: 'Error deleting record ' + error,
                        variant: 'error'
                    })
                );
            });
    }


}