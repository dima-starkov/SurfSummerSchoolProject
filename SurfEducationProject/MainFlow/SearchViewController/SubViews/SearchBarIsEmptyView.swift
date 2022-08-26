//
//  SearchBarIsEmptyView.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class SearchBarIsEmptyView: UIView {
    
    //MARK: - Views
    
    let image = UIImageView()
    let label = UILabel()
    
    //MARK: -Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Private Methods
    
    private func configureAppearance() {
        configureLabel()
        configureImage()
    }
    
    private func configureLabel() {
        addSubview(label)
     
        label.text = "Введите ваш запрос"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: -16)
        ])
        
    }
    
    private func configureImage() {
        addSubview(image)
        image.image = UIImage(named: "mag-glass")
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -16),
            image.heightAnchor.constraint(equalToConstant: 26),
            image.widthAnchor.constraint(equalToConstant: 26)
        ])
    }

}

