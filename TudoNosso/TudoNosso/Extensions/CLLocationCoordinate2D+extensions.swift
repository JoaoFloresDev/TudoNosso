//
//  CLLocationCoordinate2D+extensions.swift
//  WhatsappClone
//
//  Created by Bruno Cardoso Ambrosio on 06/11/19.
//  Copyright © 2019 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func toDictionary() -> Dictionary<String,Any> {
        let dic: Dictionary<String,Any> = [
            "latitude": self.latitude,
            "longitude": self.longitude
        ]
        
        return dic
    }
    
    static func fromDictionary(dictionary: Dictionary<String,Any>) -> CLLocationCoordinate2D {

        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
        
        return location
    }
}
