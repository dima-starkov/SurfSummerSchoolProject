//
//  FavoriteDetailTextTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import UIKit

class FavoriteDetailTextTableViewCell: UITableViewCell {

//MARK: - Views
    @IBOutlet private weak var contentText: UILabel!
    
//MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

//MARK: - Methods
    
  func configure(with model: DetailItemModel) {
      contentText.text = model.content
      contentText.font = .regular12()
    }
    
    
}
