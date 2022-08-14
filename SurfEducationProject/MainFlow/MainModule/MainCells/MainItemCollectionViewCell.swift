//
//  MainItemCollectionViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 14.08.2022.
//

import UIKit

class MainItemCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var isFavorite: Bool = false

    //MARK: - Views
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isFavorite = false
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavorite = true
        }
    }
    
    //MARK: -UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
        
    }
    
    func confugure(with model: ItemModel) {
        titleLabel.text = model.title
        if model.image != nil {
            imageView.image = model.image
        }
        if model.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavorite = true
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isFavorite = false
        }
    }
}

//MARK: - Private Methods

private extension MainItemCollectionViewCell {
    func configureAppearance() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 12)
        
        favoriteButton.tintColor = .white
        
        imageView.layer.cornerRadius = 12
    }
}


