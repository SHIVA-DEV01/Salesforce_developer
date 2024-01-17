import { LightningElement, wire, track, api } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountChart.getAccountOppCon';
export default class OpportunityBarChart extends LightningElement {
   @track chartConfiguration;
   @track chartConfigurations;
   @track chartConfigurations1;
   @api recordId;
   @wire(getOpportunities, { accId: '$recordId' })

   getOpportunities({ error, data }) {
      if (error) {
         this.error = error;
         console.log('error => ' + JSON.stringify(error));
         this.chartConfiguration = undefined;
         this.chartConfigurations = undefined;
         this.chartConfigurations1 = undefined;
      } else if (data) {
         let chartData = [];
         //    let chartLabels = [];
         data.forEach(opp => {
            chartData.push(opp);

         });

         this.chartConfiguration = {
            type: 'bar',
            data: {
               labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
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
                     data: [60, 10, 52],
                     backgroundColor: '#D6E9C6' // green
                  },
                  {
                     label: 'Moderate',
                     data: [10, 30, 54],
                     backgroundColor: '#FAEBCC' // yellow
                  },
                  {
                     label: 'High',
                     data: [11.4, 43, 10],
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
               scales: {
                  xAxes: [{ stacked: true }],
                  yAxes: [{ stacked: true }]
               }
            },

         };
         this.chartConfigurations = {
            type: 'pie',
            data: {
               labels: ['Red', 'blue', 'Yellow'],
               datasets: [{
                  label: 'My First Dataset',
                  data: [300, 50, 100],
                  backgroundColor: [
                     'rgb(255, 99, 132)',
                     'rgb(54, 162, 235)',
                     'rgb(255, 205, 86)'
                  ],
                  hoverOffset: 4
               }]

               // datasets: [
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



               //    {
               //       label: 'Low',
               //       data: [60, 10, 52],
               //       backgroundColor: '#D6E9C6' // green
               //    },
               //    {
               //       label: 'Moderate',
               //       data: [10, 30, 54],
               //       backgroundColor: '#FAEBCC' // yellow
               //    },
               //    {
               //       label: 'High',
               //       data: [11.4, 43, 10],
               //       backgroundColor: '#EBCCD1' // red
               //    },
               // ],
               // options: {
               //    scales: {
               //       xAxes: [{ stacked: true }],
               //       yAxes: [{ stacked: true }]
               //     }
               // },

               // },
               //    options: {
               //    scales: {
               //       xAxes: [{ stacked: true }],
               //       yAxes: [{ stacked: true }]
               //    }
            },

         };
         console.log('data => ', data);
         this.error = undefined;


      }
      this.chartConfigurations1 = {
         type: 'gauge',
         data: {
            labels: ['Success', 'Warning', 'Warning', 'Error'],
            datasets: [

               {
                  value: 0.5,
                  minValue: 0,
                  data: [1, 2, 3, 4],
                  backgroundColor: ['green', 'yellow', 'orange', 'red']
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
            needle: {
               radiusPercentage: 2,
               widthPercentage: 3.2,
               lengthPercentage: 80,
               color: 'rgba(0, 0, 0, 1)'
            },
            valueLabel: {
               display: true,
               formatter: (value) => {
                  return '$' + Math.round(value);
               },
               color: 'rgba(255, 255, 255, 1)',
               backgroundColor: 'rgba(0, 0, 0, 1)',
               borderRadius: 5,
               padding: {
                  top: 10,
                  bottom: 10
               }
            }
         }

      };
   }


}