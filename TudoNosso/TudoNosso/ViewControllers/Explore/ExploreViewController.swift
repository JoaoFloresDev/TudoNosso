//
//  ExploreViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    var categories = ["Causas", "Organizações", "Todas as Vagas"]
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var jobsTableView: UITableView!
    
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
    }
        
    func setupTableView(){
        jobsTableView.backgroundColor = .clear
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
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
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! CauseCategory
            print(cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell2") as! CauseCategory
            print(cell)
            return cell
        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell3") as! oportunityCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
                fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
            }
            
            //todo config cell
            cell.configure()
            cell.backgroundColor = .clear
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
