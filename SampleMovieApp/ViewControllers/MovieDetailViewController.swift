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
    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    //private var viewModel: MovieDetailViewModel!

    func configure(movieId: Int) {
        //viewModel = MovieDetailViewModel(movieId: movieId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        //viewModel.fetchData()
    }

    private func setupBinding() {
//        viewModel.onDataLoaded = { [weak self] in
//            self?.updateUI()
//        }
    }

//    private func updateUI() {
//        //guard let movie = viewModel.movieDetail else { return }
//
//        titleLabel.text = movie.title
//        genresLabel.text = viewModel.genresText
//        metaLabel.text = "\(viewModel.censorRating) | \(viewModel.durationText) | \(movie.releaseDate)"
//        languagesLabel.text = "Available in: \(viewModel.languagesText)"
//        overviewLabel.text = movie.overview
//
//        if let posterPath = movie.posterPath {
//            let url = "https://image.tmdb.org/t/p/w500\(posterPath)"
//            ImageLoader.shared.loadImage(from: url) { [weak self] image in
//                self?.posterImageView.image = image
//            }
//        }
    //}
}
