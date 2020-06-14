//
//  MapVC+MapFunctions.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

//MARK: - Functions related to the control of the map
extension MapVC {
    
    func addMarkerToMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, markerText: String) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = markerText
        marker.icon = UIImage(named: "MarkerIcon")
        marker.setIconSize(scaledToSize: CGSize(width: markerSize, height: markerSize * 1.25))
        marker.map = mapView
        
        currentMarkers.append(marker)
    }
    
    func getCurrentLocation() {
        // Pedindo autorizacao para sempre utilizar a localizacao, incluindo em background
        self.locationManager.requestAlwaysAuthorization();
        self.locationManager.requestWhenInUseAuthorization();
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            locationManager.startUpdatingLocation();
        }
    }
      
    //FIXME: - Terminar de pegar os pontos da rota
    func getRoutePointsCoordinates(APIroute: DirectionRoute)
    {
        let route = APIroute.routes.first
        let routeInfo = route?.legs?.first
        for step in routeInfo?.steps ?? [] {
            print(step.endLocation)
        }
    }
    
    func drawRouteOnMap(APIroute: DirectionRoute) {
        for route in APIroute.routes {
            let routeOverviewPolyline = route.overviewPolyline
            let points = routeOverviewPolyline?.points ?? ""
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            // propriedades da renderizacao da linha
            polyline.strokeWidth = 4
            polyline.strokeColor = UIColor.blue
            polyline.map = self.mapView
        }
    }
    
    func formatAddressToURL(rawAddress: String) -> String {
        var urlFormattedAddres = rawAddress.replacingOccurrences(of: " ", with: "%20")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ã", with: "a")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "á", with: "a")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "à", with: "a")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "é", with: "e")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ê", with: "e")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ó", with: "o")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "õ", with: "o")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ô", with: "o")
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "í", with: "i")
        
        return urlFormattedAddres
    }
}
