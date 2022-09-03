//
//  LoginPresenter.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 03.09.2022.
//

import Foundation

class LoginViewPresenter: LoginPresenterProtocol {
   
    weak var view: LoginViewProtocol?
    
    func loginUser(phone: String?,password: String?){
        guard let login = phone, let password = password, let srtongView = view else { return }
        let tempCredentials = AuthRequestModel(phone: login, password: password)
        AuthService().performLoginRequestAndSaveToken(credentials: tempCredentials) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    ProfileService.shared.getUserDataModel(from: result)
                    srtongView.loginIsSuccesed()
                }
            case .failure:
                DispatchQueue.main.async {
                    srtongView.presentWarningView()
                }
            }
        }
    }
}
