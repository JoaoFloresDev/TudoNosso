//
//  CategoryRow.swift
//  TwoDirectionalScroller
//
//  Created by Robert Chen on 7/11/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit

protocol CategoryCollectionViewDelegate: NSObjectProtocol {
    func causeSelected(_ view: CategoryCollectionView, causeTitle: String?, tagCollection: Int )
}


class CategoryCollectionView : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var categorysList = ["Cultura e Arte","Educação","Idosos","Crianças","Meio Ambiente","Proteção Animal","Saúde","Esportes","Refugiados","LGBTQ+","Combate à pobreza","Treinamento profissional"]
    
    weak var delegate: CategoryCollectionViewDelegate!
}

extension CategoryCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CategoryOportunitiesViewController
        {
            let vc = segue.destination as? CategoryOportunitiesViewController
            vc?.titleHeader = "Educação"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numElem = 12
        
        // tag 0 is Cause collection
        // tag 1 is Organization collection
        if(collectionView.tag == 1) {
            numElem = 20
        }
        
        return numElem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCasesOrganizations", for: indexPath) as! CellCasesOrganizations
        
        if(collectionView.tag == 1) {
            cell.imageView.layer.borderWidth = 1.0
            cell.imageView.layer.masksToBounds = false
            cell.imageView.layer.borderColor = UIColor.white.cgColor
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height/8
            cell.imageView.clipsToBounds = true
            cell.imageView.tag = indexPath.row
            cell.titleLabel.text = String(indexPath.row)
            
            let image = cropToBounds(image: UIImage(named: "ong-img_job")!, portraitOrientation: true)
            cell.imageView.image = image
        }
        else {
            cell.imageView.layer.borderWidth = 1.0
            cell.imageView.layer.masksToBounds = false
            cell.imageView.layer.borderColor = UIColor.white.cgColor
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height/8
            cell.imageView.clipsToBounds = true
            cell.imageView.tag = indexPath.row
            cell.titleLabel.text = String(indexPath.row)
            cell.titleLabel.text = categorysList[indexPath.row]
            
            let image = cropToBounds(image: UIImage(named: "ong-img_job")!, portraitOrientation: true)
            cell.imageView.image = image
        }
        
        let image = cropToBounds(image: UIImage(named: "ong-img_job")!, portraitOrientation: true)
        cell.imageView.image = image
        cell.delegate = self
        
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


extension CategoryCollectionView : CellCasesOrganizationsDelegate {
    func causeSelected(_ cell: CellCasesOrganizations) {
        
        if let delegate = self.delegate {
            delegate.causeSelected(self, causeTitle: cell.titleLabel.text, tagCollection: self.tag)
            
        }
    }
}
