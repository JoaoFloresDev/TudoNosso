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
    
    @IBAction func applyForButtonPressed(_ sender: Any) {
        let userID = Base64Converter.encodeStringAsBase64(Local.userMail!)
        let userKind = LoginKinds(rawValue: Local.userKind!)!
        
        setupUserEngagement(userID: userID)
        
        ChannelDM().find(ById: self.job!.channelID) { (channel, err) in
            guard var channel = channel
            else{return}
            let isAlreadyChatMember = channel.between.contains(userID)
            
            if isAlreadyChatMember{
                LoginDM().recoverUser(ById: userID, onKind: userKind) { (dictionary, err) in
                    guard
                        let dictionary = dictionary,
                        let user = User(snapshot: dictionary as NSDictionary)
                        else {return}
                    let vc = ChatViewController(user: user, channel: channel)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                channel = ChannelDM().addUser(channel: channel, userID: userID, userKind: userKind.rawValue)
                LoginDM().recoverUser(ById: userID, onKind: userKind) { (dictionary, err) in
                    guard
                        let dictionary = dictionary,
                        let user = User(snapshot: dictionary as NSDictionary)
                        else {return}
                    let vc = ChatViewController(user: user, channel: channel)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let job = job else {return}
        loadJob(job)
    }
    
    
    func setupUserEngagement(userID: String) {
        guard let job = job else {return}
        
        if job.engagedOnes == nil {
            job.engagedOnes = []
        }
        if !job.engagedOnes!.contains(userID) {
            job.engagedOnes!.append(userID)
            JobDM().save(job: job)
            self.job = job
            updateVacancyNumberAndEngagedCount()
        }
    }
    
    fileprivate func updateVacancyNumberAndEngagedCount() {
        OperationQueue.main.addOperation {
            self.engajedAndSlotsLabel.text = self.job!.engagedOnesSlashVacancyNumber
        }
    }
    
    private func loadJob(_ job:Job){
        OperationQueue.main.addOperation {
            self.jobTitleLabel.text = job.title
            self.jobTypeLabel.text = "Vaga \(job.vacancyType)"
            self.jobDescriptionLabel.text = job.desc
        }
        updateVacancyNumberAndEngagedCount()
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
