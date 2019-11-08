//
//  JobsTableViewHeader.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 08/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class JobsTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var circleView: RoundedView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifer = String(describing: JobsTableViewHeader.self)
    static let height = CGFloat(42)
    
    static var nib: UINib {
        let nibName = String(describing: JobsTableViewHeader.self)
        return UINib(nibName: nibName, bundle: nil)
    }
    
    enum TypeOfHeader {
        case ongoing
        case finished
        
        var title: String {
            switch self {
            case .ongoing:  return "Em andamento"
            case .finished: return "Encerradas"
            }
        }
        
        var circleColor: UIColor {
            switch self {
            case .ongoing:  return UIColor(rgb: 0x82E148)
            case .finished: return UIColor.thinGray
            }
        }
    }
    
    func configure(type: TypeOfHeader) {
        self.circleView.backgroundColor = type.circleColor
        self.titleLabel.text = type.title
    }
}
