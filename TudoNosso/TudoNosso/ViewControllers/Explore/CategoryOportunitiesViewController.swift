//
//  CategoryOportunitiesViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 11/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class CategoryOportunitiesViewController : UIViewController,UISearchBarDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var headerItem: UINavigationItem!
    
    //MARK: - PROPERTIES
    var filteredOngoingJobs : [Job] = []
    var searchController = UISearchController(searchResultsController: nil)
    var titleHeader: String = ""
    var jobsData = JobsDataSource()
    var ongoingJobs : [Job] = []
    var jobs : [Job] = [] {
        didSet {
            self.sortJobs()
        }
    }
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar(searchBarDelegate: self, searchResultsUpdating: self, jobsTableView, searchController)
        setupJobsTableView()
        
        loadData()
        headerItem.title = titleHeader
    }
    
    //MARK: - SETUP
    
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
    
//MARK: LOADER
    func loadData() {
//        var cat:[String] = []
//        cat.append()
        let jobDM = JobDM()
        jobDM.find(inField: .categories, comparison: .arrayContains, withValue: jobsData.nameKeyBD(key: titleHeader)) { (result, error) in
            guard let result = result else { return }
            self.jobs = result
            self.jobsTableView.reloadData()
        }
    }
    
    //MARK: - FILTER
    private func filterJobs(for searchText: String) {
        filteredOngoingJobs = ongoingJobs.filter { player in
            return player.title.lowercased().contains(searchText.lowercased())
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
    
    //MARK: - SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is JobViewController {
            if let vc = segue.destination as? JobViewController,
                let selectedJob = sender as? Job {
                vc.job = selectedJob
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension CategoryOportunitiesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedJob = ongoingJobs[indexPath.row]
        self.performSegue(withIdentifier: "showDetailJobSegue", sender: selectedJob)
    }
    
}
// MARK: - UITableViewDataSource
extension CategoryOportunitiesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredOngoingJobs.count
        } else {
            return ongoingJobs.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    }
}

// MARK: - UISearchResultsUpdating
extension CategoryOportunitiesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterJobs(for: searchController.searchBar.text ?? "")
    }
}

