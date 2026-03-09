//
//  MovieDetailViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 28/02/2026.
//

import Foundation
import Alamofire
import Model
import Utilities


public final class MovieDetailViewModel {
    private let apiKey = "9b171df651373fbef57d316b5b943cdf"
    private let baseUrl = "https://api.themoviedb.org/3"
    private let movieId: Int
    var movieDetails: MovieDetail?
    
    var cast: [Cast] = []
    var onMovieDetailUpdated: (() -> Void)?
    var onCastUpdated: (() -> Void)?
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    func fetchMovieDetail(){
        let detailUrl = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)"
       
        AF.request(detailUrl).response { response in
            guard let data = response.data else { return }
            if let decodedResponse = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                DispatchQueue.main.async {
                    self.movieDetails = decodedResponse
                    self.onMovieDetailUpdated?()
                }
            }
        }
    }
    func fetchCast() {
        let creditsUrl = "\(baseUrl)/movie/\(movieId)/credits?api_key=\(apiKey)"
        
        AF.request(creditsUrl).response { response in
            guard let data = response.data else { return }
            if let decodedResponse = try? JSONDecoder().decode(CreditsResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.cast = decodedResponse.cast
                    self.onCastUpdated?()
                }
            }
        }
    }
}

