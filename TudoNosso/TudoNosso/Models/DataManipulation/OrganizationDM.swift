//
//  OrganizationDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class OrganizationDM: GenericsDM {

    let TABLENAME = "ongs"
    
    func save(ong: Organization) {
        let ongId = Base64Converter.encodeStringAsBase64(ong.email)
        db.collection(TABLENAME).document(ongId).setData(ong.representation)
    }
    
    func listAll(completion: @escaping ([Organization]?, Error?) ->()) {
        db.collection(TABLENAME).getDocuments { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
        }
    }

    
    func find(ByEmail email:String, completion: @escaping (Organization?,Error?) -> Void) {
        let ongId = Base64Converter.encodeStringAsBase64(email)
        self.find(ById: ongId, completion: completion)
    }
    
    func find(ById id:String, completion: @escaping (Organization?,Error?) -> Void) {
        db.collection(TABLENAME).document(id).getDocument { (snapshot, err) in
            self.handleSingleDocument(snapshot, err, completion: completion)
        }
    }
    
    func find(inField field: OrganizationFields, withValueEqual value:String, completion: @escaping ([Organization]?,Error?) ->()) {
        db.collection(TABLENAME).whereField(field.rawValue, isEqualTo: value).getDocuments() { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
       }
    }
    
    
    func find(inField field: OrganizationFields, comparation: ComparationKind, withValue value:Any, completion: @escaping ([Job]?,Error?) ->()){
        
        switch comparation {
        case .equal:
            db.collection(TABLENAME).whereField(field.rawValue, isEqualTo: value).getDocuments { (snapshot, error) in
                self.handleDocuments(snapshot, error, completion: completion)
            }
            break
        case .lessThan:
            db.collection(TABLENAME).whereField(field.rawValue, isLessThan: value).getDocuments { (snapshot, error) in
                self.handleDocuments(snapshot, error, completion: completion)
            }
            break
        case .lessThanOrEqual:
            db.collection(TABLENAME).whereField(field.rawValue, isLessThanOrEqualTo: value).getDocuments { (snapshot, error) in
                self.handleDocuments(snapshot, error, completion: completion)
            }
            break
        case .greaterThan:
            db.collection(TABLENAME).whereField(field.rawValue, isGreaterThan: value).getDocuments { (snapshot, error) in
                self.handleDocuments(snapshot, error, completion: completion)
            }
            break
        case .greaterThanOrEqual:
            db.collection(TABLENAME).whereField(field.rawValue, isGreaterThanOrEqualTo: value).getDocuments { (snapshot, error) in
                self.handleDocuments(snapshot, error, completion: completion)
            }
            break
        case .arrayContains:
            db.collection(TABLENAME).whereField(field.rawValue, arrayContains: value).getDocuments { (snapshot, error) in
                self.handleDocuments(snapshot, error, completion: completion)
            }
            break
        }
    }
}
