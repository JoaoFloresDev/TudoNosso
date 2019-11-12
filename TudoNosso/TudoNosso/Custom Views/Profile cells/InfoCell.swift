//
//  InfoCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 08/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            self.locationLabel.lineBreakMode = .byWordWrapping
            self.locationLabel.numberOfLines = 0
        }
    }
    
    static let reuseIdentifer = String(describing: InfoCell.self)
    
    static var nib: UINib {
           let nibName = String(describing: InfoCell.self)
           return UINib(nibName: nibName, bundle: nil)
       }
    
    func configure(){
        self.locationLabel.text = "Rua Cabo Rubens Zimmermann, 186, Pq. Oziel – Campinas, SP, Brasil" //TODO esse foi só um teste de redimensionamento da view.
        self.locationLabel.sizeToFit()
        self.locationLabel.superview?.sizeToFit()
    }
}
