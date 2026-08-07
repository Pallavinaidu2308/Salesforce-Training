
import { LightningElement } from 'lwc';

export default class PlacementHome extends LightningElement {

    studentName = 'Bollam Pallavi';
    rollNumber = '23PA1A5705';
    department = 'CSBS';

    message = '';
    status = 'Not Applied';

    showMessage() {
        this.message = 'Welcome to Salesforce Development.';
    }

    applyJob() {
        this.status = 'Applied';
    }
}
