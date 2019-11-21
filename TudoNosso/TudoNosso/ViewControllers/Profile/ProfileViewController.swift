//
//  ProfileViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit
import CoreLocation

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var addJobLabelView: UIView!
    @IBOutlet weak var editLabelView: UIView!
    
    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var jobsContainerView: UIView!
    
    private let jobsSegueID = "toJobsTable"
    private let profileSegueID = "toProfileTable"
    
    var email: String?
    
    var ong : Organization? {
        didSet{
            if self.shouldPerformSegue(withIdentifier: self.profileSegueID, sender: self) {
                self.performSegue(withIdentifier: self.profileSegueID, sender: self)
            }
        }
    }
    
    var jobs : [Job]? {
        didSet {
            if self.shouldPerformSegue(withIdentifier: self.jobsSegueID, sender: self) {
                self.performSegue(withIdentifier: self.jobsSegueID, sender: self)
            }
        }
    }
    
    enum TypeOfProfile {
        case ong
        case volunteer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        let jobDM = JobDM()
        let orgDM = OrganizationDM()
        
        var emailAdress: String! = ""
        
        if self.email != nil {
            emailAdress = self.email
        } else {
            emailAdress = "bruno@gmail.com" //placeholder
        }
        
        let id = Base64Converter.encodeStringAsBase64(emailAdress)
        
        orgDM.find(ByEmail: emailAdress) { (result, error) in
            if let erro = error {
                print(erro.localizedDescription)
            } else {
                guard let ong = result else {return}
                self.ong = ong
                self.profileNameLabel.text = ong.name
            }
        }
        
        jobDM.find(inField: .organizationID, withValueEqual: id) { (result, error) in
            if let erro = error {
                print(erro.localizedDescription)
            } else {
                guard let jobs = result else {return}
                self.jobs = jobs
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier{
        case profileSegueID:
            if self.ong != nil {
                return true
            } else {
                return false
            }
        case jobsSegueID:
            if self.jobs != nil {
                return true
            } else {
                return false
            }
        default:    return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == profileSegueID {
            if let nextVC = segue.destination as? ProfileTableViewController {
                nextVC.data = self.ong
            }
        } else if segue.identifier == jobsSegueID {
            if let nextVC = segue.destination as? JobsTableViewController {
                nextVC.data = self.jobs
            }
        }
    }

    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // show jobs
            self.jobsContainerView.isHidden = false
            self.profileContainerView.isHidden = true
            
            self.addJobLabelView.isHidden = false
            self.editLabelView.isHidden = true
        case 1: // show profile
            self.jobsContainerView.isHidden = true
            self.profileContainerView.isHidden = false
            
            self.addJobLabelView.isHidden = true
            self.editLabelView.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func addJobPressed(_ sender: Any) {
        print("add job pressed")
    }
    
    @IBAction func editProfilePressed(_ sender: Any) {
        print("edit profile pressed")
    }
}
