//
//  SignInViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class SignInViewController: UIViewController, CoordinatorBoard {
    weak var mainCoordinator : MainCoordinator?
    var defaults = UserDefaults.standard
    
    struct Keys {
        static let user = "user"
    }
    var iconClick = false
    let imageIcon = UIImageView()
    
    
    @IBOutlet weak var signInButtonTapped: CustomButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func signUpButtonTapped(_ sender: Any) {
        mainCoordinator?.signUpButtonTapped()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
        imageIcon.image = UIImage(named: "eye-solid")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        self.navigationItem.hidesBackButton = true
        signInButtonTapped.configureView(title: "Sign In")
        signInButtonTapped.onTap = {
            guard let email = self.emailTextField.text, !email.isEmpty,
                  let password = self.passwordTextField.text, !password.isEmpty else {
                      print("Credentials not valid.")
                return
            }
            
           let user = findUser(byEmail: email)
           if user == nil {
                print("User does not exist")
            }
            
            let securePassword = SecurityManager.getPassword(account: email)
            if self.passwordTextField.text == securePassword {
                print("Sign in successful")
                let loggedInUser = LoggedInUser(
                    email: user?.email ?? "",
                    name: user?.name ?? ""
                )
                UserSessionManager.shared.save(user: loggedInUser)
                self.mainCoordinator?.signInButtonTapped()
            }
            else {
                let alertController = UIAlertController(title: "Password Incorrect", message: "Enter correct password to proceed OR click forget password.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in

                }
                alertController.addAction(okAction)
//                present(alertController, animated: true, completion: nil)
                print("In correct Password")
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextField.frame = emailTextField.frame.integral
        passwordTextField.frame = passwordTextField.frame.integral
    }
    
}

func loginSuccess(user: User) {
    let sessionUser = LoggedInUser(
        email: user.email ?? "",
        name: user.name ?? ""
    )

   
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
