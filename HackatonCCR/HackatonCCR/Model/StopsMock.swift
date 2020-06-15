//
//  StopsMock.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

var point1: Stop {
    let addr: String = "Av. Santa Tecla, 1469 - Getúlio Vargas, Bagé - RS, 96412-000, Brazil"
    let city: String = "Bage"
    let coordinates: Coordinates? = Coordinates(latitude: "-54.088410", longitude: "-31.329471")
    let phone: String? = "(53) 3242-4401"
    let ups: Int? = 130
    let categories: [String]? = []
    let reportedPrices: [String]? = []
    let name = "Parada Antônio de Moraes"
    let gplaceID: String? = "ChIJRUGUemF1BpURtDMGb9diK3o"
    let downs: Int? = 12
    let price: Double = 3.739
}
