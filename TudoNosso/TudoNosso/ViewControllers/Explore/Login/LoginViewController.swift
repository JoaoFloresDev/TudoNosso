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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(msg: "Campo e-mail precisa ser preenchido", field: emailTextField)
        } else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(msg: "Campo senha precisa ser preenchido", field: passwordTextField)
        }else {
            guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else {return}
            LoginDM().signIn(email: email, pass: password) { (ong, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        
    }
    
    func showAlert(msg: String, field:UITextField) {
        let alertController = UIAlertController(title: "Campos necessários", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (act) in
            field.becomeFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController,animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        KeyboardAvoiding.avoidingView = self.constrainTextBox
        
    }
    
//    keyboard functions
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            KeyboardAvoiding.avoidingView = self.constrainTextBox
        }
        else if textField == self.passwordTextField {
            KeyboardAvoiding.avoidingView = self.constrainTextBox
        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        else if textField == self.passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
