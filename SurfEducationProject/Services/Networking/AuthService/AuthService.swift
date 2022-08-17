//
//  AuthService.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct AuthService {
    let dataTask = BaseNetworkTask<AuthRequestModel,AuthResponseModel>( isNeedInjectToken: false, method: .post, path: "/auth/login")
    
    func performLoginRequest (credentials: AuthRequestModel,
                              onResponceWasRecived: @escaping (Result<AuthResponseModel, Error>) -> Void) {
        dataTask.performRequest(input: credentials, onResponceWasRecived: onResponceWasRecived)
    }
}
