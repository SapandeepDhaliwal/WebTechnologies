import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators, NgForm } from '@angular/forms';
import {ConfigService} from '../app/config.service';
import {Globals} from './global';
import { Observable, from, of } from 'rxjs';
import { startWith, map, debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { ValidatorFn } from '@angular/forms';

const trimValidator: ValidatorFn = (control: FormControl) => {
  if (control.value.startsWith(' ') || control.invalid || control.touched) {
    return {
      
      'trimError': { value: 'Please enter a street.' }
    };
  }

  return null;
};




@Component({
    selector: 'app-root',
    templateUrl: 'app.component.html',
    styleUrls: ['app.component.css']
})



export class AppComponent{
  control = new FormControl('', trimValidator);
  public show:boolean = false;
  public displayNoFav:boolean = false;
  public displayFav:boolean = false;
  public length;
  public favData;
  public street:string;
  public state:string = "Select0";
  public currentLocation:string;
  public progressBar:boolean = false;
  public invalid:boolean = false;
  public resultJson='';

  title = 'weather-app';
  city: string;
  toggleValue:boolean = false;
  public arr = [];
  
  @ViewChild('weatherSearch')public weatherSearchControl:NgForm
  response: any;
  cityControl = new FormControl();
  cities: string[] = ['Champs-Élysées', 'champs','Lombard Street', 'Abbey Road', 'Fifth Avenue'];
  filteredcities: Observable<string[]>;


  constructor(private configservice : ConfigService, public globals:Globals){}


    ngOnInit() {
      this.toggleValue = true;
      this.filteredcities = this.cityControl.valueChanges.pipe(
        debounceTime(400),
        distinctUntilChanged(),
        switchMap(term => this._filter(term))
      );
      
    }

    onChanges(checked) {
      
      this.toggleValue=!checked;
    }

    
    _filter(value) {
      const filterValue = this._normalizeValue(value);
      
      if(value.trim().length > 0)
      {
        return this.configservice.getData(filterValue);
      }
      else{
        return of([]);
      }

     
    }

    private _normalizeValue(value: string): string {
      return value.toLowerCase().replace(/\s/g, '');
    }

    clearData(){
      this.weatherSearchControl.resetForm({state: "Select0"});
      this.cityControl.setValue('');
      
      this.cityControl.markAsPristine();
      this.cityControl.markAsUntouched();
      this.cityControl.updateValueAndValidity();
      this.show = false;
      this.displayNoFav = false;
      this.displayFav = false;
      this.invalid =false;
      this.progressBar = false;
      this.toggleValue = true;
    }

    
    
    onSubmit(form: NgForm) {
      

      var lat;
      var lon;
      this.show = false;
      this.displayNoFav = false;
      this.displayFav = false;
      this.invalid =false;
      this.progressBar = true;
     
      
      if((form.value.state == undefined || 
        form.value.street.trim().length == 0 || 
        this.cityControl.value.trim().length == 0) &&
        JSON.stringify(form.value.currentLocation) != "true"){
            
        this.invalid = true;
        this.show = false;
        this.displayNoFav = false;
        this.displayFav = false;
        
        this.progressBar = false;
      }
      else{

      this.configservice.getLatLong().subscribe(data1 =>{
        lat = data1.lat;
        lon = data1.lon;
        if(JSON.stringify(form.value.currentLocation) == "true"){
          this.globals.city = data1.city;
          this.globals.state = data1.region;
          

        }
        else{
          this.globals.city = this.cityControl.value;
          this.globals.state = form.value.state;
        }
        this.cityControl.value
        this.globals.stateName =  this.globals.getStateName(this.globals.state);

        this.configservice.getFormData(form,lat,lon,this.globals.city).subscribe(data =>{
          if(data.latitude == undefined){
            
            this.invalid = true;
            this.show = false;
            this.displayNoFav = false;
            this.displayFav = false;
            
            this.progressBar = false;
          }
          else{
           
          this.resultJson = data;
          this.globals.lat = data.latitude;
          this.globals.long = data.longitude;
      
          this.configservice.getSeal(this.globals.stateName).subscribe(data2 =>{
            
            this.globals.sealUrl = data2.items[0].link;
          });

          this.show = true;
          this.displayNoFav = false;
          this.displayFav = false;
          this.invalid =false;
          this.progressBar = false;
        }
        });
        
      
      });
    }
    }


    favButtonClicked(){
      this.displayFav=false;
      this.displayNoFav=false;
      this.invalid =false;
      this.favData = [];
      var localLength = 0;
      for(var i = 0; i < this.globals.myStorage.length; i++){
        

        var key = this.globals.myStorage.key(i);
        if(key.split(":").length == 2)
        {
          localLength++;
        }
      }

      if(localLength == 0){
        this.displayNoFav = true;
        this.show = false;
      }
      else{
        this.show = false;
        this.displayNoFav = false;
        this.displayFav = true;
        this.length = this.globals.myStorage.length;
      }
      var j = 0;
      for(var i = 0; i < this.globals.myStorage.length; i++){
        

        var key = this.globals.myStorage.key(i);
        if(key.split(":").length == 2)
        {
          var locState = this.globals.myStorage.getItem(key).split(":")[1];
          this.favData.push({idx : j+1,
            act_idx:i+1, 
            city : this.globals.myStorage.getItem(key).split(":")[0],
            state : this.globals.myStorage.getItem(key).split(":")[1],
            url: this.globals.myStorage.getItem(locState)
          });
          j++;
        }
        
      }
     
    }


    removeFavRow(index){
      var key = this.globals.myStorage.key(index-1);
      this.globals.myStorage.removeItem(key);
      
      this.favButtonClicked();
    }


    cityClicked(index){
      this.progressBar = true;
      var key = this.globals.myStorage.key(index-1);
      var city = this.globals.myStorage.getItem(key).split(":")[0];
      var state = this.globals.myStorage.getItem(key).split(":")[1];
      var lat = this.globals.myStorage.getItem(key).split(":")[2];
      var lon = this.globals.myStorage.getItem(key).split(":")[3];
     

      this.globals.city = city;
      this.globals.state =state;
      this.globals.stateName = this.globals.getStateName(this.globals.state);
      this.configservice.getFavFormData(lat,lon).subscribe(data =>{
        this.resultJson = data;
        this.globals.lat = data.latitude;
        this.globals.long = data.longitude;
        this.progressBar = false;

        this.configservice.getSeal(this.globals.stateName).subscribe(data2 =>{
            
          this.globals.sealUrl = data2.items[0].link;
        });
      });
      this.show = true;
      this.displayNoFav = false;
      this.displayFav = false;
      
     


    }


}
