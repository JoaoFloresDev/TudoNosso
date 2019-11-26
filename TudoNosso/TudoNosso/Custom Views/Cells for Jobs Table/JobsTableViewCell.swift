//
//  JobsTableViewCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {
    
    let ongDM = OrganizationDM()
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var typeOfJobLabel: UILabel!
    @IBOutlet weak var jobAdressLabel: UILabel!
    @IBOutlet weak var jobImageVeiw: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var firstVolunteerImage: RoundedImageView!
    @IBOutlet weak var secondVolunteerImage: RoundedImageView!
    @IBOutlet weak var engagedLabel: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    
    static let reuseIdentifer = "JobsTableViewCell"
    
    static var nib: UINib {
        let nibName = String(describing: JobsTableViewCell.self)
        return UINib(nibName: nibName, bundle: nil)
    }
    
    func configure(job: Job, buttonsAvailable: Bool){
        
        jobTitleLabel.text = job.title
        typeOfJobLabel.text = job.vacancyType
        categoriesLabel.text = job.category.rawValue
        engagedLabel.text = "00 engajados / " + String(format: "%02d", job.vacancyNumber) + " vagas"
        
        if buttonsAvailable { //TODO ajustes
            buttonsView.isHidden = false
            buttonsView.superview?.sizeToFit()
            buttonsView.superview?.superview?.sizeToFit()
        }
        
        ongDM.find(ById: job.organizationID) { (ong, err) in
            guard let ong = ong else { return }
            
            if let avatar = ong.avatar {
                FileDM().recoverProfileImage(profilePic: avatar) { (image, error) in
                    guard let imanage = image else {return}
                    OperationQueue.main.addOperation {
                        self.jobImageVeiw.image = image
                    }
                }
            }
        }
        
//        jobImageVeiw.image = job
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        
    }
}
