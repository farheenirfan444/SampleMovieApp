//
//  PopUpViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 28/02/2026.
//

import Foundation
import UIKit

class PopUpViewModel{
    
    private(set) var titleLabel: String
    private(set) var messageLabel: String
    
    init(titleLabel: String, messageLabel: String) {
        self.titleLabel = titleLabel
        self.messageLabel = messageLabel
    }
}
