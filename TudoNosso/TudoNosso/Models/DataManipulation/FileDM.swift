//
//  FileDM.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 19/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation
import FirebaseStorage
class FileDM {
    let storage = Storage.storage()
    
    func recoverProfileImage(profilePic:String, completion: @escaping (UIImage?,Error?) ->()) {
          
          storage.reference().child("profilePic/\(profilePic)").downloadURL { (url, err) in
              if let err = err {
                  print(err.localizedDescription)
                  completion(nil,err)
              }else {
                  do {
                      let image = try UIImage(data: Data(contentsOf: url!))
                      completion(image,nil)
                  } catch {
                      print("erro na imagem")
                  }
              }
          }
          
          
      }
    
}
