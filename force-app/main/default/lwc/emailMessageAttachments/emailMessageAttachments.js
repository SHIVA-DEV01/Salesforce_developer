import { LightningElement, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import JSZIP from '@salesforce/resourceUrl/jszip';
import PARSERJs from '@salesforce/resourceUrl/PapaparseMinJs';
import apexMethodName from '@salesforce/apex/AttachmentExporter.getAttachments';
import getObjectNames from '@salesforce/apex/AttachmentExporter.getObjectNames';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EmailMessageAttachments extends LightningElement {
    attachments; // Store attachment data here
    zipFileContent;
    jsZipInitialized = false;
    buttonDis = true;
    objectButtonDis = true;
    objectNames = [];
    objectmap = [];
    selectedobjname;
    enableExport = false;
    filter;
    customFilter = false;
    loaded = false;

    get filterCss(){
        if(this.customFilter){
            return 'slds-col slds-size--1-of-1 slds-small-size--1-of-1 slds-medium-size--1-of-3';
        }else{
            return 'slds-col slds-size--1-of-1 slds-small-size--1-of-1 slds-medium-size--1-of-1';
        }
    }

    filterOptions = [
        {label: 'All', value: 'ALL'},
        {label: 'Today', value: 'TODAY'},
        {label: 'Yesterday', value: 'YESTERDAY'},
        {label: 'Custom Date', value: 'CUSTOM_DATE'}
    ];

    options =
        [
            { label: "All the business actvities", value: "All BA" },
            { label: "List of all the business actvities", value: "ListRoot" }
        ];
    startDate = '2019-07-04';
    endDate = '2023-07-04';
    @wire(getObjectNames)
    wiredObjectNames({ error, data }) {
        if (data) {
            this.objectNames = data;
            data.forEach(currentItem => {
                let objectmaps = new Map();
                objectmaps = { label: currentItem, value: currentItem };
                this.objectmap.push(objectmaps);
                this.options = [...this.options, objectmaps];
            });
        } else if (error) {
           let message  = 'Something went wrong. Please refresh the page or contact the admin.';
                    let title = 'Object Validation';
                    let variant =  'error';
                    this.showToast(title,message,variant);
        }
    }

    async connectedCallback() {
        try {
            await loadScript(this, JSZIP)
                .then(() => {
                    console.log('success load');
                })
            await loadScript(this, PARSERJs)
                .then(() => {
                    console.log('success load');
                })
                .catch(error => {
                    console.error('Error fetching attachments:', error);
                })
        } catch (error) {
            console.error('Error loading JSZip:', error);
        }

    }

    async handleConvertToZip() {
        try {
            const zip = new JSZip();
            await this.attachments.forEach(attachment => {
                if (attachment.parentId) {
                    var img = zip.folder(attachment.parentId);
                    if (!attachment.name.includes('.')) {
                        img.file(attachment.name + '.' + attachment.extension, attachment.body, { base64: true });
                    }
                    else {
                        img.file(attachment.name, attachment.body, { base64: true });
                    }
                }
                else {
                    if (!attachment.name.includes('.')) {
                        zip.file(attachment.name + '.' + attachment.extension, attachment.body, { base64: true });
                    }
                    else {
                        zip.file(attachment.name, attachment.body, { base64: true });
                    }
                }
            });
            await zip.generateAsync({ type: "blob" }).then(function (content) {
                const blobUrl = URL.createObjectURL(content);
                const a = document.createElement('a');
                a.style.display = 'none';
                a.href = blobUrl;
                a.download = 'Attachment Records.zip';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                URL.revokeObjectURL(blobUrl);
            });
      let message  = 'Download completed';
                    let title = 'Status';
                    let variant =  'success';
                    this.showToast(title,message,variant);
        } catch (error) {
            console.error('Error loading JSZip:', error);
        }

    }
    generateCsv() {
        try {
            if(this.attachments){
            let attachmentSheet = JSON.parse(JSON.stringify(this.attachments));

            attachmentSheet.forEach(currentItem => {
                delete currentItem['body'];
                delete currentItem['isDataExceeded'];
            });
            this.csvData = attachmentSheet;
            this.convertToCSV(this.csvData);
            }
        } catch (error) {
            console.error('Error loading JSZip:', error);
        }
    }
    async convertToCSV(data) {
        const csv = Papa.unparse(data);

        const blob = new Blob([csv], { type: 'text/plain' });

        const url = URL.createObjectURL(blob);

        const link = document.createElement('a');
        link.href = url;
        link.download = 'Download_Report.csv';

        link.click();

       await URL.revokeObjectURL(url);
             let message  = 'Download completed';
                    let title = 'Status';
                    let variant =  'success';
                    this.showToast(title,message,variant);
        ;
    }
    getattachmentData(obj, startdate, endate) {
        apexMethodName({ objectname: obj, startdate: startdate, enddate: endate, filter:  this.filter})
            .then(data => {
                if(data.length > 1){
                if(data[0].isDataExceeded){
                    let message  = 'The attachment data has exceeded the salesforce limit. Please update the date range filter for shorter time period.';
                    let title = 'Attachment Limit Exceeded';
                    let variant =  'error';
                    this.showToast(title,message,variant);
                    this.buttonDis = true;
                    
                }else{
                    this.attachments = data;
                    this.buttonDis = false;
                }
                }else{
                    let message  = 'No data found';
                    let title = 'Data validation';
                    let variant =  'info';
                    this.showToast(title,message,variant);
                     this.buttonDis = true;
                }
                this.loaded = !this.loaded;
                 
                
            });
    }
    selectobject(event) {
        let val = event.target.value;
        let name = event.target.name;
        if(name === 'From'){
            this.startDate = val;
        }else if(name === 'End'){
            this.endDate = val;
        }else if(name === 'Select_Filter'){
            this.filter = val;
            if(val === 'CUSTOM_DATE'){
                this.customFilter = true;
            }else{
                this.customFilter = false;
            }
        }else if(name === 'Select_Object'){
            this.selectedobjname = val;
        }

        if(this.startDate != null && this.endDate != null && this.filter != undefined && this.selectedobjname != undefined){
            this.buttonDis = false;
        }
        else {
            this.buttonDis = true;
        }

    }
    confirm(event) {
        this.getattachmentData(this.selectedobjname, this.startDate, this.endDate);
        this.objectButtonDis = false;
    }
    gotohome(event) {
        this.objectButtonDis = true;
        this.loaded = !this.loaded;
    }
    showToast(title,message,variant) {
    const event = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
    }
    
}