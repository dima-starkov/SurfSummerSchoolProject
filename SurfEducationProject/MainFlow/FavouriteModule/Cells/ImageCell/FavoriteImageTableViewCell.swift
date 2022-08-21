//
//  FavoriteImageTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 15.08.2022.
//

import UIKit

class FavoriteImageTableViewCell: UITableViewCell {
    
    //MARK: -Properties
    
    var item: DetailItemModel?
    
    //MARK: -Events
    
    var didTapHeartButton: (()->Void)?
    
    //MARK: -Views
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        guard item != nil else {
            return
        }
        didTapHeartButton?()
        sender.flashAnimation()
    }
    
    func configure(with model: DetailItemModel) {
        item = model
        guard let url = URL(string: model.imageURL) else { return }
        cartImageView.loadImage(from: url)
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .standartWhite()
    }
    
}

