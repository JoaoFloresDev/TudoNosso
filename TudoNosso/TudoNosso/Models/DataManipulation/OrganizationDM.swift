//
//  OrganizationDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseDatabase

class OrganizationDM {
    var databaseRef: DatabaseReference!
    let TABLENAME = "ongs"
    
    init() {
        databaseRef = Database.database().reference().child(TABLENAME)
    }
    
    func save(ong: Organization) {
        let ongId = Base64Converter.encodeStringAsBase64(ong.email)
        databaseRef.child(ongId).setValue(ong.representation)
    }
    
    func listAll(completion: @escaping ([Organization]) ->()) {
        
        databaseRef.queryOrdered(byChild: "name").observe(.value) { snapshot in
            let result = snapshot.children.compactMap { (child) -> Organization? in
                if let snap = child as? DataSnapshot,
                    let data = snap.value as? NSDictionary,
                    let element = Organization(snapshot: data) {
                    return element
                } else {
                    return nil
                }
            }
            completion(result)
        }
    }
    
    func find(ByEmail email:String, completion: @escaping (Organization?) -> Void) {
        let ongId = Base64Converter.encodeStringAsBase64(email)
        
        let ongData = databaseRef.child(ongId)
        var ong: Organization?
        ongData.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                ong = Organization(snapshot: data)
                completion(ong)
            } else {
                completion(nil)
            }
        }
    }
}
