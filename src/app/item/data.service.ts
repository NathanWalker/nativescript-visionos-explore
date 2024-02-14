import { Injectable } from "@angular/core";

import { DataSceneModel } from "./data-scene.model";

@Injectable({
  providedIn: "root",
})
export class DataService {
  items: Array<DataSceneModel> = [
    {
      id: "Video",
      data: {
        url: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      },
      icon: "ion-ios-videocam",
    },
    { id: "Fire", icon: "ion-ios-bonfire" },
    { id: "Fireflies", icon: "ion-ios-star" },
    {
      id: "ParticleEmitter Magic",
      isImmersive: true,
      data: { preset: "magic" },
      icon: "ion-ios-water",
    },
    {
      id: "ParticleEmitter Fireworks",
      isImmersive: true,
      data: {
        preset: "fireworks",
        position: { x: 0, y: 1.5, z: -0.5 },
        scale: 3,
      },
      icon: "ion-ios-water",
    },
    {
      id: "ParticleEmitter Snow",
      isImmersive: true,
      data: { preset: "snow", position: { x: 0, y: 2, z: -1 } },
      icon: "ion-ios-water",
    },
    {
      id: "ParticleEmitter Rain",
      isImmersive: true,
      data: { preset: "rain", position: { x: 0, y: 2, z: -0.5 } },
      icon: "ion-ios-water",
    },
    {
      id: "ParticleEmitter Impact",
      isImmersive: true,
      data: { preset: "impact", position: { x: 0, y: 1.5, z: -0.5 } },
      icon: "ion-ios-water",
    }
  ];
}
