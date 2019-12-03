//
//  LocationViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 03/12/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - PROPERTIES
    let locationManager = CLLocationManager()
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        setLocationManager()
    }
    
    //MARK: - METHODS
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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
