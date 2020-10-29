import { LightningElement, api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import SUBTASK_OBJECT from '@salesforce/schema/SubTask__c';
import NAMES_FIELD from '@salesforce/schema/SubTask__c.Name';
import DONE__C_FIELD from '@salesforce/schema/SubTask__c.Done__c';
import TASK_TODO__C_FIELD from '@salesforce/schema/SubTask__c.Task_ToDo__c';

export default class AddSubTaskWindow extends LightningElement {
  @api showPositive;
  @api showNegative;
  @api positiveButtonLabel = 'Save';
  @api negativeButtonLabel = 'Cancel';
  @api showWindow;
  @api taskTodoObj;

  subTaskObject = SUBTASK_OBJECT;
  myFields = [NAMES_FIELD, DONE__C_FIELD,TASK_TODO__C_FIELD];

  handleSuccess(event) {
    const evt = new ShowToastEvent({
        title: "SubTask was created",
        message: "Record ID: " + event.detail.id,
        variant: "success"
    });
    this.dispatchEvent(evt);
}

  constructor() {
    super();
    this.showNegative = true;
    this.showPositive = true;
    this.showWindow = false;
    this.taskTodoObj=null;
  }

  handlePositive() {
    this.dispatchEvent(new CustomEvent('positive'));
  }
  
  handleNegative() {
    this.dispatchEvent(new CustomEvent('negative'));
  }

  handleClose() {
    this.dispatchEvent(new CustomEvent('close'));
  }
}