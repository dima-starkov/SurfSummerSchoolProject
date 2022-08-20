//
//  AuthResponseModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct AuthResponseModel: Decodable {
    let token: String
    let user_info: [String:String]
}
