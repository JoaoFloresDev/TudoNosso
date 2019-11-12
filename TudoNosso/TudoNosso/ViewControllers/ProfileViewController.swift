//
//  ProfileViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupJobsTableView()
        setupProfileTableView()
    }
    
    func setupJobsTableView(){
        jobsTableView.isHidden = false
        jobsTableView.backgroundColor = .clear
        
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
        jobsTableView.register(JobsTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: JobsTableViewHeader.reuseIdentifer)
    }
    
    func setupProfileTableView() {
        profileTableView.isHidden = true
        profileTableView.backgroundColor = .clear
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        profileTableView.register(InfoCell.nib, forCellReuseIdentifier: InfoCell.reuseIdentifer)
    }

    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.jobsTableView.isHidden = false
            self.profileTableView.isHidden = true
        case 1:
            self.jobsTableView.isHidden = true
            self.profileTableView.isHidden = false
        default:
            self.jobsTableView.isHidden = false
            self.profileTableView.isHidden = true
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case jobsTableView:     return 2
        case profileTableView:  return 1
        default:                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case jobsTableView:
            
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobsTableViewHeader.reuseIdentifer) as? JobsTableViewHeader else {
                fatalError("The dequeued header is not an instance of JobsTableViewHeader.")
            }
            
            switch section {
            case 0:  header.configure(type: .ongoing)
            case 1:  header.configure(type: .finished)
            default: break
            }
            
            return header
            
        default:    return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView{
        case jobsTableView:     return JobsTableViewHeader.height
        case profileTableView:  return 0
        default:                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case jobsTableView:
            return 2 //TODO
        case profileTableView:
            return 3
        default:    return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView{
        case jobsTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
                fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
            }
            //todo config cell
            cell.configure()
            cell.backgroundColor = .clear
            return cell
        case profileTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseIdentifer, for: indexPath) as? InfoCell else {
                fatalError("The dequeued cell is not an instance of InfoCell.") }
            cell.backgroundColor = .clear
            cell.configure() //TODO
            return cell
        default: return UITableViewCell()
        }
    }
}
