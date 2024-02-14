import { OpenSceneOptions } from "@nativescript/swift-ui";

export interface DataSceneModel extends OpenSceneOptions {
  data?: {
    url?: string;
    preset?: "sparks" | "magic" | "snow" | "fireworks" | "impact" | "rain";
    position?: { x: number; y: number; z: number };
    scale?: number;
  };
  opened?: boolean;
  icon?: string;
}
