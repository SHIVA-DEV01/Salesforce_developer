import { LightningElement, track, wire } from 'lwc';

import getContact from '@salesforce/apex/AccountTableLwc.getContact';

const columns=[
{label: 'Contact Name', fieldName: 'Name'},
{label: 'Contact Phone', fieldName: 'Phone', type:'Phone',cellAttributes:{ iconName: { fieldName: 'displayIconName1'}}},
{label: 'Contact Email', fieldName: 'Email',type:'email'},
{ label: 'AccountName', fieldName: 'AccountUrl', type: 'url',typeAttributes: {label: { fieldName: 'AccountName' }, target: '_blank'}},
{label: 'Last Modified Date', fieldName: 'LastModifiedDate',cellAttributes:{ iconName: { fieldName: 'displayIconName2'}}},
{label: 'Profile Picture', fieldName: 'PhotoUrl', type: 'image'},
{
    label:'IsActive',
    cellAttributes:{

        iconName: {
            fieldName: 'displayIconName'
            
        }
    }
    
},
// {label: 'files', fieldName: 'files', type: 'fileupload',typeAttributes: {
//     formats: ".pdf,.png",
//     recordId: { fieldName: 'Id' }, //pass Id of current record
// }}
];

export default class detailOfAccount extends LightningElement {
 ampm = true;
    @track error;
    @track columns = columns;
    @track conList;
    @wire (getContact) 
    accList({error, data})
    {
        // let count = {
        //     Name: null,
        //     Phone: null,
        //     Email: null,
        //     AccountName: null,
        //     LastModifiedDate: null,

        //   };
        const a=[];
        if(data)
        {
            let conParsedData=JSON.parse(JSON.stringify(data));
            console.log(conParsedData);
            conParsedData.forEach(con => {


                const options = {
                    year: 'numeric', month: 'numeric', day: 'numeric',
                    hour: 'numeric', minute: 'numeric', second: 'numeric',
                    hour12: false
                  };


                let count = {
                    Name: null,
                    Phone: null,
                    Email: null,
                    AccountName: null,
                    LastModifiedDate: null,
                    AccountUrl: null,
                    displayIconName: null,
                    displayIconName1: null,
                    displayIconName2: null,
        
                  };

                console.log(con);

                

                if(con.Phone!=null){
                    count.displayIconName1 = 'standard:voice_call';
                }

                
                  
                count.displayIconName2 = 'utility:clock';
                  
                  

                  if(con.Account){


                
                count.Name = con.Name;

                
                if (con.Phone) {
                    var cleaned = ('' + con.Phone).replace(/\D/g, '');
                    var match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
                    if (match) {
                        count.Phone = '+1  (' + match[1] + ') ' + match[2] + '-' + match[3];
                    }
                }
                    
                    count.Email = con.Email;
                    count.AccountName = con.Account.Name;
                    
                    let dt = new Date( con.LastModifiedDate );
                    count.LastModifiedDate = new Intl.DateTimeFormat( 'en-US', options ).format( dt );
                    console.log(con.Account.BBDEC__Active__c);

                    count.AccountUrl='/lightning/r/Account/'+con.AccountId+'/view';

                    
                    if ( con.Account.BBDEC__Active__c=='Yes')  {
                        console.log('True');
                        count.displayIconName='standard:task2';
                        
                    }   else if( con.Account.BBDEC__Active__c=='No'){
                        console.log('false');
                        count.displayIconName='standard:first_non_empty';
                        
    
                    } else{
                        count.displayIconName='standard:first_non_empty';
                    }

                    console.log(count);
                    a.push(count);
                    
                     

                    
                    
                    
                    


                  }
                  else{
                    count.Name = con.Name;
                    count.Phone = con.Phone;
                    count.Email = con.Email;
                    count.AccountName = '';
                    let dt = new Date( con.LastModifiedDate );
                    count.LastModifiedDate = new Intl.DateTimeFormat( 'en-US', options ).format( dt );
                    
                    
                

                
                    console.log(count);
                    a.push(count);
                  }
                
                
                
            });
            console.log('msg>>>',a);
            this.conList=a;
            console.log(this.conList);

        }

        else if(error)
        {
            this.error = error;
            console.log(error);
        }

    }

   

}