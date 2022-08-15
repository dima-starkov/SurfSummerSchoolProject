//
//  DetailImageTableViewCell.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 15.08.2022.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    //MARK: - Views
    @IBOutlet private weak var DetailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        DetailImage.layer.cornerRadius = 12
        DetailImage.contentMode = .scaleAspectFill
    }
    
    func cofigure(with model: DetailItemModel) {
        DetailImage.image = model.image
    }
    
}
