import SwiftUI

@main
struct NativeScriptApp: App {
    @State private var immersionStyle: ImmersionStyle = .full

    var body: some Scene {
        NativeScriptMainWindow()
            .defaultSize(width: 750, height: 700)

        WindowGroup(id: "Video") {
            VideoSceneView()
        }
        .windowStyle(.plain)

        WindowGroup(id: "Fire") {
            FireView()
        }
        .windowStyle(.plain)
        .defaultSize(width: 3.0, height: 3.0, depth: 0.0, in: .meters)
        
        WindowGroup(id: "Fireflies") {
            FirefliesView()
        }
        .windowStyle(.plain)
        .defaultSize(width: 2.0, height: 2.0, depth: 0.0, in: .meters)
        
        ImmersiveSpace(id: "ParticleEmitter") {
            ParticleEmitterView()
        }
        .immersionStyle(selection: $immersionStyle, in: .full, .full)
    }
}
