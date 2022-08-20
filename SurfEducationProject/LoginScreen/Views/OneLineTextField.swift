//
//  OneLineTextField.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class OneLineTextField: UITextField {
    
    let bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
    
    var bottomViewColor: UIColor = .lightGray {
        didSet {
            bottomView.backgroundColor = bottomViewColor
        }
    }
    
    convenience init(font: UIFont) {
        self.init()
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.returnKeyType = .next
        bottomView.backgroundColor = bottomViewColor
        self.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

}
