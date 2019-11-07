//
//  CategoryEnum.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 06/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import Foundation


enum CategoryEnum : String{
    case education = "Education"
    case cultureAndArt = "Culture & Art"
    case kids = "Kids"
    case elderly = "Elderly"
    case environment = "Environment"
    case animalProtection = "Animal Protection"
    case health = "Health"
    case sport = "Sport"
    case refugees = "Refugees"
    case lgbtq = "LGBTQ+"
    case againstPoverty = "Against Poverty"
    case professionalTraining = "Professional Training"
    
    
    func description() -> String{
        return self.rawValue
    }
}
