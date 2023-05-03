import { LightningElement } from 'lwc';
export default class DisablePastDateTime extends LightningElement {
		
		get minDate() {
        const today = new Date().addDay(14).toISOString().slice(0, 10);
        return today;
    }
}