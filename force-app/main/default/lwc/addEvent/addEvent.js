import { LightningElement,track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import EVT_OBJECT from '@salesforce/schema/Event__c';
import Name_F from '@salesforce/schema/Event__c.Name__c';
import Event_Organizer__c from '@salesforce/schema/Event__c.Event_Organizer__c';
import Start_DateTime__c from '@salesforce/schema/Event__c.Start_DateTime__c';
import End_Date_Time__c from '@salesforce/schema/Event__c.End_Date_Time__c';
import Max_Seats__c from '@salesforce/schema/Event__c.Max_Seats__c';
import Location__c from '@salesforce/schema/Event__c.Location__c';
import Event_Detail__c from '@salesforce/schema/Event__c.Event_Detail__c';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getSpeaker from '@salesforce/apex/eventDetailController.getSpeaker';
export default class AddEvent extends NavigationMixin(LightningElement) {
    @track eventRecord = {
        Name:'',
        Event_Organizer__c:'',
        Start_DateTime__c:null,
        End_Date_Time__c:null,
        Max_Seats__c:null,
        Location__c:'',
        Event_Detail__c:''
    }
@track errors;
    handleChange(event){
        let name=event.target.name;
        let value=event.target.value;
        this.eventRecord[name]=value;
    }
    lookupChange(event){
        let selectedRecId = event.detail.selectedRecordId;
        let parentField = event.detail.parentfield;
        this.eventRecord[parentField] = selectedRecId;
    }
    handleClick(){
        const fields={};
        fields[Name_F.fieldApiName]=this.eventRecord.Name;
        fields[Event_Organizer__c.fieldApiName]=this.eventRecord.Event_Organizer__c;
        fields[Start_DateTime__c.fieldApiName]=this.eventRecord.Start_DateTime__c;
        fields[End_Date_Time__c.fieldApiName]=this.eventRecord.End_Date_Time__c;
        fields[Max_Seats__c.fieldApiName]=this.eventRecord.Max_Seats__c;
        fields[Location__c.fieldApiName]=this.eventRecord.Location__c;
        fields[Event_Detail__c.fieldApiName]=this.eventRecord.Event_Detail__c;
        
        const eventRecord = { apiName: EVT_OBJECT.objectApiName, fields };

        createRecord(eventRecord)
        .then((eventRec) => {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Record Saved',
                message: 'Event Draft is Ready',
                variant: 'success'
            }));
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    actionName: "view",
                    recordId: eventRec.id
                }
            });
        }).catch((err) => {
            this.errors = JSON.stringify(err);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error Occured',
                message: this.errors,
                variant: 'error'
            }));
        });
}

handleCancel() {
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            actionName: "home",
            objectApiName: "Event__c"
        }
    });
}

}