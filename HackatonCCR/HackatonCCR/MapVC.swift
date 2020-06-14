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
    
    //FIXME: - Teste networking
    let geocodeQueryService = GeocodeQueryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //FIXME: - Testando o networking
//        self.geocodeQueryService.getGeocodeByAddress(address: "Av%20Paulista%201811Av%20Paulista%201811Av%20Paulista%201811Av%20Paulista%201811Av%20Paulista%201811Av%20Paulista%201811Av%20Paulista%201811Av%20Paulista%201811", completion: { (geocode, error) in
//            if error == nil{
//                self.addMarkerToMap(latitude: geocode!.latitude!, longitude: geocode!.longitude!, markerText: "Destino Selecionado")
//                let camera = GMSCameraPosition.camera(withLatitude: (geocode!.latitude)!, longitude: (geocode!.longitude)!, zoom: 15);
//                self.mapView.camera = camera;
//            }
//        })
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
        if place.formattedAddress != nil {
            
            var urlFormattedAddres = place.formattedAddress!.replacingOccurrences(of: " ", with: "%20")
            
            // FIXME: - Fazer esse tratamento numa extension
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ã", with: "a")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "á", with: "a")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "à", with: "a")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "é", with: "e")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ê", with: "e")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ó", with: "o")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "õ", with: "o")
            urlFormattedAddres = urlFormattedAddres.replacingOccurrences(of: "ô", with: "o")
            self.geocodeQueryService.getGeocodeByAddress(address: urlFormattedAddres, completion: { (geocode, error) in
                if error == nil{
                    self.addMarkerToMap(latitude: geocode!.latitude!, longitude: geocode!.longitude!, markerText: "Destino Selecionado")
                    let camera = GMSCameraPosition.camera(withLatitude: (geocode!.latitude)!, longitude: (geocode!.longitude)!, zoom: 15);
                    self.mapView.camera = camera;
                }
            })
        }
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
