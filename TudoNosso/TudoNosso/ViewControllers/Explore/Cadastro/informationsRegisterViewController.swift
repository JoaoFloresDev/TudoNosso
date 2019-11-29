

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

class informationsRegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var constrainTextBox: UIView!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var endressTextBox: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var descriptionTextBox: UITextField!
    @IBOutlet weak var siteTextBox: UITextField!
    @IBOutlet weak var facebookTextBox: UITextField!
    @IBOutlet weak var constrainViewSite: UIView!
    
    @IBAction func registerAction(_ sender: Any) {
        if nameTextBox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(msg: "Campo Nome precisa ser preenchido", field: nameTextBox)
        } else if endressTextBox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(msg: "Campo Endereço precisa ser preenchido", field: endressTextBox)
        }else {
            showAlert(msg: "Finalizar cadastro?", field: endressTextBox)
//            cadastrar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        nameTextBox.delegate = self
        endressTextBox.delegate = self
        phoneTextField.delegate = self
        emailTextBox.delegate = self
        descriptionTextBox.delegate = self
        siteTextBox.delegate = self
        facebookTextBox.delegate = self
        
        KeyboardAvoiding.avoidingView = self.constrainTextBox
    }
    
    func showAlert(msg: String, field:UITextField) {
        let alertController = UIAlertController(title: "Campos necessários", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (act) in
            field.becomeFirstResponder()
        }
        
        alertController.addAction(okAction)
        present(alertController,animated: true)
    }
    
    //    keyboard functions
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.emailTextBox {
            KeyboardAvoiding.avoidingView = self.constrainViewSite
        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case nameTextBox:
            self.endressTextBox.becomeFirstResponder()
            
        case endressTextBox:
            self.phoneTextField.becomeFirstResponder()
            
        case phoneTextField:
            self.emailTextBox.becomeFirstResponder()
            
        case emailTextBox:
            self.descriptionTextBox.becomeFirstResponder()
            
        case descriptionTextBox:
            self.siteTextBox.becomeFirstResponder()
            
        case siteTextBox:
            self.facebookTextBox.becomeFirstResponder()
            
        default: //facebookTextBox:
            KeyboardAvoiding.avoidingView = self.constrainTextBox
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
