//
//  ButtonThemeCell.swift
//  PopoFace
//
//  Created by apprenant152 on 11/12/2025.
//

import SwiftUI

struct ButtonThemeCell: View {
    let image: String
    let isSelect: Bool
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        }label: {
            ZStack{
                Circle()
                    .fill(.clear)
                    .glassEffect(isSelect ? .regular : .clear)
                    .frame(width: 64, height: 64)
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
            }
        }
      
    }
}

#Preview {
    ZStack{
        ButtonThemeCell(image: "apple", isSelect: false) {
            print("Button tapped")
        }
    }
    .background(.red)
}
