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
import Firebase

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // var associated with the card
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController: CardViewController!
    var visualEffectView: UIVisualEffectView!
    
    var cardHeight: CGFloat = 405
    var cardHandleAreaHeight: CGFloat = 106
    
    var cardVisible = false
    
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    // var associated with locations
    let locationManager = CLLocationManager();
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    var destinationLatitude: Double?
    var destinationLongitude: Double?
    var destinationUF: String?
    var rectangle = GMSPolyline()
    
    //database Access
    let db = Firestore.firestore()
    
    // var associated with markers
    var currentMarkers: [GMSMarker] = [];
    var markerSize: Double = 35;
    
    // var associated with search bar
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    // Networking
    let geocodeQueryService = GeocodeQueryService()
    let routesQueryService = RoutesQueryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIXME: - Tirar isso daqui
        CollectAllStopsFromState(state: "RS", completion: { (stops, error) in
            print("olar")
        })
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
        
        userLatitude = (locationManager.location?.coordinate.latitude ?? 0.0) as Double
        userLongitude = (locationManager.location?.coordinate.longitude ?? 0.0) as Double
        
        getPlacesInformations()
    }
}

// MARK: - Integrando a search bar a tela
extension MapVC: GMSAutocompleteResultsViewControllerDelegate {
    //MARK: - Customizando a aparencia da searchbar
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        if place.formattedAddress != nil {
            
            var urlFormattedAddres = formatAddressToURL(rawAddress: place.formattedAddress!)
            self.geocodeQueryService.getGeocodeByAddress(address: urlFormattedAddres, completion: { (geocode, error) in
                if error == nil{
                    self.addMarkerToMap(latitude: geocode!.latitude!, longitude: geocode!.longitude!, markerText: "Destino Selecionado")
                    self.destinationLatitude = geocode!.latitude
                    self.destinationLongitude = geocode!.longitude
                    self.destinationUF = geocode!.UF
                    self.routesQueryService.getRouteByCoordinates(originLat: self.userLatitude, originLnt: self.userLongitude, destinationLat: self.destinationLatitude!, destinationLtn: self.destinationLongitude!, completion: { (route, error) in
                        if error == nil {
                            self.drawRouteOnMap(APIroute: route!)
                            self.getRoutePointsCoordinates(APIroute: route!)
                        }
                        else
                        {
                            print("erro na query da rota: ", error)
                        }
                    })
                    
                    // set the camera to the point of interest
                    let camera = GMSCameraPosition.camera(withLatitude: (geocode!.latitude)!, longitude: (geocode!.longitude)!, zoom: 15);
                    self.mapView.camera = camera;
                }
                else
                {
                    print("Erro na query do geocode: ", error)
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
