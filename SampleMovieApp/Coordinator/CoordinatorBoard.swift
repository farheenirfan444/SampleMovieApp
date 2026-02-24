//
//  CoordinatorBoard.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//


import Foundation
import UIKit

protocol CoordinatorBoard: UIViewController {
    static func instantiateStoryBoard() -> Self
    
}

extension CoordinatorBoard {
    static func instantiateStoryBoard() -> Self
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let id = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

