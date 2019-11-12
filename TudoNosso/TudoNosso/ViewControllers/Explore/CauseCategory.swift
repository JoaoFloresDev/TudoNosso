//
//  CategoryRow.swift
//  TwoDirectionalScroller
//
//  Created by Robert Chen on 7/11/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit

class CauseCategory : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    

}

extension CauseCategory : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numElem = 10
        print(collectionView.tag)
        if(collectionView.tag == 1) {
            numElem = 20
        }
        return numElem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.imageView.layer.borderWidth = 1.0
        cell.imageView.layer.masksToBounds = false
        cell.imageView.layer.borderColor = UIColor.white.cgColor
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height/8
        cell.imageView.clipsToBounds = true
        cell.imageView.tag = indexPath.row
        
//        if(indexPath.row <= 9) {
//            let image = cropToBounds(image: UIImage(named: "category\(indexPath.row)")!, portraitOrientation: true)
//            cell.imageView.image = image
//        }
//        else {
//            cell.imageView.image = (UIImage(named: "category1")!)
//        }
        let image = cropToBounds(image: UIImage(named: "ong-img_job")!, portraitOrientation: true)
        cell.imageView.image = image
        
        return cell
    }
    
    func cropToBounds(image: UIImage, portraitOrientation: Bool) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = 0
        var cgheight: CGFloat = 0
        
        if (portraitOrientation) { // if portrate
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            // hard coded
            cgwidth = 3000
            cgheight = 3000
        } else { // if landscape
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            // hard coded
            cgwidth = 3000
            cgheight = 3000
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: 1, orientation: image.imageOrientation)
        return image
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemHeight = collectionView.bounds.height - 10
        
        return CGSize(width: itemHeight, height: itemHeight)
    }
}
