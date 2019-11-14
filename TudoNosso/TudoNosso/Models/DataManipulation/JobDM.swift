//
//  OportunityDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class JobDM{
    var db = Firestore.firestore()
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
            if let err = err{
                print("\(err.localizedDescription)")
                completion(nil,err)
            }else {
                if let snapshot = snapshot{
                    let result = snapshot.documents.compactMap { (child) -> Job? in
                        if let element = Job(snapshot: child.data() as NSDictionary){
                            return element
                        }
                        return nil
                    }
                    completion(result,nil)
                }else {
                     completion(nil,nil)
                }   
            }
        }
    }
    
    func find(ById id:String, completion: @escaping (Job?, Error?) -> Void) {
        db.collection(TABLENAME).document(id).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                completion(nil, err)
            }else {
                if let snapshot = snapshot {
                    let job = Job(snapshot: snapshot.data()! as NSDictionary)
                    completion(job, nil)
                }else {
                    completion(nil, nil)
                }
            }
        }
    }
    
    func find(inField field: JobFields, withValueEqual value:String, completion: @escaping ([Job]?,Error?) ->()) {
        db.collection(TABLENAME).whereField(field.rawValue, isEqualTo: value).getDocuments() { (snapshot, err) in
               if let err = err {
                   print(err.localizedDescription)
                completion(nil,err)
               }else {
                if let snapshot = snapshot {
                   let result = snapshot.documents.compactMap { (child) -> Job? in
                        if let element = Job(snapshot: child.data() as NSDictionary){
                            return element
                        }
                        return nil
                    }
                    completion(result, nil)
               }else {
                    completion(nil, nil)
               }
           }
       }
    }
}


