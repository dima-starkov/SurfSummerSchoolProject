//
//  PostLoadErrorView.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 17.08.2022.
//

import UIKit

class PostLoadErrorView: UIView {
    
    //MARK: - Views

    let reloadButton = UIButton()
    let smileImage = UIImageView()
    let textLabel = UILabel()
    
    //MARK: - Events
    
    var tryUpdate: (()->Void)?
    
    //MARK: -Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }
    
    private func configureAppearance() {
        configureButton()
        configureLabel()
        configureImage()
    }
    
    //MARK: - Private Methods
    
    private func configureButton() {
        addSubview(reloadButton)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadButton.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 30),
            reloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            reloadButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        reloadButton.backgroundColor = .black
        reloadButton.setTitle("Обновить", for: .normal)
        reloadButton.setTitleColor(.white, for: .normal)
        
        reloadButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
    }
    
    @objc private func didTapUpdateButton() {
        tryUpdate?()
    }
    
    private func configureLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.bottomAnchor.constraint(equalTo: reloadButton.topAnchor,constant: -16)
        ])
        
        textLabel.text = "Не удалось загрузить ленту\nОбновите экран или попробуйте позже"
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
        textLabel.textColor = .lightGray
    }
    
    private func configureImage() {
        addSubview(smileImage)
        smileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            smileImage.widthAnchor.constraint(equalToConstant: 26),
            smileImage.heightAnchor.constraint(equalToConstant: 26),
            smileImage.bottomAnchor.constraint(equalTo: textLabel.topAnchor,constant: -16),
            smileImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        smileImage.image = UIImage(named: "SadSmile")
    }
    
}


