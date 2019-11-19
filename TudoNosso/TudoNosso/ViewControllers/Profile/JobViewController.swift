//
//  StoriesViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class JobViewController: UIViewController {
    //MARK: variable
    var job: Job?
    let ongDM = OrganizationDM()
    
    
    //MARK: IBOutlet
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var jobOrganizationName: UIButton!
    @IBOutlet weak var engajedAndSlotsLabel: UILabel!
    
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var jobLocalizationLabel: UILabel!
    @IBOutlet weak var jobOrganizationImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        guard let job = job else {return}
        loadJob(job)
        
        
    }
    private func loadJob(_ job:Job){
        jobTitleLabel.text = job.title
        jobTypeLabel.text = "Vaga \(job.vacancyType)"
        jobDescriptionLabel.text = job.desc
        engajedAndSlotsLabel.text = "~ / \(job.vacancyNumber) vagas"
        
        AddressUtil.recoveryAddress(fromLocation: job.localization) { (address, err) in
            guard let address = address else { return }
                self.jobLocalizationLabel.text = address
        }
        
        ongDM.find(ById: job.organizationID) { (ong, err) in
            guard let ong = ong else { return }
            self.jobOrganizationName.setTitle(ong.name, for: .normal)
            
        }
    }

}
