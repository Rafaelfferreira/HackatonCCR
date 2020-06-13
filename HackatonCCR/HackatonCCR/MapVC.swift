//
//  MapVC.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 12/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager();
    var currentMarkers: [GMSMarker] = [];
    
    var markerSize: Int = 35;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Google maps sdk: compass
        mapView.settings.compassButton = true;
        
        // Google maps sdk: Users location
        mapView.settings.myLocationButton = true;
        mapView.isMyLocationEnabled = true
        
        // Inicializando o aplicativo na posicao atual do usuario
        getCurrentLocation();
        // Setta o frame para comecar na posicao do usuario
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 15);
        mapView.camera = camera;
        
        //testando adicionar os markers
        addMarkerToMap(latitude: (locationManager.location?.coordinate.latitude)! - 0.003, longitude: (locationManager.location?.coordinate.longitude)!, markerText: "Teste")
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
    
    func addMarkerToMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, markerText: String) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = markerText
        marker.icon = UIImage(named: "MarkerIcon")
        marker.setIconSize(scaledToSize: CGSize(width: markerSize, height: markerSize * 1.25))
        marker.map = mapView
        
        currentMarkers.append(marker)
    }
}

extension MapVC: CLLocationManagerDelegate {
    // MARK: - Metodo chamado sempre que a localizacao do usuario mudar
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}

extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
