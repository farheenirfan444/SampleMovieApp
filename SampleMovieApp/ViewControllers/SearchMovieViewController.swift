//
//  SearchMovieViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 23/02/2026.
//

import UIKit

class SearchMovieViewController: UIViewController, CoordinatorBoard {
    
    //MARK: IBOutlets
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var recentSearchCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: Variable
    
    var viewModel = SearchViewModel()
    var mainCoordinator: MainCoordinator?
    let popUp = PopUpView()
    let popUpViewModel = PopUpViewModel(titleLabel: "Search Field Empty", messageLabel: "Add a movie to search")
    var baseUrl = ""
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentSearchCollectionView.dataSource = self
        recentSearchCollectionView.delegate = self
        
        bindViewModel()
        
        baseUrl = viewModel.baseUrl
        setUpUI()
        
        viewModel.loadRecentSearches()
    }
    //MARK: Helper functions
    private func setUpUI() {
        styleTextField(searchTextField)
        searchMovieButton()
    }
    private func searchMovieButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 24)
        button.addTarget(self, action: #selector(searchMovie), for: .touchUpInside)
        let container = UIView(frame: CGRect(x: -4, y: 0, width: 44, height: 24))
        button.center = container.center
        container.addSubview(button)
        searchTextField.rightView = container
        searchTextField.rightViewMode = .always
        
    }
    @objc func searchMovie() {
        guard let query = searchTextField.text, !query.isEmpty else {
            popUp.show(on: self, viewModel: popUpViewModel)
            return
        }
      viewModel.searchMovies(query: query)
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
    
    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.searchState {
        case .recent:
            return viewModel.numberOfMoviesInRecent
        case .results:
            return viewModel.numberOfMovies
        }
    }
    //cell for item at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieHomeScreenCellCollectionViewCell
        
        if viewModel.searchState == .recent {
            cell.titleLabel.text = viewModel.recentTitle(at: indexPath.item)
            cell.posterImage.loadImage(from: viewModel.recentPosterURL(at: indexPath.item))
        } else {
            cell.titleLabel.text = viewModel.movieTitle(at: indexPath.item)
            cell.posterImage.loadImage(from: viewModel.moviePosterURL(at: indexPath.item))
        }
        return cell
    }
    // did select item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.searchState == .results else { return }
        let movie = viewModel.selectedMovie(at: indexPath.item)
        viewModel.saveRecent(movie: movie)
        mainCoordinator?.goToMovieDetailScreen(movie: movie)
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
}
