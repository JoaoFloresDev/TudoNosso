//
//  GenericDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class GenericsDM {
    var db = Firestore.firestore()
    
    
    func handleDocuments<T: DictionaryInterpreter>(_ querySnapshot: QuerySnapshot?, _ error: Error?, completion:@escaping ([T]?,Error?) -> ())  {
        if let err = error {
            completion(nil,err)
        }else if let snapshot = querySnapshot {
            let result = snapshot.documents.compactMap { (child) -> T? in
                if let interpreted = T.interpret(data: child.data() as NSDictionary) {
                    return interpreted
                }
                return nil
            }
            completion(result,nil)
        }else {
            completion(nil,nil)
        }
    }
    
    func handleSingleDocument<T: DictionaryInterpreter>(_ snapshot:DocumentSnapshot?, _ error: Error?, completion:@escaping (T?,Error?) -> ()) {
        if let err = error{
            completion(nil,err)
        }else if
            let snapshot = snapshot,
            let interpreted = T.interpret(data: snapshot.data()! as NSDictionary){
                completion(interpreted,nil)
        }else {
            completion(nil,nil)
            
        }
    }
}

enum ComparationKind{
    case equal
    case lessThan
    case lessThanOrEqual
    case greaterThan
    case greaterThanOrEqual
    case arrayContains
}
