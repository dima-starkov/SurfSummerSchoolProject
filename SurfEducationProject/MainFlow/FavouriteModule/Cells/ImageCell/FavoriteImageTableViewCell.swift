//
//  FavoriteImageTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 15.08.2022.
//

import UIKit

class FavoriteImageTableViewCell: UITableViewCell {
    
    //MARK: -Views
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да, точно", style: .default, handler: nil)
        let noAction = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(yesAction)
        alert.addAction(noAction)
    }
    
    func configure(with model: DetailItemModel) {
//        cartImageView.image = model.image
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
    
}

