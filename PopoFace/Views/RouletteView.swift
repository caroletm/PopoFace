//
//  RouletteView.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import SwiftUI

struct RouletteView<T: Identifiable>: View {
    @ObservedObject var controller: RouletteController<T>
    var getImage: (T) -> String
    var getName: (T) -> String

    var body: some View {
        if controller.running {
            Image(getImage(controller.items[controller.currentIndex]))
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .onTapGesture { controller.stop() }
        }
    }
}
