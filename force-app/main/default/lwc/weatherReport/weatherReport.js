import { LightningElement } from 'lwc';
import getWeatherResponse from '@salesforce/apex/IntegratedWithWeatherAPI.getWeatherReport'
// import { loadStyle } from 'lightning/platformResourceLoader';
// import SLDS from '@salesforce/resourceUrl/BBDEC__SLDS221';
export default class WeatherReport extends LightningElement {


    user_Location = {};
    currentTime;
    icon;
    currentlocationObj = {};
    currentdataObj = {};
    currentAirQuality = {};
    weatherForecastData = [];
    airForecastData = [];


  get temperatureStyle() {
    let temperature = parseInt(this.currentdataObj.temp_c);
    let color = '';
    if (temperature >= 30) {
      color = 'red';
    } else if (temperature >= 20) {
      color = 'orange';
    } else {
      color = 'blue';
    }
    return `color: ${color};`;
  }

    connectedCallback() {
        // Promise.all([loadStyle(this, SLDS + '/salesforce-lightning-design-system.css')]);
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(position => {
                this.user_Location = position.coords.latitude + ',' + position.coords.longitude;

                this.getDataFromAPI();
                console.log('this.user_Location', this.user_Location.trim());
            });

        }

    }

    getDataFromAPI() {
        getWeatherResponse({ userLocation: this.user_Location.trim() })
            .then(result => {
                let parseData = JSON.parse(result);
                console.log('ParseData >>>>> ', parseData);
                this.currentTime = this.convertDateIntoAMPM();
                this.currentlocationObj = parseData.location;
                this.currentdataObj = parseData.current;

                console.log('This.currentlocationObj Object >>> ', this.currentlocationObj);
                console.log('This.currentdataObj Object >>> ', this.currentdataObj);
                parseData.forecast.forecastday.forEach(element => {
                  let tempArray = {
                    'date' : element.date,
                    'icon' : element.day.condition.icon,
                    'min_temp' : element.day.mintemp_c,
                    'max_temp' : element.day.maxtemp_c,
                    'weather' : element.day.condition.text
                  };
                  this.weatherForecastData.push(tempArray);

                  let tempArrAir ={
                    'date' : element.date,
                    'uv' : element.day.uv,
                    'wind' : element.day.maxwind_kph,
                    'vis' : element.day.avgvis_km
                  };
                  this.airForecastData.push(tempArrAir);
                });

                console.log('this.weatherForecastData >>>>>> ',this.weatherForecastData);
                console.log('this.airForecastData >>>>>> ',this.airForecastData);

                this.icon = parseData.current.condition.icon;
                this.temp = parseData.current.temp_c;
                this.text = parseData.current.condition.text;
                this.location = parseData.location.name;
                this.country = parseData.location.country;

            })
            .catch(error => {
                console.log(' Weather error  !!!!!!! ', error);
            })
    }

    convertDateIntoAMPM() {
        const date = new Date();
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'pm' : 'am';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0' + minutes : minutes;
        let convertedDate = hours + ':' + minutes + ' ' + ampm;
        return convertedDate;
    }
}