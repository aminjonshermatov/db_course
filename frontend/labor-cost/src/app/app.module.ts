import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {MatButtonModule} from "@angular/material/button";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatTabsModule} from "@angular/material/tabs";
import { DetailsTabComponent } from './details-tab/details-tab.component';
import { ProfessionsTabComponent } from './professions-tab/professions-tab.component';
import { PriceGuidesTabComponent } from './price-guides-tab/price-guides-tab.component';
import { LaborCostStandardsTabComponent } from './labor-cost-standards-tab/labor-cost-standards-tab.component';
import {DetailsService} from "./details-tab/details.service";
import {MatSnackBarModule} from "@angular/material/snack-bar";
import {MatTableModule} from "@angular/material/table";
import {MatSortModule} from "@angular/material/sort";
import {HttpClientModule} from "@angular/common/http";

@NgModule({
  declarations: [
    AppComponent,
    DetailsTabComponent,
    ProfessionsTabComponent,
    PriceGuidesTabComponent,
    LaborCostStandardsTabComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    MatButtonModule,
    BrowserAnimationsModule,
    MatTabsModule,
    MatSnackBarModule,
    MatTableModule,
    MatSortModule,
  ],
  providers: [
    DetailsService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
