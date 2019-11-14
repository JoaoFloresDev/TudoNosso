//
//  Oportunity.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 06/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseFirestore.FIRGeoPoint


class Job {
    
    var id: String?
    var title: String
    var desc: String?
    var category: CategoryEnum
    var vacancyType: String
    var vacancyNumber: Int
    var organizationID: String
    var localization: CLLocationCoordinate2D
    var status:Bool
    
    init( title: String, category: CategoryEnum, vacancyType: String, vacancyNumber: Int, organizationID: String, localization: CLLocationCoordinate2D,status:Bool) {
        self.title = title
        self.category = category
        self.vacancyType = vacancyType
        self.vacancyNumber = vacancyNumber
        self.organizationID = organizationID
        self.localization = localization
        self.status = status
    }
    
    init(id: String, title: String, desc: String, category: CategoryEnum, vacancyType: String, vacancyNumber: Int, organizationID: String, localization: CLLocationCoordinate2D, status: Bool) {
        self.id = id
        self.title = title
        self.desc = desc
        self.category = category
        self.vacancyType = vacancyType
        self.vacancyNumber = vacancyNumber
        self.organizationID = organizationID
        self.localization = localization
        self.status = status
    }
    
    init?(snapshot: NSDictionary) {
        guard
            let id = snapshot["id"] as? String,
            let title = snapshot["title"] as? String,
            let category = snapshot["category"] as? String,
            let vacancyType = snapshot["vacancyType"] as? String,
            let vacancyNumber = snapshot["vacancyNumber"] as? Int,
            let organizationID = snapshot["organizationID"] as? String,
            let location = snapshot["localization"] as? GeoPoint,
            let status = snapshot["status"] as? Bool
            else {
                return nil
        }
        guard let categoryEnum = CategoryEnum.init(rawValue: category) else {
            return nil
        }
        self.category = categoryEnum
        self.id = id
        self.title = title
        self.desc = snapshot["desc"] as? String
        self.vacancyType = vacancyType
        self.vacancyNumber = vacancyNumber
        self.organizationID = organizationID
        self.localization = CLLocationCoordinate2D.fromGeoPoint(geoPoint: location)
        self.status = status
        
    }
    
    
}

extension Job: DatabaseRepresentation {
  
  var representation: [String : Any] {
    var rep: [String : Any] = [
        "id": id,
        "title": title,
        "category": category.description(),
        "vacancyType": vacancyType,
        "vacancyNumber": vacancyNumber,
        "organizationID": organizationID,
        "localization": localization.toGeoPoint(),
        "status": status
    ]
    
    if let desc = self.desc{
        rep["desc"] = desc
    }
    return rep
  }
  
}

enum JobFields: String {
    case id = "id"
    case title = "title"
    case description = "desc"
    case category = "category"
    case vacancyType = "vacancyType"
    case vacancyNumber = "vacancyNumber"
    case organizationID = "organizationID"
    case localization = "localization"
    case status = "status"
    
}
