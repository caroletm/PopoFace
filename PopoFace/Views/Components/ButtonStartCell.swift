//
//  ButtonStartCell.swift
//  PopoFace
//
//  Created by apprenant152 on 11/12/2025.
//

import SwiftUI

struct ButtonStartCell: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Lancer")
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
    }
}

#Preview {
    ButtonStartCell()
}
