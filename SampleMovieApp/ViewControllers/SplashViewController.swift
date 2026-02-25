//
//  SplashViewViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class SplashViewController: UIViewController,CoordinatorBoard  {
    var defaults = UserDefaults.standard
    struct Keys {
        static let user = "user"
    }

    weak var mainCoordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            //self.mainCoordinator?.navigateToOnBoardingScreen()

            if UserSessionManager.shared.isLoggedIn {
                self.mainCoordinator?.goToHomeScreen()
            } else {
                self.mainCoordinator?.navigateToOnBoardingScreen()
            }
        }
    }
}




