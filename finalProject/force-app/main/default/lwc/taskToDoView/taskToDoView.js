import { LightningElement,  wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
import fetchTaskToDoList from '@salesforce/apex/TaskToDoController.fetchTaskToDoList';

export default class TaskToDoView extends LightningElement {
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

