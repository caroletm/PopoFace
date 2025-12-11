//
//  RouletteController.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import Foundation
import SwiftUI
import Combine

final class RouletteController<T: Identifiable>: ObservableObject {
    @Published var running = false
    @Published var currentIndex = 0
    @Published var selectedItem: T?

    let items: [T]
    var timer: Timer?
    let speed: TimeInterval = 0.08

    init(items: [T]) {
        self.items = items
    }

    func start() {
        guard !running else { return }
        running = true
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentIndex = Int.random(in: 0..<self.items.count)
        }
    }

    func stop() {
        timer?.invalidate()
        running = false
        selectedItem = items[currentIndex]
    }
}
