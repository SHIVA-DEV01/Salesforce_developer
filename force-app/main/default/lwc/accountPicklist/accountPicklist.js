import { LightningElement, api} from 'lwc';
import getDynamicTableDataList from '@salesforce/apex/GetRecForOppConAcc.getRecord';
export default class AccountPicklist extends LightningElement {

    picklistkey;
    lstConDataTableColumns;
    lstOppDataTableColumns;
    oppTableTitle;
    conTableTitle;
    relatedConData = [];
    relatedOppData = [];

    options = [];
    lstConDataTableData;
    lstOppDataTableData;

    connectedCallback(){
        getDynamicTableDataList()
        .then(result => {
            console.log('Result >>>> ', result);
            let tempPickListObj = [];
            result.lstPickListValueData.forEach(element => {
                let tempArr = {
                    label : element.Name,
                    value : element.Id
                }

                tempPickListObj.push(tempArr);

            });
            let temp = {
                label: 'Delete',
                type: 'button-icon',
                typeAttributes:
                {
                    iconName: 'utility:delete',
                    name: 'delete',
                    iconClass: 'slds-icon-text-error'
                },    
                
            };

            result.lstConDataTableColumns.push(temp);

            this.lstConDataTableColumns = result.lstConDataTableColumns;
            this.lstConDataTableData = result.lstConDataTableData;
            this.lstOppDataTableColumns = result.lstOppDataTableColumns;
            this.lstOppDataTableData = result.lstOppDataTableData;
            this.oppTableTitle = result.oppTableTitle;
            this.conTableTitle = result.conTableTitle;


            this.options = tempPickListObj;

        })
        .catch(error => {
            console.log('Error >>>> ', error);
        });
    }

    pickListHandleChange(event){
        try {
            console.log(event.target.value);
            this.picklistkey = event.target.value;
            let tempRelatedConObj = [];
            let tempRelatedOppObj = [];
            this.lstConDataTableData.forEach(element => {
                if(element.AccountId == event.target.value){
                    
                    tempRelatedConObj.push(element);
                    console.log(element);
                }
            });
            this.relatedConData = tempRelatedConObj;
            this.lstOppDataTableData.forEach(element => {
                if(element.AccountId == event.target.value){
                    tempRelatedOppObj.push(element);
                    
                    console.log(element);
                }
            });
            
            this.relatedOppData = tempRelatedOppObj;
            console.log('this.relatedConData >>> ',this.relatedConData);
        } catch (error) {
            console.log('Error >>> ', error);
        }
        
    }

    contactSelected(event) {
        const contactId = event.detail;
        console.log('contactId ::::::::>>>>>>>> ', contactId);
    }
}