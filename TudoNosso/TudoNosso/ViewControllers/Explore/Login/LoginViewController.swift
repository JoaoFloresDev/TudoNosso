//
//  ExploreViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit
import Photos
import Foundation
import Firebase
import Photos
import FirebaseAuth
//import FIRStorage

class LoginViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var constrainTextBox: UIView!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var locationTextBox: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        KeyboardAvoiding.avoidingView = self.constrainTextBox
        
    }
    
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
