//
//  InfoCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 08/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    static let reuseIdentifer = String(describing: InfoCell.self)
    
    static var nib: UINib {
           let nibName = String(describing: InfoCell.self)
           return UINib(nibName: nibName, bundle: nil)
       }
    
    func configure(){
        //TODO
    }
}
