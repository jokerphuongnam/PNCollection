//
//  ImageCell.swift
//  PNCollectionExample
//
//  Created by pnam on 29/01/2023.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String {
        get {
            fatalError("can't get image name")
        }
        set {
            imageView.image = UIImage(systemName: newValue)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
