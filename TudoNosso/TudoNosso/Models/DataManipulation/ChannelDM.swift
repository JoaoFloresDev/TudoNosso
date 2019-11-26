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

    func find(ById id:String, completion: @escaping (Channel?, Error?) ->()) {
        db.collection(tableName).document(id).getDocument { (snapshot, err) in
            self.handleSingleDocument(snapshot, err, completion: completion)
        }
    }
    
    func addUser(channel: Channel, userID:String, userKind:String) -> Channel {
        channel.between.append(userID)
        channel.betweenKinds.append(userKind)
        self.save(channel: channel, completion: {_ in })
        return channel
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
