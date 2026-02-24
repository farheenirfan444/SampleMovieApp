//
//  ViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 14/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    let genres = ["Action", "Adventure","Adventure", "Drama", "Comedy", "Crime",  "Documentary", "Sports", "Fantasy", "Horror", "Music", "Western","Horhor", "Thriller", "Sci-fi"]
    @IBOutlet var genreCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        genreCollectionView.isScrollEnabled = true
        if let layout = genreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
    }
   
}
