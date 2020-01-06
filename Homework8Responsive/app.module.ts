import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import {HttpClientModule, HttpClient} from '@angular/common/http';
import {ConfigService} from './config.service';
import { ThreetabsComponent } from './threetabs/threetabs.component';
import { Globals } from './global';
import { ChartsModule } from 'ng2-charts';
import { CanvasGraphComponent, NgbdModalContent } from './threetabs/canvas-graph/canvas-graph.component';
import { NgbModal, NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatAutocompleteModule,MatInputModule} from '@angular/material';


@NgModule({
  declarations: [
    AppComponent,
    ThreetabsComponent,
    CanvasGraphComponent,
    NgbdModalContent
    
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    ChartsModule,
    NgbModule,
    BrowserAnimationsModule,
    MatAutocompleteModule,
    MatInputModule
  ],
  providers: [HttpClient,ConfigService,Globals],
  bootstrap: [AppComponent
    ],
    entryComponents: [NgbdModalContent]
})
export class AppModule { }
