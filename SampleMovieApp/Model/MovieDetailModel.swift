//
//  MovieDetailModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 28/02/2026.
//

import Foundation
struct MovieDetail: Codable {
    let title: String
    let overview: String
    let runtime: Int?
    let releaseDate: String
    let genres: [Genre]
    let posterPath: String?
    
enum CodingKeys: String, CodingKey {
   case title,
        overview,
        runtime,
        releaseDate = "release_date",
        genres,
        posterPath = "poster_path"
    }
}

struct Genre : Codable {
    let id: Int
    let name: String
}

struct Cast: Codable {
    let id : Int
    let name : String
    let character : String
    let profilePath : String?
    enum CodingKeys: String, CodingKey {
   case id,
        name,
        character,
        profilePath = "profile_path"
    }
}

struct CreditsResponse : Codable {
    let cast: [Cast]
}

struct MovieDetailResponse: Codable {
    let result: MovieDetail
}
