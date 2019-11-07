//
//  OportunityDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseDatabase

class OportunityDM{
    var databaseRef: DatabaseReference!
    let TABLENAME = "oportunities"
    
    init() {
        databaseRef = Database.database().reference().child(TABLENAME)
    }
    
    func save(oportunity: Oportunity){
        //update an existing item
        if let oportunityID = oportunity.id{
            databaseRef.child(oportunityID).setValue(oportunity.representation)
            
        }else {//save new
            let ref = databaseRef.childByAutoId()
            if let key = ref.key{
                oportunity.id = key
                ref.setValue(oportunity.representation)
            }
        }
    }
    
    func delete(ById id:String){
        databaseRef.child(id).removeValue()
    }
    
    func listAll(completion: @escaping ([Oportunity]) ->()){
        
        databaseRef.observe(.value) { (snapshot) in
          let result = snapshot.children.compactMap { (child) -> Oportunity? in
            
                if  let snap = child as? DataSnapshot,
                    let data = snap.value as? NSDictionary,
                    let element = Oportunity(snapshot: data){
                    return element
                }else{
                    return nil
                }
            }
            completion(result)
        }
    }
    
    func find(ById id:String, completion: @escaping (Oportunity?) -> Void) {
        let oportunityData = databaseRef.child(id)
        var oportunity: Oportunity?
        oportunityData.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                oportunity = Oportunity(snapshot: data)
                completion(oportunity)
            } else {
                completion(nil)
            }
        }
    }
}
