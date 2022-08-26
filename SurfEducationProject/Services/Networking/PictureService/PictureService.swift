//
//  PictureService.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct PictureService {
    let dataTask = BaseNetworkTask<EmptyModel,[PictureResponseModel]>(
        isNeedInjectToken: true,
        method: .get,
        path: "picture/")
    
    func loadPictures(onResponceWasRecived: @escaping (Result<[PictureResponseModel], Error>) -> Void) {
        dataTask.performRequest(onResponceWasRecived: onResponceWasRecived)
    }
}
