//
//  CardCell.swift
//  PopoFace
//
//  Created by apprenant152 on 11/12/2025.
//

import SwiftUI

struct CardCell: View {
    @Binding var image: String
    @Binding var name: String
    var body: some View {
        VStack(spacing: 16) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 135, height: 135)
                .clipShape(Circle())

            Text(name)
                .font(.title.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.blue)
                )
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding()
        .frame(width: 250, height: 250)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.clear)
                .glassEffect(in: .rect(cornerRadius: 30))
        )
    }
}

#Preview {
    ZStack{
        CardCell(image: .constant("tomato"), name: .constant("Tomato"))
    }
    .background(.red)
    
}
