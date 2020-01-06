import { Component, OnInit, Input,ElementRef, OnChanges, Pipe, PipeTransform } from '@angular/core';
import * as CanvasJS from './canvasjs.min';
import {Globals} from '../global';


@Component({
  selector: 'app-threetabs',
  templateUrl: './threetabs.component.html',
  styleUrls: ['./threetabs.component.css']
})

export class ThreetabsComponent implements OnChanges {

@Input() rslt;

public current:boolean = true;
public hourly:boolean = false;
public weekly:boolean = false;
public city:string = "";
public star:boolean = false;
public noStar:boolean = false;


 
  constructor(private _elementRef : ElementRef,public globals:Globals) { }
  
  public barChartOptions;
  public barChartLabels;
  public barChartType ;
  public barChartLegend;
  public barChartData ;
  public barChartPlugins;
  public localData;

  ngOnInit(){
  }

 
  ngOnChanges() {
    var locKey = this.globals.city.toUpperCase()+":"+this.globals.state.toUpperCase();
    if(this.globals.myStorage.getItem(locKey)){
      this.star = true;
      this.noStar = false;
    }
    else{
      this.star = false;
      this.noStar = true;
    }
    this.city = this.globals.city;
  }

  CurrentClicked(){
    this.hourly = false;
    this.current=true;
    this.weekly = false;
  }
  HourlyClicked(){
    this.hourly = true;
    this.current=false;
    this.weekly = false;
    var max:number;
    var min:number;
    max = Math.round(this.rslt.hourly.data[0].temperature);
    min = Math.round(this.rslt.hourly.data[0].temperature);
    for (let i = 0; i < 24; i++) {
      var temp:number = Math.round(this.rslt.hourly.data[i].temperature);
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
     if(step == 0){
        step = 1;
     }

    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: 'Fahrenheit'
         },
         ticks: {
          suggestedMin: min-step,
          suggestedMax: max+step
      }


      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
   
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    
    for (let i = 0; i < 24; i++) {
      
      this.localData.push(Math.round(this.rslt.hourly.data[i].temperature));
     }

    
    this.barChartType = 'bar';
    this.barChartLegend = true;
    
    this.barChartData = [
      {data: this.localData, label: 'temperature', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
    ];
  }

  barChartTemperature(){
    var max:number;
    var min:number;
    max = Math.round(this.rslt.hourly.data[0].temperature);
    min = Math.round(this.rslt.hourly.data[0].temperature);
    for (let i = 0; i < 24; i++) {
      var temp:number = Math.round(this.rslt.hourly.data[i].temperature);
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
     if(step == 0){
      step = 1;
   }
    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: 'Fahrenheit'
         },
         ticks: {
          suggestedMin: min-step,
          suggestedMax: max+step
      }
      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    for (let i = 0; i < 24; i++) {
      this.localData.push(Math.round(this.rslt.hourly.data[i].temperature));
     }
    this.barChartType = 'bar';
    this.barChartLegend = true;
    this.barChartData = [
      {data: this.localData, label: 'temperature', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
      
      
    ];
  }


  barChartPressure(){
    var max:number;
    var min:number;
    max = this.rslt.hourly.data[0].pressure;
    min = this.rslt.hourly.data[0].pressure;
    for (let i = 0; i < 24; i++) {
      var temp:number = this.rslt.hourly.data[i].pressure;
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
     if(step == 0){
      step = 1;
   }
    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: 'Millibars'
         },
         ticks: {
          suggestedMin: min-step,
          suggestedMax: max+step
      }
      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    for (let i = 0; i < 24; i++) {
      this.localData.push(this.rslt.hourly.data[i].pressure.toFixed(2));
     }
     
    this.barChartType = 'bar';
    this.barChartLegend = true;
    this.barChartData = [
      {data: this.localData, label: 'pressure', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
      
      
    ];

  }


  barChartHumidity(){
    var max:number;
    var min:number;
    max = this.rslt.hourly.data[0].humidity;
    min = this.rslt.hourly.data[0].humidity;
    for (let i = 0; i < 24; i++) {
      var temp:number = this.rslt.hourly.data[i].humidity;
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
    
     if(step == 0){
      step = 1;
   }

    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: '% Humidity'
         },
         ticks: {
          suggestedMin: (min-step)*100,
          suggestedMax: (max+step)*100
      }
      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    for (let i = 0; i < 24; i++) {
      this.localData.push((this.rslt.hourly.data[i].humidity*100).toFixed(2));
     }
    this.barChartType = 'bar';
    this.barChartLegend = true;
    this.barChartData = [
      {data: this.localData, label: 'humidity', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
    ];

  }



  barChartOzone(){
    var max:number;
    var min:number;
    max = this.rslt.hourly.data[0].ozone;
    min = this.rslt.hourly.data[0].ozone;
    for (let i = 0; i < 24; i++) {
      var temp:number = this.rslt.hourly.data[i].ozone;
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
     if(step == 0){
      step = 1;
   }

    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: 'Dobson Units'
         },
         ticks: {
          suggestedMin: min-step,
          suggestedMax: max+step
      }
      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    for (let i = 0; i < 24; i++) {
      this.localData.push(this.rslt.hourly.data[i].ozone.toFixed(2));
     }
    this.barChartType = 'bar';
    this.barChartLegend = true;
    this.barChartData = [
      {data: this.localData, label: 'ozone', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
    ];

  }

  barChartVisibility(){
    var max:number;
    var min:number;
    max = this.rslt.hourly.data[0].visibility;
    min = this.rslt.hourly.data[0].visibility;
    for (let i = 0; i < 24; i++) {
      var temp:number = this.rslt.hourly.data[i].visibility;
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
     if(step == 0){
      step = 1;
   }

    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: 'Miles (Maximum 10)'
         },
         ticks: {
          suggestedMin: min-step,
          suggestedMax: max+step
      }
      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    for (let i = 0; i < 24; i++) {
      this.localData.push(this.rslt.hourly.data[i].visibility.toFixed(2));
     }
    this.barChartType = 'bar';
    this.barChartLegend = true;
    this.barChartData = [
      {data: this.localData, label: 'visibility', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
      
      
    ];
  }


  barChartWindSpeed(){
    var max:number;
    var min:number;
    max = this.rslt.hourly.data[0].windSpeed;
    min = this.rslt.hourly.data[0].windSpeed;
    for (let i = 0; i < 24; i++) {
      var temp:number = this.rslt.hourly.data[i].windSpeed;
      if(temp > max){
        max = temp;
      }
      if(min > temp){
        min = temp;
      }
     
      
     }
     var step = (max-min)/10;
     if(step == 0){
      step = 1;
   }

    this.barChartOptions = {
      scales: { 
      yAxes: [{
         scaleLabel: {
            display: true,
            labelString: 'Miles per hour'
         },
         ticks: {
          suggestedMin: min-step,
          suggestedMax: max+step
      }
      }],
      xAxes: [{
        scaleLabel: {
           display: true,
           labelString: 'Time difference from current hour'
        }
     }]
   },
      scaleShowVerticalLines: false,
      responsive: true,
      legend:{
        onClick: (e) =>e.stopPropagation()
      }
    };
    this.barChartLabels = [];
    for (let i = 0; i < 24; i++) {
     this.barChartLabels.push(i);
    }
    this.localData = [];
    for (let i = 0; i < 24; i++) {
      this.localData.push(this.rslt.hourly.data[i].windSpeed.toFixed(2));
     }
    this.barChartType = 'bar';
    this.barChartLegend = true;
    this.barChartData = [
      {data: this.localData, label: 'windSpeed', backgroundColor:'rgb(165,209,238)',hoverBackgroundColor:'rgb(109,145,169)'}
    ];

  }

  WeeklyClicked(){
    this.hourly = false;
    this.current=false;
    this.weekly = true;
  }
  

  favoritesClicked(){
    this.star = true;
    this.noStar = false;
    var locKey = this.globals.city.toUpperCase()+":"+this.globals.state.toUpperCase();
    var favCity = this.globals.city;
    var favState = this.globals.state;
    var favLat = this.globals.lat;
    var favLong = this.globals.long;
    if(this.globals.myStorage.getItem(locKey)){
      this.star = false;
      this.noStar = true;
      this.globals.myStorage.removeItem(favCity.toUpperCase()+":"+favState.toUpperCase());
      
    }
    else{
      this.star = true;
      this.noStar = false;
      
      this.globals.myStorage.setItem(favCity.toUpperCase()+":"+favState.toUpperCase(),
      favCity+":"+favState+":"+favLat+":"+favLong);

      this.globals.myStorage.setItem(favState.toUpperCase(),this.globals.sealUrl);
      
    }

    
    
  }

  optionSelected(value){
    if(value == 'Temperature'){
      this.barChartTemperature();
    }
    else if(value == 'Pressure'){
      this.barChartPressure();
    }
    else if(value == 'Humidity'){
      this.barChartHumidity();
    }
    else if(value == 'Ozone'){
      this.barChartOzone();
    }
    else if(value == 'Visibility'){
      this.barChartVisibility();
    }
    else if(value == 'WindSpeed'){
      this.barChartWindSpeed();
    }
  }

}
