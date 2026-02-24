//
//  SignUpViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class SignUpViewController: UIViewController , CoordinatorBoard{
    weak var mainCoordinator: MainCoordinator?
    weak var signUpSuccessfulViewController: SignUpSuccessfulViewController?

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBAction func signInButtonTapped(_ sender: Any) {
        mainCoordinator?.signInButtonTappedFromSignUp()
    }
    @IBAction func signUpButtonTappedOnSignUpScreen(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, email.isValidEmail,
              let password = passwordTextField.text, !password.isEmpty, password.isValidPassword else {
            print ("Credentials not valid")
            return
        }
       
        mainCoordinator?.goToSignUpSucessfulScreen(email: email, password: password)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
    }
}
private func styleTextField(_ textField: UITextField) {
    textField.layer.cornerRadius = 20
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 0.8
    textField.layer.borderColor = UIColor(
        red: 42/255,
        green: 42/255,
        blue: 42/255,
        alpha: 1
    ).cgColor
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    textField.clipsToBounds = true
}

