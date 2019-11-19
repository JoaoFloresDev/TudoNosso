//
//  DictionaryConvertable.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation

/// The class that use this protocol will need to inform how it inits itself interpreting a NSDictionary
protocol DictionaryInterpreter {
    static func interpret(data: NSDictionary) -> Self?
    
}


