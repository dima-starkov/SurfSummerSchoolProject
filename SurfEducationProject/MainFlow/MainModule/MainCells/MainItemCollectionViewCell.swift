//
//  MainItemCollectionViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 14.08.2022.
//

import UIKit

class MainItemCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var item: DetailItemModel?
    var favoriteStorage = FavoriteStorage.shared

    //MARK: - Views
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    //MARK: - Events
    
    
    //MARK: - Actions
    
    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        guard let item = item else { return }
        if favoriteStorage.isKeyPresentInUserDefaults(key: item.id) {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.flashAnimation()
            favoriteStorage.removeItem(item: item)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.flashAnimation()
            favoriteStorage.appendItem(item: item)
        }
    }
    
    //MARK: -UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
        
    }
    
    func confugure(with model: DetailItemModel) {
        item = model
        titleLabel.text = model.title
        guard let loadURL = URL(string: model.imageURL) else { return }
        imageView.loadImage(from: loadURL)
        if favoriteStorage.isKeyPresentInUserDefaults(key: model.id) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

//MARK: - Private Methods

private extension MainItemCollectionViewCell {
    func configureAppearance() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16,weight: .medium)
        
        favoriteButton.tintColor = .white
        
        imageView.layer.cornerRadius = 12
    }
}

