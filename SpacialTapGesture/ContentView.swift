//
// ---------------------------- //
// Original Project: SpacialTapGesture
// Created on 2024-11-06 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.


import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State var subject: Entity?
    @State var indicator: Entity?

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(scene)
                
                // place this indicator at tap location
                let indicatorModel = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: .black, isMetallic: false)]
                )
                
                // Get cube from the scene. It has Input & Collision components
                if let cube = scene.findEntity(named: "Cube") {
                    cube.components.set(HoverEffectComponent())
                    cube.addChild(indicatorModel)
                    subject = cube
                    indicator = indicatorModel
                }
            }
        }
        .gesture(spatialTapGesture)
    }
    
    var spatialTapGesture: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { value in
                if let subject = subject,
                   let indicator = indicator {
                    // convert the location3D to the coordinate space of the subject
                    // Place indicator on surface of the subject
                    let tappedPosition = value.convert(
                        value.location3D,
                        from: .local,
                        to: subject
                    )
                    indicator.position = tappedPosition
                }
            }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environment(AppModel())
}
