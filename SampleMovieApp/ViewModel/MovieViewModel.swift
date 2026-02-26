//
//  MovieViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 24/02/2026.
//


import Foundation
import Alamofire


final class MovieViewModel {
    var movies: [Movie] = []
    var onMoviesUpdated: (() -> Void)?
    
    private let apiKey = "9b171df651373fbef57d316b5b943cdf"
    private let baseUrl = "https://api.themoviedb.org/3"
    
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
    func searchMovies(query: String) {
        
        let modifiedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(modifiedQuery)"
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
    movies[index]
}
    func posterURL(for movie: Movie) -> URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

}


