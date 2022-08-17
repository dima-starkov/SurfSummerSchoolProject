//
//  UIImageView + ImageLoader.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 17.08.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(from url: URL) {
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    
}
