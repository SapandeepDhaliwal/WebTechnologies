import { Injectable } from '@angular/core';
import {HttpClient, HttpResponse} from '@angular/common/http';
import { NgForm } from '@angular/forms';
import { Observable, of } from 'rxjs';
import {map, tap} from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})


export class ConfigService {
  constructor(private http: HttpClient) { }
  
  getLatLong(): Observable<any>{
    return this.http.get('http://ip-api.com/json').pipe(map((response : Response)=>{
      const res = response;
      return res;
    }));

  }
  

  getFormData(form: NgForm, lat,lon,city): Observable<any>{
    var url='';
    var street = form.value.street;
    var prefix:string = "http://hw8submission.appspot.com";
    var state = form.value.state;
    var currentLoc = JSON.stringify(form.value.currentLocation);
    if(currentLoc!="true"){
      url = prefix+'/street/'+street+'&city/'+city+'&state/'+state;
    }
    else{
      url = prefix+'/lat/'+lat+'&long/'+lon;
    }
    return this.http.get(url).pipe(map((response : Response)=>{
        const res = response;
        return res;
    }));
  

  }

  getModalData( lat,lon,time): Observable<any>{
   
    var url='';
    var prefix:string = "http://hw8submission.appspot.com";
    url = prefix+'/lat/'+lat+'&long/'+lon+'&time/'+time;
    
    return this.http.get(url).pipe(map((response : Response)=>{
        const res = response;
        return res;
    }));
  

  }

  getFavFormData(lat,lon): Observable<any>{
    
    var url='';
    var prefix:string = "http://hw8submission.appspot.com";
    url = prefix+'/lat/'+lat+'&long/'+lon;
    
    return this.http.get(url).pipe(map((response : Response)=>{
        const res = response;
        return res;
    }));


  }


  getSeal(state): Observable<any>{
    
    var url='';
    var prefix:string = "http://hw8submission.appspot.com";
    url = prefix+'/state/'+state;
    
    return this.http.get(url).pipe(map((response : Response)=>{
        const res = response;
        return res;
    }));


  }

  

  getData(cityFrag): Observable<string[]>{

    var url='';
    var prefix:string = "http://hw8submission.appspot.com";
    url = prefix+'/city/'+cityFrag;
    return this.http.get(url).pipe(
     
      map(
        (res:any) => {
          return res.predictions.map(
            item => {
              return item.structured_formatting.main_text;
            }
          );
        }
      )
    );
  }

}
