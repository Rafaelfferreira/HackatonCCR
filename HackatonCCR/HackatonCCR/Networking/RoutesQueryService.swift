//
//  RoutesQueryService.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

// Query Exemplo
//https://maps.googleapis.com/maps/api/directions/json?
//origin=Toronto&destination=Montreal
//&key=YOUR_API_KEY

class RoutesQueryService {
    func getRouteByCoordinates(originLat: Double, originLnt: Double, destinationLat: Double, destinationLtn: Double, completion: @escaping (Geocode?, Error?) -> Void){
        let urlPath: String = "\(originLat),\(originLnt)&destination=\(destinationLat),\(destinationLtn)" + "&key=AIzaSyBW83BvH2RsLsrxlA7bXLsO4Q_YkynHnGk"
        let requestUrl: String = RoutesEndpoints.getRouteBetween2Points.rawValue + urlPath
            if let urlComponents = URLComponents(string: requestUrl) {
                
                guard let url = urlComponents.url else { return }
                print(url)
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if error != nil {
                        print("ERRO")
                        completion(nil, error)
                    }
                    
                    if let data = data {
                        do {
                            // JSONSerialization to test the API response during debug
                            let APIResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                            
                            do {
                                print(APIResponse)
                                
//                                let queryReturn = try JSONDecoder().decode(GeocodeQueryResult.self, from: data)
//                                let formatedAddress = queryReturn.results?[0].formattedAddress
//                                let latitude = queryReturn.results?[0].geometry?.location?.lat
//                                let longitude = queryReturn.results?[0].geometry?.location?.lng
//                                completion(Geocode(formattedAddress: formatedAddress, latitude: latitude, longitude: longitude), nil)
                            }  catch { return }
                            
                            
                            
                            
                        }
                    }
                }.resume()
            }
        }
}

enum RoutesEndpoints: String {
    case getRouteBetween2Points = "https://maps.googleapis.com/maps/api/directions/json?origin="
}

