//
//  Oportunity.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 06/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import CoreLocation


class Oportunity {
    
    var id: String
    var title: String
    var desc: String?
    var category: CategoryEnum
    var vacancyType: String
    var vacancyNumber: Int
    var organizationID: String
    var localization: CLLocationCoordinate2D
    
    init(id: String, title: String, category: CategoryEnum, vacancyType: String, vacancyNumber: Int, organizationID: String, localization: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.category = category
        self.vacancyType = vacancyType
        self.vacancyNumber = vacancyNumber
        self.organizationID = organizationID
        self.localization = localization
    }
    
    init(id: String, title: String, desc: String, category: CategoryEnum, vacancyType: String, vacancyNumber: Int, organizationID: String, localization: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.desc = desc
        self.category = category
        self.vacancyType = vacancyType
        self.vacancyNumber = vacancyNumber
        self.organizationID = organizationID
        self.localization = localization
    }
    
    init?(snapshot: NSDictionary) {
        guard
            let id = snapshot["id"] as? String,
            let title = snapshot["title"] as? String,
            let category = snapshot["category"] as? CategoryEnum,
            let vacancyType = snapshot["vacancyType"] as? String,
            let vacancyNumber = snapshot["vacancyNumber"] as? Int,
            let organizationID = snapshot["organizationID"] as? String,
            let dictLocalization = snapshot["localization"] as? Dictionary<String, Any>
            else {
                return nil
        }
        self.id = id
        self.title = title
        self.desc = snapshot["desc"] as? String
        self.category = category
        self.vacancyType = vacancyType
        self.vacancyNumber = vacancyNumber
        self.organizationID = organizationID
        self.localization = CLLocationCoordinate2D.fromDictionary(dictionary: dictLocalization)
        
    }
    
    
}

extension Oportunity: DatabaseRepresentation {
  
  var representation: [String : Any] {
    var rep: [String : Any] = [
        "id": id,
        "title": title,
        "category": category,
        "vacancyType": vacancyType,
        "vacancyNumber": vacancyNumber,
        "organizationID": organizationID,
        "localization": localization.toDictionary()
    ]
    
    if let desc = self.desc{
        rep["desc"] = desc
    }
    return rep
  }
  
}
