//
//  MovieModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 24/02/2026.
//

import Foundation

struct Movie: Codable {
   
    let id: Int
    let title: String
    let backdrop: String?
    let overview: String?
    let posterPath: String?
    let originalLanguage: String?
    let genreIds: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case id,
             posterPath = "poster_path",
             backdrop = "backdrop_path",
             title,
             overview,
             originalLanguage,
             genreIds = "genre_ids"
    }
}
struct HomeMovieResponse: Codable {
    let results: [Movie]
}

