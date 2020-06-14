//
//  InfoImageView.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import SwiftUI

struct InfoImageView: View {
    var listOfInfos: [InfosTypes]
    var body: some View {
        VStack{
            HStack{
                ForEach(0..<listOfInfos.count) { i in
                    if(i<3){
                        ImageWithText(info: self.listOfInfos[i])
                    }
                }
            }
            HStack{
                ForEach(0..<listOfInfos.count) { i in
                    if(i>2 && i<6){
                        ImageWithText(info: self.listOfInfos[i])
                    }
                }
            }
            HStack{
                ForEach(0..<listOfInfos.count) { i in
                    if(i>5 && i<9){
                        ImageWithText(info: self.listOfInfos[i])
                    }
                }
            }
            HStack{
                ForEach(0..<listOfInfos.count) { i in
                    if(i>8 && i<12){
                        ImageWithText(info: self.listOfInfos[i])
                    }
                }
            }
        }.padding(.bottom,50)
    }
}


struct InfoImageView_Previews: PreviewProvider {
    static var previews: some View {
        InfoImageView(listOfInfos: [.restaurante,.banheiro,.chuveiro,.vigia,
                                    .estacionamento,.lazer,.wifi,.combustivel,.oficina,.adicionar,.whatsapp])
    }
}
