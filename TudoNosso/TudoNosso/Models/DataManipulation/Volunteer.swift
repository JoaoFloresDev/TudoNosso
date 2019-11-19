//
//  Volunteer.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation

class Volunteer{
    var name: String
    var email: String
    var description: String?
    
    
    init (name: String, email:String, description: String) {
        self.name = name
        self.email = email
        self.description = description
    }
    
    init(name: String, email: String){
        self.name = name
        self.email = email
    }
    
    init?(snapshot:NSDictionary){
        guard
            let name: String = Self.snapshotField(snapshot,.name),
            let email: String = Self.snapshotField(snapshot,.email)
            else {return nil}
        self.name = name
        self.email = email
        self.description = Self.snapshotField(snapshot,.description)
    }
    
    
}

extension Volunteer: DatabaseRepresentation{
    var representation: [String : Any] {
        var rep:[VolunteerFields: Any] = [
            .name: name,
            .email: email
        ]
        if let desc = description{
            rep[.description] = desc
        }
        
        
        return Dictionary(uniqueKeysWithValues: rep.map{ key,value in
            (key.rawValue,value)
        })
    }
    
    fileprivate static func snapshotField<T>(_ snapshot:NSDictionary,_ field: VolunteerFields) ->T?{
        return snapshot[field.rawValue] as? T
    }
}

extension Volunteer: DictionaryInterpreter{
    static func interpret(data: NSDictionary) -> Self? {
        return Volunteer(snapshot: data) as? Self
    }
}

enum VolunteerFields: String, Hashable {
    case name = "volunteerName"
    case email
    case description = "desc"
}
