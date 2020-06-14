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


enum InfosTypes{
    case restaurante
    case banheiro
    case chuveiro
    case vigia
    case estacionamento
    case lazer
    case wifi
    case combustivel
    case oficina
    case adicionar
    case whatsapp
    
    func text() -> String{
        switch self {
        case .restaurante:
            return "Restaurante"
        case.banheiro:
            return "Banheiro"
        case .chuveiro:
            return "Chuveiro"
        case .vigia:
            return "Vigia"
        case .estacionamento:
            return "Estacionamento"
        case .lazer:
            return "Área de Lazer"
        case .wifi:
            return "WiFi"
        case .combustivel:
            return "Combustível"
        case .oficina:
            return "Oficina"
        case .adicionar:
            return "Adicionar"
        case .whatsapp:
            return "Compartilhar"
        }
    }
    
    func imageName() -> String{
        switch self {
        case .restaurante:
            return "restaurante"
        case.banheiro:
            return "banheiro"
        case .chuveiro:
            return "chuveiro"
        case .vigia:
            return "vigia"
        case .estacionamento:
            return "estacionamento"
        case .lazer:
            return "lazer"
        case .wifi:
            return "wifi"
        case .combustivel:
            return "combustivel"
        case .oficina:
            return "oficina"
        case .adicionar:
            return "adicionar"
        case .whatsapp:
            return "compartilhar"
    }
        
}

}

struct InfoImageView_Previews: PreviewProvider {
    static var previews: some View {
        InfoImageView(listOfInfos: [.restaurante,.banheiro,.chuveiro,.vigia,
                                    .estacionamento,.lazer,.wifi,.combustivel,.oficina,.adicionar,.whatsapp])
    }
}
