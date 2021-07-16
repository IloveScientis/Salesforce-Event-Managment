import { LightningElement ,api,track} from 'lwc';
import getSpeaker from '@salesforce/apex/eventDetailController.getSpeaker';
import getLocationDetail from '@salesforce/apex/eventDetailController.getLocationDetail';
import getEventAttendee from '@salesforce/apex/eventDetailController.getEventAttendee';
const columns = [
    { label: 'Name', fieldName: 'name',
    cellAttributes: {
        iconName: "standard:user",
        iconPosition: "left"
      }
},
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Company Name', fieldName: 'CompanyName'}
];

const columnsAtt = [
  { label: 'Name', fieldName: 'name',
  cellAttributes: {
    iconName: "standard:user",
    iconPosition: "left"
  }
},
  { label: 'Email', fieldName: 'Email', type: 'email' },  
  { label: 'Company Name', fieldName: 'CompanyName'},
  { label: 'Location', fieldName: 'Location',
  cellAttributes: {
    iconName: "utility:location",
    iconPosition: "left"
  }
},
];
export default class EventDetail extends LightningElement {
@api recordId;
@track speakerList;
@track eventRec;
@track attendeesList;
columnList=columns;
columnAtt=columnsAtt;
errors;
rowOffset = 0;
handleSpeakerActive(){
    getSpeaker({
       eventId:this.recordId
    })
    .then((result) => {
        result.forEach(speaker => {
            speaker.name=speaker.Speaker__r.Name,
            speaker.Email=speaker.Speaker__r.Email__c,
            speaker.phone=speaker.Speaker__r.Phone__c,
            speaker.CompanyName=speaker.Speaker__r.Company__c
        });
        window.console.log('Result '+result);
        this.speakerList=result;
        this.errors =undefined;
    }).catch((err) => {
        this.errors = err;
        this.speakerList=undefined;
    });
}

handleLocatioDetails() {
    getLocationDetail({
      eventId: this.recordId
    })
      .then((result) => {
        if (result.Location__c) {
          this.eventRec = result;
        } else {
          this.eventRec = undefined;
        }
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.speakerList = undefined;
      });
  }

  handleEventAttendeeDetail(){
    getEventAttendee({
      eventId: this.recordId
    })
      .then((result) => {
        result.forEach((att) => {
          //window.console.log(att.Attendee__r.Name);
          att.name = att.Attendee__r.Name;
          att.Email = att.Attendee__r.Email__c;
          att.CompanyName = att.Attendee__r.Company_Name__c;
          if (att.Attendee__r.Location__c) {
            att.Location = att.Attendee__r.Location__r.Name;
          } else {
            att.Location = "Preferred Not to Say";
          }
        });

        //window.console.log(" result ", result);
        this.attendeesList = result;
        //window.console.log(" attendeesList ", this.attendeesList);
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.attendeesList = undefined;
      });
    }
    
}