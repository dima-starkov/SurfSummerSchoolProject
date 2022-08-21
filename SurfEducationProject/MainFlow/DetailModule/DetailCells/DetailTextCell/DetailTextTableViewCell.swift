//
//  DetailTextTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 15.08.2022.
//

import UIKit

class DetailTextTableViewCell: UITableViewCell {

    //MARK: - Views
    
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: -Prorerties
    
    var paragraphStyle = NSMutableParagraphStyle()

    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        contentLabel.font = UIFont.regular12()
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.4 //расстояние между строками
    }
    
    func configure(with model: DetailItemModel) {
        contentLabel.attributedText = NSMutableAttributedString(string: model.content, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
}
