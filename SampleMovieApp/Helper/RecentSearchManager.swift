//
//  RecentSearchManager.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 28/02/2026.
//

import Foundation

final class RecentSearchManager {
    // variable
    static let shared = RecentSearchManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let key = "RecentSearch"
    
    func saveSearch(_ search: MovieSearch) {
        var searches = fetchRecentSearches()
        searches.removeAll{ $0.title == search.title }
        searches.insert(search, at: 0)
        if searches.count > 5 { searches = Array(searches.prefix(5))}
        if let data = try? JSONEncoder().encode(searches) {
            defaults.set(data, forKey: key)
        }
    }
    func fetchRecentSearches() -> [MovieSearch] {
        guard let data = defaults.data(forKey: key),
        let searches = try? JSONDecoder().decode([MovieSearch].self, from: data)
        else { return [] }
        return searches
    }
}
