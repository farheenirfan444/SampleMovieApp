//
//  CustomButton.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 25/02/2026.
//

import UIKit

@IBDesignable

final class CustomButton: UIView {
    
    var onTap: (() -> Void)?
    
    @IBOutlet weak var contentView: UIView!
    
   
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    private func configureView() {
        let bundle = Bundle(for: CustomButton.self)
        bundle.loadNibNamed("CustomButton", owner: self, options: nil)
       
        contentView.frame = self.bounds
        self.addSubview(contentView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = true
    }
    
    func configureView(title:String){
        titleLabel.text = title
    }
    @objc private func handleTap() {
        onTap?()
    }
}
