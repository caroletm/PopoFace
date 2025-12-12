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
        VStack(spacing: 20) {
            ButtonThemeCell(
                image: "etoile",
                isSelect: currentTheme == .celebrity
            ) {
                currentTheme = .celebrity
            }

            ButtonThemeCell(
                image: "Applefruit",
                isSelect: currentTheme == .fruit
            ) {
                currentTheme = .fruit
            }

            ButtonThemeCell(
                image: "Carotte",
                isSelect: currentTheme == .vegetable
            ) {
                currentTheme = .vegetable
            }
        }
    }
}

