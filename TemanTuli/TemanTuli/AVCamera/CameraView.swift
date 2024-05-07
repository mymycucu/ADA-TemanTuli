////
////  CameraView.swift
////  TemanTuli
////
////  Created by Hilmy Noerfatih on 25/05/23.
////
//
//import SwiftUI
//import AVFoundation
//import Vision
//
//struct CameraView: UIViewRepresentable {
//    private let captureSession = AVCaptureSession()
//    @State private var previewLayer: AVCaptureVideoPreviewLayer?
//
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        setupCaptureSession(context: context)
//        setupPreviewLayer(view: view)
//        startCaptureSession()
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {}
//
//    private func setupCaptureSession(context: Context) {
//        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
//        
//        do {
//            let input = try AVCaptureDeviceInput(device: device)
//            captureSession.addInput(input)
//            
//            let output = AVCaptureVideoDataOutput()
//            output.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "CameraQueue"))
//            captureSession.addOutput(output)
//        } catch {
//            print("Failed to set up capture session:", error)
//        }
//    }
//
//    private func setupPreviewLayer(view: UIView) {
//        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.frame = view.bounds
//        view.layer.addSublayer(previewLayer)
//        self.previewLayer = previewLayer
//    }
//
//    private func startCaptureSession() {
//        captureSession.startRunning()
//    }
//
//    private func stopCaptureSession() {
//        captureSession.stopRunning()
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
//        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//            
//            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
//            
//            do {
//                let handPoseRequest = VNDetectHumanHandPoseRequest()
//                try requestHandler.perform([handPoseRequest])
//                
//                guard let handPose = handPoseRequest.results, !handPose.isEmpty else {
//                    return
//                }
//                let handOservations = handPose.first
//            
////                let recognizedPoints = try observations.recognizedPoints(.all)
//                                
//                guard let handPoseModel = try? SibiModel(configuration: MLModelConfiguration()) else {
//                    fatalError("Failed to load the hand pose model")
//                }
//                
//                do {
////                    let output: SibiModelOutput = try handPoseModel.prediction(poses: buildInputAttribute(recognizedPoints: recognizedPoints))
//                    guard let keypointsMultiArray = try? handOservations?.keypointsMultiArray()
//                    else{
//                        fatalError()
//                    }
//                    
//                    let output: SibiModelOutput = try handPoseModel.prediction(poses: keypointsMultiArray)
//
//                    
////                    print(output.label)
////                    print(output.labelProbabilities.sorted{$0.value < $1.value})
//                    
//                    DispatchQueue.main.async {
//                        let predictionResult = output.label
//                    }
//                }
//            } catch {
//                print("Error performing hand pose detection: \(error)")
//            }
//            
//        }
//    }
//}
//
//
//
