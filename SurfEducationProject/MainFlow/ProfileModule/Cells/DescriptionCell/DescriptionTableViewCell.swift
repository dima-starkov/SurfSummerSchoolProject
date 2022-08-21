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
        infoTypeLabel.textColor = .grayLight()
        infoTypeLabel.font = .regular12()
        
        infoLabel.numberOfLines = 1
        infoLabel.textAlignment = .left
        infoLabel.textColor = .standartBlack()
        infoLabel.font = .regular18()
        
        selectionStyle = .none
    }
    
    func configure(infoType: String, info: String){
        infoTypeLabel.text = infoType
        infoLabel.text = info
    }
    
}
