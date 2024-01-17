import { LightningElement } from 'lwc';

export default class RingCentralMainComp extends LightningElement {
    allLogsBool = true;
    callLogsBool = false;
    faxLogsBool = false;

    allLogsHandler(){
        this.allLogsBool = true;
        this.callLogsBool = false;
        this.faxLogsBool = false;
    }
    callLogsHandler(){
        this.allLogsBool = false;
        this.callLogsBool = true;
        this.faxLogsBool = false;
    }
    faxLogsHandler(){
        this.allLogsBool = false;
        this.callLogsBool = false;
        this.faxLogsBool = true;
    }
}