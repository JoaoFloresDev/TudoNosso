//
//  AddJobTableViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 27/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class AddJobTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Cancelar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
