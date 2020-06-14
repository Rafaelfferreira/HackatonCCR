//
//  Geocode.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

struct Geocode {
    let formattedAddress: String?
    let latitude: Double?
    let longitude: Double?
}

enum GeocodeEndpoints: String {
    case getGeocodeByAddress = "https://maps.googleapis.com/maps/api/geocode/json?address="
}


// MARK: - API Return
struct GeocodeQueryResult: Codable {
    let status: String?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let addressComponents: [AddressComponent]?
    let formattedAddress: String?
    let geometry: Geometry?
    let partialMatch: Bool?
    let placeID: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case geometry
        case partialMatch = "partial_match"
        case placeID = "place_id"
        case types
    }
}

// MARK: - AddressComponent
struct AddressComponent: Codable {
    let longName, shortName: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let bounds: Bounds?
    let location: Location?
    let locationType: String?
    let viewport: Bounds?

    enum CodingKeys: String, CodingKey {
        case bounds, location
        case locationType = "location_type"
        case viewport
    }
}

// MARK: - Bounds
struct Bounds: Codable {
    let northeast, southwest: Location?
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double?
}

// MARK: - PlusCode
struct PlusCode: Codable {
    let compoundCode, globalCode: String?

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}
