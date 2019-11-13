//
//  UIColor+Extension.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 06/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

extension UIColor {
   
    class var bg: UIColor { return UIColor(rgb: 0xF9F9F9)}
    class var thinGray: UIColor { return UIColor(rgb: 0xD4D4D4)}
    class var lightGray: UIColor { return UIColor(rgb: 0xA9A9A9)}
    class var text: UIColor { return UIColor(rgb: 0x515151)}
    class var appBlack: UIColor { return UIColor(rgb: 0x212121)}
    class var darkOrange: UIColor { return UIColor(rgb: 0xE45102)}
    class var orange: UIColor { return UIColor(rgb: 0xFF5900)}
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
