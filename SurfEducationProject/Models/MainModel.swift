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
    let favoriteStorage = FavoriteStorage.shared
    
    //MARK: - Methods
    func getDefaultPosts() {
        items = Array(repeating: DetailItemModel.createDefault(), count: 20)
        didItemsUpdate?()
    }
    
    func loadPosts(isCompletion: @escaping ((Bool)-> Void)) {
            pictureService.loadPictures { [weak self] result in
                switch result {
                case .success(let data):
                    self?.items = data.map { item in
                        DetailItemModel(imageURL: item.photoUrl, title: item.title, isFavorite: false, content: item.content, dateCreation: item.date,id: item.id)
                    }
                    self?.toFillFavoriteItems()
                    self?.didItemsUpdate?()
                    isCompletion(true)
                    
                case .failure(let error):
                    self?.didItemsUpdateWithError?(error)
                    isCompletion(false)
                }
            }
        }
    
    private func toFillFavoriteItems() {
        for item in items {
            if favoriteStorage.isKeyPresentInUserDefaults(key: item.id) {
                favoriteStorage.favoritesItems.append(item)
            }
        }
    }
}
