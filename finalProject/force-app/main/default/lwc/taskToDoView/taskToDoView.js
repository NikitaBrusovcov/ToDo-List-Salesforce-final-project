import { LightningElement,  wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import fetchTaskToDoList from '@salesforce/apex/TaskToDoController.fetchTaskToDoList';

import ID_FIELD from '@salesforce/schema/SubTask__c.Id';
import DONE__C_FIELD from '@salesforce/schema/SubTask__c.Done__c';


export default class TaskToDoView extends LightningElement {

    @track showAddSubTaskWindow = false;
    @track showEditSubTaskWindow = false;
    @track showNegativeButton;
    @track showPositiveButton = true;
    @track positiveButtonLabel = 'Close';

    closeSubTaskEditWindow() {
        this.showEditSubTaskWindow = false;
        return refreshApex(this.wiredTaskResult);
    }

    showSubTaskEditWindow() {
      this.showEditSubTaskWindow = true;
    }

    closeSubTaskAddWindow() {
        this.showAddSubTaskWindow = false;
        return refreshApex(this.wiredTaskResult);
    }

    showSubTaskAddWindow() {
      this.showAddSubTaskWindow = true;
    }

    @track tasks;
    error;

    wiredTaskResult;

    @wire(fetchTaskToDoList)
     wiredTasks(result){
        this.wiredTaskResult = result;
        if (result.data) {
            this.tasks = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.tasks = undefined;
        }
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
                return refreshApex(this.wiredTaskResult);
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
                return refreshApex(this.wiredTaskResult);
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

