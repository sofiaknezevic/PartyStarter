//
//  ImagePickingCollectionViewCell.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-04-02.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class ImagePickingCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var partyItemImageView: UIImageView!
    
    
    override func awakeFromNib()
    {
        
        super.awakeFromNib()
    }
    
    func configureCell(partyItemImage:UIImage) -> Void
    {
        
        imageContainerView.layer.borderWidth = 2
        imageContainerView.layer.masksToBounds = true
        imageContainerView.layer.borderColor = UIColor.black.cgColor
        imageContainerView.layer.cornerRadius = partyItemImageView.frame.width
        imageContainerView.clipsToBounds = true
        
        
    }
    
}
