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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let job = job else {return}
        loadJob(job)
    }
    
    private func loadJob(_ job:Job){
        OperationQueue.main.addOperation {
            self.jobTitleLabel.text = job.title
            self.jobTypeLabel.text = "Vaga \(job.vacancyType)"
            self.jobDescriptionLabel.text = job.desc
            self.engajedAndSlotsLabel.text = job.engagedOnesSlashVacancyNumber
        }
        AddressUtil.recoveryAddress(fromLocation: job.localization) { (address, err) in
            guard let address = address else { return }
            OperationQueue.main.addOperation {
                self.jobLocalizationLabel.text = address
            }
        }
        
        ongDM.find(ById: job.organizationID) { (ong, err) in
            guard let ong = ong else { return }
            OperationQueue.main.addOperation {
                self.jobOrganizationName.setTitle(ong.name, for: .normal)
            }
            if let avatar = ong.avatar {
                FileDM().recoverProfileImage(profilePic: avatar) { (image, error) in
                    guard let image = image else {return}
                    OperationQueue.main.addOperation {
                        self.jobOrganizationImage.image = image
                    }
                }
            }
        }
    }
    
}
