//
//  AuthService.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct AuthService {
    let dataTask = BaseNetworkTask<AuthRequestModel,AuthResponseModel>( isNeedInjectToken: false,
                                                                        method: .post,
                                                                        path: "/auth/login")
    
    func performLoginRequestAndSaveToken(credentials: AuthRequestModel,
                              onResponceWasRecived: @escaping (Result<AuthResponseModel, Error>) -> Void) {
        dataTask.performRequest(input: credentials) { result in
            if case let .success(responceModel) = result {
                try? dataTask.tokenStorage.set(newToken: TokenContainer(token: responceModel.token, receivingDate: .now))
            }
            onResponceWasRecived(result)
        }
    }
}
