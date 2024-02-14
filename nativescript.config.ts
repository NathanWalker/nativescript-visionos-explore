import { NativeScriptConfig } from '@nativescript/core';

export default {
  id: 'org.nativescript.nativescriptvisionosexplore',
  appPath: 'src',
  appResourcesPath: 'App_Resources',
  android: {
    v8Flags: '--expose_gc',
    markingMode: 'none'
  },
  visionos: {
    SPMPackages: [
      {
        name: 'Vortex',
        libs: ['Vortex'],
        repositoryURL: 'https://github.com/twostraws/Vortex.git',
        version: '1.0.0'
      }
    ]
  }
} as NativeScriptConfig;