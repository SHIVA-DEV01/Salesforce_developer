// attachmentComponent.js
import { LightningElement, api, track } from 'lwc';
import getAttachments from '@salesforce/apex/AttachmentController.getAttachments';

export default class AttachmentComponent extends LightningElement {
    @api recordId;
    @track attachments = [];
    selectedAttachmentIds = [];

    connectedCallback() {
        this.loadAttachments();
    }

    loadAttachments() {
        getAttachments({})
            .then(result => {
                this.attachments = result;
            })
            .catch(error => {
                console.error('Error fetching attachments', error);
            });
    }

    handleCheckboxChange(event) {
        const attachmentId = event.target.value;
        if (event.target.checked) {
            this.selectedAttachmentIds.push(attachmentId);
        } else {
            this.selectedAttachmentIds = this.selectedAttachmentIds.filter(id => id !== attachmentId);
        }
    }

    downloadSelectedAttachments() {
        if (this.selectedAttachmentIds.length === 0) {
            // No attachments selected, show an alert or message to the user.
            return;
        }

        // Construct a URL for each selected attachment and open them in new tabs.
        this.selectedAttachmentIds.forEach(attachmentId => {
            window.open(`/servlet/servlet.FileDownload?file=${attachmentId}`, '_blank');
        });
    }

    // Getter function to format bytes
    get formattedAttachments() {
        return this.attachments.map(attachment => ({
            ...attachment,
            formattedSize: this.formatBytes(attachment.BodyLength)
        }));
    }

    formatBytes(bytes) {
        if (bytes === 0) return '0 Bytes';

        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        const i = parseInt(Math.floor(Math.log(bytes) / Math.log(k)));

        return Math.round((bytes / Math.pow(k, i))) + ' ' + sizes[i];
    }
}