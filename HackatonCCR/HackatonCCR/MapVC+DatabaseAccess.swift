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
    func getStopsNearRoute() {//route: DirectionRoute) {
        db.collection("places").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
