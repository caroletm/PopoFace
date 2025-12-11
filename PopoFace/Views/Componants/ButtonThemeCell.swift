//
//  ButtonThemeCell.swift
//  PopoFace
//
//  Created by apprenant152 on 11/12/2025.
//

import SwiftUI

struct ButtonThemeCell: View {
    let image: String
    @State var isSelect: Bool
    var body: some View {
        Button{
            isSelect.toggle()
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
        ButtonThemeCell(image: "Apple", isSelect: false)
    }
    .background(.red)
}
