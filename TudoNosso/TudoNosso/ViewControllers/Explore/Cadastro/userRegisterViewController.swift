//
//  userRegisterViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 28/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class userRegisterViewController: UIViewController {

    @IBOutlet weak var viewVoluntary: UIView!
    @IBOutlet weak var viewOng: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewDesign(view: viewVoluntary)
        setupViewDesign(view: viewOng)
    }
    
    @IBAction func actionVoluntary(_ sender: Any) {
        viewVoluntary.alpha = 0.7
        self.performSegue(withIdentifier: "showSignUpVoluntary", sender: self)
        viewVoluntary.alpha = 1
    }
    
    @IBAction func actionOng(_ sender: Any) {
        viewOng.alpha = 0.7
        self.performSegue(withIdentifier: "showSignUpOng", sender: self)
        viewOng.alpha = 1
    }
    
    func setupViewDesign(view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        
        view.layer.cornerRadius = viewVoluntary.frame.size.height/8
        view.clipsToBounds = true
    }
    
}
