//
//  ChannelInfoViewController.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 25/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ChannelInfoViewController: UIViewController {
    var channel:Channel! = nil{
        didSet {
            if channel != nil{
                match = zip(channel.between, channel.betweenKinds)
                    .map { (id,kind) -> (email: String, kind: String) in
                        return (Base64Converter.decodeBase64AsString(id),kind)
                }
            }
        }
    }
    var match: [(email: String, kind: String)] = []
    var members:[User] = []{
        didSet{
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ChannelGeneralInfoTableViewCell.nib,
                           forCellReuseIdentifier: ChannelGeneralInfoTableViewCell.reuseIdentifer)
        
        tableView.register(ChannelMemberTableViewCell.nib,                            forCellReuseIdentifier: ChannelMemberTableViewCell.reuseIdentifer)
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        
        loadMembers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadMembers(){
        
        let result = match.reduce([String:[String]]()) { (partialDictionary, element) -> [String:[String]] in
            var dict = partialDictionary
            if let array = partialDictionary[element.kind] {
                dict[element.kind] = array + [element.email]
            } else {
                dict[element.kind] = [element.email]
            }
            return dict
        }
        
//        print(result)
        
        /*
        let lists = match.reduce(([String](),[String]())) { (partial, element) -> ([String],[String]) in
            if element.1 == "ong" {
                return (partial.0 + [element.0], partial.1)
            } else {
                 return (partial.0 , partial.1 + [element.0])
            }
        }
        
        print(lists)
         */
        
        
        
        /*
        let matchList = match.filter { (id,type) -> Bool in
            type == "volunteer"
        }.map { (id,type) -> String in
            id
        }*/
        
        //print(matchList)
        
        OrganizationDM().find(inField: .email, comparison: .inArray, withValue: result["ong"] as Any) { (ongs, error) in
             if error == nil {
                guard let ongs = ongs else {return}
                let ongUsers = ongs.compactMap { (child) -> User? in
                    if let element = User(snapshot: child.representation as NSDictionary){
                        element.kind = "ong"
                        return element
                    }
                    return nil
                }
                self.members.append(contentsOf: ongUsers)
            }
        }
        
        VolunteerDM().find(inField: .email, comparison: .inArray, withValue: result["volunteer"] as Any) { (vonlunteers, error) in
            if error == nil {
                guard let vonlunteers = vonlunteers else {return}
                let vonlunteerUsers = vonlunteers.compactMap { (child) -> User? in
                    if let element = User(snapshot: child.representation as NSDictionary){
                        element.kind = "volunteer"
                        return element
                    }
                    return nil
                }
                self.members.append(contentsOf: vonlunteerUsers)
            }
        }
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
            cell.configure(channel:channel)
            
            if !members.isEmpty{
                let user = members[indexPath.row]
                cell.configure(user: user)
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelMemberTableViewCell.reuseIdentifer, for: indexPath) as? ChannelMemberTableViewCell else {fatalError("The dequeued cell is not an instance of ChannelMemberTableViewCell.")}
            let user = members[indexPath.row]
            cell.configure(user:user)
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
