import { Component, inject } from "@angular/core";

import { DataSceneModel } from "./data-scene.model";
import { DataService } from "./data.service";
import { openScene, updateScene } from "@nativescript/swift-ui";

@Component({
  selector: "ns-items",
  templateUrl: "./items.component.html",
})
export class ItemsComponent {
  dataService = inject(DataService);
  activeImmersivePreset: string;

  openSceneWindow(model: DataSceneModel) {
    if (model.isImmersive) {
      const sceneId = model.id.split(" ")[0];
      if (
        this.activeImmersivePreset &&
        this.activeImmersivePreset !== model.data.preset
      ) {
        this.activeImmersivePreset = model.data.preset;
        // switching active preset while open
        updateScene({
          ...model,
          id: sceneId,
        });
        return;
      } else {
        // toggling immersize
        openScene({
          ...model,
          id: sceneId,
        });
        this.activeImmersivePreset = model.opened ? null : model.data.preset;
      }
    } else {
      // toggle window scenes
      openScene(model);
    }
    model.opened = !model.opened;
  }
}
