//
//  Onganization.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 06/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import CoreLocation

class Organization {

    var name: String
    var address: CLLocationCoordinate2D
    var email: String
    var desc: String?
    var phone: String?
    var site: String?
    var facebook: String?
    
    init (name: String, address: CLLocationCoordinate2D, email: String){
           
           self.name = name
           self.address = address
           self.email = email
    }
    
    init (name: String, address: CLLocationCoordinate2D, desc: String, email: String, phone: String, site: String, facebook: String){
        
        self.name = name
        self.address = address
        self.desc = desc
        self.email = email
        self.phone = phone
        self.site = site
        self.facebook = facebook
    }
    
    init?(snapshot: NSDictionary) {
           guard
            let name = snapshot["name"] as? String,
            let email = snapshot["email"] as? String,
            let dictAddress = snapshot["address"] as? Dictionary<String, Any>
            else {
                   return nil
           }
            
        self.name = name
        self.address = CLLocationCoordinate2D.fromDictionary(dictionary: dictAddress)
        self.email = email
        self.desc = snapshot["desc"] as? String
        self.phone = snapshot["phone"] as? String
        self.site = snapshot["site"] as? String
        self.facebook = snapshot["facebook"] as? String
    }
}

extension Organization: DatabaseRepresentation {
  
  var representation: [String : Any] {
    var rep: [String : Any] = [
      "name": name,
      "address": address.toDictionary(),
      "email": email
    ]
    if let desc = self.desc {
      rep["desc"] = desc
    }
    if let phone = self.phone {
      rep["phone"] = phone
    }
    if let site = self.site {
      rep["site"] = site
    }
    if let facebook = self.facebook {
      rep["facebook"] = facebook
    }
    return rep
  }
  
}

