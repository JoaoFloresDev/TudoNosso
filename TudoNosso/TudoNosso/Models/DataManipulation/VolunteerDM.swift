//
//  VolunteerDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation


class VolunteerDM: GenericsDM {
    let TABLENAME  = "volunteers"
    
    func save(volunteer: Volunteer){
        let volunteerID = Base64Converter.encodeStringAsBase64(volunteer.email)
        db.collection(TABLENAME).document(volunteerID).setData(volunteer.representation)
    }
    
    func delete(ById id:String){
        db.collection(TABLENAME).document(id).delete()
    }
    
    func listAll(completion:@escaping ([Volunteer]?,Error?) -> ()){
        db.collection(TABLENAME).getDocuments { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
        }
    }
    
    func find(ById id:String, completion:@escaping (Volunteer?,Error?) -> ()){
        db.collection(TABLENAME).document(id).getDocument { (snapshot, err) in
            self.handleSingleDocument(snapshot, err, completion: completion)
        }
    }
    
    func find(ByEmail email: String, completion:@escaping (Volunteer?,Error?) -> ()){
        let volunteerID = Base64Converter.encodeStringAsBase64(email)
        self.find(ById: volunteerID, completion: completion)
    }
    
    func find(inField field: VolunteerFields, withValueEqual value:String, completion: @escaping ([Volunteer]?,Error?) ->()) {
        db.collection(TABLENAME).whereField(field.rawValue, isEqualTo: value).getDocuments() { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
        }
    }
}
