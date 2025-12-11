//
//  CameraView.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var faceDetector: FaceDetector

    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        let parent: CameraPreview
        init(parent: CameraPreview) { self.parent = parent }

        func captureOutput(_ output: AVCaptureOutput,
                           didOutput sampleBuffer: CMSampleBuffer,
                           from connection: AVCaptureConnection) {
            parent.faceDetector.analyze(sampleBuffer)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let session = AVCaptureSession()
        session.sessionPreset = .high

        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .front) else { return view }
        let input = try! AVCaptureDeviceInput(device: device)
        session.addInput(input)

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "videoQ"))
        session.addOutput(output)

        if let conn = output.connection(with: .video), conn.isVideoMirroringSupported {
            conn.isVideoMirrored = true
        }

        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = .resizeAspectFill
        layer.frame = UIScreen.main.bounds
        view.layer.addSublayer(layer)

        session.startRunning()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

