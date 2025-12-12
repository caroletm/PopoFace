//
// MainView.swift
// PopoFace
//
// Created by You on 11/12/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var faceDetector = FaceDetector()

    @State private var currentTheme: Theme = .celebrity

    @StateObject private var celebrityController = RouletteController(items: celebrities)
    @StateObject private var fruitController = RouletteController(items: fruits)
    @StateObject private var vegetableController = RouletteController(items: vegetables)

    @State private var showCategoryButtons = false
    @State private var showShareSheet = false

    var body: some View {
        GeometryReader { geo in
            let faceRect = convert(faceDetector.faceBoundingBox, in: geo)

            Color.clear

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
                    .ignoresSafeArea()

                // CardCell en haut centré - affiche l'item en cours
                VStack(spacing: 20) {
                    CardCell(
                        image: .constant(getCurrentDisplayItem()?.image ?? "tomato"),
                        name: .constant(getCurrentDisplayItem()?.nom ?? "En attente...")
                    )
                    .padding(.top, 100)

                    Spacer()
                }

                // Bouton de partage en haut à droite
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showShareSheet = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(.clear)
                                        .glassEffect(in: .circle)
                                )
                        }
                        .padding(.top, 60)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }

                // Picker thème avec bouton toggle (aligné avec le bouton Lancer)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(spacing: 20) {
                            // Boutons de catégories (affichés conditionnellement)
                            if showCategoryButtons {
                                ThemePickerView(currentTheme: $currentTheme)
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                            }

                            // Bouton Palette Logo
                            Button {
                                withAnimation(.spring()) {
                                    showCategoryButtons.toggle()
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.clear)
                                        .glassEffect(in: .circle)
                                        .frame(width: 64, height: 64)

                                    Image("Palette Logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.bottom, 60)
                }

                // Bouton Start/Stop
                VStack {
                    Spacer()

                    Button {
                        switch currentTheme {
                            case .celebrity:
                                celebrityController.running ? celebrityController.stop() : celebrityController.start()
                            case .fruit:
                                fruitController.running ? fruitController.stop() : fruitController.start()
                            case .vegetable:
                                vegetableController.running ? vegetableController.stop() : vegetableController.start()
                        }
                    } label: {
                        Text(currentControllerIsRunning() ? "Stopper" : "Lancer")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.black)
                            .frame(width: 200)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(
                                        LinearGradient(
                                            colors: [.yellowClear, .yellowBlack],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                            }
                    }

                    .padding(.bottom, 60)
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: ["Découvre PopoFace ! 🎭"])
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

    //Retourne le FaceItem sélectionné pour l'overlay
    private func getCurrentSelectedItem() -> (any FaceItem)? {
        switch currentTheme {
        case .celebrity: return celebrityController.selectedItem
        case .fruit: return fruitController.selectedItem
        case .vegetable: return vegetableController.selectedItem
        }
    }

    // Retourne l'item en cours (celui qui défile ou celui sélectionné)
    private func getCurrentDisplayItem() -> (any FaceItem)? {
        switch currentTheme {
        case .celebrity:
            return celebrityController.running
                ? celebrityController.items[celebrityController.currentIndex]
                : celebrityController.selectedItem
        case .fruit:
            return fruitController.running
                ? fruitController.items[fruitController.currentIndex]
                : fruitController.selectedItem
        case .vegetable:
            return vegetableController.running
                ? vegetableController.items[vegetableController.currentIndex]
                : vegetableController.selectedItem
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

// MARK: - ShareSheet
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
