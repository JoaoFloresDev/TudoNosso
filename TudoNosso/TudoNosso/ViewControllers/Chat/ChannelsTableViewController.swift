//
//  ChannelsTableViewController.swift
//  TudoNosso
//
//  Created by Bruno Cardoso Ambrosio on 22/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ChannelsTableViewController: UITableViewController {
    //MARK: variable's
    var channels: [Channel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    //MARK: IBOutlet's
    @IBOutlet var channelsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(ChannelTableViewCell.nib, forCellReuseIdentifier: ChannelTableViewCell.reuseIdentifer)
        
        loadChannels()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadChannels()
    }
    
    func loadChannels(){
        ChannelDM().listAll { (channels, err) in
            guard let channels = channels else {return}
            self.channels = channels
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.reuseIdentifer, for: indexPath) as? ChannelTableViewCell else {
            fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
        }
        cell.configure(channel: channels[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openChannel(self.channels[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    
    fileprivate func openChannel(_ channel: Channel) {
        let userID = Base64Converter.encodeStringAsBase64(Local.userMail!)
        let userKind = LoginKinds(rawValue: Local.userKind!)!
        LoginDM().recoverUser(ById: userID, onKind: userKind) { (dictionary, err) in
            if err == nil {
                guard
                    let dictionary = dictionary,
                    let user = User(snapshot: dictionary as NSDictionary)
                    else {return}
                let vc = ChatViewController(user: user, channel: channel )
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
   
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
}
