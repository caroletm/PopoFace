//
//  FaceDetector.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import Foundation
import AVFoundation
import Vision
import Combine
import CoreImage

class FaceDetector: NSObject, ObservableObject {
    @Published var faceBoundingBox: CGRect = .zero   //  detecter le visage

    private let request = VNDetectFaceRectanglesRequest()
    private let handler = VNSequenceRequestHandler()

    func analyze(_ buffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else { return }

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let imageSize = ciImage.extent.size

        do {
            try handler.perform([request], on: pixelBuffer)

            DispatchQueue.main.async {
                if let face = self.request.results?.first as? VNFaceObservation {

                    // Vision donne un CGRect normalisé (0-1). On le convertit.
                    let w = face.boundingBox.width * imageSize.width
                    let h = face.boundingBox.height * imageSize.height
                    let x = face.boundingBox.minX * imageSize.width
                    let y = (1 - face.boundingBox.minY - face.boundingBox.height) * imageSize.height

                    self.faceBoundingBox = CGRect(x: x, y: y, width: w, height: h)
                } else {
                    self.faceBoundingBox = .zero
                }
            }

        } catch {
            print("Vision error:", error.localizedDescription)
        }
    }
}

