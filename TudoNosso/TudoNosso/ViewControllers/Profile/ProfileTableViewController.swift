//
//  ProfileTableViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ProfileTableViewController : UITableViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var areasCollection: UICollectionView!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var areasCell: UITableViewCell!
    
    //MARK: - PROPERTIES
    var receivedData: ProfileViewController.Data?
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInfoCell()
        setupAboutCell()
        setupAreasCell()
    }
    
    //MARK: - METHODS
    func setupInfoCell(){
        phoneLabel.text = receivedData?.phone ?? ""
        mailLabel.text = receivedData?.email ?? ""
        
        adressLabel.numberOfLines = 0
        adressLabel.sizeToFit()
        adressLabel.superview?.sizeToFit()
        
        if let coordinates = receivedData?.address {
            AddressUtil.recoveryAddress(fromLocation: coordinates) { (result, error) in
                if error == nil {
                    if let adress = result {
                        self.adressLabel.text = adress
                        self.tableView.reloadData()
                    } else {
                        self.adressLabel.text = ""
                    }
                } else {
                    print ("Error getting adress from coordinates.")
                }
            }
        } else {
            adressLabel.text = ""
        }
    }
    
    func setupAboutCell(){
        aboutLabel.text = receivedData?.description
        aboutLabel.numberOfLines = 0
        aboutLabel.sizeToFit()
        aboutLabel.superview?.sizeToFit()
    }
    
    func setupAreasCell() {
        areasCell.isHidden = receivedData?.typeOfProfile?.isAreasFieldHidden ?? true
        if !areasCell.isHidden {
            prepareCollection()
        }
    }
    
    func prepareCollection(){
        areasCollection.delegate = self
        areasCollection.dataSource = self
        
        areasCollection.register(AreaCollectionCell.nib, forCellWithReuseIdentifier: AreaCollectionCell.reuseIdentifer)
    }
}

//MARK: - COLLECTION
extension ProfileTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let areas = receivedData?.areas {
            return areas.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaCollectionCell.reuseIdentifer, for: indexPath) as? AreaCollectionCell else {
            fatalError("The dequeued cell is not an instance of AreaCollectionCell.")
        }
        if let areas = receivedData?.areas{
            cell.label.text = areas[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        
        var width = CGFloat(0)
        
        if let areas = receivedData?.areas {
            label.text = areas[indexPath.row]
            label.sizeToFit()
            width = label.intrinsicContentSize.width + 16
        }
        
        return CGSize(width: width, height: CGFloat(24))
    }
}
