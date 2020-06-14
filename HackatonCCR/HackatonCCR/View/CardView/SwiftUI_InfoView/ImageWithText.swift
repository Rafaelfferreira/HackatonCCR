//
//  ImageWithText.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import SwiftUI
struct ImageCircle: View {
    var image: Image
    var size: CGFloat
    var body: some View {
        image
            .resizable()
            .frame(width: size, height: size, alignment: .center)
            .clipShape(Circle())
    }
}
struct ImageWithText: View {
    var info: InfosTypes
    var body: some View {
        VStack{
            ImageCircle(image: Image(info.imageName()), size: 55).padding(.bottom,10)
            Text(info.text())
            .frame(width: 123)
            .lineLimit(2)
        }
      
        
        
    }
}

struct ImageWithText_Previews: PreviewProvider {
    static var previews: some View {
        ImageWithText(info: .combustivel)
    }
}
