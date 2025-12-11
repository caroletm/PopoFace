//
//  ContentView.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import SwiftUI
import Vision
import AVFoundation
import Combine


struct ContentView: View {
    @StateObject private var faceDetector = FaceDetector()

    @State private var currentTheme: Theme = .celebrity

    @StateObject private var celebrityController = RouletteController(items: celebrities)
    @StateObject private var fruitController = RouletteController(items: fruits)
    @StateObject private var vegetableController = RouletteController(items: vegetables)

    var body: some View {
        ZStack {
            CameraPreview(faceDetector: faceDetector)
                .edgesIgnoringSafeArea(.all)

            rouletteView
                .position(x: UIScreen.main.bounds.width / 2,
                          y: UIScreen.main.bounds.height / 2 - 50)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ThemePickerView(currentTheme: $currentTheme)
                }
            }

            VStack {
                Spacer()
                Button(action: { startStopRoulette() }) {
                    Text(currentThemeControllerRunning() ? "Stop" : "Start")
                        .bold()
                        .frame(width: 120, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 60)
            }
        }
//        .alert(isPresented: Binding<Bool>(
//            get: { currentController.selectedItem != nil },
//            set: { if !$0 { currentController.selectedItem = nil } }
//        )) {
//            Alert(
//                title: Text("Résultat"),
//                message: Text("Tu es : \(getName())"),
//                dismissButton: .default(Text("OK"))
//            )
//        }
    }

    // MARK: - Helpers
//    private var currentController: any AnyObject & ObservableObject {
//        switch currentTheme {
//        case .celebrity: return celebrityController
//        case .fruit: return fruitController
//        case .vegetable: return vegetableController
//        }
//    }

    @ViewBuilder
    private var rouletteView: some View {
        switch currentTheme {
        case .celebrity:
            RouletteView(controller: celebrityController,
                         getImage: { $0.image },
                         getName: { $0.nom })
        case .fruit:
            RouletteView(controller: fruitController,
                         getImage: { $0.image },
                         getName: { $0.nom })
        case .vegetable:
            RouletteView(controller: vegetableController,
                         getImage: { $0.image },
                         getName: { $0.nom })
        }
    }

    private func getName() -> String {
        switch currentTheme {
        case .celebrity:
            return celebrityController.selectedItem?.nom ?? "Inconnu"
        case .fruit:
            return fruitController.selectedItem?.nom ?? "Inconnu"
        case .vegetable:
            return vegetableController.selectedItem?.nom ?? "Inconnu"
        }
    }


    private func startStopRoulette() {
        switch currentTheme {
        case .celebrity:
            celebrityController.running ? celebrityController.stop() : celebrityController.start()
        case .fruit:
            fruitController.running ? fruitController.stop() : fruitController.start()
        case .vegetable:
            vegetableController.running ? vegetableController.stop() : vegetableController.start()
        }
    }
    
    private func currentThemeControllerRunning() -> Bool {
        switch currentTheme {
        case .celebrity: return celebrityController.running
        case .fruit: return fruitController.running
        case .vegetable: return vegetableController.running
        }
    }

}
