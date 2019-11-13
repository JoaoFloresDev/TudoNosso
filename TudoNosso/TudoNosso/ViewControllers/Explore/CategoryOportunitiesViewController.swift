//
//  CategoryOportunitiesViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 11/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class CategoryOportunitiesViewController: UIViewController {

    var categories = ["Causas", "Organizações", "Todas as Vagas"]
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var jobsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupTableView()
        
        jobsTableView.dataSource = self
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        jobsTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor.white
    }
        
    func setupTableView(){
        jobsTableView.backgroundColor = .clear
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
    }
}

extension CategoryOportunitiesViewController : UITableViewDelegate { }

extension CategoryOportunitiesViewController : UITableViewDataSource, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showDetailSegue", sender: indexPath.count)
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return categories[section]
//    }
//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
                fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
            }
            
            //todo config cell
//            cell.configureCell()tudo
        
            cell.backgroundColor = .clear
            return cell
    }
}

