//
//  ConfirmRegisterViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 29/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ConfirmRegisterViewController: UIViewController {
    
    var email = ""
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showExploreAction(_ sender: Any) {
        
        LoginDM().signIn(email: email, pass: key) { (dictionary, error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let dictionary = dictionary as NSDictionary?  {
                if let ong = Organization(snapshot: dictionary){
                    Local.userMail = ong.email
                    Local.userKind = LoginKinds.ONG.rawValue
                }else if let volunteer = Volunteer(snapshot: dictionary){
                    Local.userMail = volunteer.email
                    Local.userKind = LoginKinds.volunteer.rawValue
                }
                ViewUtilities.navigateToStoryBoard(storyboardName: "Main", storyboardID: "Tab", window: self.view.window, completion: {})
                
            }
        }
    }
    
}
