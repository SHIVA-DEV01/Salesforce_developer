import { LightningElement, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import JSZIP from '@salesforce/resourceUrl/jszip';
import apexMethodName from '@salesforce/apex/AttachmentExporter.getAttachments';
import SHEETMIN from '@salesforce/resourceUrl/SheetJs';
import PARSERJs from '@salesforce/resourceUrl/PapaparseMinJs';

export default class AttachmentDownload extends LightningElement {
    attachments; // Store attachment data here
    zipFileContent;
    jsZipInitialized = false;
    csvData = [];
    // jsZip;

    @wire(apexMethodName)
    wiredAttachments({ error, data }) {
        if (data) {
            console.log('OUTPUT : ', data);
            this.attachments = data;
        } else if (error) {
            console.error('Error fetching attachments:', error);
        }
    }

    async connectedCallback() {
        await loadScript(this, JSZIP)
            .then(() => {
                console.log('success load');
            })
        await loadScript(this, SHEETMIN)
            .then(() => {
                console.log('success load');
            })

             await loadScript(this, PARSERJs)
            .then(() => {
                console.log('success load');
            })
    }

    handleConvertToZip() {
        try {
            const zip = new JSZip();
            this.attachments.forEach(attachment => {
                if(attachment.parentId){
                    var img= zip.folder(attachment.parentId);
                    console.log('OUTPUT : ', attachment.body);
                    img.file(attachment.name, attachment.body, { base64: true });
                }
                else{
                    zip.file(attachment.name, attachment.body, { base64: true });
                }
            });
            zip.generateAsync({ type: "blob" }).then(function (content) {
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

        } catch (error) {
            console.error('Error loading JSZip:', error);
        }

    }
    generateCsv(){
        try{
            console.log('OUTPUT : generate', this.attachments);
        let attachmentSheet = JSON.parse(JSON.stringify(this.attachments));
        
        attachmentSheet.forEach(currentItem => {
            delete currentItem['body'];
        });
       this.csvData = attachmentSheet;
       this.convertToCSV(this.csvData);
        }catch (error) {
            console.error('Error loading JSZip:', error);
        }
        

    }
    convertToCSV(data) {
            const csv = Papa.unparse(data);
            
            const blob = new Blob([csv], { type: 'text/plain' });
           
            const url = URL.createObjectURL(blob);
        
            const link = document.createElement('a');
            link.href = url;
            link.download = 'Download_Report.csv';
        
            link.click();
        
            URL.revokeObjectURL(url);
            //this.template.querySelector('body').removeChild(link);
    

        }
}