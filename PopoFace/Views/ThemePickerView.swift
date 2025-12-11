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
        HStack(spacing: 20) {
            ButtonThemeCell(
                image: "taylor", // ou une image représentative des célébrités
                isSelect: currentTheme == .celebrity
            ) {
                currentTheme = .celebrity
            }
            
            ButtonThemeCell(
                image: "apple",
                isSelect: currentTheme == .fruit
            ) {
                currentTheme = .fruit
            }
            
            ButtonThemeCell(
                image: "carrot",
                isSelect: currentTheme == .vegetable
            ) {
                currentTheme = .vegetable
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

