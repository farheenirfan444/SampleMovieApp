//
//  MovieCellCollectionViewCell.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 21/02/2026.
//

import UIKit

class MovieCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView : UIImageView!
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Apply rounded corners to the cell's layer
            self.contentView.layer.cornerRadius = 12.0
            self.contentView.layer.masksToBounds = true
            
            // Optional: If you want a subtle border like the screenshot
            self.contentView.layer.borderWidth = 0.5
            self.contentView.layer.borderColor = UIColor.darkGray.cgColor
        }
    
}
