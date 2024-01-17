import { LightningElement, track } from 'lwc';

export default class CalculatorLwc extends LightningElement {

    // @track result;
    // num1;
    // num2;

    // onInputChangeHandler(event) {
    //     const name = event.target.name;
    //     console.log(name);
    //     if (name === 'Number1') {
    //         this.num1 = event.target.value;
    //         console.log(this.num1);
    //     } else if (name === 'Number2') {
    //         this.num2 = event.target.value;
    //     }
    // }

    // onButtonCLick(event) {
    //     var operation = event.target.label;
    //     if (!isNaN(this.num1) && !isNaN(this.num2)) {
    //         const numb1 = parseInt(this.num1);
    //         const numb2 = parseInt(this.num2);
    //         console.log(numb1);
    //         console.log(numb2);
    //         var tempResult = 0;
    //         if (operation === 'Add') {
    //             tempResult = `${numb1 + numb2}`;
    //         } else if (operation === 'Subtract') {
    //             tempResult = `${numb1 - numb2}`;
    //         } else if (operation === 'Multiply') {
    //             tempResult = `${numb1 * numb2}`;
    //         } else if (operation === 'Divide') {
    //             tempResult = `${numb1 / numb2}`;
    //         }
    //         if (tempResult !== null && tempResult !== '' && tempResult !== undefined && !isNaN(tempResult)) {
    //             this.result = tempResult;
    //         }
    //     }
    // }





@track output;
var1;
var2;

input1(event){
    this.var1=parseInt(event.target.value,10);
   }

input2(event){
    this.var2=parseInt(event.target.value,10);
   }

   Adding(){
    this.output=(this.var1)+this.var2;
   }

   Subtract(){
    this.output=this.var1-this.var2;
   }

   Multiply(){
    this.output=this.var1*this.var2;
   }

   Divide(){
    this.output=this.var1/this.var2;
   }




}