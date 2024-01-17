import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import PARSERJs from '@salesforce/resourceUrl/PapaparseMinJs';
import { NavigationMixin } from 'lightning/navigation';
import getOpportunityAttachments from '@salesforce/apex/OpportunityFileAttachmentHandler.getAllPorfileCitAttachmentReltdToOppt';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sheetMin from '@salesforce/resourceUrl/SheetJs';
 
export default class OpportunityFileAttachmentCmp extends NavigationMixin(LightningElement) {
    
    downLoadUrl='';
    fileData=[];
    csvData=[];
    baseUrl='';
    opportunityData=[];
    isLoading=false;
    totalFiles=0;
    totalOppt=0;
    totalCITOppt=0;
    citLocations={};
    citFields=['Servicing Branch Number','Servicing Branch Name','Service Start Date','Location Number','Location Name','Street Address','City','State','Zip','Included Liablity','Service Days','Zone','Frequency','Hours of Operation START','Hours of Operation END','Premise Time Allowed','Billing Rate',"Customer's Bank",'Banks Cash Vault Address','Is client a FED Direct Coin Wrap Client?'];
    connectedCallback(){
        this.isLoading=true;
        loadScript(this,PARSERJs);
        getOpportunityAttachments()
        .then(result=>{
            console.log('OUTPUT : ',result);
            // if(result.opptVsContVersion && result.mapOfOppt && result.downloadUrl && result.baseUrl){
                this.fileData=result.opptVsContVersion;
                this.downLoadUrl=result.downloadUrl;
                this.baseUrl=result.baseUrl+'/sfc/servlet.shepherd/version/download/';
                this.opportunityData=result.mapOfOppt;
                for(let data in this.fileData)
                {
                    if(this.fileData[data].length>0 && this.opportunityData[data].Id){
                        for(let fdata of this.fileData[data]){
                            let row={
                                OpportunityId:data,
                                OpportunityName:this.opportunityData[data].Name,
                                Stage:this.opportunityData[data].StageName,
                                FileName:fdata.Title,
                                DownLoadLink:this.baseUrl+fdata.Id
                            }
                            this.csvData.push(row);
                        }
                    }
               }
               this.totalOppt=Object.keys(this.fileData).length;
               this.totalFiles=this.csvData.length;
               this.totalCITOppt=Object.keys(this.opportunityData).length;
            //    console.log('Total Open Cit Opportunities>>',this.totalOppt);
            //    console.log('Total Files >>',this.totalFiles);
            //    console.log('Total totalCITOppt >>',this.totalCITOppt);
               

            // }
            // else if(result==null){
            //     const event = new ShowToastEvent({
            //         title: 'Error',
            //         message: 'There are no files related to Quotes',
            //         variant: 'Error',
            //         mode:'dismissable'
            //     });
            //     this.dispatchEvent(event);
            
                   
            // }
            // else{
            //     const event = new ShowToastEvent({
            //         title: 'Error',
            //         message: 'Unknown Error',
            //         variant: 'Error',
            //         mode:'dismissable'
            //     });
            //     this.dispatchEvent(event);
            

            // }
            this.isLoading=false;
            
        })
        .catch(error=>{
            console.log('error',error);
            const event = new ShowToastEvent({
                title: 'Error',
                message: error,
                variant: 'Error',
                mode:'dismissable'
            });
            this.dispatchEvent(event);
            this.isLoading=false;
        })

    }
    renderedCallback() {
        loadScript(this,sheetMin);
        console.log('loading js ');

    }
    generateCsv(){
       this.csvData=JSON.parse(JSON.stringify(this.csvData));
      
       this.convertToCSV(this.csvData);

    }
    downLoadZipAttachment(){
        window.open(this.downLoadUrl,'_blank');
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
        handleFileUpload(event) {
            const fileReader = new FileReader();
            const file = event.target.files[0];
            fileReader.readAsArrayBuffer(file);
    
            fileReader.onloadend = () => {
                const arrayBuffer = fileReader.result;
                const data = new Uint8Array(arrayBuffer);
                const workbook = XLSX.read(data, {type: 'array'});
                console.log('workbook.Sheets>>'+workbook.Sheets);
                console.log('workbook.SheetNames>>'+workbook.SheetNames);
                const worksheet = workbook.Sheets[workbook.SheetNames[1]];
                const parsedData = XLSX.utils.sheet_to_json(worksheet, {header: 1});
                console.log('Printing DATA>>>>>>>>>>');
    
                let columnData = {};
                let range = XLSX.utils.decode_range(worksheet['!ref']);
               
    
                for (let C = range.s.c; C <= range.e.c; ++C) {
                    let col = XLSX.utils.encode_col(C);
                    let headerCell = worksheet[col + '2'];
                    let columnHeader = headerCell ? headerCell.v : 'BlankHeader';
                    columnData[columnHeader] = [];
                    for (let R = range.s.r + 2; R <= range.e.r; ++R) {
                        let cell = worksheet[col + R];

                       // console.log('cell',cell);
                        let cellValue = cell ? cell.w : undefined;
                        columnData[columnHeader].push(cellValue);
                    }
                }
          //console.log('Column-wise data: ', Object.keys(columnData));


                for(let col of Object.keys(columnData)){
                    columnData[col]=columnData[col].filter(function( element ) {
                                return element !== undefined && element!==' ' && element!=='see insert comment' && element!=='#N/A';
                             });

                    if(columnData[col].length==0){
                    delete columnData[col];
                    }
                             
                }
                //console.log('Column Data>>>'+columnData);

                let dataArray={};

                console.log('Column keys:::',Object.keys(columnData));

            
                for(let col of Object.keys(columnData)){
                   // console.log('Column:',columnData[col]);


                    //console.log('Columns Data>>>',columnData[col]);
                   // console.log('Columns>>',columnData[col][0]);

                    if(this.citFields.indexOf(col.trim())!=-1){
                        dataArray[col.trim()]=columnData[col].slice(1,columnData[col].length);
                    }


                }

                console.log('Data Array>>>',dataArray);

               


    
                // Do something with the parsed data
            }
        }
    
        

}