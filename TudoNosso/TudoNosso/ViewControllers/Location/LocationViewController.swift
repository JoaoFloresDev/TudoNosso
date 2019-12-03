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
    
    //MARK: - PROPERTIES
    let locationManager = CLLocationManager()
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

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

//MARK: - LOCATION MANAGER DELEGATE
extension LocationViewController: CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: \(location)")
        }
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}
