//
//  LogOutService.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import Foundation
struct LogOutService {
    let dataTask = BaseNetworkTask<EmptyModel,EmptyModel>( isNeedInjectToken: false,  
                                                           method: .post,
                                                           path: "/auth/logout")
    func logOut(completion: @escaping (Bool)-> Void) {
        dataTask.performRequest { result in
            switch result {
            case .success(_):
                do {
                    try dataTask.tokenStorage.removeTokenFromContainer()
                    URLCache.shared.removeAllCachedResponses()
                    ProfileService.shared.removeUserData()
                    FavoriteStorage.shared.removeAllItems()
                    completion(true)
                } catch {
                    print(error)
                    completion(false)
                }
            case .failure(_):
                completion(false)
            }
        }
    }
}
