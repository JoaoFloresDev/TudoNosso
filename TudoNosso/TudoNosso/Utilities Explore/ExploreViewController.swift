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
    
    @IBOutlet weak var searchBox: UISearchBar!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
    }
        
    //    keyboard functions
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == self.searchBox {
                textField.resignFirstResponder()
            }
            return true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
}



extension ExploreViewController : UITableViewDelegate { }

extension ExploreViewController : UITableViewDataSource {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! CategoryRow
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell2") as! OrganizationCategory
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell3") as! oportunityCell
            
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
