//
//  HomeViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class HomeViewController: UIViewController, CoordinatorBoard {
   
    //MARK: @IBOutlets and @IBActions
    @IBAction func searchButtonTapped(_ sender: Any) {
        mainCoordinator?.goToSearchScreen()
    }
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBAction func accountButtonTapped(_ sender: Any) {
        UserSessionManager.shared.logout()
        mainCoordinator?.goToSignInScreen()
    }
    //MARK: Variables
    weak var mainCoordinator: MainCoordinator?
    var viewModel = MovieViewModel()
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"

    
    //MARK: Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        bindViewModel()
       
        self.userNameLabel.text = viewModel.greeting
        viewModel.fetchMoviesForGenre()
       
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: Helper functions
    //Number of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMovies
    }
    
    //Cell for item at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieHomeScreenCellCollectionViewCell
        
        let movie = viewModel.movie(at: indexPath.item)
        cell.titleLabel.text = movie.title
        let fullImageUrl = imageBaseUrl + (movie.posterPath ?? "")
        cell.posterImage.loadImage(from: fullImageUrl)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        self.mainCoordinator?.goToMovieDetailScreen(movie: movie)
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateHeader()
                self.movieCollectionView.reloadData()
            }
        }
    }
    private func updateHeader() {
        guard let firstMovie = viewModel.movies.first else { return }
        titleLabel.text = firstMovie.title
        let fullImageUrl = imageBaseUrl + (firstMovie.posterPath ?? "")
        posterImage.loadImage(from: fullImageUrl)
        languageLabel.text = firstMovie.originalLanguage ?? "N/A"
       
        
    }
}


