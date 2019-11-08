//
//  CategoryRow.swift
//  TwoDirectionalScroller
//
//  Created by Robert Chen on 7/11/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit

class OrganizationCategory : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension OrganizationCategory : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        
        cell.imageView.layer.borderWidth=1.0
        cell.imageView.layer.masksToBounds = false
        cell.imageView.layer.borderColor = UIColor.white.cgColor
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height/8
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
}

extension OrganizationCategory : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemHeight, height: itemHeight)
    }
}
