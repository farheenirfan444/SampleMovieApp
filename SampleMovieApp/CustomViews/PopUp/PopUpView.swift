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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    private func configureView() {
        let bundle = Bundle(for: PopUpView.self)
        guard let xibView = bundle.loadNibNamed("PopUpView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        self.contentView = xibView
    }

    func configure(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    @IBAction func okButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    func show(on viewController: UIViewController) {
        self.frame = viewController.view.bounds
        viewController.view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}


