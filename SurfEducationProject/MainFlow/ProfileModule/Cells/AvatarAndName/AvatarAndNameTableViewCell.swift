//
//  AvatarAndNameTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class AvatarAndNameTableViewCell: UITableViewCell {
    
    //MARK: - Views
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confugureAppearance()
    }
    
    func configure(with model: UserModel){
        if let url = URL(string: model.avatar) {
            avatarImage.loadImage(from: url)
        }
        nameLabel.text = "\(model.firstName)\n\(model.lastName)"
        descriptionLabel.text = "\(model.about)"
        
    }

    private func confugureAppearance() {
        selectionStyle = .none
        avatarImage.layer.cornerRadius = 12
        avatarImage.contentMode = .scaleAspectFill
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
    }
    
}
