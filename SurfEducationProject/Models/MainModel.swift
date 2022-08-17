//
//  MainModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 17.08.2022.
//

import Foundation

final class DetailItemDataModel{
    
    //MARK: - Events

    var didItemsUpdate: (()->Void)?
    var didItemsUpdateWithError: ((Error)->Void)?
    
    //MARK: - Properties
    let pictureService = PictureService()
    var items: [DetailItemModel] = []
    
    //MARK: - Methods
    func getDefaultPosts() {
        items = Array(repeating: DetailItemModel.createDefault(), count: 20)
        didItemsUpdate?()
    }
    
    func loadPosts() {
            pictureService.loadPictures { [weak self] result in
                switch result {
                case .success(let data):
                    self?.items = data.map { item in
                        DetailItemModel(imageURL: item.photoUrl, title: item.title, isFavorite: false, content: item.content, dateCreation: item.date)
                    }
                    self?.didItemsUpdate?()
                    
                case .failure(let error):
                    self?.didItemsUpdateWithError?(error)
                }
            }
        }
}
