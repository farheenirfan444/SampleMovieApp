//
//  MovieViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 24/02/2026.
//


import Foundation
import Alamofire


final class MovieViewModel {
    // Variables
    var movies: [Movie] = []
    var cast: [Cast] = []
    var genreIdList = [String]()
    var onMoviesUpdated: (() -> Void)?
    var userName: String {
        UserSessionManager.shared.getUser()?.name ?? "Guest"
    }
   
    private let apiKey = "9b171df651373fbef57d316b5b943cdf"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    // functions
    func fetchMovies() {
        let url = "\(baseUrl)/trending/movie/day?api_key=\(apiKey)"
        
        AF.request(url).response { response in
            guard let data = response.data else { return }
            if let decodedResponse = try? JSONDecoder().decode(HomeMovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = decodedResponse.results
                    self.onMoviesUpdated?()
                }
            }
        }
    }
   
    func fetchMoviesForGenre() {
        guard let selectedGenre = UserPreferenceManager.shared.fetchPreferences(), !selectedGenre.isEmpty else {
            return
        }
        for genre in selectedGenre{
            if let id = movieGenreIds[genre]{
                genreIdList.append(id)
            }
        }
        let genreIds = genreIdList.joined(separator: ",")
        let url = "\(baseUrl)/discover/movie?api_key=\(apiKey)&with_genres=\(genreIds)"
        AF.request(url).response { response in
            guard let data = response.data else { return }
            if let decodedResponse = try? JSONDecoder().decode(HomeMovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = decodedResponse.results
                    self.onMoviesUpdated?()
                }
            }
        }
    }
    

var numberOfMovies: Int {
    movies.count
}
func movie(at index: Int) -> Movie {
  return movies[index]
}
var greeting: String {
  return "Hey \(userName)"
}
    
}


