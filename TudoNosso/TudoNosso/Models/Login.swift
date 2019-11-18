//
//  User.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 14/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Login {
    var id: String?
    var email: String
    var kind: String
    
    
    init(email: String, kind: String){
        self.email = email
        self.kind = kind
    }
    
    init?(id:String,snapshot: NSDictionary) {
        
        guard
            let email: String = Self.snapshotField(snapshot, .email),
            let kind: String = Self.snapshotField(snapshot, .kind)
            else {
                return nil
        }
        self.id = id
        self.email = email
        self.kind = kind
        
    }
   
}

extension Login: DatabaseRepresentation {
    
    
    var representation: [String : Any] {
        let rep: [LoginFields : Any] = [
            .kind: kind,
            .email: email
        ]
        return Dictionary(uniqueKeysWithValues: rep.map { key, value in
            (key.rawValue, value) })
    }
    
    fileprivate static func snapshotField<T>(_ snapshot: NSDictionary,_ field: LoginFields) -> T?{
        return snapshot[field.rawValue] as? T
    }
}

enum LoginFields: String {
    case email = "email"
    case kind = "kind"
    
}
