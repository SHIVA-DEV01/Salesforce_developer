import { LightningElement,wire, track, api } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountChart.getAccountOppCon';
export default class StackedChart extends LightningElement {
    
    @track chartConfiguration;
    @api recordId;
    @wire(getOpportunities, { accId: '$recordId' })
    
    getOpportunities({ error, data }) {
       if (error) {
          this.error = error;
          console.log('error => ' + JSON.stringify(error));
          this.chartConfiguration = undefined;
       } else if (data) {
          let chartData = [];
          //    let chartLabels = [];
          data.forEach(opp => {
             chartData.push(opp);
 
          });
 
          this.chartConfiguration = {
             type: 'bar',
             data: {
                labels: ['January','February','March','April','May','June','July','August','September','October','November','December'],
                datasets: [
                   // {
                   //    label: 'Number contact and opportunity in this account',
                   //    barPercentage: 0.5,
                   //    barThickness: 3,
                   //    maxBarThickness: 8,
                   //    minBarLength: 2,
                   //    backgroundColor: "blue",
                   //    data: chartData,
                      
                   //     scales: {
                         // 				xAxes: [{
                         // 						type: 'bar',
                         // 						ticks: {
                   //                      scaleOverride:true,
                   //                      scaleSteps:9,
                   //                      scaleStartValue:0,
                   //                      scaleStepWidth:100,
                         // 						}
                         // 				}]
                         // 		},
                     
                   // },
 
                   {
                      label: 'Low',
                      data: [60,10,52],
                      backgroundColor: '#D6E9C6' // green
                    },
                    {
                      label: 'Moderate',
                      data: [10,30,54],
                      backgroundColor: '#FAEBCC' // yellow
                    },
                    {
                      label: 'High',
                      data: [11.4,43,10],
                      backgroundColor: '#EBCCD1' // red
                    },
                ],
                // options: {
                //    scales: {
                //       xAxes: [{ stacked: true }],
                //       yAxes: [{ stacked: true }]
                //     }
                // },
                
             },
             options: {
                responsive: true,
                scales: {
                   xAxes: [{ stacked: true }],
                   yAxes: [{ stacked: true }]
                 }
             },
             
          };
          console.log('data => ', data);
          this.error = undefined;
       }
    }
}