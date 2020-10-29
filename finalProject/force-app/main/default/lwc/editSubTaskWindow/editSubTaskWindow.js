import { LightningElement, api } from 'lwc';


import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import SUBTASK_OBJECT from '@salesforce/schema/SubTask__c';

export default class EditSubTaskWindow extends LightningElement {
  @api showPositive;
  @api showNegative;
  @api positiveButtonLabel = 'Save';
  @api negativeButtonLabel = 'Cancel';
  @api showEditSubTaskWindow;
  @api taskTodoObj;

  subTaskObject = SUBTASK_OBJECT;

  handleSuccess(event) {
    const evt = new ShowToastEvent({
        title: "SubTask was edited",
        message: "Record ID: " + event.detail.id,
        variant: "success"
    });
    this.dispatchEvent(evt);
}

  constructor() {
    super();
    this.showNegative = true;
    this.showPositive = true;
    this.showEditSubTaskWindow = false;
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