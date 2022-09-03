//
//  LoginPresenterProtocol.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 03.09.2022.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject{
    func loginUser(phone: String?,password: String?)
}
