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
    
    func goToOnBoardingScreen1() {
        let onBoardingVC = OnBoardingScreen1ViewController.instantiateStoryBoard()
        onBoardingVC.mainCoordinator = self
        self.navigationController?.pushViewController(onBoardingVC, animated: true)
    }
    
    func goToOnBoardingScreen2() {
        let onBoardingScreen2VC = OnBoardingScreen2ViewController.instantiateStoryBoard()
        onBoardingScreen2VC.mainCoordinator = self
        self.navigationController?.pushViewController(onBoardingScreen2VC, animated: true)
        
    }
    
    func goToSignInScreen() {
        let signInVC = SignInViewController.instantiateStoryBoard()
        signInVC.mainCoordinator = self 
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func skipButtonTapped(){
        let homeVC = HomeViewController.instantiateStoryBoard()
        homeVC.mainCoordinator = self
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func goToSignUpScreen() {
        let signUpVC = SignUpViewController.instantiateStoryBoard()
        signUpVC.mainCoordinator = self
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func goToSignUpSucessfulScreen(email: String, password: String) {
        let signUpSucessfulVC = SignUpSuccessfulViewController.instantiateStoryBoard()
        signUpSucessfulVC.viewModel = SignUpSuccessfulViewModel(email: email, password: password)
        signUpSucessfulVC.mainCoordinator = self
        self.navigationController?.pushViewController(signUpSucessfulVC, animated: true)
    }
    
    func goToHomeScreen() {
        let homeVC = HomeViewController.instantiateStoryBoard()
        homeVC.mainCoordinator = self
        homeVC.viewModel = MovieViewModel()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func goToSearchScreen() {
        let searchVC = SearchMovieViewController.instantiateStoryBoard()
        searchVC.mainCoordinator = self
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func goToMovieDetailScreen(movie: Movie) {
        let vc = MovieDetailViewController.instantiateStoryBoard()
        vc.viewModel = MovieDetailViewModel(movieId: movie.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
