//
//  ChannelInfoViewController.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 25/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ChannelInfoViewController: UIViewController {
    var channel:Channel! = nil
    var members:[User] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ChannelGeneralInfoTableViewCell.nib,
                           forCellReuseIdentifier: ChannelGeneralInfoTableViewCell.reuseIdentifer)
        
        tableView.register(ChannelMemberTableViewCell.nib,                            forCellReuseIdentifier: ChannelMemberTableViewCell.reuseIdentifer)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadMembers(){
        
    }
}

extension ChannelInfoViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return members.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelGeneralInfoTableViewCell.reuseIdentifer, for: indexPath) as? ChannelGeneralInfoTableViewCell else {fatalError("The dequeued cell is not an instance of ChannelGeneralInfoTableViewCell.")}
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelMemberTableViewCell.reuseIdentifer, for: indexPath) as? ChannelMemberTableViewCell else {fatalError("The dequeued cell is not an instance of ChannelMemberTableViewCell.")}
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        default:
            return NSLocalizedString("Participants", comment: "")
            
        }
    }
    
}
