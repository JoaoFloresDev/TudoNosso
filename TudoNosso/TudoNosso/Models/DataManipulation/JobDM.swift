//
//  OportunityDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class JobDM: GenericsDM {
    let TABLENAME = "oportunities"
    
    func save(job: Job){
        //update an existing item
        if let jobID = job.id{
            db.collection(TABLENAME).document(jobID).setData(job.representation,merge: true)
        }else {//save new
            let doc = db.collection(TABLENAME).document()
            job.id = doc.documentID
            doc.setData(job.representation)
            
        }
    }
    
    func delete(ById id:String){
        db.collection(TABLENAME).document(id).delete()
    }
    
    func listAll(completion: @escaping ([Job]?, Error?) ->()){
        db.collection(TABLENAME).getDocuments { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
        }
    }
    
    func find(ById id:String, completion: @escaping (Job?, Error?) -> Void) {
        db.collection(TABLENAME).document(id).getDocument { (snapshot, err) in
            self.handleSingleDocument(snapshot, err, completion: completion)
        }
    }
    
    func find(inField field: JobFields, withValueEqual value:String, completion: @escaping ([Job]?,Error?) ->()) {
        db.collection(TABLENAME).whereField(field.rawValue, isEqualTo: value).getDocuments() { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
        }
    }
    
    func find(inField field: JobFields, comparation: ComparationKind, withValue value:Any, completion: @escaping ([Job]?,Error?) ->()){
        
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



