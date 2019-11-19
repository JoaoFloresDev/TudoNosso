//
//  LoginDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 14/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class LoginDM{
    let db = Firestore.firestore()
    let TABLENAME = "login"
    let auth = Auth.auth()
    
    
    func signIn(email: String, pass:String, completion: @escaping ([String : Any]?,Error?) ->()){
        self.auth.signIn(withEmail: email, password: pass) { (fireUser, err) in
            if err != nil {
                completion(nil,err)
            }else{
                self.find(ByEmail: email) { (login, error) in
                    self.handleLogin(login: login, error: error, completion: completion)
                }
                
                //self.find(ByEmail: email, completion: self.handleLogin(completion: completion))
            }
        }
    }
    func signUp(email: String, pass:String, kind:LoginKinds){
        self.auth.createUser(withEmail: email, password: pass) { (fireUser, err) in
            if let err = err {
                
            }else {
                switch kind {
                case .ONG:
                    break
                default:
                    break
                }
            }
        }
    }
    private func handleLogin(completion:@escaping ([String : Any]?,Error?) ->()) -> (Login?, Error?) -> () {
        return { (login, error) -> () in
            self.handleLogin(login: login, error: error, completion: completion)
        }
    }

    private func handleLogin(login: Login?,
                             error: Error?,
                             completion: @escaping ([String : Any]?,Error?) ->()) {
        
        
        if error == nil {
            guard let login = login else {return}
            switch login.kind {
            case .ONG:
                OrganizationDM().find(ById: login.id!) { (ong, err) in
                    if err == nil {
                        completion(ong?.representation,nil)
                    }else {
                        completion(nil,err)
                    }
                }
                break
            case .volunteer:
                VolunteerDM().find(ById: login.id!) { (volunter, err) in
                    if err == nil{
                        completion(volunter?.representation,nil)
                    }else{
                        completion(nil,err)
                    }
                }
            }
            
        }else {
            completion(nil, error)
        }
        
    }
    
    
    
    func find(ByEmail email: String, completion: @escaping (Login? ,Error?) -> ()){
        let userID = Base64Converter.encodeStringAsBase64(email)
        db.collection(TABLENAME).document(userID).getDocument { (snapshot, err) in
            if let err = err {
                completion(nil,err)
            }else {
                if let snapshot = snapshot {
                    if let data = snapshot.data(),
                        let login = Login(id: snapshot.documentID, snapshot: data as NSDictionary){
                        completion(login,nil)
                    }
                }
            }
        }
    }
    
    
}