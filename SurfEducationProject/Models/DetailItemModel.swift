//
//  MainCollectionViewCellModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import Foundation
import UIKit

final class DetailItemDataModel{
    
    //MARK: - Events

    var didItemsUpdate: (()->Void)?
    
    //MARK: - Properties
    
    var items: [DetailItemModel] = []
    
    //MARK: - Methods
    func getDefaultPosts() {
        items = Array(repeating: DetailItemModel.createDefault(), count: 20)
        didItemsUpdate?()
    }
    
}

struct DetailItemModel {
    let title: String
    let image: UIImage?
    let dateCreation: String
    let content: String
    let isFavorite: Bool
    
    static func createDefault()->DetailItemModel {
        .init(title: "Самый милый корги", image: UIImage(named: "korgi-default"), dateCreation: "14.08.2022", content: " Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. \n \n Теперь, кроме регулировки экстракции, настройки помола, времени заваривания и многого что помогает выделять нужные характеристики кофе, вы сможете выбрать и кружку для кофе в зависимости от сорта", isFavorite: false)
    }
}
