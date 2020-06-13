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
import GooglePlaces

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager();
    
    // var associated with markers
    var currentMarkers: [GMSMarker] = [];
    var markerSize: Double = 35;
    
    // var associated with search bar
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    let searchBarColor: UIColor = #colorLiteral(red: 0.9557622145, green: 0.9557622145, blue: 0.9557622145, alpha: 1)
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem?.title = "Test"
        print("passou por aqui")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        mapView.settings.compassButton = true;
        
        // Liberando localizacao do usuario
        mapView.settings.myLocationButton = true;
        mapView.isMyLocationEnabled = true
        
        // Integrando a search bar
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        searchController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
        
        // Inicializando o aplicativo na posicao atual do usuario
        getCurrentLocation();
        // Setta o frame para comecar na posicao do usuario
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 15);
        mapView.camera = camera;
        
        //FIXME: - testando adicionar os markers, colocar em algum lugar que faca sentido depois
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

// MARK: - Integrando a search bar a tela
extension MapVC: GMSAutocompleteResultsViewControllerDelegate {
    //MARK: - Customizando a aparencia da searchbar
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        //FIXME: - Fazer algo com isso depois inferno
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Deu errado, segue o erro: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension MapVC: CLLocationManagerDelegate {
    // MARK: - Metodo chamado sempre que a localizacao do usuario mudar
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}

// MARK: - Extensao para alterar o tamanho default dos markers no mapa
extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
