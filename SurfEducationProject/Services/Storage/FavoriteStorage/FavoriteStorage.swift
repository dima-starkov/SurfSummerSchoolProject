//
//  FavoriteStorage.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 18.08.2022.
//

import Foundation

class FavoriteStorage {
    
//MARK: - Events
    
    var itemsRemoved: ((DetailItemModel)->Void)?
    
//MARK: - Properties
    
    static let shared = FavoriteStorage()
    var favoritesItems = [DetailItemModel]()
    var userDefaults = UserDefaults.standard
    
//MARK: -Methods
    
    func appendItem(item: DetailItemModel) {
        favoritesItems.append(item)
        saveItemToUserDefaults(item: item)
    }
    
    func removeItem(item: DetailItemModel) {
        if let index = favoritesItems.firstIndex(where: {$0.title == item.title}) {
            favoritesItems.remove(at: index)
            removeItemFromUserDefaults(item: item)
            itemsRemoved?(item)
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    func removeAllItems() {
        for favoritesItem in favoritesItems {
            removeItemFromUserDefaults(item: favoritesItem)
        }
        favoritesItems.removeAll()
    }
    
//MARK: - Private Methods
    
    private func saveItemToUserDefaults(item: DetailItemModel) {
         userDefaults.set(item.dateCreation, forKey: item.id)
     }
    private func removeItemFromUserDefaults(item: DetailItemModel) {
         userDefaults.set(nil, forKey: item.id)
     }
}
