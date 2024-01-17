import {LightningElement, wire, track} from 'lwc';
import getAccount from '@salesforce/apex/AccountChart.getAccountOppCon';
export default class OpportunityBarChart extends LightningElement {
 @track chartConfiguration;

 @wire(getAccount, {})
 getOpportunities({error, data}) {
  if (error) {
   this.error = error;
   console.log('error => ' + JSON.stringify(error));
   this.chartConfiguration = undefined;
  } else if (data) {
   let chartData = [];
   let chartLabels = [];
   data.forEach(opp => {
    chartData.push(opp.Amount);
    chartLabels.push(opp.Name);
   });

   this.chartConfiguration = {
    type: 'bar',
    data: {
     labels: chartLabels,
     datasets: [
        {
            label: 'Low',
            data: [67.8],
            backgroundColor: '#D6E9C6' // green
          },
          {
            label: 'Moderate',
            data: [20.7],
            backgroundColor: '#FAEBCC' // yellow
          },
          {
            label: 'High',
            data: [11.4],
            backgroundColor: '#EBCCD1' // red
          },
     ],
     options: {
        scales: {
            xAxes: [{ stacked: true }],
            yAxes: [{ stacked: true }]
          }
    },
    },
    
   };
   console.log('data => ', data);
   this.error = undefined;
  }
 }
}