//
//  LocationViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 03/12/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark, address: String)
}

class LocationViewController: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - PROPERTIES
    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController?
    var selectedPin: MKPlacemark?
    var selectedAddress: String?
    var selectedCoordinates: CLLocationCoordinate2D?
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setLocationManager()
        setLocationSearchTable()
    }
    
    //MARK: - METHODS
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func setLocationSearchTable() {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        setSearchBar()
    }
    
    func setSearchBar() {
        if let searchBar = resultSearchController?.searchBar {
            searchBar.placeholder = "Procure um endereço"
            searchBar.searchTextField.backgroundColor = .white
            searchBar.tintColor = UIColor.black
            searchBar.barTintColor = UIColor(rgb: 0xFF5900, a: 1)
            searchBar.backgroundColor = UIColor(rgb: 0xFF5900, a: 1)
            searchBar.alpha = 1
            searchBar.setBackgroundImage(UIImage(named: "background Search"), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
            searchBar.tintColor = .white
            searchBar.isTranslucent = false
            searchBar.backgroundColor = UIColor(rgb: 0xFF5900, a: 1)
            searchBar.sizeToFit()
        }
        
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
}

//MARK: - MAP VIEW DELEGATE
extension LocationViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan())
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}

//MARK: - HANDLE MAP SEARCH
extension LocationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark, address: String){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        if let searchBar = resultSearchController?.searchBar {
            searchBar.text = address
        }
        
        selectedAddress = address
        selectedCoordinates = placemark.coordinate
    }
}
