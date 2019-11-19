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

    
    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var jobsContainerView: UIView!
    
    private let jobsSegueIdentifier = "toJobsTable"
    private let profileSegueIdentifier = "toProfileTable"
    
    
    let placeholderAreas = ["Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde"]
    var widths : [CGFloat] = []
    var collection: UICollectionView?
    
    var ong : Organization? {
        didSet{
            if self.shouldPerformSegue(withIdentifier: self.profileSegueIdentifier, sender: self) {
                self.performSegue(withIdentifier: self.profileSegueIdentifier, sender: self)
            }
        }
    }
    
    var jobs : [Job]? {
        didSet {
            if self.shouldPerformSegue(withIdentifier: self.jobsSegueIdentifier, sender: self) {
                self.performSegue(withIdentifier: self.jobsSegueIdentifier, sender: self)
            }
        }
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
        //TODO usando um email fixo por enquanto
        let email = "bruno@gmail.com"
        let id = Base64Converter.encodeStringAsBase64(email)
        
        orgDM.find(ByEmail: email) { (result, error) in
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
        case profileSegueIdentifier:
            if self.ong != nil {
                return true
            } else {
                return false
            }
        case jobsSegueIdentifier:
            if self.jobs != nil {
                return true
            } else {
                return false
            }
        default:    return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == profileSegueIdentifier {
            if let nextVC = segue.destination as? ProfileTableViewController {
                nextVC.data = self.ong
            }
        } else if segue.identifier == jobsSegueIdentifier {
            if let nextVC = segue.destination as? JobsTableViewController {
                nextVC.data = self.jobs
            }
        }
    }

    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.jobsContainerView.isHidden = false
            self.profileContainerView.isHidden = true
        case 1:
            self.jobsContainerView.isHidden = true
            self.profileContainerView.isHidden = false
        default:
            self.jobsContainerView.isHidden = false
            self.profileContainerView.isHidden = true
        }
    }
}
