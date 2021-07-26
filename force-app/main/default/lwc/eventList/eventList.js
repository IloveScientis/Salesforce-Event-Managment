import { LightningElement,track } from 'lwc';
import upcomingEvents from "@salesforce/apex/EventDetailService.upcomingEvents";
const columns = [
    {
      label: "View",
      fieldName: "detailsPage",
      type: "url",
      wrapText: "true",
      typeAttributes: {
        label: {
          fieldName: "Name__c"
        },
        target: "_self"
      }
    },
    {
      label: "Name",
      fieldName: "Name__c",
      wrapText: "true",
      cellAttributes: {
        iconName: "standard:event",
        iconPosition: "left"
      }
    },
    {
      label: "Name",
      fieldName: "EVNT_ORG",
      wrapText: "true",
      cellAttributes: {
        iconName: "standard:user",
        iconPosition: "left"
      }
    },
    {
      label: "Location",
      fieldName: "Location",
      wrapText: "true",
      type: "text",
      cellAttributes: {
        iconName: "utility:location",
        iconPosition: "left"
      }
    }
  ];
export default class EventList extends LightningElement {
    columnsList= columns;
    error;
    startdattime;
    @track recordToDisplay;
    @track result;
     
    connectedCallback() {
      this.upcomingEventsFromApex();
    }
    renderedCallback() {
      const style = document.createElement('style');
      style.innerText = `.slds-truncate {      
        overflow: visible;
     
      }`;
      this.template.querySelector('lightning-datatable').appendChild(style);
  }

    upcomingEventsFromApex() {
      upcomingEvents()
        .then((data) => {
          window.console.log(" event list ", data);
          data.forEach((record) => {
            record.detailsPage =
              "https://" + location.host + "/" + record.Id;
            record.EVNT_ORG = record.Event_Organizer__r.Name;
            if (record.Location__c) {
              record.Location = record.Location__r.Name;
            } else {
              record.Location = "This is Virtual Event";
            }
          });
  
          this.result = data;
          this.recordToDisplay = data;
          window.console.log('recordsToDisplay '+ JSON.stringify(this.recordsToDisplay));
          window.console.log('Result '+ JSON.stringify(this.result));
          
          this.error = undefined;
        })
        .catch((err) => {
          window.console.log(err);
          this.error = JSON.stringify(err);
          this.result = undefined;
        });
    }

    handleSearch(event){
      let keyword = event.detail.value;
      window.console.log("keyword in search"+keyword);
      let filteredEvents = this.result.filter((record, index, arrayobject) => {
        return record.Name__c.toLowerCase().includes(keyword.toLowerCase()); // Event - event
        // Tst - tst
      });
      window.console.log("filteredEvents in Search"+ JSON.stringify(filteredEvents));
      if (keyword && keyword.length >= 2) {
        this.recordToDisplay = filteredEvents;
        window.console.log("recordsToDisplay in search "+this.recordToDisplay);
      } else {
        this.recordToDisplay = this.result;
      }
    }
    handleStartTime(event){
      let valuestartdatetime= event.target.value;
      window.console.log("handleStarttime - valuestartdatetime "+valuestartdatetime);
      let filterRecordEvent = this.result.filter((record,index, arrayobject) => {
        return record.Start_DateTime__c >= valuestartdatetime;
      });
      window.console.log("handleStartTime - filterRecordEvent "+JSON.stringify(filterRecordEvent));
      this.recordToDisplay=filterRecordEvent;
      window.console.log("handleStartTime - recordToDisplay "+JSON.stringify(filterRecordEvent));
    }

    handleSearch(event){
      let valuesearch = event.target.value;
      window.console.log("handleSearch " + valuesearch);
      let filterSearch = this.result.filter((record,index,arrayobject) => {
        return record.Location__r.Name.toLowerCase().includes(valuesearch.toLowerCase());
      });
      if(valuesearch && valuesearch.length>=2){
        this.recordToDisplay = filterSearch;
      }else{
        this.recordToDisplay = this.result;
      }
    }


}