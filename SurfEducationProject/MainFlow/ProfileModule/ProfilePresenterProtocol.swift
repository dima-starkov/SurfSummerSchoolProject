//
//  ProfilePresenterProtocol.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 04.09.2022.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func logout()
    func getUserData() -> UserModel?
}
