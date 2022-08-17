//
//  MainCollectionViewCellModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import Foundation
import UIKit



struct DetailItemModel {
    let title: String
    let imageURL: String
    let dateCreation: String
    let content: String
    let isFavorite: Bool
    
    internal init(imageURL: String, title: String, isFavorite: Bool, content: String, dateCreation: Date) {
            self.imageURL = imageURL
            self.title = title
            self.isFavorite = isFavorite
            self.content = content
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.mm.yyyy"
            
            self.dateCreation = formatter.string(from: dateCreation)
        }
    
    static func createDefault()->DetailItemModel {
        .init(imageURL: "", title: "Cfvs", isFavorite: false, content: "", dateCreation: Date())
    }
}
