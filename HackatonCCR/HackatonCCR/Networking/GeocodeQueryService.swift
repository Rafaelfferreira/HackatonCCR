//
//  GeocodeQuery.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

class GeocodeQueryService {

let defaultSession = URLSession(configuration: .default)
var resultGeocode: Geocode? = nil

    func getGeocodeByAddress(address: String, completion: @escaping (Geocode?, Error?) -> Void){
        if let urlComponents = URLComponents(string: (GeocodeEndpoints.getGeocodeByAddress.rawValue + address + "&key=AIzaSyBW83BvH2RsLsrxlA7bXLsO4Q_YkynHnGk")) {
            // 3
            
            guard let url = urlComponents.url else { return }
            print(url)
            // 4
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("ERRO")
                    completion(nil, error)
                }
                
                if let data = data {
                    do {
                        let queryReturn = try? JSONDecoder().decode(GeocodeAPIReturn.self, from: data)
                        print("dey")
                        let formatedAddress = queryReturn?.results[0].formattedAddress
                        let latitude = queryReturn?.results[0].geometry.location.lat
                        let longitude = queryReturn?.results[0].geometry.location.lng
                        completion(Geocode(formattedAddress: formatedAddress, latitude: latitude, longitude: longitude), nil)
                        
                    }
                }
            }.resume()
        }
    }
}
