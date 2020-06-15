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
    
    func addMarkerToMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, markerText: String, map: GMSMapView) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = markerText
        marker.icon = UIImage(named: "MarkerIcon")
        marker.setIconSize(scaledToSize: CGSize(width: markerSize, height: markerSize * 1.25))
        marker.map = map
        
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
    func getRoutePointsCoordinates(APIroute: DirectionRoute, state: String)
    {
        let route = APIroute.routes.first
        let routeInfo = route?.legs?.first
        let steps = routeInfo?.steps //each point in which the user turns
        let amountOfSteps = Double(steps?.count ?? 0)
        let ratioSteps: Double = floor(amountOfSteps/5)
        let amountOfStepsAdvanced: Int = Int(ratioSteps)
        
        var currentStep = 0
        while(currentStep < Int(amountOfSteps)) {
            stopsNearLocation(latitude: (steps?[currentStep].endLocation?.lat)!, longitude: (steps?[currentStep].endLocation?.lng)!, UF: state, amount: 3, completion: { (stops, error) in
                print("RETORNOU AS PARADASS")
                for stop in stops! {
                    // FIXME: - O DB ESTA COM LATITUDE E LONGITUDE TROCADO!
                    self.addMarkerToMap(latitude: (stop.coordinates?.longitude)!, longitude: (stop.coordinates?.latitude)!, markerText: stop.name!, map: self.mapView)
                }
                
            })
            
            currentStep += amountOfStepsAdvanced
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
        urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ú", with: "u")
        
        return urlFormattedAddres
    }
    
    func showMarkersForRoute(originUF: String, destinationUF: String) {
        CollectAllStopsFromState(state: originUF) { (stops, error) in
            if error == nil {
                //O banco esta ao contrario!
                self.addMarkerToMap(latitude: (stops![0].coordinates?.longitude)!, longitude: (stops![0].coordinates?.latitude)!, markerText: "TESTE", map: self.mapView)
//                for stop in stops! {
//                    self.addMarkerToMap(latitude: (stop.coordinates?.latitude)!, longitude: (stop.coordinates?.latitude)!, markerText: stop.name!)
//                }
//                //Se forem diferentes precisa fazer mais uma chamada
//                if originUF != destinationUF {
//                    self.CollectAllStopsFromState(state: destinationUF) { (innerStops, innerError) in
//                        if innerError == nil {
//                            for stop in innerStops! {
//                                self.addMarkerToMap(latitude: (stop.coordinates?.latitude)!, longitude: (stop.coordinates?.latitude)!, markerText: stop.name!)
//                            }
//                        } else {
//                            print("Erro interno: \(innerError)")
//                        }
//                    }
//                }
            } else {
                print("Erro: \(error)")
            }
        }
    }
}
