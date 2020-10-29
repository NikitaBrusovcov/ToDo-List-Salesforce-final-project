import { LightningElement, api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EditSubTaskWindow extends LightningElement {
  @api showPositive;
  @api showNegative;
  @api positiveButtonLabel = 'Save';
  @api negativeButtonLabel = 'Cancel';
  @api showEditSubTaskWindow;
  @api subTaskObj;

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
    this.subTaskObj=null;
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