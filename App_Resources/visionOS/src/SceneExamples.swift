// These examples are from the excellent Vortex library by @twostraws!
// https://www.github.com/twostraws/Vortex
// See LICENSE for license information.
//

import SwiftUI
import RealityKit
import Vortex
import AVKit

struct FirefliesView: View {
    @State private var isDragging = false

    var body: some View {
        VortexViewReader { proxy in
            ZStack(alignment: .bottom) {
                if isDragging {
                    Text("Release your drag to reset the fireflies.")
                        .padding(.bottom, 20)
                } else {
                    Text("Drag anywhere to repel the fireflies.")
                        .padding(.bottom, 20)
                }

                VortexView(.fireflies.makeUniqueCopy()) {
                    Circle()
                        .fill(.white)
                        .frame(width: 32)
                        .blur(radius: 3)
                        .blendMode(.plusLighter)
                        .tag("circle")
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            proxy.attractTo(value.location)
                            proxy.particleSystem?.attractionStrength = -2
                            isDragging = true
                        }
                        .onEnded { _ in
                            proxy.particleSystem?.attractionStrength = 0
                            isDragging = false
                        }
                )
            }
        }
    }
}

struct FireView: View {
    @State private var isDragging = false

    var body: some View {
        VortexViewReader { proxy in
            ZStack {
                if isDragging {
                    Text("Release your drag to reset the fire.")
                        .offset(y: 50)
                } else {
                    Text("Drag near the fire to attract it.")
                        .offset(y: 50)
                }

                VortexView(.fire.makeUniqueCopy()) {
                    Circle()
                        .fill(.white)
                        .frame(width: 88)
                        .blur(radius: 6)
                        .blendMode(.plusLighter)
                        .tag("circle")
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            proxy.attractTo(value.location)
                            proxy.particleSystem?.attractionStrength = 2
                            isDragging = true
                        }
                        .onEnded { _ in
                            proxy.particleSystem?.attractionStrength = 0
                            isDragging = false
                        }
                )
            }
        }
    }
}

struct VideoSceneView: View {
    @State var context: NativeScriptSceneContext?
    @State var player: AVPlayer?
    
    func createPlayer(url: String, autoPlay: Bool = true) -> AVPlayer {
        let player = AVPlayer(url: URL(string: url)!)
        if autoPlay {
            player.play()
        }
        return player
    }
    
    var body: some View {
        ZStack {
            if context != nil {
                VideoPlayer(player: player)
                    .scaledToFill()
            } else {
                EmptyView()
            }
        }.onReceive(NotificationCenter.default
            .publisher(for: NSNotification.Name("NativeScriptUpdateScene")), perform: { obj in
                setupContext()
        }).onAppear {
            setupContext()
        }
    }
    
    func setupContext() {
        context = NativeScriptSceneRegistry.shared.getContextForId(id: "Video")
        let url = context!.data["url"] as! String
        let autoPlay = context!.data["autoPlay"] as? Bool ?? true
        if (player != nil) {
            player!.replaceCurrentItem(with: AVPlayerItem(url: URL(string: url)!))
        } else {
            player = createPlayer(url: url, autoPlay: autoPlay)
        }
    }
}
 
struct ParticleEmitterView: View {
    @State var context: NativeScriptSceneContext?
    @State var preset: String = "magic"
    @State var position: SIMD3<Float> = SIMD3(x: 0, y: 1.5, z: -1)
    @State var scale: Float = 4
    @State var viewID = 0

  var body: some View {
      ZStack {
          if context != nil {
              RealityView { content in
                  var particles = ParticleEmitterComponent.Presets.magic
                  
                  switch preset {
                  case "fireworks":
                      particles = ParticleEmitterComponent.Presets.fireworks
                  case "snow":
                      particles = ParticleEmitterComponent.Presets.snow
                  case "rain":
                      particles = ParticleEmitterComponent.Presets.rain
                  case "sparks":
                      particles = ParticleEmitterComponent.Presets.sparks
                  case "impact":
                      particles = ParticleEmitterComponent.Presets.impact
                  default:
                      particles = ParticleEmitterComponent.Presets.magic
                  }
                  
                  particles.birthLocation = .surface
                  particles.mainEmitter.size = 0.003
                  particles.emitterShape = .plane
                  
                  let particleEntity = Entity()
                  particleEntity.components[ParticleEmitterComponent.self] = particles
                  particleEntity.transform.scale *= scale
                  particleEntity.scale *= scale
                  particleEntity.position = position
                  
                  content.add(particleEntity)
                  
              }.id(viewID)
          } else {
              EmptyView()
          }
      }.onReceive(NotificationCenter.default
        .publisher(for: NSNotification.Name("NativeScriptUpdateScene")), perform: { obj in
            setupContext()
        }).onAppear {
            setupContext()
        }
  }

  func setupContext() {
    context = NativeScriptSceneRegistry.shared.getContextForId(id: "ParticleEmitter")
    if (context != nil) {
        preset = context!.data["preset"] as! String
        if (context!.data["position"] != nil) {
            let screenPos = context!.data["position"] as! Dictionary<String,Float>
            position = SIMD3(x: screenPos["x"]!, y: screenPos["y"]!, z: screenPos["z"]!)
        }
        if (context!.data["scale"] != nil) {
          scale = context!.data["scale"] as! Float
        }
        viewID += 1
    }
  }
}
