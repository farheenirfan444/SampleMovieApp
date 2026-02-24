//
//  SignUpSuccessfulViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 20/02/2026.
//

import UIKit

class SignUpSuccessfulViewController: UIViewController, CoordinatorBoard {
    
    weak var mainCoordinator: MainCoordinator?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    var email: String?
    var password: String?
    
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let phone = phoneNumberTextField.text, !phone.isEmpty,
              let city = cityTextField.text, !city.isEmpty
        else {
            print("Enter data to sign up")
           return
        }
        SecurityManager.savePassword(password: password!, account: email!)
        createUser(email: email!, password: "", name: name, phone: phone, city: city)
        mainCoordinator?.signInButtonTapped()
       fetchUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTextField(nameTextField)
        styleTextField(phoneNumberTextField)
        styleTextField(cityTextField)
        self.navigationItem.hidesBackButton = true
        
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



