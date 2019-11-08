//
//  Base64Converter.swift
//  WhatsappClone
//
//  Created by Bruno Cardoso Ambrosio on 02/11/19.
//  Copyright © 2019 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

class Base64Converter {
  static func encodeStringAsBase64(_ text:String) -> String{
        
        let data = text.data(using: .utf8)
        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64
    }
}