//
//  JobsTableViewCell.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 07/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

//MARK: - PROTOCOL
protocol JobsTableViewCellDelegate {
    func deleteJob(indexPath: IndexPath)
    func finishJob(indexPath: IndexPath)
}

//MARK: - CLASS JobsTableViewCell
class JobsTableViewCell: UITableViewCell {
    
    let ongDM = OrganizationDM()
    
    //MARK: - OUTLETS
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var typeOfJobLabel: UILabel!
    @IBOutlet weak var jobAdressLabel: UILabel!
    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var firstVolunteerImage: RoundedImageView!
    @IBOutlet weak var secondVolunteerImage: RoundedImageView!
    @IBOutlet weak var engagedLabel: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var finishView: UIView!
    
    //MARK: - PROPERTIES
    static let reuseIdentifer = "JobsTableViewCell"
    
    static var nib: UINib {
        let nibName = String(describing: JobsTableViewCell.self)
        return UINib(nibName: nibName, bundle: nil)
    }
    var buttonsAvailable = false {
        didSet {
            if buttonsAvailable { //TODO ajustes
                buttonsView.isHidden = false
                buttonsView.superview?.sizeToFit()
                buttonsView.superview?.superview?.sizeToFit()
                
                if (status ?? false) == false { // if job is finished
                    self.finishView.isHidden = true //shouldn't show Finish button.
                }
            }
        }
    }
    var status: Bool?
    var indexPath: IndexPath?
    var delegate: JobsTableViewCellDelegate?
    
    //MARK: - METHODS
    func configure(job: Job){
        status = job.status
        jobTitleLabel.text = job.title
        typeOfJobLabel.text = job.vacancyType
        categoriesLabel.text = job.firstCategoryAndCount
        engagedLabel.text = job.engagedOnesSlashVacancyNumber
        
        AddressUtil.recoveryShortAddress(fromLocation: job.localization) { (address, error) in
            guard let address = address else {return}
            OperationQueue.main.addOperation {
                self.jobAdressLabel.text = address
            }
        }
        
//        ongDM.find(ById: job.organizationID) { (ong, err) in
//            guard let ong = ong else { return }
//            
//            if let avatar = ong.avatar {
//                FileDM().recoverProfileImage(profilePic: avatar) { (image, error) in
//                    guard let image = image else {return}
//                    OperationQueue.main.addOperation {
//                        self.jobImageView.image = image
//                    }
//                }
//            }
//        }
    }
    
    func configIfProfile(delegate: JobsTableViewCellDelegate, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
        self.buttonsAvailable = true
    }
    
    //MARK: - ACTIONS
    @IBAction func deletePressed(_ sender: Any) {
        if let indexPath = self.indexPath {
            delegate?.deleteJob(indexPath: indexPath)
        }
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        if let indexPath = self.indexPath {
            delegate?.finishJob(indexPath: indexPath)
        }
    }
}
