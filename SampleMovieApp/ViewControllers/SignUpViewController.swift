//
//  SignUpViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class SignUpViewController: UIViewController , CoordinatorBoard{
    //MARK: IBOutlet
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBAction func signInButtonTapped(_ sender: Any) {
        mainCoordinator?.goToSignInScreen()
    }
    @IBOutlet weak var signUpButtonTapped: CustomButton!
    
    //MARK: Variables
    weak var mainCoordinator: MainCoordinator?
    var viewModel = SignUpViewModel()
    private var isPasswordVisible = false
    let buttonViewModel = CustomButtonViewModel(title: "Sign Up")
    let popUp = PopUpView()
    
    //MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setUpUI()
        setUpSignUpButton()
    }
    
    //MARK: Helper functions
    private func setUpUI() {
        setUpPasswordToggle()
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
    }
    
    private func setUpSignUpButton() {
        signUpButtonTapped.customViewModel = buttonViewModel
        signUpButtonTapped.onTap = { [weak self] in
            guard let self = self else { return }
            let result = self.viewModel.signUp(email: self.emailTextField.text, password: self.passwordTextField.text)
            if (result.success) {
                self.mainCoordinator?.goToSignUpSucessfulScreen(email: self.emailTextField.text!, password: self.passwordTextField.text!)
            }
            else {
                let popUpViewModel = PopUpViewModel(titleLabel: "Sign Up Failed", messageLabel: result.message)
                self.popUp.show(on: self, viewModel: popUpViewModel)
            }
        }
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


