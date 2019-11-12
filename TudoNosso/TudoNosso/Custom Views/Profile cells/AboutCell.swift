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
    
    func configure(){
        self.aboutLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." //TODO esse é somente um teste de redimensionamento da cell.
        self.aboutLabel.sizeToFit()
        self.aboutLabel.superview?.sizeToFit()
    }
}
