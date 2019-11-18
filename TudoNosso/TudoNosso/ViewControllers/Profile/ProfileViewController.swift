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
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var profileTableView: UITableView!
    
    let placeholderAreas = ["Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde"]
    var widths : [CGFloat] = []
    
    var ong : Organization = Organization(name: "", address: CLLocationCoordinate2D(), email: "")
    
    var jobs : [Job] = [] {
        didSet {
            self.sortJobs()
        }
    }
    
    var ongoingJobs : [Job] = []
    var finishedJobs : [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widths.append(contentsOf: repeatElement(0, count: placeholderAreas.count))

        setupJobsTableView()
        setupProfileTableView()
        
        loadData()
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
        profileTableView.register(AboutCell.nib, forCellReuseIdentifier: AboutCell.reuseIdentifer)
        profileTableView.register(AreasCell.nib, forCellReuseIdentifier: AreasCell.reuseIdentifer)
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
                self.profileTableView.reloadData()
            }
        }
        
        jobDM.find(inField: .organizationID, withValueEqual: id) { (result, error) in
            if let erro = error {
                print(erro.localizedDescription)
            } else {
                guard let jobs = result else {return}
                self.jobs = jobs
                self.jobsTableView.reloadData()
            }
        }
    }
    
    func sortJobs(){
        for job in jobs {
            if job.status {
                ongoingJobs.append(job)
            } else {
                finishedJobs.append(job)
            }
        }
    }
    
    func createCell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseIdentifer, for: indexPath) as? InfoCell else {
            fatalError("The dequeued cell is not an instance of InfoCell.") }
            cell.configure(ong: self.ong)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.reuseIdentifer, for: indexPath) as? AboutCell else {
            fatalError("The dequeued cell is not an instance of AboutCell.") }
            cell.configure(ong: self.ong)
            return cell
        default:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AreasCell.reuseIdentifer, for: indexPath) as? AreasCell else {
            fatalError("The dequeued cell is not an instance of AreasCell.") }
            
            cell.collection.delegate = self
            cell.collection.dataSource = self
            
            cell.collection.register(AreaCollectionCell.nib, forCellWithReuseIdentifier: AreaCollectionCell.reuseIdentifer)
            
            cell.collection.reloadData()
            
            return cell
        }
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
        case jobsTableView:
            var count = 0
            if ongoingJobs.count > 0 {
                count += 1
            }
            if finishedJobs.count > 0 {
                count += 1
            }
            return count
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
            case 0:
                if ongoingJobs.count > 0 {
                    header.configure(type: .ongoing)
                } else {
                    return nil
                }
            case 1:
                if finishedJobs.count > 0 {
                    header.configure(type: .finished)
                } else {
                    return nil
                }
            default: break
            }
            
            return header
            
        default:    return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView{
        case jobsTableView:
            switch section {
            case 0:
                if ongoingJobs.count > 0 {
                    return JobsTableViewHeader.height
                } else { return 0 }
            default:
                 if finishedJobs.count > 0 {
                                   return JobsTableViewHeader.height
                               } else { return 0 }
            }
        case profileTableView:  return 0
        default:                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case jobsTableView:
            switch section {
            case 0:
                return ongoingJobs.count
            default:
                return finishedJobs.count
            }
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
            switch indexPath.section {
            case 0:
                cell.configure(job: ongoingJobs[indexPath.row])
            default:
                cell.configure(job: finishedJobs[indexPath.row])
            }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case profileTableView:
            let cell = self.createCell(indexPath: indexPath, tableView: tableView)
            
            cell.backgroundColor = .clear
            return cell
        default: return UITableViewCell()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeholderAreas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaCollectionCell.reuseIdentifer, for: indexPath) as? AreaCollectionCell else {
            fatalError("The dequeued cell is not an instance of AreaCollectionCell.")
        }
        
        cell.label.text = placeholderAreas[indexPath.row]
        widths[indexPath.row] = cell.label.intrinsicContentSize.width + 16

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widths[indexPath.row], height: CGFloat(24))
    }
}
