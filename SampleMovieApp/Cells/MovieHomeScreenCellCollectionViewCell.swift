//
//  MovieHomeScreenCellCollectionViewCell.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 22/02/2026.
//

import UIKit

class MovieHomeScreenCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIView!
    
    @IBAction func playButton(_ sender: Any) {
        print("I am clicked.")
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    
}


