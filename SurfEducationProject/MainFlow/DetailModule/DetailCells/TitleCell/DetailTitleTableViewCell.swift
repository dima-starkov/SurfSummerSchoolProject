//
//  DetailTitleTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 15.08.2022.
//

import UIKit

class DetailTitleTableViewCell: UITableViewCell {
    
    //MARK: - Views
    
    @IBOutlet private weak var cartTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    func configure(with model: DetailItemModel) {
        cartTitleLabel.text = model.title
        dateLabel.text = model.dateCreation
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        
        cartTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .lightGray
    }
    
}
