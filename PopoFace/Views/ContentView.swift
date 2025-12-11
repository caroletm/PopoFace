//
// ContentView.swift
// PopoFace
//
// Created by You on 11/12/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var faceDetector = FaceDetector()

    @State private var currentTheme: Theme = .celebrity

    @StateObject private var celebrityController = RouletteController(items: celebrities)
    @StateObject private var fruitController = RouletteController(items: fruits)
    @StateObject private var vegetableController = RouletteController(items: vegetables)

    var body: some View {
        GeometryReader { geo in
            let faceRect = convert(faceDetector.faceBoundingBox, in: geo)

            // Overlay image au-dessus du visage
            if faceRect != .zero, let selected = getCurrentSelectedItem() {
                Image(selected.image)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: faceRect.width * 1.3,
                        height: faceRect.height * 1.3
                    )
                    .position(
                        x: faceRect.midX,
                        y: faceRect.minY - faceRect.height * 0.6
                    )
            }

            ZStack {
                // Camera preview
                CameraPreview(faceDetector: faceDetector)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .edgesIgnoringSafeArea(.all)

                // Roulette au centre
                rouletteView
                    .position(x: geo.size.width / 2, y: geo.size.height / 2 - 50)

                // Picker thème
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ThemePickerView(currentTheme: $currentTheme)
                    }
                }

                // Bouton Start/Stop
                VStack {
                    Spacer()
                    Button(action: { startStopRoulette() }) {
                        Text(currentControllerIsRunning() ? "Stop" : "Start")
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
            // Alert quand un item est sélectionné
            .alert(isPresented: Binding<Bool>(
                get: { getCurrentSelectedItem() != nil },
                set: { if !$0 { clearCurrentSelectedItem() } }
            )) {
                Alert(
                    title: Text("Résultat"),
                    message: Text("Tu es : \(getName())"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // MARK: - Helpers

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

    private func currentControllerIsRunning() -> Bool {
        switch currentTheme {
        case .celebrity: return celebrityController.running
        case .fruit: return fruitController.running
        case .vegetable: return vegetableController.running
        }
    }

    //Retourne le FaceItem sélectionné pour l’overlay
    private func getCurrentSelectedItem() -> (any FaceItem)? {
        switch currentTheme {
        case .celebrity: return celebrityController.selectedItem
        case .fruit: return fruitController.selectedItem
        case .vegetable: return vegetableController.selectedItem
        }
    }

    // 🔹 Vide l’item sélectionné
    private func clearCurrentSelectedItem() {
        switch currentTheme {
        case .celebrity: celebrityController.selectedItem = nil
        case .fruit: fruitController.selectedItem = nil
        case .vegetable: vegetableController.selectedItem = nil
        }
    }

    private func getName() -> String {
        switch currentTheme {
        case .celebrity: return celebrityController.selectedItem?.nom ?? "Inconnu"
        case .fruit: return fruitController.selectedItem?.nom ?? "Inconnu"
        case .vegetable: return vegetableController.selectedItem?.nom ?? "Inconnu"
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

    // Conversion Vision -> SwiftUI coordinates
    func convert(_ rect: CGRect, in geo: GeometryProxy) -> CGRect {
        let viewWidth = geo.size.width
        let viewHeight = geo.size.height

        return CGRect(
            x: rect.minX / 720 * viewWidth,
            y: rect.minY / 1280 * viewHeight,
            width: rect.width / 720 * viewWidth,
            height: rect.height / 1280 * viewHeight
        )
    }
}
