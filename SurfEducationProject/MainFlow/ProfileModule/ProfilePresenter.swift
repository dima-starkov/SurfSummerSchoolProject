//
//  ProfilePresenter.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 04.09.2022.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
   
    weak var view: ProfileViewProtocol?
    
    func getUserData() -> UserModel? {
        ProfileService.shared.userProfileModel
    }
    
    func logout() {
        LogOutService().logOut { [weak self] isSuccess in
            guard let strongSelf = self else { return }
            if isSuccess{
                DispatchQueue.main.async {
                    strongSelf.view?.presentLoginVC()
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.view?.presentWarning()
                }
            }
        }
    }
}
