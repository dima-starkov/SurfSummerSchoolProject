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
    
}
