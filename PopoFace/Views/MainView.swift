//
//  MainView.swift
//  PopoFace
//
//  Created by Thibault on 11/12/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Image(systemName: "dog")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Bienvenu sur PopoFace!")
        }
        .padding()
    }
}

#Preview {
    MainView()
}
