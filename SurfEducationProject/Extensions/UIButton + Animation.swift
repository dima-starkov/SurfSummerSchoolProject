//
//  UIButton + Animation.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 14.08.2022.
//

import UIKit

extension UIButton {
    
    func flashAnimation() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.3
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 2
    layer.add(flash, forKey: nil)
    }
    
    func loadAnimation() {
        let image = UIImage(named: "loadingImage")
        self.setImage(image, for: .normal)
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.imageView?.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopLoadAnimation() {
        self.imageView?.layer.removeAnimation(forKey: "rotationAnimation")
        self.setImage(nil, for: .normal)
    }
    
}
