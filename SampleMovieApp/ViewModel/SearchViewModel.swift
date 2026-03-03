//
//  MovieViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 24/02/2026.
//


import Foundation
import Alamofire
enum SearchState {
    case recent
    case results
}

final class SearchViewModel {
    // variables
    var movies: [Movie] = []
    var recentSearches = [MovieSearch]()
    
    var onMoviesUpdated: (() -> Void)?
    var searchState: SearchState = .recent
    
    private let apiKey = "9b171df651373fbef57d316b5b943cdf"
    let baseUrl = "https://api.themoviedb.org/3"
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    
    func searchMovies(query: String) {
        let modifiedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(modifiedQuery)"
        AF.request(url).response { response in
            guard let data = response.data else { return }
            if let decodedResponse = try? JSONDecoder().decode(HomeMovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = decodedResponse.results
                    self.searchState = .results
                    self.onMoviesUpdated?()
                }
            }
        }
    }
    
func loadRecentSearches() {
    recentSearches = RecentSearchManager.shared.fetchRecentSearches()
    searchState = .recent
    onMoviesUpdated?()
}
func saveRecent(movie: Movie) {
    let posterUrl = imageBaseUrl + (movie.posterPath ?? "")
    let recent = MovieSearch(title: movie.title, posterURL: posterUrl)
    RecentSearchManager.shared.saveSearch(recent)
}

func movieTitle(at index: Int) -> String {
    movies[index].title
}

func moviePosterURL(at index: Int) -> String {
    imageBaseUrl + (movies[index].posterPath ?? "")
}

func recentTitle(at index: Int) -> String {
    recentSearches[index].title
}

func recentPosterURL(at index: Int) -> String {
    recentSearches[index].posterURL
}
    
var numberOfMovies: Int {
    movies.count
}
var numberOfMoviesInRecent: Int {
    recentSearches.count
}

func selectedMovie(at index: Int) -> Movie {
    movies[index]
 }

}


