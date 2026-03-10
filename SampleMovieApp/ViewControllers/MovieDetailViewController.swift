//
//  MovieDetailViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 22/02/2026.
//

import UIKit

class MovieDetailViewController: UIViewController, CoordinatorBoard {
    //MARK: IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var censorRatingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var castImage1: UIImageView!
    @IBOutlet weak var castImage2: UIImageView!
    @IBOutlet weak var castImage3: UIImageView!
    @IBOutlet weak var castImage4: UIImageView!
    @IBOutlet weak var bookButton: CustomButton!
    
    //MARK: Variables
    var viewModel: MovieDetailViewModel!
    let baseURL = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setUpBookButton()
        
        viewModel.fetchMovieDetail()
        viewModel.fetchCast()
    }
    
    private func bindViewModel() {
        viewModel.onMovieDetailUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.populateData()
            }
        }
        viewModel.onCastUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.showCastImages()
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
        let imagePath = movie.posterPath
        let imageURL = baseURL + (imagePath ?? "")
        posterImageView.loadImage(from: imageURL)
        genresLabel.text = movie.genres.map{ $0.name }.joined(separator: ", ")
    }
    
    private func setUpBookButton() {
        let buttonViewModel = CustomButtonViewModel(title: "Book")
        bookButton.customViewModel = buttonViewModel
    }
    
    private func showCastImages() {
        let imageViews = [castImage1, castImage2, castImage3, castImage4]
        for (index, imageView) in imageViews.enumerated() {
            if index < viewModel.cast.count,
               let profilePath = viewModel.cast[index].profilePath {
                let imageURL = baseURL + profilePath
                imageView?.loadImage(from: imageURL)
            } else {
                imageView?.image = UIImage(systemName: "person.circle")
            }
        }
    }
}
