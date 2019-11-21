//
//  ProfileTableViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 18/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class ProfileTableViewController : UITableViewController {
    
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var areasCollection: UICollectionView!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    var data: Organization?
    
    let placeholderAreas = ["Educação", "Saúde", "Educação", "Saúde", "Educação", "Saúde"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollection()
        setupInfoCell()
        setupAboutCell()
    }
    
    func setupInfoCell(){
        phoneLabel.text = data?.phone ?? ""
        mailLabel.text = data?.email ?? ""
        
        adressLabel.text = "Rua Cabo Rubens Zimmermann, 186, Pq. Oziel – Campinas, SP, Brasil" //TODO esse foi só um teste de redimensionamento da view.
        adressLabel.numberOfLines = 0
        adressLabel.sizeToFit()
        adressLabel.superview?.sizeToFit()
    }
    
    func setupAboutCell(){
        aboutLabel.text = data?.desc
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

extension ProfileTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeholderAreas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaCollectionCell.reuseIdentifer, for: indexPath) as? AreaCollectionCell else {
            fatalError("The dequeued cell is not an instance of AreaCollectionCell.")
        }

        cell.label.text = placeholderAreas[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = placeholderAreas[indexPath.row]
        label.sizeToFit()
        let width = label.intrinsicContentSize.width + 16
        
        return CGSize(width: width, height: CGFloat(24))
    }
}