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
        configureAppearance()
    }
    
    
//MARK: - Methods
    
    func cofigure(with model: DetailItemModel) {
        guard let loadURL = URL(string: model.imageURL) else { return }
        DetailImage.loadImage(from: loadURL)
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        DetailImage.layer.cornerRadius = 12
        DetailImage.contentMode = .scaleAspectFill
    }
    
}
