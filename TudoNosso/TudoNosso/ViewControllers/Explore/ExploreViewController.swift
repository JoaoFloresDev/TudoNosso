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
    
    var selectedCause: String = ""
    var selectedOrganization: String = ""
    var organizationsList : [Organization] = []
    var filteredOrganizationsList : [Organization] = []
    var ongoingJobs : [Job] = []
    var filteredOngoingJobs : [Job] = []
    var categories = ["Causas", "Organizações", "Todas as Vagas"]
    var searchController = UISearchController(searchResultsController: nil)
    
    var organization : Organization = Organization(name: "", address: CLLocationCoordinate2D(), email: "")
    
    var jobs : [Job] = [] {
        didSet {
            self.sortJobs()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupJobsTableView()
        
        loadData()
    }
    
    func setupSearchBar() {
        jobsTableView.tableHeaderView = searchController.searchBar
        
        let searchBar = UISearchBar.appearance()
        searchBar.tintColor = UIColor.black
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        searchBar.alpha = 1
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        definesPresentationContext = true
    }
    
    func setupJobsTableView() {
        jobsTableView.isHidden = false
        jobsTableView.backgroundColor = .clear
        
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
        jobsTableView.register(JobsTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: JobsTableViewHeader.reuseIdentifer)
    }
    
    func setupTableView(){
        jobsTableView.backgroundColor = .clear
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
    }
    
    func loadData() {
        let jobDM = JobDM()
        
        jobDM.listAll {
            (result, error) in
            guard let result = result else { return }
            self.jobs = result
            self.jobsTableView.reloadData()
        }
    }
    
    private func filterJobs(for searchText: String) {
      filteredOngoingJobs = ongoingJobs.filter { player in
        return player.title.lowercased().contains(searchText.lowercased())
      }
      jobsTableView.reloadData()
    }
    
    private func filterOrganizations(for searchText: String) {
      filteredOrganizationsList = organizationsList.filter { player in
        return player.name.lowercased().contains(searchText.lowercased())
      }
      jobsTableView.reloadData()
    }
    
    func sortJobs(){
        for job in jobs {
            if job.status {
                ongoingJobs.append(job)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CategoryOportunitiesViewController {
            let vc = segue.destination as? CategoryOportunitiesViewController
            vc?.titleHeader = selectedCause
        }
        
        else if segue.destination is ProfileViewController {
            let vc = segue.destination as? ProfileViewController
            vc?.email = selectedOrganization
        }
    }
}

extension ExploreViewController : UITableViewDelegate { }

extension ExploreViewController : UITableViewDataSource, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterJobs(for: searchController.searchBar.text ?? "")
        filterOrganizations(for: searchController.searchBar.text ?? "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredOngoingJobs.count
        }
        
        if section < 2 {
            return 1
        } else {
            return ongoingJobs.count
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailSegue", sender: indexPath.count)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive && searchController.searchBar.text != "" {
          return categories[2]
        }
        
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return 1
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var typeCell = indexPath.section
        
        if searchController.isActive && searchController.searchBar.text != "" {
          typeCell = 2
        }
        
        switch typeCell {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! CategoryCollectionView
            cell.tag = 0
            cell.delegate = self
            cell.organizationsList = organizationsList
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell2") as! CategoryCollectionView
            cell.tag = 1
            cell.delegate = self
            cell.loadDataOrganizations()
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
                fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
            }
            
            let jobList: Job
              
            if searchController.isActive && searchController.searchBar.text != "" {
              jobList = filteredOngoingJobs[indexPath.row]
            } else {
              jobList = ongoingJobs[indexPath.row]
            }
            
            cell.configure(job: jobList)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ExploreViewController: CategoryCollectionViewDelegate {
    func causeSelected(_ view: CategoryCollectionView, causeTitle: String?, OrganizationEmail: String?,tagCollection: Int) {
    
        if(tagCollection == 0) {
            if let title = causeTitle {
                self.selectedCause = title
            }
            
            self.performSegue(withIdentifier: "showCauses", sender: self)
        }
            
        else {
            if let title = OrganizationEmail {
                self.selectedOrganization = title
            }
            
            self.performSegue(withIdentifier: "showProfile", sender: self)
        }
    }
}



