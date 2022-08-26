//
//  TokenStorage.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

protocol TokenStorage {
    func getToken() throws -> TokenContainer
    func set(newToken: TokenContainer) throws
}
