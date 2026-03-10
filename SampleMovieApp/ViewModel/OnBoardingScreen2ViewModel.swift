//
//  OnBoardingScreen2ViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 26/02/2026.
//


import Foundation

final class OnBoarding2ScreenViewModel {
    
    //MARK: Variables
    private var selectedGenres = [String]()
    var onSelectionChanged: (() -> Void)?
    let defaults = UserDefaults.standard
    
    //MARK: Functions
    func addGenre(genre: String) {
        if selectedGenres.contains(genre) {
            selectedGenres.removeAll { $0 == genre }
        }
        else {
            selectedGenres.append(genre)
        }
        onSelectionChanged?()
    }
    
    func isGenreSelected(genre: String) -> Bool {
       return selectedGenres.contains(genre)
    }
    
    func saveGenres() {
        defaults.set(selectedGenres, forKey: "UserFavoriteGenres")
        UserPreferenceManager.shared.savePreferences(selectedGenres)
    }
    
    var selectedGenresCount: Int{
        return selectedGenres.count
    }
}
