//
//  ThemePickerView.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import SwiftUI

enum Theme: String, CaseIterable {
    case celebrity = "Célébrités"
    case fruit = "Fruits"
    case vegetable = "Légumes"
}

struct ThemePickerView: View {
    @Binding var currentTheme: Theme

    var body: some View {
        Menu {
            Button("Célébrités") { currentTheme = .celebrity }
            Button("Fruits") { currentTheme = .fruit }
            Button("Légumes") { currentTheme = .vegetable }
        } label: {
            Image(systemName: "square.grid.2x2")
                .font(.largeTitle)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding()
        }
    }
}

