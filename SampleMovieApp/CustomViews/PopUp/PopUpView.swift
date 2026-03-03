//
//  PopUpView.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 25/02/2026.
//

import Foundation
import UIKit

@IBDesignable

final class PopUpView: UIView {
    //MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var contentView : UIView!
    
    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    //MARK: Helpers
    var customViewModel: PopUpViewModel? {
        didSet {
            bindViewModel()
        }
    }
   
    @IBAction func okButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension PopUpView {
    
    private func configureView() {
        loadNib()
        attachContentView()
    }
    private func loadNib() {
        let bundle = Bundle(for: PopUpView.self)
        let nibName = String(describing: PopUpView.self)
        guard let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            return
        }
        contentView = view
    }
    private func attachContentView() {
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    func show(on viewController: UIViewController, viewModel: PopUpViewModel) {
        self.customViewModel = viewModel
        self.frame = viewController.view.bounds
        viewController.view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    private func bindViewModel(){
        titleLabel.text = customViewModel?.titleLabel
        messageLabel.text = customViewModel?.messageLabel
    }
}


