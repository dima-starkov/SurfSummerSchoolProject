//
//  ProfileResponseModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let phone: String
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    let city: String
    let about: String
}

