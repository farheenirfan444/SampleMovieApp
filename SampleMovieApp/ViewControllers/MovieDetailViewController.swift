//
//  MovieDetailViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 22/02/2026.
//

import UIKit

class MovieDetailViewController: UIViewController, CoordinatorBoard {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var censorRatingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var viewModel: MovieDetailViewModel!
    
    @IBOutlet weak var bookButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bookButton.configureView(title: "Book")
        viewModel.fetchMovieDetail()
    }
    private func bindViewModel() {
        viewModel.onMovieDetailUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.populateData()
            }
        }
    }
    private func populateData() {
        guard let movie = viewModel.movieDetails else { return }
        
        titleLabel.text = movie.title
        storyTextView.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
        durationLabel.text = "\(movie.runtime!) min"
        censorRatingLabel.text = "PG-13"
        
    }
}
