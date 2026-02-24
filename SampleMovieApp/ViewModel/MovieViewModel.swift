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
    
    func fetchHomeMovies() {
        fetchMovies { [weak self] movies in
            self?.movies = movies
            self?.onMoviesUpdated?()
        }
    }
    func fetchMovies(completion: @escaping ([Movie]) -> Void) {
        let apiKey = "9b171df651373fbef57d316b5b943cdf"
        let urlString = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(HomeMovieResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse.results)
                    }
                }
            }
        }.resume()
    }
    
    func searchMovies(query: String) {
            searchMovies(query: query) { [weak self] movies in
                self?.movies = movies
                self?.onMoviesUpdated?()
            }
        }
    
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        let apiKey = "9b171df651373fbef57d316b5b943cdf"
        let modifiedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(modifiedQuery)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(HomeMovieResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse.results)
                    }
                }
            }
        }.resume()

    }
    
    func getRequestWithAF() {
        let apiKey = "9b171df651373fbef57d316b5b943cdf"
        AF.request("https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)").response { response in
            print("I am response from alamofire.")
            debugPrint(response)
        }
    }



var numberOfMovies: Int {
    movies.count
}

func movie(at index: Int) -> Movie {
    movies[index]
}

}


