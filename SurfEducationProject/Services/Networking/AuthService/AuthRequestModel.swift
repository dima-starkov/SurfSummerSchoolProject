//
//  AuthRequestModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct AuthRequestModel: Encodable {
    let phone: String
    let password: String
}
