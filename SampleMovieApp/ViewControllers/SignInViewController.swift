//
//  SignInViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class SignInViewController: UIViewController, CoordinatorBoard {
    
    //MARK: IBOutlets
    @IBOutlet weak var signInButtonTapped: CustomButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func signUpButtonTapped(_ sender: Any) {
        mainCoordinator?.goToSignUpScreen()
    }
    
    //MARK: Variables
    weak var mainCoordinator : MainCoordinator?
    let imageIcon = UIImageView()
    var isPasswordVisible = false
    var viewModel = SignInViewModel()
    let popUp = PopUpView()
    
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setUpUI()
        setUPSignInButton()
    }
    private func setUpUI(){
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
        setUpPasswordToggle()
    }
    
    private func setUPSignInButton(){
        let buttonViewModel = CustomButtonViewModel(title: "Sign In")
        signInButtonTapped.customViewModel = buttonViewModel
        signInButtonTapped.onTap = { [weak self] in
            guard let self = self else { return }
            let result = self.viewModel.signIn(email: self.emailTextField.text, password: self.passwordTextField.text)
            if(result.success) {
                self.mainCoordinator?.goToHomeScreen()
            }
            else {
                let popViewModel = PopUpViewModel(titleLabel: "Sign In Failed", messageLabel: result.message)
                self.popUp.show(on: self, viewModel: popViewModel)
            }
        }
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextField.frame = emailTextField.frame.integral
        passwordTextField.frame = passwordTextField.frame.integral
    }
    private func setUpPasswordToggle() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 24)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        let container = UIView(frame: CGRect(x: -4, y: 0, width: 44, height: 24))
        button.center = container.center
        container.addSubview(button)
        passwordTextField.rightView = container
        passwordTextField.rightViewMode = .always
        
    }
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
        let text = passwordTextField.text
        passwordTextField.text = nil
        passwordTextField.text = text
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
}
