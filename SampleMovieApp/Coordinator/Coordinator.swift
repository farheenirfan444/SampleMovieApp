//
//  Coordinator.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}
