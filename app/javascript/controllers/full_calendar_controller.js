import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    let newEventPath = this.data.get('new-event-path');

    this.element.innerHTML = '';
    let calendar = new Calendar(this.element, {
      plugins: [ dayGridPlugin ],
      customButtons: {
        addNewEvent: {
          text: '+ New Event',
          click: function() {
            window.location.assign(newEventPath);
          }
        }
      },
      header: {
        left: 'addNewEvent',
        center: 'title',
        right: 'today prev,next'
      }, 
      eventSources: [
        {
          url: this.data.get('events-endpoint'), // use the `url` property
          startParam: 'start',
          endParam: 'end'
        }
      ]
    
    
    });
    calendar.render();
  }
}
