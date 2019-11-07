//
//  LoginViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 05/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var constrainTextBox: UIView!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var locationTextBox: UITextField!
    

    //    keyboard functions
        public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == self.nameTextBox {
                KeyboardAvoiding.avoidingView = self.constrainTextBox
            }
            else if textField == self.locationTextBox {
                KeyboardAvoiding.avoidingView = self.constrainTextBox
            }
            return true
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == self.nameTextBox {
                self.locationTextBox.becomeFirstResponder()
            }
            else if textField == self.locationTextBox {
                textField.resignFirstResponder()
            }
            return true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    
    
}
