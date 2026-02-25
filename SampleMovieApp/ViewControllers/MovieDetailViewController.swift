//
//  MovieDetailViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 22/02/2026.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var censorRatingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var bookButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookButton.configureView(title: "Book")
        
       
    }
}
