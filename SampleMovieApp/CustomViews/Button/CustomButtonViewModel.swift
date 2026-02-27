//
//  CustomButtonViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 26/02/2026.
//

import Foundation

final class CustomButtonViewModel {
   
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    func updateTitle(_ newTitle: String) {
        self.title = newTitle
    }
}
