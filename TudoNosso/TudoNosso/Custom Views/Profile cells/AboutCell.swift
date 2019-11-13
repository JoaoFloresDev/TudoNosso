//
//  AboutCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 12/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {
    
    @IBOutlet weak var aboutLabel: UILabel! {
        didSet{
            self.aboutLabel.lineBreakMode = .byWordWrapping
            self.aboutLabel.numberOfLines = 0
        }
    }
    
    static let reuseIdentifer = String(describing: AboutCell.self)
    
    static var nib: UINib {
           let nibName = String(describing: AboutCell.self)
           return UINib(nibName: nibName, bundle: nil)
       }
    
    func configure(ong: Organization){
        self.aboutLabel.text = ong.desc
        self.aboutLabel.sizeToFit()
        self.aboutLabel.superview?.sizeToFit()
    }
}
