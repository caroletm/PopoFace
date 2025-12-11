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
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.clear)
                .glassEffect(in: .rect(cornerRadius: 26))
                .frame(width: 155, height: 155)
            VStack{
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
                    .frame(width: 123, height: 30)
                    .overlay {
                        Text(name)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}

#Preview {
    ZStack{
        CardCell(image: .constant("tomato"), name: .constant("Tomato"))
    }
    .background(.red)
    
}
