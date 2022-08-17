//
//  HTTPNetworkMethod.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

enum NetworkMethod: String {
    case get
    case post
}

extension NetworkMethod {
    var method: String {
        rawValue.uppercased()
    }
}
