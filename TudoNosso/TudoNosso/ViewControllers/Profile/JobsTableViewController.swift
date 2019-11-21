//
//  JobsTableViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class JobsTableViewController: UITableViewController {
    
    var data: [Job]? 
    
    var ongoingJobs : [Job] = []
    var finishedJobs : [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupJobsTableView()
        sortJobs()
    }
    
    func setupJobsTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.backgroundColor = .clear
        
        tableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
        tableView.register(JobsTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: JobsTableViewHeader.reuseIdentifer)
    }
    
    func sortJobs(){
        ongoingJobs.removeAll()
        finishedJobs.removeAll()
        
        if let jobs = self.data{
            for job in jobs {
                if job.status {
                    ongoingJobs.append(job)
                } else {
                    finishedJobs.append(job)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if ongoingJobs.count > 0 {
                return JobsTableViewHeader.TypeOfHeader.ongoing.height
            } else { return 0 }
        default:
            if finishedJobs.count > 0 {
                return JobsTableViewHeader.TypeOfHeader.finished.height
            } else { return 0 }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ongoingJobs.count
        default:
            return finishedJobs.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
}
