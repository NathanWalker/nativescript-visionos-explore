import { NgModule, NO_ERRORS_SCHEMA } from "@angular/core";
import { NativeScriptModule } from "@nativescript/angular";
import { FontIconModule, USE_STORE } from "nativescript-fonticon/angular";

import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";
import { ItemsComponent } from "./item/items.component";
import { ionIcons } from "./ionicons";

@NgModule({
  bootstrap: [AppComponent],
  imports: [NativeScriptModule, AppRoutingModule, FontIconModule.forRoot({})],
  declarations: [AppComponent, ItemsComponent],
  providers: [
    {
      // inline font icons
      provide: USE_STORE,
      useValue: {
        ion: ionIcons,
      },
    },
  ],
  schemas: [NO_ERRORS_SCHEMA],
})
export class AppModule {}
