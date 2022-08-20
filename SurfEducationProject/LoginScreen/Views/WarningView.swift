//
//  WarningView.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class WarningView: UIView {
    
    let label = UILabel()

    convenience init(text: String) {
        self.init()
        backgroundColor = .red
        addSubview(label)
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
