//
//  MainCoordinator.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator{
    var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let splashVC = SplashViewController.instantiateStoryBoard()
        splashVC.mainCoordinator = self
        self.navigationController?.pushViewController(splashVC, animated: true)
        
    }
    func navigateToOnBoardingScreen() {
        let onBoardingVC = OnBoardingScreen1ViewController.instantiateStoryBoard()
        onBoardingVC.mainCoordinator = self
        self.navigationController?.pushViewController(onBoardingVC, animated: true)
    }
    func onBoardingScreen1NextButtonTapped() {
        let onBoardingScreen2VC = OnBoardingScreen2ViewController.instantiateStoryBoard()
        onBoardingScreen2VC.mainCoordinator = self
        self.navigationController?.pushViewController(onBoardingScreen2VC, animated: true)
        
    }
    func onBoardingScreen2NextButtonTapped() {
        let signInVC = SignInViewController.instantiateStoryBoard()
        signInVC.mainCoordinator = self 
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    func skipButtonTapped(){
        let homeVC = HomeViewController.instantiateStoryBoard()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    func signInButtonTapped() {
        let homeVC = HomeViewController.instantiateStoryBoard()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    func signUpButtonTapped() {
        let signUpVC = SignUpViewController.instantiateStoryBoard()
        signUpVC.mainCoordinator = self
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    func signInButtonTappedFromSignUp() {
        let loginVC = SignInViewController.instantiateStoryBoard()
        loginVC.mainCoordinator = self
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    func goToSignUpSucessfulScreen(email: String, password: String) {
        let signUpSucessfulVC = SignUpSuccessfulViewController.instantiateStoryBoard()
        signUpSucessfulVC.email = email
        signUpSucessfulVC.password = password
        signUpSucessfulVC.mainCoordinator = self
        self.navigationController?.pushViewController(signUpSucessfulVC, animated: true)
    }
    func goToHomeScreen() {
        let homeVC = HomeViewController.instantiateStoryBoard()
        homeVC.mainCoordinator = self
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    func goToMovieDetailScreen(movieId: Int) {
        let detailVC = MovieDetailViewController()
        detailVC.configure(movieId: movieId)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func goToSearchScreen() {
        let searchVC = SearchMovieViewController.instantiateStoryBoard()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}
