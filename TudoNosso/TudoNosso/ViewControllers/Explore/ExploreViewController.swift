//
//  ExploreViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit
import CoreLocation


class ExploreViewController: UIViewController {
    
    @IBOutlet weak var jobsTableView: UITableView!
    
    var selectedTitleHeader: String = ""
    var categories = ["Causas", "Organizações", "Todas as Vagas"]
    var searchController = UISearchController(searchResultsController: nil)
    
    var ong : Organization = Organization(name: "", address: CLLocationCoordinate2D(), email: "")
    
    var jobs : [Job] = [] {
        didSet {
            self.sortJobs()
        }
    }
    
    var ongs : [Organization] = [] {
        didSet {
            self.sortOrganizations()
        }
    }
    
    var ongsList : [Organization] = []
    var ongoingJobs : [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupTableView()
        
        let searchBar = UISearchBar.appearance()
        searchBar.tintColor = UIColor.black
        searchBar.barTintColor = UIColor.white
        searchBar.alpha = 1
        searchBar.backgroundColor = UIColor.white
        
        
        jobsTableView.dataSource = self
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        jobsTableView.tableHeaderView = searchController.searchBar
        
        setupJobsTableView()
        
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
    
    func loadData() {
        let jobDM = JobDM()
        let orgDM = OrganizationDM()
        //TODO usando um email fixo por enquanto
        let email = "bruno@gmail.com"
        let id = Base64Converter.encodeStringAsBase64(email)
        
//        orgDM.find(ByEmail: email) { (result) in
//            guard let ong = result else {return}
//            self.ong = ong
//        }
        
        orgDM.listAll {
            (result) in
            self.ongs = result
            self.jobsTableView.reloadData()
        }
        
        jobDM.listAll {
            (result) in
            self.jobs = result
            self.jobsTableView.reloadData()
        }
    }
    
    func sortJobs(){
        for job in jobs {
            if job.status {
                ongoingJobs.append(job)
            }
        }
    }
    
    func sortOrganizations(){
        for ong in ongs {
            ongsList.append(ong)
            print(ong.name)
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
            
            cell.configure() //TODO
            return cell
        }
    }
    
    func setupTableView(){
        jobsTableView.backgroundColor = .clear
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CategoryOportunitiesViewController
        {
            let vc = segue.destination as? CategoryOportunitiesViewController
            vc?.titleHeader = selectedTitleHeader
        }
    }
}

extension ExploreViewController : UITableViewDelegate { }

extension ExploreViewController : UITableViewDataSource, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showDetailSegue", sender: indexPath.count)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 2 {
            return 1
        } else {
            return ongoingJobs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! CategoryCollectionView
            cell.delegate = self
            cell.tag = 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell2") as! CategoryCollectionView
            cell.tag = 1
            cell.delegate = self
            
            return cell
        case 2:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
                fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
            }
            cell.configure(job: ongoingJobs[indexPath.row])
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ExploreViewController: CategoryCollectionViewDelegate {
    func causeSelected(_ view: CategoryCollectionView, causeTitle: String?, tagCollection: Int) {
    
        print("tag: \(tagCollection)")
        if(tagCollection == 0) {
            if let title = causeTitle {
                self.selectedTitleHeader = title
            }
            
            self.performSegue(withIdentifier: "showCauses", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "showProfile", sender: self)
        }
    }
}



