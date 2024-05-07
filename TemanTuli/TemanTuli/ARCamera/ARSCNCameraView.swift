//
//  CameraView.swift
//  TemanTuli
//
//  Created by Hilmy Noerfatih on 23/05/23.
//

import SwiftUI
import AVFoundation
import Vision
import CoreML
import ARKit

struct ARSCNCameraView: UIViewRepresentable {
    @Binding var classifiedSign : String
    @Binding var progress : Double
    @Binding var isDone : Bool
    
    var sign : String
    var session: ARSession
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        arView.session = session
        arView.autoenablesDefaultLighting = true // Enable default lighting for realistic rendering
        arView.delegate = context.coordinator
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    typealias UIViewType = ARSCNView
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        private let parent: ARSCNCameraView
        private var interval : Int
        
        init(_ parent: ARSCNCameraView) {
            self.parent = parent
            self.interval = 0
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            // Convert ARFrame to CVPixelBuffer
            guard let frame = parent.session.currentFrame else {
                return
            }
            let pixelBuffer = frame.capturedImage
            // Perform hand pose detection
            detectHandPose(pixelBuffer: pixelBuffer)
        }
        
        private func detectHandPose(pixelBuffer: CVPixelBuffer) {
            
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                let handPoseRequest = VNDetectHumanHandPoseRequest()
                try requestHandler.perform([handPoseRequest])
                
                guard let handPose = handPoseRequest.results, !handPose.isEmpty else {
                    return
                }
                let handOservations = handPose.first
                
                guard let handPoseModel = try? SibiModel(configuration: MLModelConfiguration()) else {
                    fatalError("Failed to load the hand pose model")
                }
                
                do {
                    guard let keypointsMultiArray = try? handOservations?.keypointsMultiArray()
                    else{
                        fatalError()
                    }
                    
                    let output: SibiModelOutput = try handPoseModel.prediction(poses: keypointsMultiArray)
                    print(output.labelProbabilities)
                    
                    DispatchQueue.main.async {
                        if (self.parent.progress >= 1){
                            self.parent.isDone = true
                        }
                        
                        if (self.parent.classifiedSign == self.parent.sign){
                            self.parent.progress += 0.01
                        }else{
                            self.parent.progress = 0
                        }
                        
                        if (self.interval > 5){
                            self.parent.classifiedSign = output.label
                            self.interval = 0
                        }else{
                            self.interval += 1
                        }
                    }
                }
            } catch {
                print("Error performing hand pose detection: \(error)")
            }
        }
    }
}

