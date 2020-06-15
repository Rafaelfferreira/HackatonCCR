//
//  Stop.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

struct Stop: Codable {
    let gplaceID: String?
    let downs: Int?
    let addr, city: String?
    let coordinates: Coordinates?
    let phone: String?
    let ups: Int?
    let categories, reportedPrices: [String]?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case gplaceID = "gplace_id"
        case downs, addr, city, coordinates, phone, ups, categories
        case reportedPrices = "reported_prices"
        case name
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}

// MARK: - WelcomeElement
//struct Stop: Codable {
//    let addr: String?
//    let city: String?
//    let coordinates: Coordinates?
//    let phone: String?
//    let ups: Int?
//    let categories: [String]?
//    let reportedPrices: [String]?
//    let name, gplaceID: String?
//    let downs: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case addr, city, coordinates, phone, ups, categories
//        case reportedPrices = "reported_prices"
//        case name
//        case gplaceID = "gplace_id"
//        case downs
//    }
//}
//
////enum Category: String, Codable {
////    case postoDeGasolina = "Posto de Gasolina"
////}
//
////enum City: String, Codable {
////    case itacoatiara = "Itacoatiara"
////    case manacapuru = "Manacapuru"
////    case manaus = "Manaus"
////    case parintins = "Parintins"
////    case rolândia = "Rolândia"
////}
//
//// MARK: - Coordinates
//struct Coordinates: Codable {
//    let latitude, longitude: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case latitude = "_latitude"
//        case longitude = "_longitude"
//    }
//}
