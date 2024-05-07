//
//  ARCameraContainer.swift
//  TemanTuli
//
//  Created by Hilmy Noerfatih on 24/05/23.
//

import SwiftUI
import ARKit

struct ARSCNCameraContainer: View {
    @Binding var classifiedSign : String
    @Binding var progress : Double
    @Binding var isDone : Bool
    
    var sign : String
    @State private var arSession = ARSession()

    var body: some View {
        ZStack {
            ARSCNCameraView(classifiedSign: $classifiedSign, progress: $progress, isDone: $isDone, sign: sign, session: arSession)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            let configuration = ARFaceTrackingConfiguration()
            configuration.isWorldTrackingEnabled = true
            arSession.run(configuration)
        }
        .onDisappear {
            arSession.pause()
        }
    }
}
