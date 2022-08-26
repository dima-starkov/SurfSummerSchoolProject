//
//  DescriptionTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    //MARK: -Views

    @IBOutlet weak var infoTypeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    func configureAppearance() {
        infoTypeLabel.numberOfLines = 1
        infoTypeLabel.textAlignment = .left
        infoTypeLabel.textColor = .gray
        infoTypeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        infoLabel.numberOfLines = 1
        infoLabel.textAlignment = .left
        infoLabel.textColor = .black
        infoLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        selectionStyle = .none
    }
    
    func configure(infoType: String, info: String){
        infoTypeLabel.text = infoType
        infoLabel.text = info
    }
    
}
