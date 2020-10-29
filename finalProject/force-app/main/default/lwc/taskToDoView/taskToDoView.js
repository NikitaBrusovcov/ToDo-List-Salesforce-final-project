import { LightningElement,  wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';

import getTaskToDoList from '@salesforce/apex/TaskToDoController.getTaskToDoList';
import getNext from '@salesforce/apex/TaskToDoController.getNext';
import getPrevious from '@salesforce/apex/TaskToDoController.getPrevious';
import TotalRecords from '@salesforce/apex/TaskToDoController.TotalRecords';

import ID_FIELD from '@salesforce/schema/SubTask__c.Id';
import DONE__C_FIELD from '@salesforce/schema/SubTask__c.Done__c';


export default class TaskToDoView extends LightningElement {

    @track showAddSubTaskWindow = false;
    @track showEditSubTaskWindow = false;
    @track showEditTaskWindow = false;
    @track showNegativeButton;
    @track showPositiveButton = true;
    @track positiveButtonLabel = 'Close';

    closeTaskEditWindow() {
        this.showEditTaskWindow = false;
        return refreshApex(this.wiredTaskResult);
    }

    showTaskEditWindow() {
      this.showEditTaskWindow = true;
    }

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

    @track v_Offset=0;
    @track v_TotalRecords;
    @track page_size = 6;
    wiredTaskResult;

    @wire(getTaskToDoList,{ v_Offset: '$v_Offset', v_pagesize: '$page_size' } )
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

    connectedCallback() {
        TotalRecords().then(result=>{
            this.v_TotalRecords = result;
        });
    }

    previousHandler2(){
        getPrevious({v_Offset: this.v_Offset, v_pagesize: this.page_size}).then(result=>{
            this.v_Offset = result;
            if(this.v_Offset === 0){
                this.template.querySelector('c-pagination').changeView('trueprevious');
            }else{
                this.template.querySelector('c-pagination').changeView('falsenext');
            }
        });
    }
    
    nextHandler2(){
        getNext({v_Offset: this.v_Offset, v_pagesize: this.page_size}).then(result=>{
            this.v_Offset = result;
           if(this.v_Offset + 10 > this.v_TotalRecords){
                this.template.querySelector('c-pagination').changeView('truenext');
            }else{
                this.template.querySelector('c-pagination').changeView('falseprevious');
            }
        });
    }
    
    changeHandler2(event){
        const det = event.detail;
        this.page_size = det;
    }
    
    firstpagehandler(){
        this.v_Offset = 0;
        this.template.querySelector('c-pagination').changeView('trueprevious');
        this.template.querySelector('c-pagination').changeView('falsenext');
    }
    
    lastpagehandler(){
        this.v_Offset = this.v_TotalRecords - (this.v_TotalRecords)%(this.page_size);
        console.log(this.v_Offset);
        console.log(this.v_TotalRecords);
        console.log(this.page_size);
        if(this.v_Offset === this.v_TotalRecords){
            this.v_Offset = this.v_TotalRecords-this.page_size;
        }
       
        this.template.querySelector('c-pagination').changeView('falseprevious');
        this.template.querySelector('c-pagination').changeView('truenext');
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

