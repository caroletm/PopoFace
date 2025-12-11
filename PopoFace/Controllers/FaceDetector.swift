//
//  FaceDetector.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import Foundation
import Foundation
import AVFoundation
import Vision
import Combine

final class FaceDetector: NSObject, ObservableObject {
    @Published var faceDetected: Bool = false

    private let sequenceHandler = VNSequenceRequestHandler()

    func analyze(_ sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let request = VNDetectFaceRectanglesRequest { [weak self] request, error in
            guard let self = self else { return }
            let hasFace = (request.results?.first as? VNFaceObservation) != nil
            DispatchQueue.main.async {
                self.faceDetected = hasFace
            }
        }

        try? sequenceHandler.perform([request], on: pixelBuffer)
    }
}


