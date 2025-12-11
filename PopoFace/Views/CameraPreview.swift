    //
    // CameraPreview.swift
    // PopoFace
    //
    // Created by You on 11/12/2025.
    //

import SwiftUI
@preconcurrency import AVFoundation

final class CameraContainerView: UIView {
    let session: AVCaptureSession
    let previewLayer: AVCaptureVideoPreviewLayer
    
    init(session: AVCaptureSession) {
        self.session = session
        self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
        super.init(frame: .zero)
        
        layer.addSublayer(previewLayer)
        previewLayer.videoGravity = .resizeAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
}

@MainActor
struct CameraPreview: UIViewRepresentable {
    @ObservedObject var faceDetector: FaceDetector
    
    nonisolated class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        let faceDetector: FaceDetector
        
        nonisolated init(faceDetector: FaceDetector) {
            self.faceDetector = faceDetector
        }
        
        nonisolated func captureOutput(_ output: AVCaptureOutput,
                                       didOutput sampleBuffer: CMSampleBuffer,
                                       from connection: AVCaptureConnection) {
            nonisolated(unsafe) let buffer = sampleBuffer
            Task { @MainActor in
                faceDetector.analyze(buffer)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(faceDetector: faceDetector)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
            // Vérifier la permission caméra
        let session = AVCaptureSession()
        session.sessionPreset = .high
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .front) else {
            return view // appareil sans caméra frontale
        }
        
            // Demande d'autorisation si besoin
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                
                break
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                        // Si l'utilisateur donne accès, rien à faire ici — session sera démarrée si l'UI est recreée
                }
                    // On continue et essayer de configurer (peut échouer si pas encore autorisé)
            default:
                    // denied / restricted : retourne un empty view (tu peux afficher un message si tu veux)
                return view
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                session.beginConfiguration()
                
                    // Input
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                    // Output
                let dataOutput = AVCaptureVideoDataOutput()
                dataOutput.alwaysDiscardsLateVideoFrames = true
                    // pixel format par défaut est ok; si besoin configurer ici
                
                let queue = DispatchQueue(label: "videoQueue")
                dataOutput.setSampleBufferDelegate(context.coordinator, queue: queue)
                
                if session.canAddOutput(dataOutput) {
                    session.addOutput(dataOutput)
                }
                
                    // Mirror front camera if possible
                if let connection = dataOutput.connection(with: .video), connection.isVideoMirroringSupported {
                    connection.isVideoMirrored = true
                }
                
                session.commitConfiguration()
                
                    // Start session
                session.startRunning()
            } catch {
                print("Camera configuration error: \(error.localizedDescription)")
            }
        }
        
            // Crée la view contenant le previewLayer
        let container = CameraContainerView(session: session)
        
            // Ajoute container en subview et le pin à 0 pour que SwiftUI contrôle la taille via layout
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
            // rien à faire : layoutSubviews du CameraContainerView va gérer la taille
    }
}
