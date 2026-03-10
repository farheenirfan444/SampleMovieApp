//
//  ImageLoader.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 28/02/2026.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String?){
    guard let urlString = urlString,
        let url = URL(string: urlString) else {
        return
    }
        
    URLSession.shared.dataTask(with: url) { data, _, _ in
    guard let imageData = data else { return }
    DispatchQueue.main.async {
        if let image = UIImage(data: imageData) {
            self.image = image
        }
    }
  }.resume()
 }
}
