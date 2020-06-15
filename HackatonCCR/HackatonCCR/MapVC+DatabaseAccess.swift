//
//  MapVC+DatabaseAccess.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation
import Firebase

extension MapVC {
    //FIXME: - Currently returning all stops on the database
    func CollectAllStopsFromState(state: String, completion: @escaping ([Stop]?, Error?) -> Void) {//route: DirectionRoute) {
        var returningStops: [Stop] = []
        db.collection("placesOpt").getDocuments { (querySnapshot, error) in
            self.db.collection("placesOpt").document(state).collection(state).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
//                let primeiroTeste = JSONDecoder().decode(Stop, from: (querySnapshot?.documents[0].data())!)
                    print("Chegou")
                    for document in querySnapshot!.documents {
                        let address = document.data()["addr"] as? String
                        let city = document.data()["city"] as? String
                        let coordinates = document.data()["coordinates"] as? GeoPoint
                        let phoneNumber = document.data()["phone"] as? String
                        let ups = document.data()["ups"] as? Int
                        let categorias = document.data()["categories"] as? [String]
                        let reportedPrices = document.data()["reported_prices"] as? [String]
                        let name = document.data()["name"] as? String
                        let gplaceID = document.data()["gplace_id"] as? String
                        let downs = document.data()["name"] as? Int
                        
                        let newStop = Stop(addr: address, city: city, coordinates: Coordinates(latitude: coordinates?.latitude, longitude: coordinates?.longitude), phone: phoneNumber, ups: ups, categories: categorias, reportedPrices: reportedPrices, name: name, gplaceID: gplaceID, downs: downs)
                        
                        returningStops.append(newStop)
                    }
                    
                    completion(returningStops, error)
                }
            }
        }
    }
}
