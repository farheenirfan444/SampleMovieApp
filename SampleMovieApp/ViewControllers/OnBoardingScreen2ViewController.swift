//
//  OnBoardingScreen2ViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class OnBoardingScreen2ViewController: UIViewController, CoordinatorBoard {
    weak var mainCoordinator: MainCoordinator?
    @IBOutlet var genreButtons: [UIButton]!
    var selectedGenres: [String] = []

    @IBOutlet weak var nextButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in genreButtons {
            let title = button.configuration?.title
            var config = UIButton.Configuration.filled()
            config.cornerStyle = .medium
            config.background.cornerRadius = 10
            config.title = title
            config.titleAlignment = .center
            config.titleLineBreakMode = .byTruncatingTail
            config.baseBackgroundColor = UIColor(
                    red: 30/255,
                    green: 30/255,
                    blue: 30/255,
                    alpha: 1
                )
            config.baseForegroundColor = .white
            config.contentInsets = NSDirectionalEdgeInsets(
                        top: 8, leading: 8, bottom: 8, trailing: 8
                    )
            config.titleTextAttributesTransformer =
                    UIConfigurationTextAttributesTransformer { attributes in
                        var updated = attributes
                        updated.font = UIFont(name: "Poppins-Medium", size: 14)
                        return updated
                    }
           
            
            button.configuration = config
            button.configurationUpdateHandler = { button in
                var updatedConfig = button.configuration
                
                if button.isSelected {
                    updatedConfig?.baseBackgroundColor = .systemRed
                } else {
                    updatedConfig?.baseBackgroundColor = UIColor(
                        red: 30/255,
                        green: 30/255,
                        blue: 30/255,
                        alpha: 1
                    )
                }
                UIView.animate(withDuration: 0.15) {
                        var config = button.configuration
                        config?.baseBackgroundColor = button.isSelected ? .systemRed : .darkGray
                        button.configuration = config
                    }
                
                button.configuration = updatedConfig
            }
        }
        self.navigationItem.hidesBackButton = true
        nextButton.onTap = {
            if(self.selectedGenres.count > 0){
                UserDefaults.standard.set(self.selectedGenres, forKey: "UserFavoriteGenres")
                print(self.selectedGenres)
                self.mainCoordinator?.onBoardingScreen2NextButtonTapped()
            }
            else {
               let popup = PopUpView()
                popup.titleLabel.text = "Error"
                popup.messageLabel.text = "Please select at least one genre"
                popup.show(on: self)
            }
        }
    }
    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
            guard let genreName = sender.titleLabel?.text else { return }
        sender.isSelected.toggle()
            if selectedGenres.contains(genreName) {
                selectedGenres.removeAll { $0 == genreName }
               
            } else {
                selectedGenres.append(genreName)
               
            }
        }
}
