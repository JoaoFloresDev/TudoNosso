//
//  ChannelDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 22/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore

class ChannelDM: GenericsDM{
    let tableName = "channels"
    
    
    func listAll(completion: @escaping ([Channel]?,Error?) ->()) {
        
        let user = Base64Converter.encodeStringAsBase64(Local.userMail!)
        db.collection(tableName).whereField("between", arrayContains: user).getDocuments { (snapshot, err) in
            self.handleDocuments(snapshot, err, completion: completion)
        }
    }

    
    func save(channel: Channel, completion: @escaping (Channel) -> ()){
        if channel.id != nil{
            db.collection(tableName).document(channel.id!).setData(channel.representation,merge: true)
   
        }else {//save new
            let doc = db.collection(tableName).document()
            channel.id = doc.documentID
            doc.setData(channel.representation)
        }
        
        completion(channel)
        
    }
}
