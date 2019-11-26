//
//  ProfileTableViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ProfileTableViewController : UITableViewController {
    
    //MARK: Outlets
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var areasCollection: UICollectionView!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    //MARK: Properties
    var receivedData: ProfileViewController.Data?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollection()
        setupInfoCell()
        setupAboutCell()
    }
    
    //MARK: Methods
    func setupInfoCell(){
        phoneLabel.text = receivedData?.phone ?? ""
        mailLabel.text = receivedData?.email ?? ""
        
        if let coordinates = receivedData?.address {
            AddressUtil.recoveryAddress(fromLocation: coordinates) { (result, error) in
                if error == nil {
                    if let adress = result {
                        self.adressLabel.text = adress
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
        
        adressLabel.numberOfLines = 0
        adressLabel.sizeToFit()
        adressLabel.superview?.sizeToFit()
    }
    
    func setupAboutCell(){
        aboutLabel.text = receivedData?.description
        aboutLabel.numberOfLines = 0
        aboutLabel.sizeToFit()
        aboutLabel.superview?.sizeToFit()
    }
    
    func prepareCollection(){
        areasCollection.delegate = self
        areasCollection.dataSource = self
        
        areasCollection.register(AreaCollectionCell.nib, forCellWithReuseIdentifier: AreaCollectionCell.reuseIdentifer)
    }
}

//MARK: Collection View
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
