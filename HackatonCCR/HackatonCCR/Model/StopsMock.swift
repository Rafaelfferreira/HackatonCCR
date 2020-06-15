//
//  StopsMock.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

var point1: Stop {
    let addr: String = "Av. Santa Tecla, 1469 - Getúlio Vargas, Bagé"
    let city: String = "Bage"
    let coordinates: Coordinates? = Coordinates(latitude: -54.088410, longitude: -31.329471)
    let phone: String? = "(53) 3242-4401"
    let ups: Int? = 130
    let categories: [String]? = []
    let reportedPrices: [String]? = []
    let name = "Parada Antônio de Moraes"
    let gplaceID: String? = "ChIJRUGUemF1BpURtDMGb9diK3o"
    let downs: Int? = 12
    let price: Double = 3.739
    
    return Stop(addr: addr, city: city, coordinates: coordinates, phone: phone, ups: ups, categories: categories, reportedPrices: reportedPrices, name: name, gplaceID: gplaceID, downs: downs)
}

var point2: Stop {
    let addr: String = "Av. Jose do Patrocinio, 296 Bagé"
    let city: String = "Bage"
    let coordinates: Coordinates? = Coordinates(latitude: -54.088468, longitude: -31.309874)
    let phone: String? = "(53) 3242-7699"
    let ups: Int? = 130
    let categories: [String]? = []
    let reportedPrices: [String]? = []
    let name = "Parada Jose Abelha"
    let gplaceID: String? = "ChIJRdasUGUemF1BpURtDMGb9diK3o"
    let downs: Int? = 12
    let price: Double = 3.739
    
    return Stop(addr: addr, city: city, coordinates: coordinates, phone: phone, ups: ups, categories: categories, reportedPrices: reportedPrices, name: name, gplaceID: gplaceID, downs: downs)
}
