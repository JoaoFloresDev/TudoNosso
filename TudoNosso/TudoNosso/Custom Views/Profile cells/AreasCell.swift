//
//  AreasCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 12/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class AreasCell: UITableViewCell {
    static let reuseIdentifer = String(describing: AreasCell.self)
    
    static var nib: UINib {
           let nibName = String(describing: AreasCell.self)
           return UINib(nibName: nibName, bundle: nil)
       }
    
    func configure(){
    }
}
