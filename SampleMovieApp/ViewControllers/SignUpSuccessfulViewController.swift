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
    
    let popup = PopUpView()
    
    var email: String?
    var password: String?
    
    @IBOutlet weak var continueButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTextField(nameTextField)
        styleTextField(phoneNumberTextField)
        styleTextField(cityTextField)
        self.navigationItem.hidesBackButton = true
        continueButton.configureView(title: "Continue")
        continueButton.onTap = {
            guard let name = self.nameTextField.text, !name.isEmpty,
                  let phone = self.phoneNumberTextField.text, !phone.isEmpty,
                  let city = self.cityTextField.text, !city.isEmpty
            else {
                self.popup.titleLabel.text = "Input fields empty"
                self.popup.messageLabel.text = "Please fill in all the fields"
                self.popup.show(on: self)
               return
            }
            SecurityManager.savePassword(password: self.password!, account: self.email!)
            createUser(email: self.email!, password: "", name: name, phone: phone, city: city)
            self.mainCoordinator?.signInButtonTapped()
           fetchUser()
        }
        
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



