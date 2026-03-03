//
//  SignUpSuccessfulViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 20/02/2026.
//

import UIKit

class SignUpSuccessfulViewController: UIViewController, CoordinatorBoard {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var continueButton: CustomButton!
    
    //MARK: Variables
    
    weak var mainCoordinator: MainCoordinator?
    var viewModel : SignUpSuccessfulViewModel!
    let popUpView = PopUpView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setUpUI()
        
    }
    //MARK: Helper Function
    
    private func setUpUI(){
        styleTextField(nameTextField)
        styleTextField(phoneNumberTextField)
        styleTextField(cityTextField)
        setupContinueButton()
    }
    
    private func setupContinueButton() {
        let buttonViewModel = CustomButtonViewModel(title: "Continue")
        continueButton.customViewModel = buttonViewModel
        continueButton.onTap = { [weak self] in
            guard let self = self else { return }
            
            let result = self.viewModel.submit(name: nameTextField.text!, phone: phoneNumberTextField.text!, city: cityTextField.text!)
            if (result.success) {
                self.mainCoordinator?.goToHomeScreen()
            }
            else {
                let popUpViewModel = PopUpViewModel(titleLabel: "Sign Up Failed", messageLabel: result.message)
                popUpView.show(on: self, viewModel: popUpViewModel)
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
    }
}
