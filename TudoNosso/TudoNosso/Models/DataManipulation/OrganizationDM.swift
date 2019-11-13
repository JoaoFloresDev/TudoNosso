//
//  OrganizationDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class OrganizationDM {
    var db = Firestore.firestore()
    let TABLENAME = "ongs"
    
    func save(ong: Organization) {
        let ongId = Base64Converter.encodeStringAsBase64(ong.email)
        db.collection(TABLENAME).document(ongId).setData(ong.representation)
    }
    
    func listAll(completion: @escaping ([Organization]) ->()) {
        
        db.collection(TABLENAME).getDocuments { (snapshot, err) in
            if let err = err{
                print("\(err.localizedDescription)")
            }else {
                if let snapshot = snapshot{
                    let result = snapshot.documents.compactMap { (child) -> Organization? in
                        if let element = Organization(snapshot: child.data() as NSDictionary){
                            return element
                        }
                        return nil
                        
                    }
                    completion(result)
                }else {
                     let emptyList: [Organization] = []
                     completion(emptyList)
                }
            }
        }
    }

    
    func find(ByEmail email:String, completion: @escaping (Organization?) -> Void) {
        let ongId = Base64Converter.encodeStringAsBase64(email)
        
        db.collection(TABLENAME).document(ongId).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            }else {
                if let snapshot = snapshot {
                    let job = Organization(snapshot: snapshot.data()! as NSDictionary)
                    completion(job)
                }else {
                    completion(nil)
                }
            }
        }
    }
}
