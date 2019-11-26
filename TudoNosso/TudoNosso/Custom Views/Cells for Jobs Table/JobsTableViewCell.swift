//
//  JobsTableViewCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {
    
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
    }
}
