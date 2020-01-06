import { Component, OnInit, Input, Pipe } from '@angular/core';
import * as CanvasJS from '../canvasjs.min';
import { NgbModal, NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import {ConfigService} from '../../../app/config.service';
import {Globals} from '../../global';


@Component({
  selector: 'ngbd-modal-content',
  template: `
  
    <div class="modal-header" style="background-color: rgb(109,145,169);">
      <h4 class="modal-title">{{date}}</h4>
      <button type="button" class="close" aria-label="Close" (click)="activeModal.dismiss('Cross click')">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="container rounded" style="background-color: rgb(165,209,238);">
    <div class="modal-body">
      <h2 class="pl-3" style='margin-bottom: -0.5rem; font-weight:150'>{{city}}</h2>
      <div class="row">
      <div class="col my-auto" >
      
          <div class="row pl-3">
          <h2 class="col my-auto" style='font-weight:300'>{{temp}}<img class= " mb-4 mx-1 px-0" id="degree"  src ='https://cdn3.iconfinder.com/data/icons/virtual-notebook/16/button_shape_oval-512.png'  style=' width:7%; height:auto;'>F</h2>
          </div>
          
         
          
      </div>
      <div class="col-1 h-25 d-inline-block"></div>
      <div class="col h-25 d-inline-block">
      <div class="col">
      <img class="my-auto img-responsive h-25 d-inline-block" style=' display:inline; width:50%; height:auto; min-width: 50%; min-height:auto; object-fit: cover;' src="{{ImageName}}"  alt="Image"/>
      </div>
      </div>  
    </div>
    <p class="pl-3 " style='margin-top: -0.5rem;'>{{summary}}</p>
    </div>
    <div class="modal-footer ml-1 mr-1 pb-0 mb-0 border border-right-0 border-left-0 border-bottom-0 border-secondary">
    </div>
    <div class="row pl-0 ml-0">
    <div class="col-3"></div>
    <div class="col-2"></div>
    <div class="text-left col ">Precipitation: {{prec}}</div>
  </div>
  <div class="row pl-0 ml-0">
  <div class="col-3"></div>
  <div class="col-2"></div>
    <div class="text-left col ">Chance of Rain: {{rain}} %</div>
  </div>
  <div class="row pl-0 ml-0">
  <div class="col-3"></div>
  <div class="col-2"></div>  
    <div class="text-left col ">Wind Speed: {{wind}} mph</div>
  </div>
  <div class="row pl-0 ml-0">
  <div class="col-3"></div>
  <div class="col-2"></div>
    <div class="text-left col ">Humidity: {{humid}} %</div>
  </div>
  <div class="row pl-0 ml-0 pb-2 " >
  <div class="col-3"></div>
  <div class="col-2"></div>
    <div class="text-left col ">Visibility: {{vis}} miles</div>
  </div>
    
  </div>
  `
  
})
export class NgbdModalContent {
  @Input() name;
  public city:string;
  public date:string;
  public temp:string;
  public ImageName:string;
  public summary:string;
  public prec:string;
  public rain:string;
  public wind:string;
  public humid:string;
  public vis:string;
  constructor(public activeModal: NgbActiveModal) {}
}

@Component({
  selector: 'app-canvas-graph',
  templateUrl: './canvas-graph.component.html',
  styleUrls: ['./canvas-graph.component.css']
})

export class CanvasGraphComponent implements OnInit {
  @Input() rslt2;

  closeResult: string;
  constructor(public modalService: NgbModal, private configservice : ConfigService,public globals:Globals) { }
  
  openVerticallyCentered(content:any) {
    this.modalService.open(content, { centered: true });
  }

  fromJsonDate(jDate): string {
    const bDate: Date = new Date(jDate);
    
    return bDate.getDate()+"/"+bDate.getMonth()+"/"+bDate.getFullYear();  //Ignore time
  }

  ngOnInit() {
      var locCity = this.globals.city;
      let chart = new CanvasJS.Chart("chartContainer", {
        animationEnabled: true,
        exportEnabled: false,
        title: {
          text: "Weakly Weather"
        },
        legend: {
          horizontalAlign: "center", // left, center ,right 
          verticalAlign: "top",  // top, center, bottom
        },
        axisX: {
          title: "Days"
        },
        axisY: {
  
          gridThickness: 0,
          includeZero: false,
          title: "Temperature in Fahrenheit",
          interval: 10,
        }, 
        dataPointMaxWidth: 20,
        data: [{
          
          color:  "rgb(165,209,238)",
          type: "rangeBar",
          showInLegend: true,
          indexLabel: "{y[#index]}",
          legendText: "Day wise temperature range",
          toolTipContent: "<b>{label}</b>: {y[0]} to {y[1]}",
          click: onClick,
          dataPoints: [
            { x: 10, y:[Math.floor(this.rslt2.daily.data[7].temperatureLow), Math.floor(this.rslt2.daily.data[7].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[7].time*1000) },
            { x: 20, y:[Math.floor(this.rslt2.daily.data[6].temperatureLow), Math.floor(this.rslt2.daily.data[6].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[6].time*1000) },
            { x: 30, y:[Math.floor(this.rslt2.daily.data[5].temperatureLow), Math.floor(this.rslt2.daily.data[5].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[5].time*1000) },
            { x: 40, y:[Math.floor(this.rslt2.daily.data[4].temperatureLow), Math.floor(this.rslt2.daily.data[4].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[4].time*1000) },
            { x: 50, y:[Math.floor(this.rslt2.daily.data[3].temperatureLow), Math.floor(this.rslt2.daily.data[3].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[3].time*1000) },
            { x: 60, y:[Math.floor(this.rslt2.daily.data[2].temperatureLow), Math.floor(this.rslt2.daily.data[2].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[2].time*1000) },
            { x: 70, y:[Math.floor(this.rslt2.daily.data[1].temperatureLow), Math.floor(this.rslt2.daily.data[1].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[1].time*1000) },
            { x: 80, y:[Math.floor(this.rslt2.daily.data[0].temperatureLow), Math.floor(this.rslt2.daily.data[0].temperatureHigh)], label: this.fromJsonDate(this.rslt2.daily.data[0].time*1000) }
          ]
    
        }]
      });
      chart.render();
      var modalLocal = this.modalService;
      var resultLocal = this.rslt2;
      var configLocal = this.configservice;
      function onClick(e) {
        configLocal.getModalData(resultLocal.latitude,resultLocal.longitude,resultLocal.daily.data[(e.dataPoint.x/10)-1].time).subscribe(dataModal =>{
          const modalRef = modalLocal.open(NgbdModalContent, {centered:true});
          modalRef.componentInstance.city = locCity;
          const bDate: Date = new Date(resultLocal.daily.data[(80-e.dataPoint.x)/10].time*1000);
          modalRef.componentInstance.date = bDate.getDate()+"/"+bDate.getMonth()+"/"+bDate.getFullYear();
          modalRef.componentInstance.temp = Math.round(dataModal.currently.temperature);
          modalRef.componentInstance.summary = dataModal.currently.summary;
          
          if(dataModal.currently.precipIntensity != undefined){
            modalRef.componentInstance.prec = Math.round(dataModal.currently.precipIntensity* 100) / 100;
          }
          else{
            modalRef.componentInstance.prec = "N/A";
          } 
          if(dataModal.currently.precipProbability != undefined){
            modalRef.componentInstance.rain = Math.round(dataModal.currently.precipProbability*100);
          }
          else{
          modalRef.componentInstance.rain = "N/A";
          } 
          if(dataModal.currently.windSpeed != undefined){
            modalRef.componentInstance.wind = Math.round(dataModal.currently.windSpeed* 100) / 100;
          }
          else{
          modalRef.componentInstance.wind = "N/A";
          } 
          if(dataModal.currently.humidity != undefined){
            modalRef.componentInstance.humid = Math.round(dataModal.currently.humidity*100);
          }
          else{
          modalRef.componentInstance.humid = "N/A";
          } 
          if(dataModal.currently.visibility != undefined){
            modalRef.componentInstance.vis = Math.round(dataModal.currently.visibility* 100) / 100;
          }
          else{
          modalRef.componentInstance.vis = "N/A";
          }
          if(dataModal.currently.icon == "clear-day" || dataModal.currently.icon == "clear-night"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/sun-512.png";
          }
          else if(dataModal.currently.icon == "rain"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/rain-512.png";
          }
          else if(dataModal.currently.icon == "snow"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/snow-512.png";
          }
          else if(dataModal.currently.icon == "sleet"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/lightning-512.png";
          }
          else if(dataModal.currently.icon == "wind"){
            modalRef.componentInstance.ImageName = "https://cdn4.iconfinder.com/data/icons/the-weather-is-nice-today/64/weather_10-512.png";
          }
          else if(dataModal.currently.icon == "fog"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/cloudy-512.png";
          }
          else if(dataModal.currently.icon == "cloudy"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/cloud-512.png";
          }
          else if(dataModal.currently.icon == "partly-cloudy-day" || dataModal.currently.icon == "partly-cloudy-night"){
            modalRef.componentInstance.ImageName = "https://cdn3.iconfinder.com/data/icons/weather-344/142/sunny-512.png";
          }
        });
      }

      
  }
  

}
