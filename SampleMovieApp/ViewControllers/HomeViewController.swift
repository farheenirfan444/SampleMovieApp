//
//  HomeViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class HomeViewController: UIViewController, CoordinatorBoard {
    weak var mainCoordinator: MainCoordinator?
    
    var viewModel = MovieViewModel()
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        mainCoordinator?.goToSearchScreen()
    }
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        bindViewModel()
        viewModel.fetchHomeMovies()
        viewModel.getRequestWithAF()
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
        posterImage.image = UIImage(named: "img1")
        languageLabel.text = firstMovie.originalLanguage ?? "N/A"
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieHomeScreenCellCollectionViewCell
        
        let movie = viewModel.movie(at: indexPath.item)
        cell.titleLabel.text = movie.title
        cell.posterImage.backgroundColor = .red
        return cell
    }
    
    
}


