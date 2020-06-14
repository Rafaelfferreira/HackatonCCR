//
//  InfoTypes.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

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
