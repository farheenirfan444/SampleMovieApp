//
//  SearchMovieViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 23/02/2026.
//

import UIKit

class SearchMovieViewController: UIViewController, CoordinatorBoard {
    
    var viewModel = MovieViewModel()
    

    @IBAction func searchButtontapped(_ sender: Any) {
        guard let query = searchTextField.text, !query.isEmpty else {
            return
        }
        viewModel.searchMovies(query: query)
        print(query)
    }
    @IBOutlet weak var recentSearchCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchCollectionView.dataSource = self
        recentSearchCollectionView.delegate = self
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async{
                self?.recentSearchCollectionView.reloadData()
            }
        }
    }

}

extension SearchMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieHomeScreenCellCollectionViewCell
       let movie = viewModel.movie(at: indexPath.item)
        cell.titleLabel.text = movie.title
        cell.posterImage.backgroundColor = .red
        return cell
    }
}
