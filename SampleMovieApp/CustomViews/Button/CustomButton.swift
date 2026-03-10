//
//  CustomButton.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 25/02/2026.
//

import UIKit

@IBDesignable

final class CustomButton: UIView {
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: Variables
    var onTap: (() -> Void)?
    
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    //MARK: MVVM
    var customViewModel: CustomButtonViewModel? {
        didSet {
           bindViewModel()
        }
    }
}

extension CustomButton {
    //MARK: Helper functions
    private func configureView() {
        loadNib()
        attachContentView()
        setUpInteraction()
    }
    
    private func loadNib() {
        let bundle = Bundle(for: CustomButton.self)
        let nibName = String(describing: CustomButton.self)
        bundle.loadNibNamed(nibName, owner: self, options: nil)
    }
    
    private func attachContentView() {
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func setUpInteraction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        onTap?()
    }
    private func bindViewModel() {
        titleLabel.text = customViewModel?.title
    }
    
}
