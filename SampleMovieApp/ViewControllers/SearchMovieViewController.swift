//
//  SearchMovieViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 23/02/2026.
//

import UIKit

class SearchMovieViewController: UIViewController, CoordinatorBoard {
    let popup = PopUpView()
    
    var viewModel = MovieViewModel()
    @IBOutlet weak var searchResultLabel: UILabel!
    
    @IBAction func searchButtontapped(_ sender: Any) {
        guard let query = searchTextField.text, !query.isEmpty else {
            popup.titleLabel.text = "Input field empty"
            popup.messageLabel.text = "Please enter a value to search for a movie."
            popup.show(on: self)
            return
        }
      viewModel.searchMovies(query: query)
    }
    @IBOutlet weak var recentSearchCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchCollectionView.dataSource = self
        recentSearchCollectionView.delegate = self
        styleTextField(searchTextField)
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async{
                self?.recentSearchCollectionView.reloadData()
                self?.searchResultLabel.text = "Search Result"
                
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

private func styleTextField(_ textField: UITextField) {
    textField.layer.cornerRadius = 20
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 0.8
    textField.layer.borderColor = UIColor(
        red: 42/255,
        green: 42/255,
        blue: 42/255,
        alpha: 1
    ).cgColor
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    textField.clipsToBounds = true
}
