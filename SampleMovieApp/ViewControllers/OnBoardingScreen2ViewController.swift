//
//  OnBoardingScreen2ViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class OnBoardingScreen2ViewController: UIViewController, CoordinatorBoard {
    //MARK: IBOutlets
    
    @IBOutlet var genreButtons: [UIButton]!
    @IBOutlet weak var nextButton: CustomButton!
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        guard let genreName = sender.titleLabel?.text else { return }
        viewModel.addGenre(genre: genreName)
    }
    
    //MARK: Variables
    
    weak var mainCoordinator: MainCoordinator?
    var selectedGenres: [String] = []
    var viewModel = OnBoarding2ScreenViewModel()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setUpGenreButton()
        viewModel.onSelectionChanged = { [weak self] in
            self?.updateButtonSelectionStates()
        }
        nextButton.onTap = { [weak self] in
            guard let self = self else { return }
            setUpNextButton()
        }
        
    }
    private func updateButtonSelectionStates() {
        for button in genreButtons {
            guard let genreName = button.configuration?.title else { continue }
            let isSelected = viewModel.isGenreSelected(genre: genreName)
            button.isSelected = isSelected
            button.setNeedsUpdateConfiguration()
        }
    }
    private func setUpGenreButton() {
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
    }
    private func setUpNextButton() {
        if(self.viewModel.selectedGenresCount() > 0){
            self.viewModel.saveGenres()
            self.mainCoordinator?.onBoardingScreen2NextButtonTapped()
        }
        else {
            print("Select at least one genre.")
        }
    }
}
