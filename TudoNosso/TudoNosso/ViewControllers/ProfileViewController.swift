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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    func setupTableView(){
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 //TODO
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
            fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
        }
        //todo config cell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
