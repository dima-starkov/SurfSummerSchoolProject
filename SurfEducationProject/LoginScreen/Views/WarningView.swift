//
//  WarningView.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class WarningView: UIView {

//MARK: - Properties
    
    let label = UILabel()
    
//MARK: -Init

    convenience init(text: String) {
        self.init()
        backgroundColor = .warningRed()
        addSubview(label)
        label.text = text
        label.textColor = .white
        label.font = .regular14()
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
